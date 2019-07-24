Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F0C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5463821BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="T4HKhvlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfGXIZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:25:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35315 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfGXIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so45952546wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKxkD02366JB5IdAqT4wbLtrtWIwI1gSRslxcR13y+o=;
        b=T4HKhvlgZIWgcdonCwhUhZ3z+OEMFR/VSNhly7EEEAg7ipweH4u94whK9fTSYtNalr
         A/ZDt1qF8tnciMbF2GaMwoANWwTw7ibVTh+qpbN9eBDzTNuBikvlgWFT3/W8yXiQ65o+
         L/Kfld+bCNV5HT2TCqpZdB3NEHBbGHbb7eXfQ34QumXq6miX6zEK0ZL6/RoERC8e7NXf
         aAgZY1kRFmPwv/Eftv11bIuUf9DzGT0ijX+XdWtnBOLMkYwa0ok6QAqfUmY823CadqWv
         34VWd5C7zkUqo3+hjF9c0SbM7Dzuz9p8gjzOV3rlJsApgvJndtsV5/LhA45zTSLsby8S
         u4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKxkD02366JB5IdAqT4wbLtrtWIwI1gSRslxcR13y+o=;
        b=pJ3ZzP7QvtB/s2h7Jpbg6YQDPwPZ3d1SK0q3pjDLHhXPQMDKwXrGePM+6VS8Cw3ciY
         S4zMO5WvZ30FlGV9SVvl6zTO2b86XlDqd5ZeVaZg3SoR7wvWQFkqsSsU5jQiAGV7Ztfb
         TyVQol5/3ZA8xF6VGM/ouwOnGzDQkN3AAqNzqm7hc20Zj9fBxyqKrUFtiaAHjE+Q07hj
         UEOJh+Hjn8a7WAm314oL6+OHyrkSn8fJa+3esm0HAg5N29XaDL1K4ICeAVsKrL/7m5cu
         UTnFX+imVj2rrVcVZwzIMhU63qvrjXq7opt0NDHFh022FPMx/zt3zZF8sJNqovVl+cAo
         si2w==
X-Gm-Message-State: APjAAAXgFsbSQlT8Ad0znpC05xo9zSid4D40OhtbtXgtUJlkiXBNoHIB
        eiZAhmBWb1YkpvwXqgdh5Go=
X-Google-Smtp-Source: APXvYqxE5ySVYgSPMcOzXIlVOzVvl/0vcbAThP9xQsCe5hN1x3daHr7gg6o2hBdJ3+G8SsYPeq5fzw==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr36709389wrn.240.1563956713776;
        Wed, 24 Jul 2019 01:25:13 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z7sm42393880wrh.67.2019.07.24.01.25.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:25:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/7] sh: ecovec24: add additional properties to the backlight device
Date:   Wed, 24 Jul 2019 10:25:02 +0200
Message-Id: <20190724082508.27617-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190724082508.27617-1-brgl@bgdev.pl>
References: <20190724082508.27617-1-brgl@bgdev.pl>
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
---
 arch/sh/boards/mach-ecovec24/setup.c | 30 +++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index f402aa741bf3..6926bb3865b9 100644
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
@@ -1464,6 +1478,12 @@ static int __init arch_setup(void)
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
2.21.0

