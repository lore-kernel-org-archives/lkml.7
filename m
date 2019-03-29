Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DED5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0611D218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="D0JHjCon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfC2JeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:34:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55127 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfC2Jds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:33:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so609182wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JM1IFJaq9Fzy9jb7gkxjcG7uHNdo0C9cZXORwZYID2s=;
        b=D0JHjConPyyO0cRxQv1PUTZqVI3WTeq57J3FAP2XyHi2rJUUNI5ZC5L7oc/E6tlcJN
         pKNHgYGDM1aPFyKvAHOx5g33iVr1PTs45fCR7PCDPkoMwaK3YfH7RUk2J3PBNkEA4rBx
         sYENWcWooDcJodHMYVS5WMlwCz84djynJF+xtLKkE856uw5WapRrfx8t5I/axUlT05el
         Z28geVAWnsVKjM6IiysviN72ZTQI5oAQAAgMrm8iM9YB/HhM7CiR+4s/ZaZHhKAFbuf/
         Gajlg7u54ny33L+HlpaZvMnZhVpGiBVJahmZS8Qsum5UFEK40GnEuuS3GpBfj74Ty3x+
         hdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JM1IFJaq9Fzy9jb7gkxjcG7uHNdo0C9cZXORwZYID2s=;
        b=o7iWJbOqyoOQgfE4NCQsGttQnp3PQKZCniNByZIq+B2rT0oY3PwpGEBnpwsIuqG64x
         C9B5p21HHemutavJdcAT/QOp4Zyb4+yoj23kQOQJ/k1eDDGqW8tqATAF8pjX9ORizC9H
         JPN89fxN7SRcu0tY0YrmJYQFtUPNKAe1qQ85XgjJNTWZQmZ6BaOfJ/lnf/iN6ESxcqer
         ZjDnyee0cVYKjHhXs2SSqWGP/swCGyOvI2cAonvYnXQpTaNFmTG8BJHV48HoN5uLJnuw
         6Jl1v1sZOXYwiyQ+JE0Gsq9vOZdycbBolkVsbc/eRuffWlD5MaQl1USJx2JL7Krx5k4Z
         USUA==
X-Gm-Message-State: APjAAAXMqP/UaYxukX7vAGgAFLLyuePhlYubxQubi2LsJwG9snC/L9ph
        nQZoTq5gHoVbBJCHZ8KvdWWUcg==
X-Google-Smtp-Source: APXvYqxBhAX2VClwpi4aYDKKs3DFdRs9olKE3HhUScClXiKL60lGO7CW7XC2L6AlxrsLRV/60+rvBw==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr3028614wmh.93.1553852026829;
        Fri, 29 Mar 2019 02:33:46 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id s12sm1957125wmj.42.2019.03.29.02.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:33:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 4/6] ARM: davinci: omapl138-hawk: add a fixed regulator for ohci-da8xx
Date:   Fri, 29 Mar 2019 10:33:32 +0100
Message-Id: <20190329093334.3885-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329093334.3885-1-brgl@bgdev.pl>
References: <20190329093334.3885-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Instead of directly using the vbus GPIO we should model it as a fixed
regulator. Add all necessary fix-ups for the regulator to be registered
and configure the vbus GPIO as its enable pin.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 49 +++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index e244c8648594..0039b4d4c935 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -21,6 +21,7 @@
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/ti-aemif.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
@@ -298,15 +299,50 @@ static const short da850_hawk_usb11_pins[] = {
 	-1
 };
 
-static struct gpiod_lookup_table hawk_usb_gpio_lookup = {
+static struct regulator_consumer_supply hawk_usb_supplies[] = {
+	REGULATOR_SUPPLY("vbus", NULL),
+};
+
+static struct regulator_init_data hawk_usb_vbus_data = {
+	.consumer_supplies	= hawk_usb_supplies,
+	.num_consumer_supplies	= ARRAY_SIZE(hawk_usb_supplies),
+};
+
+static struct fixed_voltage_config hawk_usb_vbus = {
+	.supply_name		= "vbus",
+	.microvolts		= 3300000,
+	.init_data		= &hawk_usb_vbus_data,
+};
+
+static struct platform_device hawk_usb_vbus_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev		= {
+		.platform_data = &hawk_usb_vbus,
+	},
+};
+
+static struct gpiod_lookup_table hawk_usb_oc_gpio_lookup = {
 	.dev_id		= "ohci-da8xx",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", DA850_USB1_VBUS_PIN, "vbus", 0),
 		GPIO_LOOKUP("davinci_gpio", DA850_USB1_OC_PIN, "oc", 0),
 		{ }
 	},
 };
 
+static struct gpiod_lookup_table hawk_usb_vbus_gpio_lookup = {
+	.dev_id		= "reg-fixed-voltage.1",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", DA850_USB1_VBUS_PIN, NULL, 0),
+		{ }
+	},
+};
+
+static struct gpiod_lookup_table *hawk_usb_gpio_lookups[] = {
+	&hawk_usb_oc_gpio_lookup,
+	&hawk_usb_vbus_gpio_lookup,
+};
+
 static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
 	/* TPS2087 switch @ 5V */
 	.potpgt         = (3 + 1) / 2,  /* 3 ms max */
@@ -327,12 +363,19 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB PHY CLK registration failed: %d\n",
 			__func__, ret);
 
+	gpiod_add_lookup_tables(hawk_usb_gpio_lookups,
+				ARRAY_SIZE(hawk_usb_gpio_lookups));
+
 	ret = da8xx_register_usb_phy();
 	if (ret)
 		pr_warn("%s: USB PHY registration failed: %d\n",
 			__func__, ret);
 
-	gpiod_add_lookup_table(&hawk_usb_gpio_lookup);
+	ret = platform_device_register(&hawk_usb_vbus_device);
+	if (ret) {
+		pr_warn("%s: Unable to register the vbus supply\n", __func__);
+		return;
+	}
 
 	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
 	if (ret)
-- 
2.21.0

