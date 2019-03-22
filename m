Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29828C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FEE218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="ajzSAWkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfCVGik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:38:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43912 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfCVGik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:38:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so827368pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 23:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=GqCFNCHwCWex9kY5aQD0+YkFCj4GOyZq5hipltOCRrE=;
        b=ajzSAWkKFG1CR8yfxnJ/A1M/E3hFd0sLjM9DT2V/AG0NwwCooByU1UfdetoHW06zpM
         Kb7pAx8NSfUuv8riXRs3bD6woULsxZOdoP2/AY6qYwQ8j7VWz3kuDjiZtdsLPZF5ZFU1
         c/IO/6tyNMGiKwLcUY3ayxpNf4qgrGMlo/XkJNlmbX9QuK29YjbFnur8G8FyocMP7+hw
         uyIvdVbvaorhAA2hpUmuQYdGERAWH6r0bPpaovoioSseSY14tPFV6DCJBDpNVdBJB161
         bOsjSO/PbAOKN3KmMQz1F+pk/CnBvt41GZ/SjsoD+Cu98PW7AquIlW3kaiHiBBP8p7Qs
         /aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GqCFNCHwCWex9kY5aQD0+YkFCj4GOyZq5hipltOCRrE=;
        b=CCZbwChEEwj3kvSJiAxkPJbrZPzF7PN0jMoEdL3ylDsPRxYls4HhXtgGPtPpkQGlOh
         A1WDgiMYMYPBZtbU8ZdzN2fvyiDk2gOoyaIL3um55imJ7//MILkyMe3/Iq0QXE3hlZ+R
         HkX1/3e1YU1Q/ODka4BCLVbNDaKXXLxSUsyCe+9n3VpTGPesde19p7/EQXLyXJaPBA3W
         tn0jDThnZp5tIKlZUalubjVpNotg5RnuDz1wzxkeG88ARe62MoBmAUymiDUSK6wGTjMw
         WIJ6lETOH3ORB4iWbCqS1UENmODHKBzd5fp0LZnjsX/1DvmEgejdlLAJ1A0wR76+17Ro
         qkCA==
X-Gm-Message-State: APjAAAXacAtHflydyYTAcsVePDceDWDolmGDhWdeXEhuzyqjUe5Yo5d8
        J9DBpFZprJ0fAsRmx7xjIl6drg==
X-Google-Smtp-Source: APXvYqz3HZv7QeZso888aOcvgnAys89SihVElaXehpolY6LbpmATM8Uy6DUmQDyTJujQUhr/Ml4dWw==
X-Received: by 2002:a63:d706:: with SMTP id d6mr6968545pgg.367.1553236718350;
        Thu, 21 Mar 2019 23:38:38 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-125.dynamic-ip.hinet.net. [118.171.129.125])
        by smtp.gmail.com with ESMTPSA id v4sm7953766pgh.53.2019.03.21.23.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 23:38:37 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: act8865: Convert to regulator core's simplified DT parsing code
