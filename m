Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C561C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EA820850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LKWFbZDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfDKJam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:30:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51319 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfDKJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:30:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so5804598wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyAH0wiE/i5zzvDeE8RjO1VQwB5hV38XLhGYRf7RuPY=;
        b=LKWFbZDwyDIE9VBr6ZDku3pb8lR9hY4EYrV44XAhbR/fmjLWPCxnw3Krj21LVhqRTL
         YPBAPpxboZOOsae32hg1KEvxzNeEzuqgz9c7x2WtxgQdNFU/W1LE0/BOSOa0sYpDWQgr
         KNritHHpzh8a/BK7iC+SS49TfrsLKuEFHrrbEaVIcpoZ9OwdKd9Z4lHXWbGmSDLbDkYr
         8+NVPjZVZHiCBz9JxBt7hcGe2hLlKeV3K99wlW0Nl3aRIN8lzhvXYY9xOSczTINuTBFx
         n2ubV4JS4+fDrLXAd+6t1kE2Gu6uX/d71iIwtW21xKzQ1hVjv6HPfwg2lBEhXCvsw3+4
         LGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyAH0wiE/i5zzvDeE8RjO1VQwB5hV38XLhGYRf7RuPY=;
        b=tAkD8Mf5y8WarP9Z9f7G+9HIbKmgSkUeMNsC43WSb/oySZeea4L6AHY/MiekV+AMQN
         fJCXP6rfl8NJFxQ9iT8t4NV9ZU8Jn7LKof4MBQRP87IyzaiJfEwHyaqHOigAiCwxOT7a
         KuMZf9AoStYyxT7HQHb54kyIhCu4w45y3NbmJ1s+s8Mm5aFUx1hOGCr1SHOHB3ewuWAH
         kvNGuK7JtD4U8rYMOUI0uRoRzu05eZL57SCq4uzF8lVVmNM4UFynS6ySBKFHvweobiNG
         P7ezyQbwQMKpsSCURUEn7jpKTAl0hpeDrP75zz6WBlMcA+bbTt5U5PlJjNrQyyGp5Iku
         Ya9A==
X-Gm-Message-State: APjAAAWAaeC53LkY+aNyI8mjD2Bc2yEyBTPntBBWuPmT6nJ8begQOP4L
        ncH5VXqYRN+tjzh65QtauGrsZw==
X-Google-Smtp-Source: APXvYqzArDrbBVSw7R46IuYWlEMH89mmBiFePh3BpDkGU+eWOvyfu00TsWGYAn256PJYMX5byeDLaQ==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr5794968wmg.26.1554975035679;
        Thu, 11 Apr 2019 02:30:35 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a9sm37517228wrt.29.2019.04.11.02.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:30:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 5/6] ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
Date:   Thu, 11 Apr 2019 11:30:23 +0200
Message-Id: <20190411093024.23555-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411093024.23555-1-brgl@bgdev.pl>
References: <20190411093024.23555-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 49 +++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index e3d74e43c47d..51a892702e27 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_data/ti-aemif.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/nvmem-provider.h>
 
@@ -53,15 +54,50 @@ static const short da830_evm_usb11_pins[] = {
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
+	.id		= 0,
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
 		{ }
 	},
 };
 
+static struct gpiod_lookup_table da830_evm_usb_vbus_gpio_lookup = {
+	.dev_id		= "reg-fixed-voltage.0",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", ON_BD_USB_DRV, "vbus", 0),
+		{ }
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
@@ -76,6 +112,9 @@ static __init void da830_evm_usb_init(void)
 		pr_warn("%s: USB PHY CLK registration failed: %d\n",
 			__func__, ret);
 
+	gpiod_add_lookup_tables(da830_evm_usb_gpio_lookups,
+				ARRAY_SIZE(da830_evm_usb_gpio_lookups));
+
 	ret = da8xx_register_usb_phy();
 	if (ret)
 		pr_warn("%s: USB PHY registration failed: %d\n",
@@ -101,7 +140,11 @@ static __init void da830_evm_usb_init(void)
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
2.21.0

