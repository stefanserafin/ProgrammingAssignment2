## The function cache Solve created an inverse matrix, where makeCacheMatrix
## stores the matrix and it's inverse matrix.

## function needs a matrix to be provided, otherwise an empty one would be
## created. function returns a list of functions which provide read and write
## access to the matrix and its reverse matrix.
makeCacheMatrix <- function(x = matrix()) {
  i_m <- NULL
  set <- function(y) {
    x <<- y
    i_m <<- NULL
  }
  get <- function() x
  setInverseMatrix <- function(inverse_matrix) i_m <<- inverse_matrix
  getInverseMatrix <- function() i_m
  list(set = set, get = get,
       setInverseMatrix = setInverseMatrix,
       getInverseMatrix = getInverseMatrix)
}


## The function is used to cache the inverse matrix. The matrix cache
## generated by function makeCacheMatrix needs to be passed in as an argument.
## if the inverse already exists, the inverse matrix will be returned. If the
## inverse matrix does not exist, a new one will be created.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  i_m <- x$getInverseMatrix()
  if(!is.null(i_m)) {
    message("getting cached data")
    return(i_m)
  }
  else
  {
    message("creating new inverse matrix")
  }
  data <- x$get()
  i_m <- solve(data, ...)
  message("inverse matrix created successfully.")
  x$setInverseMatrix(i_m)
  i_m
}

## Simple test function to confirm that caching and generation of inverse 
## matrix works as expected
test_function <- function(m)
{
  message("Matrix to be tested:")
  print(m)
  
  # create cache and inverse matrix for the first time
  cache_matrix <- makeCacheMatrix(test_matrix_3)
  inverse_matrix <- cacheSolve(cache_matrix)
  print(inverse_matrix)
  
  # Try to create inverse matrix again. Data should be cached now!
  message("Lets invert again. Is the invert matrix cached now?")
  inverse_matrix <- cacheSolve(cache_matrix)
  print(inverse_matrix)
  
  # Result of the invert should be same matrix that was initially passed in
  message("Lets invert our invert matrix")
  cache_matrix <- makeCacheMatrix(inverse_matrix)
  inverse_matrix <- cacheSolve(cache_matrix)
  print(inverse_matrix)
}

test_matrix_1 <- rbind(c(1,2), c(2,1)) 
test_function(test_matrix_1)

test_matrix_2 <- matrix(c(1,2,3,1,2,1,3,2,1), nrow = 3, byrow = TRUE)
test_function(test_matrix_2)
