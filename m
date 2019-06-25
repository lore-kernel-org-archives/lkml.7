Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F4C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F4821655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PYAuZLZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfFYQfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50917 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfFYQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:35:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so3533148wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrI0W6bS0McQj19QWXhKoVrTSOU0J8VgPihi8/PszeI=;
        b=PYAuZLZQuMDcDy7kn4Dp7xi/9RxRvvmyhWfmfEj68PC+BfshQ01WkAwGIFz2Da1Nu+
         fxfiOLaJUQq7w6ykZylcXfZUuPHsZ3QWQG9yMCbvo7QyQqz2UMUWT4l9Bitl3VVC6K2F
         L0TjcltZHBHKtRxFLyb/o3NDTieiROr8YZNhTb0X1rLsVpHx1JJ74w87BtRXHFzpCYQf
         Wjg+jLmX1G+RFC9yctx6GObshpk1AW2BRvH9tlZHm8ACITW1NnC8h0JpNJIgY6I59Tlx
         W1FrPl0FZrpBpkkF00+aiDfjd23rUrllhCN8yi7UD5PpvhOsm1qUbM3ztTMuRAB3EHQP
         29Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrI0W6bS0McQj19QWXhKoVrTSOU0J8VgPihi8/PszeI=;
        b=XhmH1SuhRmEwaqu5qGU1rwp46wA26+s2ULm+lyjSQKsoOXJhcvdb3+ZDQslIXFyKwn
         5iOS/Mo6TrKp9gcVOxDfm0O6kIDH14PfeVVE3Tk7onFkreT0Yr5Qxr1JRPlIZ4pm7f8U
         8/6H0KMjr1FfoS1NL8Xr3Dbe8BaIGnspmv1+lGT5zbPQcKoa4kbfx3ask2VUf2ncbpcd
         0y5s47LIhVzsD2VaryH4LUgCE2qNb7VgmdrMthgePtLAlIK91SgQnv1edaxq2aEwLMtO
         HmUskVxHc27t5wx1WXdNZu/r7Buv8rG850L89gMfanJTt/rV1ZHMSuVLe/B51a8R9Tmt
         05PQ==
X-Gm-Message-State: APjAAAWXTkFUAdrZSv4tOUo1wdymzT/hEdpYYZwZEyBaDvw3lGqyoH6D
        yaJr/hN4d6czuYgVwuyer50RZQ==
X-Google-Smtp-Source: APXvYqz3kMtpzixVnxZc9H1Kfh+kHcls8129A5lmZg5kt5LowzOPkBnkiHOHjACo8VCQc8yPPH0pyA==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr21077680wmb.129.1561480500524;
        Tue, 25 Jun 2019 09:35:00 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:35:00 -0700 (PDT)
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
Subject: [PATCH 07/12] fbdev: da8xx: add support for a regulator
Date:   Tue, 25 Jun 2019 18:34:29 +0200
Message-Id: <20190625163434.13620-8-brgl@bgdev.pl>
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

We want to remove the hacky platform data callback for power control.
Add a regulator to the driver data and enable/disable it next to
the current panel_power_ctrl() calls. We will use it in subsequent
patch on da850-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/fbdev/da8xx-fb.c | 54 ++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 9ea817ac1d81..4fa99ff79f3b 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/console.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -165,6 +166,7 @@ struct da8xx_fb_par {
 #endif
 	unsigned int		lcdc_clk_rate;
 	void (*panel_power_ctrl)(int);
+	struct regulator	*lcd_supply;
 	u32 pseudo_palette[16];
 	struct fb_videomode	mode;
 	struct lcd_ctrl_config	cfg;
@@ -1066,6 +1068,7 @@ static void lcd_da8xx_cpufreq_deregister(struct da8xx_fb_par *par)
 static int fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(&dev->dev);
+	int ret;
 
 	if (info) {
 		struct da8xx_fb_par *par = info->par;
@@ -1073,8 +1076,13 @@ static int fb_remove(struct platform_device *dev)
 #ifdef CONFIG_CPU_FREQ
 		lcd_da8xx_cpufreq_deregister(par);
 #endif
-		if (par->panel_power_ctrl)
+		if (par->panel_power_ctrl) {
 			par->panel_power_ctrl(0);
+		} else if (par->lcd_supply) {
+			ret = regulator_disable(par->lcd_supply);
+			if (ret)
+				return ret;
+		}
 
 		lcd_disable_raster(DA8XX_FRAME_WAIT);
 		lcdc_write(0, LCD_RASTER_CTRL_REG);
@@ -1179,15 +1187,25 @@ static int cfb_blank(int blank, struct fb_info *info)
 	case FB_BLANK_UNBLANK:
 		lcd_enable_raster();
 
-		if (par->panel_power_ctrl)
+		if (par->panel_power_ctrl) {
 			par->panel_power_ctrl(1);
+		} else if (par->lcd_supply) {
+			ret = regulator_enable(par->lcd_supply);
+			if (ret)
+				return ret;
+		}
 		break;
 	case FB_BLANK_NORMAL:
 	case FB_BLANK_VSYNC_SUSPEND:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_POWERDOWN:
-		if (par->panel_power_ctrl)
+		if (par->panel_power_ctrl) {
 			par->panel_power_ctrl(0);
+		} else if (par->lcd_supply) {
+			ret = regulator_disable(par->lcd_supply);
+			if (ret)
+				return ret;
+		}
 
 		lcd_disable_raster(DA8XX_FRAME_WAIT);
 		break;
@@ -1401,6 +1419,20 @@ static int fb_probe(struct platform_device *device)
 		par->panel_power_ctrl(1);
 	}
 
+	par->lcd_supply = devm_regulator_get_optional(&device->dev, "lcd");
+	if (IS_ERR(par->lcd_supply)) {
+		if (PTR_ERR(par->lcd_supply) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_pm_runtime_disable;
+		}
+
+		par->lcd_supply = NULL;
+	} else {
+		ret = regulator_enable(par->lcd_supply);
+		if (ret)
+			goto err_pm_runtime_disable;
+	}
+
 	fb_videomode_to_var(&da8xx_fb_var, lcdc_info);
 	par->cfg = *lcd_cfg;
 
@@ -1604,10 +1636,16 @@ static int fb_suspend(struct device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct da8xx_fb_par *par = info->par;
+	int ret;
 
 	console_lock();
-	if (par->panel_power_ctrl)
+	if (par->panel_power_ctrl) {
 		par->panel_power_ctrl(0);
+	} else if (par->lcd_supply) {
+		ret = regulator_disable(par->lcd_supply);
+		if (ret)
+			return ret;
+	}
 
 	fb_set_suspend(info, 1);
 	lcd_disable_raster(DA8XX_FRAME_WAIT);
@@ -1621,6 +1659,7 @@ static int fb_resume(struct device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct da8xx_fb_par *par = info->par;
+	int ret;
 
 	console_lock();
 	pm_runtime_get_sync(dev);
@@ -1628,8 +1667,13 @@ static int fb_resume(struct device *dev)
 	if (par->blank == FB_BLANK_UNBLANK) {
 		lcd_enable_raster();
 
-		if (par->panel_power_ctrl)
+		if (par->panel_power_ctrl) {
 			par->panel_power_ctrl(1);
+		} else if (par->lcd_supply) {
+			ret = regulator_enable(par->lcd_supply);
+			if (ret)
+				return ret;
+		}
 	}
 
 	fb_set_suspend(info, 0);
-- 
2.21.0

