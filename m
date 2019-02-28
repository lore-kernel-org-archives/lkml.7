Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D524C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A3A2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="FpKbW97t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbfB1NlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37569 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1NlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id s22so9763948pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IkIOPqV08fUfdKsL8mPGFHx9p20q3RcMzNZzjE048CI=;
        b=FpKbW97tY4vqbubE1SaNh0o3ZtHqzZQSu0pfqxRK7PptBvk5cy1nPtuqAr0x66KlYr
         kAPrWeLC/FtiBNK8uHJ0Y0cioIFzOdXS5gpJ6fps1P7JfVFpzH/Q+VXQJAwRYaJqDAYZ
         y+0Se9TxL94sc39kRL70QRCHsUOH9OEfA9AuiBXV4BFt285FLMac0rP4O06yN2eQ30I1
         O09w5azNd8d4SsRULqVxFtkNluxqQQyDO8DceJyxUFybmmx3adF8gaiNqnSDgKLx2ao6
         Aplprmih40+XM12wW/8uREcy5fksN7DhGuCrfCDKCWAOfGiB8S6NCXkYryQgi33h6x1+
         +wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IkIOPqV08fUfdKsL8mPGFHx9p20q3RcMzNZzjE048CI=;
        b=qkDnAHPotcIuPWvWxmxQwbZggH0wGrIfMFz1bKdIvyKYqjYWxtbFKpPmtXD67+DfVU
         uGoKNLZg5YYJCT/nr53PkJk+3wi8GMAlN/c/16BRZxkgGpv5V60zAc7wvT5s6brxJsAW
         UhDAFE39eGuaU3T74sYd5I0K18BcIl1jEH0B1bwZDg3pVq1wYqHlmlR70fIhtrR1VZKY
         5m8rL6caf5wk8Ha/0WxKmSeP7Sw+YbNhm+TApPkSgu0mzRFqwQVeRzsPOFdFHCVZzYeN
         2lSCVe18Ngs2KhgUO1a4xNSf28kujeLKYwFNFHAtnsuejbroYOvzYMxikG0/myBPFNXt
         VscQ==
X-Gm-Message-State: AHQUAuYSBm11Q3bzHUWxOdKzNYG6Io5lS3ZJAJWBNt351U1oGuJKU8IE
        6scc4caD74K4hDmlRFrHhAzMcQ==
X-Google-Smtp-Source: AHgI3IYQAgG/gjyy/ktMzb8tTyrhx4hqaYilsbS+8MoGSyDdn1tPLlx1y6LCb794ZmEBPg4+QtXLhQ==
X-Received: by 2002:a63:d442:: with SMTP id i2mr8481079pgj.246.1551361278565;
        Thu, 28 Feb 2019 05:41:18 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:41:17 -0800 (PST)
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
Subject: [PATCH 08/11] regulator: pv88060: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:19 +0800
Message-Id: <20190228134022.32625-9-axel.lin@ingics.com>
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
 drivers/regulator/pv88060-regulator.c | 51 ++++-----------------------
 1 file changed, 7 insertions(+), 44 deletions(-)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index da6ed723e398..1600f9821891 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -53,10 +53,6 @@ enum {
 
 struct pv88060_regulator {
 	struct regulator_desc desc;
-	/* Current limiting */
-	unsigned	n_current_limits;
-	const int	*current_limits;
-	unsigned int limit_mask;
 	unsigned int conf;		/* buck configuration register */
 };
 
@@ -75,7 +71,7 @@ static const struct regmap_config pv88060_regmap_config = {
  * Entry indexes corresponds to register values.
  */
 
-static const int pv88060_buck1_limits[] = {
+static const unsigned int pv88060_buck1_limits[] = {
 	1496000, 2393000, 3291000, 4189000
 };
 
@@ -128,40 +124,6 @@ static int pv88060_buck_set_mode(struct regulator_dev *rdev,
 					PV88060_BUCK_MODE_MASK, val);
 }
 
-static int pv88060_set_current_limit(struct regulator_dev *rdev, int min,
-				    int max)
-{
-	struct pv88060_regulator *info = rdev_get_drvdata(rdev);
-	int i;
-
-	/* search for closest to maximum */
-	for (i = info->n_current_limits - 1; i >= 0; i--) {
-		if (min <= info->current_limits[i]
-			&& max >= info->current_limits[i]) {
-			return regmap_update_bits(rdev->regmap,
-				info->conf,
-				info->limit_mask,
-				i << PV88060_BUCK_ILIM_SHIFT);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int pv88060_get_current_limit(struct regulator_dev *rdev)
-{
-	struct pv88060_regulator *info = rdev_get_drvdata(rdev);
-	unsigned int data;
-	int ret;
-
-	ret = regmap_read(rdev->regmap, info->conf, &data);
-	if (ret < 0)
-		return ret;
-
-	data = (data & info->limit_mask) >> PV88060_BUCK_ILIM_SHIFT;
-	return info->current_limits[data];
-}
-
 static const struct regulator_ops pv88060_buck_ops = {
 	.get_mode = pv88060_buck_get_mode,
 	.set_mode = pv88060_buck_set_mode,
@@ -171,8 +133,8 @@ static const struct regulator_ops pv88060_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
-	.set_current_limit = pv88060_set_current_limit,
-	.get_current_limit = pv88060_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static const struct regulator_ops pv88060_ldo_ops = {
@@ -207,10 +169,11 @@ static const struct regulator_ops pv88060_sw_ops = {
 		.enable_mask = PV88060_BUCK_EN, \
 		.vsel_reg = PV88060_REG_##regl_name##_CONF0,\
 		.vsel_mask = PV88060_VBUCK_MASK,\
+		.curr_table = limits_array,\
+		.n_current_limits = ARRAY_SIZE(limits_array),\
+		.csel_reg = PV88060_REG_##regl_name##_CONF1,\
+		.csel_mask = PV88060_BUCK_ILIM_MASK,\
 	},\
-	.current_limits = limits_array,\
-	.n_current_limits = ARRAY_SIZE(limits_array),\
-	.limit_mask = PV88060_BUCK_ILIM_MASK, \
 	.conf = PV88060_REG_##regl_name##_CONF1,\
 }
 
-- 
2.17.1

