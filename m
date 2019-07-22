Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF400C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889DA2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x1y+r829"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfGVNop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:44:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52751 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfGVNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:44:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so35241995wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwe8A6dusI8g3EU+MAhcchYTHGl9r3ZdFpQ26N/cCWM=;
        b=x1y+r829Kmv8VT1o1u/ml65RFsTDcW6H6q+k8jsc1IUXKtlf4+M9LoIwaGxdwsfBVW
         Maly7KAB6TUaNZNDKKWV+kRUXaWjeWkZboVfA7iRMdtBWECjwEKT712uBvKcbEvioykk
         v4WelV8e3g8+3hPq0saqdrlgmL9usULnfe3K3kxi8tCuqfp4eGGDq399czY+1ZOngK6u
         rrNGU9nUoH/7JXXEgcFVvbBFYZawUqs1hRmS48zFpX7BvADm64dbGx6C6ppPaDNHGl4S
         wwGAX0GfIFRa037mnj6e0VNOg4oaqSr8E0sHYjAvnwB0uMmdm4LcUZEIosdh/rMF38lP
         qE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwe8A6dusI8g3EU+MAhcchYTHGl9r3ZdFpQ26N/cCWM=;
        b=ASHPgNds+2HTgruVrerX7W96Cko9CD1KASNmS39MnGBsCM0UUs6pNacvyrUMEG9PVb
         9/xwgs1YUuQkuazUw1Nsm6qsYg5LR13WRUaFbDoJ7Z8zH1OJmvo/5Gpoo5egQ6CSoqij
         uY4mu6cyJy4fkuXf7QRIjL7HpldjaI+tBHeE3CKCEo4YrDct6bEKnUr8z3Jqu8fG0MlR
         2k0KSkFV4XS0TSFtdQc64SPpu9v/MBffglshVuYhr53DI9Hodzbj0paJiH+rRmCSGZ8H
         Lv76XiFBQBA+RfuavmEMfSo2rVSkIo9WkllDsjWSjMgimMHEF8+cN2cpCTqy3YelJicX
         kwPA==
X-Gm-Message-State: APjAAAXNLxHWgFoj6ilTNYuj5LrUreK3KQQrm9CvcOYbknChVraVoV1w
        qEUMkFL5Xvsy8gOgtd1ntZw=
X-Google-Smtp-Source: APXvYqzo/YYqTVi5D8NUKu0A6bOHmsiYuaGRepo2J0qmuAZjjv4mu5dWS7KsdCNQdsEJsW5c/D2z1Q==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr65270937wmf.111.1563803082072;
        Mon, 22 Jul 2019 06:44:42 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id p6sm40652484wrq.97.2019.07.22.06.44.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:44:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/9] ARM: davinci: da850-evm: model the backlight GPIO as an actual device
Date:   Mon, 22 Jul 2019 15:44:17 +0200
Message-Id: <20190722134423.26555-4-brgl@bgdev.pl>
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

Instead of enabling the panel backlight in a callback defined in board
file using deprecated legacy GPIO API calls, model the line as a GPIO
backlight device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/board-da850-evm.c | 40 +++++++++++++++++--------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 0628e7d7dcf3..ac05d4838f1e 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -36,6 +36,7 @@
 #include <linux/platform_data/ti-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/uio_pruss.h>
+#include <linux/property.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/tps6507x.h>
 #include <linux/regulator/fixed.h>
@@ -804,34 +805,49 @@ static const short da850_evm_mmcsd0_pins[] __initconst = {
 
 static void da850_panel_power_ctrl(int val)
 {
-	/* lcd backlight */
-	gpio_set_value(DA850_LCD_BL_PIN, val);
-
 	/* lcd power */
 	gpio_set_value(DA850_LCD_PWR_PIN, val);
 }
 
+static struct property_entry da850_lcd_backlight_props[] = {
+	PROPERTY_ENTRY_BOOL("default-on"),
+	{ }
+};
+
+static struct gpiod_lookup_table da850_lcd_backlight_gpio_table = {
+	.dev_id		= "gpio-backlight",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", DA850_LCD_BL_PIN, NULL, 0),
+		{ }
+	},
+};
+
+static const struct platform_device_info da850_lcd_backlight_info = {
+	.name		= "gpio-backlight",
+	.id		= PLATFORM_DEVID_NONE,
+	.properties	= da850_lcd_backlight_props,
+};
+
 static int da850_lcd_hw_init(void)
 {
+	struct platform_device *backlight;
 	int status;
 
-	status = gpio_request(DA850_LCD_BL_PIN, "lcd bl");
-	if (status < 0)
-		return status;
+	gpiod_add_lookup_table(&da850_lcd_backlight_gpio_table);
+	backlight = platform_device_register_full(&da850_lcd_backlight_info);
+	if (IS_ERR(backlight))
+		return PTR_ERR(backlight);
 
 	status = gpio_request(DA850_LCD_PWR_PIN, "lcd pwr");
-	if (status < 0) {
-		gpio_free(DA850_LCD_BL_PIN);
+	if (status < 0)
 		return status;
-	}
 
-	gpio_direction_output(DA850_LCD_BL_PIN, 0);
 	gpio_direction_output(DA850_LCD_PWR_PIN, 0);
 
-	/* Switch off panel power and backlight */
+	/* Switch off panel power */
 	da850_panel_power_ctrl(0);
 
-	/* Switch on panel power and backlight */
+	/* Switch on panel power */
 	da850_panel_power_ctrl(1);
 
 	return 0;
-- 
2.21.0

