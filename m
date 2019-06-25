Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFFEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC36208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dsz03gRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfFYQfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35789 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbfFYQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:35:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so3660153wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjvgqiqZzglCEryM8XBbJiMmioEThPc/Ew98mkOW+30=;
        b=dsz03gRN+B8sj18/khuc/IOGJ4ZAac3MpDKb3Zv/Bc9PoYBZsScWcIBR66+WT13q4A
         tN8EW3Vfjzl0srOYa1HtJEj4YWDxKeLJeFxcOpAU1yqzULbgKdw7lI1k9uJYS2TLwLfq
         nJu10QxZk+xzeoc8TdS7m0YAZ+oQffTcRYbFO9YXz55433gHQs5zlWTN1V3cyKJa1Q2A
         iPJuT54NssEe53FbS36r8nVdcdRnBqTyep+QMieQHsg6JfL23Iqv4l0ggpRn13oHMR0p
         AZG9QARW/pNBZ52Cg4cBykzft5A+BRios2hbeleUvawVzlsiZYnAcBm99WZBoCSgvzcU
         PqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjvgqiqZzglCEryM8XBbJiMmioEThPc/Ew98mkOW+30=;
        b=iT+U46MlGAfz/s6FyubSEAxjc6PPSdasOr4IK4snznW6yLTGBbkY03ziTK7ZgtCtAN
         hjVH9zu+SyrTXDUUg5DuTYHraJUQeS7DmKvhqu/CViARpXs3qpJFvPyICboQsevhQUmp
         AMLbWqkhiWVCZh9ZGZyqB3go5cUMelttLWQKoUrZ/72Q8m13xiNlWRi+tkNpQhBOroLL
         Mky0lhsWpvDnoZHG69jADBylpyeCO9Ib7aeD8SAV+bgQ9NwM3z9HhSf8x+bw9AqnW853
         TEtcOHwgjGKXmdk05FliKbARpNMozzIjwCjZmpRv9W3aVoovJ06NdANG0JSBJkFn/dmK
         lR8g==
X-Gm-Message-State: APjAAAW8bOr4C+D1Gz4kawXGNe8OyDMa30LCaOsrGnUjhFHiz6HdvAdt
        s/FlI5qpNcvELB+HBZr2bm0gyw==
X-Google-Smtp-Source: APXvYqz13wXYAnILJ9E9trPlEzD6Yeo7CCy/mNFNreUVqazy0miJn87+1vh+k2XQcsjx0bfSNxAnqA==
X-Received: by 2002:a1c:c74a:: with SMTP id x71mr20501151wmf.121.1561480504153;
        Tue, 25 Jun 2019 09:35:04 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:35:03 -0700 (PDT)
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
Subject: [PATCH 10/12] fbdev: da8xx-fb: use devm_platform_ioremap_resource()
Date:   Tue, 25 Jun 2019 18:34:32 +0200
Message-Id: <20190625163434.13620-11-brgl@bgdev.pl>
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

Shrink the code a bit by using the new helper wrapping the calls to
platform_get_resource() and devm_ioremap_resource() together.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/fbdev/da8xx-fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 328de29c4933..4dda194d6b8f 100644
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

