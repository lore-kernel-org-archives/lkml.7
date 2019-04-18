Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805592183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="unGTsUEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbfDRLpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:45:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40591 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRLpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:45:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so999449pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ZKp2mxK33VHGbO7KAi3Qi8hPzNY3jh0BvbhNSi5Vt8=;
        b=unGTsUEmpYXdXx9UVyYYTctor2hvsqagVLbJbq2H7sVzqpWrEVSnoieiIjjVJOnDRg
         gWLpBG0uevJWu/GR3hkU2NYa4WHPIw8jEbPOi9PIGAwzZ0Dtq0pmNA8I7pKTQ0dlYHyG
         uPw9FT9l4B4Ov5Bfs7nyIqCSew1fZq4cl0vLnfzJUhheWGH+JpgH6L0tVrqkeexGZDTJ
         XAyHsqTq2Bx/XA5BqyHGiAT6mTnEU+mkFZS8oJG6nc5YwRTV+o9ecGcd/I23/9b0LpT7
         CZ1KDpGDu3ZNa4jRj4csrCjErULLw2GC6PMCKyaEW5imSWbgtMRR0PeENP87x+6aACfX
         Btrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ZKp2mxK33VHGbO7KAi3Qi8hPzNY3jh0BvbhNSi5Vt8=;
        b=d/WuN32fC6AiDBTpfZNyF6yd9PPxAnb2VtDKF7bD+9rZnf2zipCqXXaOAFzlbBcLd4
         Ixb6js17eHrX+5hbGqv+hWO+i4grw90OSK9dlMTw4uQQaFR38+EwgyHJwVz2CWHM0O91
         Wv+zJsbMCUKVO1uxOC4E24EN1x05L/ykjI4LL7vocPVDhHIg/K0oZ55YgbIK49WKJt+t
         e2GoNwjWUq4CQgcOpo95CAGs47BRfvQ/jfjXlTBqA91EbNlxEuexQN0nEDQklj21U4lf
         0MAYAxOnoraBWV5zMXYD8Nenl7WIZiExlV9kV+DBA3plKVg3JOz16gEi6BM/v7c25SNp
         Lx2Q==
X-Gm-Message-State: APjAAAWcUxJTxVU5F0H9xZGPcLhhU3+QQUGzBr/CjXW//WwmqGg+9FGU
        oMl61TIhbxGAZVqedPk1noxh9Q==
X-Google-Smtp-Source: APXvYqx5Vi6YDuIPehvPVpbB52LtEUF91tgLy8SO2vyVcMkjc3+FnB+QEwfzP3IMZUmUdcE+GU8R7A==
X-Received: by 2002:a63:30c5:: with SMTP id w188mr87408989pgw.76.1555587916893;
        Thu, 18 Apr 2019 04:45:16 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id l19sm2550579pff.1.2019.04.18.04.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 04:45:16 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: ltc3589: Get rid of struct ltc3589_regulator
Date:   Thu, 18 Apr 2019 19:44:59 +0800
Message-Id: <20190418114500.1098-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418114500.1098-1-axel.lin@ingics.com>
References: <20190418114500.1098-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After converting to use simplified DT parsing, the struct ltc3589_regulator
only has a desc member. So let's remove struct ltc3589_regulator and use
struct regulator_desc instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ltc3589.c | 69 +++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 35741f476024..077e73715514 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -84,15 +84,11 @@ enum ltc3589_reg {
 	LTC3589_NUM_REGULATORS,
 };
 
-struct ltc3589_regulator {
-	struct regulator_desc desc;
-};
-
 struct ltc3589 {
 	struct regmap *regmap;
 	struct device *dev;
 	enum ltc3589_variant variant;
-	struct ltc3589_regulator regulator_descs[LTC3589_NUM_REGULATORS];
+	struct regulator_desc regulator_descs[LTC3589_NUM_REGULATORS];
 	struct regulator_dev *regulators[LTC3589_NUM_REGULATORS];
 };
 
