Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4692082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="o8ep84Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfDLMhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:37:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54595 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfDLMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:36:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so11028552wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkiOzqo+5E8+PTnExhJYSKG8TC17kxUDe5ZrFElD/ZE=;
        b=o8ep84Q2/ISktCjQUU+vyYVsFjv1uyAK6SwCYaD4jFPEo1k0bqeNPAX2jydpt0quHY
         bdNKR/nqe+T1MnRzAEgttYd8HKmhNU6RmqlSVrBFkF3Tuw0l03zBIUjHbg43TaV5Bclb
         LSZgulopBXIDgJMrb5b5UIBko9QP9OAbuYNHmFH8NO3bBAbI/mTQAO6m5neAmfWsoa4Q
         fMBh0U+4dVQn9lxZ5mzervhRl1oNb0j+HvJWs60pSM11dqXvjmxNPElY5dcp0ZlWTiRd
         sYmPyrrlZu/xWk2pKs7wnczZPF6P5kLTlH4bDO9xGuiZaEhXj733gUATOFKZD2W3qU+A
         /rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkiOzqo+5E8+PTnExhJYSKG8TC17kxUDe5ZrFElD/ZE=;
        b=GlF+J50iKgdv3pPJB0o7XX9zB/WEM+XFBMQmOmBGuH4iOLxeexPPKGjqZKk63pk0Ke
         gugyhcbN6HLbVKDxh0P0i3l4fzyxLoAzlmM3BNWPARZxA38xT+73ZYKiz8e0Rq5bs8Fw
         q3HZ2FEmeZeW8nWv3c0ZqD28j6WSbL9/dFyuAi0TOMyZcSFk/fd/OEND/l7ynhG4N4l5
         K+pmfcG9M3ItgGKmLi6HMAEF3AAm4/+pVoVPt2aEdw5UoX0wfYOi88fWGtw0gZZUzcVL
         npVR/TW6/nikfgfVMdlLA6Pf87+x+0Q44u4ia2SgO4d5/8JAGhvGuqXkm4P8GXEUqN3B
         QjUQ==
X-Gm-Message-State: APjAAAWpI1AjTk+gopAo1kRqg8qs+o7IsCnDAsAmvLpcPANGWouDRb/J
        g67y2HykWc7CsSdDxV3aMkTcNg==
X-Google-Smtp-Source: APXvYqzzQFHewKkSvNQ7QQk9hjqwJsoMiX45q4ONdF3ZP0biYEW/amEcQzL4GiM88Y5pcvpDlAVuKQ==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr11021693wmb.47.1555072608151;
        Fri, 12 Apr 2019 05:36:48 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id v190sm12384030wme.18.2019.04.12.05.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:36:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 4/6] ARM: davinci: omapl138-hawk: add a fixed regulator for ohci-da8xx
Date:   Fri, 12 Apr 2019 14:36:38 +0200
Message-Id: <20190412123640.11437-5-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-omapl138-hawk.c | 49 +++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index e244c8648594..db177a6a7e48 100644
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
+	.id		= 0,
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
+	.dev_id		= "reg-fixed-voltage.0",
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

