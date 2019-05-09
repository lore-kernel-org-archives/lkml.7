Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0093FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953E020675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fesHRt60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfEIR2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:28:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44074 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfEIR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:28:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJMt2162236;
        Thu, 9 May 2019 17:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=FvwJdH247VIR+T7d8TULPFfutaAeqdcje9WExwJ1RHc=;
 b=fesHRt605BuU7kaQjJ33JtffhGU3oVjx2bxIZ9mfdG91NgEWIx/1+mU9UWZtlJFS9iyf
 VGGdqwyyHULxcM+K/tsFE7hiSuv8WT+oBtvY6kb3epYjI07oH5lHqwpaL2FsTzFIJdjo
 Sm9yjcncu7QSNhdQuUInprQ39Ns7I/HkcaP9RR8HucQg+ri3KXLpM53+u2TYCqBOILVt
 oojaxNmtyEzMNzCsTHmSS1ZKPVQQJHXXXZzmIUu7ztx0WWoFPOWugfLtEN32IxrEu54F
 JHGpbSI5IrM8G9l0bPz2bIxsntzximkwF7olKmmQhWSl9KnaUOsZhNcnyz1axZ5rE5jg /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s94b6cf9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:27:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HNxqa109565;
        Thu, 9 May 2019 17:25:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2sagyvcg73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:48 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HPlha019366;
        Thu, 9 May 2019 17:25:47 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:47 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 15/16] xen/net: gnttab, evtchn, xenbus API changes
Date:   Thu,  9 May 2019 10:25:39 -0700
Message-Id: <20190509172540.12398-16-ankur.a.arora@oracle.com>
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

