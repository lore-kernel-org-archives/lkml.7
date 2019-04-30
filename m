Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BFC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6753221707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EC6v1Tdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfD3Kxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:53:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfD3Kx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rmuLwSYncpi3n4CrmHM33F2J2iZJVIYEy1EMwTwHe/w=; b=EC6v1Tdkm5p6ksCbfdb2vvFd59
        E5iANjP59q5i1RKhJ0dXazMTKVP66raHvjIbL0o6pMfTx5uZeb5MNZIdJZaYxWu/kQ847Nr/YaMhd
        7LBZY6VCf0M/RqimcxZWSRVSFnjgD5k716OCBlDNew4tVib7CJbDi54GeusIdXCmJsYpYY3bRN4zq
        6uwta/FMGiPgxuVSCLjclv7fbZj1EVV9R6+SBp9uIsdae39zBsZCpM5bleYX9ZEsfQZtsHT0h6XxV
        4zZ2MGroUDuHE3SkhlUo5aSVtiQDzY7+Rh5ugsCy2Yc2VJCHV7jgAMyCgq+RAanxYnYqe4U/1aS72
        2gae0C5w==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQO2-00083j-Kd; Tue, 30 Apr 2019 10:53:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] iommu/dma: Refactor iommu_dma_get_sgtable
Date:   Tue, 30 Apr 2019 06:52:09 -0400
Message-Id: <20190430105214.24628-21-hch@lst.de>
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

Inline __iommu_dma_get_sgtable_page into the main function, and use the
fact that __iommu_dma_get_pages return NULL for remapped contigous
allocations to simplify the code flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 45 +++++++++++++++------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index dc4bf41d0349..5d4013ffd068 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1078,42 +1078,31 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	return __iommu_dma_mmap(pages, size, vma);
 }
 
-static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
-		size_t size)
-{
-	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-
-	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return ret;
-}
-
 static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct page **pages;
+	struct page *page;
+	int ret;
 
-	if (!is_vmalloc_addr(cpu_addr)) {
-		struct page *page = virt_to_page(cpu_addr);
-		return __iommu_dma_get_sgtable_page(sgt, page, size);
-	}
+	if (is_vmalloc_addr(cpu_addr)) {
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		struct page *page = vmalloc_to_page(cpu_addr);
-		return __iommu_dma_get_sgtable_page(sgt, page, size);
+		if (pages) {
+			return sg_alloc_table_from_pages(sgt, pages,
+					PAGE_ALIGN(size) >> PAGE_SHIFT,
+					0, size, GFP_KERNEL);
+		}
+
+		page = vmalloc_to_page(cpu_addr);
+	} else {
+		page = virt_to_page(cpu_addr);
 	}
 
-	pages = __iommu_dma_get_pages(cpu_addr);
-	if (!pages)
-		return -ENXIO;
-	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
-					 GFP_KERNEL);
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
-- 
2.20.1

