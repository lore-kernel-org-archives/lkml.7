Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A99BC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03242187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfKGLPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:15:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:39068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388250AbfKGLPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:15:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BEBBDB3EB;
        Thu,  7 Nov 2019 11:15:48 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 2/2] xen/gntdev: switch from kcalloc() to kvcalloc()
Date:   Thu,  7 Nov 2019 12:15:46 +0100
Message-Id: <20191107111546.26579-3-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191107111546.26579-1-jgross@suse.com>
References: <20191107111546.26579-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sufficient many pages to map gntdev can reach order 9 allocation
sizes. As there is no need to have physically contiguous buffers switch
to kvcalloc() in order to avoid failing allocations.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/gntdev.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 0578d369e537..f1bc0d269e12 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -113,14 +113,14 @@ static void gntdev_free_map(struct gntdev_grant_map *map)
 		gnttab_free_pages(map->count, map->pages);
 
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
-	kfree(map->frames);
+	kvfree(map->frames);
 #endif
-	kfree(map->pages);
-	kfree(map->grants);
-	kfree(map->map_ops);
-	kfree(map->unmap_ops);
-	kfree(map->kmap_ops);
-	kfree(map->kunmap_ops);
+	kvfree(map->pages);
+	kvfree(map->grants);
+	kvfree(map->map_ops);
+	kvfree(map->unmap_ops);
+	kvfree(map->kmap_ops);
+	kvfree(map->kunmap_ops);
 	kfree(map);
 }
 
@@ -134,12 +134,13 @@ struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
 	if (NULL == add)
 		return NULL;
 
-	add->grants    = kcalloc(count, sizeof(add->grants[0]), GFP_KERNEL);
-	add->map_ops   = kcalloc(count, sizeof(add->map_ops[0]), GFP_KERNEL);
-	add->unmap_ops = kcalloc(count, sizeof(add->unmap_ops[0]), GFP_KERNEL);
-	add->kmap_ops  = kcalloc(count, sizeof(add->kmap_ops[0]), GFP_KERNEL);
-	add->kunmap_ops = kcalloc(count, sizeof(add->kunmap_ops[0]), GFP_KERNEL);
-	add->pages     = kcalloc(count, sizeof(add->pages[0]), GFP_KERNEL);
+	add->grants    = kvcalloc(count, sizeof(add->grants[0]), GFP_KERNEL);
+	add->map_ops   = kvcalloc(count, sizeof(add->map_ops[0]), GFP_KERNEL);
+	add->unmap_ops = kvcalloc(count, sizeof(add->unmap_ops[0]), GFP_KERNEL);
+	add->kmap_ops  = kvcalloc(count, sizeof(add->kmap_ops[0]), GFP_KERNEL);
+	add->kunmap_ops = kvcalloc(count,
+				   sizeof(add->kunmap_ops[0]), GFP_KERNEL);
+	add->pages     = kvcalloc(count, sizeof(add->pages[0]), GFP_KERNEL);
 	if (NULL == add->grants    ||
 	    NULL == add->map_ops   ||
 	    NULL == add->unmap_ops ||
@@ -158,8 +159,8 @@ struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
 	if (dma_flags & (GNTDEV_DMA_FLAG_WC | GNTDEV_DMA_FLAG_COHERENT)) {
 		struct gnttab_dma_alloc_args args;
 
-		add->frames = kcalloc(count, sizeof(add->frames[0]),
-				      GFP_KERNEL);
+		add->frames = kvcalloc(count, sizeof(add->frames[0]),
+				       GFP_KERNEL);
 		if (!add->frames)
 			goto err;
 
-- 
2.16.4

