Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492C92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KrMRTWW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfC0IFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:05:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbfC0IFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jtx4Z3dpkCGhzgNC/TUwZTOr6JnUPAUkZlWzq1diKSY=; b=KrMRTWW2Us6Q9ACcXoSCi3aEY8
        j0ig4d+fCzyJRi2lpEzrwOopaeqdTHAy75di6Wulup2nOw/qNGJh8s4c9k4Rk/j7HnEm6eaOm7I9k
        JKZftMMmOwI2T6Scs8Kz6wngkIXGlcl+cwWmlxpdk8bH/PEr1tjzRqE/uocxyQnp6NMd1ZQr1tst4
        t4WM4nyAuJkLdjXrlva/faAwZRM7C8aLnc64xD7TC4f1Gq6ZrvxI8E8wEj2Sr6eGdmbfv/EbLEHRo
        CtfEvg29gSo+dZuoejECOGYBHU2/rP5sIfbZ8EXKJ7sgxHNbEdFzfWZpjAT9BRfoX2FQLXbVzeD7r
        gg8gh2kg==;
Received: from 213-225-14-48.nat.highway.a1.net ([213.225.14.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h93Z9-0006hA-5E; Wed, 27 Mar 2019 08:05:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] dma-iommu: refactor page array remap helpers
Date:   Wed, 27 Mar 2019 09:04:38 +0100
Message-Id: <20190327080448.5500-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the call to dma_common_pages_remap / dma_common_free_remap  into
__iommu_dma_alloc / __iommu_dma_free and rename those functions to
better describe what they do.  This keeps the functionality that
allocates and remaps a non-contigous array of pages nicely abstracted
out from the calling code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 75 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4d46beeea5b7..2013c650718a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -524,51 +524,57 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 }
 
 /**
- * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
+ * iommu_dma_free_remap - Free a buffer allocated by iommu_dma_alloc_remap
  * @dev: Device which owns this buffer
- * @pages: Array of buffer pages as returned by __iommu_dma_alloc()
  * @size: Size of buffer in bytes
+ * @cpu_address: Virtual address of the buffer
  * @handle: DMA address of buffer
  *
  * Frees both the pages associated with the buffer, and the array
  * describing them
  */
-static void __iommu_dma_free(struct device *dev, struct page **pages,
-		size_t size, dma_addr_t *handle)
+static void iommu_dma_free_remap(struct device *dev, size_t size,
+		void *cpu_addr, dma_addr_t dma_handle)
 {
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
-	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
-	*handle = DMA_MAPPING_ERROR;
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (WARN_ON(!area || !area->pages))
+		return;
+	__iommu_dma_unmap(iommu_get_dma_domain(dev), dma_handle, size);
+	__iommu_dma_free_pages(area->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
+	dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
 }
 
 /**
- * __iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
+ * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
  * @dev: Device to allocate memory for. Must be a real device
  *	 attached to an iommu_dma_domain
  * @size: Size of buffer in bytes
+ * @dma_handle: Out argument for allocated DMA handle
  * @gfp: Allocation flags
  * @attrs: DMA attributes for this allocation
- * @prot: IOMMU mapping flags
- * @handle: Out argument for allocated DMA handle
  *
  * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
  * but an IOMMU which supports smaller pages might not map the whole thing.
  *
- * Return: Array of struct page pointers describing the buffer,
- *	   or NULL on failure.
+ * Return: Mapped virtual address, or NULL on failure.
  */
-static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
-		gfp_t gfp, unsigned long attrs, int prot, dma_addr_t *handle)
+static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
+	bool coherent = dev_is_dma_coherent(dev);
+	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
 	struct page **pages;
 	struct sg_table sgt;
 	dma_addr_t iova;
-	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
+	void *vaddr;
 
-	*handle = DMA_MAPPING_ERROR;
+	*dma_handle = DMA_MAPPING_ERROR;
 
 	min_size = alloc_sizes & -alloc_sizes;
 	if (min_size < PAGE_SIZE) {
@@ -594,7 +600,7 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
 	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
 		goto out_free_iova;
 
-	if (!(prot & IOMMU_CACHE)) {
+	if (!(ioprot & IOMMU_CACHE)) {
 		struct scatterlist *sg;
 		int i;
 
@@ -602,14 +608,21 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
 			arch_dma_prep_coherent(sg_page(sg), sg->length);
 	}
 
-	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
+	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, ioprot)
 			< size)
 		goto out_free_sg;
 
-	*handle = iova;
+	vaddr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
+			__builtin_return_address(0));
+	if (!vaddr)
+		goto out_unmap;
+
+	*dma_handle = iova;
 	sg_free_table(&sgt);
-	return pages;
+	return vaddr;
 
+out_unmap:
+	__iommu_dma_unmap(domain, iova, size);
 out_free_sg:
 	sg_free_table(&sgt);
 out_free_iova:
@@ -1013,18 +1026,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 						    size >> PAGE_SHIFT);
 		}
 	} else {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page **pages;
-
-		pages = __iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
-					handle);
-		if (!pages)
-			return NULL;
-
-		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
-					      __builtin_return_address(0));
-		if (!addr)
-			__iommu_dma_free(dev, pages, iosize, handle);
+		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
 	return addr;
 }
@@ -1038,7 +1040,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	/*
 	 * @cpu_addr will be one of 4 things depending on how it was allocated:
 	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from __iommu_dma_alloc(), for all
+	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
 	 *   non-atomic allocations.
 	 * - A non-cacheable alias from the atomic pool, for atomic
 	 *   allocations by non-coherent devices.
@@ -1056,12 +1058,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
-		struct vm_struct *area = find_vm_area(cpu_addr);
-
-		if (WARN_ON(!area || !area->pages))
-			return;
-		__iommu_dma_free(dev, area->pages, iosize, &handle);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+		iommu_dma_free_remap(dev, iosize, cpu_addr, handle);
 	} else {
 		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
 		__free_pages(virt_to_page(cpu_addr), get_order(size));
-- 
2.20.1

