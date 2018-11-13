ARG NODE_VERSION=11.1-alpine
ARG NGINX_VERSION=stable-alpine

FROM node:${NODE_VERSION} as build

WORKDIR /app

# npm caching optimization
COPY package.json /app/
RUN npm install

COPY . /app
RUN $(npm bin)/ng build

FROM nginx:${NGINX_VERSION}
COPY --from=build /app/dist /usr/share/nginx/html
