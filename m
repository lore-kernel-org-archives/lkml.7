Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFF8C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA27A2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="KDPxQtJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfDMC3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 22:29:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDMC3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 22:29:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so6005803pgj.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 19:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yAFXPrMgigIXihGcQa7Lnv3A2PntZKJccF6sLLE81kI=;
        b=KDPxQtJuChD64G/NyXgPj38v3g++YvJHjXOtjdXlGmzFIk0C09u4EEm/M658BNE3KB
         9KCmEx22yhbdnLjkOgIA+U+/z961TesN77hUwro/XDcyrEErl84VYG3KoLlJf4sN46EW
         9yR6WCiQo1svGf4ugQugSH7br6RIB5NVLcddsnFZHFtXokxdWzmXonvEt7mCc7v+yprS
         BSfuLKTODlvMHcku1sgL3qHF+Y2VuoUSpRwW0HhpBQiVdZalWtLscQ7lwjc9k+fkT0/+
         mY+dAz94yWoYihPkLBl49IrKJ+VusgZ0XUEXJX6p3ZLgWNgtfQUegA9WZEsSZWRnZCEx
         f9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yAFXPrMgigIXihGcQa7Lnv3A2PntZKJccF6sLLE81kI=;
        b=qQuWaHG16AF2nlZEX5LvYW55cR5eYJ1AsspIIqq07SWJoOhCPJvTBYKab45uaabwPx
         6ShOvfIsXJ7EHpsGeyErF32EW1Lsc6ALIV1PfwsWLLdAZWBSAHQRcn2kh4tsTZ7QaL9B
         yeboeKt8i66h9bmKeXxGeP0zL/DTuP5qZGOBJyBFCixSp8nh+7Exn4NBJvI9sY+iUSsb
         vW4hgvjeRL/TOqbci2XTg2kobkG5WRdVtAnsS9NeqUSH1TGintEYLiVQjIPnroRuK9RC
         s31FkwSmZbz19ojh2maUxJIBUQKsGP4B2Bdq9qtUivvWhUADDxLZy5Ee/dztDjp1Qjp6
         4hew==
X-Gm-Message-State: APjAAAUABh7QsL31AJdkbp2hpCuYjuyK9u43phLsI5VZB4KtnesOqJpr
        pBOUqyfspTNdNDTo07TrkI2D2Q==
X-Google-Smtp-Source: APXvYqxkG4BUjgiDB8rplxbulmSBdHk/1xd0uow8koLnAYJ1jyZQps1nFcE5GYIiGtgCxnSLAKWtIw==
X-Received: by 2002:a63:b64:: with SMTP id a36mr57570818pgl.58.1555122558111;
        Fri, 12 Apr 2019 19:29:18 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-188.dynamic-ip.hinet.net. [36.239.234.188])
        by smtp.gmail.com with ESMTPSA id j14sm46899317pfa.57.2019.04.12.19.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 19:29:17 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>,
        Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: tps65218: Convert to use regulator_get_current_limit_regmap
Date:   Sat, 13 Apr 2019 10:29:07 +0800
Message-Id: <20190413022907.24789-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_get_current_limit_regmap helper to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps65218-regulator.c | 48 ++++++++++----------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 7aed3fbffecc..b72035610013 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -29,7 +29,8 @@
 #include <linux/mfd/tps65218.h>
 
 #define TPS65218_REGULATOR(_name, _of, _id, _type, _ops, _n, _vr, _vm, _er, \
-			   _em, _cr, _cm, _lr, _nlr, _delay, _fuv, _sr, _sm) \
+			   _em, _cr, _cm, _lr, _nlr, _delay, _fuv, _sr, _sm, \
+			   _ct, _ncl) \
 	{							\
 		.name			= _name,		\
 		.of_match		= _of,			\
@@ -42,6 +43,8 @@
 		.vsel_mask		= _vm,			\
 		.csel_reg		= _cr,			\
 		.csel_mask		= _cm,			\
+		.curr_table		= _ct,			\
+		.n_current_limits	= _ncl,			\
 		.enable_reg		= _er,			\
 		.enable_mask		= _em,			\
 		.volt_table		= NULL,			\
@@ -188,8 +191,7 @@ static const struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.set_suspend_disable	= tps65218_pmic_set_suspend_disable,
 };
 
-static const int ls3_currents[] = { 100000, 200000, 500000, 1000000 };
-
+static const unsigned int ls3_currents[] = { 100000, 200000, 500000, 1000000 };
 
 static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
 					       int lim_uA)
@@ -229,29 +231,13 @@ static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
 				 TPS65218_PROTECT_L1);
 }
 
