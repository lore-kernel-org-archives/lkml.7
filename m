Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245102146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T35qEcm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfC0IFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:05:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbfC0IFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=boe59w8Ais9ON6lIXarq24m1gpT2viPpkIj/JXUHe5o=; b=T35qEcm7saqKowqe3tMvd4k624
        eLvAx2HgSBvjeYmjqsOX5uQYenWRCj23G9RE99YjkPhgePympZXnyYr1fYuFiJa90sZjO7F/jdy4a
        14YzBbkUkfVATJJz57bio4YQ9J4aK+2KwZ266M9Eg7ytkj7EaOKraggJQy0kMkRcGq5i51s5dPydO
        OmGVb2I6P6anCkqpVUN6kpr1SIdeyeC8eh/5IgQaKNwTzzd72mHgcYWrcfHPJXIwpyH5lzI4U3yom
        suJ+ucsvheo4iSxshuD4E0e12PeW9WM6W7dJZOkMz5iiyKKEwTqY95Di+onBTS0G8YVGExGT+TNKV
        KfNgg4pQ==;
Received: from 213-225-14-48.nat.highway.a1.net ([213.225.14.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h93Yr-0006AB-Vp; Wed, 27 Mar 2019 08:05:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/21] dma-iommu: use for_each_sg in iommu_dma_alloc
Date:   Wed, 27 Mar 2019 09:04:33 +0100
Message-Id: <20190327080448.5500-7-hch@lst.de>
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

arch_dma_prep_coherent can handle physically contiguous ranges larger
than PAGE_SIZE just fine, which means we don't need a page-based
iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77d704c8f565..f915cb7c46e6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -577,15 +577,11 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
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

