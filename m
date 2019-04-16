Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC245C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36902087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OLB0j0ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfDPSY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfDPSYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oGWIvDWHpGEpQusWH5QfN5rD9gp1ljz+CdOv8bdUgOQ=; b=OLB0j0haRCPUeKqKcdzfuXIT4t
        Vg0QVxaMFc1OQJU9k2sJIvYHHboNN4N+g8y/PqHHMicOt+loh9nyIyHHFdyr+KYyh02XHR9YS7tdn
        WUC5p2Xwo5j/lt4EJ0/U/J7cpcIogSq2Kq3TMMkniqWpZN3HsD6oK5SUspX9vmMs+4IIG8MlHGKNo
        mWFG/Ok+2WjNm29o54AAap5SgHxmQhCdRs9Z+a5FdaXLxM745FnbW8gS95vP2aN4S94uULDNsXSDi
        MIWLSF/CqMVNLPqFkA9SYm3FW8Nw6S0ovuWrfnwMAAkK189vF3yxVCeIZ4PcrlohpBtvkbIAXMmnr
        V/t1CDLQ==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSkq-00076w-5B; Tue, 16 Apr 2019 18:24:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] sparc/iommu: create a common helper for map_sg
Date:   Tue, 16 Apr 2019 20:23:42 +0200
Message-Id: <20190416182347.18441-5-hch@lst.de>
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

Share the code for the global and per-page flush map_sg loops using a
simple bool parameter to disable the per-page flush for the former
variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 7cb9ddda7531..f90d943a3a27 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -241,25 +241,9 @@ static dma_addr_t sbus_iommu_map_page_pflush(struct device *dev,
 	return __sbus_iommu_map_page(dev, page, offset, len);
 }
 
-static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i, n;
-
-	flush_page_for_dma(0);
-
-	for_each_sg(sgl, sg, nents, i) {
-		n = (sg->length + sg->offset + PAGE_SIZE-1) >> PAGE_SHIFT;
-		sg->dma_address = iommu_get_one(dev, sg_page(sg), n) + sg->offset;
-		sg->dma_length = sg->length;
-	}
-
-	return nents;
-}
-
-static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
+static int __sbus_iommu_map_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs,
+		bool per_page_flush)
 {
 	unsigned long page, oldpage = 0;
 	struct scatterlist *sg;
@@ -273,7 +257,7 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
 		 * XXX Is this a good assumption?
 		 * XXX What if someone else unmaps it here and races us?
 		 */
-		if (!PageHighMem(sg_page(sg))) {
+		if (per_page_flush && !PageHighMem(sg_page(sg))) {
 			page = (unsigned long)page_address(sg_page(sg));
 			for (i = 0; i < n; i++) {
 				if (page != oldpage) {	/* Already flushed? */
@@ -291,6 +275,19 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
+static int sbus_iommu_map_sg_gflush(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	flush_page_for_dma(0);
+	return __sbus_iommu_map_sg(dev, sgl, nents, dir, attrs, false);
+}
+
+static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	return __sbus_iommu_map_sg(dev, sgl, nents, dir, attrs, true);
+}
+
 static void sbus_iommu_unmap_page(struct device *dev, dma_addr_t dma_addr,
 		size_t len, enum dma_data_direction dir, unsigned long attrs)
 {
-- 
2.20.1

