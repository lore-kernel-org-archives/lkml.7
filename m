Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB149C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ECF217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnb78vub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDKHLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:11:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bFsH0aPgfN/QmhFG3BGd/cwArk0A/IbJ6M9U9+CRolE=; b=nnb78vubqHZcz8qr3Gg0qXeLc
        kS3j13gZr2JDzYBpRaA+sLHBOnp9kooiZOa2TZRFF45zAqk/af3GAPcwfVTf5wbubT3xUNSeM7cA7
        rSwfguKvMs0r3cuyhDn10HIfdbRPS67+jK8fbQRaAS95H3x7w9q7DrZVEW8ueulWy1k2DDDVOiP3o
        ybioWD8xLu2de0WGD8cOdqyl5iyTskwc4YHR09IY7SKYzVxjultIVsIH8+AgPcUu45HUoRmcCEusz
        rox4DwTzUJK0SQyD0bqcVw4yZYfvWya9JIVqDR/gAXHCvXw/nE9mQxUig9+vSSJT3rtm2A2u0v5je
        EtFad02UQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hETs2-0007b4-BP; Thu, 11 Apr 2019 07:11:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux@armlinux.org.uk, iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: remove the dma_get_sgtable API comments from arm to common code
Date:   Thu, 11 Apr 2019 09:11:16 +0200
Message-Id: <20190411071116.29862-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments are spot on and should be near the central API, not just
near a single implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 11 -----------
 kernel/dma/mapping.c      | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 43f46aa7ef33..6e7a4574d4da 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -898,17 +898,6 @@ static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_add
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
 }
 
-/*
- * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
- * that the intention is to allow exporting memory allocated via the
- * coherent DMA APIs through the dma_buf API, which only accepts a
- * scattertable.  This presents a couple of problems:
- * 1. Not all memory allocated via the coherent DMA APIs is backed by
- *    a struct page
- * 2. Passing coherent DMA memory into the streaming APIs is not allowed
- *    as we will try to flush the memory through a different alias to that
- *    actually being used (and the flushes are redundant.)
- */
 int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
 		 unsigned long attrs)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index c000906348c9..21352da4929e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -131,6 +131,17 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return ret;
 }
 
+/*
+ * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
+ * that the intention is to allow exporting memory allocated via the
+ * coherent DMA APIs through the dma_buf API, which only accepts a
+ * scattertable.  This presents a couple of problems:
+ * 1. Not all memory allocated via the coherent DMA APIs is backed by
+ *    a struct page
+ * 2. Passing coherent DMA memory into the streaming APIs is not allowed
+ *    as we will try to flush the memory through a different alias to that
+ *    actually being used (and the flushes are redundant.)
+ */
 int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
-- 
2.20.1

