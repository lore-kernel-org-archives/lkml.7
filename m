Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9908AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1942087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tq7Zr0Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfDPSYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730280AbfDPSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wAKySMWZ7ZKsfBsVRkHIS6BVFp7MEJvMJdJmQy9KZi4=; b=tq7Zr0KrB52diGSYqhYFGgW7AS
        EOzOtkXFZ6bcACxG6Qxpa0VX6n3/5i5Zzme2xdTPO3k584vxib86X9tSFR3ElF/1DfyyWuHv40mKN
        u6wY0zufxF+IxGyhXeCvAyjsECi0zKEuVv6zdgKqN9rj1/mJDfkppd7wl9Xef+Bqd1zMOgQzTvAsR
        VOSnZZrqQ2sqiBcamH9RgwLO1T0uOwKj0s25naFelgh6ReBNHjUYzd1tly5jzEzOxC1s86uLO7rH1
        Yl/KbFhCHEYEBdAnAfyfXLhwUrE9Gbid5OtXAPnw7X7dE/jBiyrPoiI6qEiC8b2aKPyIox4pnvBEZ
        PVUDTPfA==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSkv-00078E-GO; Tue, 16 Apr 2019 18:24:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] sparc/iommu: move per-page flushing into __sbus_iommu_map_page
Date:   Tue, 16 Apr 2019 20:23:44 +0200
Message-Id: <20190416182347.18441-7-hch@lst.de>
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

This prepares for reusing __sbus_iommu_map_page in the map_sg path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 19d9266e4049..7e191c8ae46a 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -207,15 +207,25 @@ static u32 iommu_get_one(struct device *dev, phys_addr_t paddr, int npages)
 }
 
 static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t len)
+		unsigned long offset, size_t len, bool per_page_flush)
 {
 	void *vaddr = page_address(page) + offset;
 	unsigned long off = (unsigned long)vaddr & ~PAGE_MASK;
 	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	
+
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
+
+	if (per_page_flush) {
+		unsigned long p = (unsigned long)vaddr & PAGE_MASK;
+
+		while (p < (unsigned long)vaddr + len) {
+			flush_page_for_dma(p);
+			p += PAGE_SIZE;
+		}
+	}
+
 	return iommu_get_one(dev, virt_to_phys(vaddr), npages) + off;
 }
 
@@ -224,22 +234,14 @@ static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	flush_page_for_dma(0);
-	return __sbus_iommu_map_page(dev, page, offset, len);
+	return __sbus_iommu_map_page(dev, page, offset, len, false);
 }
 
 static dma_addr_t sbus_iommu_map_page_pflush(struct device *dev,
 		struct page *page, unsigned long offset, size_t len,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	void *vaddr = page_address(page) + offset;
-	unsigned long p = ((unsigned long)vaddr) & PAGE_MASK;
-
-	while (p < (unsigned long)vaddr + len) {
-		flush_page_for_dma(p);
-		p += PAGE_SIZE;
-	}
-
-	return __sbus_iommu_map_page(dev, page, offset, len);
+	return __sbus_iommu_map_page(dev, page, offset, len, true);
 }
 
 static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
-- 
2.20.1

