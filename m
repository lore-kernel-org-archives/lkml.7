Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3639EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F1021916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sBlqznH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfCUWxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:53:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCUWxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s9q5FJ99lWpVCtL740s0cfRjj+9qxL33pzPFuAa0dhI=; b=sBlqznH7rjBOhc2hY1LI2NLLZe
        bBDUtIJ/WBMA2oWwbUwQT7cDojT2pOfk8BnATBvXq1uSpO4kGgVBpSolguZgMzd8LTa3JaFkyaEcT
        O4+N1hAEWOgJ4wmrpnrs6r2VUbxxTAbZJP4nybps/xuylrhJIaS00s8/YHOicYFY7uBIWwYsM1woX
        5toBZpMxQBPfWj1hSfhWiWOKt+CGKMP5pNLz0D+rhvibcHWyvj19R+tHuhMWb87lK0ocTyv62F93o
        pb1oQB2cli2sN2nlMlWFyJWdzH1nzplH9wZgQt/r+3y13k+lgLF9x4ZbJPlkH1mExeYlj3Dz2l9gh
        IELB2C7A==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76Yb-0007sm-H9; Thu, 21 Mar 2019 22:53:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] da8xx-fb: pass struct device to DMA API functions
Date:   Thu, 21 Mar 2019 15:52:30 -0700
Message-Id: <20190321225235.30648-3-hch@lst.de>
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

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/da8xx-fb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 43f2a4816860..ec62274b914b 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1097,9 +1097,9 @@ static int fb_remove(struct platform_device *dev)
 
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
-		dma_free_coherent(NULL, PALETTE_SIZE, par->v_palette_base,
+		dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
 				  par->p_palette_base);
-		dma_free_coherent(NULL, par->vram_size, par->vram_virt,
+		dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
 				  par->vram_phys);
 		pm_runtime_put_sync(&dev->dev);
 		pm_runtime_disable(&dev->dev);
@@ -1425,7 +1425,7 @@ static int fb_probe(struct platform_device *device)
 	par->vram_size = roundup(par->vram_size/8, ulcm);
 	par->vram_size = par->vram_size * LCD_NUM_BUFFERS;
 
-	par->vram_virt = dma_alloc_coherent(NULL,
+	par->vram_virt = dma_alloc_coherent(par->dev,
 					    par->vram_size,
 					    &par->vram_phys,
 					    GFP_KERNEL | GFP_DMA);
@@ -1446,7 +1446,7 @@ static int fb_probe(struct platform_device *device)
 		da8xx_fb_fix.line_length - 1;
 
 	/* allocate palette buffer */
-	par->v_palette_base = dma_alloc_coherent(NULL, PALETTE_SIZE,
+	par->v_palette_base = dma_alloc_coherent(par->dev, PALETTE_SIZE,
 						 &par->p_palette_base,
 						 GFP_KERNEL | GFP_DMA);
 	if (!par->v_palette_base) {
@@ -1532,11 +1532,12 @@ static int fb_probe(struct platform_device *device)
 	fb_dealloc_cmap(&da8xx_fb_info->cmap);
 
 err_release_pl_mem:
-	dma_free_coherent(NULL, PALETTE_SIZE, par->v_palette_base,
+	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
 			  par->p_palette_base);
 
 err_release_fb_mem:
-	dma_free_coherent(NULL, par->vram_size, par->vram_virt, par->vram_phys);
+	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
+		          par->vram_phys);
 
 err_release_fb:
 	framebuffer_release(da8xx_fb_info);
-- 
2.20.1

