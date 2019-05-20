Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C3DC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EDA20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AATotP4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfETHbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfETHbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=117qtInUSRTjScTlp3+Hy7VbUwgEhdDFPvMFg6m2tcg=; b=AATotP4Wpdx1KhD+fcamjdNQN8
        D2vz0lUaOJbFTtpNwt6l6B9U3Y5gzFUanEN8NB5ny/THpB0VG3cpSmWZXE/OQ2e6N8zcOCamrcIpS
        te5/IR1xiLndcR5aqaoYUsl/tzE4ht/ILQB2lidDMOeaOjuS4qOySfcCyYxITgDKSPmrQNltpNOwe
        NDdZ8ApGA6+fyclJ5RlxVEmAPKhKDsQTAk20CvZcpwm1c5+JOZO8qoRP0RF8XOE/skpotiXp4JRLf
        II97i1V537caQFhcKOJmAUYxCm3t0kiR16x9ULK5AleT4a3VbjFLK0sJECqStdAaGeNqer/EB7yLe
        XPj1i7Ag==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSclG-0004FI-Ab; Mon, 20 May 2019 07:31:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/24] iommu/dma: Refactor the page array remapping allocator
Date:   Mon, 20 May 2019 09:29:34 +0200
Message-Id: <20190520072948.11412-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520072948.11412-1-hch@lst.de>
References: <20190520072948.11412-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the call to dma_common_pages_remap into __iommu_dma_alloc and
rename it to iommu_dma_alloc_remap.  This creates a self-contained
helper for remapped pages allocation and mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 54 +++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5e81165e6755..0ffb7805de77 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -564,9 +564,9 @@ static struct page **__iommu_dma_get_pages(void *cpu_addr)
 }
 
 /**
- * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
+ * iommu_dma_free - Free a buffer allocated by iommu_dma_alloc_remap()
  * @dev: Device which owns this buffer
- * @pages: Array of buffer pages as returned by __iommu_dma_alloc()
+ * @pages: Array of buffer pages as returned by __iommu_dma_alloc_remap()
  * @size: Size of buffer in bytes
  * @handle: DMA address of buffer
  *
@@ -582,33 +582,35 @@ static void __iommu_dma_free(struct device *dev, struct page **pages,
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
@@ -634,7 +636,7 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
 	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
 		goto out_free_iova;
 
-	if (!(prot & IOMMU_CACHE)) {
+	if (!(ioprot & IOMMU_CACHE)) {
 		struct scatterlist *sg;
 		int i;
 
@@ -642,14 +644,21 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
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
+	__iommu_dma_unmap(dev, iova, size);
 out_free_sg:
 	sg_free_table(&sgt);
 out_free_iova:
@@ -1008,18 +1017,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
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
@@ -1033,7 +1031,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	/*
 	 * @cpu_addr will be one of 4 things depending on how it was allocated:
 	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from __iommu_dma_alloc(), for all
+	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
 	 *   non-atomic allocations.
 	 * - A non-cacheable alias from the atomic pool, for atomic
 	 *   allocations by non-coherent devices.
-- 
2.20.1

