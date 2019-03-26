Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA6B20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OrEKiMg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfCZP5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:57:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42091 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731475AbfCZP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:57:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so11498604wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fi53ij1K/FV0HXXK08Smgt19lpbi7fcy/SCdbK/jhdY=;
        b=OrEKiMg+9Ou8/jDznyyH/U1jZPDJT7dDsPHu5jqDLpg25175m5U4qLuDHHjGIwv6Gu
         tfbKNt2UuI55ydlK47FM2dKOovk1vgzZoth2pEaGyL6ewUTUPMVI6aYQt+sASC5iXSbE
         aE0Qt1UbdH9WVtBtURoecs9HJBrmdBy5aIc/xnYlDxwxnsIr1CUvJ91IZXuY5rlyC3zK
         CCCEmiG31EHlcT+qkjuesday19DM6nb1vxMhbnlnRZegKgRohm9EOWQ4z/NPtWt5+i6x
         83tX7Fz1jaWIuzDiCNzEtclKqX6s04O4ZCUwHz9PTeihgISS5AQMcvE7wsd/d2zlLQg9
         2Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fi53ij1K/FV0HXXK08Smgt19lpbi7fcy/SCdbK/jhdY=;
        b=P+iOL7HpX32TMqr3g6rwC/OhOcFp3sdEtqNP5hqPzJ57h3GzTiLaMSRKxXSKdt1K8g
         1ho6Ze8+m5Z52W3bKGXca5POhqCrOhCrWLkrKRgymRy7Wz5T7+DD3cf3anj8nDkp6h2O
         csRB7yF+cNjWdHx/VlVO9Y26DMSzFUwQ8th45DbLMjwgXKGhNc7jxNdhWl/SYPdQmfkK
         Wv88Dut+fgunJvOv6S9u7GnMhrWa15JATrie1Yk/i8doryj2WgVCplhGEkyaeAsJ8RFg
         MlPcdCFkRAqsMFvtvw2pEE1ktKkKZISED8ctyJjjMAe0Avn3hJSAH1vMsNLXKbWV6XhD
         8ucA==
X-Gm-Message-State: APjAAAXePqte6jxmaPddFojR+Bc1T9k1tBVaA6e31RQ/1JON0Q3V4l2G
        9y5oQtpZpF+1QyhAVvj4TyxKGw==
X-Google-Smtp-Source: APXvYqzhrAPxJruRDv7MCyTAjE/yvjaZbO0Ofuanv/eh0AwxC1c/i4MCwEQM7vjvH08MsIdaVWFLgw==
X-Received: by 2002:adf:eb84:: with SMTP id t4mr21459803wrn.100.1553615858033;
        Tue, 26 Mar 2019 08:57:38 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 204sm28522999wmc.1.2019.03.26.08.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:57:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
Date:   Tue, 26 Mar 2019 16:57:27 +0100
Message-Id: <20190326155728.5432-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326155728.5432-1-brgl@bgdev.pl>
References: <20190326155728.5432-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 48 +++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index ff097ecfa451..2ae1eff54345 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_data/ti-aemif.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/nvmem-provider.h>
 
@@ -53,14 +54,48 @@ static const short da830_evm_usb11_pins[] = {
 	-1
 };
 
-static struct gpiod_lookup_table da830_evm_usb_gpio_lookup = {
+static struct regulator_consumer_supply da830_evm_usb_supplies[] = {
+	REGULATOR_SUPPLY("vbus", NULL),
+};
+
+static struct regulator_init_data da830_evm_usb_vbus_data = {
+	.consumer_supplies	= da830_evm_usb_supplies,
+	.num_consumer_supplies	= ARRAY_SIZE(da830_evm_usb_supplies),
+};
+
+static struct fixed_voltage_config da830_evm_usb_vbus = {
+	.supply_name		= "vbus",
+	.microvolts		= 33000000,
+	.init_data		= &da830_evm_usb_vbus_data,
+};
+
+static struct platform_device da830_evm_usb_vbus_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev		= {
+		.platform_data = &da830_evm_usb_vbus,
+	},
+};
+
+static struct gpiod_lookup_table da830_evm_usb_oc_gpio_lookup = {
 	.dev_id		= "ohci-da8xx",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_DRV, "vbus", 0),
 		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_OVC, "oc", 0),
 	},
 };
 
+static struct gpiod_lookup_table da830_evm_usb_vbus_gpio_lookup = {
+	.dev_id		= "reg-fixed-voltage.1",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_DRV, "vbus", 0),
+	},
+};
+
+static struct gpiod_lookup_table *da830_evm_usb_gpio_lookups[] = {
+	&da830_evm_usb_oc_gpio_lookup,
+	&da830_evm_usb_vbus_gpio_lookup,
+};
+
 static struct da8xx_ohci_root_hub da830_evm_usb11_pdata = {
 	/* TPS2065 switch @ 5V */
 	.potpgt		= (3 + 1) / 2,	/* 3 ms max */
@@ -75,6 +110,9 @@ static __init void da830_evm_usb_init(void)
 		pr_warn("%s: USB PHY CLK registration failed: %d\n",
 			__func__, ret);
 
+	gpiod_add_lookup_tables(da830_evm_usb_gpio_lookups,
+				ARRAY_SIZE(da830_evm_usb_gpio_lookups));
+
 	ret = da8xx_register_usb_phy();
 	if (ret)
 		pr_warn("%s: USB PHY registration failed: %d\n",
@@ -100,7 +138,11 @@ static __init void da830_evm_usb_init(void)
 		return;
 	}
 
-	gpiod_add_lookup_table(&da830_evm_usb_gpio_lookup);
+	ret = platform_device_register(&da830_evm_usb_vbus_device);
+	if (ret) {
+		pr_warn("%s: Unable to register the vbus supply\n", __func__);
+		return;
+	}
 
 	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
 	if (ret)
-- 
2.20.1

