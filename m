Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B3EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E5520643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfDSTAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:00:09 -0400
Received: from verein.lst.de ([213.95.11.211]:56373 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfDSTAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:00:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 15E2C68BFE; Fri, 19 Apr 2019 10:23:49 +0200 (CEST)
Date:   Fri, 19 Apr 2019 10:23:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Message-ID: <20190419082348.GA22299@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de> <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com> <20190418163512.GA25347@lst.de> <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:15:00PM +0100, Robin Murphy wrote:
> Still, I've worked in the vm_map_pages() stuff pending in MM and given them 
> the same treatment to finish the picture. Both x86_64_defconfig and 
> i386_defconfig do indeed compile and link fine as I expected, so I really 
> would like to understand the concern around #ifdefs better.

This looks generally fine to me.  One thing I'd like to do is to
generally make use of the fact that __iommu_dma_get_pages returns NULL
for the force contigous case as that cleans up a few things.  Also
for the !DMA_REMAP case we need to try the page allocator when
dma_alloc_from_contiguous does not return a page.  What do you thing
of the following incremental diff?  If that is fine with you I can
fold that in and add back in the remaining patches from my series
not obsoleted by your patches and resend.


diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1bc8d1de1a1d..50b44e220de3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -894,7 +894,7 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 
 static void __iommu_dma_free(struct device *dev, void *cpu_addr, size_t size)
 {
-	struct page *page, **pages;
+	struct page *page = NULL;
 	int count = size >> PAGE_SHIFT;
 
 	/* Non-coherent atomic allocation? Easy */
@@ -902,24 +902,26 @@ static void __iommu_dma_free(struct device *dev, void *cpu_addr, size_t size)
 	    dma_free_from_pool(cpu_addr, size))
 		return;
 
-	/* Lowmem means a coherent atomic or CMA allocation */
-	if (!IS_ENABLED(CONFIG_DMA_REMAP) || !is_vmalloc_addr(cpu_addr)) {
-		page = virt_to_page(cpu_addr);
-		if (!dma_release_from_contiguous(dev, page, count))
-			__free_pages(page, get_order(size));
-		return;
-	}
-	/*
-	 * If it's remapped, then it's either non-coherent or highmem CMA, or
-	 * an iommu_dma_alloc_remap() construction.
-	 */
-	page = vmalloc_to_page(cpu_addr);
-	if (!dma_release_from_contiguous(dev, page, count)) {
-		pages = __iommu_dma_get_pages(cpu_addr);
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && is_vmalloc_addr(cpu_addr)) {
+		/*
+		 * If it the address is remapped, then it's either non-coherent
+		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
+		 */
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
+
 		if (pages)
 			__iommu_dma_free_pages(pages, count);
+		else
+			page = vmalloc_to_page(cpu_addr);
+
+		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+	} else {
+		/* Lowmem means a coherent atomic or CMA allocation */
+		page = virt_to_page(cpu_addr);
 	}
-	dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+
+	if (page && !dma_release_from_contiguous(dev, page, count))
+		__free_pages(page, get_order(size));
 }
 
 static void *iommu_dma_alloc(struct device *dev, size_t size,
@@ -935,25 +937,26 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	gfp |= __GFP_ZERO;
 
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
+
 	if (!gfpflags_allow_blocking(gfp)) {
-		if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !coherent)
+		if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !coherent) {
 			cpu_addr = dma_alloc_from_pool(alloc_size, &page, gfp);
-		else
-			page = alloc_pages(gfp, page_order);
-	} else if (!IS_ENABLED(CONFIG_DMA_REMAP) ||
-		   (attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
+			if (!cpu_addr)
+				return NULL;
+			goto do_iommu_map;
+		}
+	} else {
 		page = dma_alloc_from_contiguous(dev, count, page_order,
 						 gfp & __GFP_NOWARN);
-	} else {
-		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
 	}
-
+	if (!page)
+		page = alloc_pages(gfp, page_order);
 	if (!page)
 		return NULL;
 
-	if (cpu_addr)
-		goto do_iommu_map;
-
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && (!coherent || PageHighMem(page))) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
@@ -1007,16 +1010,14 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (!is_vmalloc_addr(cpu_addr)) {
-		pfn = page_to_pfn(virt_to_page(cpu_addr));
-	} else if (!IS_ENABLED(CONFIG_DMA_REMAP) ||
-		 (attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
+
+		if (pages)
+			return vm_map_pages(vma, pages, nr_pages);
 		pfn = vmalloc_to_pfn(cpu_addr);
 	} else {
-		struct page **pages = __iommu_dma_get_pages(cpu_addr);
-		if (!pages)
-			return -ENXIO;
-		return vm_map_pages(vma, pages, nr_pages);
+		pfn = page_to_pfn(virt_to_page(cpu_addr));
 	}
 
 	return remap_pfn_range(vma, vma->vm_start, pfn + off,
@@ -1028,26 +1029,25 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
-	struct page *page = NULL, **pages = NULL;
-	int ret = -ENXIO;
+	struct page *page;
+	int ret;
 
-	if (!is_vmalloc_addr(cpu_addr))
-		page = virt_to_page(cpu_addr);
-	else if (!IS_ENABLED(CONFIG_DMA_REMAP) ||
-		 (attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
+
+		if (pages)
+			return sg_alloc_table_from_pages(sgt,
+					__iommu_dma_get_pages(cpu_addr),
+					PAGE_ALIGN(size) >> PAGE_SHIFT, 0, size,
+					GFP_KERNEL);
 		page = vmalloc_to_page(cpu_addr);
-	else
-		pages = __iommu_dma_get_pages(cpu_addr);
-
-	if (page) {
-		ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-		if (!ret)
-			sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	} else if (pages) {
-		ret = sg_alloc_table_from_pages(sgt, pages,
-						PAGE_ALIGN(size) >> PAGE_SHIFT,
-						0, size, GFP_KERNEL);
+	} else {
+		page = virt_to_page(cpu_addr);
 	}
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
 	return ret;
 }
 
