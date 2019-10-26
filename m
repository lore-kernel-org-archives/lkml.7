Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3025B206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vh0c6Dcg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MnOao79j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfJZAn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 20:43:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33844 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfJZAn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 20:43:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6ADF160D52; Sat, 26 Oct 2019 00:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572050635;
        bh=gOp7bQ1U59fV0k/2DQy6TdOt9caAaesaRY1XzyZQLVs=;
        h=From:To:Cc:Subject:Date:From;
        b=Vh0c6Dcg8c+yzCVre1dnWFc+tHk4i26zGkn7zokzBTZ+l4mKqJJAfYCx/ONJMCerV
         qGVjl7kPSHE7BjaP/eqzpY+bgokFI4pDusa3XdBEiL4PLOiH6e2MX3SEPayuSHEPMx
         3Fp6SW48c5sCyG8Giu/pEiHVjr6v+CQRrJ0z6Wuk=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EDD2160240;
        Sat, 26 Oct 2019 00:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572050634;
        bh=gOp7bQ1U59fV0k/2DQy6TdOt9caAaesaRY1XzyZQLVs=;
        h=From:To:Cc:Subject:Date:From;
        b=MnOao79jyuA6Yl413hUwILw4FIwIL/+LTvHhaeULPa49c62Ggu6LtqGgIgSauXZR1
         6A5n4xSYOq4TM89S7YcU8n1KiuWywZCGArX9cBIH718RnPdYNTZG1F+cBdSsbe8ynl
         daKkvUF8I4PBjKyWMnYB3+X2MWtYRNSSQUbc1Lno=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDD2160240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, joro@8bytes.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        will@kernel.org, pratikp@codeaurora.org, lmark@codeaurora.org
Subject: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Date:   Fri, 25 Oct 2019 17:43:36 -0700
Message-Id: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, IOMMU_QCOM_SYS_CACHE exists to allow non-coherent
I/O masters on Qualcomm SoCs to upgrade to caching their
buffers in the outer-level/system cache on these platforms.
However, these masters are limited to managing the mapping
of these buffers themselves through the IOMMU framework,
as opposed to allowing the DMA-IOMMU framework to handle it,
since there is no DMA attribute that maps to the
IOMMU_QCOM_SYS_CACHE protection bit.

Thus, introduce DMA_ATTR_SYS_CACHE so that clients
can use the DMA-IOMMU layer to map their DMA buffers with
the correct memory attributes to allow the buffers to be
cached in the outer-level/system cache.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/dma-iommu.c   | 2 ++
 include/linux/dma-mapping.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f321279..c433ece 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -369,6 +369,8 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 
 	if (attrs & DMA_ATTR_PRIVILEGED)
 		prot |= IOMMU_PRIV;
+	if (attrs & DMA_ATTR_SYS_CACHE)
+		prot |= IOMMU_QCOM_SYS_CACHE;
 
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fc..bdd4dcf 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -71,6 +71,14 @@
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
 /*
+ * DMA_ATTR_SYS_CACHE: This is a hint that non-coherent masters can use to
+ * tell the DMA-IOMMU layer to map their DMA buffers with the correct memory
+ * attributes that allow these buffers to be cached in an outer-level/system
+ * cache.
+ */
+#define DMA_ATTR_SYS_CACHE		(1UL << 10)
+
+/*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
  * It can be given to a device to use as a DMA source or target.  A CPU cannot
  * reference a dma_addr_t directly because there may be translation between
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

