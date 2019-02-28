Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71767C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3582721850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="CBxxBVuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfB1Nlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1Nl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so9235146pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrseqgr1GN0kfQBtkZLhXupoJWeTWIVNctr3h8BfTG4=;
        b=CBxxBVuBykn+63dyKq6uW1VpusRiTRaq/KEa/rVs+FN2Ts/lUeZNpgbAHad9OpfB79
         Ru3k2flJxxabPiWkagqv8kPfyJKlIc3JADUTAv6uqud703YC84ro05DxsD/Z9xbjEqgq
         FDeZ8EasiwUosnDsoezHOxKDqjE/5WKL/3yjfO9lX8w3WQFx3EK8oMWq4RjKLEuCZBn1
         pLr9tlhpWgd4XwCz+UaUrkpVHWuFHblNMk/LWNe2CmmBqhO8Mfelfgn+h2lrfVfbgFnG
         mbauvt/nq2oFXvkPxP8hDjxcU04oACagYAOTMfQ+V4hufB4a1WhWZB2k+vFh9njPIW6P
         E7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrseqgr1GN0kfQBtkZLhXupoJWeTWIVNctr3h8BfTG4=;
        b=QTYnFoQkSqQZ1pxyKZwRmiZgWpJkUeCDBIEbTf+KtsG1c3cbGeTq3uQHNtw+m6Rcgk
         qeuloouUOmwAVWSVV3rgFMnT0adVaBYDPFfDEjUILfhWZqzgX214Cto22CXyt9fcxRlS
         gUI5oqYW6TLxSEoiwc9qr7I7HaSCVk6PEMot3Ch+f5crttaMcrQ/8D0mIv1VlKqfYmT9
         OI/3cY1j3UYwOPLNzSgzSrirAxNVK6ci/BVlWAnTwN3/k9cKdYD9aEuk3RN3xhef2ptw
         LhHg2OnRpIRr135hXfUX3p8uc9B++jiTpHNFxRV6NYJ2YRseVv0AddbZnGVn4KHzRiem
         03qw==
X-Gm-Message-State: AHQUAua5FpEoTnUnv1UKFoNiCnRHR5g/FqJYq2522v16phocvr+Lq4KI
        s86qflkruu3tAQz8woASJS6jjQ==
X-Google-Smtp-Source: AHgI3IZQess6kAVhjSZN5tBTrEalUM1eZPW30vPmcm1/SAkrzAjcbbdwWig9z7fXW/ZGfm41Aybv9Q==
X-Received: by 2002:a62:41cc:: with SMTP id g73mr7359463pfd.145.1551361287799;
        Thu, 28 Feb 2019 05:41:27 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:41:27 -0800 (PST)
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
Subject: [PATCH 10/11] regulator: pv88090: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:21 +0800
Message-Id: <20190228134022.32625-11-axel.lin@ingics.com>
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
 drivers/regulator/pv88090-regulator.c | 53 ++++-----------------------
 1 file changed, 8 insertions(+), 45 deletions(-)

diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 2302b0df7630..6e97cc6df2ee 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -42,10 +42,6 @@ enum {
 
 struct pv88090_regulator {
 	struct regulator_desc desc;
-	/* Current limiting */
-	unsigned int n_current_limits;
-	const int	*current_limits;
-	unsigned int limit_mask;
 	unsigned int conf;
 	unsigned int conf2;
 };
@@ -71,14 +67,14 @@ static const struct regmap_config pv88090_regmap_config = {
  *  Entry indexes corresponds to register values.
  */
 
-static const int pv88090_buck1_limits[] = {
+static const unsigned int pv88090_buck1_limits[] = {
 	 220000,  440000,  660000,  880000, 1100000, 1320000, 1540000, 1760000,
 	1980000, 2200000, 2420000, 2640000, 2860000, 3080000, 3300000, 3520000,
 	3740000, 3960000, 4180000, 4400000, 4620000, 4840000, 5060000, 5280000,
 	5500000, 5720000, 5940000, 6160000, 6380000, 6600000, 6820000, 7040000
 };
 
-static const int pv88090_buck23_limits[] = {
+static const unsigned int pv88090_buck23_limits[] = {
 	1496000, 2393000, 3291000, 4189000
 };
 
@@ -150,40 +146,6 @@ static int pv88090_buck_set_mode(struct regulator_dev *rdev,
 					PV88090_BUCK1_MODE_MASK, val);
 }
 
-static int pv88090_set_current_limit(struct regulator_dev *rdev, int min,
-				    int max)
-{
-	struct pv88090_regulator *info = rdev_get_drvdata(rdev);
-	int i;
-
-	/* search for closest to maximum */
-	for (i = info->n_current_limits - 1; i >= 0; i--) {
-		if (min <= info->current_limits[i]
-			&& max >= info->current_limits[i]) {
-			return regmap_update_bits(rdev->regmap,
-				info->conf,
-				info->limit_mask,
-				i << PV88090_BUCK1_ILIM_SHIFT);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int pv88090_get_current_limit(struct regulator_dev *rdev)
-{
-	struct pv88090_regulator *info = rdev_get_drvdata(rdev);
-	unsigned int data;
-	int ret;
-
-	ret = regmap_read(rdev->regmap, info->conf, &data);
-	if (ret < 0)
-		return ret;
-
-	data = (data & info->limit_mask) >> PV88090_BUCK1_ILIM_SHIFT;
-	return info->current_limits[data];
-}
-
 static const struct regulator_ops pv88090_buck_ops = {
 	.get_mode = pv88090_buck_get_mode,
 	.set_mode = pv88090_buck_set_mode,
@@ -193,8 +155,8 @@ static const struct regulator_ops pv88090_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
-	.set_current_limit = pv88090_set_current_limit,
-	.get_current_limit = pv88090_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 };
 
 static const struct regulator_ops pv88090_ldo_ops = {
@@ -223,10 +185,11 @@ static const struct regulator_ops pv88090_ldo_ops = {
 		.enable_mask = PV88090_##regl_name##_EN, \
 		.vsel_reg = PV88090_REG_##regl_name##_CONF0, \
 		.vsel_mask = PV88090_V##regl_name##_MASK, \
+		.curr_table = limits_array, \
+		.n_current_limits = ARRAY_SIZE(limits_array), \
+		.csel_reg = PV88090_REG_##regl_name##_CONF1, \
+		.csel_mask = PV88090_##regl_name##_ILIM_MASK, \
 	},\
-	.current_limits = limits_array, \
-	.n_current_limits = ARRAY_SIZE(limits_array), \
-	.limit_mask = PV88090_##regl_name##_ILIM_MASK, \
 	.conf = PV88090_REG_##regl_name##_CONF1, \
 	.conf2 = PV88090_REG_##regl_name##_CONF2, \
 }
-- 
2.17.1

