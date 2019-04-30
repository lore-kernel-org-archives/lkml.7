Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C3C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F149321707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="umlyifbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfD3Kxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:53:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfD3Kxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W5OFZ0nXVCnRaKqTLxQ4iF6nubxh208Z3vdp8U1R4sM=; b=umlyifbbPBa2ph4J+SwIR/D2Xv
        mDs2Rsf7FRfW6vKBpTG3mzu3XK0kijknlAdJFEdtM1e1AhlJj4Awo2zobz9q5r9klVuT8OqjZH8UI
        +RwTFcofpN2htm0ofZtpwadnmGEH9leEUUP+uykwEyxhDK/NYOSGJEBwTXRgIM+AReSW5NDLEVZEL
        LslRbVR3J5LuxYcBZTC0C/LgiblrNkU0gU+vYqEpXDCtfplfumxNsnoovC+scgb3JSQxbLc+Gdkvk
        A2Ci8N/AkWyu4YaxF6B8w14fj9jigIessA6RjeuSQ6ehWFo28/7KpJoey3H4V0amlkiwCL3GVzqIv
        HlXDlzoA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQO4-00086S-Dr; Tue, 30 Apr 2019 10:53:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] iommu/dma: Refactor iommu_dma_mmap
Date:   Tue, 30 Apr 2019 06:52:10 -0400
Message-Id: <20190430105214.24628-22-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inline __iommu_dma_mmap_pfn into the main function, and use the
fact that __iommu_dma_get_pages return NULL for remapped contigous
allocations to simplify the code flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 46 ++++++++++-----------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5d4013ffd068..9ace9ad73e10 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1023,31 +1023,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	return cpu_addr;
 }
 
-static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
-			      unsigned long pfn, size_t size)
-{
-	int ret = -ENXIO;
-	unsigned long nr_vma_pages = vma_pages(vma);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-
-	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      vma->vm_end - vma->vm_start,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
-}
-
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-	struct page **pages;
+	unsigned long pfn, off = vma->vm_pgoff;
 	int ret;
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
@@ -1058,24 +1039,19 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (!is_vmalloc_addr(cpu_addr)) {
-		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
-		return __iommu_dma_mmap_pfn(vma, pfn, size);
-	}
+	if (is_vmalloc_addr(cpu_addr)) {
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
-		return __iommu_dma_mmap_pfn(vma, pfn, size);
+		if (pages)
+			return __iommu_dma_mmap(pages, size, vma);
+		pfn = vmalloc_to_pfn(cpu_addr);
+	} else {
+		pfn = page_to_pfn(virt_to_page(cpu_addr));
 	}
 
-	pages = __iommu_dma_get_pages(cpu_addr);
-	if (!pages)
-		return -ENXIO;
-	return __iommu_dma_mmap(pages, size, vma);
+	return remap_pfn_range(vma, vma->vm_start, pfn + off,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
 }
 
 static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
-- 
2.20.1