@@ -209,7 +205,7 @@ static int ltc3589_of_parse_cb(struct device_node *np,
 			       struct regulator_config *config)
 {
 	struct ltc3589 *ltc3589 = config->driver_data;
-	struct ltc3589_regulator *rdesc = &ltc3589->regulator_descs[desc->id];
+	struct regulator_desc *rdesc = &ltc3589->regulator_descs[desc->id];
 	u32 r[2];
 	int ret;
 
@@ -227,36 +223,34 @@ static int ltc3589_of_parse_cb(struct device_node *np,
 	if (!r[0] || !r[1])
 		return 0;
 
-	rdesc->desc.min_uV = ltc3589_scale(desc->min_uV, r[0], r[1]);
-	rdesc->desc.uV_step = ltc3589_scale(desc->uV_step, r[0], r[1]);
-	rdesc->desc.fixed_uV = ltc3589_scale(desc->fixed_uV, r[0], r[1]);
+	rdesc->min_uV = ltc3589_scale(desc->min_uV, r[0], r[1]);
+	rdesc->uV_step = ltc3589_scale(desc->uV_step, r[0], r[1]);
+	rdesc->fixed_uV = ltc3589_scale(desc->fixed_uV, r[0], r[1]);
 
 	return 0;
 }
 
 #define LTC3589_REG(_name, _of_name, _ops, en_bit, dtv1_reg, dtv_mask, go_bit)\
 	[LTC3589_ ## _name] = {						\
-		.desc = {						\
-			.name = #_name,					\
-			.of_match = of_match_ptr(#_of_name),		\
-			.regulators_node = of_match_ptr("regulators"),	\
-			.of_parse_cb = ltc3589_of_parse_cb,		\
-			.n_voltages = (dtv_mask) + 1,			\
-			.min_uV = (go_bit) ? 362500 : 0,		\
-			.uV_step = (go_bit) ? 12500 : 0,		\
-			.ramp_delay = (go_bit) ? 1750 : 0,		\
-			.fixed_uV = (dtv_mask) ? 0 : 800000,		\
-			.ops = &ltc3589_ ## _ops ## _regulator_ops,	\
-			.type = REGULATOR_VOLTAGE,			\
-			.id = LTC3589_ ## _name,			\
-			.owner = THIS_MODULE,				\
-			.vsel_reg = (dtv1_reg),			\
-			.vsel_mask = (dtv_mask),			\
-			.apply_reg = (go_bit) ? LTC3589_VCCR : 0,	\
-			.apply_bit = (go_bit),				\
-			.enable_reg = (en_bit) ? LTC3589_OVEN : 0,	\
-			.enable_mask = (en_bit),			\
-		},							\
+		.name = #_name,						\
+		.of_match = of_match_ptr(#_of_name),			\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.of_parse_cb = ltc3589_of_parse_cb,			\
+		.n_voltages = (dtv_mask) + 1,				\
+		.min_uV = (go_bit) ? 362500 : 0,			\
+		.uV_step = (go_bit) ? 12500 : 0,			\
+		.ramp_delay = (go_bit) ? 1750 : 0,			\
+		.fixed_uV = (dtv_mask) ? 0 : 800000,			\
+		.ops = &ltc3589_ ## _ops ## _regulator_ops,		\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = LTC3589_ ## _name,				\
+		.owner = THIS_MODULE,					\
+		.vsel_reg = (dtv1_reg),					\
+		.vsel_mask = (dtv_mask),				\
+		.apply_reg = (go_bit) ? LTC3589_VCCR : 0,		\
+		.apply_bit = (go_bit),					\
+		.enable_reg = (en_bit) ? LTC3589_OVEN : 0,		\
+		.enable_mask = (en_bit),				\
 	}
 
 #define LTC3589_LINEAR_REG(_name, _of_name, _dtv1)			\
@@ -267,7 +261,7 @@ static int ltc3589_of_parse_cb(struct device_node *np,
 #define LTC3589_FIXED_REG(_name, _of_name)				\
 	LTC3589_REG(_name, _of_name, fixed, LTC3589_OVEN_ ## _name, 0, 0, 0)
 
-static struct ltc3589_regulator ltc3589_regulators[LTC3589_NUM_REGULATORS] = {
+static const struct regulator_desc ltc3589_regulators[] = {
 	LTC3589_LINEAR_REG(SW1, sw1, B1DTV1),
 	LTC3589_LINEAR_REG(SW2, sw2, B2DTV1),
 	LTC3589_LINEAR_REG(SW3, sw3, B3DTV1),
@@ -403,7 +397,7 @@ static int ltc3589_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	struct ltc3589_regulator *descs;
+	struct regulator_desc *descs;
 	struct ltc3589 *ltc3589;
 	int i, ret;
 
@@ -422,11 +416,11 @@ static int ltc3589_probe(struct i2c_client *client,
 	descs = ltc3589->regulator_descs;
 	memcpy(descs, ltc3589_regulators, sizeof(ltc3589_regulators));
 	if (ltc3589->variant == LTC3589) {
-		descs[LTC3589_LDO3].desc.fixed_uV = 1800000;
-		descs[LTC3589_LDO4].desc.volt_table = ltc3589_ldo4;
+		descs[LTC3589_LDO3].fixed_uV = 1800000;
+		descs[LTC3589_LDO4].volt_table = ltc3589_ldo4;
 	} else {
-		descs[LTC3589_LDO3].desc.fixed_uV = 2800000;
-		descs[LTC3589_LDO4].desc.volt_table = ltc3589_12_ldo4;
+		descs[LTC3589_LDO3].fixed_uV = 2800000;
+		descs[LTC3589_LDO4].volt_table = ltc3589_12_ldo4;
 	}
 
 	ltc3589->regmap = devm_regmap_init_i2c(client, &ltc3589_regmap_config);
@@ -437,8 +431,7 @@ static int ltc3589_probe(struct i2c_client *client,
 	}
 
 	for (i = 0; i < LTC3589_NUM_REGULATORS; i++) {
-		struct ltc3589_regulator *rdesc = &ltc3589->regulator_descs[i];
-		struct regulator_desc *desc = &rdesc->desc;
+		struct regulator_desc *desc = &ltc3589->regulator_descs[i];
 		struct regulator_config config = { };
 
 		config.dev = dev;
-- 
2.17.1

