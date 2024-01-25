#!/bin/bash

boundary authenticate password -auth-method-id ampw_0gZcQHhkPo -login-name $BOUNDARY_USER --password=env://BOUNDARY_PASSWORD
GLOBAL_SCOPE=`boundary scopes list -format=json | jq -r '.items[] | .id'`
echo "dumping targets"
boundary targets list -scope-id=$GLOBAL_SCOPE -recursive -format=json | jq -rc '.items[]| "boundary connect ssh -target-id "+.id+" #"+.name'