Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7091C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFB221955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MhJkVril"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfGVNov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:44:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45237 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbfGVNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:44:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so39451932wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZNZSpaofSdzivT5ozjQLNdDnvzWvkLxf6Z+OYHBPIw=;
        b=MhJkVrilHvUFduWmegELGsRt7I/OQwOf1FOT3pw5wugJ7nLEtyl76vP+nEwYRmsNOG
         PYvtnBgquBU/LKh20yz0cR9e+iNJJLuPUAIo5lgXVvaKOZvZs7hKYSoEBpbOUlakY9vZ
         sq6xsMEX6FldnBJz1SXE798wmMgJcFhDL7ecdv3j/QqW6MTJyi3wykulnM351jrBSEEd
         NMsIv9ZJB+/KNvxr/Vz1GSJxkSzE1LjU2AkGCCN8cu82Uyle3KRHRQPp91w6PR6i6q99
         bG2BF2RgI00HTBrGMWPe4/ioIrBWaIkJVOgNrpsrQWuLICJMBfwIyLJCPe72El/dS3FR
         O37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZNZSpaofSdzivT5ozjQLNdDnvzWvkLxf6Z+OYHBPIw=;
        b=fIdxEKF45qmORO/r8JcZrCQgqELS7guIZr3dmeHvjroUob9to+bcKp/DM5+hYoxFeq
         uty+OekFISgabjKfb9q2lgFgwvqwtMGbjTUzQJ6jVLepM2ejt5QNUCw+wvRnGOJS719f
         c0ALqjV2/vcG2coqU37NqjOtKdZj2XNATDABhmoU79NNhhJb1Yw/1vru9kDPklEEzcEB
         XCqwWgTyqLdwF2fnL1dHcXhMcyhtVOy7og05m06t6uBl/sqJIPCSffyOtXliA4E+4sD8
         Dk81f4c8WskaK7yjBgfJYPMCaOgVEeS84Wnrqp0pDQMLWP71auPpmstRo2jodkCnABU6
         NLqw==
X-Gm-Message-State: APjAAAVEYzd8XmZf/f/6zdmOW/HFIOfCXCn7o/KvlrgFMnASqLaPBRut
        TQ6rAoXQqm9FITtuGF6/DWo=
X-Google-Smtp-Source: APXvYqx7ZF2KX08BrvxXBHPWpYJULmcDpJjOv+ofaB2WjURPPsnMfzA7/Oi1Okbc2rYIOo4Wwzbb5w==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr76330087wru.141.1563803087790;
        Mon, 22 Jul 2019 06:44:47 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id p6sm40652484wrq.97.2019.07.22.06.44.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:44:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 8/9] fbdev: da8xx-fb: drop a redundant if
Date:   Mon, 22 Jul 2019 15:44:22 +0200
Message-Id: <20190722134423.26555-9-brgl@bgdev.pl>
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

The driver data is always set in probe. The remove() callback won't be
called if probe failed which is the only way for it to be NULL. Remove
the redundant if.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/da8xx-fb.c | 43 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index f2f66605e8fb..d14ea6f91371 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1067,37 +1067,34 @@ static void lcd_da8xx_cpufreq_deregister(struct da8xx_fb_par *par)
 static int fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(&dev->dev);
+	struct da8xx_fb_par *par = info->par;
 	int ret;
 
-	if (info) {
-		struct da8xx_fb_par *par = info->par;
-
 #ifdef CONFIG_CPU_FREQ
-		lcd_da8xx_cpufreq_deregister(par);
+	lcd_da8xx_cpufreq_deregister(par);
 #endif
-		if (par->lcd_supply) {
-			ret = regulator_disable(par->lcd_supply);
-			if (ret)
-				return ret;
-		}
+	if (par->lcd_supply) {
+		ret = regulator_disable(par->lcd_supply);
+		if (ret)
+			return ret;
+	}
 
-		lcd_disable_raster(DA8XX_FRAME_WAIT);
-		lcdc_write(0, LCD_RASTER_CTRL_REG);
+	lcd_disable_raster(DA8XX_FRAME_WAIT);
+	lcdc_write(0, LCD_RASTER_CTRL_REG);
 
-		/* disable DMA  */
-		lcdc_write(0, LCD_DMA_CTRL_REG);
+	/* disable DMA  */
+	lcdc_write(0, LCD_DMA_CTRL_REG);
 
-		unregister_framebuffer(info);
-		fb_dealloc_cmap(&info->cmap);
-		dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
-				  par->p_palette_base);
-		dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
-				  par->vram_phys);
-		pm_runtime_put_sync(&dev->dev);
-		pm_runtime_disable(&dev->dev);
-		framebuffer_release(info);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
+	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
+			  par->p_palette_base);
+	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
+			  par->vram_phys);
+	pm_runtime_put_sync(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+	framebuffer_release(info);
 
-	}
 	return 0;
 }
 
-- 
2.21.0

