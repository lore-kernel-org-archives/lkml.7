Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F73C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70A9206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LWjUBjQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfG3GTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:19:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfG3GTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jzoHUBaVmA64oWNrVo/G4me83PbtX+FG4xTY0W22gF8=; b=LWjUBjQNvq23AXlcybE9iOAY7
        85k5b/KawWAxULHTtBb7zuuhUOcIeJbw5r1FThcXJAkD3StG5K+b28lS0eI52lxhLUiCHcJfGBkTx
        AtDkk2RJwdRoU+zKsWZfQuo5IFHjE43dhQ4UcZ61be72RNFo+0tS3o3do7osxGS/ojGO22o5GYvtl
        97SDA3JukypuGlYFTkzOIPsDNGzaaaAJII3JvH5W9ZSq5a7Jre5a4eSUKBM6h0CKux7o6b67m6pn8
        /LxGiNxdQDzq98xG7wxgwTv/GYP1EdxlvVZEq/A6Izmb5Jl6I1n+QKk0ahKUjMjrilCanPK559AAg
        +n7M/43oA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsLTR-0006Rn-FJ; Tue, 30 Jul 2019 06:19:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tomi.valkeinen@ti.com
Cc:     laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: remove dma_{alloc,free,mmap}_writecombine
Date:   Tue, 30 Jul 2019 09:18:49 +0300
Message-Id: <20190730061849.29686-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can already use DMA_ATTR_WRITE_COMBINE or the _wc prefixed version,
so remove the third way of doing things.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 11 +++++------
 include/linux/dma-mapping.h         |  9 ---------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index 785c5546067a..c70f3246a552 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -4609,11 +4609,10 @@ static int dispc_errata_i734_wa_init(struct dispc_device *dispc)
 	i734_buf.size = i734.ovli.width * i734.ovli.height *
 		color_mode_to_bpp(i734.ovli.fourcc) / 8;
 
-	i734_buf.vaddr = dma_alloc_writecombine(&dispc->pdev->dev,
-						i734_buf.size, &i734_buf.paddr,
-						GFP_KERNEL);
+	i734_buf.vaddr = dma_alloc_wc(&dispc->pdev->dev, i734_buf.size,
+			&i734_buf.paddr, GFP_KERNEL);
 	if (!i734_buf.vaddr) {
-		dev_err(&dispc->pdev->dev, "%s: dma_alloc_writecombine failed\n",
+		dev_err(&dispc->pdev->dev, "%s: dma_alloc_wc failed\n",
 			__func__);
 		return -ENOMEM;
 	}
@@ -4626,8 +4625,8 @@ static void dispc_errata_i734_wa_fini(struct dispc_device *dispc)
 	if (!dispc->feat->has_gamma_i734_bug)
 		return;
 
-	dma_free_writecombine(&dispc->pdev->dev, i734_buf.size, i734_buf.vaddr,
-			      i734_buf.paddr);
+	dma_free_wc(&dispc->pdev->dev, i734_buf.size, i734_buf.vaddr,
+		    i734_buf.paddr);
 }
 
 static void dispc_errata_i734_wa(struct dispc_device *dispc)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea32c78..633dae466097 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -786,9 +786,6 @@ static inline void *dma_alloc_wc(struct device *dev, size_t size,
 
 	return dma_alloc_attrs(dev, size, dma_addr, gfp, attrs);
 }
-#ifndef dma_alloc_writecombine
-#define dma_alloc_writecombine dma_alloc_wc
-#endif
 
 static inline void dma_free_wc(struct device *dev, size_t size,
 			       void *cpu_addr, dma_addr_t dma_addr)
@@ -796,9 +793,6 @@ static inline void dma_free_wc(struct device *dev, size_t size,
 	return dma_free_attrs(dev, size, cpu_addr, dma_addr,
 			      DMA_ATTR_WRITE_COMBINE);
 }
-#ifndef dma_free_writecombine
-#define dma_free_writecombine dma_free_wc
-#endif
 
 static inline int dma_mmap_wc(struct device *dev,
 			      struct vm_area_struct *vma,
@@ -808,9 +802,6 @@ static inline int dma_mmap_wc(struct device *dev,
 	return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size,
 			      DMA_ATTR_WRITE_COMBINE);
 }
-#ifndef dma_mmap_writecombine
-#define dma_mmap_writecombine dma_mmap_wc
-#endif
 
 #ifdef CONFIG_NEED_DMA_MAP_STATE
 #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)        dma_addr_t ADDR_NAME
-- 
2.20.1

