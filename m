Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DADC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F46220675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2uRpHG+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfEIR2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:28:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44072 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfEIR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:28:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJMtB162249;
        Thu, 9 May 2019 17:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=qADDO5XbYDC5p6Cw305RMwRKa5GuJxNYpTDOSlCGey4=;
 b=2uRpHG+0Oa6u+Fr3EJRP8c6OSt8R3D0E2fi3ueDJy/WY75/zcvKH1qnFqQHkZN6obTe6
 xRa9STbdfb1Rs08NkmQxncRDrgOPI28d374A7sJLGroeBuO7IW5AEZcB1V737YX6PG0A
 fR5Ihfeixd3mHNXgTYmhbMBstGkkV0DcrxGP1wgF50rxcH3rOT7DECAHHE4Sas+IEjev
 0rAa4A3046b5aWtMtUmFxir4DOV1YvM3oeUNR4b8ORMjd04nhT2pFehkrbjDlx/0UA22
 5qY69JwH4I5zMS7k3PKPEH7dCsw5UQ1URLRjDun8cYPxL1CsmX4xssEkgZ8uNkIgYFaS pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s94b6cf9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:27:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HP4lo119491;
        Thu, 9 May 2019 17:25:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2scpy5t23m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HPkFf019362;
        Thu, 9 May 2019 17:25:46 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:46 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 14/16] xen/blk: gnttab, evtchn, xenbus API changes
Date:   Thu,  9 May 2019 10:25:38 -0700
Message-Id: <20190509172540.12398-15-ankur.a.arora@oracle.com>
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

For the most part, we now pass xenhost_t * as a parameter.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/block/xen-blkback/blkback.c |  34 +++++----
 drivers/block/xen-blkback/common.h  |   2 +-
 drivers/block/xen-blkback/xenbus.c  |  63 ++++++++---------
 drivers/block/xen-blkfront.c        | 103 +++++++++++++++-------------
 4 files changed, 107 insertions(+), 95 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 7ad4423c24b8..d366a17a4bd8 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -142,7 +142,7 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
 		HZ * xen_blkif_pgrant_timeout);
 }
 
-static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
+static inline int get_free_page(xenhost_t *xh, struct xen_blkif_ring *ring, struct page **page)
 {
 	unsigned long flags;
 
@@ -150,7 +150,7 @@ static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
 	if (list_empty(&ring->free_pages)) {
 		BUG_ON(ring->free_pages_num != 0);
 		spin_unlock_irqrestore(&ring->free_pages_lock, flags);
-		return gnttab_alloc_pages(1, page);
+		return gnttab_alloc_pages(xh, 1, page);
 	}
 	BUG_ON(ring->free_pages_num == 0);
 	page[0] = list_first_entry(&ring->free_pages, struct page, lru);
@@ -174,7 +174,7 @@ static inline void put_free_pages(struct xen_blkif_ring *ring, struct page **pag
 	spin_unlock_irqrestore(&ring->free_pages_lock, flags);
 }
 
-static inline void shrink_free_pagepool(struct xen_blkif_ring *ring, int num)
+static inline void shrink_free_pagepool(xenhost_t *xh, struct xen_blkif_ring *ring, int num)
 {
 	/* Remove requested pages in batches of NUM_BATCH_FREE_PAGES */
 	struct page *page[NUM_BATCH_FREE_PAGES];
@@ -190,14 +190,14 @@ static inline void shrink_free_pagepool(struct xen_blkif_ring *ring, int num)
 		ring->free_pages_num--;
 		if (++num_pages == NUM_BATCH_FREE_PAGES) {
 			spin_unlock_irqrestore(&ring->free_pages_lock, flags);
-			gnttab_free_pages(num_pages, page);
+			gnttab_free_pages(xh, num_pages, page);
 			spin_lock_irqsave(&ring->free_pages_lock, flags);
 			num_pages = 0;
 		}
 	}
 	spin_unlock_irqrestore(&ring->free_pages_lock, flags);
 	if (num_pages != 0)
-		gnttab_free_pages(num_pages, page);
+		gnttab_free_pages(xh, num_pages, page);
 }
 
 #define vaddr(page) ((unsigned long)pfn_to_kaddr(page_to_pfn(page)))
@@ -301,8 +301,8 @@ static void put_persistent_gnt(struct xen_blkif_ring *ring,
 	atomic_dec(&ring->persistent_gnt_in_use);
 }
 
