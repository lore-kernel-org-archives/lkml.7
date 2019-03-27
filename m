Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F70DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBEF2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DUgnOEac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbfC0IG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:06:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732788AbfC0IGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=grktw2W9NaSbEM3zUk0/aJf/xu5rZiJlOMykyPpN2hM=; b=DUgnOEacfCkgz05975SUL3BKmC
        f2xs0mdSAL/UwgAtjO1azZ0wcPJRVKynv0zQHSTLiSWRxFYK5vSXQYNriRPZXmbJovOc6ryhOf8V7
        xDM4dyeCq/hfekewXy5uBXZi06fazkosE0iwEAhxZWdjYDBMOlDjKaguBpqEYs6JSAwBlAU2H67U7
        cjtNQtDeLTHKx87ZfNAaSKOWmwwbFwUtW5kTm2Tb1m/zpiJA3Nin5yet31vh8Y/RnQl/APp+eGsDm
        DsIKa1Bg2f0NZEDKLhTOnx91c7/wL9tiXFXwJ0xX9yTkCUb85/pj0sQXeG2N/PXlBWbmotb2jjnKY
        Rff7Hymw==;
Received: from 213-225-14-48.nat.highway.a1.net ([213.225.14.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h93ZP-00073U-MQ; Wed, 27 Mar 2019 08:06:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/21] dma-iommu: refactor iommu_dma_alloc
Date:   Wed, 27 Mar 2019 09:04:44 +0100
Message-Id: <20190327080448.5500-18-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split all functionality related to non-coherent devices into a
separate helper, and make the decision flow more obvious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 51 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09b29f6093bb..f65dd19b0953 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -767,6 +767,22 @@ static void *iommu_dma_alloc_pool(struct device *dev, size_t size,
 	return vaddr;
 }
 
+static void *iommu_dma_alloc_noncoherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	/*
+	 * In atomic context we can't remap anything, so we'll only get the
+	 * virtually contiguous buffer we need by way of a physically
+	 * contiguous allocation.
+	 */
+	if (!gfpflags_allow_blocking(gfp))
+		return iommu_dma_alloc_pool(dev, size, dma_handle, gfp, attrs);
+	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
+		return iommu_dma_alloc_contiguous_remap(dev, size, dma_handle,
+				gfp, attrs);
+	return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+}
+
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
 {
@@ -1040,40 +1056,23 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 }
 
 static void *iommu_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	bool coherent = dev_is_dma_coherent(dev);
-	size_t iosize = size;
-	void *addr;
-
 	/*
 	 * Some drivers rely on this, and we probably don't want the
 	 * possibility of stale kernel data being read by devices anyway.
 	 */
 	gfp |= __GFP_ZERO;
 
-	if (!gfpflags_allow_blocking(gfp)) {
-		/*
-		 * In atomic context we can't remap anything, so we'll only
-		 * get the virtually contiguous buffer we need by way of a
-		 * physically contiguous allocation.
-		 */
-		if (!coherent)
-			return iommu_dma_alloc_pool(dev, iosize, handle, gfp,
-					attrs);
-		return iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
+	if (!dev_is_dma_coherent(dev))
+		return iommu_dma_alloc_noncoherent(dev, size, dma_handle, gfp,
 				attrs);
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		if (coherent)
-			addr = iommu_dma_alloc_contiguous(dev, iosize, handle,
-					gfp, attrs);
-		else
-			addr = iommu_dma_alloc_contiguous_remap(dev, iosize,
-					handle, gfp, attrs);
-	} else {
-		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
-	}
-	return addr;
+
+	if (gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, size, dma_handle, gfp, attrs);
+
+	return iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
 }
 
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-- 
2.20.1

