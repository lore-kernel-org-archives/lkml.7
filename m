Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13188C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDB621850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="RiIaCwhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfB1NlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40412 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbfB1NlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so9773212plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4qboQr5mj/MpLlzJSKMn+3syI3I3umISlClB03x9/+U=;
        b=RiIaCwhgd1CwaCDefg2WFV3xj8tEzhSAaJ2COLI2FHnjCV60YuirGxf5N3vYnWFbHn
         ybNlk6MRTvyufAWUgqJyMNMUy8LNAg5fH+l8UHUOrolV4kQOc9HnZ3jteJlxyd8b2r3B
         36sWD2UffhEYtH3yX/sHy7GD+H0XkFInIc5IA62iqFz+h1jmdRDRZzqhu/QGxHB7w6EP
         YC8jXQztdxNnNux8noCLvGpftUxnsnPHJgWqMUtk5ZK6HQLXDeY1P6h2DHPONolf8IKv
         3ATrNk7edJ5tmh/xGDD3AtwN575/6AY6WK7uZUMv2uuEe9qp6B/UlF+pA8AFaUMhv5RC
         X5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4qboQr5mj/MpLlzJSKMn+3syI3I3umISlClB03x9/+U=;
        b=tkBKCbkYp5UiT+Yz+zNAzATckGzqXBLG4oy6Cm67dvH5guD/T8EntM9mUMHE7xFk5c
         4VTviV/LJ5Q4B18I/Z4ZV0mCG2f1f/2VWSyRO7Mm6Fyg1f7mxqDfhpmCR9kiGCWCqHUE
         0Ki2+FARLbIHR+fTObzrBgiagtDrZGiWOxk3TGV+giffYPI1YkQkqL7KdZpsJEWV//jA
         jFmYegCT1LMzhDU5c4UE5QlbIPKjFZCY3CNdAcSzaVXQ5Yxj/qF24w+c6my3eRF6QD7s
         wRN+wV177LlrY/OBV9+58JL7sqoAlxyA9gQO7HGnZLWwEClwWFEgDNyjHurwnEbrFsV/
         P9NQ==
X-Gm-Message-State: AHQUAuaIGDpEYA+v7V7+xJv4DHOI1ftZhCK2BwdO33Tz6S+NmJ8uFtnS
        8sMgmUiSODXAmGOVTKQ90HqpPQ==
X-Google-Smtp-Source: AHgI3IYlehzg131o8/kfVFyuOuVDBJ9VSStKNkezYKqQ0wvBOWq1RegXvJQNSAxbvgk1i1DfsNB2Wg==
X-Received: by 2002:a17:902:1aa:: with SMTP id b39mr8065878plb.317.1551361260944;
        Thu, 28 Feb 2019 05:41:00 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:41:00 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        patches@opensource.cirrus.com,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        James Ban <James.Ban.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 04/11] regulator: da9210: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:15 +0800
Message-Id: <20190228134022.32625-5-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228134022.32625-1-axel.lin@ingics.com>
References: <20190228134022.32625-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9210-regulator.c | 53 ++++------------------------
 1 file changed, 7 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 84dba64ed11e..528303771723 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -41,10 +41,6 @@ static const struct regmap_config da9210_regmap_config = {
 	.val_bits = 8,
 };
 
-static int da9210_set_current_limit(struct regulator_dev *rdev, int min_uA,
-				    int max_uA);
-static int da9210_get_current_limit(struct regulator_dev *rdev);
-
 static const struct regulator_ops da9210_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -52,8 +48,8 @@ static const struct regulator_ops da9210_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
-	.set_current_limit = da9210_set_current_limit,
-	.get_current_limit = da9210_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 /* Default limits measured in millivolts and milliamps */
@@ -62,7 +58,7 @@ static const struct regulator_ops da9210_buck_ops = {
 #define DA9210_STEP_MV		10
 
 /* Current limits for buck (uA) indices corresponds with register values */
-static const int da9210_buck_limits[] = {
+static const unsigned int da9210_buck_limits[] = {
 	1600000, 1800000, 2000000, 2200000, 2400000, 2600000, 2800000, 3000000,
 	3200000, 3400000, 3600000, 3800000, 4000000, 4200000, 4400000, 4600000
 };
@@ -80,47 +76,12 @@ static const struct regulator_desc da9210_reg = {
 	.enable_reg = DA9210_REG_BUCK_CONT,
 	.enable_mask = DA9210_BUCK_EN,
 	.owner = THIS_MODULE,
+	.curr_table = da9210_buck_limits,
+	.n_current_limits = ARRAY_SIZE(da9210_buck_limits),
+	.csel_reg = DA9210_REG_BUCK_ILIM,
+	.csel_mask = DA9210_BUCK_ILIM_MASK,
 };
 
-static int da9210_set_current_limit(struct regulator_dev *rdev, int min_uA,
-				    int max_uA)
-{
-	struct da9210 *chip = rdev_get_drvdata(rdev);
-	unsigned int sel;
-	int i;
-
-	/* search for closest to maximum */
-	for (i = ARRAY_SIZE(da9210_buck_limits)-1; i >= 0; i--) {
-		if (min_uA <= da9210_buck_limits[i] &&
-		    max_uA >= da9210_buck_limits[i]) {
-			sel = i;
-			sel = sel << DA9210_BUCK_ILIM_SHIFT;
-			return regmap_update_bits(chip->regmap,
-						  DA9210_REG_BUCK_ILIM,
-						  DA9210_BUCK_ILIM_MASK, sel);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int da9210_get_current_limit(struct regulator_dev *rdev)
-{
-	struct da9210 *chip = rdev_get_drvdata(rdev);
-	unsigned int data;
-	unsigned int sel;
-	int ret;
-
-	ret = regmap_read(chip->regmap, DA9210_REG_BUCK_ILIM, &data);
-	if (ret < 0)
-		return ret;
-
-	/* select one of 16 values: 0000 (1600mA) to 1111 (4600mA) */
-	sel = (data & DA9210_BUCK_ILIM_MASK) >> DA9210_BUCK_ILIM_SHIFT;
-
-	return da9210_buck_limits[sel];
-}
-
 static irqreturn_t da9210_irq_handler(int irq, void *data)
 {
 	struct da9210 *chip = data;
-- 
2.17.1

