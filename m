Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14036C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4D320856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GZlfsJfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfETHbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbfETHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fx0vPR8OlaArT6kYdrfo2v49y0lE5Fpq2yv/M0uX9Ro=; b=GZlfsJfpwqJDWTKCGB4SuaMAGm
        EEujl8ArbW1UJGE6wbkYCUB311NVGyO5jVgXjhr9PIQFgzCjcJW8syw9arb80wCMvR3tjX20B06GL
        ZlXPL96E+dWvwoZHR3QNDuxTwbYja+FCIcu41fh/1jDQ8lnJ0S4dvnrpVOIYw09M08VsbZ5FwtwGx
        fF4fh1xHDgjmNZLvCq56NRgYrHQzpRbeZ8qbBvc30Z56CnE2LFhcugb/5pEg3+e5UmMS39wS4RE9m
        5S+Q2M9/30nab5XdJXhdDCOZrFJz1wEC5Gf2DfujmdpVmKZRmckqR54jBuGGEJtqEeBhQEiIwas4v
        objJlFng==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSclL-0004Ih-7F; Mon, 20 May 2019 07:31:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/24] iommu/dma: Refactor iommu_dma_free
Date:   Mon, 20 May 2019 09:29:36 +0200
Message-Id: <20190520072948.11412-13-hch@lst.de>
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

From: Robin Murphy <robin.murphy@arm.com>

The freeing logic was made particularly horrible by part of it being
opaque to the arch wrapper, which led to a lot of convoluted repetition
to ensure each path did everything in the right order. Now that it's
all private, we can pick apart and consolidate the logically-distinct
steps of freeing the IOMMU mapping, the underlying pages, and the CPU
remap (if necessary) into something much more manageable.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[various cosmetic changes to the code flow]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 73 ++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5e0c8450fa0b..a288b3d366ae 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -935,6 +935,39 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 	__iommu_dma_unmap(dev, handle, size);
 }
 
+static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle, unsigned long attrs)
+{
+	size_t alloc_size = PAGE_ALIGN(size);
+	int count = alloc_size >> PAGE_SHIFT;
+	struct page *page = NULL, **pages = NULL;
+
+	__iommu_dma_unmap(dev, handle, size);
+
+	/* Non-coherent atomic allocation? Easy */
+	if (dma_free_from_pool(cpu_addr, alloc_size))
+		return;
+
+	if (is_vmalloc_addr(cpu_addr)) {
+		/*
+		 * If it the address is remapped, then it's either non-coherent
+		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
+		 */
+		pages = __iommu_dma_get_pages(cpu_addr);
+		if (!pages)
+			page = vmalloc_to_page(cpu_addr);
+		dma_common_free_remap(cpu_addr, alloc_size, VM_USERMAP);
+	} else {
+		/* Lowmem means a coherent atomic or CMA allocation */
+		page = virt_to_page(cpu_addr);
+	}
+
+	if (pages)
+		__iommu_dma_free_pages(pages, count);
+	if (page && !dma_release_from_contiguous(dev, page, count))
+		__free_pages(page, get_order(alloc_size));
+}
+
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
@@ -1004,46 +1037,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	return addr;
 }
 
-static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
-{
-	size_t iosize = size;
-
-	size = PAGE_ALIGN(size);
-	/*
-	 * @cpu_addr will be one of 4 things depending on how it was allocated:
-	 * - A remapped array of pages for contiguous allocations.
-	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
-	 *   non-atomic allocations.
-	 * - A non-cacheable alias from the atomic pool, for atomic
-	 *   allocations by non-coherent devices.
-	 * - A normal lowmem address, for atomic allocations by
-	 *   coherent devices.
-	 * Hence how dodgy the below logic looks...
-	 */
-	if (dma_in_atomic_pool(cpu_addr, size)) {
-		__iommu_dma_unmap(dev, handle, iosize);
-		dma_free_from_pool(cpu_addr, size);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		struct page *page = vmalloc_to_page(cpu_addr);
-
-		__iommu_dma_unmap(dev, handle, iosize);
-		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else if (is_vmalloc_addr(cpu_addr)){
-		struct page **pages = __iommu_dma_get_pages(cpu_addr);
-
-		if (!pages)
-			return;
-		__iommu_dma_unmap(dev, handle, iosize);
-		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
-	} else {
-		__iommu_dma_unmap(dev, handle, iosize);
-		__free_pages(virt_to_page(cpu_addr), get_order(size));
-	}
-}
-
 static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
 			      unsigned long pfn, size_t size)
 {
-- 
2.20.1

