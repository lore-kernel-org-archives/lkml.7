Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586EEC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3152D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mi3aYH33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfFYQfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37618 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbfFYQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:35:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so18635423wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5d3BfSnmnwO/hS4dFGhcrIk5LVowo1/qQQdF1Vy3jk=;
        b=mi3aYH337XfZeD6KCGPODvIEDc6lpAsrLiBKenynyTgeBAflzEuAFOSSRaIv7QCcw0
         cU5hYTlgn0flazzm/uE9V2gsr0kjBHT5y/98Qo74IaK5b50eEFHQWnCUmKzphCf694cO
         LDW7BmNVzoFJZ5NIlzjd+HVONir3l9AyrAj5png44VBdtFHeh3uryIXOkGa1wJPvA5LN
         WvCLOTnyGe8CkM/Fz5OUnv1HjtcHnzID+6CRcBFR3JznXuOHp5DQfeF10qw9RKY3r25S
         CYTFos7dPmJNHROYanCTBvFs7gU6PLh/xVeNfeRVmRWdHzC44plIWFbBhF8yvimaw5KZ
         jexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5d3BfSnmnwO/hS4dFGhcrIk5LVowo1/qQQdF1Vy3jk=;
        b=F+aKa6c6RrnumESyLwHVuPD47JxK41OJoEOW9wE/zsaciwybf0iVfKrpXv6EH+AUYA
         eUkakeW2EHN5DUyXty9K5CgW+ySMpE8Icy36hyzAQf7kSSoDgd36YxXNfC2ag4Ah6b7w
         H4hJUEFBD7BE2gZxU7Kp4xn8S4Yh/bi3SS6+ZGRoW9FWHRLiEBK3Wtaq2FownSlMakkB
         9LNGxd29KpqFz/BnhOwWgQ5ikDLCG8CvGIkSORmqskXyvqRYtP1lXwVQKuuB89BzeAQ5
         jfHsj3PeCCMJRxQjkKstmI/jk/uRtV/p3YVfGKuPNPjtJttN6oQBuxCnfkG3g/e1Sn3W
         mWtg==
X-Gm-Message-State: APjAAAXXX9rzEoDeXKIhKvDLO7M3TK5PSCwBxEGrdSQJuKPVNP+ZdIja
        EbAOVj3+UHOAQEUEa5UEqmFhXg==
X-Google-Smtp-Source: APXvYqxYtpw4EEVsdGnQVBBLUuXARVZGsIrOsocPZwN44dsA/Y8ZCTQWBqOBfRU7qmBFqnACXLnZHw==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr71415wrv.45.1561480499309;
        Tue, 25 Jun 2019 09:34:59 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:34:58 -0700 (PDT)
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
Subject: [PATCH 06/12] ARM: davinci: da850-evm: model the backlight GPIO as an actual device
Date:   Tue, 25 Jun 2019 18:34:28 +0200
Message-Id: <20190625163434.13620-7-brgl@bgdev.pl>
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

Instead of enabling the panel backlight in a callback defined in board
file using deprecated legacy GPIO API calls, model the line as a GPIO
backlight device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 40 +++++++++++++++++--------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 31ae3be5741d..ffda623bb543 100644
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
@@ -803,34 +804,49 @@ static const short da850_evm_mmcsd0_pins[] __initconst = {
 
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

