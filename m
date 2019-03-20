Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A542146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="gcf1VQNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfCTLkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:40:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37099 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfCTLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:40:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so1758587pfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RCzSIHq/usPy1SZSQl4aky3KfYzMolvPk3ngnvcAqB0=;
        b=gcf1VQNmdgpJRQ41liTULY7pjTT02PSquAtMmpT7qdqhzHjGflyPwQJvGbWh28oRC2
         evQvkj/C9BjxV/XDViNJtRhpbb1U3n2/AR/kDXo1UwOTpY/97LmgjhK0qTUNEzqQcgET
         QDI5jrdtYPUVA8yoEAuXjgfnR9Vyyn+m1gx+NkTnHbfMzwHQLauJJDs6N0/AYVgmxpnw
         h2O7KWscOowKN9p8SMdQ34urzUmZZnEKflZqRciRYcVC4Ao38l85oA+dngA4u229RIXX
         IBHE9RZcTbZYvko51Hzpn+OANJb7iFvs3Kt5uqqgePxBj3T/pnIEQRlP8gyc+FU8iedN
         hRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RCzSIHq/usPy1SZSQl4aky3KfYzMolvPk3ngnvcAqB0=;
        b=R9i01Uq6+XItT9gPWu1v6I0KpP41YbcC9F5usl8wjAofC0lH/STEm8uDb/fC1G7bLk
         0pvkoM8XkjLVPV8hKzQCgEyzx4lGFaVaGCcbbFSFWbNuJrYD3luC2niPQTCitcB+KMd+
         ZweS+Ynm1BvMO6TxABp6yrK/ccZqZxhhprGlM7USTSMMzI7eJSrw2H49emsA3UabndnM
         VWR5yFyALCFuVqy1eYVxmxqMCjATLS8oeDJKCNoEadUTDiqgG2I9GRZGucp1vq+QIQl1
         bDteQxucHAZtqkTB5xQ5g1XLI9tVkeZDsvpVV7ieF31tA6wPr220JVc4yWXA35IAdN5f
         y54g==
X-Gm-Message-State: APjAAAVRsR0VbGxUG2hLgl2bp1In2kVs+yTsw0fH/2pNyC/G02wzAXhi
        0h2OeZn9lkwLL96jyg4+miEBIdfCERA=
X-Google-Smtp-Source: APXvYqza85BUy6fs9DQa6l9ISK1FvQyHyK3dX850CcjwXj4JGgF5Q8iEu+XY+Y1ewjGasROh+XrGPA==
X-Received: by 2002:a17:902:2865:: with SMTP id e92mr7611762plb.312.1553082035739;
        Wed, 20 Mar 2019 04:40:35 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-96.dynamic-ip.hinet.net. [118.171.142.96])
        by smtp.gmail.com with ESMTPSA id x5sm2214225pgp.68.2019.03.20.04.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:40:34 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max8925: Convert to regulator core's simplified DT parsing code
Date:   Wed, 20 Mar 2019 19:40:23 +0800
Message-Id: <20190320114023.19801-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max8925-regulator.c | 76 ++++-----------------------
 1 file changed, 9 insertions(+), 67 deletions(-)

diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index 39b63ddefeb2..aed6727982cd 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -159,6 +159,8 @@ static const struct regulator_ops max8925_regulator_ldo_ops = {
 {								\
 	.desc	= {						\
 		.name	= "SDV" #_id,				\
+		.of_match = of_match_ptr("SDV" #_id),		\
+		.regulators_node = of_match_ptr("regulators"),	\
 		.ops	= &max8925_regulator_sdv_ops,		\
 		.type	= REGULATOR_VOLTAGE,			\
 		.id	= MAX8925_ID_SD##_id,			\
@@ -175,6 +177,8 @@ static const struct regulator_ops max8925_regulator_ldo_ops = {
 {								\
 	.desc	= {						\
 		.name	= "LDO" #_id,				\
+		.of_match = of_match_ptr("LDO" #_id),		\
+		.regulators_node = of_match_ptr("regulators"),	\
 		.ops	= &max8925_regulator_ldo_ops,		\
 		.type	= REGULATOR_VOLTAGE,			\
 		.id	= MAX8925_ID_LDO##_id,			\
@@ -187,34 +191,6 @@ static const struct regulator_ops max8925_regulator_ldo_ops = {
 	.enable_reg	= MAX8925_LDOCTL##_id,			\
 }
 
-#ifdef CONFIG_OF
-static struct of_regulator_match max8925_regulator_matches[] = {
-	{ .name	= "SDV1",},
-	{ .name = "SDV2",},
-	{ .name = "SDV3",},
-	{ .name = "LDO1",},
-	{ .name = "LDO2",},
-	{ .name = "LDO3",},
-	{ .name = "LDO4",},
-	{ .name = "LDO5",},
-	{ .name = "LDO6",},
-	{ .name = "LDO7",},
-	{ .name = "LDO8",},
-	{ .name = "LDO9",},
-	{ .name = "LDO10",},
-	{ .name = "LDO11",},
-	{ .name = "LDO12",},
-	{ .name = "LDO13",},
-	{ .name = "LDO14",},
-	{ .name = "LDO15",},
-	{ .name = "LDO16",},
-	{ .name = "LDO17",},
-	{ .name = "LDO18",},
-	{ .name = "LDO19",},
-	{ .name = "LDO20",},
-};
-#endif
-
 static struct max8925_regulator_info max8925_regulator_info[] = {
 	MAX8925_SDV(1, 637.5, 1425, 12.5),
 	MAX8925_SDV(2,   650, 2225,   25),
@@ -242,37 +218,6 @@ static struct max8925_regulator_info max8925_regulator_info[] = {
 	MAX8925_LDO(20, 750, 3900, 50),
 };
 
-#ifdef CONFIG_OF
-static int max8925_regulator_dt_init(struct platform_device *pdev,
-				    struct regulator_config *config,
-				    int ridx)
-{
-	struct device_node *nproot, *np;
-	int rcount;
-
-	nproot = pdev->dev.parent->of_node;
-	if (!nproot)
-		return -ENODEV;
-	np = of_get_child_by_name(nproot, "regulators");
-	if (!np) {
-		dev_err(&pdev->dev, "failed to find regulators node\n");
-		return -ENODEV;
-	}
-
-	rcount = of_regulator_match(&pdev->dev, np,
-				&max8925_regulator_matches[ridx], 1);
-	of_node_put(np);
-	if (rcount < 0)
-		return rcount;
-	config->init_data =	max8925_regulator_matches[ridx].init_data;
-	config->of_node = max8925_regulator_matches[ridx].of_node;
-
-	return 0;
-}
-#else
-#define max8925_regulator_dt_init(x, y, z)	(-1)
-#endif
-
 static int max8925_regulator_probe(struct platform_device *pdev)
 {
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
@@ -281,7 +226,7 @@ static int max8925_regulator_probe(struct platform_device *pdev)
 	struct max8925_regulator_info *ri;
 	struct resource *res;
 	struct regulator_dev *rdev;
-	int i, regulator_idx;
+	int i;
 
 	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
 	if (!res) {
@@ -290,10 +235,8 @@ static int max8925_regulator_probe(struct platform_device *pdev)
 	}
 	for (i = 0; i < ARRAY_SIZE(max8925_regulator_info); i++) {
 		ri = &max8925_regulator_info[i];
-		if (ri->vol_reg == res->start) {
-			regulator_idx = i;
+		if (ri->vol_reg == res->start)
 			break;
-		}
 	}
 
 	if (i == ARRAY_SIZE(max8925_regulator_info)) {
@@ -303,12 +246,11 @@ static int max8925_regulator_probe(struct platform_device *pdev)
 	}
 	ri->i2c = chip->i2c;
 
-	config.dev = &pdev->dev;
+	config.dev = chip->dev;
 	config.driver_data = ri;
 
-	if (max8925_regulator_dt_init(pdev, &config, regulator_idx))
-		if (pdata)
-			config.init_data = pdata;
+	if (pdata)
+		config.init_data = pdata;
 
 	rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
 	if (IS_ERR(rdev)) {
-- 
2.17.1

