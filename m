Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E146C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB87C217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3842AqDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfEIR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41858 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfEIRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:25:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJSBL162321;
        Thu, 9 May 2019 17:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Yk7rv8RXBJruI/gHyJZRpw6blRShhbnurNLnUDXHVG8=;
 b=3842AqDIae0mBybH8EwVXHVP7Az1QqpsCu9UqGSrKXcJdjk4pT/v3IY1JZLehGBTMQla
 Ka/PebsY9rjiZA9OjQPCy5SuDcUgDt2stmSliya0SqaaPfrEp87L7254aVOndOtu0YqW
 iP4oUPRJMH8OLN5ToG/AF2dxOU5EHpqaEbh+UkTOL8x/2Xn/kH+cmXBf7Mq6GfMlLEWA
 4sDsWHxYSbgvGIKi0z3gVlLt+XLIGgns8WyntldRhfU74w98YZsxxxJn4J0mtkmGArEr
 jALu42mtQ/i/knlbAB1R7AlwWXf9VeBShvck+EqMkMK7rFP2V2pW30stZCM0R8etoQQo Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s94b6cf0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HP7wJ152264;
        Thu, 9 May 2019 17:25:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2schvyy7xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49HPmEI031352;
        Thu, 9 May 2019 17:25:48 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:47 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 16/16] xen/grant-table: host_addr fixup in mapping on xenhost_r0
Date:   Thu,  9 May 2019 10:25:40 -0700
Message-Id: <20190509172540.12398-17-ankur.a.arora@oracle.com>
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

Xenhost type xenhost_r0 does not support standard GNTTABOP_map_grant_ref
semantics (map a gref onto a specified host_addr). That's because
since the hypervisor is local (same address space as the caller of
GNTTABOP_map_grant_ref), there is no external entity that could
map an arbitrary page underneath an arbitrary address.

To handle this, the GNTTABOP_map_grant_ref hypercall on xenhost_r0
treats the host_addr as an OUT parameter instead of IN and expects the
gnttab_map_refs() and similar to fixup any state that caches the
value of host_addr from before the hypercall.

Accordingly gnttab_map_refs() now adds two parameters, a fixup function
and a pointer to cached maps to fixup:
 int gnttab_map_refs(xenhost_t *xh, struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
-		    struct page **pages, unsigned int count)
+		    struct page **pages, gnttab_map_fixup_t map_fixup_fn,
+		    void **map_fixup[], unsigned int count)

The reason we use a fixup function and not an additional mapping op
in the xenhost_t is because, depending on the caller, what we are fixing
might be different: blkback, netback for instance cache host_addr in
via a struct page *, while __xenbus_map_ring() caches a phys_addr.

This patch fixes up xen-blkback and xen-gntdev drivers.

TODO:
  - also rewrite gnttab_batch_map() and __xenbus_map_ring().
  - modify xen-netback, scsiback, pciback etc

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/block/xen-blkback/blkback.c | 14 +++++++++++++-
 drivers/xen/gntdev.c                |  2 +-
 drivers/xen/grant-table.c           | 20 ++++++++++++++------
 include/xen/grant_table.h           | 11 ++++++++++-
 4 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index d366a17a4bd8..50ce40ba35e5 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -806,11 +806,18 @@ static void xen_blkbk_unmap(struct xen_blkif_ring *ring,
 	}
 }
 
+static void blkbk_map_fixup(uint64_t host_addr, void **fixup)
+{
+	struct page **pg = (struct page **)fixup;
+	*pg = virt_to_page(host_addr);
+}
+
 static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			 struct grant_page *pages[],
 			 int num, bool ro)
 {
 	struct gnttab_map_grant_ref map[BLKIF_MAX_SEGMENTS_PER_REQUEST];
+	struct page **map_fixup[BLKIF_MAX_SEGMENTS_PER_REQUEST];
 	struct page *pages_to_gnt[BLKIF_MAX_SEGMENTS_PER_REQUEST];
 	struct persistent_gnt *persistent_gnt = NULL;
 	phys_addr_t addr = 0;
@@ -858,6 +865,9 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			gnttab_set_map_op(&map[segs_to_map++], addr,
 					  flags, pages[i]->gref,
 					  blkif->domid);
+
+			if (gnttab_map_fixup(dev->xh))
+				  map_fixup[i] = &pages[i]->page;
 		}
 		map_until = i + 1;
 		if (segs_to_map == BLKIF_MAX_SEGMENTS_PER_REQUEST)
