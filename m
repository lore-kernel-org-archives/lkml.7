Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE331C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543A8216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lv2twt8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfEIR0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35414 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfEIR0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:26:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJW1Z169554;
        Thu, 9 May 2019 17:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=hqA9nnmc3aaCaD1vJvMN9O3t2wFzBAC7GiJ5+V+WkDU=;
 b=lv2twt8jJxAoz/nULIzS29XNDCyzpIOgM6kAG0ACZt2NVyaUoxIP+g1iGzjRg4ZMsP8j
 EeYnhFj/ZptM5Xttxh4IqzSAIw+m17bDU36ZmK3aXzivmTJ0r5Snet4MogQyPJ8dRk3M
 TCACBPS34rkWcIGd+FB2bZBUOF3e5YViGROv8TqVwVMgs1ugZVAHVkoUvZ8BVTlEePSK
 X7PiWFRvgI2CCmxSXveEV0FKa5MC0rr7pySNE3nPpVxDlJiqbRHVxZt09V6QJyoAIuPS
 WCOIrB0BE3AxEx7fwGo3VSUulFaKhs4tjMIYSApJiG9pY0a2B8/3xXZ0QpshU6UVbRNy 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2s94b14e3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HP7rC152344;
        Thu, 9 May 2019 17:25:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2schvyy7ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:45 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49HPi4U011189;
        Thu, 9 May 2019 17:25:44 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:44 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 12/16] xen/xenbus: support xenbus frontend/backend with xenhost_t
Date:   Thu,  9 May 2019 10:25:36 -0700
Message-Id: <20190509172540.12398-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509172540.12398-1-ankur.a.arora@oracle.com>
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of xenbus init, both frontend, backend interfaces need to talk
on the correct xenbus. This might be a local xenstore (backend) or might
be a XS_PV/XS_HVM interface (frontend) which needs to talk over xenbus
with the remote xenstored. We bootstrap all of these with evtchn/gfn
parameters from (*setup_xs)().

Given this we can do appropriate device discovery (in case of frontend)
and device connectivity for the backend.
Once done, we stash the xenhost_t * in xen_bus_type, xenbus_device or
xenbus_watch and then the frontend and backend devices implicitly use
the correct interface.

The rest of patch is just changing the interfaces where needed.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/block/xen-blkback/blkback.c        |  10 +-
 drivers/net/xen-netfront.c                 |  14 +-
 drivers/pci/xen-pcifront.c                 |   4 +-
 drivers/xen/cpu_hotplug.c                  |   4 +-
 drivers/xen/manage.c                       |  28 +--
 drivers/xen/xen-balloon.c                  |   8 +-
 drivers/xen/xenbus/xenbus.h                |  45 ++--
 drivers/xen/xenbus/xenbus_client.c         |  32 +--
 drivers/xen/xenbus/xenbus_comms.c          | 121 +++++-----
 drivers/xen/xenbus/xenbus_dev_backend.c    |  30 ++-
 drivers/xen/xenbus/xenbus_dev_frontend.c   |  22 +-
 drivers/xen/xenbus/xenbus_probe.c          | 246 +++++++++++++--------
 drivers/xen/xenbus/xenbus_probe_backend.c  |  19 +-
 drivers/xen/xenbus/xenbus_probe_frontend.c |  65 +++---
 drivers/xen/xenbus/xenbus_xs.c             | 188 +++++++++-------
 include/xen/xen-ops.h                      |   3 +
 include/xen/xenbus.h                       |  54 +++--
 include/xen/xenhost.h                      |  20 ++
 18 files changed, 536 insertions(+), 377 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..7ad4423c24b8 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -541,12 +541,12 @@ static void xen_vbd_resize(struct xen_blkif *blkif)
 	pr_info("VBD Resize: new size %llu\n", new_size);
 	vbd->size = new_size;
 again:
-	err = xenbus_transaction_start(&xbt);
+	err = xenbus_transaction_start(dev->xh, &xbt);
 	if (err) {
 		pr_warn("Error starting transaction\n");
 		return;
 	}
-	err = xenbus_printf(xbt, dev->nodename, "sectors", "%llu",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "sectors", "%llu",
 			    (unsigned long long)vbd_sz(vbd));
 	if (err) {
 		pr_warn("Error writing new size\n");
@@ -557,20 +557,20 @@ static void xen_vbd_resize(struct xen_blkif *blkif)
 	 * the front-end. If the current state is "connected" the
 	 * front-end will get the new size information online.
 	 */
-	err = xenbus_printf(xbt, dev->nodename, "state", "%d", dev->state);
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "state", "%d", dev->state);
 	if (err) {
 		pr_warn("Error writing the state\n");
 		goto abort;
 	}
 
-	err = xenbus_transaction_end(xbt, 0);
+	err = xenbus_transaction_end(dev->xh, xbt, 0);
 	if (err == -EAGAIN)
 		goto again;
 	if (err)
 		pr_warn("Error ending transaction\n");
 	return;
 abort:
-	xenbus_transaction_end(xbt, 1);
+	xenbus_transaction_end(dev->xh, xbt, 1);
 }
 
 /*
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 1cd0a2d2ba54..ee28e8b85406 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1336,9 +1336,9 @@ static struct net_device *xennet_create_dev(struct xenbus_device *dev)
 
 	xenbus_switch_state(dev, XenbusStateInitialising);
 	wait_event(module_wq,
-		   xenbus_read_driver_state(dev->otherend) !=
+		   xenbus_read_driver_state(dev, dev->otherend) !=
 		   XenbusStateClosed &&
-		   xenbus_read_driver_state(dev->otherend) !=
+		   xenbus_read_driver_state(dev, dev->otherend) !=
 		   XenbusStateUnknown);
 	return netdev;
 
@@ -2145,19 +2145,19 @@ static int xennet_remove(struct xenbus_device *dev)
 
 	dev_dbg(&dev->dev, "%s\n", dev->nodename);
 
-	if (xenbus_read_driver_state(dev->otherend) != XenbusStateClosed) {
+	if (xenbus_read_driver_state(dev, dev->otherend) != XenbusStateClosed) {
 		xenbus_switch_state(dev, XenbusStateClosing);
 		wait_event(module_wq,
-			   xenbus_read_driver_state(dev->otherend) ==
+			   xenbus_read_driver_state(dev, dev->otherend) ==
 			   XenbusStateClosing ||
-			   xenbus_read_driver_state(dev->otherend) ==
+			   xenbus_read_driver_state(dev, dev->otherend) ==
 			   XenbusStateUnknown);
 
 		xenbus_switch_state(dev, XenbusStateClosed);
 		wait_event(module_wq,
-			   xenbus_read_driver_state(dev->otherend) ==
+			   xenbus_read_driver_state(dev, dev->otherend) ==
 			   XenbusStateClosed ||
-			   xenbus_read_driver_state(dev->otherend) ==
+			   xenbus_read_driver_state(dev, dev->otherend) ==
 			   XenbusStateUnknown);
 	}
 
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index f894290e8b3a..4c7ef1e09ed7 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -860,7 +860,7 @@ static int pcifront_try_connect(struct pcifront_device *pdev)
 
 
 	/* Only connect once */
-	if (xenbus_read_driver_state(pdev->xdev->nodename) !=
+	if (xenbus_read_driver_state(pdev->xdev, pdev->xdev->nodename) !=
 	    XenbusStateInitialised)
 		goto out;
 
@@ -871,7 +871,7 @@ static int pcifront_try_connect(struct pcifront_device *pdev)
 		goto out;
 	}
 
