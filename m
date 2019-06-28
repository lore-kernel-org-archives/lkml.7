Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97640C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F9121773
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="e4MZgyhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfF1KDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:03:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33012 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF1KDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:03:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so8997153wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwsPk5YbJoDix1Y8ZNEpxUoFdLsjdX1Ck3sCZ4BgCIs=;
        b=e4MZgyhkaBCcepB2UsfuVfMG6ppjiDnGbz9M79hYKRlZFD1dfOZfKqq/Z6s3I71WSy
         6EWWm6HcpnfPlDylc6RkNICWKI20aotoUFlMqVqwI7XmWNhUr3um5ww6jiMDFo8OsYPU
         5tBd7f9XIBXqM1+IIDt8/VvJ36ZmYODC22e48EWw78V3Oe+BvkiEQMBA+21buJ9Ozd6h
         stDj8jo5MynT4DCP4CIhUwPrIMVVxqfWSJeapQoVc1FODSlcZ/q0XKVmRfFCnxyVVgGJ
         g0I6ZmlL1WxbdI6TPIYy9H9c7W4+vZYJaNAyIDPV4bRKIzfHHdP9S9u5nVHzVPvxI/l7
         Rpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwsPk5YbJoDix1Y8ZNEpxUoFdLsjdX1Ck3sCZ4BgCIs=;
        b=CFrAnkEH2EQ1Dmhd9+gFoG/ondhHq2kTWUK1KnSPQV7rwk5idbj+F/Ord9F3DLcVIV
         ChRItr419Ez9w9SaB7WJyHpkKkmkpBCo+BCWkkjrs2mtOWYrhpFfZIgV2w1ntEiyJCLY
         lpGMQSlMxx+i7Ryag/oxtPgqcXmWZZR6+0xWmFVKbkCrDpXRBW3KvA3JUVha/B5hvPnw
         cLujOCW6geBxpsTvDkT5S+0q7NWfRZ8NbB9llxNg8q/Q2L4YtLyK4aMhSaJ8QeD3f1h4
         S+CeMO15JgIUrne8MqnJpWqaqoBBuq31ev+3VHtmw0XuztKFnGeHMz6zaNN4TTnNK3r0
         V7mA==
X-Gm-Message-State: APjAAAW6PipGXZ/eu6eo7EOv9oNEHWqOgVGDxFmo7L0kQ4IEM47i9JS0
        +yZSF1sRB9enJWuVgyVVePGUTA==
X-Google-Smtp-Source: APXvYqwFiCb2shM2kiGTN1aAGEpRy7nSuxeCbB/BtOrmU69Ws9UfeMtcBbJczJme1reWj0RNCFudtQ==
X-Received: by 2002:a7b:c206:: with SMTP id x6mr6707413wmi.156.1561716184473;
        Fri, 28 Jun 2019 03:03:04 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l124sm1628874wmf.36.2019.06.28.03.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 03:03:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH RFT 1/4] sh: ecovec24: add additional properties to the backlight device
Date:   Fri, 28 Jun 2019 12:02:50 +0200
Message-Id: <20190628100253.8385-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628100253.8385-1-brgl@bgdev.pl>
References: <20190628100253.8385-1-brgl@bgdev.pl>
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

