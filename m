Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C06821916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nyWYIRuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCUWxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:53:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfCUWxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ez+3EWjdVvcOHsf4UKZtVhBc01z3rs8TGTRNqolA6d8=; b=nyWYIRuc0OdL0079dxLKpM0LW+
        38D8w27a41xu2YwM1h3qiP8uXOOb1B7viyiFZZKEEV52tP0kb0BYXlu4FkDn7wbwsNV6eu4x5z62w
        2ydHpj7skFQBYlrwr+r3u6IkWao0fFUFUIJuw7DdUcDj0m3+FOdEdvKqhwH5rrim/sSSn5sYVpJeW
        C6yhNKWQv2sN54hkl8vghYi9Y+Utvmyrkz3YGD/VIWkAnNzunjC7c8PDBBMnvfgYS8jQi8kNPTWHq
        R0PcmhNT2WqfLSJRukNqgQrKDejsMFvWMTzjDl6w2AMLSCAM5tqE28HQ+AqjepTxM96xny6dk8be3
        gwjueO6w==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76Yx-0008RO-Nz; Thu, 21 Mar 2019 22:53:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dma-mapping: remove leftover NULL device support
Date:   Thu, 21 Mar 2019 15:52:34 -0700
Message-Id: <20190321225235.30648-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
References: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most dma_map_ops implementations already had some issues with a NULL
device, or did simply crash if one was fed to them.  Now that we have
cleaned up all the obvious offenders we can stop to pretend we
support this mode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API-HOWTO.txt | 13 ++++++-------
 include/linux/dma-mapping.h     |  6 +++---
 kernel/dma/direct.c             |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 1a721d0f35c8..0e98cf7466dd 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -365,13 +365,12 @@ __get_free_pages() (but takes size instead of a page order).  If your
 driver needs regions sized smaller than a page, you may prefer using
 the dma_pool interface, described below.
 
-The consistent DMA mapping interfaces, for non-NULL dev, will by
-default return a DMA address which is 32-bit addressable.  Even if the
-device indicates (via DMA mask) that it may address the upper 32-bits,
-consistent allocation will only return > 32-bit addresses for DMA if
-the consistent DMA mask has been explicitly changed via
-dma_set_coherent_mask().  This is true of the dma_pool interface as
-well.
+The consistent DMA mapping interfaces, will by default return a DMA address
+which is 32-bit addressable.  Even if the device indicates (via the DMA mask)
+that it may address the upper 32-bits, consistent allocation will only
+return > 32-bit addresses for DMA if the consistent DMA mask has been
+explicitly changed via dma_set_coherent_mask().  This is true of the
+dma_pool interface as well.
 
 dma_alloc_coherent() returns two values: the virtual address which you
 can use to access it from the CPU and dma_handle which you pass to the
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..6309a721394b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -267,9 +267,9 @@ size_t dma_direct_max_mapping_size(struct device *dev);
 
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	if (dev && dev->dma_ops)
+	if (dev->dma_ops)
 		return dev->dma_ops;
-	return get_arch_dma_ops(dev ? dev->bus : NULL);
+	return get_arch_dma_ops(dev->bus);
 }
 
 static inline void set_dma_ops(struct device *dev,
@@ -650,7 +650,7 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 
 static inline u64 dma_get_mask(struct device *dev)
 {
-	if (dev && dev->dma_mask && *dev->dma_mask)
+	if (dev->dma_mask && *dev->dma_mask)
 		return *dev->dma_mask;
 	return DMA_BIT_MASK(32);
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fcdb23e8d2fc..2c2772e9702a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -311,7 +311,7 @@ static inline bool dma_direct_possible(struct device *dev, dma_addr_t dma_addr,
 		size_t size)
 {
 	return swiotlb_force != SWIOTLB_FORCE &&
-		(!dev || dma_capable(dev, dma_addr, size));
+		dma_capable(dev, dma_addr, size);
 }
 
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-- 
2.20.1

