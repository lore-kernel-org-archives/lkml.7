Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB512C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B628C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vfxJcimz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfDLMgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:36:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40284 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfDLMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:36:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so10901226wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyAH0wiE/i5zzvDeE8RjO1VQwB5hV38XLhGYRf7RuPY=;
        b=vfxJcimzZAf4jUdtnGeJKKAJI3aDV6ULLr6n9UB4lk1AaK7TdW+/i8ucVjrl3BGCe2
         HVuXwQn1MV5+ML90el9EIJGSeOGyhhnk7M+Yr8i0ixB/bvCDyk3+DDBiXvhMiEKpBtbK
         R5jZx9NZmMHQUTkkW2/bOs5EYd6F5a4ujSI7v0krSAhiR2qnRGTHvJJCBpo7rLmeHJdu
         XqBKqraXUpgZ4yzoQofnb3gdhdwx9V3wN+mDrjXeny/zge5QuxvU1gT6nBFRhRNwMej7
         YcmySxQzGKudb/QVF5DNY4YTL0OfxVhgMsJLM/my9wz+pJ6PvVUyPmxi9/bMAsdl20/3
         /NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyAH0wiE/i5zzvDeE8RjO1VQwB5hV38XLhGYRf7RuPY=;
        b=UNOHy/Ki49bQHZLy3BfvXQ9+k/fpMYS53BKAvcT8tA6zt/DVkEBQfb9uIpzVNYJR/P
         mp6eXVrreoTsX1JOmg11SpIeQiZ0Sl2+Ju7ltv1oqYtJaEYZ8GctsAM4Wa+u6UO+E3Gb
         G+42ZHs6LIKCdG3KgM68vYUiCSb6aJ45B5IvOfRWeiQIPS5XgTohh+FeEr9S6sparVD+
         J6H+6rCau/NpmTMeBYnxwHUvqu6BCydQk9RvhbhzNUhqVjEbfn0095MsE6KNCZAyKPxE
         LAj9aBV7USDdAYJqhiTiRGBzhhuJWR/jTiuDd73zAIO6XBeD2p9xB/n4B3bFnj3ixEv1
         YFKQ==
X-Gm-Message-State: APjAAAVx79+qFl3i7to5EwocR/vn4rxVSitMMDS2ksk3m67hW1MpTrZt
        0APyJL9QEJWWdBbYbEbJEBjHHA==
X-Google-Smtp-Source: APXvYqzmKKSpUEDN0I3pJfNrQFrzgLeSvGY457OoNa770MDWpdG6X1KjuLcbp0dAm+2r9kmredz9eg==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr11337862wme.62.1555072609308;
        Fri, 12 Apr 2019 05:36:49 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id v190sm12384030wme.18.2019.04.12.05.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:36:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 5/6] ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
Date:   Fri, 12 Apr 2019 14:36:39 +0200
Message-Id: <20190412123640.11437-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412123640.11437-1-brgl@bgdev.pl>
References: <20190412123640.11437-1-brgl@bgdev.pl>
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

