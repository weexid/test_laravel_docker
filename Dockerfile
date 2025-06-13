FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    git \
    libzip-dev \
    zip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libssl-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install pdo_mysql zip gd

# Install redis extension if not already installed
RUN if ! php -m | grep -q redis; then \
    pecl install redis && \
    docker-php-ext-enable redis; \
    fi

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
