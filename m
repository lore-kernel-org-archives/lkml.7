Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E84CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8380020872
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HMLHp/EO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfJSIgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:36:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39177 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfJSIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:36:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so8151137wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2IW6NowdeBUIPfd3VNaI3dgAIYTgpRJtcprF0UeLqs=;
        b=HMLHp/EOn7D85bvZcEzeR75AlaOniQc19ENmHjj8gJXXdEEkq6jPm42L87jXMJEsrv
         sewZFUp34htOHovu0XlCfkXlcVXNND+ijmRLoBkT0CXyUBpBTtzL2MN1PzuN0Se+NIwi
         IC+V5Mt5H/7iKH7vTUOg0kCalZ3PwNEsWCuIw5VyQcln48tzMcrRVQkIJVVaSp0g4tWT
         tqGxZzPrS0Trm7oaF+Td7cyfMuWG8vuAWRMfbZSxpYVobQaZyJONblOO4q3VyTXZdFvg
         zMgaQMhUvogJWVDu0cKeilyNoJGYARpuA73fg4vIebg8CzLUFoi3V0FN6M/NZfjfYcBN
         6isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2IW6NowdeBUIPfd3VNaI3dgAIYTgpRJtcprF0UeLqs=;
        b=WHW7XAvFnUazoP0jBBpEvRDZYwTmCjvOoiLMSFQtlmv7MJGfA/ApuY3Rf6l2GZ4faa
         +vFUPTdaV4wIZyG0WDrTjbQ9nmhTzG42omYV/2XTFHBF/zpKAQ0HYLdnTEPOzG2KnLsY
         1m1EdS5dD29T3UJig6ujSSAkSqYhUZH2SK43nHUcWOfkxnJbeCWSVwMhAyVflU/d9OVe
         zLWbjaMfNTu+56u4VarW8yJuZ2kJrVt26u6UnX8ilYnrb1dXIZ4a2EyE7myNvpPvErJM
         Yy8p5e7uTA6OxQVMAi5APRbB98VGQ87pn6MUxDUcLrokft8jsIYA32hx7JZnUAeETTsh
         /nmw==
X-Gm-Message-State: APjAAAX6dvsfFt9fPyX1O9EApZGOLmLOxkjZp+V5r/W/d7PrBPITbN0W
        xHp39vwfCHw0KcDtfY1uNeKuAg==
X-Google-Smtp-Source: APXvYqw3NydOO+Nuq280jVny5Giey8kePuzmSc0rGbxCZeyXpiGDAaroan7UA2mv4I22jq8kYvhYpQ==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr10385114wme.144.1571474175115;
        Sat, 19 Oct 2019 01:36:15 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u1sm7242627wmc.38.2019.10.19.01.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 01:36:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 4/9] sh: ecovec24: add additional properties to the backlight device
Date:   Sat, 19 Oct 2019 10:35:51 +0200
Message-Id: <20191019083556.19466-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019083556.19466-1-brgl@bgdev.pl>
References: <20191019083556.19466-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a GPIO lookup entry and a device property for GPIO backlight to the
board file. Tie them to the platform device which is now registered using
platform_device_register_full() because of the properties. These changes
are inactive now but will be used once the gpio backlight driver is
modified.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/boards/mach-ecovec24/setup.c | 30 +++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index acaa97459531..aaa8ea62636f 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -371,6 +371,19 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+static struct gpiod_lookup_table gpio_backlight_lookup = {
+	.dev_id		= "gpio-backlight.0",
+	.table = {
+		GPIO_LOOKUP("sh7724_pfc", GPIO_PTR1, NULL, GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static struct property_entry gpio_backlight_props[] = {
+	PROPERTY_ENTRY_BOOL("default-on"),
+	{ }
+};
+
 static struct gpio_backlight_platform_data gpio_backlight_data = {
 	.fbdev = &lcdc_device.dev,
 	.gpio = GPIO_PTR1,
@@ -378,13 +391,15 @@ static struct gpio_backlight_platform_data gpio_backlight_data = {
 	.name = "backlight",
 };
 
-static struct platform_device gpio_backlight_device = {
+static const struct platform_device_info gpio_backlight_device_info = {
 	.name = "gpio-backlight",
-	.dev = {
-		.platform_data = &gpio_backlight_data,
-	},
+	.data = &gpio_backlight_data,
+	.size_data = sizeof(gpio_backlight_data),
+	.properties = gpio_backlight_props,
 };
 
+static struct platform_device *gpio_backlight_device;
+
 /* CEU0 */
 static struct ceu_platform_data ceu0_pdata = {
 	.num_subdevs			= 2,
@@ -1006,7 +1021,6 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&usb1_common_device,
 	&usbhs_device,
 	&lcdc_device,
-	&gpio_backlight_device,
 	&keysc_device,
 	&cn12_power,
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
@@ -1462,6 +1476,12 @@ static int __init arch_setup(void)
 #endif
 #endif
 
+	gpiod_add_lookup_table(&gpio_backlight_lookup);
+	gpio_backlight_device = platform_device_register_full(
+					&gpio_backlight_device_info);
+	if (IS_ERR(gpio_backlight_device))
+		return PTR_ERR(gpio_backlight_device);
+
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-- 
2.23.0

