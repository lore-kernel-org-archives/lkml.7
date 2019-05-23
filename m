Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90572C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521032133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HxgaAZjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfEWHBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:01:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfEWHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KI2pZD9PKv8cCG83JeH7uDAN64J4a2xCEJ+l9lKDsxQ=; b=HxgaAZjwf0uf6Dyd7oR6y01hau
        T+S+kBxrcWhCjkjJ4tqAm7X5bBrb2635KflQggtnUAY8x52oBHTDqruy0YSaEIW6gVuVpF0bKEJot
        Wuub9uS5jPn+xZzQSgZpipN0qBT51t3Lq18WvAeii+OZcwjFI2qKvZQop7WlxHGZLJdFc1vP3iYTv
        K6O+H1RkKKXzqmPSCIxwXSLltScRd0Nd7qP0pYDhP2mi5v253ME04fb9kMYrZDNjbtFGJJBE0cvvB
        h4GPOvYE7WaOCkGCxnU3Lqz+X8LWOHcIaI2jHhZv6YYieZYDUCWfQCXT72CF3yA6kvWVdRhec3jhp
        pDs/mVnw==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThig-00056P-31; Thu, 23 May 2019 07:00:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/23] iommu/dma: Factor out remapped pages lookup
Date:   Thu, 23 May 2019 09:00:13 +0200
Message-Id: <20190523070028.7435-9-hch@lst.de>
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

Since we duplicate the find_vm_area() logic a few times in places where
we only care aboute the pages, factor out a helper to abstract it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: don't warn when not finding a region, as we'll rely on that later]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4596e4860da8..e870ea59a34d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -554,6 +554,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	return pages;
 }
 
+static struct page **__iommu_dma_get_pages(void *cpu_addr)
+{
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (!area || !area->pages)
+		return NULL;
+	return area->pages;
+}
+
 /**
  * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
  * @dev: Device which owns this buffer
@@ -1042,11 +1051,11 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
-		struct vm_struct *area = find_vm_area(cpu_addr);
+		struct page **pages = __iommu_dma_get_pages(cpu_addr);
 
-		if (WARN_ON(!area || !area->pages))
+		if (!pages)
 			return;
-		__iommu_dma_free(dev, area->pages, iosize, &handle);
+		__iommu_dma_free(dev, pages, iosize, &handle);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
 		__iommu_dma_unmap(dev, handle, iosize);
@@ -1078,7 +1087,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 {
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
-	struct vm_struct *area;
+	struct page **pages;
 	int ret;
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
@@ -1103,11 +1112,10 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		return __iommu_dma_mmap_pfn(vma, pfn, size);
 	}
 
-	area = find_vm_area(cpu_addr);
-	if (WARN_ON(!area || !area->pages))
+	pages = __iommu_dma_get_pages(cpu_addr);
+	if (!pages)
 		return -ENXIO;
-
-	return __iommu_dma_mmap(area->pages, size, vma);
+	return __iommu_dma_mmap(pages, size, vma);
 }
 
 static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
@@ -1125,7 +1133,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct vm_struct *area = find_vm_area(cpu_addr);
+	struct page **pages;
 
 	if (!is_vmalloc_addr(cpu_addr)) {
 		struct page *page = virt_to_page(cpu_addr);
@@ -1141,10 +1149,10 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		return __iommu_dma_get_sgtable_page(sgt, page, size);
 	}
 
-	if (WARN_ON(!area || !area->pages))
+	pages = __iommu_dma_get_pages(cpu_addr);
+	if (!pages)
 		return -ENXIO;
-
-	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
+	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
 					 GFP_KERNEL);
 }
 
-- 
2.20.1

