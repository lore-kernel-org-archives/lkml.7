Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C66EC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F174D2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="i50Tzhxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfFYQfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34846 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbfFYQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:35:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id f15so8743675wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAOkVHO1BfkTnSJLTBWlqsTsKKDk8gdZ6nODPU4c1tE=;
        b=i50TzhxoE0EVWRZb7FuSgJwILA4rx2iPG77Mv3xcrrEJhVN4B/h7MPBBWVugqYxWp2
         z/toOghI0xFLzo4j20BFkcTCK+t9oS1ur5Zxjuv68/EUxdI7HLW8oC2Nj9IGNwbxlkcf
         ppV6VXclq/A8Z0b+pcsB0R3xp2T8dBZGYEgPFrzfJRHQCawfFi+1EpUaRPuEwp5oe/TE
         cjUFukQoM00ogBXYvTqt763tfq4G+xwbOAaEuus8bhR4jpNdbtNk1PP3kxzDeiAC6IY4
         zhd+wjbHvP1qPE3kwpdpje4Jp/GVei4mLQW7Kg6+P3xNN65ClIzjaWSbuQstQ63Hv5H+
         570A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAOkVHO1BfkTnSJLTBWlqsTsKKDk8gdZ6nODPU4c1tE=;
        b=NCsluOrBln3/O5BuKbmTzLvumTu3rModK5moC95ivk1OeiPKrSiP4rM+K383GCSL1h
         Lq3ED/P0De7nqYNSZWY9oj7sntwviCCiCFDPJgNqgqP/uYG6/mAoCkE/CTe9+xf1h3/p
         FqoTILHp/ECxEVRFKWwODGqstef2dbDw8AJC7gUpqQMcX1G/HZTwQRmBo/zAyg5Whcn8
         uyFZiBtkmvZWots9GoQ4fUoRbkLFuIMa5U+jKVaqzQ2dDzPgF9Mscer2yb9Q2/xwIdPO
         fzccWKyBtJjhrYdUBGOe3x3+ktYeYVwQ5hNoMGIg3vXzOK/KsoKjNTks7JxD7c6NIi56
         JtBg==
X-Gm-Message-State: APjAAAXqzzn+PUaVGYkxxvf11LPj6c1pHVEtQEY8lL/fGRUE09bXfySG
        fKwPGabFsfYWIculkeUbvHrwHw==
X-Google-Smtp-Source: APXvYqytytlRfo6YGBjwFJZaCuSVzWH7Bv4+NP+iZBeBXrfYOEHyoR/Ueaj3FUGfeHDYPIHfHNmD2A==
X-Received: by 2002:adf:e691:: with SMTP id r17mr62365819wrm.67.1561480505225;
        Tue, 25 Jun 2019 09:35:05 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:35:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/12] fbdev: da8xx-fb: drop a redundant if
Date:   Tue, 25 Jun 2019 18:34:33 +0200
Message-Id: <20190625163434.13620-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
References: <20190625163434.13620-1-brgl@bgdev.pl>
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
---
 drivers/video/fbdev/da8xx-fb.c | 43 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 4dda194d6b8f..6b11a8108108 100644
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

