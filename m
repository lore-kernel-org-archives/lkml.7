Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD34C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D2A21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SxoigtBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGCQKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:10:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41654 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:10:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so3460783wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7aUHp3n4aoHH2pZfqvYApUYVKzXsITpREbapoBoW/8=;
        b=SxoigtBhG1wXeEsOWti7NJ1Fqk6vj2zFzD8CSiP1hgzZnIrUix0lvcpaJAg8c6ZsG3
         bU0POnJJA6U5F+04imc0uMEHCA2XxJrUJs1NVw5ov/ikAfeZOOwgX1zcRgeqSzaxgxLA
         FYv+0bcuc/SGQ3Fp1/CUe3PmzWtByTfrmnACrnu//ukA8MDePzIkt533Mx4T2RrsA+zR
         IbgWaVSU+NAUCzVI31G9Zxg15bRBrBmaU1cB8pF4D6gsKIGlVH4jcdS9Kt3zIKwoe71+
         vygQBmOkFVL7TcHII0HhsjGVdMOheTUlE73yghVdy8HeVs8fyGqUrcp80l48DfNP3kS3
         W3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7aUHp3n4aoHH2pZfqvYApUYVKzXsITpREbapoBoW/8=;
        b=B2tQg1VLSX4XWc8O7vAsaTM5ccNy+JYYdDaA1XDBVvdjv4jqUAZNnhHUcVI891+Yew
         ODbwnJrOi8a6ZIqNHAiMPOu9vPoeUWDHzkLtGh5a62LVhmRTL//rH7hT5U8Xp3QwfBK4
         wokndy7DwQsGJOlMq8dn2VV9zjNhmIwagEsLMfb+Pu0gZ00yMbuKc6BYsS2NpvuhQ+Jc
         H+z5OYCUBO7UZusmJxQ6HI76as+un+dT6LeHL2B+XnaLaEgl+5if3DkB/JlFNbjOSbIa
         A+JsCyfXGmxKAZC+lJVbzwhdfoYc6fC/GCWIvL3E6ddjPlLLKABgnm8ifOf/sG5ttRYx
         Irgg==
X-Gm-Message-State: APjAAAW05QC7zRN08ExrTWJKdM2asaN7SnWOOk7dAMoSOgri7RQ5BdSa
        0f3QxYSxcl8u52JbDu5f7HnSuB9wqsM=
X-Google-Smtp-Source: APXvYqyIK4G5hMaT7WkkBXCpixxNPcIMz/+eaUZ/B0d69AvkhtzjgPD5Ih7vgGSAwizOaxb7DWEYnA==
X-Received: by 2002:adf:db12:: with SMTP id s18mr28898400wri.335.1562170242463;
        Wed, 03 Jul 2019 09:10:42 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t17sm3803572wrs.45.2019.07.03.09.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:10:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] regulator: max77650: use vsel_step
Date:   Wed,  3 Jul 2019 18:10:35 +0200
Message-Id: <20190703161035.31808-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703161035.31808-1-brgl@bgdev.pl>
References: <20190703161035.31808-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new vsel_step field in the regulator description to instruct
the regulator API on the required voltage ramping. Switch to using the
generic regmap helpers for voltage setting and remove the old set_voltage
callback that handcoded the selector stepping.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/regulator/max77650-regulator.c | 73 ++++----------------------
 1 file changed, 9 insertions(+), 64 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 304fbe7da265..ac89a412f665 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -108,67 +108,6 @@ static int max77650_regulator_disable(struct regulator_dev *rdev)
 				  MAX77650_REGULATOR_DISABLED);
 }
 
