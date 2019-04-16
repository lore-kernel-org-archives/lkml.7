Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69515C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390FA2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555396867;
	bh=H0o5dNCLlp84SoA0n7A6haX/AtSXzPGS44dR0gQukGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ptlvhwp28Fpi3kM+Yf0efgBdONphLl8gcjS0kemLbqLCLpUOTVq9UwPmrDCK3HT7
	 TlsFkpWW2LllO7rpldxg/vDMkmIOBvB6avg2yipuQGTpov2NyJqAhvSEwKc/2jQtZs
	 rxbyrdWp+HtkIjQ4r7B1XNSIs0M9HoZHoRsCQIl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfDPGlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:41:05 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34020 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfDPGkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:40:31 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id A4108602AD; Tue, 16 Apr 2019 14:40:25 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v4 5/7] power: supply: axp20x_usb_power: add support for AXP813
Date:   Tue, 16 Apr 2019 14:40:22 +0800
Message-Id: <20190416064024.20414-6-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416064024.20414-1-wens@kernel.org>
References: <20190416064024.20414-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

This adds support for AXP813 PMIC. It is almost the same as AXP22X but
has a different current limit.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 66 ++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 04c2cafbe8e6..d2b1255ee1cc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -42,6 +42,11 @@
 #define AXP20X_VBUS_CLIMIT_100mA	2
 #define AXP20X_VBUS_CLIMIT_NONE		3
 
+#define AXP813_VBUS_CLIMIT_900mA	0
+#define AXP813_VBUS_CLIMIT_1500mA	1
+#define AXP813_VBUS_CLIMIT_2000mA	2
+#define AXP813_VBUS_CLIMIT_2500mA	3
+
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
 
@@ -131,6 +136,31 @@ static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
 	return 0;
 }
 
+static int axp813_get_current_max(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
+
+	if (ret)
+		return ret;
+
+	switch (v & AXP20X_VBUS_CLIMIT_MASK) {
+	case AXP813_VBUS_CLIMIT_900mA:
+		*val = 900000;
+		break;
+	case AXP813_VBUS_CLIMIT_1500mA:
+		*val = 1500000;
+		break;
+	case AXP813_VBUS_CLIMIT_2000mA:
+		*val = 2000000;
+		break;
+	case AXP813_VBUS_CLIMIT_2500mA:
+		*val = 2500000;
+		break;
+	}
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -169,6 +199,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		val->intval = ret * 1700; /* 1 step = 1.7 mV */
 		return 0;
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		if (power->axp20x_id == AXP813_ID)
+			return axp813_get_current_max(power, &val->intval);
 		return axp20x_get_current_max(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
@@ -260,6 +292,31 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp813_usb_power_set_current_max(struct axp20x_usb_power *power,
+					    int intval)
+{
+	int val;
+
+	switch (intval) {
+	case 900000:
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK,
+					  AXP813_VBUS_CLIMIT_900mA);
+	case 1500000:
+	case 2000000:
+	case 2500000:
+		val = (intval - 1000000) / 500000;
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK, val);
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
 static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -294,6 +351,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 		return axp20x_usb_power_set_voltage_min(power, val->intval);
 
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		if (power->axp20x_id == AXP813_ID)
+			return axp813_usb_power_set_current_max(power,
+								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
 	default:
@@ -429,7 +489,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		usb_power_desc = &axp20x_usb_power_desc;
 		irq_names = axp20x_irq_names;
 	} else if (power->axp20x_id == AXP221_ID ||
-		   power->axp20x_id == AXP223_ID) {
+		   power->axp20x_id == AXP223_ID ||
+		   power->axp20x_id == AXP813_ID) {
 		usb_power_desc = &axp22x_usb_power_desc;
 		irq_names = axp22x_irq_names;
 	} else {
@@ -488,6 +549,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp223-usb-power-supply",
 		.data = (void *)AXP223_ID,
+	}, {
+		.compatible = "x-powers,axp813-usb-power-supply",
+		.data = (void *)AXP813_ID,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
-- 
2.20.1

