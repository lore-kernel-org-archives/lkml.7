Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CCEC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HA2k2u+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfETHbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731055AbfETHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hxhqCRUMar40pZ/yJbuAv8Q698ScXxbVeoXe6d65Urc=; b=HA2k2u+0n6cTkELvms7UJsq4VL
        OydGywakRC6pzPKcAwnNlQMu1lgHcEMQuut1Yz8hMksj3TBtGEPSm9277HT8DRlr2USfE8PcQBdUe
        hXDYqt3qxe2k/kSsdSG7O3nKyiQWJveo4a0oBPhnzRy3S+AiU7GDUTWg1iLQ5GDlYBZicK4wZNT/+
        6g74oi4miLr2LXRWac1LNa/PkowOkhQkQZkEmUdSJVyfLkeF8GtVp7rXTfGAtpfzTEsnGIoiwRRU4
        txM2cZLR844xzkLgAOfm9dN0iRw+HgcoAViCABIf+Zm/uka0YIFtN/WcBC6B8icOXpRW927fy0Bkx
        dHGkzNeQ==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hScli-0004vH-RC; Mon, 20 May 2019 07:31:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/24] iommu/dma: Don't depend on CONFIG_DMA_DIRECT_REMAP
Date:   Mon, 20 May 2019 09:29:45 +0200
Message-Id: <20190520072948.11412-22-hch@lst.de>
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
index 130e94477b6d..e559e43c8ac2 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -96,7 +96,6 @@ config IOMMU_DMA
 	select IOMMU_IOVA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
-	depends on DMA_DIRECT_REMAP
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 84150ca7b572..0aff220c4aed 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -942,10 +942,11 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
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
@@ -989,7 +990,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	if (!coherent || PageHighMem(page)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && (!coherent || PageHighMem(page))) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
@@ -1022,11 +1023,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
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
@@ -1058,7 +1060,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
 		if (pages)
@@ -1080,7 +1082,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
 		if (pages) {
-- 
2.20.1

