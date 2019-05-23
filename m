Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E197BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E3221773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bkxFKXol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfEWHBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:01:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t/0Cka1byqukGvePTAFnylVRHiq4MYjOBkQdyrey9kc=; b=bkxFKXolH88PImrhAkuP2uS4ah
        pbOBKrjU6VoiXuftIMA1SMzOhbuL6CDYBhKn+wu9rbK8oYvBLs47KNm51X1jlaGiemEcs2TZ7BwSo
        0x9MW42b3165HOQ4fWPibGeFEAOl5lGDk/go4t5u5eXhAjeyMA6dRFvdL3g7dmSAY1/IWRjw0bH0P
        K/tTCBsE7AHLJhMAodmiTm4SdiobHDoLYiWd3DIlo/tNkd0zoPTitGKb0gmWJa+pi7TNOQcrdEOCB
        zZ1DnH4wJQbQFFwGOcKICfA1xy2y/9BUAEQ+K6f5C1beyXgqW2MIVRokkwvNcP546vih+v715A4zm
        4Kw8tzug==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThjE-00060F-4z; Thu, 23 May 2019 07:01:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 20/23] iommu/dma: Don't depend on CONFIG_DMA_DIRECT_REMAP
Date:   Thu, 23 May 2019 09:00:25 +0200
Message-Id: <20190523070028.7435-21-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523070028.7435-1-hch@lst.de>
References: <20190523070028.7435-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For entirely dma coherent architectures there is no requirement to ever
remap dma coherent allocation.  Move all the remap and pool code under
IS_ENABLED() checks and drop the Kconfig dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig     |  1 -
 drivers/iommu/dma-iommu.c | 16 +++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d6d063160dd6..83664db5221d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -97,7 +97,6 @@ config IOMMU_DMA
 	select IOMMU_IOVA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
-	depends on DMA_DIRECT_REMAP
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2797d10070..567c300d1926 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -927,10 +927,11 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 	struct page *page = NULL, **pages = NULL;
 
 	/* Non-coherent atomic allocation? Easy */
-	if (dma_free_from_pool(cpu_addr, alloc_size))
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    dma_free_from_pool(cpu_addr, alloc_size))
 		return;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		/*
 		 * If it the address is remapped, then it's either non-coherent
 		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
@@ -974,7 +975,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	if (!coherent || PageHighMem(page)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && (!coherent || PageHighMem(page))) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
@@ -1007,11 +1008,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	gfp |= __GFP_ZERO;
 
-	if (gfpflags_allow_blocking(gfp) &&
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
 
-	if (!gfpflags_allow_blocking(gfp) && !coherent)
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    !gfpflags_allow_blocking(gfp) && !coherent)
 		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
@@ -1044,7 +1046,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
 		if (pages)
@@ -1066,7 +1068,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
 		if (pages) {
-- 
2.20.1

