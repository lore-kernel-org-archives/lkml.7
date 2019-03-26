Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE45C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CF22070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="2AHMFk/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCZP5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:57:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39700 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731489AbfCZP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:57:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so14984636wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RoQu7lKq5HUjsOpqb5VBB45JH3hBOA4zTqWoTxIGD0=;
        b=2AHMFk/nV5es0CsmlQNEAIl+UXjXuD9BY51qYWm4ehk9X8dG1QUsoNCAXpMvlhH7Yf
         IN5YEtJVEBJfAUOj69n6pKbfvWQKkf+zgH78/S+OXP7aL5vS+rVnXVaEAlpe22TZMwjh
         oIA+xxnD09PC1d7gp7X/fJzWrb1AMAtBHgtzTtdYOO0gXAX8FQv/kXiXxgHh/1LqRKSa
         pKd+xwZqf6SVmOt/B42PXgO/2/fVML/+pCAdpTdozi90nJxPzhlXTXaTDpI0Gauj0AEd
         HX6AvkpZFtqrfhzFw0K3UJPbZcZjitIKe2xPxJ6ItfyseU7XMHkqe6jjG4q/b8lBn81K
         KUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RoQu7lKq5HUjsOpqb5VBB45JH3hBOA4zTqWoTxIGD0=;
        b=hGGLQamF0CRz7dmA1F8r+QRd4SEvCFaahH4i3d5kF42pnNS1wEYMct3XHdrVxoJrUx
         2K2NsQUUPMJNlUISHCgNSNs3B38+h+H4104s+BbxRsj2n/K9DAzzZ+YrLb0EaRZ6zYDn
         RxtM8x6uUizF9gzCxlB8g6TBebcKsdj54UpGKAl+8VSS1dOtOsRhUdq3L7AKn957JNgv
         U8O2XvZtto1Kp2mRSgVHoP1vpFdPAkVd7qd6DudgqfrmYGu2DP2KZTfg24Y8QlY4XMOG
         /6Zp8c9VNNU0iEltwVbCnfvTLgjTcgKPJMvOwbARpeL4XTnCV/Hz+cp9BsV6xaJ62fY5
         ymxQ==
X-Gm-Message-State: APjAAAXIiBEnydTlWj63B5j14xm2pqAJSb02tlve48x+2OCq+PoxDMFm
        kOfQu/TiTg7CMD3ubv78AvDaGA==
X-Google-Smtp-Source: APXvYqxMZQ2CgaEn9VNAFmSYHng/qFDULpwN5xe6U1SLeQ53mxYaRXuNmHztd/kqbirFZBDJVE2lzg==
X-Received: by 2002:a5d:5190:: with SMTP id k16mr2329572wrv.10.1553615856848;
        Tue, 26 Mar 2019 08:57:36 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 204sm28522999wmc.1.2019.03.26.08.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:57:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/3] ARM: davinci: omapl138-hawk: add a fixed regulator for ohci-da8xx
Date:   Tue, 26 Mar 2019 16:57:26 +0100
Message-Id: <20190326155728.5432-2-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/board-omapl138-hawk.c | 48 +++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 0896af2bed24..ea7110e47e8a 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -21,6 +21,7 @@
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/ti-aemif.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
@@ -298,14 +299,48 @@ static const short da850_hawk_usb11_pins[] = {
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
 	},
 };
 
+static struct gpiod_lookup_table hawk_usb_vbus_gpio_lookup = {
+	.dev_id		= "reg-fixed-voltage.1",
+	.table = {
+		GPIO_LOOKUP("davinci_gpio", DA850_USB1_VBUS_PIN, NULL, 0),
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
@@ -326,12 +361,19 @@ static __init void omapl138_hawk_usb_init(void)
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
2.20.1

