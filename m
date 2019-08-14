Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4D5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E412133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D/znYnV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfHNIAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:00:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfHNH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4sJ9dgtsUC7Ci1f0SdNsLJkuIBkzca2k4D6PTH5Qbvc=; b=D/znYnV0I3O2TacWBvxIjKktVJ
        ON3aGDJeLV1KqzSGLA8rUTKXgzgbnYiSJN4BU07R4YKJ1a7yb1G8oOD8ITKLxh2I/035XkuM0VNJD
        ybQ1zcD7BJw5FATEfoGeRsqoiyoqV+mjLui7NDMVTq5WaWriD6TydoZoSfg4uaITb3UZYmjwFsawu
        jCdxQBbATYR/cuUdU+RX35jKjFSALBrmNZxEgzkQFbMPV2xF9+cRN1/3EatZaztRSt5tYGQGTgmIb
        5JvV++90mf7GdDAY2ofHbe+whhRAw/bwQN1U9ouc8oxpdTWJgMVi2lBZIJq30k129Pz9UMWOi56Hf
        8VGxMUyA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxoCE-00082k-FZ; Wed, 14 Aug 2019 07:59:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] nouveau: simplify nouveau_dmem_migrate_to_ram
Date:   Wed, 14 Aug 2019 09:59:24 +0200
Message-Id: <20190814075928.23766-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814075928.23766-1-hch@lst.de>
References: <20190814075928.23766-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor the main copy page to ram routine out into a helper that acts on
a single page and which doesn't require the nouveau_dmem_fault
structure for argument passing.  Also remove the loop over multiple
pages as we only handle one at the moment, although the structure of
the main worker function makes it relatively easy to add multi page
support back if needed in the future.  But at least for now this avoid
the needed to dynamically allocate memory for the dma addresses in
what is essentially the page fault path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 161 ++++++-------------------
 1 file changed, 40 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 21052a4aaf69..7dded864022c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -86,13 +86,6 @@ static inline struct nouveau_dmem *page_to_dmem(struct page *page)
 	return container_of(page->pgmap, struct nouveau_dmem, pagemap);
 }
 
-struct nouveau_dmem_fault {
-	struct nouveau_drm *drm;
-	struct nouveau_fence *fence;
-	dma_addr_t *dma;
-	unsigned long npages;
-};
-
 struct nouveau_migrate {
 	struct vm_area_struct *vma;
 	struct nouveau_drm *drm;
@@ -146,130 +139,55 @@ static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
 	}
 }
 
-static void
-nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
-				  const unsigned long *src_pfns,
-				  unsigned long *dst_pfns,
-				  unsigned long start,
-				  unsigned long end,
-				  struct nouveau_dmem_fault *fault)
+static vm_fault_t nouveau_dmem_fault_copy_one(struct nouveau_drm *drm,
+		struct vm_fault *vmf, struct migrate_vma *args,
+		dma_addr_t *dma_addr)
 {
-	struct nouveau_drm *drm = fault->drm;
 	struct device *dev = drm->dev->dev;
-	unsigned long addr, i, npages = 0;
-	nouveau_migrate_copy_t copy;
-	int ret;
-
-
-	/* First allocate new memory */
-	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
-		struct page *dpage, *spage;
-
-		dst_pfns[i] = 0;
-		spage = migrate_pfn_to_page(src_pfns[i]);
-		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
-			continue;
-
-		dpage = alloc_page_vma(GFP_HIGHUSER, vma, addr);
-		if (!dpage) {
-			dst_pfns[i] = MIGRATE_PFN_ERROR;
-			continue;
-		}
-		lock_page(dpage);
-
-		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage)) |
-			      MIGRATE_PFN_LOCKED;
-		npages++;
-	}
-
-	/* Allocate storage for DMA addresses, so we can unmap later. */
-	fault->dma = kmalloc(sizeof(*fault->dma) * npages, GFP_KERNEL);
-	if (!fault->dma)
-		goto error;
-
-	/* Copy things over */
-	copy = drm->dmem->migrate.copy_func;
-	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
-		struct page *spage, *dpage;
-
-		dpage = migrate_pfn_to_page(dst_pfns[i]);
-		if (!dpage || dst_pfns[i] == MIGRATE_PFN_ERROR)
-			continue;
-
-		spage = migrate_pfn_to_page(src_pfns[i]);
-		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
-			dst_pfns[i] = MIGRATE_PFN_ERROR;
-			__free_page(dpage);
-			continue;
-		}
+	struct page *dpage, *spage;
 
