Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E75FC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E746020643
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iXnzMUAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfC2Jd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:33:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43550 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfC2Jdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:33:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so1685036wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbCGKRK2X1xPLdacL1xB8HrW5AVjZ0KwD0ifnHHdo+g=;
        b=iXnzMUAbcdao3LV0SCIWLlFt13jR8QGk+hMydpXfSkXJxiCsmrH8Mwys7RmZd8DPPg
         U8UdLbiJbouQI+10MCIO0al7cvmezfM+euBlKqPg5Iz+EemT8qvo0OuXJPsa6LyEUHrY
         JEN0GyEVwstJJxTWyuwys8W9ZCY6ai8JgeyJOWYlfgAV0HJFXpNMG8hHe4VOTMnqg+Oc
         Pa3dpsYguhAPCzmQaURjD/JrCZRxwrpf6BeyLpI7NVyP+c6xj5j9AMZm0hf32eI73w/d
         dqZxKPeFbYA6Bg9OxrLuyHmj9bfGFUbfjSF8OCc3zmX0YRWcKS3eZNm/yH/ae6g3Df+y
         oLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbCGKRK2X1xPLdacL1xB8HrW5AVjZ0KwD0ifnHHdo+g=;
        b=Who755nSg5WpMpuu7ER2mjAAbtdQztARVG3EGcgDYuS4FIU6oXim+bEYUkavlWLx0j
         WBB6MY04tsKGDGo+/eT9YqeEJDM+7bqJo9VBqK1mVGHNBEU7gHWBInoBdBG+lX8g+PUX
         4tquW/BUYPDmehMUvViWkVobT3LI06BKIrq8+lkBRiqysV/HhQuRYLgpcrroIc+Y6gcS
         4Q6o3SJ8ByexBbGwGURn2IIYy/0C9VHImI8fhqXTmPoBhqmwullyH9pnByCRXAJ/lCof
         wLZ4o6oPMrJZWG08r7/7Run+QEOk7icsVbIyyze3DjpT1ifzYDmM2sXGlu+uQ/1ikbgR
         K/aw==
X-Gm-Message-State: APjAAAUKeWuuBOXXp8vFRw0Zy3q8YB6aDOZVE8vNJNxLypNQvXb4TVt7
        BIyDlFB6iijdp4+Qkzt3Jsl5rw==
X-Google-Smtp-Source: APXvYqyQR9UvO6TWHtcUrh4IiHTJ7pi8WetsR42Ox4VYCAjcb/5UecHqkFGawyhYmd0frxyujftF8A==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr9510456wrj.101.1553852028108;
        Fri, 29 Mar 2019 02:33:48 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id s12sm1957125wmj.42.2019.03.29.02.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:33:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/6] ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
Date:   Fri, 29 Mar 2019 10:33:33 +0100
Message-Id: <20190329093334.3885-6-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-da830-evm.c | 49 +++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index e3d74e43c47d..6caf50bb92c9 100644
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
 		{ }
 	},
 };
 
+static struct gpiod_lookup_table da830_evm_usb_vbus_gpio_lookup = {
+	.dev_id		= "reg-fixed-voltage.1",
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