-static void free_persistent_gnts(struct xen_blkif_ring *ring, struct rb_root *root,
-                                 unsigned int num)
+static void free_persistent_gnts(xenhost_t *xh, struct xen_blkif_ring *ring,
+				struct rb_root *root, unsigned int num)
 {
 	struct gnttab_unmap_grant_ref unmap[BLKIF_MAX_SEGMENTS_PER_REQUEST];
 	struct page *pages[BLKIF_MAX_SEGMENTS_PER_REQUEST];
@@ -314,6 +314,7 @@ static void free_persistent_gnts(struct xen_blkif_ring *ring, struct rb_root *ro
 	unmap_data.pages = pages;
 	unmap_data.unmap_ops = unmap;
 	unmap_data.kunmap_ops = NULL;
+	unmap_data.xh = xh;
 
 	foreach_grant_safe(persistent_gnt, n, root, node) {
 		BUG_ON(persistent_gnt->handle ==
@@ -351,10 +352,12 @@ void xen_blkbk_unmap_purged_grants(struct work_struct *work)
 	int segs_to_unmap = 0;
 	struct xen_blkif_ring *ring = container_of(work, typeof(*ring), persistent_purge_work);
 	struct gntab_unmap_queue_data unmap_data;
+	struct xenbus_device *dev = xen_blkbk_xenbus(ring->blkif->be);
 
 	unmap_data.pages = pages;
 	unmap_data.unmap_ops = unmap;
 	unmap_data.kunmap_ops = NULL;
+	unmap_data.xh = dev->xh;
 
 	while(!list_empty(&ring->persistent_purge_list)) {
 		persistent_gnt = list_first_entry(&ring->persistent_purge_list,
@@ -615,6 +618,7 @@ int xen_blkif_schedule(void *arg)
 	struct xen_vbd *vbd = &blkif->vbd;
 	unsigned long timeout;
 	int ret;
+	struct xenbus_device *dev = xen_blkbk_xenbus(blkif->be);
 
 	set_freezable();
 	while (!kthread_should_stop()) {
@@ -657,7 +661,7 @@ int xen_blkif_schedule(void *arg)
 		}
 
 		/* Shrink if we have more than xen_blkif_max_buffer_pages */
-		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+		shrink_free_pagepool(dev->xh, ring, xen_blkif_max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
@@ -677,18 +681,18 @@ int xen_blkif_schedule(void *arg)
 /*
  * Remove persistent grants and empty the pool of free pages
  */
-void xen_blkbk_free_caches(struct xen_blkif_ring *ring)
+void xen_blkbk_free_caches(xenhost_t *xh, struct xen_blkif_ring *ring)
 {
 	/* Free all persistent grant pages */
 	if (!RB_EMPTY_ROOT(&ring->persistent_gnts))
-		free_persistent_gnts(ring, &ring->persistent_gnts,
+		free_persistent_gnts(xh, ring, &ring->persistent_gnts,
 			ring->persistent_gnt_c);
 
 	BUG_ON(!RB_EMPTY_ROOT(&ring->persistent_gnts));
 	ring->persistent_gnt_c = 0;
 
 	/* Since we are shutting down remove all pages from the buffer */
-	shrink_free_pagepool(ring, 0 /* All */);
+	shrink_free_pagepool(xh, ring, 0 /* All */);
 }
 
 static unsigned int xen_blkbk_unmap_prepare(
@@ -784,6 +788,7 @@ static void xen_blkbk_unmap(struct xen_blkif_ring *ring,
 	struct gnttab_unmap_grant_ref unmap[BLKIF_MAX_SEGMENTS_PER_REQUEST];
 	struct page *unmap_pages[BLKIF_MAX_SEGMENTS_PER_REQUEST];
 	unsigned int invcount = 0;
+	struct xenbus_device *dev = xen_blkbk_xenbus(ring->blkif->be);
 	int ret;
 
 	while (num) {
@@ -792,7 +797,7 @@ static void xen_blkbk_unmap(struct xen_blkif_ring *ring,
 		invcount = xen_blkbk_unmap_prepare(ring, pages, batch,
 						   unmap, unmap_pages);
 		if (invcount) {
-			ret = gnttab_unmap_refs(unmap, NULL, unmap_pages, invcount);
+			ret = gnttab_unmap_refs(dev->xh, unmap, NULL, unmap_pages, invcount);
 			BUG_ON(ret);
 			put_free_pages(ring, unmap_pages, invcount);
 		}
@@ -815,6 +820,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 	int last_map = 0, map_until = 0;
 	int use_persistent_gnts;
 	struct xen_blkif *blkif = ring->blkif;
+	struct xenbus_device *dev = xen_blkbk_xenbus(blkif->be); /* function call */
 
 	use_persistent_gnts = (blkif->vbd.feature_gnt_persistent);
 
@@ -841,7 +847,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			pages[i]->page = persistent_gnt->page;
 			pages[i]->persistent_gnt = persistent_gnt;
 		} else {
-			if (get_free_page(ring, &pages[i]->page))
+			if (get_free_page(dev->xh, ring, &pages[i]->page))
 				goto out_of_memory;
 			addr = vaddr(pages[i]->page);
 			pages_to_gnt[segs_to_map] = pages[i]->page;
@@ -859,7 +865,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 	}
 
 	if (segs_to_map) {
-		ret = gnttab_map_refs(map, NULL, pages_to_gnt, segs_to_map);
+		ret = gnttab_map_refs(dev->xh, map, NULL, pages_to_gnt, segs_to_map);
 		BUG_ON(ret);
 	}
 
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..633115888765 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -382,7 +382,7 @@ int xen_blkif_xenbus_init(void);
 irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
 int xen_blkif_schedule(void *arg);
 int xen_blkif_purge_persistent(void *arg);
-void xen_blkbk_free_caches(struct xen_blkif_ring *ring);
+void xen_blkbk_free_caches(xenhost_t *xh, struct xen_blkif_ring *ring);
 
 int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
 			      struct backend_info *be, int state);
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index beea4272cfd3..a3ed34269b23 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -65,7 +65,7 @@ static int blkback_name(struct xen_blkif *blkif, char *buf)
 	char *devpath, *devname;
 	struct xenbus_device *dev = blkif->be->dev;
 
-	devpath = xenbus_read(XBT_NIL, dev->nodename, "dev", NULL);
+	devpath = xenbus_read(dev->xh, XBT_NIL, dev->nodename, "dev", NULL);
 	if (IS_ERR(devpath))
 		return PTR_ERR(devpath);
 
@@ -246,6 +246,7 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 	struct pending_req *req, *n;
 	unsigned int j, r;
 	bool busy = false;
+	struct xenbus_device *dev = xen_blkbk_xenbus(blkif->be);
 
 	for (r = 0; r < blkif->nr_rings; r++) {
 		struct xen_blkif_ring *ring = &blkif->rings[r];
@@ -279,7 +280,7 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
 		}
 
 		/* Remove all persistent grants and the cache of ballooned pages. */
-		xen_blkbk_free_caches(ring);
+		xen_blkbk_free_caches(dev->xh, ring);
 
 		/* Check that there is no request in use */
 		list_for_each_entry_safe(req, n, &ring->pending_free, free_list) {
@@ -507,7 +508,7 @@ static int xen_blkbk_remove(struct xenbus_device *dev)
 		xenvbd_sysfs_delif(dev);
 
 	if (be->backend_watch.node) {
-		unregister_xenbus_watch(&be->backend_watch);
+		unregister_xenbus_watch(dev->xh, &be->backend_watch);
 		kfree(be->backend_watch.node);
 		be->backend_watch.node = NULL;
 	}
@@ -530,7 +531,7 @@ int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
 	struct xenbus_device *dev = be->dev;
 	int err;
 
-	err = xenbus_printf(xbt, dev->nodename, "feature-flush-cache",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-flush-cache",
 			    "%d", state);
 	if (err)
 		dev_warn(&dev->dev, "writing feature-flush-cache (%d)", err);
@@ -547,18 +548,18 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	struct block_device *bdev = be->blkif->vbd.bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (!xenbus_read_unsigned(dev->nodename, "discard-enable", 1))
+	if (!xenbus_read_unsigned(dev->xh, dev->nodename, "discard-enable", 1))
 		return;
 
 	if (blk_queue_discard(q)) {
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 			"discard-granularity", "%u",
 			q->limits.discard_granularity);
 		if (err) {
 			dev_warn(&dev->dev, "writing discard-granularity (%d)", err);
 			return;
 		}
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 			"discard-alignment", "%u",
 			q->limits.discard_alignment);
 		if (err) {
@@ -567,7 +568,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 		}
 		state = 1;
 		/* Optional. */
-		err = xenbus_printf(xbt, dev->nodename,
+		err = xenbus_printf(dev->xh, xbt, dev->nodename,
 				    "discard-secure", "%d",
 				    blkif->vbd.discard_secure);
 		if (err) {
@@ -575,7 +576,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 			return;
 		}
 	}
-	err = xenbus_printf(xbt, dev->nodename, "feature-discard",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-discard",
 			    "%d", state);
 	if (err)
 		dev_warn(&dev->dev, "writing feature-discard (%d)", err);
@@ -586,7 +587,7 @@ int xen_blkbk_barrier(struct xenbus_transaction xbt,
 	struct xenbus_device *dev = be->dev;
 	int err;
 
-	err = xenbus_printf(xbt, dev->nodename, "feature-barrier",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-barrier",
 			    "%d", state);
 	if (err)
 		dev_warn(&dev->dev, "writing feature-barrier (%d)", err);
@@ -625,7 +626,7 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 		goto fail;
 	}
 
-	err = xenbus_printf(XBT_NIL, dev->nodename,
+	err = xenbus_printf(dev->xh, XBT_NIL, dev->nodename,
 			    "feature-max-indirect-segments", "%u",
 			    MAX_INDIRECT_SEGMENTS);
 	if (err)
@@ -634,7 +635,7 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 			 dev->nodename, err);
 
 	/* Multi-queue: advertise how many queues are supported by us.*/
-	err = xenbus_printf(XBT_NIL, dev->nodename,
+	err = xenbus_printf(dev->xh, XBT_NIL, dev->nodename,
 			    "multi-queue-max-queues", "%u", xenblk_max_queues);
 	if (err)
 		pr_warn("Error writing multi-queue-max-queues\n");
@@ -647,7 +648,7 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	if (err)
 		goto fail;
 
-	err = xenbus_printf(XBT_NIL, dev->nodename, "max-ring-page-order", "%u",
+	err = xenbus_printf(dev->xh, XBT_NIL, dev->nodename, "max-ring-page-order", "%u",
 			    xen_blkif_max_ring_order);
 	if (err)
 		pr_warn("%s write out 'max-ring-page-order' failed\n", __func__);
@@ -685,7 +686,7 @@ static void backend_changed(struct xenbus_watch *watch,
 
 	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
 
-	err = xenbus_scanf(XBT_NIL, dev->nodename, "physical-device", "%x:%x",
+	err = xenbus_scanf(dev->xh, XBT_NIL, dev->nodename, "physical-device", "%x:%x",
 			   &major, &minor);
 	if (XENBUS_EXIST_ERR(err)) {
 		/*
@@ -707,7 +708,7 @@ static void backend_changed(struct xenbus_watch *watch,
 		return;
 	}
 
-	be->mode = xenbus_read(XBT_NIL, dev->nodename, "mode", NULL);
+	be->mode = xenbus_read(dev->xh, XBT_NIL, dev->nodename, "mode", NULL);
 	if (IS_ERR(be->mode)) {
 		err = PTR_ERR(be->mode);
 		be->mode = NULL;
@@ -715,7 +716,7 @@ static void backend_changed(struct xenbus_watch *watch,
 		return;
 	}
 
-	device_type = xenbus_read(XBT_NIL, dev->otherend, "device-type", NULL);
+	device_type = xenbus_read(dev->xh, XBT_NIL, dev->otherend, "device-type", NULL);
 	if (!IS_ERR(device_type)) {
 		cdrom = strcmp(device_type, "cdrom") == 0;
 		kfree(device_type);
@@ -849,7 +850,7 @@ static void connect(struct backend_info *be)
 
 	/* Supply the information about the device the frontend needs */
 again:
-	err = xenbus_transaction_start(&xbt);
+	err = xenbus_transaction_start(dev->xh, &xbt);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "starting transaction");
 		return;
@@ -862,14 +863,14 @@ static void connect(struct backend_info *be)
 
 	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
 
-	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "feature-persistent", "%u", 1);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "writing %s/feature-persistent",
 				 dev->nodename);
 		goto abort;
 	}
 
-	err = xenbus_printf(xbt, dev->nodename, "sectors", "%llu",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "sectors", "%llu",
 			    (unsigned long long)vbd_sz(&be->blkif->vbd));
 	if (err) {
 		xenbus_dev_fatal(dev, err, "writing %s/sectors",
@@ -878,7 +879,7 @@ static void connect(struct backend_info *be)
 	}
 
 	/* FIXME: use a typename instead */
-	err = xenbus_printf(xbt, dev->nodename, "info", "%u",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "info", "%u",
 			    be->blkif->vbd.type |
 			    (be->blkif->vbd.readonly ? VDISK_READONLY : 0));
 	if (err) {
@@ -886,7 +887,7 @@ static void connect(struct backend_info *be)
 				 dev->nodename);
 		goto abort;
 	}
-	err = xenbus_printf(xbt, dev->nodename, "sector-size", "%lu",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "sector-size", "%lu",
 			    (unsigned long)
 			    bdev_logical_block_size(be->blkif->vbd.bdev));
 	if (err) {
@@ -894,13 +895,13 @@ static void connect(struct backend_info *be)
 				 dev->nodename);
 		goto abort;
 	}
-	err = xenbus_printf(xbt, dev->nodename, "physical-sector-size", "%u",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "physical-sector-size", "%u",
 			    bdev_physical_block_size(be->blkif->vbd.bdev));
 	if (err)
 		xenbus_dev_error(dev, err, "writing %s/physical-sector-size",
 				 dev->nodename);
 
-	err = xenbus_transaction_end(xbt, 0);
+	err = xenbus_transaction_end(dev->xh, xbt, 0);
 	if (err == -EAGAIN)
 		goto again;
 	if (err)
@@ -913,7 +914,7 @@ static void connect(struct backend_info *be)
 
 	return;
  abort:
-	xenbus_transaction_end(xbt, 1);
+	xenbus_transaction_end(dev->xh, xbt, 1);
 }
 
 /*
@@ -928,7 +929,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 	struct xenbus_device *dev = blkif->be->dev;
 	unsigned int ring_page_order, nr_grefs, evtchn;
 
-	err = xenbus_scanf(XBT_NIL, dir, "event-channel", "%u",
+	err = xenbus_scanf(dev->xh, XBT_NIL, dir, "event-channel", "%u",
 			  &evtchn);
 	if (err != 1) {
 		err = -EINVAL;
@@ -936,10 +937,10 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 		return err;
 	}
 
-	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
+	err = xenbus_scanf(dev->xh, XBT_NIL, dev->otherend, "ring-page-order", "%u",
 			  &ring_page_order);
 	if (err != 1) {
-		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
+		err = xenbus_scanf(dev->xh, XBT_NIL, dir, "ring-ref", "%u", &ring_ref[0]);
 		if (err != 1) {
 			err = -EINVAL;
 			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
@@ -962,7 +963,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 			char ring_ref_name[RINGREF_NAME_LEN];
 
 			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
-			err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
+			err = xenbus_scanf(dev->xh, XBT_NIL, dir, ring_ref_name,
 					   "%u", &ring_ref[i]);
 			if (err != 1) {
 				err = -EINVAL;
@@ -1034,7 +1035,7 @@ static int connect_ring(struct backend_info *be)
 	pr_debug("%s %s\n", __func__, dev->otherend);
 
 	be->blkif->blk_protocol = BLKIF_PROTOCOL_DEFAULT;
-	err = xenbus_scanf(XBT_NIL, dev->otherend, "protocol",
+	err = xenbus_scanf(dev->xh, XBT_NIL, dev->otherend, "protocol",
 			   "%63s", protocol);
 	if (err <= 0)
 		strcpy(protocol, "unspecified, assuming default");
@@ -1048,7 +1049,7 @@ static int connect_ring(struct backend_info *be)
 		xenbus_dev_fatal(dev, err, "unknown fe protocol %s", protocol);
 		return -ENOSYS;
 	}
-	pers_grants = xenbus_read_unsigned(dev->otherend, "feature-persistent",
+	pers_grants = xenbus_read_unsigned(dev->xh, dev->otherend, "feature-persistent",
 					   0);
 	be->blkif->vbd.feature_gnt_persistent = pers_grants;
 	be->blkif->vbd.overflow_max_grants = 0;
@@ -1056,7 +1057,7 @@ static int connect_ring(struct backend_info *be)
 	/*
 	 * Read the number of hardware queues from frontend.
 	 */
-	requested_num_queues = xenbus_read_unsigned(dev->otherend,
+	requested_num_queues = xenbus_read_unsigned(dev->xh, dev->otherend,
 						    "multi-queue-num-queues",
 						    1);
 	if (requested_num_queues > xenblk_max_queues
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a06716424023..3929370d1f2f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -341,10 +341,11 @@ static struct grant *get_free_grant(struct blkfront_ring_info *rinfo)
 	return gnt_list_entry;
 }
 
-static inline void grant_foreign_access(const struct grant *gnt_list_entry,
+static inline void grant_foreign_access(xenhost_t *xh,
+					const struct grant *gnt_list_entry,
 					const struct blkfront_info *info)
 {
-	gnttab_page_grant_foreign_access_ref_one(gnt_list_entry->gref,
+	gnttab_page_grant_foreign_access_ref_one(xh, gnt_list_entry->gref,
 						 info->xbdev->otherend_id,
 						 gnt_list_entry->page,
 						 0);
@@ -361,13 +362,13 @@ static struct grant *get_grant(grant_ref_t *gref_head,
 		return gnt_list_entry;
 
 	/* Assign a gref to this page */
-	gnt_list_entry->gref = gnttab_claim_grant_reference(gref_head);
+	gnt_list_entry->gref = gnttab_claim_grant_reference(info->xbdev->xh, gref_head);
 	BUG_ON(gnt_list_entry->gref == -ENOSPC);
 	if (info->feature_persistent)
-		grant_foreign_access(gnt_list_entry, info);
+		grant_foreign_access(info->xbdev->xh, gnt_list_entry, info);
 	else {
 		/* Grant access to the GFN passed by the caller */
-		gnttab_grant_foreign_access_ref(gnt_list_entry->gref,
+		gnttab_grant_foreign_access_ref(info->xbdev->xh, gnt_list_entry->gref,
 						info->xbdev->otherend_id,
 						gfn, 0);
 	}
@@ -385,7 +386,7 @@ static struct grant *get_indirect_grant(grant_ref_t *gref_head,
 		return gnt_list_entry;
 
 	/* Assign a gref to this page */
-	gnt_list_entry->gref = gnttab_claim_grant_reference(gref_head);
+	gnt_list_entry->gref = gnttab_claim_grant_reference(info->xbdev->xh, gref_head);
 	BUG_ON(gnt_list_entry->gref == -ENOSPC);
 	if (!info->feature_persistent) {
 		struct page *indirect_page;
@@ -397,7 +398,7 @@ static struct grant *get_indirect_grant(grant_ref_t *gref_head,
 		list_del(&indirect_page->lru);
 		gnt_list_entry->page = indirect_page;
 	}
-	grant_foreign_access(gnt_list_entry, info);
+	grant_foreign_access(info->xbdev->xh, gnt_list_entry, info);
 
 	return gnt_list_entry;
 }
@@ -723,10 +724,10 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 	if (rinfo->persistent_gnts_c < max_grefs) {
 		new_persistent_gnts = true;
 
-		if (gnttab_alloc_grant_references(
+		if (gnttab_alloc_grant_references(info->xbdev->xh,
 		    max_grefs - rinfo->persistent_gnts_c,
 		    &setup.gref_head) < 0) {
-			gnttab_request_free_callback(
+			gnttab_request_free_callback(info->xbdev->xh,
 				&rinfo->callback,
 				blkif_restart_queue_callback,
 				rinfo,
@@ -835,7 +836,7 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		rinfo->shadow[extra_id].req = *extra_ring_req;
 
 	if (new_persistent_gnts)
-		gnttab_free_grant_references(setup.gref_head);
+		gnttab_free_grant_references(info->xbdev->xh, setup.gref_head);
 
 	return 0;
 }
@@ -1195,7 +1196,7 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 		struct blkfront_ring_info *rinfo = &info->rinfo[i];
 
 		/* No more gnttab callback work. */
-		gnttab_cancel_free_callback(&rinfo->callback);
+		gnttab_cancel_free_callback(info->xbdev->xh, &rinfo->callback);
 
 		/* Flush gnttab callback work. Must be done with no locks held. */
 		flush_work(&rinfo->work);
@@ -1265,7 +1266,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 					 &rinfo->grants, node) {
 			list_del(&persistent_gnt->node);
 			if (persistent_gnt->gref != GRANT_INVALID_REF) {
-				gnttab_end_foreign_access(persistent_gnt->gref,
+				gnttab_end_foreign_access(info->xbdev->xh, persistent_gnt->gref,
 							  0, 0UL);
 				rinfo->persistent_gnts_c--;
 			}
@@ -1289,7 +1290,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 		       rinfo->shadow[i].req.u.rw.nr_segments;
 		for (j = 0; j < segs; j++) {
 			persistent_gnt = rinfo->shadow[i].grants_used[j];
-			gnttab_end_foreign_access(persistent_gnt->gref, 0, 0UL);
+			gnttab_end_foreign_access(info->xbdev->xh, persistent_gnt->gref, 0, 0UL);
 			if (info->feature_persistent)
 				__free_page(persistent_gnt->page);
 			kfree(persistent_gnt);
@@ -1304,7 +1305,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 
 		for (j = 0; j < INDIRECT_GREFS(segs); j++) {
 			persistent_gnt = rinfo->shadow[i].indirect_grants[j];
-			gnttab_end_foreign_access(persistent_gnt->gref, 0, 0UL);
+			gnttab_end_foreign_access(info->xbdev->xh, persistent_gnt->gref, 0, 0UL);
 			__free_page(persistent_gnt->page);
 			kfree(persistent_gnt);
 		}
@@ -1319,7 +1320,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	}
 
 	/* No more gnttab callback work. */
-	gnttab_cancel_free_callback(&rinfo->callback);
+	gnttab_cancel_free_callback(info->xbdev->xh, &rinfo->callback);
 
 	/* Flush gnttab callback work. Must be done with no locks held. */
 	flush_work(&rinfo->work);
@@ -1327,7 +1328,7 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	/* Free resources associated with old device channel. */
 	for (i = 0; i < info->nr_ring_pages; i++) {
 		if (rinfo->ring_ref[i] != GRANT_INVALID_REF) {
-			gnttab_end_foreign_access(rinfo->ring_ref[i], 0, 0);
+			gnttab_end_foreign_access(info->xbdev->xh, rinfo->ring_ref[i], 0, 0);
 			rinfo->ring_ref[i] = GRANT_INVALID_REF;
 		}
 	}
@@ -1491,7 +1492,7 @@ static bool blkif_completion(unsigned long *id,
 	}
 	/* Add the persistent grant into the list of free grants */
 	for (i = 0; i < num_grant; i++) {
-		if (gnttab_query_foreign_access(s->grants_used[i]->gref)) {
+		if (gnttab_query_foreign_access(info->xbdev->xh, s->grants_used[i]->gref)) {
 			/*
 			 * If the grant is still mapped by the backend (the
 			 * backend has chosen to make this grant persistent)
@@ -1510,14 +1511,14 @@ static bool blkif_completion(unsigned long *id,
 			 * so it will not be picked again unless we run out of
 			 * persistent grants.
 			 */
-			gnttab_end_foreign_access(s->grants_used[i]->gref, 0, 0UL);
+			gnttab_end_foreign_access(info->xbdev->xh, s->grants_used[i]->gref, 0, 0UL);
 			s->grants_used[i]->gref = GRANT_INVALID_REF;
 			list_add_tail(&s->grants_used[i]->node, &rinfo->grants);
 		}
 	}
 	if (s->req.operation == BLKIF_OP_INDIRECT) {
 		for (i = 0; i < INDIRECT_GREFS(num_grant); i++) {
-			if (gnttab_query_foreign_access(s->indirect_grants[i]->gref)) {
+			if (gnttab_query_foreign_access(info->xbdev->xh, s->indirect_grants[i]->gref)) {
 				if (!info->feature_persistent)
 					pr_alert_ratelimited("backed has not unmapped grant: %u\n",
 							     s->indirect_grants[i]->gref);
@@ -1526,7 +1527,7 @@ static bool blkif_completion(unsigned long *id,
 			} else {
 				struct page *indirect_page;
 
-				gnttab_end_foreign_access(s->indirect_grants[i]->gref, 0, 0UL);
+				gnttab_end_foreign_access(info->xbdev->xh, s->indirect_grants[i]->gref, 0, 0UL);
 				/*
 				 * Add the used indirect page back to the list of
 				 * available pages for indirect grefs.
@@ -1726,9 +1727,10 @@ static int write_per_ring_nodes(struct xenbus_transaction xbt,
 	unsigned int i;
 	const char *message = NULL;
 	struct blkfront_info *info = rinfo->dev_info;
+	xenhost_t *xh = info->xbdev->xh;
 
 	if (info->nr_ring_pages == 1) {
-		err = xenbus_printf(xbt, dir, "ring-ref", "%u", rinfo->ring_ref[0]);
+		err = xenbus_printf(xh, xbt, dir, "ring-ref", "%u", rinfo->ring_ref[0]);
 		if (err) {
 			message = "writing ring-ref";
 			goto abort_transaction;
@@ -1738,7 +1740,7 @@ static int write_per_ring_nodes(struct xenbus_transaction xbt,
 			char ring_ref_name[RINGREF_NAME_LEN];
 
 			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
-			err = xenbus_printf(xbt, dir, ring_ref_name,
+			err = xenbus_printf(xh, xbt, dir, ring_ref_name,
 					    "%u", rinfo->ring_ref[i]);
 			if (err) {
 				message = "writing ring-ref";
@@ -1747,7 +1749,7 @@ static int write_per_ring_nodes(struct xenbus_transaction xbt,
 		}
 	}
 
-	err = xenbus_printf(xbt, dir, "event-channel", "%u", rinfo->evtchn);
+	err = xenbus_printf(xh, xbt, dir, "event-channel", "%u", rinfo->evtchn);
 	if (err) {
 		message = "writing event-channel";
 		goto abort_transaction;
@@ -1756,7 +1758,7 @@ static int write_per_ring_nodes(struct xenbus_transaction xbt,
 	return 0;
 
 abort_transaction:
-	xenbus_transaction_end(xbt, 1);
+	xenbus_transaction_end(xh, xbt, 1);
 	if (message)
 		xenbus_dev_fatal(info->xbdev, err, "%s", message);
 
@@ -1782,7 +1784,7 @@ static int talk_to_blkback(struct xenbus_device *dev,
 	if (!info)
 		return -ENODEV;
 
-	max_page_order = xenbus_read_unsigned(info->xbdev->otherend,
+	max_page_order = xenbus_read_unsigned(dev->xh, info->xbdev->otherend,
 					      "max-ring-page-order", 0);
 	ring_page_order = min(xen_blkif_max_ring_order, max_page_order);
 	info->nr_ring_pages = 1 << ring_page_order;
@@ -1801,14 +1803,14 @@ static int talk_to_blkback(struct xenbus_device *dev,
 	}
 
 again:
-	err = xenbus_transaction_start(&xbt);
+	err = xenbus_transaction_start(dev->xh, &xbt);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "starting transaction");
 		goto destroy_blkring;
 	}
 
 	if (info->nr_ring_pages > 1) {
-		err = xenbus_printf(xbt, dev->nodename, "ring-page-order", "%u",
+		err = xenbus_printf(dev->xh, xbt, dev->nodename, "ring-page-order", "%u",
 				    ring_page_order);
 		if (err) {
 			message = "writing ring-page-order";
@@ -1825,7 +1827,7 @@ static int talk_to_blkback(struct xenbus_device *dev,
 		char *path;
 		size_t pathsize;
 
-		err = xenbus_printf(xbt, dev->nodename, "multi-queue-num-queues", "%u",
+		err = xenbus_printf(dev->xh, xbt, dev->nodename, "multi-queue-num-queues", "%u",
 				    info->nr_rings);
 		if (err) {
 			message = "writing multi-queue-num-queues";
@@ -1851,19 +1853,19 @@ static int talk_to_blkback(struct xenbus_device *dev,
 		}
 		kfree(path);
 	}
-	err = xenbus_printf(xbt, dev->nodename, "protocol", "%s",
+	err = xenbus_printf(dev->xh, xbt, dev->nodename, "protocol", "%s",
 			    XEN_IO_PROTO_ABI_NATIVE);
 	if (err) {
 		message = "writing protocol";
 		goto abort_transaction;
 	}
-	err = xenbus_printf(xbt, dev->nodename,
+	err = xenbus_printf(dev->xh, xbt, dev->nodename,
 			    "feature-persistent", "%u", 1);
 	if (err)
 		dev_warn(&dev->dev,
 			 "writing persistent grants feature to xenbus");
 
-	err = xenbus_transaction_end(xbt, 0);
+	err = xenbus_transaction_end(dev->xh, xbt, 0);
 	if (err) {
 		if (err == -EAGAIN)
 			goto again;
@@ -1884,7 +1886,7 @@ static int talk_to_blkback(struct xenbus_device *dev,
 	return 0;
 
  abort_transaction:
-	xenbus_transaction_end(xbt, 1);
+	xenbus_transaction_end(dev->xh, xbt, 1);
 	if (message)
 		xenbus_dev_fatal(dev, err, "%s", message);
  destroy_blkring:
@@ -1907,7 +1909,7 @@ static int negotiate_mq(struct blkfront_info *info)
 	BUG_ON(info->nr_rings);
 
 	/* Check if backend supports multiple queues. */
-	backend_max_queues = xenbus_read_unsigned(info->xbdev->otherend,
+	backend_max_queues = xenbus_read_unsigned(info->xbdev->xh, info->xbdev->otherend,
 						  "multi-queue-max-queues", 1);
 	info->nr_rings = min(backend_max_queues, xen_blkif_max_queues);
 	/* We need at least one ring. */
@@ -1948,11 +1950,11 @@ static int blkfront_probe(struct xenbus_device *dev,
 	struct blkfront_info *info;
 
 	/* FIXME: Use dynamic device id if this is not set. */
-	err = xenbus_scanf(XBT_NIL, dev->nodename,
+	err = xenbus_scanf(dev->xh, XBT_NIL, dev->nodename,
 			   "virtual-device", "%i", &vdevice);
 	if (err != 1) {
 		/* go looking in the extended area instead */
-		err = xenbus_scanf(XBT_NIL, dev->nodename, "virtual-device-ext",
+		err = xenbus_scanf(dev->xh, XBT_NIL, dev->nodename, "virtual-device-ext",
 				   "%i", &vdevice);
 		if (err != 1) {
 			xenbus_dev_fatal(dev, err, "reading virtual-device");
@@ -1980,7 +1982,7 @@ static int blkfront_probe(struct xenbus_device *dev,
 			}
 		}
 		/* do not create a PV cdrom device if we are an HVM guest */
-		type = xenbus_read(XBT_NIL, dev->nodename, "device-type", &len);
+		type = xenbus_read(dev->xh, XBT_NIL, dev->nodename, "device-type", &len);
 		if (IS_ERR(type))
 			return -ENODEV;
 		if (strncmp(type, "cdrom", 5) == 0) {
@@ -2173,7 +2175,7 @@ static void blkfront_setup_discard(struct blkfront_info *info)
 	unsigned int discard_alignment;
 
 	info->feature_discard = 1;
-	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
+	err = xenbus_gather(info->xbdev->xh, XBT_NIL, info->xbdev->otherend,
 		"discard-granularity", "%u", &discard_granularity,
 		"discard-alignment", "%u", &discard_alignment,
 		NULL);
@@ -2182,7 +2184,7 @@ static void blkfront_setup_discard(struct blkfront_info *info)
 		info->discard_alignment = discard_alignment;
 	}
 	info->feature_secdiscard =
-		!!xenbus_read_unsigned(info->xbdev->otherend, "discard-secure",
+		!!xenbus_read_unsigned(info->xbdev->xh, info->xbdev->otherend, "discard-secure",
 				       0);
 }
 
@@ -2279,6 +2281,7 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo)
 static void blkfront_gather_backend_features(struct blkfront_info *info)
 {
 	unsigned int indirect_segments;
+	xenhost_t *xh = info->xbdev->xh;
 
 	info->feature_flush = 0;
 	info->feature_fua = 0;
@@ -2290,7 +2293,8 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 	 *
 	 * If there are barriers, then we use flush.
 	 */
-	if (xenbus_read_unsigned(info->xbdev->otherend, "feature-barrier", 0)) {
+	if (xenbus_read_unsigned(xh, info->xbdev->otherend,
+					"feature-barrier", 0)) {
 		info->feature_flush = 1;
 		info->feature_fua = 1;
 	}
@@ -2299,20 +2303,21 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 	 * And if there is "feature-flush-cache" use that above
 	 * barriers.
 	 */
-	if (xenbus_read_unsigned(info->xbdev->otherend, "feature-flush-cache",
-				 0)) {
+	if (xenbus_read_unsigned(xh, info->xbdev->otherend,
+					"feature-flush-cache", 0)) {
 		info->feature_flush = 1;
 		info->feature_fua = 0;
 	}
 
-	if (xenbus_read_unsigned(info->xbdev->otherend, "feature-discard", 0))
+	if (xenbus_read_unsigned(xh, info->xbdev->otherend,
+					"feature-discard", 0))
 		blkfront_setup_discard(info);
 
 	info->feature_persistent =
-		!!xenbus_read_unsigned(info->xbdev->otherend,
+		!!xenbus_read_unsigned(xh, info->xbdev->otherend,
 				       "feature-persistent", 0);
 
-	indirect_segments = xenbus_read_unsigned(info->xbdev->otherend,
+	indirect_segments = xenbus_read_unsigned(xh, info->xbdev->otherend,
 					"feature-max-indirect-segments", 0);
 	if (indirect_segments > xen_blkif_max_segments)
 		indirect_segments = xen_blkif_max_segments;
@@ -2346,7 +2351,7 @@ static void blkfront_connect(struct blkfront_info *info)
 		 * Potentially, the back-end may be signalling
 		 * a capacity change; update the capacity.
 		 */
-		err = xenbus_scanf(XBT_NIL, info->xbdev->otherend,
+		err = xenbus_scanf(info->xbdev->xh, XBT_NIL, info->xbdev->otherend,
 				   "sectors", "%Lu", &sectors);
 		if (XENBUS_EXIST_ERR(err))
 			return;
@@ -2375,7 +2380,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	dev_dbg(&info->xbdev->dev, "%s:%s.\n",
 		__func__, info->xbdev->otherend);
 
-	err = xenbus_gather(XBT_NIL, info->xbdev->otherend,
+	err = xenbus_gather(info->xbdev->xh, XBT_NIL, info->xbdev->otherend,
 			    "sectors", "%llu", &sectors,
 			    "info", "%u", &binfo,
 			    "sector-size", "%lu", &sector_size,
@@ -2392,7 +2397,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	 * provide this. Assume physical sector size to be the same as
 	 * sector_size in that case.
 	 */
-	physical_sector_size = xenbus_read_unsigned(info->xbdev->otherend,
+	physical_sector_size = xenbus_read_unsigned(info->xbdev->xh, info->xbdev->otherend,
 						    "physical-sector-size",
 						    sector_size);
 	blkfront_gather_backend_features(info);
@@ -2668,11 +2673,11 @@ static void purge_persistent_grants(struct blkfront_info *info)
 		list_for_each_entry_safe(gnt_list_entry, tmp, &rinfo->grants,
 					 node) {
 			if (gnt_list_entry->gref == GRANT_INVALID_REF ||
-			    gnttab_query_foreign_access(gnt_list_entry->gref))
+			    gnttab_query_foreign_access(info->xbdev->xh, gnt_list_entry->gref))
 				continue;
 
 			list_del(&gnt_list_entry->node);
-			gnttab_end_foreign_access(gnt_list_entry->gref, 0, 0UL);
+			gnttab_end_foreign_access(info->xbdev->xh, gnt_list_entry->gref, 0, 0UL);
 			rinfo->persistent_gnts_c--;
 			gnt_list_entry->gref = GRANT_INVALID_REF;
 			list_add_tail(&gnt_list_entry->node, &rinfo->grants);
-- 
2.20.1

