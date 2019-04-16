Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37822C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C47E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JE0uiHdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfDPSYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfDPSYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MP0bg1SjYEGNhPZXkcFs6vwuoaxKKy+8y7MQTqX5/XQ=; b=JE0uiHdxLsHmUbBoHF5dtBjJqT
        BwD2jnWGVtuNmI6JNP8VYeziPMh4985vzEdqIM4rl+pZ03Ijtr6hmpzij7M3gqFeGfrGQzxLFIzQ/
        z9ORk7No5CzA87A8qOaxUy+AejiuzU7BR4kKvG2l2hHmtjS6SR2feYqe2exQ2mcJaFCHPaVrCuD6h
        dcpinHUl5Q/cBHKq1OJzfilzZ5xzQrWEbEAq7FlmrXkSQeodVMbHikCpfam1iA97f/hsnXg6+/MpH
        ZjHYkWYg6KJUfQam1eXH4RANsAhw5xxs6asXD/UMDJJy/o4r2DBIb33qJhVuYjcWb/t0lLHK0R3hE
        8lZnGlRA==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSl1-00079L-1D; Tue, 16 Apr 2019 18:24:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] sparc/iommu: use __sbus_iommu_map_page to implement the map_sg path
Date:   Tue, 16 Apr 2019 20:23:46 +0200
Message-Id: <20190416182347.18441-9-hch@lst.de>
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

This means we handle > PAGE_SIZE offsets fine, and grow the size check
so far only performed in the map_page path.  We lose the optimization
to not double flush a page if it apears in multiple consecutive SG list
entries.  But at least for block I/O those don't happen anymore since
we properly merge in higher layers anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 37b5ce7657f6..8fbc08d14836 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -217,6 +217,11 @@ static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
 
+	/*
+	 * We expect unmapped highmem pages to be not in the cache.
+	 * XXX Is this a good assumption?
+	 * XXX What if someone else unmaps it here and races us?
+	 */
 	if (per_page_flush && !PageHighMem(page)) {
 		unsigned long vaddr, p;
 
@@ -247,30 +252,14 @@ static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs,
 		bool per_page_flush)
 {
-	unsigned long page, oldpage = 0;
 	struct scatterlist *sg;
-	int i, j, n;
+	int j;
 
 	for_each_sg(sgl, sg, nents, j) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-
-		/*
-		 * We expect unmapped highmem pages to be not in the cache.
-		 * XXX Is this a good assumption?
-		 * XXX What if someone else unmaps it here and races us?
-		 */
-		if (per_page_flush && !PageHighMem(sg_page(sg))) {
-			page = (unsigned long)page_address(sg_page(sg));
-			for (i = 0; i < n; i++) {
-				if (page != oldpage) {	/* Already flushed? */
-					flush_page_for_dma(page);
-					oldpage = page;
-				}
-				page += PAGE_SIZE;
-			}
-		}
-
-		sg->dma_address = iommu_get_one(dev, sg_phys(sg), n) + sg->offset;
+		sg->dma_address =__sbus_iommu_map_page(dev, sg_page(sg),
+				sg->offset, sg->length, per_page_flush);
+		if (sg->dma_address == DMA_MAPPING_ERROR)
+			return 0;
 		sg->dma_length = sg->length;
 	}
 
-- 
2.20.1

