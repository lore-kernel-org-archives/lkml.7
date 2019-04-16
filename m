Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BFCC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072972087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZIInreZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfDPSYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbfDPSYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+43qxG4u/wyaihrjyi7MoWAt29wUIfubHuyDBMXeov0=; b=ZIInreZ2uYajAGicQFMo/A63W4
        WNA0bemE0wNV4DSCMOeYvLAf0VSi4LrXVUAsiOffZk+R1sBQuZF+cNYec4H07HRLUN1UWY90br6Yx
        EiL2t8ySNWmJ5Ku+fC6BElAbE9+/xY9knvHfMv/15f1948QZJFFyVzT6xCr5G1MrEIJzZApR60ddo
        53b78y50zPup4GaoAHK4WPY/LSlLPJmAWS+1fcY6QaShRxzhxxA3V+Df2/Iswks+d21/NZZ72hOmr
        UEhHUATlFw1F1A5bPEZA8O0InG/0XCXF1MVuukttTvK2wR5oIrXeJOSHdsCWPmmlJKxV02bE7aNDw
        qjbrn4xA==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSl3-00079k-Pg; Tue, 16 Apr 2019 18:24:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] sparc/iommu: merge iommu_get_one and __sbus_iommu_map_page
Date:   Tue, 16 Apr 2019 20:23:47 +0200
Message-Id: <20190416182347.18441-10-hch@lst.de>
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

There is only one caller of iommu_get_one left, so merge it into
that one to clean things up a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/mm/iommu.c | 56 +++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 8fbc08d14836..71ac353032b6 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -175,43 +175,17 @@ static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
 	}
 }
 
-static u32 iommu_get_one(struct device *dev, phys_addr_t paddr, int npages)
-{
-	struct iommu_struct *iommu = dev->archdata.iommu;
-	int ioptex;
-	iopte_t *iopte, *iopte0;
-	unsigned int busa, busa0;
-	unsigned long pfn = __phys_to_pfn(paddr);
-	int i;
-
-	/* page color = pfn of page */
-	ioptex = bit_map_string_get(&iommu->usemap, npages, pfn);
-	if (ioptex < 0)
-		panic("iommu out");
-	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
-	iopte0 = &iommu->page_table[ioptex];
-
-	busa = busa0;
-	iopte = iopte0;
-	for (i = 0; i < npages; i++) {
-		iopte_val(*iopte) = MKIOPTE(pfn, IOPERM);
-		iommu_invalidate_page(iommu->regs, busa);
-		busa += PAGE_SIZE;
-		iopte++;
-		pfn++;
-	}
-
-	iommu_flush_iotlb(iopte0, npages);
-
-	return busa0;
-}
-
 static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t len, bool per_page_flush)
 {
+	struct iommu_struct *iommu = dev->archdata.iommu;
 	phys_addr_t paddr = page_to_phys(page) + offset;
 	unsigned long off = paddr & ~PAGE_MASK;
 	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	unsigned long pfn = __phys_to_pfn(paddr);
+	unsigned int busa, busa0;
+	iopte_t *iopte, *iopte0;
+	int ioptex, i;
 
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
@@ -230,7 +204,25 @@ static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 			flush_page_for_dma(p);
 	}
 
-	return iommu_get_one(dev, paddr, npages) + off;
+	/* page color = pfn of page */
+	ioptex = bit_map_string_get(&iommu->usemap, npages, pfn);
+	if (ioptex < 0)
+		panic("iommu out");
+	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
+	iopte0 = &iommu->page_table[ioptex];
+
+	busa = busa0;
+	iopte = iopte0;
+	for (i = 0; i < npages; i++) {
+		iopte_val(*iopte) = MKIOPTE(pfn, IOPERM);
+		iommu_invalidate_page(iommu->regs, busa);
+		busa += PAGE_SIZE;
+		iopte++;
+		pfn++;
+	}
+
+	iommu_flush_iotlb(iopte0, npages);
+	return busa0 + off;
 }
 
 static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
-- 
2.20.1

