Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294F52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J6PSA23V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfC0IGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:06:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732747AbfC0IGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZUTNROb7mjJMav2h/QwSdTi3BJMeh0TMh0zzzyvz2jQ=; b=J6PSA23VSseL8pxvx0pVtX9kwu
        VoaR7zkK5Iqy9nyUYlKYVKbpjkbq3TXK5LLk+ED9RmemQ7QiWGdY+SPXcQtFtz/zeZAmHzqAyOzw4
        tN5MtAlBciw8ViqBfZ4L5EasGj+DC8di3l8uLpGLx26wm7neqL2fKpUbOKLqG0TLNENS/F89UiMkM
        RpmuIZk0m5zdkEPggCm0KZKubN/DCEUMb2I/r2PBG8Wt3Oauq3p/sGCbPS0VFS3OaGEHNZTnEd9r6
        Ne3weVkHz6JIL3lyT6IyKnnrivmY58wNJtHlC161NPbh1UUwc7QvAGGTrvQ0wzWcpSqilHhTDb9Al
        ZFvHbJUw==;
Received: from 213-225-14-48.nat.highway.a1.net ([213.225.14.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h93ZS-00073z-88; Wed, 27 Mar 2019 08:06:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] dma-iommu: don't depend on CONFIG_DMA_DIRECT_REMAP
Date:   Wed, 27 Mar 2019 09:04:45 +0100
Message-Id: <20190327080448.5500-19-hch@lst.de>
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

For entirely dma coherent architectures there is no requirement to ever
remap dma coherent allocation.  Move all the remap and pool code under
CONFIG_DMA_DIRECT_REMAP ifdefs, and drop the Kconfig dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/Kconfig     |  1 -
 drivers/iommu/dma-iommu.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bdc14baf2ee5..6f07f3b21816 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -95,7 +95,6 @@ config IOMMU_DMA
 	select IOMMU_API
 	select IOMMU_IOVA
 	select NEED_SG_DMA_LENGTH
-	depends on DMA_DIRECT_REMAP
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f65dd19b0953..092b689c1c54 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -500,6 +500,7 @@ static void *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
 	return page_address(page);
 }
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -782,6 +783,7 @@ static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
 				gfp, attrs);
 	return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
 }
+#endif /* CONFIG_DMA_DIRECT_REMAP */
 
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
@@ -1064,6 +1066,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	 */
 	gfp |= __GFP_ZERO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (!dev_is_dma_coherent(dev))
 		return iommu_dma_alloc_noncoherent(dev, size, dma_handle, gfp,
 				attrs);
@@ -1071,6 +1074,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 		return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+#endif
 
 	return iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
 }
@@ -1090,6 +1094,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	 *
 	 * Hence how dodgy the below logic looks...
 	 */
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (dma_in_atomic_pool(cpu_addr, PAGE_ALIGN(size))) {
 		iommu_dma_free_pool(dev, size, cpu_addr, dma_handle);
 		return;
@@ -1103,6 +1108,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		page = vmalloc_to_page(cpu_addr);
 		dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	iommu_dma_free_contiguous(dev, size, page, dma_handle);
@@ -1125,11 +1131,13 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 			return iommu_dma_mmap_remap(cpu_addr, size, vma);
 		pfn = vmalloc_to_pfn(cpu_addr);
 	} else
+#endif
 		pfn = page_to_pfn(virt_to_page(cpu_addr));
 
 	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
@@ -1143,11 +1151,13 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	if (is_vmalloc_addr(cpu_addr)) {
 		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 			return iommu_dma_get_sgtable_remap(sgt, cpu_addr, size);
 		page = vmalloc_to_page(cpu_addr);
 	} else
+#endif
 		page = virt_to_page(cpu_addr);
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-- 
2.20.1

