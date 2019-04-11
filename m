Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E1C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611C220873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Gi+SxuxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDKB7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:59:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45962 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfDKB7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:59:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so2513044plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 18:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EJ9Gt7MPu/Nj5TnWjjqCH7qQKn4gtoL1SgHZ5X1VZ88=;
        b=Gi+SxuxMAZ5A/wcNWpg/tRQ6kPgC3faNyKUkIz0n87hZ4vI7keTSijSEcHDQTEU7mN
         9lC05nlQt0w50Ai54ymeinMwQhDWVxefQUz15DypYZl2lvQARfEOzBqwyPG9X5Y/Kna2
         29Rujv3u/vqfL9rs5MwaPuN+x+VM79aVJ+p66eLow2Q186jtbRQ/5DQyzuANw6Oh8+X5
         dhvZL6KbPZisdloHaCAu6SNdnu23VLYkFG4iX/nH3fc2uO+Symq4XmiiMaFx/3+p2zwq
         xo2tKzuJ+4QwwQBLbkoRwyjN747p/j4Wg6M+P91NUGNgdLd0FQO9US/EpjhvvaA6CYPX
         un5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EJ9Gt7MPu/Nj5TnWjjqCH7qQKn4gtoL1SgHZ5X1VZ88=;
        b=SlaryW5tVsN60vbEZUrj+1Rrg2tSPBQUn2o9peZ7iTk/EVAetDadwNgyeAzI5e8mbt
         vwOrgOsxhi7oeeCx10syq4oqSZiWvwYWOFR0haDnTBjD8WUL5DlH3+w4pMY+mmgbVzKu
         pkNoC2zcUn4V0OweEDyfbV1pKj+xfuva35tuhwirsa0dt5jAcQr0zPCTuh/JYuroWLDN
         hJ9U5LQfmfN7r/we0pBSabe654XT3Go/dz1N0XES80uSANDkW8ttEWkiWiCHArTGXCsA
         XhhZ9RtV7vsBAjoSD/RG2s+6JaUGXPn4lxVVtrCgs6FELzZGIMyOUO2ClSTNTT/pXdd/
         CsXw==
X-Gm-Message-State: APjAAAWitKSHEHaHm4R/Aj/ocbCmxx1KJA/Blawxip4Kb1QEyZuWB21K
        1FZwR81ri22wA4eDMUtY3hVcl+52Mg0=
X-Google-Smtp-Source: APXvYqyc/PGc4/sm/jajvLwxc4YmyWIesBCQYWHXnyh9LNMxJJPZN686PI+fuWrH/DuDrImt81WLuw==
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr32205522plb.233.1554947976221;
        Wed, 10 Apr 2019 18:59:36 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id e193sm6612532pgc.53.2019.04.10.18.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 18:59:35 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: mcp16502: Remove unneeded fields from struct mcp16502
