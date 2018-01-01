cat <<EOF | oc create -n openshift-metrics -f - 
apiVersion: v1
kind: Service
metadata:
  labels:
    name: alertmanager
  name: alertmanager
  namespace: openshift-metrics
spec:
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 9093
  selector:
    app: prometheus
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
EOF
  
  
oc expose service alertmanager
route="`oc get routes -n openshift-metrics alertmanager | grep alertmanager | awk  '{print $2}'`"
echo "Try accessing $route"
