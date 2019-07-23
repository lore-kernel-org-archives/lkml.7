Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA0CC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D2F21955
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qIURi0xW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfGWBO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:14:29 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44580 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGWBO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563844466; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=GcBWZrW412EKZLNqlkDxGr311oZLo5darrG9rJ0Zh3Q=;
        b=qIURi0xWwalEkD7oO1WZSVS3X8xFs+yEpeXRqWCmFVw0bGjkO44ah/lHfHNdi7lTGT5/+B
        UODyonFHjvvluLsWw/rWQxato8s5+Lvn2DfZDF7NV56CUkJYZ+zRoIxahN/V8gz1CPlFBc
        rRelNx2YMprqlT2+0CI/hoOIz1z9SuY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] regulator: act8865: Add support for act8600 charger
Date:   Mon, 22 Jul 2019 21:14:18 -0400
Message-Id: <20190723011418.29143-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten ter Huurne <maarten@treewalker.org>

This provides a way to monitor battery charge status via the power
supply subsystem.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/regulator/act8865-regulator.c | 84 +++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index cf72d7c6b8c9..e63285de485d 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/act8865.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/power_supply.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regmap.h>
 
@@ -118,6 +119,11 @@
 #define ACT8600_LDO10_ENA		0x40	/* ON - [6] */
 #define ACT8600_SUDCDC_VSEL_MASK	0xFF	/* SUDCDC VSET - [7:0] */
 
+#define ACT8600_APCH_CHG_ACIN		BIT(7)
+#define ACT8600_APCH_CHG_USB		BIT(6)
+#define ACT8600_APCH_CSTATE0		BIT(5)
+#define ACT8600_APCH_CSTATE1		BIT(4)
+
 /*
  * ACT8865 voltage number
  */
@@ -372,6 +378,75 @@ static void act8865_power_off(void)
 	while (1);
 }
 
+static int act8600_charger_get_status(struct regmap *map)
+{
+	unsigned int val;
+	int ret;
+	u8 state0, state1;
+
+	ret = regmap_read(map, ACT8600_APCH_STAT, &val);
+	if (ret < 0)
+		return ret;
+
+	state0 = val & ACT8600_APCH_CSTATE0;
+	state1 = val & ACT8600_APCH_CSTATE1;
+
+	if (state0 && !state1)
+		return POWER_SUPPLY_STATUS_CHARGING;
+	if (!state0 && state1)
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	if (!state0 && !state1)
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+
+	return POWER_SUPPLY_STATUS_UNKNOWN;
+}
+
+static int act8600_charger_get_property(struct power_supply *psy,
+		enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct regmap *map = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = act8600_charger_get_status(map);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property act8600_charger_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+};
+
+static const struct power_supply_desc act8600_charger_desc = {
+	.name = "act8600-charger",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = act8600_charger_properties,
+	.num_properties = ARRAY_SIZE(act8600_charger_properties),
+	.get_property = act8600_charger_get_property,
+};
+
+static int act8600_charger_probe(struct device *dev, struct regmap *regmap)
+{
+	struct power_supply *charger;
+	struct power_supply_config cfg = {
+		.drv_data = regmap,
+		.of_node = dev->of_node,
+	};
+
+	charger = devm_power_supply_register(dev, &act8600_charger_desc, &cfg);
+
+	return IS_ERR(charger) ? PTR_ERR(charger) : 0;
+}
+
 static int act8865_pmic_probe(struct i2c_client *client,
 			      const struct i2c_device_id *i2c_id)
 {
@@ -483,6 +558,15 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		}
 	}
 
+	if (type == ACT8600) {
+		ret = act8600_charger_probe(dev, act8865->regmap);
+		if (ret < 0) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to probe charger");
+			return ret;
+		}
+	}
+
 	i2c_set_clientdata(client, act8865);
 
 	return 0;
-- 
2.21.0.593.g511ec345e18

