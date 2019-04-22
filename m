Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C1A21738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vEToXoqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDVSBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:01:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbfDVSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pCvPHNIJc+2XUkyhBlEJNWKVKvK8GagilonQxBslMQQ=; b=vEToXoqjQjq3J6LfKlYcyeLeu3
        woHeia27SMbTUuBvDMz7Rm+602KzjktwFQbQWPJ/AEWamhTbji+LccRshKzxTEVRyzBR+6sZEB5By
        Vk2ey5aym3V7TVP8wyV8vUrEop5NQK5t85mL2ZwpJX/gSk1P0ccHf/vuhjX5PFirIv1P5gtC9BUCU
        WwwArRxL0tLmBbiHdQaT4qV7BIMAQBK3l6IT9mErErAVU1xGKVuY61btSkBqQ/siQMKYzW8lhf9Ft
        urCwopjHV1svCLwCGJrMIF9YQ8kb2M+pt3I/66efxe6Wa7N2wAQSnSmoLte2g2EaUcsX3ruYw74ac
        fp1wOW7w==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIdFU-0002VE-Am; Mon, 22 Apr 2019 18:01:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/26] iommu/dma: Refactor iommu_dma_alloc, part 2
Date:   Mon, 22 Apr 2019 19:59:36 +0200
Message-Id: <20190422175942.18788-21-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422175942.18788-1-hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Apart from the iommu_dma_alloc_remap() case which remains sufficiently
different that it's better off being self-contained, the rest of the
logic can now be consolidated into a single flow which separates the
logcially-distinct steps of allocating pages, getting the CPU address,
and finally getting the IOMMU address.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: split the page allocation into a new helper to simplify the flow]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9b269f0792f3..acdfe866cb29 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -955,35 +955,14 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	__iommu_dma_free(dev, size, cpu_addr);
 }
 
-static void *iommu_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
+		struct page **pagep, gfp_t gfp, unsigned long attrs)
 {
 	bool coherent = dev_is_dma_coherent(dev);
-	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	size_t alloc_size = PAGE_ALIGN(size);
 	struct page *page = NULL;
 	void *cpu_addr;
 
-	gfp |= __GFP_ZERO;
-
-	if (gfpflags_allow_blocking(gfp) &&
-	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
-		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
-
-	if (!gfpflags_allow_blocking(gfp) && !coherent) {
-		cpu_addr = dma_alloc_from_pool(alloc_size, &page, gfp);
-		if (!cpu_addr)
-			return NULL;
-
-		*handle = __iommu_dma_map(dev, page_to_phys(page), size,
-					  ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			dma_free_from_pool(cpu_addr, alloc_size);
-			return NULL;
-		}
-		return cpu_addr;
-	}
-
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
 						 get_order(alloc_size),
@@ -993,33 +972,59 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
-	if (*handle == DMA_MAPPING_ERROR)
-		goto out_free_pages;
-
 	if (!coherent || PageHighMem(page)) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
 				VM_USERMAP, prot, __builtin_return_address(0));
 		if (!cpu_addr)
-			goto out_unmap;
+			goto out_free_pages;
 
 		if (!coherent)
 			arch_dma_prep_coherent(page, size);
 	} else {
 		cpu_addr = page_address(page);
 	}
+
+	*pagep = page;
 	memset(cpu_addr, 0, alloc_size);
 	return cpu_addr;
-out_unmap:
-	__iommu_dma_unmap(dev, *handle, size);
 out_free_pages:
 	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
 		__free_pages(page, get_order(alloc_size));
 	return NULL;
 }
 
+static void *iommu_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+{
+	bool coherent = dev_is_dma_coherent(dev);
+	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	struct page *page = NULL;
+	void *cpu_addr;
+
+	gfp |= __GFP_ZERO;
+
+	if (gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
+
+	if (!gfpflags_allow_blocking(gfp) && !coherent)
+		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+	else
+		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
+	if (!cpu_addr)
+		return NULL;
+
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
+	if (*handle == DMA_MAPPING_ERROR) {
+		__iommu_dma_free(dev, size, cpu_addr);
+		return NULL;
+	}
+
+	return cpu_addr;
+}
+
 static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
 			      unsigned long pfn, size_t size)
 {
-- 
2.20.1

