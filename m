Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CE9C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC1121955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uzNFC9Rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfGVNos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:44:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37050 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbfGVNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:44:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so14418466wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fl6PbtQINJTgpZP0DL3/QcbGxfGTmAVvPv+f3ONzLQ=;
        b=uzNFC9RrjNkUHabQHG9WmUr7OQn69AM0PvDTmxkN6UU3iLj75HPsh6z/G20kHYjCL1
         IN2xx5t/pLvM5Ra7AHrUbHMtKcw7gxkAqWsEwOry13CCxFtypAgZQB9LAOnM/iNEdRLL
         EXx6/m1WT4Pxb4xCZrs8VW2nQEemNswoJFKRnfWV0wpWxsiaXCESakmG56JneLx9E7q5
         4drQgTV5jzPxfWJiLtRgYdVm0S+8wJqsIHHQ3PJSM7G2s9PHYFq98DtY66BJSOmOZCSr
         ZLmTZqObitwllxpxBylZ5HnY7o5w2bK5loW4mGFPZJYH1gTaqllEu6BesuBEkcaX3n2P
         dEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fl6PbtQINJTgpZP0DL3/QcbGxfGTmAVvPv+f3ONzLQ=;
        b=ZLiv4b1RTPMR5EzB8lRxYL1Apz5jSnMaaCVXAWPAkRUdTVfKMYRBGajTkEbYx/ul1n
         ho6ty1CL0s4zJtdzv4Du3dLWkVTORt/a+i/2EE6WUvgIKSVn0N7fiGcx2krF4yJNTqgH
         ta3lpjpZsuv1n6yt15ITADdyv4GjnYLxRr1NCtmK7i85ezhdii205hjegkg4a1PnyGGl
         AzlBVfvvU5fiI2RWAO/7ftQY4GNxU50/FNXk/10x3weHvs/HQ4HS5+R32VdH/3BYMgh9
         yC26e+qiDJawiZqlzWavZnPSUunjcN4MBFJFZRMeqDF2vrecV/tbfbs5MA6/IIFhpB+4
         oEGw==
X-Gm-Message-State: APjAAAVnj4ISOiDAmekVqQo1DzoimF6BRXKuXh5LK/Kjf0VXPY0bgzYh
        bU1UQfnaDIo4mqIf1al1BjI=
X-Google-Smtp-Source: APXvYqzB2urAdCfkcFcjTViZIEFF4ByHCqhBxlw/o6zaUTstYzcPFQFxzde+LpDToOCHUOqyK7J9tQ==
X-Received: by 2002:adf:f104:: with SMTP id r4mr78354246wro.140.1563803084525;
        Mon, 22 Jul 2019 06:44:44 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id p6sm40652484wrq.97.2019.07.22.06.44.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:44:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/9] ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
Date:   Mon, 22 Jul 2019 15:44:19 +0200
Message-Id: <20190722134423.26555-6-brgl@bgdev.pl>
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

Now that the da8xx fbdev driver supports power control with an actual
regulator, switch to using a fixed power supply for da850-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/board-da850-evm.c | 62 ++++++++++++++++++-------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index ac05d4838f1e..5b3549f1236c 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -803,12 +803,6 @@ static const short da850_evm_mmcsd0_pins[] __initconst = {
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
@@ -828,28 +822,61 @@ static const struct platform_device_info da850_lcd_backlight_info = {
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
 
@@ -1459,7 +1486,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: LCD initialization failed: %d\n", __func__, ret);
 
-	sharp_lk043t1dg01_pdata.panel_power_ctrl = da850_panel_power_ctrl,
 	ret = da8xx_register_lcdc(&sharp_lk043t1dg01_pdata);
 	if (ret)
 		pr_warn("%s: LCDC registration failed: %d\n", __func__, ret);
-- 
2.21.0