For the most part, we now pass xenhost_t * as parameter.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/net/xen-netback/hash.c      |   7 +-
 drivers/net/xen-netback/interface.c |   7 +-
 drivers/net/xen-netback/netback.c   |  11 +--
 drivers/net/xen-netback/rx.c        |   3 +-
 drivers/net/xen-netback/xenbus.c    |  81 +++++++++++-----------
 drivers/net/xen-netfront.c          | 102 +++++++++++++++-------------
 6 files changed, 117 insertions(+), 94 deletions(-)

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index 0ccb021f1e78..93a449571ef3 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -289,6 +289,8 @@ u32 xenvif_set_hash_flags(struct xenvif *vif, u32 flags)
 u32 xenvif_set_hash_key(struct xenvif *vif, u32 gref, u32 len)
 {
 	u8 *key = vif->hash.key;
+	struct xenbus_device *dev = xenvif_to_xenbus_device(vif);
+
 	struct gnttab_copy copy_op = {
 		.source.u.ref = gref,
 		.source.domid = vif->domid,
@@ -303,7 +305,7 @@ u32 xenvif_set_hash_key(struct xenvif *vif, u32 gref, u32 len)
 		return XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER;
 
 	if (copy_op.len != 0) {
-		gnttab_batch_copy(&copy_op, 1);
+		gnttab_batch_copy(dev->xh, &copy_op, 1);
 
 		if (copy_op.status != GNTST_okay)
 			return XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER;
@@ -334,6 +336,7 @@ u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
 			    u32 off)
 {
 	u32 *mapping = vif->hash.mapping[!vif->hash.mapping_sel];
+	struct xenbus_device *dev = xenvif_to_xenbus_device(vif);
 	unsigned int nr = 1;
 	struct gnttab_copy copy_op[2] = {{
 		.source.u.ref = gref,
@@ -363,7 +366,7 @@ u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
 	       vif->hash.size * sizeof(*mapping));
 
 	if (copy_op[0].len != 0) {
-		gnttab_batch_copy(copy_op, nr);
+		gnttab_batch_copy(dev->xh, copy_op, nr);
 
 		if (copy_op[0].status != GNTST_okay ||
 		    copy_op[nr - 1].status != GNTST_okay)
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 53d4e6351f1e..329a4c701042 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -519,6 +519,7 @@ struct xenvif *xenvif_alloc(struct device *parent, domid_t domid,
 int xenvif_init_queue(struct xenvif_queue *queue)
 {
 	int err, i;
+	struct xenbus_device *dev = xenvif_to_xenbus_device(queue->vif);
 
 	queue->credit_bytes = queue->remaining_credit = ~0UL;
 	queue->credit_usec  = 0UL;
@@ -542,7 +543,7 @@ int xenvif_init_queue(struct xenvif_queue *queue)
 	 * better enable it. The long term solution would be to use just a
 	 * bunch of valid page descriptors, without dependency on ballooning
 	 */
-	err = gnttab_alloc_pages(MAX_PENDING_REQS,
+	err = gnttab_alloc_pages(dev->xh, MAX_PENDING_REQS,
 				 queue->mmap_pages);
 	if (err) {
 		netdev_err(queue->vif->dev, "Could not reserve mmap_pages\n");
@@ -790,7 +791,9 @@ void xenvif_disconnect_ctrl(struct xenvif *vif)
  */
 void xenvif_deinit_queue(struct xenvif_queue *queue)
 {
-	gnttab_free_pages(MAX_PENDING_REQS, queue->mmap_pages);
+	struct xenbus_device *dev = xenvif_to_xenbus_device(queue->vif);
+
+	gnttab_free_pages(dev->xh, MAX_PENDING_REQS, queue->mmap_pages);
 }
 
 void xenvif_free(struct xenvif *vif)
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 80aae3a32c2a..055de62ecbf5 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1244,6 +1244,7 @@ static inline void xenvif_tx_dealloc_action(struct xenvif_queue *queue)
 	pending_ring_idx_t dc, dp;
 	u16 pending_idx, pending_idx_release[MAX_PENDING_REQS];
 	unsigned int i = 0;
+	struct xenbus_device *dev = xenvif_to_xenbus_device(queue->vif);
 
 	dc = queue->dealloc_cons;
 	gop = queue->tx_unmap_ops;
@@ -1280,7 +1281,7 @@ static inline void xenvif_tx_dealloc_action(struct xenvif_queue *queue)
 
 	if (gop - queue->tx_unmap_ops > 0) {
 		int ret;
-		ret = gnttab_unmap_refs(queue->tx_unmap_ops,
+		ret = gnttab_unmap_refs(dev->xh, queue->tx_unmap_ops,
 					NULL,
 					queue->pages_to_unmap,
 					gop - queue->tx_unmap_ops);
@@ -1310,6 +1311,7 @@ int xenvif_tx_action(struct xenvif_queue *queue, int budget)
 {
 	unsigned nr_mops, nr_cops = 0;
 	int work_done, ret;
+	struct xenbus_device *dev = xenvif_to_xenbus_device(queue->vif);
 
 	if (unlikely(!tx_work_todo(queue)))
 		return 0;
@@ -1319,9 +1321,9 @@ int xenvif_tx_action(struct xenvif_queue *queue, int budget)
 	if (nr_cops == 0)
 		return 0;
 
-	gnttab_batch_copy(queue->tx_copy_ops, nr_cops);
+	gnttab_batch_copy(dev->xh, queue->tx_copy_ops, nr_cops);
 	if (nr_mops != 0) {
-		ret = gnttab_map_refs(queue->tx_map_ops,
+		ret = gnttab_map_refs(dev->xh, queue->tx_map_ops,
 				      NULL,
 				      queue->pages_to_map,
 				      nr_mops);
@@ -1391,6 +1393,7 @@ void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx)
 {
 	int ret;
 	struct gnttab_unmap_grant_ref tx_unmap_op;
+	struct xenbus_device *dev = xenvif_to_xenbus_device(queue->vif);
 
 	gnttab_set_unmap_op(&tx_unmap_op,
 			    idx_to_kaddr(queue, pending_idx),
@@ -1398,7 +1401,7 @@ void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx)
 			    queue->grant_tx_handle[pending_idx]);
 	xenvif_grant_handle_reset(queue, pending_idx);
 
-	ret = gnttab_unmap_refs(&tx_unmap_op, NULL,
+	ret = gnttab_unmap_refs(dev->xh, &tx_unmap_op, NULL,
 				&queue->mmap_pages[pending_idx], 1);
 	if (ret) {
 		netdev_err(queue->vif->dev,
diff --git a/drivers/net/xen-netback/rx.c b/drivers/net/xen-netback/rx.c
index ef5887037b22..aa8fcbe315a6 100644
--- a/drivers/net/xen-netback/rx.c
+++ b/drivers/net/xen-netback/rx.c
@@ -134,8 +134,9 @@ static void xenvif_rx_copy_flush(struct xenvif_queue *queue)
 {
 	unsigned int i;
 	int notify;
+	struct xenbus_device *dev = xenvif_to_xenbus_device(queue->vif);
 
-	gnttab_batch_copy(queue->rx_copy.op, queue->rx_copy.num);
+	gnttab_batch_copy(dev->xh, queue->rx_copy.op, queue->rx_copy.num);
 
 	for (i = 0; i < queue->rx_copy.num; i++) {
 		struct gnttab_copy *op;
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index 2625740bdc4a..09316c221db9 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -257,7 +257,7 @@ static int netback_remove(struct xenbus_device *dev)
 	if (be->vif) {
 		kobject_uevent(&dev->dev.kobj, KOBJ_OFFLINE);
 		xen_unregister_watchers(be->vif);
-		xenbus_rm(XBT_NIL, dev->nodename, "hotplug-status");
+		xenbus_rm(dev->xh, XBT_NIL, dev->nodename, "hotplug-status");
 		xenvif_free(be->vif);
 		be->vif = NULL;
 	}
@@ -299,26 +299,26 @@ static int netback_probe(struct xenbus_device *dev,
 	sg = 1;
 
 	do {
-		err = xenbus_transaction_start(&xbt);
+		err = xenbus_transaction_start(dev->xh, &xbt);
 		if (err) {
 			xenbus_dev_fatal(dev, err, "starting transaction");
 			goto fail;
 		}
 
-		err = xenbus_printf(xbt, dev->nodename, "feature-sg", "%d", sg);
+		err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-sg", "%d", sg);
 		if (err) {
 			message = "writing feature-sg";
 			goto abort_transaction;
 		}
 
-		err = xenbus_printf(xbt, dev->nodename, "feature-gso-tcpv4",
+		err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-gso-tcpv4",
 				    "%d", sg);
 		if (err) {
 			message = "writing feature-gso-tcpv4";
 			goto abort_transaction;
 		}
 
-		err = xenbus_printf(xbt, dev->nodename, "feature-gso-tcpv6",
+		err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-gso-tcpv6",
 				    "%d", sg);
 		if (err) {
 			message = "writing feature-gso-tcpv6";
@@ -326,7 +326,7 @@ static int netback_probe(struct xenbus_device *dev,
 		}
 
 		/* We support partial checksum setup for IPv6 packets */
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 				    "feature-ipv6-csum-offload",
 				    "%d", 1);
 		if (err) {
@@ -335,7 +335,7 @@ static int netback_probe(struct xenbus_device *dev,
 		}
 
 		/* We support rx-copy path. */
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 				    "feature-rx-copy", "%d", 1);
 		if (err) {
 			message = "writing feature-rx-copy";
@@ -346,7 +346,7 @@ static int netback_probe(struct xenbus_device *dev,
 		 * We don't support rx-flip path (except old guests who don't
 		 * grok this feature flag).
 		 */
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 				    "feature-rx-flip", "%d", 0);
 		if (err) {
 			message = "writing feature-rx-flip";
@@ -354,14 +354,14 @@ static int netback_probe(struct xenbus_device *dev,
 		}
 
 		/* We support dynamic multicast-control. */
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 				    "feature-multicast-control", "%d", 1);
 		if (err) {
 			message = "writing feature-multicast-control";
 			goto abort_transaction;
 		}
 
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 				    "feature-dynamic-multicast-control",
 				    "%d", 1);
 		if (err) {
@@ -369,7 +369,7 @@ static int netback_probe(struct xenbus_device *dev,
 			goto abort_transaction;
 		}
 
-		err = xenbus_transaction_end(xbt, 0);
+		err = xenbus_transaction_end(dev->xh, xbt, 0);
 	} while (err == -EAGAIN);
 
 	if (err) {
@@ -381,25 +381,25 @@ static int netback_probe(struct xenbus_device *dev,
 	 * Split event channels support, this is optional so it is not
 	 * put inside the above loop.
 	 */
-	err = xenbus_printf(XBT_NIL, dev->nodename,
+	err = xenbus_printf(dev->xh, XBT_NIL, dev->nodename,
 			    "feature-split-event-channels",
 			    "%u", separate_tx_rx_irq);
 	if (err)
 		pr_debug("Error writing feature-split-event-channels\n");
 
 	/* Multi-queue support: This is an optional feature. */
-	err = xenbus_printf(XBT_NIL, dev->nodename,
+	err = xenbus_printf(dev->xh, XBT_NIL, dev->nodename,
 			    "multi-queue-max-queues", "%u", xenvif_max_queues);
 	if (err)
 		pr_debug("Error writing multi-queue-max-queues\n");
 
-	err = xenbus_printf(XBT_NIL, dev->nodename,
+	err = xenbus_printf(dev->xh, XBT_NIL, dev->nodename,
 			    "feature-ctrl-ring",
 			    "%u", true);
 	if (err)
 		pr_debug("Error writing feature-ctrl-ring\n");
 
-	script = xenbus_read(XBT_NIL, dev->nodename, "script", NULL);
+	script = xenbus_read(dev->xh, XBT_NIL, dev->nodename, "script", NULL);
 	if (IS_ERR(script)) {
 		err = PTR_ERR(script);
 		xenbus_dev_fatal(dev, err, "reading script");
@@ -417,7 +417,7 @@ static int netback_probe(struct xenbus_device *dev,
 	return 0;
 
 abort_transaction:
-	xenbus_transaction_end(xbt, 1);
+	xenbus_transaction_end(dev->xh, xbt, 1);
 	xenbus_dev_fatal(dev, err, "%s", message);
 fail:
 	pr_debug("failed\n");
@@ -459,7 +459,7 @@ static int backend_create_xenvif(struct backend_info *be)
 	if (be->vif != NULL)
 		return 0;
 
-	err = xenbus_scanf(XBT_NIL, dev->nodename, "handle", "%li", &handle);
+	err = xenbus_scanf(dev->xh, XBT_NIL, dev->nodename, "handle", "%li", &handle);
 	if (err != 1) {
 		xenbus_dev_fatal(dev, err, "reading handle");
 		return (err < 0) ? err : -EINVAL;
@@ -680,7 +680,7 @@ static void xen_net_read_rate(struct xenbus_device *dev,
 	*bytes = ~0UL;
 	*usec = 0;
 
-	ratestr = xenbus_read(XBT_NIL, dev->nodename, "rate", NULL);
+	ratestr = xenbus_read(dev->xh, XBT_NIL, dev->nodename, "rate", NULL);
 	if (IS_ERR(ratestr))
 		return;
 
@@ -710,7 +710,7 @@ static int xen_net_read_mac(struct xenbus_device *dev, u8 mac[])
 	char *s, *e, *macstr;
 	int i;
 
-	macstr = s = xenbus_read(XBT_NIL, dev->nodename, "mac", NULL);
+	macstr = s = xenbus_read(dev->xh, XBT_NIL, dev->nodename, "mac", NULL);
 	if (IS_ERR(macstr))
 		return PTR_ERR(macstr);
 
@@ -765,7 +765,7 @@ static int xen_register_credit_watch(struct xenbus_device *dev,
 	snprintf(node, maxlen, "%s/rate", dev->nodename);
 	vif->credit_watch.node = node;
 	vif->credit_watch.callback = xen_net_rate_changed;
-	err = register_xenbus_watch(&vif->credit_watch);
+	err = register_xenbus_watch(dev->xh, &vif->credit_watch);
 	if (err) {
 		pr_err("Failed to set watcher %s\n", vif->credit_watch.node);
 		kfree(node);
@@ -777,8 +777,9 @@ static int xen_register_credit_watch(struct xenbus_device *dev,
 
 static void xen_unregister_credit_watch(struct xenvif *vif)
 {
+	struct xenbus_device *dev = xenvif_to_xenbus_device(vif);
 	if (vif->credit_watch.node) {
-		unregister_xenbus_watch(&vif->credit_watch);
+		unregister_xenbus_watch(dev->xh, &vif->credit_watch);
 		kfree(vif->credit_watch.node);
 		vif->credit_watch.node = NULL;
 	}
@@ -791,7 +792,7 @@ static void xen_mcast_ctrl_changed(struct xenbus_watch *watch,
 					  mcast_ctrl_watch);
 	struct xenbus_device *dev = xenvif_to_xenbus_device(vif);
 
-	vif->multicast_control = !!xenbus_read_unsigned(dev->otherend,
+	vif->multicast_control = !!xenbus_read_unsigned(dev->xh, dev->otherend,
 					"request-multicast-control", 0);
 }
 
@@ -817,7 +818,7 @@ static int xen_register_mcast_ctrl_watch(struct xenbus_device *dev,
 		 dev->otherend);
 	vif->mcast_ctrl_watch.node = node;
 	vif->mcast_ctrl_watch.callback = xen_mcast_ctrl_changed;
-	err = register_xenbus_watch(&vif->mcast_ctrl_watch);
+	err = register_xenbus_watch(dev->xh, &vif->mcast_ctrl_watch);
 	if (err) {
 		pr_err("Failed to set watcher %s\n",
 		       vif->mcast_ctrl_watch.node);
@@ -830,8 +831,10 @@ static int xen_register_mcast_ctrl_watch(struct xenbus_device *dev,
 
 static void xen_unregister_mcast_ctrl_watch(struct xenvif *vif)
 {
+	struct xenbus_device *dev = xenvif_to_xenbus_device(vif);
+
 	if (vif->mcast_ctrl_watch.node) {
-		unregister_xenbus_watch(&vif->mcast_ctrl_watch);
+		unregister_xenbus_watch(dev->xh, &vif->mcast_ctrl_watch);
 		kfree(vif->mcast_ctrl_watch.node);
 		vif->mcast_ctrl_watch.node = NULL;
 	}
@@ -853,7 +856,7 @@ static void xen_unregister_watchers(struct xenvif *vif)
 static void unregister_hotplug_status_watch(struct backend_info *be)
 {
 	if (be->have_hotplug_status_watch) {
-		unregister_xenbus_watch(&be->hotplug_status_watch);
+		unregister_xenbus_watch(be->dev->xh, &be->hotplug_status_watch);
 		kfree(be->hotplug_status_watch.node);
 	}
 	be->have_hotplug_status_watch = 0;
@@ -869,7 +872,7 @@ static void hotplug_status_changed(struct xenbus_watch *watch,
 	char *str;
 	unsigned int len;
 
-	str = xenbus_read(XBT_NIL, be->dev->nodename, "hotplug-status", &len);
+	str = xenbus_read(be->dev->xh, XBT_NIL, be->dev->nodename, "hotplug-status", &len);
 	if (IS_ERR(str))
 		return;
 	if (len == sizeof("connected")-1 && !memcmp(str, "connected", len)) {
@@ -891,14 +894,14 @@ static int connect_ctrl_ring(struct backend_info *be)
 	unsigned int evtchn;
 	int err;
 
-	err = xenbus_scanf(XBT_NIL, dev->otherend,
+	err = xenbus_scanf(dev->xh, XBT_NIL, dev->otherend,
 			   "ctrl-ring-ref", "%u", &val);
 	if (err < 0)
 		goto done; /* The frontend does not have a control ring */
 
 	ring_ref = val;
 
-	err = xenbus_scanf(XBT_NIL, dev->otherend,
+	err = xenbus_scanf(dev->xh, XBT_NIL, dev->otherend,
 			   "event-channel-ctrl", "%u", &val);
 	if (err < 0) {
 		xenbus_dev_fatal(dev, err,
@@ -936,7 +939,7 @@ static void connect(struct backend_info *be)
 	/* Check whether the frontend requested multiple queues
 	 * and read the number requested.
 	 */
-	requested_num_queues = xenbus_read_unsigned(dev->otherend,
+	requested_num_queues = xenbus_read_unsigned(dev->xh, dev->otherend,
 					"multi-queue-num-queues", 1);
 	if (requested_num_queues > xenvif_max_queues) {
 		/* buggy or malicious guest */
@@ -1087,7 +1090,7 @@ static int connect_data_rings(struct backend_info *be,
 			 queue->id);
 	}
 
-	err = xenbus_gather(XBT_NIL, xspath,
+	err = xenbus_gather(dev->xh, XBT_NIL, xspath,
 			    "tx-ring-ref", "%lu", &tx_ring_ref,
 			    "rx-ring-ref", "%lu", &rx_ring_ref, NULL);
 	if (err) {
@@ -1098,11 +1101,11 @@ static int connect_data_rings(struct backend_info *be,
 	}
 
 	/* Try split event channels first, then single event channel. */
-	err = xenbus_gather(XBT_NIL, xspath,
+	err = xenbus_gather(dev->xh, XBT_NIL, xspath,
 			    "event-channel-tx", "%u", &tx_evtchn,
 			    "event-channel-rx", "%u", &rx_evtchn, NULL);
 	if (err < 0) {
-		err = xenbus_scanf(XBT_NIL, xspath,
+		err = xenbus_scanf(dev->xh, XBT_NIL, xspath,
 				   "event-channel", "%u", &tx_evtchn);
 		if (err < 0) {
 			xenbus_dev_fatal(dev, err,
@@ -1137,7 +1140,7 @@ static int read_xenbus_vif_flags(struct backend_info *be)
 	unsigned int rx_copy;
 	int err;
 
-	err = xenbus_scanf(XBT_NIL, dev->otherend, "request-rx-copy", "%u",
+	err = xenbus_scanf(dev->xh, XBT_NIL, dev->otherend, "request-rx-copy", "%u",
 			   &rx_copy);
 	if (err == -ENOENT) {
 		err = 0;
@@ -1151,7 +1154,7 @@ static int read_xenbus_vif_flags(struct backend_info *be)
 	if (!rx_copy)
 		return -EOPNOTSUPP;
 
-	if (!xenbus_read_unsigned(dev->otherend, "feature-rx-notify", 0)) {
+	if (!xenbus_read_unsigned(dev->xh, dev->otherend, "feature-rx-notify", 0)) {
 		/* - Reduce drain timeout to poll more frequently for
 		 *   Rx requests.
 		 * - Disable Rx stall detection.
@@ -1160,20 +1163,20 @@ static int read_xenbus_vif_flags(struct backend_info *be)
 		be->vif->stall_timeout = 0;
 	}
 
-	vif->can_sg = !!xenbus_read_unsigned(dev->otherend, "feature-sg", 0);
+	vif->can_sg = !!xenbus_read_unsigned(dev->xh, dev->otherend, "feature-sg", 0);
 
 	vif->gso_mask = 0;
 
-	if (xenbus_read_unsigned(dev->otherend, "feature-gso-tcpv4", 0))
+	if (xenbus_read_unsigned(dev->xh, dev->otherend, "feature-gso-tcpv4", 0))
 		vif->gso_mask |= GSO_BIT(TCPV4);
 
-	if (xenbus_read_unsigned(dev->otherend, "feature-gso-tcpv6", 0))
+	if (xenbus_read_unsigned(dev->xh, dev->otherend, "feature-gso-tcpv6", 0))
 		vif->gso_mask |= GSO_BIT(TCPV6);
 
-	vif->ip_csum = !xenbus_read_unsigned(dev->otherend,
+	vif->ip_csum = !xenbus_read_unsigned(dev->xh, dev->otherend,
 					     "feature-no-csum-offload", 0);
 
-	vif->ipv6_csum = !!xenbus_read_unsigned(dev->otherend,
+	vif->ipv6_csum = !!xenbus_read_unsigned(dev->xh, dev->otherend,
 						"feature-ipv6-csum-offload", 0);
 
 	return 0;
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index ee28e8b85406..71007ad822c0 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -285,6 +285,7 @@ static void xennet_alloc_rx_buffers(struct netfront_queue *queue)
 	RING_IDX req_prod = queue->rx.req_prod_pvt;
 	int notify;
 	int err = 0;
+	struct xenbus_device *dev = queue->info->xbdev;
 
 	if (unlikely(!netif_carrier_ok(queue->info->netdev)))
 		return;
@@ -309,14 +310,14 @@ static void xennet_alloc_rx_buffers(struct netfront_queue *queue)
 		BUG_ON(queue->rx_skbs[id]);
 		queue->rx_skbs[id] = skb;
 
-		ref = gnttab_claim_grant_reference(&queue->gref_rx_head);
+		ref = gnttab_claim_grant_reference(dev->xh, &queue->gref_rx_head);
 		WARN_ON_ONCE(IS_ERR_VALUE((unsigned long)(int)ref));
 		queue->grant_rx_ref[id] = ref;
 
 		page = skb_frag_page(&skb_shinfo(skb)->frags[0]);
 
 		req = RING_GET_REQUEST(&queue->rx, req_prod);
-		gnttab_page_grant_foreign_access_ref_one(ref,
+		gnttab_page_grant_foreign_access_ref_one(dev->xh, ref,
 							 queue->info->xbdev->otherend_id,
 							 page,
 							 0);
@@ -377,6 +378,7 @@ static void xennet_tx_buf_gc(struct netfront_queue *queue)
 	unsigned short id;
 	struct sk_buff *skb;
 	bool more_to_do;
+	struct xenbus_device *dev = queue->info->xbdev;
 
 	BUG_ON(!netif_carrier_ok(queue->info->netdev));
 
@@ -393,15 +395,15 @@ static void xennet_tx_buf_gc(struct netfront_queue *queue)
 
 			id  = txrsp->id;
 			skb = queue->tx_skbs[id].skb;
-			if (unlikely(gnttab_query_foreign_access(
+			if (unlikely(gnttab_query_foreign_access(dev->xh,
 				queue->grant_tx_ref[id]) != 0)) {
 				pr_alert("%s: warning -- grant still in use by backend domain\n",
 					 __func__);
 				BUG();
 			}
-			gnttab_end_foreign_access_ref(
+			gnttab_end_foreign_access_ref(dev->xh,
 				queue->grant_tx_ref[id], GNTMAP_readonly);
-			gnttab_release_grant_reference(
+			gnttab_release_grant_reference(dev->xh,
 				&queue->gref_tx_head, queue->grant_tx_ref[id]);
 			queue->grant_tx_ref[id] = GRANT_INVALID_REF;
 			queue->grant_tx_page[id] = NULL;
@@ -436,13 +438,14 @@ static void xennet_tx_setup_grant(unsigned long gfn, unsigned int offset,
 	struct page *page = info->page;
 	struct netfront_queue *queue = info->queue;
 	struct sk_buff *skb = info->skb;
+	struct xenbus_device *dev = queue->info->xbdev;
 
 	id = get_id_from_freelist(&queue->tx_skb_freelist, queue->tx_skbs);
 	tx = RING_GET_REQUEST(&queue->tx, queue->tx.req_prod_pvt++);
-	ref = gnttab_claim_grant_reference(&queue->gref_tx_head);
+	ref = gnttab_claim_grant_reference(dev->xh, &queue->gref_tx_head);
 	WARN_ON_ONCE(IS_ERR_VALUE((unsigned long)(int)ref));
 
-	gnttab_grant_foreign_access_ref(ref, queue->info->xbdev->otherend_id,
+	gnttab_grant_foreign_access_ref(dev->xh, ref, queue->info->xbdev->otherend_id,
 					gfn, GNTMAP_readonly);
 
 	queue->tx_skbs[id].skb = skb;
@@ -786,6 +789,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
 	struct xen_netif_rx_response *rx = &rinfo->rx;
 	struct xen_netif_extra_info *extras = rinfo->extras;
 	struct device *dev = &queue->info->netdev->dev;
+	struct xenbus_device *xdev = queue->info->xbdev;
 	RING_IDX cons = queue->rx.rsp_cons;
 	struct sk_buff *skb = xennet_get_rx_skb(queue, cons);
 	grant_ref_t ref = xennet_get_rx_ref(queue, cons);
@@ -823,10 +827,10 @@ static int xennet_get_responses(struct netfront_queue *queue,
 			goto next;
 		}
 
-		ret = gnttab_end_foreign_access_ref(ref, 0);
+		ret = gnttab_end_foreign_access_ref(xdev->xh, ref, 0);
 		BUG_ON(!ret);
 
-		gnttab_release_grant_reference(&queue->gref_rx_head, ref);
+		gnttab_release_grant_reference(xdev->xh, &queue->gref_rx_head, ref);
 
 		__skb_queue_tail(list, skb);
 
@@ -1130,6 +1134,7 @@ static void xennet_release_tx_bufs(struct netfront_queue *queue)
 {
 	struct sk_buff *skb;
 	int i;
+	struct xenbus_device *dev = queue->info->xbdev;
 
 	for (i = 0; i < NET_TX_RING_SIZE; i++) {
 		/* Skip over entries which are actually freelist references */
@@ -1138,7 +1143,7 @@ static void xennet_release_tx_bufs(struct netfront_queue *queue)
 
 		skb = queue->tx_skbs[i].skb;
 		get_page(queue->grant_tx_page[i]);
-		gnttab_end_foreign_access(queue->grant_tx_ref[i],
+		gnttab_end_foreign_access(dev->xh, queue->grant_tx_ref[i],
 					  GNTMAP_readonly,
 					  (unsigned long)page_address(queue->grant_tx_page[i]));
 		queue->grant_tx_page[i] = NULL;
@@ -1151,6 +1156,7 @@ static void xennet_release_tx_bufs(struct netfront_queue *queue)
 static void xennet_release_rx_bufs(struct netfront_queue *queue)
 {
 	int id, ref;
+	struct xenbus_device *dev = queue->info->xbdev;
 
 	spin_lock_bh(&queue->rx_lock);
 
@@ -1172,7 +1178,7 @@ static void xennet_release_rx_bufs(struct netfront_queue *queue)
 		 * foreign access is ended (which may be deferred).
 		 */
 		get_page(page);
-		gnttab_end_foreign_access(ref, 0,
+		gnttab_end_foreign_access(dev->xh, ref, 0,
 					  (unsigned long)page_address(page));
 		queue->grant_rx_ref[id] = GRANT_INVALID_REF;
 
@@ -1186,22 +1192,23 @@ static netdev_features_t xennet_fix_features(struct net_device *dev,
 	netdev_features_t features)
 {
 	struct netfront_info *np = netdev_priv(dev);
+	struct xenbus_device *xdev = np->xbdev;
 
 	if (features & NETIF_F_SG &&
-	    !xenbus_read_unsigned(np->xbdev->otherend, "feature-sg", 0))
+	    !xenbus_read_unsigned(xdev->xh, np->xbdev->otherend, "feature-sg", 0))
 		features &= ~NETIF_F_SG;
 
 	if (features & NETIF_F_IPV6_CSUM &&
-	    !xenbus_read_unsigned(np->xbdev->otherend,
+	    !xenbus_read_unsigned(xdev->xh, np->xbdev->otherend,
 				  "feature-ipv6-csum-offload", 0))
 		features &= ~NETIF_F_IPV6_CSUM;
 
 	if (features & NETIF_F_TSO &&
-	    !xenbus_read_unsigned(np->xbdev->otherend, "feature-gso-tcpv4", 0))
+	    !xenbus_read_unsigned(xdev->xh, np->xbdev->otherend, "feature-gso-tcpv4", 0))
 		features &= ~NETIF_F_TSO;
 
 	if (features & NETIF_F_TSO6 &&
-	    !xenbus_read_unsigned(np->xbdev->otherend, "feature-gso-tcpv6", 0))
+	    !xenbus_read_unsigned(xdev->xh, np->xbdev->otherend, "feature-gso-tcpv6", 0))
 		features &= ~NETIF_F_TSO6;
 
 	return features;
@@ -1375,17 +1382,18 @@ static int netfront_probe(struct xenbus_device *dev,
 	return 0;
 }
 
-static void xennet_end_access(int ref, void *page)
+static void xennet_end_access(xenhost_t *xh, int ref, void *page)
 {
 	/* This frees the page as a side-effect */
 	if (ref != GRANT_INVALID_REF)
-		gnttab_end_foreign_access(ref, 0, (unsigned long)page);
+		gnttab_end_foreign_access(xh, ref, 0, (unsigned long)page);
 }
 
 static void xennet_disconnect_backend(struct netfront_info *info)
 {
 	unsigned int i = 0;
 	unsigned int num_queues = info->netdev->real_num_tx_queues;
+	struct xenbus_device *dev = info->xbdev;
 
 	netif_carrier_off(info->netdev);
 
@@ -1408,12 +1416,12 @@ static void xennet_disconnect_backend(struct netfront_info *info)
 
 		xennet_release_tx_bufs(queue);
 		xennet_release_rx_bufs(queue);
-		gnttab_free_grant_references(queue->gref_tx_head);
-		gnttab_free_grant_references(queue->gref_rx_head);
+		gnttab_free_grant_references(dev->xh, queue->gref_tx_head);
+		gnttab_free_grant_references(dev->xh, queue->gref_rx_head);
 
 		/* End access and free the pages */
-		xennet_end_access(queue->tx_ring_ref, queue->tx.sring);
-		xennet_end_access(queue->rx_ring_ref, queue->rx.sring);
+		xennet_end_access(dev->xh, queue->tx_ring_ref, queue->tx.sring);
+		xennet_end_access(dev->xh, queue->rx_ring_ref, queue->rx.sring);
 
 		queue->tx_ring_ref = GRANT_INVALID_REF;
 		queue->rx_ring_ref = GRANT_INVALID_REF;
@@ -1443,7 +1451,7 @@ static int xen_net_read_mac(struct xenbus_device *dev, u8 mac[])
 	char *s, *e, *macstr;
 	int i;
 
-	macstr = s = xenbus_read(XBT_NIL, dev->nodename, "mac", NULL);
+	macstr = s = xenbus_read(dev->xh, XBT_NIL, dev->nodename, "mac", NULL);
 	if (IS_ERR(macstr))
 		return PTR_ERR(macstr);
 
@@ -1588,11 +1596,11 @@ static int setup_netfront(struct xenbus_device *dev,
 	 * granted pages because backend is not accessing it at this point.
 	 */
 alloc_evtchn_fail:
-	gnttab_end_foreign_access_ref(queue->rx_ring_ref, 0);
+	gnttab_end_foreign_access_ref(dev->xh, queue->rx_ring_ref, 0);
 grant_rx_ring_fail:
 	free_page((unsigned long)rxs);
 alloc_rx_ring_fail:
-	gnttab_end_foreign_access_ref(queue->tx_ring_ref, 0);
+	gnttab_end_foreign_access_ref(dev->xh, queue->tx_ring_ref, 0);
 grant_tx_ring_fail:
 	free_page((unsigned long)txs);
 fail:
@@ -1608,6 +1616,7 @@ static int xennet_init_queue(struct netfront_queue *queue)
 	unsigned short i;
 	int err = 0;
 	char *devid;
+	struct xenbus_device *dev = queue->info->xbdev;
 
 	spin_lock_init(&queue->tx_lock);
 	spin_lock_init(&queue->rx_lock);
@@ -1633,7 +1642,7 @@ static int xennet_init_queue(struct netfront_queue *queue)
 	}
 
 	/* A grant for every tx ring slot */
-	if (gnttab_alloc_grant_references(NET_TX_RING_SIZE,
+	if (gnttab_alloc_grant_references(dev->xh, NET_TX_RING_SIZE,
 					  &queue->gref_tx_head) < 0) {
 		pr_alert("can't alloc tx grant refs\n");
 		err = -ENOMEM;
@@ -1641,7 +1650,7 @@ static int xennet_init_queue(struct netfront_queue *queue)
 	}
 
 	/* A grant for every rx ring slot */
-	if (gnttab_alloc_grant_references(NET_RX_RING_SIZE,
+	if (gnttab_alloc_grant_references(dev->xh, NET_RX_RING_SIZE,
 					  &queue->gref_rx_head) < 0) {
 		pr_alert("can't alloc rx grant refs\n");
 		err = -ENOMEM;
@@ -1651,7 +1660,7 @@ static int xennet_init_queue(struct netfront_queue *queue)
 	return 0;
 
  exit_free_tx:
-	gnttab_free_grant_references(queue->gref_tx_head);
+	gnttab_free_grant_references(dev->xh, queue->gref_tx_head);
  exit:
 	return err;
 }
@@ -1685,14 +1694,14 @@ static int write_queue_xenstore_keys(struct netfront_queue *queue,
 	}
 
 	/* Write ring references */
-	err = xenbus_printf(*xbt, path, "tx-ring-ref", "%u",
+	err = xenbus_printf(dev->xh, *xbt, path, "tx-ring-ref", "%u",
 			queue->tx_ring_ref);
 	if (err) {
 		message = "writing tx-ring-ref";
 		goto error;
 	}
 
-	err = xenbus_printf(*xbt, path, "rx-ring-ref", "%u",
+	err = xenbus_printf(dev->xh, *xbt, path, "rx-ring-ref", "%u",
 			queue->rx_ring_ref);
 	if (err) {
 		message = "writing rx-ring-ref";
@@ -1704,7 +1713,7 @@ static int write_queue_xenstore_keys(struct netfront_queue *queue,
 	 */
 	if (queue->tx_evtchn == queue->rx_evtchn) {
 		/* Shared event channel */
-		err = xenbus_printf(*xbt, path,
+		err = xenbus_printf(dev->xh,*xbt, path,
 				"event-channel", "%u", queue->tx_evtchn);
 		if (err) {
 			message = "writing event-channel";
@@ -1712,14 +1721,14 @@ static int write_queue_xenstore_keys(struct netfront_queue *queue,
 		}
 	} else {
 		/* Split event channels */
-		err = xenbus_printf(*xbt, path,
+		err = xenbus_printf(dev->xh, *xbt, path,
 				"event-channel-tx", "%u", queue->tx_evtchn);
 		if (err) {
 			message = "writing event-channel-tx";
 			goto error;
 		}
 
-		err = xenbus_printf(*xbt, path,
+		err = xenbus_printf(dev->xh, *xbt, path,
 				"event-channel-rx", "%u", queue->rx_evtchn);
 		if (err) {
 			message = "writing event-channel-rx";
@@ -1810,12 +1819,12 @@ static int talk_to_netback(struct xenbus_device *dev,
 	info->netdev->irq = 0;
 
 	/* Check if backend supports multiple queues */
-	max_queues = xenbus_read_unsigned(info->xbdev->otherend,
+	max_queues = xenbus_read_unsigned(dev->xh, info->xbdev->otherend,
 					  "multi-queue-max-queues", 1);
 	num_queues = min(max_queues, xennet_max_queues);
 
 	/* Check feature-split-event-channels */
-	feature_split_evtchn = xenbus_read_unsigned(info->xbdev->otherend,
+	feature_split_evtchn = xenbus_read_unsigned(dev->xh, info->xbdev->otherend,
 					"feature-split-event-channels", 0);
 
 	/* Read mac addr. */
@@ -1847,16 +1856,16 @@ static int talk_to_netback(struct xenbus_device *dev,
 	}
 
 again:
-	err = xenbus_transaction_start(&xbt);
+	err = xenbus_transaction_start(dev->xh, &xbt);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "starting transaction");
 		goto destroy_ring;
 	}
 
-	if (xenbus_exists(XBT_NIL,
+	if (xenbus_exists(dev->xh, XBT_NIL,
 			  info->xbdev->otherend, "multi-queue-max-queues")) {
 		/* Write the number of queues */
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 				    "multi-queue-num-queues", "%u", num_queues);
 		if (err) {
 			message = "writing multi-queue-num-queues";
@@ -1879,45 +1888,45 @@ static int talk_to_netback(struct xenbus_device *dev,
 	}
 
 	/* The remaining keys are not queue-specific */
-	err = xenbus_printf(xbt, dev->nodename, "request-rx-copy", "%u",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "request-rx-copy", "%u",
 			    1);
 	if (err) {
 		message = "writing request-rx-copy";
 		goto abort_transaction;
 	}
 
-	err = xenbus_printf(xbt, dev->nodename, "feature-rx-notify", "%d", 1);
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-rx-notify", "%d", 1);
 	if (err) {
 		message = "writing feature-rx-notify";
 		goto abort_transaction;
 	}
 
-	err = xenbus_printf(xbt, dev->nodename, "feature-sg", "%d", 1);
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-sg", "%d", 1);
 	if (err) {
 		message = "writing feature-sg";
 		goto abort_transaction;
 	}
 
-	err = xenbus_printf(xbt, dev->nodename, "feature-gso-tcpv4", "%d", 1);
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-gso-tcpv4", "%d", 1);
 	if (err) {
 		message = "writing feature-gso-tcpv4";
 		goto abort_transaction;
 	}
 
-	err = xenbus_write(xbt, dev->nodename, "feature-gso-tcpv6", "1");
+	err = xenbus_write(dev->xh, xbt, dev->nodename, "feature-gso-tcpv6", "1");
 	if (err) {
 		message = "writing feature-gso-tcpv6";
 		goto abort_transaction;
 	}
 
-	err = xenbus_write(xbt, dev->nodename, "feature-ipv6-csum-offload",
+	err = xenbus_write(dev->xh, xbt, dev->nodename, "feature-ipv6-csum-offload",
 			   "1");
 	if (err) {
 		message = "writing feature-ipv6-csum-offload";
 		goto abort_transaction;
 	}
 
-	err = xenbus_transaction_end(xbt, 0);
+	err = xenbus_transaction_end(dev->xh, xbt, 0);
 	if (err) {
 		if (err == -EAGAIN)
 			goto again;
@@ -1930,7 +1939,7 @@ static int talk_to_netback(struct xenbus_device *dev,
  abort_transaction:
 	xenbus_dev_fatal(dev, err, "%s", message);
 abort_transaction_no_dev_fatal:
-	xenbus_transaction_end(xbt, 1);
+	xenbus_transaction_end(dev->xh, xbt, 1);
  destroy_ring:
 	xennet_disconnect_backend(info);
 	rtnl_lock();
@@ -1949,8 +1958,9 @@ static int xennet_connect(struct net_device *dev)
 	int err;
 	unsigned int j = 0;
 	struct netfront_queue *queue = NULL;
+	struct xenbus_device *xdev = np->xbdev;
 
-	if (!xenbus_read_unsigned(np->xbdev->otherend, "feature-rx-copy", 0)) {
+	if (!xenbus_read_unsigned(xdev->xh, np->xbdev->otherend, "feature-rx-copy", 0)) {
 		dev_info(&dev->dev,
 			 "backend does not support copying receive path\n");
 		return -ENODEV;
-- 
2.20.1

