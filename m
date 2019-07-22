Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82056C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C44D21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rVd3UGYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfGVNow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:44:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54093 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbfGVNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:44:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so35245732wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWheGXALa3QU6XJ4okjj1TMSdfEv0wcU+XMDpAi/P/4=;
        b=rVd3UGYLpnpiE7d7YNlI3ET5cbhQAhoqJOLIqM567rXb8R0JuSNY+GZ12K9dSNKFZ4
         dl5s5Jx5CpB5SVRzWyOMoTxhRuQ486dDy+IOe5n7GRP60Z/QxdFNnFTZq+X2qWesd+tQ
         68xC09YKoAIjDOa30G0pN5Wdl1aYP05UC/xJr1YOuir73Ug3MH+21e4Wuc8zXvn+LPoN
         MPGKQJSOoUPFhnonqd1vSWZtmNxpr0QdnqfZT/PRoV9YpazFmIObAyyTcj1GgdAHJdQM
         gmp068N6OqASdUbiM9rb03eyh0yElND1TFAVSEnQXvniCrOLzl+Y0bTbvr7Jjx6wbIoz
         HI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWheGXALa3QU6XJ4okjj1TMSdfEv0wcU+XMDpAi/P/4=;
        b=Q61juDESLYREaU9XDyxMkzk6tbzrR5aAfT938pO4zCwi/bnAIQsbUMYp1bph81miMW
         is+0q8CSiu6MRhbusXjmvcXLZK8/nPQMY0vYVgGjrugNJ5dJDAUGGnnZsAfvxOBOnXKB
         Rftkee+7ItTKYWOIsBESQ9zTOwqqUw7ds4MeaCo9iTsloy6UpWkiWCVIlwE+9h1dBhRq
         2p6oBSTX5xp4XhjMBUh2rarpeO5nZmT9WksG4gwuUfCWWFv42O7lFgfeikNeTp5r2UAF
         wXMwIZVMgwNbzaq6TimbETtS0doDLumXEVx3x+2AmKPkIWK/7QWq+oU2ABD241EkEP54
         Uk4g==
X-Gm-Message-State: APjAAAWqiDqPbRi04Y7tvTLzh7vk4bsOx0jbGKtOHlvXHNHjz1bFQKvd
        Qj7QjQYCYztJZ5ShlJkyN3xKJbP+
X-Google-Smtp-Source: APXvYqxCpsWqQ4zm4VmmUJy0WYCbbplgVH9qEJJDDHs04LIzglwRSQkeaNmUKXyrghagMF9BDt0qtA==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr65271331wmf.111.1563803088790;
        Mon, 22 Jul 2019 06:44:48 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id p6sm40652484wrq.97.2019.07.22.06.44.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:44:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 9/9] fbdev: da8xx: use resource management for dma
Date:   Mon, 22 Jul 2019 15:44:23 +0200
Message-Id: <20190722134423.26555-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722134423.26555-1-brgl@bgdev.pl>
References: <20190722134423.26555-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use managed variants of dma alloc functions in the da8xx fbdev driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/da8xx-fb.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index d14ea6f91371..2d3dcc52fcf3 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1087,10 +1087,6 @@ static int fb_remove(struct platform_device *dev)
 
 	unregister_framebuffer(info);
 	fb_dealloc_cmap(&info->cmap);
-	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
-			  par->p_palette_base);
-	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
-			  par->vram_phys);
 	pm_runtime_put_sync(&dev->dev);
 	pm_runtime_disable(&dev->dev);
 	framebuffer_release(info);
@@ -1427,10 +1423,10 @@ static int fb_probe(struct platform_device *device)
 	par->vram_size = roundup(par->vram_size/8, ulcm);
 	par->vram_size = par->vram_size * LCD_NUM_BUFFERS;
 
-	par->vram_virt = dma_alloc_coherent(par->dev,
-					    par->vram_size,
-					    &par->vram_phys,
-					    GFP_KERNEL | GFP_DMA);
+	par->vram_virt = dmam_alloc_coherent(par->dev,
+					     par->vram_size,
+					     &par->vram_phys,
+					     GFP_KERNEL | GFP_DMA);
 	if (!par->vram_virt) {
 		dev_err(&device->dev,
 			"GLCD: kmalloc for frame buffer failed\n");
@@ -1448,20 +1444,20 @@ static int fb_probe(struct platform_device *device)
 		da8xx_fb_fix.line_length - 1;
 
 	/* allocate palette buffer */
-	par->v_palette_base = dma_alloc_coherent(par->dev, PALETTE_SIZE,
-						 &par->p_palette_base,
-						 GFP_KERNEL | GFP_DMA);
+	par->v_palette_base = dmam_alloc_coherent(par->dev, PALETTE_SIZE,
+						  &par->p_palette_base,
+						  GFP_KERNEL | GFP_DMA);
 	if (!par->v_palette_base) {
 		dev_err(&device->dev,
 			"GLCD: kmalloc for palette buffer failed\n");
 		ret = -EINVAL;
-		goto err_release_fb_mem;
+		goto err_release_fb;
 	}
 
 	par->irq = platform_get_irq(device, 0);
 	if (par->irq < 0) {
 		ret = -ENOENT;
-		goto err_release_pl_mem;
+		goto err_release_fb;
 	}
 
 	da8xx_fb_var.grayscale =
@@ -1479,7 +1475,7 @@ static int fb_probe(struct platform_device *device)
 
 	ret = fb_alloc_cmap(&da8xx_fb_info->cmap, PALETTE_SIZE, 0);
 	if (ret)
-		goto err_release_pl_mem;
+		goto err_release_fb;
 	da8xx_fb_info->cmap.len = par->palette_sz;
 
 	/* initialize var_screeninfo */
@@ -1533,14 +1529,6 @@ static int fb_probe(struct platform_device *device)
 err_dealloc_cmap:
 	fb_dealloc_cmap(&da8xx_fb_info->cmap);
 
-err_release_pl_mem:
-	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
-			  par->p_palette_base);
-
-err_release_fb_mem:
-	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
-		          par->vram_phys);
-
 err_release_fb:
 	framebuffer_release(da8xx_fb_info);
 
-- 
2.21.0