-static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
-					      unsigned int sel)
-{
-	struct max77650_regulator_desc *rdesc = rdev_get_drvdata(rdev);
-	int rv = 0, curr, diff;
-	bool ascending;
-
-	/*
-	 * If the regulator is disabled, we can program the desired
-	 * voltage right away.
-	 */
-	if (!max77650_regulator_is_enabled(rdev)) {
-		if (rdesc == &max77651_SBB1_desc)
-			return regulator_set_voltage_sel_pickable_regmap(rdev,
-									 sel);
-		else
-			return regulator_set_voltage_sel_regmap(rdev, sel);
-	}
-
-	/*
-	 * Otherwise we need to manually ramp the output voltage up/down
-	 * one step at a time.
-	 */
-
-	if (rdesc == &max77651_SBB1_desc)
-		curr = regulator_get_voltage_sel_pickable_regmap(rdev);
-	else
-		curr = regulator_get_voltage_sel_regmap(rdev);
-
-	if (curr < 0)
-		return curr;
-
-	diff = curr - sel;
-	if (diff == 0)
-		return 0; /* Already there. */
-	else if (diff > 0)
-		ascending = false;
-	else
-		ascending = true;
-
-	/*
-	 * Make sure we'll get to the right voltage and break the loop even if
-	 * the selector equals 0.
-	 */
-	for (ascending ? curr++ : curr--;; ascending ? curr++ : curr--) {
-		if (rdesc == &max77651_SBB1_desc)
-			rv = regulator_set_voltage_sel_pickable_regmap(rdev,
-								       curr);
-		else
-			rv = regulator_set_voltage_sel_regmap(rdev, curr);
-
-		if (rv)
-			return rv;
-
-		if (curr == sel)
-			break;
-	}
-
-	return 0;
-}
-
 static const struct regulator_ops max77650_regulator_LDO_ops = {
 	.is_enabled		= max77650_regulator_is_enabled,
 	.enable			= max77650_regulator_enable,
@@ -176,7 +115,7 @@ static const struct regulator_ops max77650_regulator_LDO_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
@@ -187,7 +126,7 @@ static const struct regulator_ops max77650_regulator_SBB_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
@@ -200,7 +139,7 @@ static const struct regulator_ops max77651_SBB1_regulator_ops = {
 	.disable		= max77650_regulator_disable,
 	.list_voltage		= regulator_list_voltage_pickable_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_pickable_regmap,
-	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
+	.set_voltage_sel	= regulator_set_voltage_sel_pickable_regmap,
 	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
@@ -217,6 +156,7 @@ static struct max77650_regulator_desc max77650_LDO_desc = {
 		.min_uV			= 1350000,
 		.uV_step		= 12500,
 		.n_voltages		= 128,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_LDO_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_LDO_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
@@ -242,6 +182,7 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 		.min_uV			= 800000,
 		.uV_step		= 25000,
 		.n_voltages		= 64,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB0_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
@@ -271,6 +212,7 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 		.min_uV			= 800000,
 		.uV_step		= 12500,
 		.n_voltages		= 64,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB1_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
@@ -301,6 +243,7 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.linear_ranges		= max77651_sbb1_volt_ranges,
 		.n_linear_ranges	= ARRAY_SIZE(max77651_sbb1_volt_ranges),
 		.n_voltages		= 58,
+		.vsel_step		= 1,
 		.vsel_range_mask	= MAX77651_REGULATOR_V_SBB1_RANGE_MASK,
 		.vsel_range_reg		= MAX77650_REG_CNFG_SBB1_A,
 		.vsel_mask		= MAX77651_REGULATOR_V_SBB1_MASK,
@@ -332,6 +275,7 @@ static struct max77650_regulator_desc max77650_SBB2_desc = {
 		.min_uV			= 800000,
 		.uV_step		= 50000,
 		.n_voltages		= 64,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB2_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
@@ -361,6 +305,7 @@ static struct max77650_regulator_desc max77651_SBB2_desc = {
 		.min_uV			= 2400000,
 		.uV_step		= 50000,
 		.n_voltages		= 64,
+		.vsel_step		= 1,
 		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB2_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
-- 
2.21.0