@@ -865,7 +875,9 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 	}
 
 	if (segs_to_map) {
-		ret = gnttab_map_refs(dev->xh, map, NULL, pages_to_gnt, segs_to_map);
+		ret = gnttab_map_refs(dev->xh, map, NULL, pages_to_gnt,
+			gnttab_map_fixup(dev->xh) ? blkbk_map_fixup : NULL,
+					(void ***) map_fixup, segs_to_map);
 		BUG_ON(ret);
 	}
 
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 40a42abe2dd0..32c6471834ba 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -342,7 +342,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 
 	pr_debug("map %d+%d\n", map->index, map->count);
 	err = gnttab_map_refs(xh, map->map_ops, use_ptemod ? map->kmap_ops : NULL,
-			map->pages, map->count);
+			map->pages, NULL, NULL, map->count);
 	if (err)
 		return err;
 
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 959b81ade113..2f3a0a4a2660 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1084,7 +1084,8 @@ void gnttab_foreach_grant(struct page **pages,
 
 int gnttab_map_refs(xenhost_t *xh, struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
-		    struct page **pages, unsigned int count)
+		    struct page **pages, gnttab_map_fixup_t map_fixup_fn,
+		    void **map_fixup[], unsigned int count)
 {
 	int i, ret;
 
@@ -1096,12 +1097,19 @@ int gnttab_map_refs(xenhost_t *xh, struct gnttab_map_grant_ref *map_ops,
 		switch (map_ops[i].status) {
 		case GNTST_okay:
 		{
-			struct xen_page_foreign *foreign;
+			if (!gnttab_map_fixup(xh)) {
+				struct xen_page_foreign *foreign;
 
-			SetPageForeign(pages[i]);
-			foreign = xen_page_foreign(pages[i]);
-			foreign->domid = map_ops[i].dom;
-			foreign->gref = map_ops[i].ref;
+				SetPageForeign(pages[i]);
+				foreign = xen_page_foreign(pages[i]);
+				foreign->domid = map_ops[i].dom;
+				foreign->gref = map_ops[i].ref;
+			} else {
+				pages[i] = virt_to_page(map_ops[i].host_addr);
+
+				if (map_fixup_fn)
+					map_fixup_fn(map_ops[i].host_addr, map_fixup[i]);
+			}
 			break;
 		}
 
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index 827b790199fb..14f7cc70cd01 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -219,9 +219,18 @@ int gnttab_dma_free_pages(xenhost_t *xh, struct gnttab_dma_alloc_args *args);
 int gnttab_pages_set_private(int nr_pages, struct page **pages);
 void gnttab_pages_clear_private(int nr_pages, struct page **pages);
 
+static inline bool
+gnttab_map_fixup(xenhost_t *xh)
+{
+	return xh->type == xenhost_r0;
+}
+
+typedef void (*gnttab_map_fixup_t)(uint64_t host_addr, void **map_fixup);
+
 int gnttab_map_refs(xenhost_t *xh, struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
-		    struct page **pages, unsigned int count);
+		    struct page **pages, gnttab_map_fixup_t map_fixup_fn,
+		    void **map_fixup[], unsigned int count);
 int gnttab_unmap_refs(xenhost_t *xh, struct gnttab_unmap_grant_ref *unmap_ops,
 		      struct gnttab_unmap_grant_ref *kunmap_ops,
 		      struct page **pages, unsigned int count);
-- 
2.20.1

