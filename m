Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B56C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC882177E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="VvRrNTOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfC1MCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:02:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41838 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfC1MCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:02:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id y5so4851266plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rEMXWBSsMkGAXkWGfEbZsJlSSd6ANATFlJRdO7BaxJg=;
        b=VvRrNTOVs2+jz3ppTmSKYG+nzg5OjIBpZ7nTypNw3J8gsLMi7rz0O8YMp+4Vn10tDh
         4CLDTxQBaKKxGeNADNrR9SEBVX1Dk1LmiEwRsXpmGYlUs/3xhzKpRUZ7Q1+0OpnQoH1J
         JpYpBlN6+Cu5YYVziUP59+WGkN/2dX8WRcgeAMeqt7akijk2ypPeSlhEuk8may5/wqpJ
         L7G26UusCoVkq/xzMN31k979PjyTe+Bh7RfVbpiU3vXESb4pvjuTbAeVJWJctyn9l7+7
         7UYhjeJ4QvB2z6Nkhg8kmlkrvX9sCR7cuNv+O+IWg5vizMSdOrY1O1fEdC/Yrd1g2sBF
         ln8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rEMXWBSsMkGAXkWGfEbZsJlSSd6ANATFlJRdO7BaxJg=;
        b=jKg0CE0oTgx/HZQvTUEUxZ1gimyGXYQ7Up1VRLtoKY4TEFt5J0Rbclr5fMwchol5sZ
         jAp+/obyOb2gCQTW7Gpe5Td4CHm64BLSEHoi+3BgOJ7eA0vUEFzTKwLj6P1rAEJw5vV2
         /rpKlxCveZaYe0PQkmc3AoQcAJGgx8fr7dqmUySkEYPLDNAqrKc3He+EH3rwLCUBD6F9
         KpoPcYMfUjgu0aFmITmK8smhXAR5C9j2cYyoFSmgO/VHSzw0FygWqDz9pRWeXI8PW1Cg
         UTLsp0vrxP5kDBHc5xsRi/4pvCkcNw6B/fLcYcktKeRUMrvZ8Fx2uFNdCxCAr6SKgaXi
         nWLw==
X-Gm-Message-State: APjAAAWanvcArSIA7RbgtGLAvXq99p6aDgbqSFRpiwmbMAeLCRYlALGT
        VLSv8hIsdHA/rA978nP9Whly9A==
X-Google-Smtp-Source: APXvYqxxt4IBp/BbvDR12fMTmNEjCCnWDp8I2u0hVnuFiWVud+wuyLZSHTq8nbzae2OSc0+s+LDFNA==
X-Received: by 2002:a17:902:2a89:: with SMTP id j9mr41283613plb.272.1553774561254;
        Thu, 28 Mar 2019 05:02:41 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id l63sm36859856pfc.89.2019.03.28.05.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 05:02:40 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Anuj Aggarwal <anuj.aggarwal@ti.com>,
        Todd Fischer <todd.fischer@ridgerun.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: tps6507x: Convert to regulator core's simplified DT parsing code
Date:   Thu, 28 Mar 2019 20:02:25 +0800
Message-Id: <20190328120225.32556-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328120225.32556-1-axel.lin@ingics.com>
References: <20190328120225.32556-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps6507x-regulator.c | 107 +++++--------------------
 1 file changed, 19 insertions(+), 88 deletions(-)

diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index 4dbb22685539..a1b7fab91dd4 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -358,66 +358,20 @@ static const struct regulator_ops tps6507x_pmic_ops = {
 	.map_voltage = regulator_map_voltage_ascend,
 };
 
