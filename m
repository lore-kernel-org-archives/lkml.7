Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9DEC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98FC2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ki0jw+ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfEWHCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:02:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfEWHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NSNCQUYrnS6wDWHdm9NymWDh/Llkt3j/bdpHRBhch0U=; b=ki0jw+NDP1damW3Zkj3uPLULio
        hoYu1uv6dfwJ7/gUGEdFdL7pxCCJBnWb3px/bp3FwbaqE8uDE9sNJR0zAIM5EqmFvboQcCoE93BZ6
        KBxnAczDyE0WCnDccu/aHAhoKAspcDrRXAKH1t6iGc2XOlxPMuI6daqVGQPv+zSz3LLBpqruPUpC0
        HJ72n7zRZnreDxfR5KwuLO2M2kJntm7syXYbWNpG8Q56LaKxwMH7mVMFxVEIuVyI+Qa3UTzoZetU7
        ViNFmbyjJZk3a9fiqc4n6NG7sC3oNUwlRmYmpaDwyP+MNaDTPCDtyC2eC9/OcuPBHaexYEKpfztlx
        FXT3XVRA==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThia-0004x9-HI; Thu, 23 May 2019 07:00:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/23] iommu/dma: Move domain lookup into __iommu_dma_{map,unmap}
Date:   Thu, 23 May 2019 09:00:11 +0200
Message-Id: <20190523070028.7435-7-hch@lst.de>
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

From: Robin Murphy <robin.murphy@arm.com>

Most of the callers don't care, and the couple that do already have the
domain to hand for other reasons are in slow paths where the (trivial)
overhead of a repeated lookup will be utterly immaterial.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c406abe3be01..c04450a4adec 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -448,9 +448,10 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 				size >> iova_shift(iovad));
 }
 
-static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
+static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 		size_t size)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, dma_addr);
@@ -465,8 +466,9 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, struct iommu_domain *domain)
+		size_t size, int prot)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	size_t iova_off = 0;
 	dma_addr_t iova;
@@ -565,7 +567,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 static void __iommu_dma_free(struct device *dev, struct page **pages,
 		size_t size, dma_addr_t *handle)
 {
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
+	__iommu_dma_unmap(dev, *handle, size);
 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 	*handle = DMA_MAPPING_ERROR;
 }
@@ -718,14 +720,13 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
-	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
-			iommu_get_dma_domain(dev));
+	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
 }
 
 static void __iommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
+	__iommu_dma_unmap(dev, handle, size);
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
@@ -734,11 +735,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
+	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle =__iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, coherent, attrs),
-			iommu_get_dma_domain(dev));
+	dma_handle =__iommu_dma_map(dev, phys, size, prot);
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(dev, phys, size, dir);
@@ -750,7 +750,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), dma_handle, size);
+	__iommu_dma_unmap(dev, dma_handle, size);
 }
 
 /*
@@ -931,21 +931,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		sg = tmp;
 	}
 	end = sg_dma_address(sg) + sg_dma_len(sg);
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), start, end - start);
+	__iommu_dma_unmap(dev, start, end - start);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			iommu_get_dma_domain(dev));
+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
+	__iommu_dma_unmap(dev, handle, size);
 }
 
 static void *iommu_dma_alloc(struct device *dev, size_t size,
@@ -1205,9 +1204,8 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
 }
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
-		phys_addr_t msi_addr, struct iommu_domain *domain)
+		phys_addr_t msi_addr, struct iommu_dma_cookie *cookie)
 {
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi_page;
 	dma_addr_t iova;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
@@ -1222,7 +1220,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
+	iova = __iommu_dma_map(dev, msi_addr, size, prot);
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
@@ -1258,7 +1256,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	 * of an MSI from within an IPI handler.
 	 */
 	spin_lock_irqsave(&cookie->msi_lock, flags);
-	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
+	msi_page = iommu_dma_get_msi_page(dev, msi_addr, cookie);
 	spin_unlock_irqrestore(&cookie->msi_lock, flags);
 
 	msi_desc_set_iommu_cookie(desc, msi_page);
-- 
2.20.1