Date:   Thu, 11 Apr 2019 09:59:22 +0800
Message-Id: <20190411015923.7157-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the context with rdev, we can use rdev->regmap instead of mcp->rmap.
The *rdev[NUM_REGULATORS] is not required because current code uses
devm_regulator_register() so we don't need to store *rdev for clean up
paths.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 40 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 3a8004abe044..9292ab8736c7 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -119,8 +119,6 @@ enum {
  * @lpm: LPM GPIO descriptor
  */
 struct mcp16502 {
-	struct regulator_dev *rdev[NUM_REGULATORS];
-	struct regmap *rmap;
 	struct gpio_desc *lpm;
 };
 
@@ -179,13 +177,12 @@ static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
 {
 	unsigned int val;
 	int ret, reg;
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 
 	reg = mcp16502_get_reg(rdev, MCP16502_OPMODE_ACTIVE);
 	if (reg < 0)
 		return reg;
 
-	ret = regmap_read(mcp->rmap, reg, &val);
+	ret = regmap_read(rdev->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -211,7 +208,6 @@ static int _mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode,
 {
 	int val;
 	int reg;
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 
 	reg = mcp16502_get_reg(rdev, op_mode);
 	if (reg < 0)
@@ -228,7 +224,7 @@ static int _mcp16502_set_mode(struct regulator_dev *rdev, unsigned int mode,
 		return -EINVAL;
 	}
 
-	reg = regmap_update_bits(mcp->rmap, reg, MCP16502_MODE, val);
+	reg = regmap_update_bits(rdev->regmap, reg, MCP16502_MODE, val);
 	return reg;
 }
 
@@ -247,9 +243,8 @@ static int mcp16502_get_status(struct regulator_dev *rdev)
 {
 	int ret;
 	unsigned int val;
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 
-	ret = regmap_read(mcp->rmap, MCP16502_STAT_BASE(rdev_get_id(rdev)),
+	ret = regmap_read(rdev->regmap, MCP16502_STAT_BASE(rdev_get_id(rdev)),
 			  &val);
 	if (ret)
 		return ret;
@@ -290,7 +285,6 @@ static int mcp16502_suspend_get_target_reg(struct regulator_dev *rdev)
  */
 static int mcp16502_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 {
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 	int sel = regulator_map_voltage_linear_range(rdev, uV, uV);
 	int reg = mcp16502_suspend_get_target_reg(rdev);
 
@@ -300,7 +294,7 @@ static int mcp16502_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 	if (reg < 0)
 		return reg;
 
-	return regmap_update_bits(mcp->rmap, reg, MCP16502_VSEL, sel);
+	return regmap_update_bits(rdev->regmap, reg, MCP16502_VSEL, sel);
 }
 
 /*
@@ -328,13 +322,12 @@ static int mcp16502_set_suspend_mode(struct regulator_dev *rdev,
  */
 static int mcp16502_set_suspend_enable(struct regulator_dev *rdev)
 {
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 	int reg = mcp16502_suspend_get_target_reg(rdev);
 
 	if (reg < 0)
 		return reg;
 
-	return regmap_update_bits(mcp->rmap, reg, MCP16502_EN, MCP16502_EN);
+	return regmap_update_bits(rdev->regmap, reg, MCP16502_EN, MCP16502_EN);
 }
 
 /*
@@ -342,13 +335,12 @@ static int mcp16502_set_suspend_enable(struct regulator_dev *rdev)
  */
 static int mcp16502_set_suspend_disable(struct regulator_dev *rdev)
 {
-	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
 	int reg = mcp16502_suspend_get_target_reg(rdev);
 
 	if (reg < 0)
 		return reg;
 
-	return regmap_update_bits(mcp->rmap, reg, MCP16502_EN, 0);
+	return regmap_update_bits(rdev->regmap, reg, MCP16502_EN, 0);
 }
 #endif /* CONFIG_SUSPEND */
 
@@ -441,17 +433,16 @@ static const struct regmap_config mcp16502_regmap_config = {
 static int setup_regulators(struct mcp16502 *mcp, struct device *dev,
 			    struct regulator_config config)
 {
+	struct regulator_dev *rdev;
 	int i;
 
 	for (i = 0; i < NUM_REGULATORS; i++) {
-		mcp->rdev[i] = devm_regulator_register(dev,
-						       &mcp16502_desc[i],
-						       &config);
-		if (IS_ERR(mcp->rdev[i])) {
+		rdev = devm_regulator_register(dev, &mcp16502_desc[i], &config);
+		if (IS_ERR(rdev)) {
 			dev_err(dev,
 				"failed to register %s regulator %ld\n",
-				mcp16502_desc[i].name, PTR_ERR(mcp->rdev[i]));
-			return PTR_ERR(mcp->rdev[i]);
+				mcp16502_desc[i].name, PTR_ERR(rdev));
+			return PTR_ERR(rdev);
 		}
 	}
 
@@ -464,6 +455,7 @@ static int mcp16502_probe(struct i2c_client *client,
 	struct regulator_config config = { };
 	struct device *dev;
 	struct mcp16502 *mcp;
+	struct regmap *rmap;
 	int ret = 0;
 
 	dev = &client->dev;
@@ -473,15 +465,15 @@ static int mcp16502_probe(struct i2c_client *client,
 	if (!mcp)
 		return -ENOMEM;
 
-	mcp->rmap = devm_regmap_init_i2c(client, &mcp16502_regmap_config);
-	if (IS_ERR(mcp->rmap)) {
-		ret = PTR_ERR(mcp->rmap);
+	rmap = devm_regmap_init_i2c(client, &mcp16502_regmap_config);
+	if (IS_ERR(rmap)) {
+		ret = PTR_ERR(rmap);
 		dev_err(dev, "regmap init failed: %d\n", ret);
 		return ret;
 	}
 
 	i2c_set_clientdata(client, mcp);
-	config.regmap = mcp->rmap;
+	config.regmap = rmap;
 	config.driver_data = mcp;
 
 	mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
-- 
2.17.1

