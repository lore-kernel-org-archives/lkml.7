Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB6BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081DC21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTdzSyTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfD3Ky4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:54:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfD3KxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hoQ9dDF1t2WyWmPf7DFt97kzINCVR3iMS/SIjsaMb1Q=; b=nTdzSyTiS6zBlYA6M8fmgvu+7O
        rCAqqZ1C0oi7/xXZZ2U3g1vjzjk10yaY76Mm1S41Ia0CQuLJ1v5UOE0jGHHyxJd4ryKxvcBNoVgtt
        lNLzULJV7GtuhBUPdCgweqMWK5XbAwblJ4FF74VVnXfw2GGoo9Nuna9jm6BlwvplhwjXR9RrOGWek
        /uRnEYRRksgBOHt1kagy8/4mM772pSBh1uORqMA3gjAdp8DOUQe/WUpwhjTOXflHuQtJtQsiVCGZJ
        ehpDIeF426e6X+xoNrGbodusAJUEUDSwWWc+2cAb566PDLJ+O4KFern9dMT13BE5T9KqOWrthy9yY
        3Y6ro4Wg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQNc-0007PA-7E; Tue, 30 Apr 2019 10:52:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/25] iommu/dma: Cleanup dma-iommu.h
Date:   Tue, 30 Apr 2019 06:51:52 -0400
Message-Id: <20190430105214.24628-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for a __KERNEL__ guard outside uapi and add a missing comment
describing the #else cpp statement.  Last but not least include
<linux/errno.h> instead of the asm version, which is frowned upon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-iommu.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..8741637941ca 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -16,9 +16,8 @@
 #ifndef __DMA_IOMMU_H
 #define __DMA_IOMMU_H
 
-#ifdef __KERNEL__
+#include <linux/errno.h>
 #include <linux/types.h>
-#include <asm/errno.h>
 
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/dma-mapping.h>
@@ -74,7 +73,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-#else
+#else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
 struct msi_msg;
@@ -108,5 +107,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 }
 
 #endif	/* CONFIG_IOMMU_DMA */
-#endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
2.20.1