Date:   Fri, 22 Mar 2019 14:38:19 +0800
Message-Id: <20190322063820.31205-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation. With this conversion, also move the NULL test against pdata
in act8865_get_regulator_data() to the caller. This makes it clear the
code path to explicitly set init_data is for non-DT case only.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/act8865-regulator.c | 143 ++++----------------------
 1 file changed, 19 insertions(+), 124 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index e0239cf3f56d..af8f201e67d7 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -245,6 +245,8 @@ static struct regulator_ops act8865_ldo_ops = {
 #define ACT88xx_REG(_name, _family, _id, _vsel_reg, _supply)		\
 	[_family##_ID_##_id] = {					\
 		.name			= _name,			\
+		.of_match		= of_match_ptr(_name),		\
+		.regulators_node	= of_match_ptr("regulators"),	\
 		.supply_name		= _supply,			\
 		.id			= _family##_ID_##_id,		\
 		.type			= REGULATOR_VOLTAGE,		\
@@ -265,6 +267,8 @@ static const struct regulator_desc act8600_regulators[] = {
 	ACT88xx_REG("DCDC3", ACT8600, DCDC3, VSET, "vp3"),
 	{
 		.name = "SUDCDC_REG4",
+		.of_match = of_match_ptr("SUDCDC_REG4"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_SUDCDC4,
 		.ops = &act8865_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -283,6 +287,8 @@ static const struct regulator_desc act8600_regulators[] = {
 	ACT88xx_REG("LDO8", ACT8600, LDO8, VSET, "inl"),
 	{
 		.name = "LDO_REG9",
+		.of_match = of_match_ptr("LDO_REG9"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_LDO9,
 		.ops = &act8865_ldo_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -294,6 +300,8 @@ static const struct regulator_desc act8600_regulators[] = {
 	},
 	{
 		.name = "LDO_REG10",
+		.of_match = of_match_ptr("LDO_REG10"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_LDO10,
 		.ops = &act8865_ldo_ops,
 		.type = REGULATOR_VOLTAGE,
@@ -348,110 +356,6 @@ static const struct of_device_id act8865_dt_ids[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, act8865_dt_ids);
-
-static struct of_regulator_match act8846_matches[] = {
-	[ACT8846_ID_REG1]	= { .name = "REG1" },
-	[ACT8846_ID_REG2]	= { .name = "REG2" },
-	[ACT8846_ID_REG3]	= { .name = "REG3" },
-	[ACT8846_ID_REG4]	= { .name = "REG4" },
-	[ACT8846_ID_REG5]	= { .name = "REG5" },
-	[ACT8846_ID_REG6]	= { .name = "REG6" },
-	[ACT8846_ID_REG7]	= { .name = "REG7" },
-	[ACT8846_ID_REG8]	= { .name = "REG8" },
-	[ACT8846_ID_REG9]	= { .name = "REG9" },
-	[ACT8846_ID_REG10]	= { .name = "REG10" },
-	[ACT8846_ID_REG11]	= { .name = "REG11" },
-	[ACT8846_ID_REG12]	= { .name = "REG12" },
-};
-
-static struct of_regulator_match act8865_matches[] = {
-	[ACT8865_ID_DCDC1]	= { .name = "DCDC_REG1"},
-	[ACT8865_ID_DCDC2]	= { .name = "DCDC_REG2"},
-	[ACT8865_ID_DCDC3]	= { .name = "DCDC_REG3"},
-	[ACT8865_ID_LDO1]	= { .name = "LDO_REG1"},
-	[ACT8865_ID_LDO2]	= { .name = "LDO_REG2"},
-	[ACT8865_ID_LDO3]	= { .name = "LDO_REG3"},
-	[ACT8865_ID_LDO4]	= { .name = "LDO_REG4"},
-};
-
-static struct of_regulator_match act8600_matches[] = {
-	[ACT8600_ID_DCDC1]	= { .name = "DCDC_REG1"},
-	[ACT8600_ID_DCDC2]	= { .name = "DCDC_REG2"},
-	[ACT8600_ID_DCDC3]	= { .name = "DCDC_REG3"},
-	[ACT8600_ID_SUDCDC4]	= { .name = "SUDCDC_REG4"},
-	[ACT8600_ID_LDO5]	= { .name = "LDO_REG5"},
-	[ACT8600_ID_LDO6]	= { .name = "LDO_REG6"},
-	[ACT8600_ID_LDO7]	= { .name = "LDO_REG7"},
-	[ACT8600_ID_LDO8]	= { .name = "LDO_REG8"},
-	[ACT8600_ID_LDO9]	= { .name = "LDO_REG9"},
-	[ACT8600_ID_LDO10]	= { .name = "LDO_REG10"},
-};
-
-static int act8865_pdata_from_dt(struct device *dev,
-				 struct act8865_platform_data *pdata,
-				 unsigned long type)
-{
-	int matched, i, num_matches;
-	struct device_node *np;
-	struct act8865_regulator_data *regulator;
-	struct of_regulator_match *matches;
-
-	switch (type) {
-	case ACT8600:
-		matches = act8600_matches;
-		num_matches = ARRAY_SIZE(act8600_matches);
-		break;
-	case ACT8846:
-		matches = act8846_matches;
-		num_matches = ARRAY_SIZE(act8846_matches);
-		break;
-	case ACT8865:
-		matches = act8865_matches;
-		num_matches = ARRAY_SIZE(act8865_matches);
-		break;
-	default:
-		dev_err(dev, "invalid device id %lu\n", type);
-		return -EINVAL;
-	}
-
-	np = of_get_child_by_name(dev->of_node, "regulators");
-	if (!np) {
-		dev_err(dev, "missing 'regulators' subnode in DT\n");
-		return -EINVAL;
-	}
-
-	matched = of_regulator_match(dev, np, matches, num_matches);
-	of_node_put(np);
-	if (matched <= 0)
-		return matched;
-
-	pdata->regulators = devm_kcalloc(dev,
-					 num_matches,
-					 sizeof(struct act8865_regulator_data),
-					 GFP_KERNEL);
-	if (!pdata->regulators)
-		return -ENOMEM;
-
-	pdata->num_regulators = num_matches;
-	regulator = pdata->regulators;
-
-	for (i = 0; i < num_matches; i++) {
-		regulator->id = i;
-		regulator->name = matches[i].name;
-		regulator->init_data = matches[i].init_data;
-		regulator->of_node = matches[i].of_node;
-		regulator++;
-	}
-
-	return 0;
-}
-#else
-static inline int act8865_pdata_from_dt(struct device *dev,
-					struct act8865_platform_data *pdata,
-					unsigned long type)
-{
-	return 0;
-}
 #endif
 
 static struct act8865_regulator_data *act8865_get_regulator_data(
@@ -459,9 +363,6 @@ static struct act8865_regulator_data *act8865_get_regulator_data(
 {
 	int i;
 
-	if (!pdata)
-		return NULL;
-
 	for (i = 0; i < pdata->num_regulators; i++) {
 		if (pdata->regulators[i].id == id)
 			return &pdata->regulators[i];
@@ -484,7 +385,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 			      const struct i2c_device_id *i2c_id)
 {
 	const struct regulator_desc *regulators;
-	struct act8865_platform_data pdata_of, *pdata;
+	struct act8865_platform_data *pdata = NULL;
 	struct device *dev = &client->dev;
 	int i, ret, num_regulators;
 	struct act8865 *act8865;
@@ -493,9 +394,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 	int off_reg, off_mask;
 	int voltage_select = 0;
 
-	pdata = dev_get_platdata(dev);
-
-	if (dev->of_node && !pdata) {
+	if (dev->of_node) {
 		const struct of_device_id *id;
 
 		id = of_match_device(of_match_ptr(act8865_dt_ids), dev);
@@ -509,6 +408,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 						   NULL);
 	} else {
 		type = i2c_id->driver_data;
+		pdata = dev_get_platdata(dev);
 	}
 
 	switch (type) {
@@ -543,14 +443,6 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	if (dev->of_node && !pdata) {
-		ret = act8865_pdata_from_dt(dev, &pdata_of, type);
-		if (ret < 0)
-			return ret;
-
-		pdata = &pdata_of;
-	}
-
 	act8865 = devm_kzalloc(dev, sizeof(struct act8865), GFP_KERNEL);
 	if (!act8865)
 		return -ENOMEM;
@@ -577,17 +469,20 @@ static int act8865_pmic_probe(struct i2c_client *client,
 	for (i = 0; i < num_regulators; i++) {
 		const struct regulator_desc *desc = &regulators[i];
 		struct regulator_config config = { };
-		struct act8865_regulator_data *rdata;
 		struct regulator_dev *rdev;
 
 		config.dev = dev;
 		config.driver_data = act8865;
 		config.regmap = act8865->regmap;
 
-		rdata = act8865_get_regulator_data(desc->id, pdata);
-		if (rdata) {
-			config.init_data = rdata->init_data;
-			config.of_node = rdata->of_node;
+		if (pdata) {
+			struct act8865_regulator_data *rdata;
+
+			rdata = act8865_get_regulator_data(desc->id, pdata);
+			if (rdata) {
+				config.init_data = rdata->init_data;
+				config.of_node = rdata->of_node;
+			}
 		}
 
 		rdev = devm_regulator_register(dev, desc, &config);
-- 
2.17.1

