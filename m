Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02898C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC6E21921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oH8iUy0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfGVNo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:44:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52057 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbfGVNos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:44:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so35255884wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4loNub9lZdf1BYbpDmPVljkc5Kvved+HB+y+7xouaI=;
        b=oH8iUy0oCnaW2Mj2oJVlsoemIUP8GHJDmj4c0Hhq1B7mUftxPx8dg/swAXck0y7vVj
         Mho02HKkJP6iU/GOP71E8UtNkq3htYFze5MLOpgnEfIZulqm56DRXeb0yfpW0Ih/mA0y
         mA20gdd2iFt1rhmUHR5ogbyAGbfismVQWV+0YvUHKq1Ph3dvkjlljMELrAqpr0pFQq6y
         /pOvdpePXRbqz5XSN8fVri9t/pbpajVy6F0yvwaEN2IsyLVtRxecIsdnK5vKZHPrLCST
         EkfiZmroKigK9Qqc/f4QQoSkUMi98Z336uS79OAMdWTiaS+50eHOcnu7JmL4MJ8OCYkm
         y6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4loNub9lZdf1BYbpDmPVljkc5Kvved+HB+y+7xouaI=;
        b=HoDW0c3P4BrkDUkSugEMSPrnxjMAdAkGyXgC16emg6C8EGYW5IBs/pGSblyta6Rvcp
         Dg0VIOILNydyHOlS2sLQUmZ/Gyxlz/L3t5nu0YrvIEVwgm89f/dEo3BhZIt4o2nxViNB
         CEc6Gkgm/PLlYgJuE7kYbi57xrRuzn5HfJzwZrPOsDwH9IG0oHWUiDVEfbdXtqxCJ5pB
         HBrAS8jIDT/qHFKvg1Gkwa35ywBuFCS9Y8XfXJzqIyHz1pZ3FTCx2r50gUAjxd1pa4/v
         R2X8j8NmpOeGIY5tHkqpWvCIVVOcjbg5QemOnL8xf8QsyZAPtXRYTqozMytLjBpksW/d
         ziPg==
X-Gm-Message-State: APjAAAVNYUc/eVQ/eo1vDJiDVthMxi96VTsqgKhTcEhWBDUTwkQfJSSa
        lAAnNILf6tg2Z9ba7RssDCM=
X-Google-Smtp-Source: APXvYqxy+WVOLlDEGPN7MS1uXI0lN7nEos9pc3ewXzM+Z/h/Dxcsr3WmJetxjWHaQPwMOxDUXEh+Pw==
X-Received: by 2002:a1c:f918:: with SMTP id x24mr61496788wmh.132.1563803086629;
        Mon, 22 Jul 2019 06:44:46 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id p6sm40652484wrq.97.2019.07.22.06.44.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:44:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 7/9] fbdev: da8xx-fb: use devm_platform_ioremap_resource()
Date:   Mon, 22 Jul 2019 15:44:21 +0200
Message-Id: <20190722134423.26555-8-brgl@bgdev.pl>
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

Shrink the code a bit by using the new helper wrapping the calls to
platform_get_resource() and devm_ioremap_resource() together.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/da8xx-fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 19ed9889c8f8..f2f66605e8fb 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1339,7 +1339,6 @@ static int fb_probe(struct platform_device *device)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata =
 						dev_get_platdata(&device->dev);
-	struct resource *lcdc_regs;
 	struct lcd_ctrl_config *lcd_cfg;
 	struct fb_videomode *lcdc_info;
 	struct fb_info *da8xx_fb_info;
@@ -1357,8 +1356,7 @@ static int fb_probe(struct platform_device *device)
 	if (lcdc_info == NULL)
 		return -ENODEV;
 
-	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
-	da8xx_fb_reg_base = devm_ioremap_resource(&device->dev, lcdc_regs);
+	da8xx_fb_reg_base = devm_platform_ioremap_resource(device, 0);
 	if (IS_ERR(da8xx_fb_reg_base))
 		return PTR_ERR(da8xx_fb_reg_base);
 
-- 
2.21.0

