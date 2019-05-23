Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3406EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A512133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DpcSDhHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfEWHBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:01:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbfEWHBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S0I3Biel1310XkQs07KGIWKEiW7Es6xP6s+e5Qs00No=; b=DpcSDhHGSgUuRaORM1eAJNnuDO
        EKVK+k8aR3gXWrxx8nDKqlAZaVIlr4tMwwNVfiJ2r/uC7pkasPgrp2c17sjtEnZ2Q1X1VU8V9+nbW
        yMIgyXZn1/jXbOYP8n4vKiyjoRM8MAPzPth80IuEm1bwZqOWStOpTbhxwaisiKy8cSSE5KRybUACH
        Jz1/bdEZTx9fwEnmkmWNHj6BG4N3hNDHEB9DL2eCf5Y1/d6AM4wBXPeP1PSfMVv2MHoiu5oQ+Qd8M
        Q+KgHB+hywjPg2V9eivdjzZbYiFFjdD1GJNG9A2XbnPaIQk/XfWviYZmQc1gGnOtJ6hoSLdPlJ3pi
        i5TrbHvQ==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThir-0005Pg-Ea; Thu, 23 May 2019 07:01:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/23] iommu/dma: Refactor iommu_dma_alloc
Date:   Thu, 23 May 2019 09:00:17 +0200
Message-Id: <20190523070028.7435-13-hch@lst.de>
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

Shuffle around the self-contained atomic and non-contiguous cases to
return early and get out of the way of the CMA case that we're about to
work on next.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: slight changes to the code flow]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f61e3f8861a8..41e87756c076 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -973,14 +973,19 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 	size_t iosize = size;
+	struct page *page;
 	void *addr;
 
 	size = PAGE_ALIGN(size);
 	gfp |= __GFP_ZERO;
 
+	if (gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
+
 	if (!gfpflags_allow_blocking(gfp)) {
-		struct page *page;
 		/*
 		 * In atomic context we can't remap anything, so we'll only
 		 * get the virtually contiguous buffer we need by way of a
@@ -1002,39 +1007,34 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 				__free_pages(page, get_order(size));
 			else
 				dma_free_from_pool(addr, size);
-			addr = NULL;
-		}
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page *page;
-
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
-		if (!page)
 			return NULL;
-
-		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
-			return NULL;
-		}
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
-						   prot,
-						   __builtin_return_address(0));
-		if (addr) {
-			if (!coherent)
-				arch_dma_prep_coherent(page, iosize);
-			memset(addr, 0, size);
-		} else {
-			__iommu_dma_unmap(dev, *handle, iosize);
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
 		}
-	} else {
-		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
+		return addr;
 	}
+
+	page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
+					 get_order(size), gfp & __GFP_NOWARN);
+	if (!page)
+		return NULL;
+
+	*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
+	if (*handle == DMA_MAPPING_ERROR)
+		goto out_free_pages;
+
+	addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
+			__builtin_return_address(0));
+	if (!addr)
+		goto out_unmap;
+
+	if (!coherent)
+		arch_dma_prep_coherent(page, iosize);
+	memset(addr, 0, size);
 	return addr;
+out_unmap:
+	__iommu_dma_unmap(dev, *handle, iosize);
+out_free_pages:
+	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+	return NULL;
 }
 
 static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
-- 
2.20.1

