Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74266C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382CE2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="lj7XTwyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfB1NlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37432 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1NlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so9778913pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4b9bR+8a6kqlWaenk93UNlfy4rA9JqVKbQF7I7k4DoQ=;
        b=lj7XTwyirUQFMaI3s9MIFXvCdgNuN8yTZzWFapTfAFhGz849TmyvAyxtc67Ccnj9vO
         Mv6LZa4DjC+y4qXIIAoB/pMKiTxKjW9zj5h0gOC/Unp1zl4UPln4Ew6kN/mlYjWc+5ex
         e/j9tCR5i27zXgs/B2bRbzxWqeG0dYr7pcUMWP7tC1eGOUlUA18WYexVnXCWkNqmKJJW
         JVrJmwVcM/PzVQtFlhbujlykI5nD0b/AhL3FXw8I1T/xKqJfDn4C/pRhjJYLZHPwtjo8
         7dhw+qL14E7z/qXX/ih1Mj/NijVG1OZ52m9j91sbeOdn46EsvqRGoQyn15x7lh2I1uBT
         Xl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4b9bR+8a6kqlWaenk93UNlfy4rA9JqVKbQF7I7k4DoQ=;
        b=EPPECtT2oEu5PDRy969+YF9Mw0TUp76lcVNhy1f7NMdhNNDbduBxrFfwz54gXHyY6C
         T5wCmzeK/3Cu8CNHovQh+KVZHpgV8oK5Y/9r8oFfHn734o1FJ8KGZUyFPt0MuG/Z8V4T
         cSTiXlOtZy7scQ6iI/NddBt/75aIACs5CcS85o0bblIKrfR1iQmDogxBKZhRWmT9xrPT
         lvC/UHKclmWTC8VFsUBHkrZLm6/MCkEBg1NnZKHq4W9MMgZB+PnHvudd5BxxaqFVtyDb
         +tqYVn2ex41Lh423MZB4+AInkz3KwUt+805n/Nt4439LwaQo1FEaIouq5fn4rWSaxTGz
         GUIg==
X-Gm-Message-State: AHQUAuY11bi8RrLVU/EgRH8MECTwBF77bJC4JtFrmBeOd8B6Y1ohFBeu
        Pi7UWUgokf3CLRgo2/wmQTrxng==
X-Google-Smtp-Source: AHgI3IYrj0cvXxSNyKJY+/NQatlN+h6PICxLGYU+UiGG38pKNy89uEl7EHyOvmL/FS3JYGxUH0hPvA==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr7782347plb.172.1551361282970;
        Thu, 28 Feb 2019 05:41:22 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:41:22 -0800 (PST)
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
Subject: [PATCH 09/11] regulator: pv88080: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:20 +0800
Message-Id: <20190228134022.32625-10-axel.lin@ingics.com>
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
 drivers/regulator/pv88080-regulator.c | 55 ++++-----------------------
 1 file changed, 8 insertions(+), 47 deletions(-)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 6770e4de2097..bdddacdbeb99 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -45,12 +45,7 @@ enum pv88080_types {
 
 struct pv88080_regulator {
 	struct regulator_desc desc;
-	/* Current limiting */
-	unsigned int n_current_limits;
-	const int *current_limits;
-	unsigned int limit_mask;
 	unsigned int mode_reg;
-	unsigned int limit_reg;
 	unsigned int conf2;
 	unsigned int conf5;
 };
@@ -102,11 +97,11 @@ static const struct regmap_config pv88080_regmap_config = {
  * Entry indexes corresponds to register values.
  */
 
-static const int pv88080_buck1_limits[] = {
+static const unsigned int pv88080_buck1_limits[] = {
 	3230000, 5130000, 6960000, 8790000
 };
 
-static const int pv88080_buck23_limits[] = {
+static const unsigned int pv88080_buck23_limits[] = {
 	1496000, 2393000, 3291000, 4189000
 };
 
@@ -272,40 +267,6 @@ static int pv88080_buck_set_mode(struct regulator_dev *rdev,
 					PV88080_BUCK1_MODE_MASK, val);
 }
 
-static int pv88080_set_current_limit(struct regulator_dev *rdev, int min,
-				    int max)
-{
-	struct pv88080_regulator *info = rdev_get_drvdata(rdev);
-	int i;
-
-	/* search for closest to maximum */
-	for (i = info->n_current_limits - 1; i >= 0; i--) {
-		if (min <= info->current_limits[i]
-			&& max >= info->current_limits[i]) {
-				return regmap_update_bits(rdev->regmap,
-					info->limit_reg,
-					info->limit_mask,
-					i << PV88080_BUCK1_ILIM_SHIFT);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int pv88080_get_current_limit(struct regulator_dev *rdev)
-{
-	struct pv88080_regulator *info = rdev_get_drvdata(rdev);
-	unsigned int data;
-	int ret;
-
-	ret = regmap_read(rdev->regmap, info->limit_reg, &data);
-	if (ret < 0)
-		return ret;
-
-	data = (data & info->limit_mask) >> PV88080_BUCK1_ILIM_SHIFT;
-	return info->current_limits[data];
-}
-
 static const struct regulator_ops pv88080_buck_ops = {
 	.get_mode = pv88080_buck_get_mode,
 	.set_mode = pv88080_buck_set_mode,
@@ -315,8 +276,8 @@ static const struct regulator_ops pv88080_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
-	.set_current_limit = pv88080_set_current_limit,
-	.get_current_limit = pv88080_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static const struct regulator_ops pv88080_hvbuck_ops = {
@@ -341,9 +302,9 @@ static const struct regulator_ops pv88080_hvbuck_ops = {
 		.min_uV = min, \
 		.uV_step = step, \
 		.n_voltages = ((max) - (min))/(step) + 1, \
+		.curr_table = limits_array, \
+		.n_current_limits = ARRAY_SIZE(limits_array), \
 	},\
-	.current_limits = limits_array, \
-	.n_current_limits = ARRAY_SIZE(limits_array), \
 }
 
 #define PV88080_HVBUCK(chip, regl_name, min, step, max) \
@@ -521,9 +482,9 @@ static int pv88080_i2c_probe(struct i2c_client *i2c,
 		if (init_data)
 			config.init_data = &init_data[i];
 
-		pv88080_regulator_info[i].limit_reg
+		pv88080_regulator_info[i].desc.csel_reg
 			= regmap_config->buck_regmap[i].buck_limit_reg;
-		pv88080_regulator_info[i].limit_mask
+		pv88080_regulator_info[i].desc.csel_mask
 			= regmap_config->buck_regmap[i].buck_limit_mask;
 		pv88080_regulator_info[i].mode_reg
 			= regmap_config->buck_regmap[i].buck_mode_reg;
-- 
2.17.1