-static struct of_regulator_match tps6507x_matches[] = {
-	{ .name = "VDCDC1"},
-	{ .name = "VDCDC2"},
-	{ .name = "VDCDC3"},
-	{ .name = "LDO1"},
-	{ .name = "LDO2"},
-};
-
-static struct tps6507x_board *tps6507x_parse_dt_reg_data(
-		struct platform_device *pdev,
-		struct of_regulator_match **tps6507x_reg_matches)
+static int tps6507x_pmic_of_parse_cb(struct device_node *np,
+				     const struct regulator_desc *desc,
+				     struct regulator_config *config)
 {
-	struct tps6507x_board *tps_board;
-	struct device_node *np = pdev->dev.parent->of_node;
-	struct device_node *regulators;
-	struct of_regulator_match *matches;
-	struct regulator_init_data *reg_data;
-	int idx = 0, count, ret;
-
-	tps_board = devm_kzalloc(&pdev->dev, sizeof(*tps_board),
-					GFP_KERNEL);
-	if (!tps_board)
-		return NULL;
-
-	regulators = of_get_child_by_name(np, "regulators");
-	if (!regulators) {
-		dev_err(&pdev->dev, "regulator node not found\n");
-		return NULL;
-	}
-
-	count = ARRAY_SIZE(tps6507x_matches);
-	matches = tps6507x_matches;
-
-	ret = of_regulator_match(&pdev->dev, regulators, matches, count);
-	of_node_put(regulators);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error parsing regulator init data: %d\n",
-			ret);
-		return NULL;
-	}
-
-	*tps6507x_reg_matches = matches;
-
-	reg_data = devm_kzalloc(&pdev->dev, (sizeof(struct regulator_init_data)
-					* TPS6507X_NUM_REGULATOR), GFP_KERNEL);
-	if (!reg_data)
-		return NULL;
-
-	tps_board->tps6507x_pmic_init_data = reg_data;
-
-	for (idx = 0; idx < count; idx++) {
-		if (!matches[idx].init_data || !matches[idx].of_node)
-			continue;
-
-		memcpy(&reg_data[idx], matches[idx].init_data,
-				sizeof(struct regulator_init_data));
+	struct tps6507x_pmic *tps = config->driver_data;
+	struct tps_info *info = tps->info[desc->id];
+	u32 prop;
+	int ret;
 
-	}
+	ret = of_property_read_u32(np, "ti,defdcdc_default", &prop);
+	if (!ret)
+		info->defdcdc_default = prop;
 
-	return tps_board;
+	return 0;
 }
 
 static int tps6507x_pmic_probe(struct platform_device *pdev)
@@ -425,14 +379,11 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 	struct tps6507x_dev *tps6507x_dev = dev_get_drvdata(pdev->dev.parent);
 	struct tps_info *info = &tps6507x_pmic_regs[0];
 	struct regulator_config config = { };
-	struct regulator_init_data *init_data;
+	struct regulator_init_data *init_data = NULL;
 	struct regulator_dev *rdev;
 	struct tps6507x_pmic *tps;
 	struct tps6507x_board *tps_board;
-	struct of_regulator_match *tps6507x_reg_matches = NULL;
 	int i;
-	int error;
-	unsigned int prop;
 
 	/**
 	 * tps_board points to pmic related constants
@@ -440,20 +391,8 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 	 */
 
 	tps_board = dev_get_platdata(tps6507x_dev->dev);
-	if (IS_ENABLED(CONFIG_OF) && !tps_board &&
-		tps6507x_dev->dev->of_node)
-		tps_board = tps6507x_parse_dt_reg_data(pdev,
-				&tps6507x_reg_matches);
-	if (!tps_board)
-		return -EINVAL;
-
-	/**
-	 * init_data points to array of regulator_init structures
-	 * coming from the board-evm file.
-	 */
-	init_data = tps_board->tps6507x_pmic_init_data;
-	if (!init_data)
-		return -EINVAL;
+	if (tps_board)
+		init_data = tps_board->tps6507x_pmic_init_data;
 
 	tps = devm_kzalloc(&pdev->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -467,13 +406,16 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 	for (i = 0; i < TPS6507X_NUM_REGULATOR; i++, info++, init_data++) {
 		/* Register the regulators */
 		tps->info[i] = info;
-		if (init_data->driver_data) {
+		if (init_data && init_data->driver_data) {
 			struct tps6507x_reg_platform_data *data =
 					init_data->driver_data;
-			tps->info[i]->defdcdc_default = data->defdcdc_default;
+			info->defdcdc_default = data->defdcdc_default;
 		}
 
 		tps->desc[i].name = info->name;
+		tps->desc[i].of_match = of_match_ptr(info->name);
+		tps->desc[i].regulators_node = of_match_ptr("regulators");
+		tps->desc[i].of_parse_cb = tps6507x_pmic_of_parse_cb;
 		tps->desc[i].id = i;
 		tps->desc[i].n_voltages = info->table_len;
 		tps->desc[i].volt_table = info->table;
@@ -485,17 +427,6 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 		config.init_data = init_data;
 		config.driver_data = tps;
 
-		if (tps6507x_reg_matches) {
-			error = of_property_read_u32(
-				tps6507x_reg_matches[i].of_node,
-					"ti,defdcdc_default", &prop);
-
-			if (!error)
-				tps->info[i]->defdcdc_default = prop;
-
-			config.of_node = tps6507x_reg_matches[i].of_node;
-		}
-
 		rdev = devm_regulator_register(&pdev->dev, &tps->desc[i],
 					       &config);
 		if (IS_ERR(rdev)) {
-- 
2.17.1

