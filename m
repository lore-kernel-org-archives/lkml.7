Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E07DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDBD2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lcLl6T4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403885AbfHHPeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:34:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfHHPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j9hd1gXafoIFkJfnTboIp4tn+A5fZCyE7gPL7/ciKOg=; b=lcLl6T4UpCDHh7dI2F9DPsj0PQ
        +harwwfP67MkygSc8Qs6g0jkJMefWFP0J/mU23BwYC7VcgmiCWnjv4Cf3HP+2R34Wrg2U3CsVYKX3
        AhVaXxmACi7s3887jh66oun91w0jc8W36KqmKSnznDE0Ox8bZFRXLaY9GfzA713LUGyP7jRckcT+n
        Hh2qtY0CGL+Q1ffBBl9YlD9jiwVvCCwrajyJ3/c0FicdvML3darrFfiFabSZfj4pgj+Mt4E9XuZlq
        cqXd4RJzJCHP7javh8oWvmrddlrfQnSeERTP/Q2X2IQEGxS+TmIMh1eTjhuvJzQRRpP2jBNtl+559
        MPOhv18w==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkQr-0005FS-VU; Thu, 08 Aug 2019 15:34:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] nouveau: simplify nouveau_dmem_migrate_to_ram
Date:   Thu,  8 Aug 2019 18:33:43 +0300
Message-Id: <20190808153346.9061-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808153346.9061-1-hch@lst.de>
References: <20190808153346.9061-1-hch@lst.de>
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
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 159 +++++++------------------
 1 file changed, 40 insertions(+), 119 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 21052a4aaf69..473195762974 100644
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
@@ -146,130 +139,57 @@ static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
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
+	struct page *dpage, *spage;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
 
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
+	spage = migrate_pfn_to_page(args->src[0]);
+	if (!spage || !(args->src[0] & MIGRATE_PFN_MIGRATE))
+		return 0;
 
-	/* Allocate storage for DMA addresses, so we can unmap later. */
-	fault->dma = kmalloc(sizeof(*fault->dma) * npages, GFP_KERNEL);
-	if (!fault->dma)
+	dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
+	if (!dpage)
 		goto error;
+	lock_page(dpage);
 
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
-
-		fault->dma[fault->npages] =
-			dma_map_page_attrs(dev, dpage, 0, PAGE_SIZE,
-					   PCI_DMA_BIDIRECTIONAL,
-					   DMA_ATTR_SKIP_CPU_SYNC);
-		if (dma_mapping_error(dev, fault->dma[fault->npages])) {
-			dst_pfns[i] = MIGRATE_PFN_ERROR;
-			__free_page(dpage);
-			continue;
-		}
+	*dma_addr = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, *dma_addr))
+		goto error_free_page;
 
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
+	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_HOST, *dma_addr,
+			NOUVEAU_APER_VRAM, nouveau_dmem_page_addr(spage)))
+		goto error_dma_unmap;
 
-	nouveau_fence_new(drm->dmem->migrate.chan, false, &fault->fence);
-
-	return;
+	args->dst[0] = migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
+	ret = 0;
 
+error_dma_unmap:
+	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
+error_free_page:
+	__free_page(dpage);
 error:
-	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, ++i) {
-		struct page *page;
-
-		if (!dst_pfns[i] || dst_pfns[i] == MIGRATE_PFN_ERROR)
-			continue;
-
-		page = migrate_pfn_to_page(dst_pfns[i]);
-		dst_pfns[i] = MIGRATE_PFN_ERROR;
-		if (page == NULL)
-			continue;
-
-		__free_page(page);
-	}
-}
-
-static void
-nouveau_dmem_fault_finalize_and_map(struct nouveau_dmem_fault *fault)
-{
-	struct nouveau_drm *drm = fault->drm;
-
-	nouveau_dmem_fence_done(&fault->fence);
-
-	while (fault->npages--) {
-		dma_unmap_page(drm->dev->dev, fault->dma[fault->npages],
-			       PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-	}
-	kfree(fault->dma);
+	return ret;
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
@@ -281,16 +201,17 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
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

