Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672A5C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F11C21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbfGRGwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:52:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbfGRGw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1D4BAE47;
        Thu, 18 Jul 2019 06:52:26 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 2/2] xen/gntdev: switch from kcalloc() to kvcalloc()
Date:   Thu, 18 Jul 2019 08:52:22 +0200
Message-Id: <20190718065222.31310-3-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190718065222.31310-1-jgross@suse.com>
References: <20190718065222.31310-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sufficient many pages to map gntdev can reach order 9 allocation
sizes. As there is no need to have physically contiguous buffers switch
to kvcalloc() in order to avoid failing allocations.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/gntdev.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 23e21a9aedf7..961aa778312b 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -115,14 +115,14 @@ static void gntdev_free_map(struct gntdev_grant_map *map)
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
 
@@ -136,12 +136,12 @@ struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
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
+	add->kunmap_ops = kvcalloc(count, sizeof(add->kunmap_ops[0]), GFP_KERNEL);
+	add->pages     = kvcalloc(count, sizeof(add->pages[0]), GFP_KERNEL);
 	if (NULL == add->grants    ||
 	    NULL == add->map_ops   ||
 	    NULL == add->unmap_ops ||
@@ -160,8 +160,8 @@ struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
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