-	err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend,
+	err = xenbus_scanf(pdev->xdev->xh, XBT_NIL, pdev->xdev->otherend,
 			   "root_num", "%d", &num_roots);
 	if (err == -ENOENT) {
 		xenbus_dev_error(pdev->xdev, err,
diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index b1357aa4bc55..afeb94446d34 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -37,7 +37,7 @@ static int vcpu_online(unsigned int cpu)
 	char dir[16], state[16];
 
 	sprintf(dir, "cpu/%u", cpu);
-	err = xenbus_scanf(XBT_NIL, dir, "availability", "%15s", state);
+	err = xenbus_scanf(xh_default, XBT_NIL, dir, "availability", "%15s", state);
 	if (err != 1) {
 		if (!xen_initial_domain())
 			pr_err("Unable to read cpu state\n");
@@ -90,7 +90,7 @@ static int setup_cpu_watcher(struct notifier_block *notifier,
 		.node = "cpu",
 		.callback = handle_vcpu_hotplug_event};
 
-	(void)register_xenbus_watch(&cpu_watch);
+	(void)register_xenbus_watch(xh_default, &cpu_watch);
 
 	for_each_possible_cpu(cpu) {
 		if (vcpu_online(cpu) == 0) {
diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index 5bb01a62f214..9a69d955dd5c 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -227,14 +227,14 @@ static void shutdown_handler(struct xenbus_watch *watch,
 		return;
 
  again:
-	err = xenbus_transaction_start(&xbt);
+	err = xenbus_transaction_start(xh_default, &xbt);
 	if (err)
 		return;
 
-	str = (char *)xenbus_read(xbt, "control", "shutdown", NULL);
+	str = (char *)xenbus_read(xh_default, xbt, "control", "shutdown", NULL);
 	/* Ignore read errors and empty reads. */
 	if (XENBUS_IS_ERR_READ(str)) {
-		xenbus_transaction_end(xbt, 1);
+		xenbus_transaction_end(xh_default, xbt, 1);
 		return;
 	}
 
@@ -245,9 +245,9 @@ static void shutdown_handler(struct xenbus_watch *watch,
 
 	/* Only acknowledge commands which we are prepared to handle. */
 	if (idx < ARRAY_SIZE(shutdown_handlers))
-		xenbus_write(xbt, "control", "shutdown", "");
+		xenbus_write(xh_default, xbt, "control", "shutdown", "");
 
-	err = xenbus_transaction_end(xbt, 0);
+	err = xenbus_transaction_end(xh_default, xbt, 0);
 	if (err == -EAGAIN) {
 		kfree(str);
 		goto again;
@@ -272,10 +272,10 @@ static void sysrq_handler(struct xenbus_watch *watch, const char *path,
 	int err;
 
  again:
-	err = xenbus_transaction_start(&xbt);
+	err = xenbus_transaction_start(xh_default, &xbt);
 	if (err)
 		return;
-	err = xenbus_scanf(xbt, "control", "sysrq", "%c", &sysrq_key);
+	err = xenbus_scanf(xh_default, xbt, "control", "sysrq", "%c", &sysrq_key);
 	if (err < 0) {
 		/*
 		 * The Xenstore watch fires directly after registering it and
@@ -287,21 +287,21 @@ static void sysrq_handler(struct xenbus_watch *watch, const char *path,
 		if (err != -ENOENT && err != -ERANGE)
 			pr_err("Error %d reading sysrq code in control/sysrq\n",
 			       err);
-		xenbus_transaction_end(xbt, 1);
+		xenbus_transaction_end(xh_default, xbt, 1);
 		return;
 	}
 
 	if (sysrq_key != '\0') {
-		err = xenbus_printf(xbt, "control", "sysrq", "%c", '\0');
+		err = xenbus_printf(xh_default, xbt, "control", "sysrq", "%c", '\0');
 		if (err) {
 			pr_err("%s: Error %d writing sysrq in control/sysrq\n",
 			       __func__, err);
-			xenbus_transaction_end(xbt, 1);
+			xenbus_transaction_end(xh_default, xbt, 1);
 			return;
 		}
 	}
 
-	err = xenbus_transaction_end(xbt, 0);
+	err = xenbus_transaction_end(xh_default, xbt, 0);
 	if (err == -EAGAIN)
 		goto again;
 
@@ -331,7 +331,7 @@ static int setup_shutdown_watcher(void)
 #define FEATURE_PATH_SIZE (SHUTDOWN_CMD_SIZE + sizeof("feature-"))
 	char node[FEATURE_PATH_SIZE];
 
-	err = register_xenbus_watch(&shutdown_watch);
+	err = register_xenbus_watch(xh_default, &shutdown_watch);
 	if (err) {
 		pr_err("Failed to set shutdown watcher\n");
 		return err;
@@ -339,7 +339,7 @@ static int setup_shutdown_watcher(void)
 
 
 #ifdef CONFIG_MAGIC_SYSRQ
-	err = register_xenbus_watch(&sysrq_watch);
+	err = register_xenbus_watch(xh_default, &sysrq_watch);
 	if (err) {
 		pr_err("Failed to set sysrq watcher\n");
 		return err;
@@ -351,7 +351,7 @@ static int setup_shutdown_watcher(void)
 			continue;
 		snprintf(node, FEATURE_PATH_SIZE, "feature-%s",
 			 shutdown_handlers[idx].command);
-		err = xenbus_printf(XBT_NIL, "control", node, "%u", 1);
+		err = xenbus_printf(xh_default, XBT_NIL, "control", node, "%u", 1);
 		if (err) {
 			pr_err("%s: Error %d writing %s\n", __func__,
 				err, node);
diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index 2acbfe104e46..d34d9b1af7a8 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -63,7 +63,7 @@ static void watch_target(struct xenbus_watch *watch,
 	static bool watch_fired;
 	static long target_diff;
 
-	err = xenbus_scanf(XBT_NIL, "memory", "target", "%llu", &new_target);
+	err = xenbus_scanf(xh_default, XBT_NIL, "memory", "target", "%llu", &new_target);
 	if (err != 1) {
 		/* This is ok (for domain0 at least) - so just return */
 		return;
@@ -77,9 +77,9 @@ static void watch_target(struct xenbus_watch *watch,
 	if (!watch_fired) {
 		watch_fired = true;
 
-		if ((xenbus_scanf(XBT_NIL, "memory", "static-max",
+		if ((xenbus_scanf(xh_default, XBT_NIL, "memory", "static-max",
 				  "%llu", &static_max) == 1) ||
-		    (xenbus_scanf(XBT_NIL, "memory", "memory_static_max",
+		    (xenbus_scanf(xh_default, XBT_NIL, "memory", "memory_static_max",
 				  "%llu", &static_max) == 1))
 			static_max >>= PAGE_SHIFT - 10;
 		else
@@ -103,7 +103,7 @@ static int balloon_init_watcher(struct notifier_block *notifier,
 {
 	int err;
 
-	err = register_xenbus_watch(&target_watch);
+	err = register_xenbus_watch(xh_default, &target_watch);
 	if (err)
 		pr_err("Failed to set balloon watcher\n");
 
diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index 092981171df1..183c6e40bdaa 100644
--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -39,9 +39,11 @@
 #define XEN_BUS_ID_SIZE			20
 
 struct xen_bus_type {
+	xenhost_t *xh;
 	char *root;
 	unsigned int levels;
-	int (*get_bus_id)(char bus_id[XEN_BUS_ID_SIZE], const char *nodename);
+	int (*get_bus_id)(struct xen_bus_type *bus, char bus_id[XEN_BUS_ID_SIZE],
+			  const char *nodename);
 	int (*probe)(struct xen_bus_type *bus, const char *type,
 		     const char *dir);
 	void (*otherend_changed)(struct xenbus_watch *watch, const char *path,
@@ -49,13 +51,30 @@ struct xen_bus_type {
 	struct bus_type bus;
 };
 
-enum xenstore_init {
-	XS_UNKNOWN,
-	XS_PV,
-	XS_HVM,
-	XS_LOCAL,
+struct xenstore_private {
+	/* xenbus_comms.c */
+	struct work_struct probe_work;
+	struct wait_queue_head xb_waitq;
+	struct list_head xb_write_list;
+	struct task_struct *xenbus_task;
+	struct list_head reply_list;
+	int xenbus_irq;
+
+	/* xenbus_probe.c */
+	struct xenstore_domain_interface *store_interface;
+	struct blocking_notifier_head xenstore_chain;
+
+	enum xenstore_init domain_type;
+	xen_pfn_t store_gfn;
+	uint32_t store_evtchn;
+	int xenstored_ready;
+
+	/*  xenbus_xs.c */
+	struct list_head watches; /* xenhost local so we don't mix them up. */
 };
 
+#define xs_priv(xh) ((struct xenstore_private *) (xh)->xenstore_private)
+
 struct xs_watch_event {
 	struct list_head list;
 	unsigned int len;
@@ -87,18 +106,14 @@ struct xb_req_data {
 	void *par;
 };
 
-extern enum xenstore_init xen_store_domain_type;
 extern const struct attribute_group *xenbus_dev_groups[];
 extern struct mutex xs_response_mutex;
-extern struct list_head xs_reply_list;
-extern struct list_head xb_write_list;
-extern wait_queue_head_t xb_waitq;
 extern struct mutex xb_write_mutex;
 
-int xs_init(void);
-int xb_init_comms(void);
-void xb_deinit_comms(void);
-int xs_watch_msg(struct xs_watch_event *event);
+int xs_init(xenhost_t *xh);
+int xb_init_comms(xenhost_t *xh);
+void xb_deinit_comms(xenhost_t *xh);
+int xs_watch_msg(xenhost_t *xh, struct xs_watch_event *event);
 void xs_request_exit(struct xb_req_data *req);
 
 int xenbus_match(struct device *_dev, struct device_driver *_drv);
@@ -130,7 +145,7 @@ int xenbus_read_otherend_details(struct xenbus_device *xendev,
 
 void xenbus_ring_ops_init(void);
 
-int xenbus_dev_request_and_reply(struct xsd_sockmsg *msg, void *par);
+int xenbus_dev_request_and_reply(xenhost_t *xh, struct xsd_sockmsg *msg, void *par);
 void xenbus_dev_queue_reply(struct xb_req_data *req);
 
 #endif
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 5748fbaf0238..e4f8ecb9490a 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -122,7 +122,7 @@ int xenbus_watch_path(struct xenbus_device *dev, const char *path,
 	watch->node = path;
 	watch->callback = callback;
 
-	err = register_xenbus_watch(watch);
+	err = register_xenbus_watch(dev->xh, watch);
 
 	if (err) {
 		watch->node = NULL;
@@ -206,17 +206,17 @@ __xenbus_switch_state(struct xenbus_device *dev,
 again:
 	abort = 1;
 
-	err = xenbus_transaction_start(&xbt);
+	err = xenbus_transaction_start(dev->xh, &xbt);
 	if (err) {
 		xenbus_switch_fatal(dev, depth, err, "starting transaction");
 		return 0;
 	}
 
-	err = xenbus_scanf(xbt, dev->nodename, "state", "%d", &current_state);
+	err = xenbus_scanf(dev->xh, xbt, dev->nodename, "state", "%d", &current_state);
 	if (err != 1)
 		goto abort;
 
-	err = xenbus_printf(xbt, dev->nodename, "state", "%d", state);
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "state", "%d", state);
 	if (err) {
 		xenbus_switch_fatal(dev, depth, err, "writing new state");
 		goto abort;
@@ -224,7 +224,7 @@ __xenbus_switch_state(struct xenbus_device *dev,
 
 	abort = 0;
 abort:
-	err = xenbus_transaction_end(xbt, abort);
+	err = xenbus_transaction_end(dev->xh, xbt, abort);
 	if (err) {
 		if (err == -EAGAIN && !abort)
 			goto again;
@@ -279,7 +279,7 @@ static void xenbus_va_dev_error(struct xenbus_device *dev, int err,
 
 	path_buffer = kasprintf(GFP_KERNEL, "error/%s", dev->nodename);
 	if (path_buffer)
-		xenbus_write(XBT_NIL, path_buffer, "error", printf_buffer);
+		xenbus_write(dev->xh, XBT_NIL, path_buffer, "error", printf_buffer);
 
 	kfree(printf_buffer);
 	kfree(path_buffer);
@@ -363,7 +363,7 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 	int i, j;
 
 	for (i = 0; i < nr_pages; i++) {
-		err = gnttab_grant_foreign_access(dev->otherend_id,
+		err = gnttab_grant_foreign_access(dev->xh, dev->otherend_id,
 						  virt_to_gfn(vaddr), 0);
 		if (err < 0) {
 			xenbus_dev_fatal(dev, err,
@@ -379,7 +379,7 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 
 fail:
 	for (j = 0; j < i; j++)
-		gnttab_end_foreign_access_ref(grefs[j], 0);
+		gnttab_end_foreign_access_ref(dev->xh, grefs[j], 0);
 	return err;
 }
 EXPORT_SYMBOL_GPL(xenbus_grant_ring);
@@ -399,7 +399,7 @@ int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port)
 	alloc_unbound.dom = DOMID_SELF;
 	alloc_unbound.remote_dom = dev->otherend_id;
 
-	err = HYPERVISOR_event_channel_op(EVTCHNOP_alloc_unbound,
+	err = hypervisor_event_channel_op(dev->xh, EVTCHNOP_alloc_unbound,
 					  &alloc_unbound);
 	if (err)
 		xenbus_dev_fatal(dev, err, "allocating event channel");
@@ -421,7 +421,7 @@ int xenbus_free_evtchn(struct xenbus_device *dev, int port)
 
 	close.port = port;
 
-	err = HYPERVISOR_event_channel_op(EVTCHNOP_close, &close);
+	err = hypervisor_event_channel_op(dev->xh, EVTCHNOP_close, &close);
 	if (err)
 		xenbus_dev_error(dev, err, "freeing event channel %d", port);
 
@@ -478,7 +478,7 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 		handles[i] = INVALID_GRANT_HANDLE;
 	}
 
-	gnttab_batch_map(map, i);
+	gnttab_batch_map(dev->xh, map, i);
 
 	for (i = 0; i < nr_grefs; i++) {
 		if (map[i].status != GNTST_okay) {
@@ -503,7 +503,7 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 		}
 	}
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, j))
+	if (hypervisor_grant_table_op(dev->xh, GNTTABOP_unmap_grant_ref, unmap, j))
 		BUG();
 
 	*leaked = false;
@@ -761,7 +761,7 @@ static int xenbus_unmap_ring_vfree_pv(struct xenbus_device *dev, void *vaddr)
 		unmap[i].handle = node->handles[i];
 	}
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, i))
+	if (hypervisor_grant_table_op(dev->xh, GNTTABOP_unmap_grant_ref, unmap, i))
 		BUG();
 
 	err = GNTST_okay;
@@ -884,7 +884,7 @@ int xenbus_unmap_ring(struct xenbus_device *dev,
 		gnttab_set_unmap_op(&unmap[i], vaddrs[i],
 				    GNTMAP_host_map, handles[i]);
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, i))
+	if (hypervisor_grant_table_op(dev->xh, GNTTABOP_unmap_grant_ref, unmap, i))
 		BUG();
 
 	err = GNTST_okay;
@@ -910,10 +910,10 @@ EXPORT_SYMBOL_GPL(xenbus_unmap_ring);
  * Return the state of the driver rooted at the given store path, or
  * XenbusStateUnknown if no state can be read.
  */
-enum xenbus_state xenbus_read_driver_state(const char *path)
+enum xenbus_state xenbus_read_driver_state(struct xenbus_device *dev, const char *path)
 {
 	enum xenbus_state result;
-	int err = xenbus_gather(XBT_NIL, path, "state", "%d", &result, NULL);
+	int err = xenbus_gather(dev->xh, XBT_NIL, path, "state", "%d", &result, NULL);
 	if (err)
 		result = XenbusStateUnknown;
 
diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index acbc366c1717..2494ae1a0a7e 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -43,31 +43,21 @@
 #include <xen/page.h>
 #include "xenbus.h"
 
-/* A list of replies. Currently only one will ever be outstanding. */
-LIST_HEAD(xs_reply_list);
-
-/* A list of write requests. */
-LIST_HEAD(xb_write_list);
-DECLARE_WAIT_QUEUE_HEAD(xb_waitq);
 DEFINE_MUTEX(xb_write_mutex);
 
 /* Protect xenbus reader thread against save/restore. */
 DEFINE_MUTEX(xs_response_mutex);
 
-static int xenbus_irq;
-static struct task_struct *xenbus_task;
-
-static DECLARE_WORK(probe_work, xenbus_probe);
-
-
-static irqreturn_t wake_waiting(int irq, void *unused)
+static irqreturn_t wake_waiting(int irq, void *_xs)
 {
-	if (unlikely(xenstored_ready == 0)) {
-		xenstored_ready = 1;
-		schedule_work(&probe_work);
+	struct xenstore_private *xs = (struct xenstore_private *) _xs;
+
+	if (unlikely(xs->xenstored_ready == 0)) {
+			xs->xenstored_ready = 1;
+			schedule_work(&xs->probe_work);
 	}
 
-	wake_up(&xb_waitq);
+	wake_up(&xs->xb_waitq);
 	return IRQ_HANDLED;
 }
 
@@ -96,24 +86,26 @@ static const void *get_input_chunk(XENSTORE_RING_IDX cons,
 	return buf + MASK_XENSTORE_IDX(cons);
 }
 
-static int xb_data_to_write(void)
+static int xb_data_to_write(struct xenstore_private *xs)
 {
-	struct xenstore_domain_interface *intf = xen_store_interface;
+	struct xenstore_domain_interface *intf = xs->store_interface;
 
 	return (intf->req_prod - intf->req_cons) != XENSTORE_RING_SIZE &&
-		!list_empty(&xb_write_list);
+		!list_empty(&xs->xb_write_list);
 }
 
 /**
  * xb_write - low level write
+ * @xh: xenhost to send to
  * @data: buffer to send
  * @len: length of buffer
  *
  * Returns number of bytes written or -err.
  */
-static int xb_write(const void *data, unsigned int len)
+static int xb_write(xenhost_t *xh, const void *data, unsigned int len)
 {
-	struct xenstore_domain_interface *intf = xen_store_interface;
+	struct xenstore_private *xs = xs_priv(xh);
+	struct xenstore_domain_interface *intf = xs->store_interface;
 	XENSTORE_RING_IDX cons, prod;
 	unsigned int bytes = 0;
 
@@ -128,7 +120,7 @@ static int xb_write(const void *data, unsigned int len)
 			intf->req_cons = intf->req_prod = 0;
 			return -EIO;
 		}
-		if (!xb_data_to_write())
+		if (!xb_data_to_write(xs))
 			return bytes;
 
 		/* Must write data /after/ reading the consumer index. */
@@ -151,21 +143,22 @@ static int xb_write(const void *data, unsigned int len)
 
 		/* Implies mb(): other side will see the updated producer. */
 		if (prod <= intf->req_cons)
-			notify_remote_via_evtchn(xh_default, xen_store_evtchn);
+			notify_remote_via_evtchn(xh, xs->store_evtchn);
 	}
 
 	return bytes;
 }
 
-static int xb_data_to_read(void)
+static int xb_data_to_read(struct xenstore_private *xs)
 {
-	struct xenstore_domain_interface *intf = xen_store_interface;
+	struct xenstore_domain_interface *intf = xs->store_interface;
 	return (intf->rsp_cons != intf->rsp_prod);
 }
 
-static int xb_read(void *data, unsigned int len)
+static int xb_read(xenhost_t *xh, void *data, unsigned int len)
 {
-	struct xenstore_domain_interface *intf = xen_store_interface;
+	struct xenstore_private *xs = xs_priv(xh);
+	struct xenstore_domain_interface *intf = xs->store_interface;
 	XENSTORE_RING_IDX cons, prod;
 	unsigned int bytes = 0;
 
@@ -204,14 +197,15 @@ static int xb_read(void *data, unsigned int len)
 
 		/* Implies mb(): other side will see the updated consumer. */
 		if (intf->rsp_prod - cons >= XENSTORE_RING_SIZE)
-			notify_remote_via_evtchn(xh_default, xen_store_evtchn);
+			notify_remote_via_evtchn(xh, xs->store_evtchn);
 	}
 
 	return bytes;
 }
 
-static int process_msg(void)
+static int process_msg(xenhost_t *xh)
 {
+	struct xenstore_private *xs = xs_priv(xh);
 	static struct {
 		struct xsd_sockmsg msg;
 		char *body;
@@ -242,7 +236,7 @@ static int process_msg(void)
 		 */
 		mutex_lock(&xs_response_mutex);
 
-		if (!xb_data_to_read()) {
+		if (!xb_data_to_read(xh->xenstore_private)) {
 			/* We raced with save/restore: pending data 'gone'. */
 			mutex_unlock(&xs_response_mutex);
 			state.in_msg = false;
@@ -252,7 +246,7 @@ static int process_msg(void)
 
 	if (state.in_hdr) {
 		if (state.read != sizeof(state.msg)) {
-			err = xb_read((void *)&state.msg + state.read,
+			err = xb_read(xh, (void *)&state.msg + state.read,
 				      sizeof(state.msg) - state.read);
 			if (err < 0)
 				goto out;
@@ -281,7 +275,7 @@ static int process_msg(void)
 		state.read = 0;
 	}
 
-	err = xb_read(state.body + state.read, state.msg.len - state.read);
+	err = xb_read(xh, state.body + state.read, state.msg.len - state.read);
 	if (err < 0)
 		goto out;
 
@@ -293,11 +287,11 @@ static int process_msg(void)
 
 	if (state.msg.type == XS_WATCH_EVENT) {
 		state.watch->len = state.msg.len;
-		err = xs_watch_msg(state.watch);
+		err = xs_watch_msg(xh, state.watch);
 	} else {
 		err = -ENOENT;
 		mutex_lock(&xb_write_mutex);
-		list_for_each_entry(req, &xs_reply_list, list) {
+		list_for_each_entry(req, &xs->reply_list, list) {
 			if (req->msg.req_id == state.msg.req_id) {
 				list_del(&req->list);
 				err = 0;
@@ -333,8 +327,9 @@ static int process_msg(void)
 	return err;
 }
 
-static int process_writes(void)
+static int process_writes(xenhost_t *xh)
 {
+	struct xenstore_private *xs = xs_priv(xh);
 	static struct {
 		struct xb_req_data *req;
 		int idx;
@@ -344,13 +339,13 @@ static int process_writes(void)
 	unsigned int len;
 	int err = 0;
 
-	if (!xb_data_to_write())
+	if (!xb_data_to_write(xs))
 		return 0;
 
 	mutex_lock(&xb_write_mutex);
 
 	if (!state.req) {
-		state.req = list_first_entry(&xb_write_list,
+		state.req = list_first_entry(&xs->xb_write_list,
 					     struct xb_req_data, list);
 		state.idx = -1;
 		state.written = 0;
@@ -367,7 +362,7 @@ static int process_writes(void)
 			base = state.req->vec[state.idx].iov_base;
 			len = state.req->vec[state.idx].iov_len;
 		}
-		err = xb_write(base + state.written, len - state.written);
+		err = xb_write(xh, base + state.written, len - state.written);
 		if (err < 0)
 			goto out_err;
 		state.written += err;
@@ -380,7 +375,7 @@ static int process_writes(void)
 
 	list_del(&state.req->list);
 	state.req->state = xb_req_state_wait_reply;
-	list_add_tail(&state.req->list, &xs_reply_list);
+	list_add_tail(&state.req->list, &xs->reply_list);
 	state.req = NULL;
 
  out:
@@ -406,42 +401,45 @@ static int process_writes(void)
 	return err;
 }
 
-static int xb_thread_work(void)
+static int xb_thread_work(struct xenstore_private *xs)
 {
-	return xb_data_to_read() || xb_data_to_write();
+	return xb_data_to_read(xs) || xb_data_to_write(xs);
 }
 
-static int xenbus_thread(void *unused)
+static int xenbus_thread(void *_xh)
 {
+	xenhost_t *xh = (xenhost_t *)_xh;
+	struct xenstore_private *xs = xs_priv(xh);
 	int err;
 
 	while (!kthread_should_stop()) {
-		if (wait_event_interruptible(xb_waitq, xb_thread_work()))
+		if (wait_event_interruptible(xs->xb_waitq, xb_thread_work(xs)))
 			continue;
 
-		err = process_msg();
+		err = process_msg(xh);
 		if (err == -ENOMEM)
 			schedule();
 		else if (err)
 			pr_warn_ratelimited("error %d while reading message\n",
 					    err);
 
-		err = process_writes();
+		err = process_writes(xh);
 		if (err)
 			pr_warn_ratelimited("error %d while writing message\n",
 					    err);
 	}
 
-	xenbus_task = NULL;
+	xs->xenbus_task = NULL;
 	return 0;
 }
 
 /**
  * xb_init_comms - Set up interrupt handler off store event channel.
  */
-int xb_init_comms(void)
+int xb_init_comms(xenhost_t *xh)
 {
-	struct xenstore_domain_interface *intf = xen_store_interface;
+	struct xenstore_private *xs = xs_priv(xh);
+	struct xenstore_domain_interface *intf = xs->store_interface;
 
 	if (intf->req_prod != intf->req_cons)
 		pr_err("request ring is not quiescent (%08x:%08x)!\n",
@@ -455,34 +453,35 @@ int xb_init_comms(void)
 			intf->rsp_cons = intf->rsp_prod;
 	}
 
-	if (xenbus_irq) {
+	if (xs->xenbus_irq) {
 		/* Already have an irq; assume we're resuming */
-		rebind_evtchn_irq(xen_store_evtchn, xenbus_irq);
+		rebind_evtchn_irq(xs->store_evtchn, xs->xenbus_irq);
 	} else {
 		int err;
 
-		err = bind_evtchn_to_irqhandler(xh_default, xen_store_evtchn, wake_waiting,
-						0, "xenbus", &xb_waitq);
+		err = bind_evtchn_to_irqhandler(xh, xs->store_evtchn, wake_waiting,
+						0, "xenbus", xs);
 		if (err < 0) {
 			pr_err("request irq failed %i\n", err);
 			return err;
 		}
 
-		xenbus_irq = err;
+		xs->xenbus_irq = err;
 
-		if (!xenbus_task) {
-			xenbus_task = kthread_run(xenbus_thread, NULL,
+		if (!xs->xenbus_task) {
+			xs->xenbus_task = kthread_run(xenbus_thread, xh,
 						  "xenbus");
-			if (IS_ERR(xenbus_task))
-				return PTR_ERR(xenbus_task);
+			if (IS_ERR(xs->xenbus_task))
+				return PTR_ERR(xs->xenbus_task);
 		}
 	}
 
 	return 0;
 }
 
-void xb_deinit_comms(void)
+void xb_deinit_comms(xenhost_t *xh)
 {
-	unbind_from_irqhandler(xenbus_irq, &xb_waitq);
-	xenbus_irq = 0;
+	struct xenstore_private *xs = xs_priv(xh);
+	unbind_from_irqhandler(xs->xenbus_irq, xs);
+	xs->xenbus_irq = 0;
 }
diff --git a/drivers/xen/xenbus/xenbus_dev_backend.c b/drivers/xen/xenbus/xenbus_dev_backend.c
index edba5fecde4d..211f1ce53d30 100644
--- a/drivers/xen/xenbus/xenbus_dev_backend.c
+++ b/drivers/xen/xenbus/xenbus_dev_backend.c
@@ -19,6 +19,8 @@
 
 #include "xenbus.h"
 
+static xenhost_t *xh;
+
 static int xenbus_backend_open(struct inode *inode, struct file *filp)
 {
 	if (!capable(CAP_SYS_ADMIN))
@@ -31,6 +33,7 @@ static long xenbus_alloc(domid_t domid)
 {
 	struct evtchn_alloc_unbound arg;
 	int err = -EEXIST;
+	struct xenstore_private *xs = xs_priv(xh);
 
 	xs_suspend();
 
@@ -44,23 +47,23 @@ static long xenbus_alloc(domid_t domid)
 	 * unnecessarily complex for the intended use where xenstored is only
 	 * started once - so return -EEXIST if it's already running.
 	 */
-	if (xenstored_ready)
+	if (xs->xenstored_ready)
 		goto out_err;
 
-	gnttab_grant_foreign_access_ref(GNTTAB_RESERVED_XENSTORE, domid,
-			virt_to_gfn(xen_store_interface), 0 /* writable */);
+	gnttab_grant_foreign_access_ref(xh, GNTTAB_RESERVED_XENSTORE, domid,
+			virt_to_gfn(xs->store_interface), 0 /* writable */);
 
 	arg.dom = DOMID_SELF;
 	arg.remote_dom = domid;
 
-	err = HYPERVISOR_event_channel_op(EVTCHNOP_alloc_unbound, &arg);
+	err = hypervisor_event_channel_op(xh, EVTCHNOP_alloc_unbound, &arg);
 	if (err)
 		goto out_err;
 
-	if (xen_store_evtchn > 0)
-		xb_deinit_comms();
+	if (xs->store_evtchn > 0)
+		xb_deinit_comms(xh);
 
-	xen_store_evtchn = arg.port;
+	xs->store_evtchn = arg.port;
 
 	xs_resume();
 
@@ -74,13 +77,15 @@ static long xenbus_alloc(domid_t domid)
 static long xenbus_backend_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long data)
 {
+	struct xenstore_private *xs = xs_priv(xh);
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	switch (cmd) {
 	case IOCTL_XENBUS_BACKEND_EVTCHN:
-		if (xen_store_evtchn > 0)
-			return xen_store_evtchn;
+		if (xs->store_evtchn > 0)
+			return xs->store_evtchn;
 		return -ENODEV;
 	case IOCTL_XENBUS_BACKEND_SETUP:
 		return xenbus_alloc(data);
@@ -92,6 +97,7 @@ static long xenbus_backend_ioctl(struct file *file, unsigned int cmd,
 static int xenbus_backend_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
+	struct xenstore_private *xs = xs_priv(xh);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -100,7 +106,7 @@ static int xenbus_backend_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	if (remap_pfn_range(vma, vma->vm_start,
-			    virt_to_pfn(xen_store_interface),
+			    virt_to_pfn(xs->store_interface),
 			    size, vma->vm_page_prot))
 		return -EAGAIN;
 
@@ -125,6 +131,10 @@ static int __init xenbus_backend_init(void)
 
 	if (!xen_initial_domain())
 		return -ENODEV;
+	/*
+	 * Backends shouldn't have any truck with the remote xenhost.
+	 */
+	xh = xh_default;
 
 	err = misc_register(&xenbus_backend_dev);
 	if (err)
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index c3e201025ef0..d6e0c397c6a0 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -58,10 +58,14 @@
 
 #include <xen/xenbus.h>
 #include <xen/xen.h>
+#include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 #include <asm/xen/hypervisor.h>
 
 #include "xenbus.h"
 
+static xenhost_t *xh;
+
 /*
  * An element of a list of outstanding transactions, for which we're
  * still waiting a reply.
@@ -312,13 +316,13 @@ static void xenbus_file_free(struct kref *kref)
 	 */
 
 	list_for_each_entry_safe(trans, tmp, &u->transactions, list) {
-		xenbus_transaction_end(trans->handle, 1);
+		xenbus_transaction_end(xh, trans->handle, 1);
 		list_del(&trans->list);
 		kfree(trans);
 	}
 
 	list_for_each_entry_safe(watch, tmp_watch, &u->watches, list) {
-		unregister_xenbus_watch(&watch->watch);
+		unregister_xenbus_watch(xh, &watch->watch);
 		list_del(&watch->list);
 		free_watch_adapter(watch);
 	}
@@ -450,7 +454,7 @@ static int xenbus_write_transaction(unsigned msg_type,
 		   (!strcmp(msg->body, "T") || !strcmp(msg->body, "F"))))
 		return xenbus_command_reply(u, XS_ERROR, "EINVAL");
 
-	rc = xenbus_dev_request_and_reply(&msg->hdr, u);
+	rc = xenbus_dev_request_and_reply(xh, &msg->hdr, u);
 	if (rc && trans) {
 		list_del(&trans->list);
 		kfree(trans);
@@ -489,7 +493,7 @@ static int xenbus_write_watch(unsigned msg_type, struct xenbus_file_priv *u)
 		watch->watch.callback = watch_fired;
 		watch->dev_data = u;
 
-		err = register_xenbus_watch(&watch->watch);
+		err = register_xenbus_watch(xh, &watch->watch);
 		if (err) {
 			free_watch_adapter(watch);
 			rc = err;
@@ -500,7 +504,7 @@ static int xenbus_write_watch(unsigned msg_type, struct xenbus_file_priv *u)
 		list_for_each_entry(watch, &u->watches, list) {
 			if (!strcmp(watch->token, token) &&
 			    !strcmp(watch->watch.node, path)) {
-				unregister_xenbus_watch(&watch->watch);
+				unregister_xenbus_watch(xh, &watch->watch);
 				list_del(&watch->list);
 				free_watch_adapter(watch);
 				break;
@@ -618,8 +622,9 @@ static ssize_t xenbus_file_write(struct file *filp,
 static int xenbus_file_open(struct inode *inode, struct file *filp)
 {
 	struct xenbus_file_priv *u;
+	struct xenstore_private *xs = xs_priv(xh);
 
-	if (xen_store_evtchn == 0)
+	if (xs->store_evtchn == 0)
 		return -ENOENT;
 
 	nonseekable_open(inode, filp);
@@ -687,6 +692,11 @@ static int __init xenbus_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
+	if (xen_driver_domain() && xen_nested())
+		xh = xh_remote;
+	else
+		xh = xh_default;
+
 	err = misc_register(&xenbus_dev);
 	if (err)
 		pr_err("Could not register xenbus frontend device\n");
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 049bd511f36e..bd90ba00d64c 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -65,20 +65,6 @@
 
 #include "xenbus.h"
 
-
-int xen_store_evtchn;
-EXPORT_SYMBOL_GPL(xen_store_evtchn);
-
-struct xenstore_domain_interface *xen_store_interface;
-EXPORT_SYMBOL_GPL(xen_store_interface);
-
-enum xenstore_init xen_store_domain_type;
-EXPORT_SYMBOL_GPL(xen_store_domain_type);
-
-static unsigned long xen_store_gfn;
-
-static BLOCKING_NOTIFIER_HEAD(xenstore_chain);
-
 /* If something in array of ids matches this device, return it. */
 static const struct xenbus_device_id *
 match_device(const struct xenbus_device_id *arr, struct xenbus_device *dev)
@@ -112,7 +98,7 @@ static void free_otherend_details(struct xenbus_device *dev)
 static void free_otherend_watch(struct xenbus_device *dev)
 {
 	if (dev->otherend_watch.node) {
-		unregister_xenbus_watch(&dev->otherend_watch);
+		unregister_xenbus_watch(dev->xh, &dev->otherend_watch);
 		kfree(dev->otherend_watch.node);
 		dev->otherend_watch.node = NULL;
 	}
@@ -145,7 +131,7 @@ static int watch_otherend(struct xenbus_device *dev)
 int xenbus_read_otherend_details(struct xenbus_device *xendev,
 				 char *id_node, char *path_node)
 {
-	int err = xenbus_gather(XBT_NIL, xendev->nodename,
+	int err = xenbus_gather(xendev->xh, XBT_NIL, xendev->nodename,
 				id_node, "%i", &xendev->otherend_id,
 				path_node, NULL, &xendev->otherend,
 				NULL);
@@ -156,7 +142,7 @@ int xenbus_read_otherend_details(struct xenbus_device *xendev,
 		return err;
 	}
 	if (strlen(xendev->otherend) == 0 ||
-	    !xenbus_exists(XBT_NIL, xendev->otherend, "")) {
+	    !xenbus_exists(xendev->xh, XBT_NIL, xendev->otherend, "")) {
 		xenbus_dev_fatal(xendev, -ENOENT,
 				 "unable to read other end from %s.  "
 				 "missing or inaccessible.",
@@ -186,7 +172,7 @@ void xenbus_otherend_changed(struct xenbus_watch *watch,
 		return;
 	}
 
-	state = xenbus_read_driver_state(dev->otherend);
+	state = xenbus_read_driver_state(dev, dev->otherend);
 
 	dev_dbg(&dev->dev, "state is %d, (%s), %s, %s\n",
 		state, xenbus_strstate(state), dev->otherend_watch.node, path);
@@ -439,7 +425,11 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 	size_t stringlen;
 	char *tmpstring;
 
-	enum xenbus_state state = xenbus_read_driver_state(nodename);
+	enum xenbus_state state;
+
+	err = xenbus_gather(bus->xh, XBT_NIL, nodename, "state", "%d", &state, NULL);
+	if (err)
+		state = XenbusStateUnknown;
 
 	if (state != XenbusStateInitialising) {
 		/* Device is not new, so ignore it.  This can happen if a
@@ -465,10 +455,11 @@ int xenbus_probe_node(struct xen_bus_type *bus,
 	xendev->devicetype = tmpstring;
 	init_completion(&xendev->down);
 
+	xendev->xh = bus->xh;
 	xendev->dev.bus = &bus->bus;
 	xendev->dev.release = xenbus_dev_release;
 
-	err = bus->get_bus_id(devname, xendev->nodename);
+	err = bus->get_bus_id(bus, devname, xendev->nodename);
 	if (err)
 		goto fail;
 
@@ -496,7 +487,7 @@ static int xenbus_probe_device_type(struct xen_bus_type *bus, const char *type)
 	unsigned int dir_n = 0;
 	int i;
 
-	dir = xenbus_directory(XBT_NIL, bus->root, type, &dir_n);
+	dir = xenbus_directory(bus->xh, XBT_NIL, bus->root, type, &dir_n);
 	if (IS_ERR(dir))
 		return PTR_ERR(dir);
 
@@ -516,7 +507,7 @@ int xenbus_probe_devices(struct xen_bus_type *bus)
 	char **dir;
 	unsigned int i, dir_n;
 
-	dir = xenbus_directory(XBT_NIL, bus->root, "", &dir_n);
+	dir = xenbus_directory(bus->xh, XBT_NIL, bus->root, "", &dir_n);
 	if (IS_ERR(dir))
 		return PTR_ERR(dir);
 
@@ -564,7 +555,7 @@ void xenbus_dev_changed(const char *node, struct xen_bus_type *bus)
 	if (char_count(node, '/') < 2)
 		return;
 
-	exists = xenbus_exists(XBT_NIL, node, "");
+	exists = xenbus_exists(bus->xh, XBT_NIL, node, "");
 	if (!exists) {
 		xenbus_cleanup_devices(node, &bus->bus);
 		return;
@@ -660,47 +651,61 @@ int xenbus_dev_cancel(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_cancel);
 
-/* A flag to determine if xenstored is 'ready' (i.e. has started) */
-int xenstored_ready;
-
-
-int register_xenstore_notifier(struct notifier_block *nb)
+int register_xenstore_notifier(xenhost_t *xh, struct notifier_block *nb)
 {
 	int ret = 0;
+	struct xenstore_private *xs = xs_priv(xh);
 
-	if (xenstored_ready > 0)
+	if (xs->xenstored_ready > 0)
 		ret = nb->notifier_call(nb, 0, NULL);
 	else
-		blocking_notifier_chain_register(&xenstore_chain, nb);
+		blocking_notifier_chain_register(&xs->xenstore_chain, nb);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_xenstore_notifier);
 
-void unregister_xenstore_notifier(struct notifier_block *nb)
+void unregister_xenstore_notifier(xenhost_t *xh, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&xenstore_chain, nb);
+	struct xenstore_private *xs = xs_priv(xh);
+
+	blocking_notifier_chain_unregister(&xs->xenstore_chain, nb);
 }
 EXPORT_SYMBOL_GPL(unregister_xenstore_notifier);
 
-void xenbus_probe(struct work_struct *unused)
+/* Needed by platform-pci */
+void __xenbus_probe(void *_xs)
 {
-	xenstored_ready = 1;
+	struct xenstore_private *xs = (struct xenstore_private *) _xs;
+	xs->xenstored_ready = 1;
 
 	/* Notify others that xenstore is up */
-	blocking_notifier_call_chain(&xenstore_chain, 0, NULL);
+	blocking_notifier_call_chain(&xs->xenstore_chain, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(__xenbus_probe);
+
+void xenbus_probe(struct work_struct *w)
+{
+	struct xenstore_private *xs = container_of(w,
+			struct xenstore_private, probe_work);
+
+	__xenbus_probe(xs);
 }
-EXPORT_SYMBOL_GPL(xenbus_probe);
 
 static int __init xenbus_probe_initcall(void)
 {
+	xenhost_t **xh;
+
 	if (!xen_domain())
 		return -ENODEV;
 
 	if (xen_initial_domain() || xen_hvm_domain())
 		return 0;
 
-	xenbus_probe(NULL);
+	for_each_xenhost(xh) {
+		struct xenstore_private *xs = xs_priv(*xh);
+		xenbus_probe(&xs->probe_work);
+	}
 	return 0;
 }
 
@@ -709,30 +714,31 @@ device_initcall(xenbus_probe_initcall);
 /* Set up event channel for xenstored which is run as a local process
  * (this is normally used only in dom0)
  */
-static int __init xenstored_local_init(void)
+static int __init xenstored_local_init(xenhost_t *xh)
 {
 	int err = -ENOMEM;
 	unsigned long page = 0;
 	struct evtchn_alloc_unbound alloc_unbound;
+	struct xenstore_private *xs = xs_priv(xh);
 
 	/* Allocate Xenstore page */
 	page = get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		goto out_err;
 
-	xen_store_gfn = virt_to_gfn((void *)page);
+	xs->store_gfn = virt_to_gfn((void *)page);
 
 	/* Next allocate a local port which xenstored can bind to */
 	alloc_unbound.dom        = DOMID_SELF;
 	alloc_unbound.remote_dom = DOMID_SELF;
 
-	err = HYPERVISOR_event_channel_op(EVTCHNOP_alloc_unbound,
+	err = hypervisor_event_channel_op(xh, EVTCHNOP_alloc_unbound,
 					  &alloc_unbound);
 	if (err == -ENOSYS)
 		goto out_err;
 
 	BUG_ON(err);
-	xen_store_evtchn = alloc_unbound.port;
+	xs->store_evtchn = alloc_unbound.port;
 
 	return 0;
 
@@ -746,18 +752,24 @@ static int xenbus_resume_cb(struct notifier_block *nb,
 			    unsigned long action, void *data)
 {
 	int err = 0;
+	xenhost_t **xh;
 
-	if (xen_hvm_domain()) {
-		uint64_t v = 0;
+	for_each_xenhost(xh) {
+		struct xenstore_private *xs = xs_priv(*xh);
 
-		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
-		if (!err && v)
-			xen_store_evtchn = v;
-		else
-			pr_warn("Cannot update xenstore event channel: %d\n",
-				err);
-	} else
-		xen_store_evtchn = xen_start_info->store_evtchn;
+		/* FIXME xh->resume_xs()? */
+		if (xen_hvm_domain()) {
+			uint64_t v = 0;
+
+			err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
+			if (!err && v)
+				xs->store_evtchn = v;
+			else
+				pr_warn("Cannot update xenstore event channel: %d\n",
+					err);
+		} else
+			xs->store_evtchn = xen_start_info->store_evtchn;
+	}
 
 	return err;
 }
@@ -766,67 +778,115 @@ static struct notifier_block xenbus_resume_nb = {
 	.notifier_call = xenbus_resume_cb,
 };
 
-static int __init xenbus_init(void)
+int xenbus_setup(xenhost_t *xh)
 {
+	struct xenstore_private *xs = xs_priv(xh);
 	int err = 0;
-	uint64_t v = 0;
-	xen_store_domain_type = XS_UNKNOWN;
 
-	if (!xen_domain())
-		return -ENODEV;
+	BUG_ON(xs->domain_type == XS_UNKNOWN);
 
-	xenbus_ring_ops_init();
-
-	if (xen_pv_domain())
-		xen_store_domain_type = XS_PV;
-	if (xen_hvm_domain())
-		xen_store_domain_type = XS_HVM;
-	if (xen_hvm_domain() && xen_initial_domain())
-		xen_store_domain_type = XS_LOCAL;
-	if (xen_pv_domain() && !xen_start_info->store_evtchn)
-		xen_store_domain_type = XS_LOCAL;
-	if (xen_pv_domain() && xen_start_info->store_evtchn)
-		xenstored_ready = 1;
-
-	switch (xen_store_domain_type) {
+	switch (xs->domain_type) {
 	case XS_LOCAL:
-		err = xenstored_local_init();
+		err = xenstored_local_init(xh);
 		if (err)
-			goto out_error;
-		xen_store_interface = gfn_to_virt(xen_store_gfn);
+			goto out;
+		xs->store_interface = gfn_to_virt(xs->store_gfn);
 		break;
 	case XS_PV:
-		xen_store_evtchn = xen_start_info->store_evtchn;
-		xen_store_gfn = xen_start_info->store_mfn;
-		xen_store_interface = gfn_to_virt(xen_store_gfn);
+		xs->store_interface = gfn_to_virt(xs->store_gfn);
+		xs->xenstored_ready = 1;
 		break;
 	case XS_HVM:
-		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
-		if (err)
-			goto out_error;
-		xen_store_evtchn = (int)v;
-		err = hvm_get_parameter(HVM_PARAM_STORE_PFN, &v);
-		if (err)
-			goto out_error;
-		xen_store_gfn = (unsigned long)v;
-		xen_store_interface =
-			xen_remap(xen_store_gfn << XEN_PAGE_SHIFT,
+		xs->store_interface =
+			xen_remap(xs->store_gfn << XEN_PAGE_SHIFT,
 				  XEN_PAGE_SIZE);
 		break;
 	default:
 		pr_warn("Xenstore state unknown\n");
 		break;
 	}
+out:
+	return err;
+}
 
-	/* Initialize the interface to xenstore. */
-	err = xs_init();
-	if (err) {
-		pr_warn("Error initializing xenstore comms: %i\n", err);
-		goto out_error;
+int xen_hvm_setup_xs(xenhost_t *xh)
+{
+	uint64_t v = 0;
+	int err = 0;
+	struct xenstore_private *xs = xs_priv(xh);
+
+	if (xen_initial_domain()) {
+		xs->domain_type = XS_LOCAL;
+		xs->store_evtchn = 0;
+		xs->store_gfn = 0;
+	} else { /* Frontend */
+		xs->domain_type = XS_HVM;
+		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
+		if (err)
+			goto out;
+		xs->store_evtchn = (int) v;
+
+		err = hvm_get_parameter(HVM_PARAM_STORE_PFN, &v);
+		if (err)
+			goto out;
+		xs->store_gfn = (int) v;
+	}
+
+out:
+	return err;
+}
+
+int xen_pv_setup_xs(xenhost_t *xh)
+{
+	struct xenstore_private *xs = xs_priv(xh);
+
+	if (xen_initial_domain()) {
+		xs->domain_type = XS_LOCAL;
+		xs->store_evtchn = 0;
+		xs->store_gfn = 0;
+	} else { /* Frontend */
+		xs->domain_type = XS_PV;
+		xs->store_evtchn = xen_start_info->store_evtchn;
+		xs->store_gfn = xen_start_info->store_mfn;
+	}
+
+	return 0;
+}
+
+static int __init xenbus_init(void)
+{
+	int err = 0;
+	struct xenstore_private *xs;
+	xenhost_t **xh;
+	int notifier = 0;
+
+	if (!xen_domain())
+		return -ENODEV;
+
+	xenbus_ring_ops_init();
+
+	for_each_xenhost(xh) {
+		(*xh)->xenstore_private = kzalloc(sizeof(*xs), GFP_KERNEL);
+		xenhost_setup_xs(*xh);
+		err = xenbus_setup(*xh);
+		if (err)
+			goto out_error;
+
+		/* Initialize the interface to xenstore. */
+		err = xs_init(*xh);
+		if (err) {
+			pr_warn("Error initializing xenstore comms: %i\n", err);
+			goto out_error;
+		}
+
+		xs = xs_priv(*xh);
+
+		if ((xs->domain_type != XS_LOCAL) &&
+		    (xs->domain_type != XS_UNKNOWN))
+		    notifier++;
 	}
 
-	if ((xen_store_domain_type != XS_LOCAL) &&
-	    (xen_store_domain_type != XS_UNKNOWN))
+	if (notifier)
 		xen_resume_notifier_register(&xenbus_resume_nb);
 
 #ifdef CONFIG_XEN_COMPAT_XENFS
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index d3c53a9db5e3..f030d6ab3c31 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -57,7 +57,8 @@
 #include "xenbus.h"
 
 /* backend/<type>/<fe-uuid>/<id> => <type>-<fe-domid>-<id> */
-static int backend_bus_id(char bus_id[XEN_BUS_ID_SIZE], const char *nodename)
+static int backend_bus_id(struct xen_bus_type *bus, char bus_id[XEN_BUS_ID_SIZE],
+			  const char *nodename)
 {
 	int domid, err;
 	const char *devid, *type, *frontend;
@@ -73,14 +74,14 @@ static int backend_bus_id(char bus_id[XEN_BUS_ID_SIZE], const char *nodename)
 
 	devid = strrchr(nodename, '/') + 1;
 
-	err = xenbus_gather(XBT_NIL, nodename, "frontend-id", "%i", &domid,
+	err = xenbus_gather(bus->xh, XBT_NIL, nodename, "frontend-id", "%i", &domid,
 			    "frontend", NULL, &frontend,
 			    NULL);
 	if (err)
 		return err;
 	if (strlen(frontend) == 0)
 		err = -ERANGE;
-	if (!err && !xenbus_exists(XBT_NIL, frontend, ""))
+	if (!err && !xenbus_exists(bus->xh, XBT_NIL, frontend, ""))
 		err = -ENOENT;
 	kfree(frontend);
 
@@ -165,7 +166,7 @@ static int xenbus_probe_backend(struct xen_bus_type *bus, const char *type,
 	if (!nodename)
 		return -ENOMEM;
 
-	dir = xenbus_directory(XBT_NIL, nodename, "", &dir_n);
+	dir = xenbus_directory(bus->xh, XBT_NIL, nodename, "", &dir_n);
 	if (IS_ERR(dir)) {
 		kfree(nodename);
 		return PTR_ERR(dir);
@@ -189,6 +190,7 @@ static void frontend_changed(struct xenbus_watch *watch,
 
 static struct xen_bus_type xenbus_backend = {
 	.root = "backend",
+	.xh = NULL,		/* Filled at xenbus_probe_backend_init() */
 	.levels = 3,		/* backend/type/<frontend>/<id> */
 	.get_bus_id = backend_bus_id,
 	.probe = xenbus_probe_backend,
@@ -224,7 +226,7 @@ static int read_frontend_details(struct xenbus_device *xendev)
 
 int xenbus_dev_is_online(struct xenbus_device *dev)
 {
-	return !!xenbus_read_unsigned(dev->nodename, "online", 0);
+	return !!xenbus_read_unsigned(dev->xh, dev->nodename, "online", 0);
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_is_online);
 
@@ -244,7 +246,7 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
 {
 	/* Enumerate devices in xenstore and watch for changes. */
 	xenbus_probe_devices(&xenbus_backend);
-	register_xenbus_watch(&be_watch);
+	register_xenbus_watch(xenbus_backend.xh,&be_watch);
 
 	return NOTIFY_DONE;
 }
@@ -258,12 +260,15 @@ static int __init xenbus_probe_backend_init(void)
 
 	DPRINTK("");
 
+	/* Backends always talk to default xenhost */
+	xenbus_backend.xh = xh_default;
+
 	/* Register ourselves with the kernel bus subsystem */
 	err = bus_register(&xenbus_backend.bus);
 	if (err)
 		return err;
 
-	register_xenstore_notifier(&xenstore_notifier);
+	register_xenstore_notifier(xenbus_backend.xh, &xenstore_notifier);
 
 	return 0;
 }
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index 3edab7cc03c3..fa2f733d1f1e 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -20,6 +20,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 #include <asm/xen/hypervisor.h>
 #include <xen/xenbus.h>
 #include <xen/events.h>
@@ -33,7 +34,8 @@
 
 
 /* device/<type>/<id> => <type>-<id> */
-static int frontend_bus_id(char bus_id[XEN_BUS_ID_SIZE], const char *nodename)
+static int frontend_bus_id(struct xen_bus_type *bus, char bus_id[XEN_BUS_ID_SIZE],
+				const char *nodename)
 {
 	nodename = strchr(nodename, '/');
 	if (!nodename || strlen(nodename + 1) >= XEN_BUS_ID_SIZE) {
@@ -101,13 +103,13 @@ static void xenbus_frontend_delayed_resume(struct work_struct *w)
 
 static int xenbus_frontend_dev_resume(struct device *dev)
 {
+	struct xenbus_device *xdev = to_xenbus_device(dev);
+	struct xenstore_private *xs = xs_priv(xdev->xh);
 	/*
 	 * If xenstored is running in this domain, we cannot access the backend
 	 * state at the moment, so we need to defer xenbus_dev_resume
 	 */
-	if (xen_store_domain_type == XS_LOCAL) {
-		struct xenbus_device *xdev = to_xenbus_device(dev);
-
+	if (xs->domain_type == XS_LOCAL) {
 		schedule_work(&xdev->work);
 
 		return 0;
@@ -118,8 +120,10 @@ static int xenbus_frontend_dev_resume(struct device *dev)
 
 static int xenbus_frontend_dev_probe(struct device *dev)
 {
-	if (xen_store_domain_type == XS_LOCAL) {
-		struct xenbus_device *xdev = to_xenbus_device(dev);
+	struct xenbus_device *xdev = to_xenbus_device(dev);
+	struct xenstore_private *xs = xs_priv(xdev->xh);
+
+	if (xs->domain_type == XS_LOCAL) {
 		INIT_WORK(&xdev->work, xenbus_frontend_delayed_resume);
 	}
 
@@ -136,6 +140,7 @@ static const struct dev_pm_ops xenbus_pm_ops = {
 
 static struct xen_bus_type xenbus_frontend = {
 	.root = "device",
+	.xh = NULL, 	/* initializd in xenbus_probe_frontend_init() */
 	.levels = 2,		/* device/type/<id> */
 	.get_bus_id = frontend_bus_id,
 	.probe = xenbus_probe_frontend,
@@ -242,7 +247,7 @@ static int print_device_status(struct device *dev, void *data)
 	} else if (xendev->state < XenbusStateConnected) {
 		enum xenbus_state rstate = XenbusStateUnknown;
 		if (xendev->otherend)
-			rstate = xenbus_read_driver_state(xendev->otherend);
+			rstate = xenbus_read_driver_state(xendev, xendev->otherend);
 		pr_warn("Timeout connecting to device: %s (local state %d, remote state %d)\n",
 			xendev->nodename, xendev->state, rstate);
 	}
@@ -335,7 +340,7 @@ static int backend_state;
 static void xenbus_reset_backend_state_changed(struct xenbus_watch *w,
 					const char *path, const char *token)
 {
-	if (xenbus_scanf(XBT_NIL, path, "", "%i",
+	if (xenbus_scanf(xenbus_frontend.xh, XBT_NIL, path, "", "%i",
 			 &backend_state) != 1)
 		backend_state = XenbusStateUnknown;
 	printk(KERN_DEBUG "XENBUS: backend %s %s\n",
@@ -373,26 +378,27 @@ static void xenbus_reset_frontend(char *fe, char *be, int be_state)
 	backend_state = XenbusStateUnknown;
 
 	pr_info("triggering reconnect on %s\n", be);
-	register_xenbus_watch(&be_watch);
+	register_xenbus_watch(xenbus_frontend.xh, &be_watch);
 
 	/* fall through to forward backend to state XenbusStateInitialising */
 	switch (be_state) {
 	case XenbusStateConnected:
-		xenbus_printf(XBT_NIL, fe, "state", "%d", XenbusStateClosing);
+		xenbus_printf(xenbus_frontend.xh, XBT_NIL, fe,
+				"state", "%d", XenbusStateClosing);
 		xenbus_reset_wait_for_backend(be, XenbusStateClosing);
 		/* fall through */
 
 	case XenbusStateClosing:
-		xenbus_printf(XBT_NIL, fe, "state", "%d", XenbusStateClosed);
+		xenbus_printf(xenbus_frontend.xh, XBT_NIL, fe, "state", "%d", XenbusStateClosed);
 		xenbus_reset_wait_for_backend(be, XenbusStateClosed);
 		/* fall through */
 
 	case XenbusStateClosed:
-		xenbus_printf(XBT_NIL, fe, "state", "%d", XenbusStateInitialising);
+		xenbus_printf(xenbus_frontend.xh, XBT_NIL, fe, "state", "%d", XenbusStateInitialising);
 		xenbus_reset_wait_for_backend(be, XenbusStateInitWait);
 	}
 
-	unregister_xenbus_watch(&be_watch);
+	unregister_xenbus_watch(xenbus_frontend.xh, &be_watch);
 	pr_info("reconnect done on %s\n", be);
 	kfree(be_watch.node);
 }
@@ -406,7 +412,7 @@ static void xenbus_check_frontend(char *class, char *dev)
 	if (!frontend)
 		return;
 
-	err = xenbus_scanf(XBT_NIL, frontend, "state", "%i", &fe_state);
+	err = xenbus_scanf(xenbus_frontend.xh, XBT_NIL, frontend, "state", "%i", &fe_state);
 	if (err != 1)
 		goto out;
 
@@ -415,10 +421,10 @@ static void xenbus_check_frontend(char *class, char *dev)
 	case XenbusStateClosed:
 		printk(KERN_DEBUG "XENBUS: frontend %s %s\n",
 				frontend, xenbus_strstate(fe_state));
-		backend = xenbus_read(XBT_NIL, frontend, "backend", NULL);
+		backend = xenbus_read(xenbus_frontend.xh, XBT_NIL, frontend, "backend", NULL);
 		if (!backend || IS_ERR(backend))
 			goto out;
-		err = xenbus_scanf(XBT_NIL, backend, "state", "%i", &be_state);
+		err = xenbus_scanf(xenbus_frontend.xh, XBT_NIL, backend, "state", "%i", &be_state);
 		if (err == 1)
 			xenbus_reset_frontend(frontend, backend, be_state);
 		kfree(backend);
@@ -430,18 +436,18 @@ static void xenbus_check_frontend(char *class, char *dev)
 	kfree(frontend);
 }
 
-static void xenbus_reset_state(void)
+static void xenbus_reset_state(xenhost_t *xh)
 {
 	char **devclass, **dev;
 	int devclass_n, dev_n;
 	int i, j;
 
-	devclass = xenbus_directory(XBT_NIL, "device", "", &devclass_n);
+	devclass = xenbus_directory(xh, XBT_NIL, "device", "", &devclass_n);
 	if (IS_ERR(devclass))
 		return;
 
 	for (i = 0; i < devclass_n; i++) {
-		dev = xenbus_directory(XBT_NIL, "device", devclass[i], &dev_n);
+		dev = xenbus_directory(xh, XBT_NIL, "device", devclass[i], &dev_n);
 		if (IS_ERR(dev))
 			continue;
 		for (j = 0; j < dev_n; j++)
@@ -453,14 +459,14 @@ static void xenbus_reset_state(void)
 
 static int frontend_probe_and_watch(struct notifier_block *notifier,
 				   unsigned long event,
-				   void *data)
+				   void *xh)
 {
 	/* reset devices in Connected or Closed state */
 	if (xen_hvm_domain())
-		xenbus_reset_state();
+		xenbus_reset_state((xenhost_t *)xh);
 	/* Enumerate devices in xenstore and watch for changes. */
 	xenbus_probe_devices(&xenbus_frontend);
-	register_xenbus_watch(&fe_watch);
+	register_xenbus_watch(xh, &fe_watch);
 
 	return NOTIFY_DONE;
 }
@@ -475,12 +481,19 @@ static int __init xenbus_probe_frontend_init(void)
 
 	DPRINTK("");
 
+	if (xen_driver_domain() && xen_nested())
+		xenbus_frontend.xh = xh_remote;
+	else
+		xenbus_frontend.xh = xh_default;
+
 	/* Register ourselves with the kernel bus subsystem */
-	err = bus_register(&xenbus_frontend.bus);
-	if (err)
-		return err;
+	if (xenbus_frontend.xh) {
+		err = bus_register(&xenbus_frontend.bus);
+		if (err)
+			return err;
 
-	register_xenstore_notifier(&xenstore_notifier);
+		register_xenstore_notifier(xenbus_frontend.xh, &xenstore_notifier);
+	}
 
 	return 0;
 }
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 74c2b9416b88..35c771bea9b6 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -76,8 +76,6 @@ static DECLARE_WAIT_QUEUE_HEAD(xs_state_enter_wq);
 /* Wait queue for suspend handling waiting for critical region being empty. */
 static DECLARE_WAIT_QUEUE_HEAD(xs_state_exit_wq);
 
-/* List of registered watches, and a lock to protect it. */
-static LIST_HEAD(watches);
 static DEFINE_SPINLOCK(watches_lock);
 
 /* List of pending watch callback events, and a lock to protect it. */
@@ -166,9 +164,9 @@ static int get_error(const char *errorstring)
 	return xsd_errors[i].errnum;
 }
 
-static bool xenbus_ok(void)
+static bool xenbus_ok(struct xenstore_private *xs)
 {
-	switch (xen_store_domain_type) {
+	switch (xs->domain_type) {
 	case XS_LOCAL:
 		switch (system_state) {
 		case SYSTEM_POWER_OFF:
@@ -190,9 +188,9 @@ static bool xenbus_ok(void)
 	return false;
 }
 
-static bool test_reply(struct xb_req_data *req)
+static bool test_reply(struct xenstore_private *xs, struct xb_req_data *req)
 {
-	if (req->state == xb_req_state_got_reply || !xenbus_ok())
+	if (req->state == xb_req_state_got_reply || !xenbus_ok(xs))
 		return true;
 
 	/* Make sure to reread req->state each time. */
@@ -201,12 +199,12 @@ static bool test_reply(struct xb_req_data *req)
 	return false;
 }
 
-static void *read_reply(struct xb_req_data *req)
+static void *read_reply(struct xenstore_private *xs, struct xb_req_data *req)
 {
 	while (req->state != xb_req_state_got_reply) {
-		wait_event(req->wq, test_reply(req));
+		wait_event(req->wq, test_reply(xs, req));
 
-		if (!xenbus_ok())
+		if (!xenbus_ok(xs))
 			/*
 			 * If we are in the process of being shut-down there is
 			 * no point of trying to contact XenBus - it is either
@@ -222,9 +220,10 @@ static void *read_reply(struct xb_req_data *req)
 	return req->body;
 }
 
-static void xs_send(struct xb_req_data *req, struct xsd_sockmsg *msg)
+static void xs_send(xenhost_t *xh, struct xb_req_data *req, struct xsd_sockmsg *msg)
 {
 	bool notify;
+	struct xenstore_private *xs = xs_priv(xh);
 
 	req->msg = *msg;
 	req->err = 0;
@@ -236,19 +235,19 @@ static void xs_send(struct xb_req_data *req, struct xsd_sockmsg *msg)
 	req->msg.req_id = xs_request_enter(req);
 
 	mutex_lock(&xb_write_mutex);
-	list_add_tail(&req->list, &xb_write_list);
-	notify = list_is_singular(&xb_write_list);
+	list_add_tail(&req->list, &xs->xb_write_list);
+	notify = list_is_singular(&xs->xb_write_list);
 	mutex_unlock(&xb_write_mutex);
 
 	if (notify)
-		wake_up(&xb_waitq);
+		wake_up(&xs->xb_waitq);
 }
 
-static void *xs_wait_for_reply(struct xb_req_data *req, struct xsd_sockmsg *msg)
+static void *xs_wait_for_reply(struct xenstore_private *xs, struct xb_req_data *req, struct xsd_sockmsg *msg)
 {
 	void *ret;
 
-	ret = read_reply(req);
+	ret = read_reply(xs, req);
 
 	xs_request_exit(req);
 
@@ -271,7 +270,7 @@ static void xs_wake_up(struct xb_req_data *req)
 	wake_up(&req->wq);
 }
 
-int xenbus_dev_request_and_reply(struct xsd_sockmsg *msg, void *par)
+int xenbus_dev_request_and_reply(xenhost_t *xh, struct xsd_sockmsg *msg, void *par)
 {
 	struct xb_req_data *req;
 	struct kvec *vec;
@@ -289,14 +288,15 @@ int xenbus_dev_request_and_reply(struct xsd_sockmsg *msg, void *par)
 	req->cb = xenbus_dev_queue_reply;
 	req->par = par;
 
-	xs_send(req, msg);
+	xs_send(xh, req, msg);
 
 	return 0;
 }
 EXPORT_SYMBOL(xenbus_dev_request_and_reply);
 
 /* Send message to xs, get kmalloc'ed reply.  ERR_PTR() on error. */
-static void *xs_talkv(struct xenbus_transaction t,
+static void *xs_talkv(xenhost_t *xh,
+		      struct xenbus_transaction t,
 		      enum xsd_sockmsg_type type,
 		      const struct kvec *iovec,
 		      unsigned int num_vecs,
@@ -307,6 +307,7 @@ static void *xs_talkv(struct xenbus_transaction t,
 	void *ret = NULL;
 	unsigned int i;
 	int err;
+	struct xenstore_private *xs = xs_priv(xh);
 
 	req = kmalloc(sizeof(*req), GFP_NOIO | __GFP_HIGH);
 	if (!req)
@@ -323,9 +324,9 @@ static void *xs_talkv(struct xenbus_transaction t,
 	for (i = 0; i < num_vecs; i++)
 		msg.len += iovec[i].iov_len;
 
-	xs_send(req, &msg);
+	xs_send(xh, req, &msg);
 
-	ret = xs_wait_for_reply(req, &msg);
+	ret = xs_wait_for_reply(xs, req, &msg);
 	if (len)
 		*len = msg.len;
 
@@ -348,7 +349,7 @@ static void *xs_talkv(struct xenbus_transaction t,
 }
 
 /* Simplified version of xs_talkv: single message. */
-static void *xs_single(struct xenbus_transaction t,
+static void *xs_single(xenhost_t *xh, struct xenbus_transaction t,
 		       enum xsd_sockmsg_type type,
 		       const char *string,
 		       unsigned int *len)
@@ -357,7 +358,7 @@ static void *xs_single(struct xenbus_transaction t,
 
 	iovec.iov_base = (void *)string;
 	iovec.iov_len = strlen(string) + 1;
-	return xs_talkv(t, type, &iovec, 1, len);
+	return xs_talkv(xh, t, type, &iovec, 1, len);
 }
 
 /* Many commands only need an ack, don't care what it says. */
@@ -415,7 +416,7 @@ static char **split(char *strings, unsigned int len, unsigned int *num)
 	return ret;
 }
 
-char **xenbus_directory(struct xenbus_transaction t,
+char **xenbus_directory(xenhost_t *xh, struct xenbus_transaction t,
 			const char *dir, const char *node, unsigned int *num)
 {
 	char *strings, *path;
@@ -425,7 +426,7 @@ char **xenbus_directory(struct xenbus_transaction t,
 	if (IS_ERR(path))
 		return (char **)path;
 
-	strings = xs_single(t, XS_DIRECTORY, path, &len);
+	strings = xs_single(xh, t, XS_DIRECTORY, path, &len);
 	kfree(path);
 	if (IS_ERR(strings))
 		return (char **)strings;
@@ -435,13 +436,13 @@ char **xenbus_directory(struct xenbus_transaction t,
 EXPORT_SYMBOL_GPL(xenbus_directory);
 
 /* Check if a path exists. Return 1 if it does. */
-int xenbus_exists(struct xenbus_transaction t,
+int xenbus_exists(xenhost_t *xh, struct xenbus_transaction t,
 		  const char *dir, const char *node)
 {
 	char **d;
 	int dir_n;
 
-	d = xenbus_directory(t, dir, node, &dir_n);
+	d = xenbus_directory(xh, t, dir, node, &dir_n);
 	if (IS_ERR(d))
 		return 0;
 	kfree(d);
@@ -453,7 +454,7 @@ EXPORT_SYMBOL_GPL(xenbus_exists);
  * Returns a kmalloced value: call free() on it after use.
  * len indicates length in bytes.
  */
-void *xenbus_read(struct xenbus_transaction t,
+void *xenbus_read(xenhost_t *xh, struct xenbus_transaction t,
 		  const char *dir, const char *node, unsigned int *len)
 {
 	char *path;
@@ -463,7 +464,7 @@ void *xenbus_read(struct xenbus_transaction t,
 	if (IS_ERR(path))
 		return (void *)path;
 
-	ret = xs_single(t, XS_READ, path, len);
+	ret = xs_single(xh, t, XS_READ, path, len);
 	kfree(path);
 	return ret;
 }
@@ -472,7 +473,7 @@ EXPORT_SYMBOL_GPL(xenbus_read);
 /* Write the value of a single file.
  * Returns -err on failure.
  */
-int xenbus_write(struct xenbus_transaction t,
+int xenbus_write(xenhost_t *xh, struct xenbus_transaction t,
 		 const char *dir, const char *node, const char *string)
 {
 	const char *path;
@@ -488,14 +489,14 @@ int xenbus_write(struct xenbus_transaction t,
 	iovec[1].iov_base = (void *)string;
 	iovec[1].iov_len = strlen(string);
 
-	ret = xs_error(xs_talkv(t, XS_WRITE, iovec, ARRAY_SIZE(iovec), NULL));
+	ret = xs_error(xs_talkv(xh, t, XS_WRITE, iovec, ARRAY_SIZE(iovec), NULL));
 	kfree(path);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xenbus_write);
 
 /* Create a new directory. */
-int xenbus_mkdir(struct xenbus_transaction t,
+int xenbus_mkdir(xenhost_t *xh, struct xenbus_transaction t,
 		 const char *dir, const char *node)
 {
 	char *path;
@@ -505,14 +506,14 @@ int xenbus_mkdir(struct xenbus_transaction t,
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 
-	ret = xs_error(xs_single(t, XS_MKDIR, path, NULL));
+	ret = xs_error(xs_single(xh, t, XS_MKDIR, path, NULL));
 	kfree(path);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xenbus_mkdir);
 
 /* Destroy a file or directory (directories must be empty). */
-int xenbus_rm(struct xenbus_transaction t, const char *dir, const char *node)
+int xenbus_rm(xenhost_t *xh,struct xenbus_transaction t, const char *dir, const char *node)
 {
 	char *path;
 	int ret;
@@ -521,7 +522,7 @@ int xenbus_rm(struct xenbus_transaction t, const char *dir, const char *node)
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 
-	ret = xs_error(xs_single(t, XS_RM, path, NULL));
+	ret = xs_error(xs_single(xh, t, XS_RM, path, NULL));
 	kfree(path);
 	return ret;
 }
@@ -530,11 +531,11 @@ EXPORT_SYMBOL_GPL(xenbus_rm);
 /* Start a transaction: changes by others will not be seen during this
  * transaction, and changes will not be visible to others until end.
  */
-int xenbus_transaction_start(struct xenbus_transaction *t)
+int xenbus_transaction_start(xenhost_t *xh, struct xenbus_transaction *t)
 {
 	char *id_str;
 
-	id_str = xs_single(XBT_NIL, XS_TRANSACTION_START, "", NULL);
+	id_str = xs_single(xh, XBT_NIL, XS_TRANSACTION_START, "", NULL);
 	if (IS_ERR(id_str))
 		return PTR_ERR(id_str);
 
@@ -547,7 +548,7 @@ EXPORT_SYMBOL_GPL(xenbus_transaction_start);
 /* End a transaction.
  * If abandon is true, transaction is discarded instead of committed.
  */
-int xenbus_transaction_end(struct xenbus_transaction t, int abort)
+int xenbus_transaction_end(xenhost_t *xh, struct xenbus_transaction t, int abort)
 {
 	char abortstr[2];
 
@@ -556,19 +557,19 @@ int xenbus_transaction_end(struct xenbus_transaction t, int abort)
 	else
 		strcpy(abortstr, "T");
 
-	return xs_error(xs_single(t, XS_TRANSACTION_END, abortstr, NULL));
+	return xs_error(xs_single(xh, t, XS_TRANSACTION_END, abortstr, NULL));
 }
 EXPORT_SYMBOL_GPL(xenbus_transaction_end);
 
 /* Single read and scanf: returns -errno or num scanned. */
-int xenbus_scanf(struct xenbus_transaction t,
+int xenbus_scanf(xenhost_t *xh, struct xenbus_transaction t,
 		 const char *dir, const char *node, const char *fmt, ...)
 {
 	va_list ap;
 	int ret;
 	char *val;
 
-	val = xenbus_read(t, dir, node, NULL);
+	val = xenbus_read(xh, t, dir, node, NULL);
 	if (IS_ERR(val))
 		return PTR_ERR(val);
 
@@ -584,13 +585,13 @@ int xenbus_scanf(struct xenbus_transaction t,
 EXPORT_SYMBOL_GPL(xenbus_scanf);
 
 /* Read an (optional) unsigned value. */
-unsigned int xenbus_read_unsigned(const char *dir, const char *node,
+unsigned int xenbus_read_unsigned(xenhost_t *xh, const char *dir, const char *node,
 				  unsigned int default_val)
 {
 	unsigned int val;
 	int ret;
 
-	ret = xenbus_scanf(XBT_NIL, dir, node, "%u", &val);
+	ret = xenbus_scanf(xh, XBT_NIL, dir, node, "%u", &val);
 	if (ret <= 0)
 		val = default_val;
 
@@ -599,7 +600,7 @@ unsigned int xenbus_read_unsigned(const char *dir, const char *node,
 EXPORT_SYMBOL_GPL(xenbus_read_unsigned);
 
 /* Single printf and write: returns -errno or 0. */
-int xenbus_printf(struct xenbus_transaction t,
+int xenbus_printf(xenhost_t *xh, struct xenbus_transaction t,
 		  const char *dir, const char *node, const char *fmt, ...)
 {
 	va_list ap;
@@ -613,7 +614,7 @@ int xenbus_printf(struct xenbus_transaction t,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = xenbus_write(t, dir, node, buf);
+	ret = xenbus_write(xh, t, dir, node, buf);
 
 	kfree(buf);
 
@@ -622,7 +623,7 @@ int xenbus_printf(struct xenbus_transaction t,
 EXPORT_SYMBOL_GPL(xenbus_printf);
 
 /* Takes tuples of names, scanf-style args, and void **, NULL terminated. */
-int xenbus_gather(struct xenbus_transaction t, const char *dir, ...)
+int xenbus_gather(xenhost_t *xh, struct xenbus_transaction t, const char *dir, ...)
 {
 	va_list ap;
 	const char *name;
@@ -634,7 +635,7 @@ int xenbus_gather(struct xenbus_transaction t, const char *dir, ...)
 		void *result = va_arg(ap, void *);
 		char *p;
 
-		p = xenbus_read(t, dir, name, NULL);
+		p = xenbus_read(xh, t, dir, name, NULL);
 		if (IS_ERR(p)) {
 			ret = PTR_ERR(p);
 			break;
@@ -651,7 +652,7 @@ int xenbus_gather(struct xenbus_transaction t, const char *dir, ...)
 }
 EXPORT_SYMBOL_GPL(xenbus_gather);
 
-static int xs_watch(const char *path, const char *token)
+static int xs_watch(xenhost_t *xh, const char *path, const char *token)
 {
 	struct kvec iov[2];
 
@@ -660,11 +661,11 @@ static int xs_watch(const char *path, const char *token)
 	iov[1].iov_base = (void *)token;
 	iov[1].iov_len = strlen(token) + 1;
 
-	return xs_error(xs_talkv(XBT_NIL, XS_WATCH, iov,
+	return xs_error(xs_talkv(xh, XBT_NIL, XS_WATCH, iov,
 				 ARRAY_SIZE(iov), NULL));
 }
 
-static int xs_unwatch(const char *path, const char *token)
+static int xs_unwatch(xenhost_t *xh, const char *path, const char *token)
 {
 	struct kvec iov[2];
 
@@ -673,24 +674,25 @@ static int xs_unwatch(const char *path, const char *token)
 	iov[1].iov_base = (char *)token;
 	iov[1].iov_len = strlen(token) + 1;
 
-	return xs_error(xs_talkv(XBT_NIL, XS_UNWATCH, iov,
+	return xs_error(xs_talkv(xh, XBT_NIL, XS_UNWATCH, iov,
 				 ARRAY_SIZE(iov), NULL));
 }
 
-static struct xenbus_watch *find_watch(const char *token)
+static struct xenbus_watch *find_watch(xenhost_t *xh, const char *token)
 {
 	struct xenbus_watch *i, *cmp;
+	struct xenstore_private *xs = xs_priv(xh);
 
 	cmp = (void *)simple_strtoul(token, NULL, 16);
 
-	list_for_each_entry(i, &watches, list)
+	list_for_each_entry(i, &xs->watches, list)
 		if (i == cmp)
 			return i;
 
 	return NULL;
 }
 
-int xs_watch_msg(struct xs_watch_event *event)
+int xs_watch_msg(xenhost_t *xh, struct xs_watch_event *event)
 {
 	if (count_strings(event->body, event->len) != 2) {
 		kfree(event);
@@ -700,7 +702,7 @@ int xs_watch_msg(struct xs_watch_event *event)
 	event->token = (const char *)strchr(event->body, '\0') + 1;
 
 	spin_lock(&watches_lock);
-	event->handle = find_watch(event->token);
+	event->handle = find_watch(xh, event->token);
 	if (event->handle != NULL) {
 		spin_lock(&watch_events_lock);
 		list_add_tail(&event->list, &watch_events);
@@ -719,7 +721,7 @@ int xs_watch_msg(struct xs_watch_event *event)
  * so if we are running on anything older than 4 do not attempt to read
  * control/platform-feature-xs_reset_watches.
  */
-static bool xen_strict_xenbus_quirk(void)
+static bool xen_strict_xenbus_quirk(xenhost_t *xh)
 {
 #ifdef CONFIG_X86
 	uint32_t eax, ebx, ecx, edx, base;
@@ -733,42 +735,44 @@ static bool xen_strict_xenbus_quirk(void)
 	return false;
 
 }
-static void xs_reset_watches(void)
+static void xs_reset_watches(xenhost_t *xh)
 {
 	int err;
 
 	if (!xen_hvm_domain() || xen_initial_domain())
 		return;
 
-	if (xen_strict_xenbus_quirk())
+	if (xen_strict_xenbus_quirk(xh))
 		return;
 
-	if (!xenbus_read_unsigned("control",
+	if (!xenbus_read_unsigned(xh, "control",
 				  "platform-feature-xs_reset_watches", 0))
 		return;
 
-	err = xs_error(xs_single(XBT_NIL, XS_RESET_WATCHES, "", NULL));
+	err = xs_error(xs_single(xh, XBT_NIL, XS_RESET_WATCHES, "", NULL));
 	if (err && err != -EEXIST)
 		pr_warn("xs_reset_watches failed: %d\n", err);
 }
 
 /* Register callback to watch this node. */
-int register_xenbus_watch(struct xenbus_watch *watch)
+int register_xenbus_watch(xenhost_t *xh, struct xenbus_watch *watch)
 {
 	/* Pointer in ascii is the token. */
 	char token[sizeof(watch) * 2 + 1];
+	struct xenstore_private *xs = xs_priv(xh);
 	int err;
 
 	sprintf(token, "%lX", (long)watch);
+	watch->xh = xh;
 
 	down_read(&xs_watch_rwsem);
 
 	spin_lock(&watches_lock);
-	BUG_ON(find_watch(token));
-	list_add(&watch->list, &watches);
+	BUG_ON(find_watch(xh, token));
+	list_add(&watch->list, &xs->watches);
 	spin_unlock(&watches_lock);
 
-	err = xs_watch(watch->node, token);
+	err = xs_watch(xh, watch->node, token);
 
 	if (err) {
 		spin_lock(&watches_lock);
@@ -782,7 +786,7 @@ int register_xenbus_watch(struct xenbus_watch *watch)
 }
 EXPORT_SYMBOL_GPL(register_xenbus_watch);
 
-void unregister_xenbus_watch(struct xenbus_watch *watch)
+void unregister_xenbus_watch(xenhost_t *xh, struct xenbus_watch *watch)
 {
 	struct xs_watch_event *event, *tmp;
 	char token[sizeof(watch) * 2 + 1];
@@ -793,11 +797,11 @@ void unregister_xenbus_watch(struct xenbus_watch *watch)
 	down_read(&xs_watch_rwsem);
 
 	spin_lock(&watches_lock);
-	BUG_ON(!find_watch(token));
+	BUG_ON(!find_watch(xh, token));
 	list_del(&watch->list);
 	spin_unlock(&watches_lock);
 
-	err = xs_unwatch(watch->node, token);
+	err = xs_unwatch(xh, watch->node, token);
 	if (err)
 		pr_warn("Failed to release watch %s: %i\n", watch->node, err);
 
@@ -831,24 +835,29 @@ void xs_suspend(void)
 	mutex_lock(&xs_response_mutex);
 }
 
-void xs_resume(void)
+void xs_resume()
 {
 	struct xenbus_watch *watch;
 	char token[sizeof(watch) * 2 + 1];
+	xenhost_t **xh;
 
-	xb_init_comms();
+	for_each_xenhost(xh) {
+		struct xenstore_private *xs = xs_priv(*xh);
 
-	mutex_unlock(&xs_response_mutex);
+		xb_init_comms(*xh);
 
-	xs_suspend_exit();
+		mutex_unlock(&xs_response_mutex);
 
-	/* No need for watches_lock: the xs_watch_rwsem is sufficient. */
-	list_for_each_entry(watch, &watches, list) {
-		sprintf(token, "%lX", (long)watch);
-		xs_watch(watch->node, token);
+		xs_suspend_exit();
+
+		/* No need for watches_lock: the xs_watch_rwsem is sufficient. */
+		list_for_each_entry(watch, &xs->watches, list) {
+			sprintf(token, "%lX", (long)watch);
+			xs_watch(*xh, watch->node, token);
+		}
+
+		up_write(&xs_watch_rwsem);
 	}
-
-	up_write(&xs_watch_rwsem);
 }
 
 void xs_suspend_cancel(void)
@@ -905,13 +914,18 @@ static int xs_reboot_notify(struct notifier_block *nb,
 			    unsigned long code, void *unused)
 {
 	struct xb_req_data *req;
+	xenhost_t **xh;
 
-	mutex_lock(&xb_write_mutex);
-	list_for_each_entry(req, &xs_reply_list, list)
-		wake_up(&req->wq);
-	list_for_each_entry(req, &xb_write_list, list)
-		wake_up(&req->wq);
-	mutex_unlock(&xb_write_mutex);
+	for_each_xenhost(xh) {
+		struct xenstore_private *xs = xs_priv(*xh);
+
+		mutex_lock(&xb_write_mutex);
+		list_for_each_entry(req, &xs->reply_list, list)
+			wake_up(&req->wq);
+		list_for_each_entry(req, &xs->xb_write_list, list)
+			wake_up(&req->wq);
+		mutex_unlock(&xb_write_mutex);
+	}
 	return NOTIFY_DONE;
 }
 
@@ -919,15 +933,17 @@ static struct notifier_block xs_reboot_nb = {
 	.notifier_call = xs_reboot_notify,
 };
 
-int xs_init(void)
+int xs_init(xenhost_t *xh)
 {
 	int err;
 	struct task_struct *task;
 
-	register_reboot_notifier(&xs_reboot_nb);
+	if (xh->type != xenhost_r2)
+		/* Needs to be moved out */
+		register_reboot_notifier(&xs_reboot_nb);
 
 	/* Initialize the shared memory rings to talk to xenstored */
-	err = xb_init_comms();
+	err = xb_init_comms(xh);
 	if (err)
 		return err;
 
@@ -936,7 +952,7 @@ int xs_init(void)
 		return PTR_ERR(task);
 
 	/* shutdown watches for kexec boot */
-	xs_reset_watches();
+	xs_reset_watches(xh);
 
 	return 0;
 }
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 75be9059893f..3ba2f6b1e196 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -204,6 +204,9 @@ int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
 int xen_xlate_map_ballooned_pages(xen_pfn_t **pfns, void **vaddr,
 				  unsigned long nr_grant_frames);
 
+int xen_hvm_setup_xs(xenhost_t *xh);
+int xen_pv_setup_xs(xenhost_t *xh);
+
 bool xen_running_on_version_or_later(unsigned int major, unsigned int minor);
 
 efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816d5f8c..8f8c39008e15 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <xen/interface/xen.h>
+#include <xen/xenhost.h>
 #include <xen/interface/grant_table.h>
 #include <xen/interface/io/xenbus.h>
 #include <xen/interface/io/xs_wire.h>
@@ -58,6 +59,8 @@ struct xenbus_watch
 
 	/* Path being watched. */
 	const char *node;
+	/* On xenhost. */
+	xenhost_t *xh;
 
 	/* Callback (executed in a process context with no locks held). */
 	void (*callback)(struct xenbus_watch *,
@@ -70,6 +73,7 @@ struct xenbus_device {
 	const char *devicetype;
 	const char *nodename;
 	const char *otherend;
+	xenhost_t *xh;
 	int otherend_id;
 	struct xenbus_watch otherend_watch;
 	struct device dev;
@@ -78,6 +82,13 @@ struct xenbus_device {
 	struct work_struct work;
 };
 
+enum xenstore_init {
+	XS_UNKNOWN,
+	XS_PV,
+	XS_HVM,
+	XS_LOCAL,
+};
+
 static inline struct xenbus_device *to_xenbus_device(struct device *dev)
 {
 	return container_of(dev, struct xenbus_device, dev);
@@ -133,52 +144,51 @@ struct xenbus_transaction
 /* Nil transaction ID. */
 #define XBT_NIL ((struct xenbus_transaction) { 0 })
 
-char **xenbus_directory(struct xenbus_transaction t,
+char **xenbus_directory(xenhost_t *xh, struct xenbus_transaction t,
 			const char *dir, const char *node, unsigned int *num);
-void *xenbus_read(struct xenbus_transaction t,
+void *xenbus_read(xenhost_t *xh, struct xenbus_transaction t,
 		  const char *dir, const char *node, unsigned int *len);
-int xenbus_write(struct xenbus_transaction t,
+int xenbus_write(xenhost_t *xh, struct xenbus_transaction t,
 		 const char *dir, const char *node, const char *string);
-int xenbus_mkdir(struct xenbus_transaction t,
+int xenbus_mkdir(xenhost_t *xh, struct xenbus_transaction t,
 		 const char *dir, const char *node);
-int xenbus_exists(struct xenbus_transaction t,
+int xenbus_exists(xenhost_t *xh, struct xenbus_transaction t,
 		  const char *dir, const char *node);
-int xenbus_rm(struct xenbus_transaction t, const char *dir, const char *node);
-int xenbus_transaction_start(struct xenbus_transaction *t);
-int xenbus_transaction_end(struct xenbus_transaction t, int abort);
+int xenbus_rm(xenhost_t *xh, struct xenbus_transaction t, const char *dir, const char *node);
+int xenbus_transaction_start(xenhost_t *xh, struct xenbus_transaction *t);
+int xenbus_transaction_end(xenhost_t *xh, struct xenbus_transaction t, int abort);
 
 /* Single read and scanf: returns -errno or num scanned if > 0. */
-__scanf(4, 5)
-int xenbus_scanf(struct xenbus_transaction t,
+__scanf(5, 6)
+int xenbus_scanf(xenhost_t *xh, struct xenbus_transaction t,
 		 const char *dir, const char *node, const char *fmt, ...);
 
 /* Read an (optional) unsigned value. */
-unsigned int xenbus_read_unsigned(const char *dir, const char *node,
+unsigned int xenbus_read_unsigned(xenhost_t *xh, const char *dir, const char *node,
 				  unsigned int default_val);
 
 /* Single printf and write: returns -errno or 0. */
-__printf(4, 5)
-int xenbus_printf(struct xenbus_transaction t,
+__printf(5, 6)
+int xenbus_printf(xenhost_t *xh, struct xenbus_transaction t,
 		  const char *dir, const char *node, const char *fmt, ...);
 
 /* Generic read function: NULL-terminated triples of name,
  * sprintf-style type string, and pointer. Returns 0 or errno.*/
-int xenbus_gather(struct xenbus_transaction t, const char *dir, ...);
+int xenbus_gather(xenhost_t *xh, struct xenbus_transaction t, const char *dir, ...);
 
 /* notifer routines for when the xenstore comes up */
-extern int xenstored_ready;
-int register_xenstore_notifier(struct notifier_block *nb);
-void unregister_xenstore_notifier(struct notifier_block *nb);
+int register_xenstore_notifier(xenhost_t *xh, struct notifier_block *nb);
+void unregister_xenstore_notifier(xenhost_t *xh, struct notifier_block *nb);
 
-int register_xenbus_watch(struct xenbus_watch *watch);
-void unregister_xenbus_watch(struct xenbus_watch *watch);
+int register_xenbus_watch(xenhost_t *xh, struct xenbus_watch *watch);
+void unregister_xenbus_watch(xenhost_t *xh, struct xenbus_watch *watch);
 void xs_suspend(void);
 void xs_resume(void);
 void xs_suspend_cancel(void);
 
 struct work_struct;
 
-void xenbus_probe(struct work_struct *);
+void __xenbus_probe(void *xs);
 
 #define XENBUS_IS_ERR_READ(str) ({			\
 	if (!IS_ERR(str) && strlen(str) == 0) {		\
@@ -218,7 +228,7 @@ int xenbus_unmap_ring(struct xenbus_device *dev,
 int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port);
 int xenbus_free_evtchn(struct xenbus_device *dev, int port);
 
-enum xenbus_state xenbus_read_driver_state(const char *path);
+enum xenbus_state xenbus_read_driver_state(struct xenbus_device *dev, const char *path);
 
 __printf(3, 4)
 void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt, ...);
@@ -230,7 +240,5 @@ int xenbus_dev_is_online(struct xenbus_device *dev);
 int xenbus_frontend_closed(struct xenbus_device *dev);
 
 extern const struct file_operations xen_xenbus_fops;
-extern struct xenstore_domain_interface *xen_store_interface;
-extern int xen_store_evtchn;
 
 #endif /* _XEN_XENBUS_H */
diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
index acee0c7872b6..91574ecaad6c 100644
--- a/include/xen/xenhost.h
+++ b/include/xen/xenhost.h
@@ -140,6 +140,9 @@ typedef struct {
 		void *gnttab_status_vm_area;
 		void *auto_xlat_grant_frames;
 	};
+
+	/* xenstore private state */
+	void *xenstore_private;
 } xenhost_t;
 
 typedef struct xenhost_ops {
@@ -228,6 +231,17 @@ typedef struct xenhost_ops {
 	int (*alloc_ballooned_pages)(xenhost_t *xh, int nr_pages, struct page **pages);
 	void (*free_ballooned_pages)(xenhost_t *xh, int nr_pages, struct page **pages);
 
+	/*
+	 * xenbus: as part of xenbus-init, frontend/backend need to talk to the
+	 * correct xenbus.  This might be a local xenstore (backend) or might
+	 * be a XS_PV/XS_HVM interface (frontend). We bootstrap these with
+	 * evtchn/gfn parameters from (*setup_xs)().
+	 *
+	 * Once done, stash the xenhost_t * in xen_bus_type, xenbus_device or
+	 * xenbus_watch and then the frontend and backend devices implicitly
+	 * use the correct interface.
+	 */
+	int (*setup_xs)(xenhost_t *xh);
 } xenhost_ops_t;
 
 extern xenhost_t *xh_default, *xh_remote;
@@ -279,4 +293,10 @@ static inline void xenhost_probe_vcpu_id(xenhost_t *xh, int cpu)
 	(xh->ops->probe_vcpu_id)(xh, cpu);
 }
 
+static inline void xenhost_setup_xs(xenhost_t *xh)
+{
+	if (xh)
+		(xh->ops->setup_xs)(xh);
+}
+
 #endif /* __XENHOST_H */
-- 
2.20.1