-		fault->dma[fault->npages] =
-			dma_map_page_attrs(dev, dpage, 0, PAGE_SIZE,
-					   PCI_DMA_BIDIRECTIONAL,
-					   DMA_ATTR_SKIP_CPU_SYNC);
-		if (dma_mapping_error(dev, fault->dma[fault->npages])) {
-			dst_pfns[i] = MIGRATE_PFN_ERROR;
-			__free_page(dpage);
-			continue;
-		}
-
-		ret = copy(drm, 1, NOUVEAU_APER_HOST,
-				fault->dma[fault->npages++],
-				NOUVEAU_APER_VRAM,
-				nouveau_dmem_page_addr(spage));
-		if (ret) {
-			dst_pfns[i] = MIGRATE_PFN_ERROR;
-			__free_page(dpage);
-			continue;
-		}
-	}
-
-	nouveau_fence_new(drm->dmem->migrate.chan, false, &fault->fence);
-
-	return;
-
-error:
-	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, ++i) {
-		struct page *page;
-
-		if (!dst_pfns[i] || dst_pfns[i] == MIGRATE_PFN_ERROR)
-			continue;
+	spage = migrate_pfn_to_page(args->src[0]);
+	if (!spage || !(args->src[0] & MIGRATE_PFN_MIGRATE))
+		return 0;
 
-		page = migrate_pfn_to_page(dst_pfns[i]);
-		dst_pfns[i] = MIGRATE_PFN_ERROR;
-		if (page == NULL)
-			continue;
+	dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
+	if (!dpage)
+		return VM_FAULT_SIGBUS;
+	lock_page(dpage);
 
-		__free_page(page);
-	}
-}
+	*dma_addr = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, *dma_addr))
+		goto error_free_page;
 
-static void
-nouveau_dmem_fault_finalize_and_map(struct nouveau_dmem_fault *fault)
-{
-	struct nouveau_drm *drm = fault->drm;
+	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_HOST, *dma_addr,
+			NOUVEAU_APER_VRAM, nouveau_dmem_page_addr(spage)))
+		goto error_dma_unmap;
 
-	nouveau_dmem_fence_done(&fault->fence);
+	args->dst[0] = migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+	return 0;
 
-	while (fault->npages--) {
-		dma_unmap_page(drm->dev->dev, fault->dma[fault->npages],
-			       PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-	}
-	kfree(fault->dma);
+error_dma_unmap:
+	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+error_free_page:
+	__free_page(dpage);
+	return VM_FAULT_SIGBUS;
 }
 
 static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 {
 	struct nouveau_dmem *dmem = page_to_dmem(vmf->page);
-	unsigned long src[1] = {0}, dst[1] = {0};
+	struct nouveau_drm *drm = dmem->drm;
+	struct nouveau_fence *fence;
+	unsigned long src = 0, dst = 0;
+	dma_addr_t dma_addr = 0;
+	vm_fault_t ret;
 	struct migrate_vma args = {
 		.vma		= vmf->vma,
 		.start		= vmf->address,
 		.end		= vmf->address + PAGE_SIZE,
-		.src		= src,
-		.dst		= dst,
+		.src		= &src,
+		.dst		= &dst,
 	};
-	struct nouveau_dmem_fault fault = { .drm = dmem->drm };
 
 	/*
 	 * FIXME what we really want is to find some heuristic to migrate more
@@ -281,16 +199,17 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	if (!args.cpages)
 		return 0;
 
-	nouveau_dmem_fault_alloc_and_copy(args.vma, src, dst, args.start,
-			args.end, &fault);
-	migrate_vma_pages(&args);
-	nouveau_dmem_fault_finalize_and_map(&fault);
+	ret = nouveau_dmem_fault_copy_one(drm, vmf, &args, &dma_addr);
+	if (ret || dst == 0)
+		goto done;
 
+	nouveau_fence_new(dmem->migrate.chan, false, &fence);
+	migrate_vma_pages(&args);
+	nouveau_dmem_fence_done(&fence);
+	dma_unmap_page(drm->dev->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+done:
 	migrate_vma_finalize(&args);
-	if (dst[0] == MIGRATE_PFN_ERROR)
-		return VM_FAULT_SIGBUS;
-
-	return 0;
+	return ret;
 }
 
 static const struct dev_pagemap_ops nouveau_dmem_pagemap_ops = {
-- 
2.20.1

