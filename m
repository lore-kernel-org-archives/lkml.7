Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B07CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390E82133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="r/RkcHXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDII3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:29:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33862 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfDII3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:29:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so19705885wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyAH0wiE/i5zzvDeE8RjO1VQwB5hV38XLhGYRf7RuPY=;
        b=r/RkcHXMX6LLaUb5DyY0cJqlJ/XpJ28YIwZGo0EuPMwnE08n0FL171fRH5NEwYIqJW
         Yjx3VnSmo6eo1uNO6bIPngtk/WXNqokjQcOXMlj4lFyCGpP50TSmWpFwg+xld5c+4Zmj
         eBwsDS9OMg5pFaIj3FItxbxi4hF8lBrhn7vcWNBQ//A5GYGlcJ+GJv5E7vSRA71GE956
         PA+n4ZpUrLUuffhpSPMBLHsgJRCKflQMpS+xbe7YstfPIJngcnR3TtWYz8gS+6Mlga0M
         HitjuC1eKUYVaE4DKNkV9ZhEgnWUb9krQhmyXmu0vgFC2WTTjJUsUDtTLqA41KooDtnJ
         mM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyAH0wiE/i5zzvDeE8RjO1VQwB5hV38XLhGYRf7RuPY=;
        b=gOryo6CH0JnBDa/XFNgihDcr2MRctzPSdO26JMgfDh/379kXilHhBblRzRbCL+Kbxg
         0bK5KVTHN8BNI0b+D3ts5rf0LjL+HAs93zD87uZHsoK0Oq9fZrnRN2ZzmT3//eUAzEif
         lfJDThLi+kgBSbPtTyKy3SVSLktYt/o11kmHnRFxebowEjItHwt2Pfj5GiJ/VmfTvmqt
         U856K8ZEFVoVSFOb4gsbP4uS3z4sYsy6q8htoSN6qRvBZ2GCMDLV/4KF9spNJrQ+1ldq
         Q+EweXzrHyB2FGsJWn72utZxA9Nx0dnHZ125N4mj9fkIUKuLcg+/pEl15xkOJAYoYCHE
         lWkA==
X-Gm-Message-State: APjAAAVPSOEQnA1aix7YpCNoPLeAHhWsuOnHxOfMVUFB85BIcUdPYlp/
        BqK2Nl7Hgdh/lXeypknG/0719A==
X-Google-Smtp-Source: APXvYqxb7X9Rk6XcFuSmdlNUmt9x59B/entM4fiTxnbGiWv+T3cpIjMl5X7CDH3WT/mB2aIL/pWkDA==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr23225448wrm.300.1554798546324;
        Tue, 09 Apr 2019 01:29:06 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id c20sm59968651wre.28.2019.04.09.01.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:29:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 5/6] ARM: davinci: da830-evm: add a fixed regulator for ohci-da8xx
Date:   Tue,  9 Apr 2019 10:28:54 +0200
Message-Id: <20190409082855.15373-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409082855.15373-1-brgl@bgdev.pl>
References: <20190409082855.15373-1-brgl@bgdev.pl>
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

