Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9882CC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F126208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jrA5ZxxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfFYQfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50922 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbfFYQfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:35:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so3533263wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8CTKhWBWFU1fqIPJGLSNQd9vJ1aS8JWPNlYGCmcN8g=;
        b=jrA5ZxxSlBscH60wVMRBFqwb9J9maa3kZ+JU/Fp6J34myN9KJoXuFwMIV3ZMmz7DNl
         JG1+U+oqjwTTtkfTBwVSTD9L0stYYQBCQZkkcL3caSVFgC7U6RXMgCV/zfQrx45vdTPR
         ayJ9TIWzXGPqIe9iL9vtxCexuyN/YsuaVdU4T1Q4mDvSPLx+u2zB3+l0GtmMMSE7vAuY
         HbLhX9dVYD7+9Iarnn6PZ2NDdK94xvM49thFHPfOOqjj+zAUG4SbHrwUzjnbuK/64XdC
         3fSgoI3x6TSweLX2gY1e5b8i24ts0cvG/7te0F0uN7yuIYRTLlPHbaTRofncPw/XoXFE
         Gz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8CTKhWBWFU1fqIPJGLSNQd9vJ1aS8JWPNlYGCmcN8g=;
        b=OcOyxFDdeEGAJMeERNcsRpVYPqn0w8ISIIiOmtIt/6vIM6WzJfPzc9njcGu8baeSuW
         9hpv1tzjtx8fAK/GHLOp6rc06V6h5/1unSz01wI2cY+ubjpDIcvm19KHsxUvRvG1q4yY
         6UI3lVUsSr0YAbk5VNAHOgEwhn/gTKLWk8dyCuQg+CQWcEAuZ32X0d82RgUtn2VtsCdI
         HphqccSXqgaiPpVR0FIGIYejqaWnLPZditNX9koUdU5Of6tEautZDsLE+ya9VFRwxMhN
         zN/0locJhWCDDhMn3H8Z1rkQXAJViIAXRgWD2la/QtWK5uhmLYYHD6RNNnUGJeIZB7ug
         fsJg==
X-Gm-Message-State: APjAAAXDpwHhMSx7QcDvyhlERvETUYJLAOVCk/4XuIXsXyzrqyOCTAlM
        OX12L68w6ULVLCaJ+kCT7pDtDA==
X-Google-Smtp-Source: APXvYqy9vA8JJyTM1z74NApjY88ZDcDlQT7HuRw6dubZNjHezxo9Xp8wOa5eR0G69DpWTbPZXt+I1w==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr19922351wma.118.1561480502950;
        Tue, 25 Jun 2019 09:35:02 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:35:02 -0700 (PDT)
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
Subject: [PATCH 09/12] fbdev: da8xx: remove panel_power_ctrl() callback from platform data
Date:   Tue, 25 Jun 2019 18:34:31 +0200
Message-Id: <20190625163434.13620-10-brgl@bgdev.pl>
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

There are no more users of panel_power_ctrl(). Remove it from the
driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/fbdev/da8xx-fb.c | 25 +++++--------------------
 include/video/da8xx-fb.h       |  1 -
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 4fa99ff79f3b..328de29c4933 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -165,7 +165,6 @@ struct da8xx_fb_par {
 	struct notifier_block	freq_transition;
 #endif
 	unsigned int		lcdc_clk_rate;
-	void (*panel_power_ctrl)(int);
 	struct regulator	*lcd_supply;
 	u32 pseudo_palette[16];
 	struct fb_videomode	mode;
@@ -1076,9 +1075,7 @@ static int fb_remove(struct platform_device *dev)
 #ifdef CONFIG_CPU_FREQ
 		lcd_da8xx_cpufreq_deregister(par);
 #endif
-		if (par->panel_power_ctrl) {
-			par->panel_power_ctrl(0);
-		} else if (par->lcd_supply) {
+		if (par->lcd_supply) {
 			ret = regulator_disable(par->lcd_supply);
 			if (ret)
 				return ret;
@@ -1187,9 +1184,7 @@ static int cfb_blank(int blank, struct fb_info *info)
 	case FB_BLANK_UNBLANK:
 		lcd_enable_raster();
 
-		if (par->panel_power_ctrl) {
-			par->panel_power_ctrl(1);
-		} else if (par->lcd_supply) {
+		if (par->lcd_supply) {
 			ret = regulator_enable(par->lcd_supply);
 			if (ret)
 				return ret;
@@ -1199,9 +1194,7 @@ static int cfb_blank(int blank, struct fb_info *info)
 	case FB_BLANK_VSYNC_SUSPEND:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_POWERDOWN:
-		if (par->panel_power_ctrl) {
-			par->panel_power_ctrl(0);
-		} else if (par->lcd_supply) {
+		if (par->lcd_supply) {
 			ret = regulator_disable(par->lcd_supply);
 			if (ret)
 				return ret;
@@ -1414,10 +1407,6 @@ static int fb_probe(struct platform_device *device)
 	par->dev = &device->dev;
 	par->lcdc_clk = tmp_lcdc_clk;
 	par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
-	if (fb_pdata->panel_power_ctrl) {
-		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
-		par->panel_power_ctrl(1);
-	}
 
 	par->lcd_supply = devm_regulator_get_optional(&device->dev, "lcd");
 	if (IS_ERR(par->lcd_supply)) {
@@ -1639,9 +1628,7 @@ static int fb_suspend(struct device *dev)
 	int ret;
 
 	console_lock();
-	if (par->panel_power_ctrl) {
-		par->panel_power_ctrl(0);
-	} else if (par->lcd_supply) {
+	if (par->lcd_supply) {
 		ret = regulator_disable(par->lcd_supply);
 		if (ret)
 			return ret;
@@ -1667,9 +1654,7 @@ static int fb_resume(struct device *dev)
 	if (par->blank == FB_BLANK_UNBLANK) {
 		lcd_enable_raster();
 
-		if (par->panel_power_ctrl) {
-			par->panel_power_ctrl(1);
-		} else if (par->lcd_supply) {
+		if (par->lcd_supply) {
 			ret = regulator_enable(par->lcd_supply);
 			if (ret)
 				return ret;
diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index efed3c3383d6..1d19ae62b844 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -32,7 +32,6 @@ struct da8xx_lcdc_platform_data {
 	const char manu_name[10];
 	void *controller_data;
 	const char type[25];
-	void (*panel_power_ctrl)(int);
 };
 
 struct lcd_ctrl_config {
-- 
2.21.0

