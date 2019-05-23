Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F506C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E8E2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QLj3bKMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfEWHAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:00:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfEWHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/9Eurjn8mYI9ykDjpIHMqWyLxByMSC5LUCM9LONdLp8=; b=QLj3bKMU+COiXNEG+wi35lIFqo
        DPW+ZjH8uCGOhMHkHKUd8P+9Rj1Zg3OHZi/ZrIkmuI+PRAXISODl36jVR00w153TWmbM6yGGeExqK
        70zDSpYetsNx9gNqM9kZ3A4d4Zf+IF9gPlwf0ie3n62hV6BJaphsSNFJfQxMuefQCQG12W6lH1KDS
        UnTtD7KLrM7aA1NEp5iW981QOUjlJfZZJMpKzsi31bwZ4YTWIFFKMbxljUJbiVuhzoO29fBWPVGRF
        5pwqxFYAnNutzshgryV/MDhTIWpheeUKMUGfNlbPC0+Sv/YSQN3PDic3nzgmS6j9EEkilWd0g9VZb
        DlxVeJow==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThiM-0004hI-Ez; Thu, 23 May 2019 07:00:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/23] iommu/dma: Cleanup dma-iommu.h
Date:   Thu, 23 May 2019 09:00:06 +0200
Message-Id: <20190523070028.7435-2-hch@lst.de>
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

No need for a __KERNEL__ guard outside uapi and add a missing comment
describing the #else cpp statement.  Last but not least include
<linux/errno.h> instead of the asm version, which is frowned upon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-iommu.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 476e0c54de2d..dfb83f9c24dc 100644
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
@@ -86,7 +85,7 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-#else
+#else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
 struct msi_desc;
@@ -128,5 +127,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 }
 
 #endif	/* CONFIG_IOMMU_DMA */
-#endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
2.20.1

