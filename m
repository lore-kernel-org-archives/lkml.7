Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F899C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2FE206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iq26QBR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfETHbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfETHba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xlVdYa3LM3JV3R1qnSvDve8LJlyAQnRtMYWJmeE6eFU=; b=Iq26QBR3nk1tlfJaP+POhoPAfh
        odNFSaIWNX2fjktC6GFmq+wBk5isVhKDUmEMOsfeJFPqEKmLTPt9YcMqDLwnXLiIQYs3ISpmrbriY
        h3ToyZQNLVKU510y1htyyqbwy3uPki747xM1QkjliDc17WQJ89tWeKCteUKfC32kUprfFuizToMI4
        9+JAzDq9qjG5HdRQgJvNn0Tkrx/itLR6kY6fC5H+TAw+bNiVuKFa7ybqvl3FgCWuhUpZPv3+lUZev
        ZZkWYpOq81m3+BYD8A+YxlzVLZ6z4slYp8Xk1RI0S4lhgAWnU+QZH4JiACaTK/MV1Lmg2ZZe6MRPl
        ETGbOuXQ==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSclY-0004dn-Nh; Mon, 20 May 2019 07:31:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] iommu/dma: Cleanup variable naming in iommu_dma_alloc
Date:   Mon, 20 May 2019 09:29:41 +0200
Message-Id: <20190520072948.11412-18-hch@lst.de>
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

Most importantly clear up the size / iosize confusion.  Also rename addr
to cpu_addr to match the surrounding code and make the intention a little
more clear.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 45 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f0cd35fd11dd..4e27a29f4458 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -977,64 +977,63 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
-	size_t iosize = size;
+	size_t alloc_size = PAGE_ALIGN(size);
 	struct page *page = NULL;
-	void *addr;
+	void *cpu_addr;
 
-	size = PAGE_ALIGN(size);
 	gfp |= __GFP_ZERO;
 
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
-		return iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
+		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
 
 	if (!gfpflags_allow_blocking(gfp) && !coherent) {
-		addr = dma_alloc_from_pool(size, &page, gfp);
-		if (!addr)
+		cpu_addr = dma_alloc_from_pool(alloc_size, &page, gfp);
+		if (!cpu_addr)
 			return NULL;
 
-		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize,
+		*handle = __iommu_dma_map(dev, page_to_phys(page), size,
 					  ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
-			dma_free_from_pool(addr, size);
+			dma_free_from_pool(cpu_addr, alloc_size);
 			return NULL;
 		}
-		return addr;
+		return cpu_addr;
 	}
 
 	if (gfpflags_allow_blocking(gfp))
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-						 get_order(size),
+		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
+						 get_order(alloc_size),
 						 gfp & __GFP_NOWARN);
 	if (!page)
-		page = alloc_pages(gfp, get_order(size));
+		page = alloc_pages(gfp, get_order(alloc_size));
 	if (!page)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
 	if (*handle == DMA_MAPPING_ERROR)
 		goto out_free_pages;
 
 	if (!coherent || PageHighMem(page)) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
-				__builtin_return_address(0));
-		if (!addr)
+		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
+				VM_USERMAP, prot, __builtin_return_address(0));
+		if (!cpu_addr)
 			goto out_unmap;
 
 		if (!coherent)
-			arch_dma_prep_coherent(page, iosize);
+			arch_dma_prep_coherent(page, size);
 	} else {
-		addr = page_address(page);
+		cpu_addr = page_address(page);
 	}
-	memset(addr, 0, size);
-	return addr;
+	memset(cpu_addr, 0, alloc_size);
+	return cpu_addr;
 out_unmap:
-	__iommu_dma_unmap(dev, *handle, iosize);
+	__iommu_dma_unmap(dev, *handle, size);
 out_free_pages:
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
+	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
+		__free_pages(page, get_order(alloc_size));
 	return NULL;
 }
 
-- 
2.20.1

