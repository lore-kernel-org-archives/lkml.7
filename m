Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6A4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAD020880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NL6x667D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfDPSYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfDPSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W1KMMjMMYjh5aoz7WBFfS5OP0Gny+UzRR9uwG3wwQHo=; b=NL6x667Dk+RFYVCOIkt8OEaNtl
        jA3FHRwpy4XLeYdYF/7wZ4AUI4X1P6qX3O4rZQcLv25YBUiVzQU/V8qlksOg10sYpaRKU2/F+EhzY
        FORozJjv6+nRV8AFyD9syhLkclwRnDLCGAJCWnmCh22Hzr9MeKBvh+A8YM369bYrRokIPwZl75Nc8
        iZghh8W5JkhZg/d30IadtqA5zuTSIECzNx2HE4yO6kONWARHn4jeAV8+qO0z8hJ9jZRl8HyYnmMep
        5ksu8/UWhOM3bT5Wy4rc6v0NosTXnkpi89FG3KL8RbW71OYwGfK9gnNxsOk8A+9rzCz8HuAoWi2Zj
        7VcdwEBg==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSks-00077B-Rf; Tue, 16 Apr 2019 18:24:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] sparc/iommu: pass a physical address to iommu_get_one
Date:   Tue, 16 Apr 2019 20:23:43 +0200
Message-Id: <20190416182347.18441-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
References: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for the page structure, just the paddr / pfn.  This is
going to simplify fixes to the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index f90d943a3a27..19d9266e4049 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -175,16 +175,17 @@ static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
 	}
 }
 
-static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
+static u32 iommu_get_one(struct device *dev, phys_addr_t paddr, int npages)
 {
 	struct iommu_struct *iommu = dev->archdata.iommu;
 	int ioptex;
 	iopte_t *iopte, *iopte0;
 	unsigned int busa, busa0;
+	unsigned long pfn = __phys_to_pfn(paddr);
 	int i;
 
 	/* page color = pfn of page */
-	ioptex = bit_map_string_get(&iommu->usemap, npages, page_to_pfn(page));
+	ioptex = bit_map_string_get(&iommu->usemap, npages, pfn);
 	if (ioptex < 0)
 		panic("iommu out");
 	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
@@ -193,11 +194,11 @@ static u32 iommu_get_one(struct device *dev, struct page *page, int npages)
 	busa = busa0;
 	iopte = iopte0;
 	for (i = 0; i < npages; i++) {
-		iopte_val(*iopte) = MKIOPTE(page_to_pfn(page), IOPERM);
+		iopte_val(*iopte) = MKIOPTE(pfn, IOPERM);
 		iommu_invalidate_page(iommu->regs, busa);
 		busa += PAGE_SIZE;
 		iopte++;
-		page++;
+		pfn++;
 	}
 
 	iommu_flush_iotlb(iopte0, npages);
@@ -215,7 +216,7 @@ static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
-	return iommu_get_one(dev, virt_to_page(vaddr), npages) + off;
+	return iommu_get_one(dev, virt_to_phys(vaddr), npages) + off;
 }
 
 static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
@@ -268,7 +269,7 @@ static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
 			}
 		}
 
-		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
+		sg->dma_address = iommu_get_one(dev, sg_phys(sg), n) + sg->offset;
 		sg->dma_length = sg->length;
 	}
 
-- 
2.20.1

