Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3518C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624A52183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="xojDJX/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbfDRLpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:45:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35699 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:45:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so1011565pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Ln/HBy2BxmJ3KoTFpTywBQhPf219mfqmNcpriM3Q6mc=;
        b=xojDJX/mf/ktL0c0EB/UMLg9JBE+fAIVlC+2w/NjuGYFX3QSWpyJ/eUXgzkwDOl5K+
         jBl2cHrrePNrLwz2F1Iq+HPxjBejzqXjmLnXrNE9JsT9uxhfX3tNL+83BuAjvKeEqEHP
         7nNuBzwty/I6OZ0zvgJ8Pe05xws9c1ksKJdI+UhIKt0usqQrpJgVahxQMlSAWVZkr3u+
         u4RowLGx4oIaOI4Y++vU1pFE6J/oIcgNFw/eIVKxFzMCSh5RNFmGI7vCx5mvmv7Sq/hi
         GTwV9J00mzMKvF3Oz8Sih8TAnTOqjbC6CodfD+hqeXOmBcgIW83KXLCODCbaIE8Tl/IW
         nQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ln/HBy2BxmJ3KoTFpTywBQhPf219mfqmNcpriM3Q6mc=;
        b=lOLWjAu6NeHbgQsiEmkuPyS/mOxN1MKnNLNoqrlSPdlmsNJQ/2L7WKgMcBRd5r2D5r
         Gf5hjt/TWde6mmwktritszwrp1gUsdrtI50wbtaz+UeN4XPwGBVuxV2MoFQtWNZgUjVs
         HOqDzjHyTqhmaVTII6UO5PLsfiOOoAGelede8fxpCBalgljmDfX4X/2NFgNXMb1jEGu1
         4R8VdM/KJFkm7CG5rzmBjMxw+oEpsF4RtVfwnVpBfxzGCafRceGfxdb0SHcaAF/ryhTr
         g1km5S5RLFAezwibaN0zIZVbvSjYyN3bPPaLV6jfgDIu/SZBZvsqVLg69ZAiTfWN7kvL
         SdZg==
X-Gm-Message-State: APjAAAUR78zXju4eWJmcNvSpAcbTXAQGy1XEAjLwIfgjDILedUuktNRy
        3h56N6hcJn1zXnQhHG0oEbBk7d0/gEs=
X-Google-Smtp-Source: APXvYqzrznX8V3u7IUb7IWyeMpNLL0Rcx/vzYdtNhSazwwzktQCPjicrzguO6ju2ktA4kEeud08jSw==
X-Received: by 2002:a63:ef07:: with SMTP id u7mr90370752pgh.0.1555587913624;
        Thu, 18 Apr 2019 04:45:13 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id l19sm2550579pff.1.2019.04.18.04.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 04:45:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: ltc3589: Convert to use simplified DT parsing
