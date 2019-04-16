Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FABC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6694D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AyK1fCPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfDPSYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbfDPSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FWmW50D8VCPzKMkmL2J4rwiG+l/cJD5BGjgkEjIfYqw=; b=AyK1fCPUE0Aq1KQe7xf9Wn8irT
        RUNPJQY51fu7LacqP9mcKPUthnweosI2NeGeiivexPTv3i3l8jN4KE19J1GP/qoeMx8vUJcLJAuKS
        p+rFRCulAAB4s8z4MrolWedRZCvrPKqvA3lKjANo8H9FgB/lX2MjlEyCPmxsQuoMv+lJ/Igmd+Nzv
        SNSJNffRLZZJ+wD2eGZBNZgPRgN/BbaJUaaYfdT3gVDbz9foBfvEm4KbCG2EdUNEIGStVF5j7wUTl
        tztdo41SRUeZ9jge8k718mVIjQt9+Bx2qEU+LqUn7XILC6lFH9l8tU+5+N+IIJjeK5vySdxAKzJyM
        S4xsQ2vA==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSkk-00075v-Qu; Tue, 16 Apr 2019 18:24:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] sparc/iommu: use sbus_iommu_unmap_page in sbus_iommu_unmap_sg
Date:   Tue, 16 Apr 2019 20:23:40 +0200
Message-Id: <20190416182347.18441-3-hch@lst.de>
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

Use the page-level helper instead of duplicating the logic, while also
fixing the incorrect handling of larger than page sized offsets in
the sg variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index dcdadac03fdf..f47a6ce0acaa 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -321,11 +321,11 @@ static void sbus_iommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *sg;
-	int i, n;
+	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		iommu_release_one(dev, sg->dma_address & PAGE_MASK, n);
+		sbus_iommu_unmap_page(dev, sg->dma_address, sg->length, dir,
+				attrs);
 		sg->dma_address = 0x21212121;
 	}
 }
-- 
2.20.1

