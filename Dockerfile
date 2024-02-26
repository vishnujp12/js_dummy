# Use official Node.js image as base image
FROM node:latest as build

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files from the current directory to the container
COPY . .

# Build the React app
RUN npm run build

# Use a lighter weight image for production
FROM nginx:alpine

# Copy the build files from the previous stage to the NGINX server's directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Command to run NGINX server
CMD ["nginx", "-g", "daemon off;"]

