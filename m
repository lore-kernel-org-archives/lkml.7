Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FDE21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DYTVAFj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfDEO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:56:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33312 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbfDEOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:55:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35Etr3q105058;
        Fri, 5 Apr 2019 09:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554476153;
        bh=yol9W4T7d+wJar/2rbqMVHKIUbI4T3sfDoNbcW62Uho=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DYTVAFj4ZSn6F2D8cqPZoZKmaKwYLarGKwhvXsJ1ySc4DU7MLngMoPCNHHFHvIkuB
         t7KNjal5Xr8WgXQvpfn55IQs5CX8Lg+PSpmDoVh149p7mJZ+jG9EkI4JGcw4wvTsZ9
         7XgzblHlGJlx7Ol5Tvej8IPoqjUvQF/PneFasl6Q=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35Etrl7077892
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 09:55:53 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 09:55:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 09:55:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35Etqqk033344;
        Fri, 5 Apr 2019 09:55:52 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 4/6] regulator: lm363x: Add support for LM36274
Date:   Fri, 5 Apr 2019 09:55:38 -0500
Message-ID: <20190405145540.27703-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190405145540.27703-1-dmurphy@ti.com>
References: <20190405145540.27703-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding regulator support for the LM36274 backlight driver.
This device can leverage this existing code as the functionality
and registers are common enough between the LM36274 and the LM363x
series of devices.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/regulator/Kconfig            |  2 +-
 drivers/regulator/lm363x-regulator.c | 52 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b7f249ee5e68..23252ae81fdf 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -362,7 +362,7 @@ config REGULATOR_LM363X
 	tristate "TI LM363X voltage regulators"
 	depends on MFD_TI_LMU
 	help
-	  This driver supports LM3631 and LM3632 voltage regulators for
+	  This driver supports LM3631, LM3632 and LM36274 voltage regulators for
 	  the LCD bias.
 	  One boost output voltage is configurable and always on.
 	  Other LDOs are used for the display module.
diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index 382b1cecdd93..1944677b1448 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -37,6 +37,11 @@
 #define LM3632_VBOOST_MIN		4500000
 #define LM3632_VLDO_MIN			4000000
 
+/* LM36274 */
+#define LM36274_BOOST_VSEL_MAX		0x3f
+#define LM36274_LDO_VSEL_MAX		0x34
+#define LM36274_VOLTAGE_MIN		4000000
+
 /* Common */
 #define LM363X_STEP_50mV		50000
 #define LM363X_STEP_500mV		500000
@@ -217,6 +222,51 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
 		.enable_reg     = LM3632_REG_BIAS_CONFIG,
 		.enable_mask    = LM3632_EN_VNEG_MASK,
 	},
+
+	/* LM36274 */
+	{
+		.name           = "vboost",
+		.of_match	= "vboost",
+		.id             = LM36274_BOOST,
+		.ops            = &lm363x_boost_voltage_table_ops,
+		.n_voltages     = LM36274_BOOST_VSEL_MAX,
+		.min_uV         = LM36274_VOLTAGE_MIN,
+		.uV_step        = LM363X_STEP_50mV,
+		.type           = REGULATOR_VOLTAGE,
+		.owner          = THIS_MODULE,
+		.vsel_reg       = LM36274_REG_VOUT_BOOST,
+		.vsel_mask      = LM36274_VOUT_MASK,
+	},
+	{
+		.name           = "ldo_vpos",
+		.of_match	= "vpos",
+		.id             = LM36274_LDO_POS,
+		.ops            = &lm363x_regulator_voltage_table_ops,
+		.n_voltages     = LM36274_LDO_VSEL_MAX,
+		.min_uV         = LM36274_VOLTAGE_MIN,
+		.uV_step        = LM363X_STEP_50mV,
+		.type           = REGULATOR_VOLTAGE,
+		.owner          = THIS_MODULE,
+		.vsel_reg       = LM36274_REG_VOUT_POS,
+		.vsel_mask      = LM36274_VOUT_MASK,
+		.enable_reg     = LM36274_REG_BIAS_CONFIG_1,
+		.enable_mask    = LM36274_EN_VPOS_MASK,
+	},
+	{
+		.name           = "ldo_vneg",
+		.of_match	= "vneg",
+		.id             = LM36274_LDO_NEG,
+		.ops            = &lm363x_regulator_voltage_table_ops,
+		.n_voltages     = LM36274_LDO_VSEL_MAX,
+		.min_uV         = LM36274_VOLTAGE_MIN,
+		.uV_step        = LM363X_STEP_50mV,
+		.type           = REGULATOR_VOLTAGE,
+		.owner          = THIS_MODULE,
+		.vsel_reg       = LM36274_REG_VOUT_NEG,
+		.vsel_mask      = LM36274_VOUT_MASK,
+		.enable_reg     = LM36274_REG_BIAS_CONFIG_1,
+		.enable_mask    = LM36274_EN_VNEG_MASK,
+	},
 };
 
 static struct gpio_desc *lm363x_regulator_of_get_enable_gpio(struct device *dev, int id)
@@ -229,9 +279,11 @@ static struct gpio_desc *lm363x_regulator_of_get_enable_gpio(struct device *dev,
 	 */
 	switch (id) {
 	case LM3632_LDO_POS:
+	case LM36274_LDO_POS:
 		return gpiod_get_index_optional(dev, "enable", 0,
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	case LM3632_LDO_NEG:
+	case LM36274_LDO_NEG:
 		return gpiod_get_index_optional(dev, "enable", 1,
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	default:
-- 
2.19.0

