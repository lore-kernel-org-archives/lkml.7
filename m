Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49EFC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD6A206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AoRJtxHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfETHbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbfETHbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X/lbNoKXhKb9aKtxZyFYuZtuYqVbUfAbRDafxA8+tdY=; b=AoRJtxHb+KxzXGww6MjIu0Hoyi
        oBO1MspMfO6An4HuLMi6+DU4Pyr44Jr5TABZMVS34pgs/3Cj0BbuTRoRyoidPxd6wqEy2y6PWyYNG
        ArnZSNjjxX0Q+jPItvShOX7Y84JrCjJOYBxBmP/LAXkihbITPJIgRAQT00iUEzJKUUQwbedhMAjfi
        KTynMMu1gpIYbee5cqq2quAnw9hPJ0ICB5+wDxQidAZ39rwcNamm8TzT3DLSMA6/u8ZVRHy9BwZG4
        H4qzdPKc99OaxzVyoEoTycQbNNL4umkhO7byCtTJxWiNXXt9YS5yyBFacq8uAGBOyehzGZXSpxE0W
        pEFJH4hA==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSclB-000481-0a; Mon, 20 May 2019 07:31:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] iommu/dma: Squash __iommu_dma_{map,unmap}_page helpers
Date:   Mon, 20 May 2019 09:29:32 +0200
Message-Id: <20190520072948.11412-9-hch@lst.de>
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

The remaining internal callsites don't care about having prototypes
compatible with the relevant dma_map_ops callbacks, so the extra
level of indirection just wastes space and complictaes things.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6ece8f477fc8..498e319d6607 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -717,18 +717,6 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
 }
 
-static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, int prot)
-{
-	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
-}
-
-static void __iommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	__iommu_dma_unmap(dev, handle, size);
-}
-
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -974,7 +962,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		if (!addr)
 			return NULL;
 
-		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
+		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize,
+					  ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
 			if (coherent)
 				__free_pages(page, get_order(size));
@@ -991,7 +980,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		if (!page)
 			return NULL;
 
-		*handle = __iommu_dma_map_page(dev, page, 0, iosize, ioprot);
+		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
 			dma_release_from_contiguous(dev, page,
 						    size >> PAGE_SHIFT);
@@ -1005,7 +994,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 				arch_dma_prep_coherent(page, iosize);
 			memset(addr, 0, size);
 		} else {
-			__iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
+			__iommu_dma_unmap(dev, *handle, iosize);
 			dma_release_from_contiguous(dev, page,
 						    size >> PAGE_SHIFT);
 		}
@@ -1044,12 +1033,12 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 * Hence how dodgy the below logic looks...
 	 */
 	if (dma_in_atomic_pool(cpu_addr, size)) {
-		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
+		__iommu_dma_unmap(dev, handle, iosize);
 		dma_free_from_pool(cpu_addr, size);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
 		struct page *page = vmalloc_to_page(cpu_addr);
 
-		__iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
+		__iommu_dma_unmap(dev, handle, iosize);
 		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
@@ -1060,7 +1049,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		__iommu_dma_free(dev, area->pages, iosize, &handle);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
-		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
+		__iommu_dma_unmap(dev, handle, iosize);
 		__free_pages(virt_to_page(cpu_addr), get_order(size));
 	}
 }
-- 
2.20.1

