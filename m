Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CDEC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7892133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="udSRiyk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbfEWHAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:00:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfEWHAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ju/RqGP90XZgvPmH9rBY/iir4lrqKXLkPO1RUnFwzk8=; b=udSRiyk7h7eU94yJMVnXksovGz
        EvQsMYTGXj9+YO3zmKYRmh+oA+9+obtRvLgfosBqj5BrSYDTEZIAj8Kt5oEB978fmIoE5haW5DP4r
        sTeSj8SrTbGeYwhNNiIQljMheZfUCOzMxNzGZC3pmXXuh1jmnEF7WrQ4bWcDKCwg18Y55nD9YKQRM
        4RYIRCWlUUMoCA5AJZbdTufDj3F9e1K2MxdJPSN5IK6I42vm4P2X7PsSVOwNz66Gk2nMAUDBlKD9J
        tTDO4CpEAfo+sZ7b0l3PGrfgwRPygI36uRpwtHj/39u7Ga60reH+hIckFfnwzvwTeYJS5+u9jhwGV
        rrJ2xbrA==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThiS-0004mA-1l; Thu, 23 May 2019 07:00:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/23] iommu/dma: Use for_each_sg in iommu_dma_alloc
Date:   Thu, 23 May 2019 09:00:08 +0200
Message-Id: <20190523070028.7435-4-hch@lst.de>
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

arch_dma_prep_coherent can handle physically contiguous ranges larger
than PAGE_SIZE just fine, which means we don't need a page-based
iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index aac12433ffef..9b7f120d7381 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -606,15 +606,11 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 		goto out_free_iova;
 
 	if (!(prot & IOMMU_CACHE)) {
-		struct sg_mapping_iter miter;
-		/*
-		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
-		 * sufficient here, so skip it by using the "wrong" direction.
-		 */
-		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
-		while (sg_miter_next(&miter))
-			arch_dma_prep_coherent(miter.page, PAGE_SIZE);
-		sg_miter_stop(&miter);
+		struct scatterlist *sg;
+		int i;
+
+		for_each_sg(sgt.sgl, sg, sgt.orig_nents, i)
+			arch_dma_prep_coherent(sg_page(sg), sg->length);
 	}
 
 	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
-- 
2.20.1