-static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
-{
-	int retval;
-	unsigned int index;
-	struct tps65218 *tps = rdev_get_drvdata(dev);
-
-	retval = regmap_read(tps->regmap, dev->desc->csel_reg, &index);
-	if (retval < 0)
-		return retval;
-
-	index = (index & dev->desc->csel_mask) >>
-					 __builtin_ctz(dev->desc->csel_mask);
-
-	return ls3_currents[index];
-}
-
 static const struct regulator_ops tps65218_ls23_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
 	.set_input_current_limit = tps65218_pmic_set_input_current_lim,
 	.set_current_limit	= tps65218_pmic_set_current_limit,
-	.get_current_limit	= tps65218_pmic_get_current_limit,
+	.get_current_limit	= regulator_get_current_limit_regmap,
 };
 
 /* Operations permitted on DCDC5, DCDC6 */
@@ -270,53 +256,57 @@ static const struct regulator_desc regulators[] = {
 			   TPS65218_CONTROL_DCDC1_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC1_EN, 0, 0, dcdc1_dcdc2_ranges,
 			   2, 4000, 0, TPS65218_REG_SEQ3,
-			   TPS65218_SEQ3_DC1_SEQ_MASK),
+			   TPS65218_SEQ3_DC1_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("DCDC2", "regulator-dcdc2", TPS65218_DCDC_2,
 			   REGULATOR_VOLTAGE, tps65218_dcdc12_ops, 64,
 			   TPS65218_REG_CONTROL_DCDC2,
 			   TPS65218_CONTROL_DCDC2_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC2_EN, 0, 0, dcdc1_dcdc2_ranges,
 			   2, 4000, 0, TPS65218_REG_SEQ3,
-			   TPS65218_SEQ3_DC2_SEQ_MASK),
+			   TPS65218_SEQ3_DC2_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("DCDC3", "regulator-dcdc3", TPS65218_DCDC_3,
 			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 64,
 			   TPS65218_REG_CONTROL_DCDC3,
 			   TPS65218_CONTROL_DCDC3_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC3_EN, 0, 0, ldo1_dcdc3_ranges, 2,
-			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC3_SEQ_MASK),
+			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC3_SEQ_MASK,
+			   NULL, 0),
 	TPS65218_REGULATOR("DCDC4", "regulator-dcdc4", TPS65218_DCDC_4,
 			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 53,
 			   TPS65218_REG_CONTROL_DCDC4,
 			   TPS65218_CONTROL_DCDC4_MASK, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC4_EN, 0, 0, dcdc4_ranges, 2,
-			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC4_SEQ_MASK),
+			   0, 0, TPS65218_REG_SEQ4, TPS65218_SEQ4_DC4_SEQ_MASK,
+			   NULL, 0),
 	TPS65218_REGULATOR("DCDC5", "regulator-dcdc5", TPS65218_DCDC_5,
 			   REGULATOR_VOLTAGE, tps65218_dcdc56_pmic_ops, 1, -1,
 			   -1, TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC5_EN, 0,
 			   0, NULL, 0, 0, 1000000, TPS65218_REG_SEQ5,
-			   TPS65218_SEQ5_DC5_SEQ_MASK),
+			   TPS65218_SEQ5_DC5_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("DCDC6", "regulator-dcdc6", TPS65218_DCDC_6,
 			   REGULATOR_VOLTAGE, tps65218_dcdc56_pmic_ops, 1, -1,
 			   -1, TPS65218_REG_ENABLE1, TPS65218_ENABLE1_DC6_EN, 0,
 			   0, NULL, 0, 0, 1800000, TPS65218_REG_SEQ5,
-			   TPS65218_SEQ5_DC6_SEQ_MASK),
+			   TPS65218_SEQ5_DC6_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("LDO1", "regulator-ldo1", TPS65218_LDO_1,
 			   REGULATOR_VOLTAGE, tps65218_ldo1_dcdc34_ops, 64,
 			   TPS65218_REG_CONTROL_LDO1,
 			   TPS65218_CONTROL_LDO1_MASK, TPS65218_REG_ENABLE2,
 			   TPS65218_ENABLE2_LDO1_EN, 0, 0, ldo1_dcdc3_ranges,
 			   2, 0, 0, TPS65218_REG_SEQ6,
-			   TPS65218_SEQ6_LDO1_SEQ_MASK),
+			   TPS65218_SEQ6_LDO1_SEQ_MASK, NULL, 0),
 	TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
 			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
 			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS2_EN,
 			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS2ILIM_MASK,
-			   NULL, 0, 0, 0, 0, 0),
+			   NULL, 0, 0, 0, 0, 0, ls3_currents,
+			   ARRAY_SIZE(ls3_currents)),
 	TPS65218_REGULATOR("LS3", "regulator-ls3", TPS65218_LS_3,
 			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
 			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS3_EN,
 			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS3ILIM_MASK,
-			   NULL, 0, 0, 0, 0, 0),
+			   NULL, 0, 0, 0, 0, 0, ls3_currents,
+			   ARRAY_SIZE(ls3_currents)),
 };
 
 static int tps65218_regulator_probe(struct platform_device *pdev)
-- 
2.17.1

