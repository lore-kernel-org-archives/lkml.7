Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4945C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D872190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="VUmF1WXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbfGVSNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:13:33 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:28961 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfGVSNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:13:32 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 45sqSp55k8zB2;
        Mon, 22 Jul 2019 20:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1563819130; bh=XAqN9Z5GxdiKSFRY+TjZ30AKda1Zi0HoeytkimFExzg=;
        h=Date:From:Subject:To:Cc:From;
        b=VUmF1WXMgsySLjvOQ7XaBW90KRpV2Je+SmLh3ozn3p9r/56qOyGCEs0ygxClmPZkS
         d4cpubEzQvYKotIyK1jv431l3Aw0WzVd4GTPhK/4a829t7vN6OyBlJHomXNbgBZ3Oc
         065juQKAW7MEl/bSpbVKBNkVHopXtRlGIYk4ZBnaupX50hfafiXt0r19BX8NZVN0y2
         ze5q8a5tuFgx8j0x6FH7bikaqTpHK/m0mBGGdYzCOopthQQ3rTDeXOnrGw0v5zbi5+
         pqv2zrWrh9Fe3Hw5e0k6jGGjwVL4BUctyFgECB4XS1CG7Iu771+LYdkWQdYeGzGO2R
         op/4AU3DSJqoA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Mon, 22 Jul 2019 20:13:29 +0200
Message-Id: <d02d7285ef26f59ce43a3097e342eea081b98444.1563819128.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regulator: act8865: support regulator-pull-down property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AC8865 has internal 1.5k pull-down resistor that can be enabled when LDO
is shut down.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 * against broonie/regulator/for-next tree

---
 drivers/regulator/act8865-regulator.c | 45 ++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index cf72d7c6b8c9..921f8f03b84e 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -112,6 +112,8 @@
  * Field Definitions.
  */
 #define	ACT8865_ENA		0x80	/* ON - [7] */
+#define	ACT8865_DIS		0x40	/* DIS - [6] */
+
 #define	ACT8865_VSEL_MASK	0x3F	/* VSET - [5:0] */
 
 
@@ -228,12 +230,23 @@ static const struct regulator_ops act8865_ops = {
 };
 
 static const struct regulator_ops act8865_ldo_ops = {
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_pull_down		= regulator_set_pull_down_regmap,
 };
 
-#define ACT88xx_REG(_name, _family, _id, _vsel_reg, _supply)		\
+static const struct regulator_ops act8865_fixed_ldo_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+};
+
+#define ACT88xx_REG_(_name, _family, _id, _vsel_reg, _supply, _ops)	\
 	[_family##_ID_##_id] = {					\
 		.name			= _name,			\
 		.of_match		= of_match_ptr(_name),		\
@@ -241,7 +254,7 @@ static const struct regulator_ops act8865_ldo_ops = {
 		.supply_name		= _supply,			\
 		.id			= _family##_ID_##_id,		\
 		.type			= REGULATOR_VOLTAGE,		\
-		.ops			= &act8865_ops,			\
+		.ops			= _ops,				\
 		.n_voltages		= ACT8865_VOLTAGE_NUM,		\
 		.linear_ranges		= act8865_voltage_ranges,	\
 		.n_linear_ranges	= ARRAY_SIZE(act8865_voltage_ranges), \
@@ -249,9 +262,17 @@ static const struct regulator_ops act8865_ldo_ops = {
 		.vsel_mask		= ACT8865_VSEL_MASK,		\
 		.enable_reg		= _family##_##_id##_CTRL,	\
 		.enable_mask		= ACT8865_ENA,			\
+		.pull_down_reg		= _family##_##_id##_CTRL,	\
+		.pull_down_mask		= ACT8865_DIS,			\
 		.owner			= THIS_MODULE,			\
 	}
 
+#define ACT88xx_REG(_name, _family, _id, _vsel_reg, _supply) \
+	ACT88xx_REG_(_name, _family, _id, _vsel_reg, _supply, &act8865_ops)
+
+#define ACT88xx_LDO(_name, _family, _id, _vsel_reg, _supply) \
+	ACT88xx_REG_(_name, _family, _id, _vsel_reg, _supply, &act8865_ldo_ops)
+
 static const struct regulator_desc act8600_regulators[] = {
 	ACT88xx_REG("DCDC1", ACT8600, DCDC1, VSET, "vp1"),
 	ACT88xx_REG("DCDC2", ACT8600, DCDC2, VSET, "vp2"),
@@ -281,7 +302,7 @@ static const struct regulator_desc act8600_regulators[] = {
 		.of_match = of_match_ptr("LDO_REG9"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_LDO9,
-		.ops = &act8865_ldo_ops,
+		.ops = &act8865_fixed_ldo_ops,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = 1,
 		.fixed_uV = 3300000,
@@ -294,7 +315,7 @@ static const struct regulator_desc act8600_regulators[] = {
 		.of_match = of_match_ptr("LDO_REG10"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_LDO10,
-		.ops = &act8865_ldo_ops,
+		.ops = &act8865_fixed_ldo_ops,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = 1,
 		.fixed_uV = 1200000,
@@ -323,20 +344,20 @@ static const struct regulator_desc act8865_regulators[] = {
 	ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET1, "vp1"),
 	ACT88xx_REG("DCDC_REG2", ACT8865, DCDC2, VSET1, "vp2"),
 	ACT88xx_REG("DCDC_REG3", ACT8865, DCDC3, VSET1, "vp3"),
-	ACT88xx_REG("LDO_REG1", ACT8865, LDO1, VSET, "inl45"),
-	ACT88xx_REG("LDO_REG2", ACT8865, LDO2, VSET, "inl45"),
-	ACT88xx_REG("LDO_REG3", ACT8865, LDO3, VSET, "inl67"),
-	ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
+	ACT88xx_LDO("LDO_REG1", ACT8865, LDO1, VSET, "inl45"),
+	ACT88xx_LDO("LDO_REG2", ACT8865, LDO2, VSET, "inl45"),
+	ACT88xx_LDO("LDO_REG3", ACT8865, LDO3, VSET, "inl67"),
+	ACT88xx_LDO("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
 };
 
 static const struct regulator_desc act8865_alt_regulators[] = {
 	ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET2, "vp1"),
 	ACT88xx_REG("DCDC_REG2", ACT8865, DCDC2, VSET2, "vp2"),
 	ACT88xx_REG("DCDC_REG3", ACT8865, DCDC3, VSET2, "vp3"),
-	ACT88xx_REG("LDO_REG1", ACT8865, LDO1, VSET, "inl45"),
-	ACT88xx_REG("LDO_REG2", ACT8865, LDO2, VSET, "inl45"),
-	ACT88xx_REG("LDO_REG3", ACT8865, LDO3, VSET, "inl67"),
-	ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
+	ACT88xx_LDO("LDO_REG1", ACT8865, LDO1, VSET, "inl45"),
+	ACT88xx_LDO("LDO_REG2", ACT8865, LDO2, VSET, "inl45"),
+	ACT88xx_LDO("LDO_REG3", ACT8865, LDO3, VSET, "inl67"),
+	ACT88xx_LDO("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
 };
 
 #ifdef CONFIG_OF
-- 
2.20.1

