Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C271FC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BFC20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IA4PRQ9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfDPSYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbfDPSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sthWR51Wk1+6wSetYhsXxusjcoDDbiMV15mbRBcTPPM=; b=IA4PRQ9y0pzhyiEKXPXJ2CaUlA
        V+ZxH5un+zAZJcf22YYiN0PeoZRS0HRRjb5GWRaQIHC/FgGwpvbwqQpGcf+Aqf+DdDpHisiQMO50D
        QAKxo9t/1Vq7lj0wxoGbZXtEXKyEURnKEXBjgXYARPVBt2VtD47r9yjuCMw//D8pnUdnVpZw+WIF3
        /JL+DwyRzeTuc9kbuKpBITF5yEQf8QJNg3Eq6Ukjym1H9Sd5E7re/SKJhWt4PX+YOglKYdJ1AdpPB
        ffE7VPlCBiia6ZDG32eZyVgFhxMFYTE6lkpOrLIJSu2LeRnY2mELvBLj9mzAwCLZzyT0a4UGId1MR
        ED+a7Q+Q==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSkn-00076a-GX; Tue, 16 Apr 2019 18:24:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] sparc/iommu: merge iommu_release_one and sbus_iommu_unmap_page
Date:   Tue, 16 Apr 2019 20:23:41 +0200
Message-Id: <20190416182347.18441-4-hch@lst.de>
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

There is only one caller of iommu_release_one left, so merge it into
that one to clean things up a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index f47a6ce0acaa..7cb9ddda7531 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -291,14 +291,17 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static void iommu_release_one(struct device *dev, u32 busa, int npages)
+static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
+		size_t len, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct iommu_struct *iommu = dev->archdata.iommu;
-	int ioptex;
-	int i;
+	unsigned int busa = dma_addr & PAGE_MASK;
+	unsigned long off = dma_addr & ~PAGE_MASK;
+	unsigned int npages = (off + len + PAGE_SIZE-1) >> PAGE_SHIFT;
+	unsigned int ioptex = (busa - iommu->start) >> PAGE_SHIFT;
+	unsigned int i;
 
 	BUG_ON(busa < iommu->start);
-	ioptex = (busa - iommu->start) >> PAGE_SHIFT;
 	for (i = 0; i < npages; i++) {
 		iopte_val(iommu->page_table[ioptex + i]) = 0;
 		iommu_invalidate_page(iommu->regs, busa);
@@ -307,16 +310,6 @@ static void iommu_release_one(struct device *dev, u32 busa, int npages)
 	bit_map_clear(&iommu->usemap, ioptex, npages);
 }
 
-static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
-		size_t len, enum dma_data_direction dir, unsigned long attrs)
-{
-	unsigned long off = dma_addr & ~PAGE_MASK;
-	int npages;
-
-	npages = (off + len + PAGE_SIZE-1) >> PAGE_SHIFT;
-	iommu_release_one(dev, dma_addr & PAGE_MASK, npages);
-}
-
 static void sbus_iommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-- 
2.20.1

