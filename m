Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7896FC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A53321743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H+rObaLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfGQG0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:26:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQG0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V10uEz0zWFZ63sIz9VJWmuEfwUxz9f6GOpX0SGJmq3k=; b=H+rObaLkaOf7mg1iUpKwHTvO5y
        8nUdnb5L2v6HXJNISb2ZuVZhIsuCG4IgOd9NRP1Eyo1A/taHfQcABuxLHjdap9bWXyijCKGOi8Uoq
        MRRCdIWZ22tyFC5InEjdPx6+8QZ9pqylyjb092b3C5nYFMvY4GoT9cvnmjThEmHH2jiAUbkJR8iwr
        4bKT8+yD1Pu+3I+JBqM50wbepIodG5xVIXg1DFAO/7Gi5qu5Uo4OcgXTKPjnqUOlmOdyPd8kpkX1D
        +sA1BUMdOuMEslmpK+diC57qfUhjgNNKSbNPxc0PLK4TAXnGuL8u/QvhE0hvTSnbWW2cUOF/df7ZV
        7TcDX+ow==;
Received: from [213.208.157.38] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hndOP-0003ma-Pe; Wed, 17 Jul 2019 06:26:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-mapping: add a dma_addressing_limited helper
Date:   Wed, 17 Jul 2019 08:26:14 +0200
Message-Id: <20190717062615.10569-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717062615.10569-1-hch@lst.de>
References: <20190717062615.10569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper returns if the device has issues addressing all present
memory in the system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8d13e28a8e07..e11b115dd0e4 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -679,6 +679,20 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 	return dma_set_mask_and_coherent(dev, mask);
 }
 
+/**
+ * dma_addressing_limited - return if the device is addressing limited
+ * @dev:	device to check
+ *
+ * Return %true if the devices DMA mask is too small to address all memory in
+ * the system, else %false.  Lack of addressing bits is the prime reason for
+ * bounce buffering, but might not be the only one.
+ */
+static inline bool dma_addressing_limited(struct device *dev)
+{
+	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
+		dma_get_required_mask(dev);
+}
+
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		const struct iommu_ops *iommu, bool coherent);
-- 
2.20.1

