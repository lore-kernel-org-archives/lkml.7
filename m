Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C9EC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632C4208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PH6PJoOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbfFYQfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39551 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbfFYQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:35:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so3624378wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPfiVDgc5mzijoolmBgAn7nj9hFIGXkNoey2vIeezPw=;
        b=PH6PJoOty745v5HCYWGPCWBeeSNGmb9UwwqkfUOiMl1dAeUCOfW64MYeP65AJk34q9
         QVGkrvI13TaiQUcKO3PAzYhR+SlYTOCGOCEmHOZl8pzZnDrgU3OgL2F4sF4t8Wuu45bI
         O0s/CEA9VySw6B9MT6SnlA85lLwIQMHTWKRdJ5dPWzlthv0Mp9kYKxLDYTI2NT9eAsHs
         9Bzih0UeynmsFxiAwYLqO5DU6VEut6rYd9k7eNOqFJNdg09L0b6P5zp0kJwKKrUMpgTh
         0ABqdJwysPXZFSMGHbolipLeMxh0463L8lROsmZybF2G0ckfGkRbbW/NOxebpA6Ut4Ft
         dJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPfiVDgc5mzijoolmBgAn7nj9hFIGXkNoey2vIeezPw=;
        b=Nx5KoCNsXB2jEOmoBovaAMjMQ+9iFAcRKId4TXvRJv9/VkjKYuwPOxo6eDoB/1n8TL
         CLayIpMIiARFoeS0xKu7xo7QUueGQFoEJCjbJ9wFm4oGLUGDijD0n2CZz0aszevziYkg
         K1HVzQPM0RoLGCw3SbNzBQclxFQAuu7QG+8UErvK+y6ArTfAg/EVyIC9kSxSXGDdNAYt
         +Sktkzfqzpr3XX2LDeVxZTPKrx63WhhDiQ5AM7cd9WNTqpq9LqaXwnV6CJO+6QlRQXnL
         jJCgHFXTE65ag94qb4WpoxcPifZ3NUzOQwThHD+lYh29F2MbnjCZ6eLYJxZ1LqB2W0Cy
         WAkw==
X-Gm-Message-State: APjAAAVob+Ua4Q+CrY0nbHho1ydhRHhTAuYzu/Ke296ajs57r9s0UjKq
        c6j/X63TbiNU+czN4ln1Vxou9g==
X-Google-Smtp-Source: APXvYqxt8oVzolPe1n9o8Uiv/T6+/noYyCssxvgjcGdkHFXUOpA/NNpR2yPO4gsel41nlJ0REFrQ8Q==
X-Received: by 2002:a1c:a842:: with SMTP id r63mr20223185wme.117.1561480501837;
        Tue, 25 Jun 2019 09:35:01 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:35:01 -0700 (PDT)
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
Subject: [PATCH 08/12] ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
Date:   Tue, 25 Jun 2019 18:34:30 +0200
Message-Id: <20190625163434.13620-9-brgl@bgdev.pl>
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

Now that the da8xx fbdev driver supports power control with an actual
regulator, switch to using a fixed power supply for da850-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 62 ++++++++++++++++++-------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index ffda623bb543..d26950f605f4 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -802,12 +802,6 @@ static const short da850_evm_mmcsd0_pins[] __initconst = {
 	-1
 };
 
-static void da850_panel_power_ctrl(int val)
-{
-	/* lcd power */
-	gpio_set_value(DA850_LCD_PWR_PIN, val);
-}
-
 static struct property_entry da850_lcd_backlight_props[] = {
 	PROPERTY_ENTRY_BOOL("default-on"),
 	{ }
@@ -827,28 +821,61 @@ static const struct platform_device_info da850_lcd_backlight_info = {
 	.properties	= da850_lcd_backlight_props,
 };
 
+static struct regulator_consumer_supply da850_lcd_supplies[] = {
+	REGULATOR_SUPPLY("lcd", NULL),
+};
+
+static struct regulator_init_data da850_lcd_supply_data = {
+	.consumer_supplies	= da850_lcd_supplies,
+	.num_consumer_supplies	= ARRAY_SIZE(da850_lcd_supplies),
+	.constraints    = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config da850_lcd_supply = {
+	.supply_name		= "lcd",
+	.microvolts		= 33000000,
+	.init_data		= &da850_lcd_supply_data,
+};
+
+static struct platform_device da850_lcd_supply_device = {
+	.name			= "reg-fixed-voltage",
+	.id			= 1, /* Dummy fixed regulator is 0 */
+	.dev			= {
+		.platform_data = &da850_lcd_supply,
+	},
+};
+
+static struct gpiod_lookup_table da850_lcd_supply_gpio_table = {
+	.dev_id			= "reg-fixed-voltage.1",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", DA850_LCD_PWR_PIN, NULL, 0),
+		{ }
+	},
+};
+
+static struct gpiod_lookup_table *da850_lcd_gpio_lookups[] = {
+	&da850_lcd_backlight_gpio_table,
+	&da850_lcd_supply_gpio_table,
+};
+
 static int da850_lcd_hw_init(void)
 {
 	struct platform_device *backlight;
 	int status;
 
-	gpiod_add_lookup_table(&da850_lcd_backlight_gpio_table);
+	gpiod_add_lookup_tables(da850_lcd_gpio_lookups,
+				ARRAY_SIZE(da850_lcd_gpio_lookups));
+
 	backlight = platform_device_register_full(&da850_lcd_backlight_info);
 	if (IS_ERR(backlight))
 		return PTR_ERR(backlight);
 
-	status = gpio_request(DA850_LCD_PWR_PIN, "lcd pwr");
-	if (status < 0)
+	status = platform_device_register(&da850_lcd_supply_device);
+	if (status)
 		return status;
 
-	gpio_direction_output(DA850_LCD_PWR_PIN, 0);
-
-	/* Switch off panel power */
-	da850_panel_power_ctrl(0);
-
-	/* Switch on panel power */
-	da850_panel_power_ctrl(1);
-
 	return 0;
 }
 
@@ -1458,7 +1485,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: LCD initialization failed: %d\n", __func__, ret);
 
-	sharp_lk043t1dg01_pdata.panel_power_ctrl = da850_panel_power_ctrl,
 	ret = da8xx_register_lcdc(&sharp_lk043t1dg01_pdata);
 	if (ret)
 		pr_warn("%s: LCDC registration failed: %d\n", __func__, ret);
-- 
2.21.0