Date:   Thu, 18 Apr 2019 19:44:58 +0800
Message-Id: <20190418114500.1098-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simplify the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ltc3589.c | 194 +++++++++++-------------------------
 1 file changed, 58 insertions(+), 136 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 75089b037b72..35741f476024 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -86,10 +86,6 @@ enum ltc3589_reg {
 
 struct ltc3589_regulator {
 	struct regulator_desc desc;
-
-	/* External feedback voltage divider */
-	unsigned int r1;
-	unsigned int r2;
 };
 
 struct ltc3589 {
@@ -196,11 +192,55 @@ static const struct regulator_ops ltc3589_table_regulator_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
+static inline unsigned int ltc3589_scale(unsigned int uV, u32 r1, u32 r2)
+{
+	uint64_t tmp;
+
+	if (uV == 0)
+		return 0;
+
+	tmp = (uint64_t)uV * r1;
+	do_div(tmp, r2);
+	return uV + (unsigned int)tmp;
+}
+
+static int ltc3589_of_parse_cb(struct device_node *np,
+			       const struct regulator_desc *desc,
+			       struct regulator_config *config)
+{
+	struct ltc3589 *ltc3589 = config->driver_data;
+	struct ltc3589_regulator *rdesc = &ltc3589->regulator_descs[desc->id];
+	u32 r[2];
+	int ret;
+
+	/* Parse feedback voltage dividers. LDO3 and LDO4 don't have them */
+	if (desc->id >= LTC3589_LDO3)
+		return 0;
+
+	ret = of_property_read_u32_array(np, "lltc,fb-voltage-divider", r, 2);
+	if (ret) {
+		dev_err(ltc3589->dev, "Failed to parse voltage divider: %d\n",
+			ret);
+		return ret;
+	}
+
+	if (!r[0] || !r[1])
+		return 0;
+
+	rdesc->desc.min_uV = ltc3589_scale(desc->min_uV, r[0], r[1]);
+	rdesc->desc.uV_step = ltc3589_scale(desc->uV_step, r[0], r[1]);
+	rdesc->desc.fixed_uV = ltc3589_scale(desc->fixed_uV, r[0], r[1]);
+
+	return 0;
+}
 
-#define LTC3589_REG(_name, _ops, en_bit, dtv1_reg, dtv_mask, go_bit)	\
+#define LTC3589_REG(_name, _of_name, _ops, en_bit, dtv1_reg, dtv_mask, go_bit)\
 	[LTC3589_ ## _name] = {						\
 		.desc = {						\
 			.name = #_name,					\
+			.of_match = of_match_ptr(#_of_name),		\
+			.regulators_node = of_match_ptr("regulators"),	\
+			.of_parse_cb = ltc3589_of_parse_cb,		\
 			.n_voltages = (dtv_mask) + 1,			\
 			.min_uV = (go_bit) ? 362500 : 0,		\
 			.uV_step = (go_bit) ? 12500 : 0,		\
@@ -219,109 +259,26 @@ static const struct regulator_ops ltc3589_table_regulator_ops = {
 		},							\
 	}
 
-#define LTC3589_LINEAR_REG(_name, _dtv1)				\
-	LTC3589_REG(_name, linear, LTC3589_OVEN_ ## _name,		\
+#define LTC3589_LINEAR_REG(_name, _of_name, _dtv1)			\
+	LTC3589_REG(_name, _of_name, linear, LTC3589_OVEN_ ## _name,	\
 		    LTC3589_ ## _dtv1, 0x1f,				\
 		    LTC3589_VCCR_ ## _name ## _GO)
 
-#define LTC3589_FIXED_REG(_name) \
-	LTC3589_REG(_name, fixed, LTC3589_OVEN_ ## _name, 0, 0, 0)
+#define LTC3589_FIXED_REG(_name, _of_name)				\
+	LTC3589_REG(_name, _of_name, fixed, LTC3589_OVEN_ ## _name, 0, 0, 0)
 
 static struct ltc3589_regulator ltc3589_regulators[LTC3589_NUM_REGULATORS] = {
-	LTC3589_LINEAR_REG(SW1, B1DTV1),
-	LTC3589_LINEAR_REG(SW2, B2DTV1),
-	LTC3589_LINEAR_REG(SW3, B3DTV1),
-	LTC3589_FIXED_REG(BB_OUT),
-	LTC3589_REG(LDO1, fixed_standby, 0, 0, 0, 0),
-	LTC3589_LINEAR_REG(LDO2, L2DTV1),
-	LTC3589_FIXED_REG(LDO3),
-	LTC3589_REG(LDO4, table, LTC3589_OVEN_LDO4, LTC3589_L2DTV2, 0x60, 0),
+	LTC3589_LINEAR_REG(SW1, sw1, B1DTV1),
+	LTC3589_LINEAR_REG(SW2, sw2, B2DTV1),
+	LTC3589_LINEAR_REG(SW3, sw3, B3DTV1),
+	LTC3589_FIXED_REG(BB_OUT, bb-out),
+	LTC3589_REG(LDO1, ldo1, fixed_standby, 0, 0, 0, 0),
+	LTC3589_LINEAR_REG(LDO2, ldo2, L2DTV1),
+	LTC3589_FIXED_REG(LDO3, ldo3),
+	LTC3589_REG(LDO4, ldo4, table, LTC3589_OVEN_LDO4, LTC3589_L2DTV2,
+		    0x60, 0),
 };
 
-#ifdef CONFIG_OF
-static struct of_regulator_match ltc3589_matches[LTC3589_NUM_REGULATORS] = {
-	{ .name = "sw1",    },
-	{ .name = "sw2",    },
-	{ .name = "sw3",    },
-	{ .name = "bb-out", },
-	{ .name = "ldo1",   }, /* standby */
-	{ .name = "ldo2",   },
-	{ .name = "ldo3",   },
-	{ .name = "ldo4",   },
-};
-
-static int ltc3589_parse_regulators_dt(struct ltc3589 *ltc3589)
-{
-	struct device *dev = ltc3589->dev;
-	struct device_node *node;
-	int i, ret;
-
-	node = of_get_child_by_name(dev->of_node, "regulators");
-	if (!node) {
-		dev_err(dev, "regulators node not found\n");
-		return -EINVAL;
-	}
-
-	ret = of_regulator_match(dev, node, ltc3589_matches,
-				 ARRAY_SIZE(ltc3589_matches));
-	of_node_put(node);
-	if (ret < 0) {
-		dev_err(dev, "Error parsing regulator init data: %d\n", ret);
-		return ret;
-	}
-	if (ret != LTC3589_NUM_REGULATORS) {
-		dev_err(dev, "Only %d regulators described in device tree\n",
-			ret);
-		return -EINVAL;
-	}
-
-	/* Parse feedback voltage dividers. LDO3 and LDO4 don't have them */
-	for (i = 0; i < LTC3589_LDO3; i++) {
-		struct ltc3589_regulator *desc = &ltc3589->regulator_descs[i];
-		struct device_node *np = ltc3589_matches[i].of_node;
-		u32 vdiv[2];
-
-		ret = of_property_read_u32_array(np, "lltc,fb-voltage-divider",
-						 vdiv, 2);
-		if (ret) {
-			dev_err(dev, "Failed to parse voltage divider: %d\n",
-				ret);
-			return ret;
-		}
-
-		desc->r1 = vdiv[0];
-		desc->r2 = vdiv[1];
-	}
-
-	return 0;
-}
-
-static inline struct regulator_init_data *match_init_data(int index)
-{
-	return ltc3589_matches[index].init_data;
-}
-
-static inline struct device_node *match_of_node(int index)
-{
-	return ltc3589_matches[index].of_node;
-}
-#else
-static inline int ltc3589_parse_regulators_dt(struct ltc3589 *ltc3589)
-{
-	return 0;
-}
-
-static inline struct regulator_init_data *match_init_data(int index)
-{
-	return NULL;
-}
-
-static inline struct device_node *match_of_node(int index)
-{
-	return NULL;
-}
-#endif
-
 static bool ltc3589_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -409,7 +366,6 @@ static const struct regmap_config ltc3589_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-
 static irqreturn_t ltc3589_isr(int irq, void *dev_id)
 {
 	struct ltc3589 *ltc3589 = dev_id;
@@ -443,28 +399,6 @@ static irqreturn_t ltc3589_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static inline unsigned int ltc3589_scale(unsigned int uV, u32 r1, u32 r2)
-{
-	uint64_t tmp;
-	if (uV == 0)
-		return 0;
-	tmp = (uint64_t)uV * r1;
-	do_div(tmp, r2);
-	return uV + (unsigned int)tmp;
-}
-
-static void ltc3589_apply_fb_voltage_divider(struct ltc3589_regulator *rdesc)
-{
-	struct regulator_desc *desc = &rdesc->desc;
-
-	if (!rdesc->r1 || !rdesc->r2)
-		return;
-
-	desc->min_uV = ltc3589_scale(desc->min_uV, rdesc->r1, rdesc->r2);
-	desc->uV_step = ltc3589_scale(desc->uV_step, rdesc->r1, rdesc->r2);
-	desc->fixed_uV = ltc3589_scale(desc->fixed_uV, rdesc->r1, rdesc->r2);
-}
-
 static int ltc3589_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -502,25 +436,13 @@ static int ltc3589_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = ltc3589_parse_regulators_dt(ltc3589);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
 		struct ltc3589_regulator *rdesc = &ltc3589->regulator_descs[i];
 		struct regulator_desc *desc = &rdesc->desc;
-		struct regulator_init_data *init_data;
 		struct regulator_config config = { };
 
-		init_data = match_init_data(i);
-
-		if (i < LTC3589_LDO3)
-			ltc3589_apply_fb_voltage_divider(rdesc);
-
 		config.dev = dev;
-		config.init_data = init_data;
 		config.driver_data = ltc3589;
-		config.of_node = match_of_node(i);
 
 		ltc3589->regulators[i] = devm_regulator_register(dev, desc,
 								 &config);
-- 
2.17.1

