Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F13C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B1420830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="rAhtG6bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfCYN4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:56:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39080 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:56:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so2935417pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qnfNrYxhBXeOdCgpns8GfwuAYToYu/hCZU3DC1X2ojw=;
        b=rAhtG6bpn+LtF7fbQ3JQKT2LyvRa5AhfVn0XI+Wp+azrvR0e4Zac74fAPuElD5Arwj
         TzWQHpV5uR5XRng2stPi4UYm6M7DavuX8hqs6937lt6LkvmS8LqyNwjLFRzuPEVuXXwd
         KfVTgJmfsM90JGBzAYYtlu0+AhnuGGjQYWuJSA7fTot3ADDfqItAt+mdKOWrjqoeAwQQ
         5+QERSy84ZyyZfo+arcaPcYfxK7qSZLM+Mdgd4E5m6EsLmcI604IRoFZHVWILraTTmuO
         W8gec+cyu2TPlKt99o1I+RHgDppAEzwqg6QWMOJ6vn0ur5KU2+QNLjHP/zFglI2CV9so
         qJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qnfNrYxhBXeOdCgpns8GfwuAYToYu/hCZU3DC1X2ojw=;
        b=Q9w7rrqHLfEVB8sNyCsuLsf7NkYMYSQnZbSEI1Nd9sE2Zhz1HcEcYBVj8p9YFcbS/i
         AfxF2Aed4RLXUex0CXQX9PxsTJizArudcN7GEILKauy2UrGB+P8D5Yf+gdFL8gUbBJub
         9vu0xaswYw/1BS0JF8WP21P5NlfCZa1IDxEeKB6JYlWeVn7txGHMuWv0c62p2g4KmwTs
         dcPqIZTodEL7SfVn3aqQlHciEE7wmb50Nsutgfrgznr6VBPbZT7jO8zCiAAgp/ZPRxwg
         GjbZ+rF9G+/tz64ebPwcErYDOQ+s4v7Ar0HdpDftUfTxcwWsQD5HYAMgTwZ5wvozEw4h
         MD0w==
X-Gm-Message-State: APjAAAU3Rb2dLm8xA8hAQ77WabxIMsMYlwtUOjv2PYqc3HQdMVMaMYib
        Y0o/dOIlzLsp48hSFud+K6VoSw==
X-Google-Smtp-Source: APXvYqykF5V3U8XTsyHi3Z1SSb9TULeEorxFB/V6ScLk7qfOzI6IzvpYKbwfosUdLFk7UJeHx8JngQ==
X-Received: by 2002:a62:bd09:: with SMTP id a9mr23966757pff.61.1553522195944;
        Mon, 25 Mar 2019 06:56:35 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id s78sm24068240pfa.134.2019.03.25.06.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 06:56:34 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max77650: Convert MAX77651 SBB1 to pickable linear range
Date:   Mon, 25 Mar 2019 21:55:57 +0800
Message-Id: <20190325135557.3423-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pickable linear range is suitable for The MAX77651 SBB1.
According to MAX77651 TV_SBB1 Code Table:
Use BIT[1:0] as range selectors.
Use BIT[5:2] as selectors for each linear range.

The MAX77651 SBB1 supports up to selector 57, selector 58 ~ 63 are RSVD,
thus set n_voltage to 58.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Bartosz,
I don't have this h/w, please help to review and test this patch.
Thanks,
Axel

 drivers/regulator/max77650-regulator.c | 134 +++++++++----------------
 1 file changed, 45 insertions(+), 89 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 5c4f86c98510..24b4a0a3c3bb 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -20,6 +20,8 @@
 
 #define MAX77650_REGULATOR_V_LDO_MASK		GENMASK(6, 0)
 #define MAX77650_REGULATOR_V_SBB_MASK		GENMASK(5, 0)
+#define MAX77651_REGULATOR_V_SBB1_MASK		GENMASK(5, 2)
+#define MAX77651_REGULATOR_V_SBB1_RANGE_MASK	GENMASK(1, 0)
 
 #define MAX77650_REGULATOR_AD_MASK		BIT(3)
 #define MAX77650_REGULATOR_AD_DISABLED		0x00
@@ -27,6 +29,8 @@
 
 #define MAX77650_REGULATOR_CURR_LIM_MASK	GENMASK(7, 6)
 
+static struct max77650_regulator_desc max77651_SBB1_desc;
+
 enum {
 	MAX77650_REGULATOR_ID_LDO = 0,
 	MAX77650_REGULATOR_ID_SBB0,
@@ -41,43 +45,20 @@ struct max77650_regulator_desc {
 	unsigned int regB;
 };
 
-static const unsigned int max77651_sbb1_regulator_volt_table[] = {
-	2400000, 3200000, 4000000, 4800000,
-	2450000, 3250000, 4050000, 4850000,
-	2500000, 3300000, 4100000, 4900000,
-	2550000, 3350000, 4150000, 4950000,
-	2600000, 3400000, 4200000, 5000000,
-	2650000, 3450000, 4250000, 5050000,
-	2700000, 3500000, 4300000, 5100000,
-	2750000, 3550000, 4350000, 5150000,
-	2800000, 3600000, 4400000, 5200000,
-	2850000, 3650000, 4450000, 5250000,
-	2900000, 3700000, 4500000,       0,
-	2950000, 3750000, 4550000,       0,
-	3000000, 3800000, 4600000,       0,
-	3050000, 3850000, 4650000,       0,
-	3100000, 3900000, 4700000,       0,
-	3150000, 3950000, 4750000,       0,
+static const unsigned int max77651_sbb1_volt_range_sel[] = {
+	0x0, 0x1, 0x2, 0x3
 };
 
-#define MAX77651_REGULATOR_SBB1_SEL_DEC(_val) \
-		(((_val & 0x3c) >> 2) | ((_val & 0x03) << 4))
-#define MAX77651_REGULATOR_SBB1_SEL_ENC(_val) \
-		(((_val & 0x30) >> 4) | ((_val & 0x0f) << 2))
-
-#define MAX77650_REGULATOR_SBB1_SEL_DECR(_val)				\
-	do {								\
-		_val = MAX77651_REGULATOR_SBB1_SEL_DEC(_val);		\
-		_val--;							\
-		_val = MAX77651_REGULATOR_SBB1_SEL_ENC(_val);		\
-	} while (0)
-
-#define MAX77650_REGULATOR_SBB1_SEL_INCR(_val)				\
-	do {								\
-		_val = MAX77651_REGULATOR_SBB1_SEL_DEC(_val);		\
-		_val++;							\
-		_val = MAX77651_REGULATOR_SBB1_SEL_ENC(_val);		\
-	} while (0)
+static const struct regulator_linear_range max77651_sbb1_volt_ranges[] = {
+	/* range index 0 */
+	REGULATOR_LINEAR_RANGE(2400000, 0x00, 0x0f, 50000),
+	/* range index 1 */
+	REGULATOR_LINEAR_RANGE(3200000, 0x00, 0x0f, 50000),
+	/* range index 2 */
+	REGULATOR_LINEAR_RANGE(4000000, 0x00, 0x0f, 50000),
+	/* range index 3 */
+	REGULATOR_LINEAR_RANGE(4800000, 0x00, 0x09, 50000),
+};
 
 static const unsigned int max77650_current_limit_table[] = {
 	1000000, 866000, 707000, 500000,
@@ -130,6 +111,7 @@ static int max77650_regulator_disable(struct regulator_dev *rdev)
 static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					      unsigned int sel)
 {
+	struct max77650_regulator_desc *rdesc = rdev_get_drvdata(rdev);
 	int rv = 0, curr, diff;
 	bool ascending;
 
@@ -137,15 +119,24 @@ static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	 * If the regulator is disabled, we can program the desired
 	 * voltage right away.
 	 */
-	if (!max77650_regulator_is_enabled(rdev))
-		return regulator_set_voltage_sel_regmap(rdev, sel);
+	if (!max77650_regulator_is_enabled(rdev)) {
+		if (rdesc == &max77651_SBB1_desc)
+			return regulator_set_voltage_sel_pickable_regmap(rdev,
+									 sel);
+		else
+			return regulator_set_voltage_sel_regmap(rdev, sel);
+	}
 
 	/*
 	 * Otherwise we need to manually ramp the output voltage up/down
 	 * one step at a time.
 	 */
 
-	curr = regulator_get_voltage_sel_regmap(rdev);
+	if (rdesc == &max77651_SBB1_desc)
+		curr = regulator_get_voltage_sel_pickable_regmap(rdev);
+	else
+		curr = regulator_get_voltage_sel_regmap(rdev);
+
 	if (curr < 0)
 		return curr;
 
@@ -162,57 +153,18 @@ static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	 * the selector equals 0.
 	 */
 	for (ascending ? curr++ : curr--;; ascending ? curr++ : curr--) {
-		rv = regulator_set_voltage_sel_regmap(rdev, curr);
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
-/*
- * Special case: non-linear voltage table for max77651 SBB1 - software
- * must ensure the voltage is ramped in 50mV increments.
- */
-static int max77651_regulator_sbb1_set_voltage_sel(struct regulator_dev *rdev,
-						   unsigned int sel)
-{
-	int rv = 0, curr, vcurr, vdest, vdiff;
-
-	/*
-	 * If the regulator is disabled, we can program the desired
-	 * voltage right away.
-	 */
-	if (!max77650_regulator_is_enabled(rdev))
-		return regulator_set_voltage_sel_regmap(rdev, sel);
-
-	curr = regulator_get_voltage_sel_regmap(rdev);
-	if (curr < 0)
-		return curr;
-
-	if (curr == sel)
-		return 0; /* Already there. */
-
-	vcurr = max77651_sbb1_regulator_volt_table[curr];
-	vdest = max77651_sbb1_regulator_volt_table[sel];
-	vdiff = vcurr - vdest;
-
-	for (;;) {
-		if (vdiff > 0)
-			MAX77650_REGULATOR_SBB1_SEL_DECR(curr);
+		if (rdesc == &max77651_SBB1_desc)
+			rv = regulator_set_voltage_sel_pickable_regmap(rdev,
+								       curr);
 		else
-			MAX77650_REGULATOR_SBB1_SEL_INCR(curr);
+			rv = regulator_set_voltage_sel_regmap(rdev, curr);
 
-		rv = regulator_set_voltage_sel_regmap(rdev, curr);
 		if (rv)
 			return rv;
 
 		if (curr == sel)
 			break;
-	};
+	}
 
 	return 0;
 }
@@ -241,14 +193,14 @@ static const struct regulator_ops max77650_regulator_SBB_ops = {
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
-/* Special case for max77651 SBB1 - non-linear voltage mapping. */
+/* Special case for max77651 SBB1 - pickable linear-range voltage mapping. */
 static const struct regulator_ops max77651_SBB1_regulator_ops = {
 	.is_enabled		= max77650_regulator_is_enabled,
 	.enable			= max77650_regulator_enable,
 	.disable		= max77650_regulator_disable,
-	.list_voltage		= regulator_list_voltage_table,
-	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
-	.set_voltage_sel	= max77651_regulator_sbb1_set_voltage_sel,
+	.list_voltage		= regulator_list_voltage_pickable_linear_range,
+	.get_voltage_sel	= regulator_get_voltage_sel_pickable_regmap,
+	.set_voltage_sel	= max77650_regulator_set_voltage_sel,
 	.get_current_limit	= regulator_get_current_limit_regmap,
 	.set_current_limit	= regulator_set_current_limit_regmap,
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
@@ -345,9 +297,13 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.supply_name		= "in-sbb1",
 		.id			= MAX77650_REGULATOR_ID_SBB1,
 		.ops			= &max77651_SBB1_regulator_ops,
-		.volt_table		= max77651_sbb1_regulator_volt_table,
-		.n_voltages = ARRAY_SIZE(max77651_sbb1_regulator_volt_table),
-		.vsel_mask		= MAX77650_REGULATOR_V_SBB_MASK,
+		.linear_range_selectors	= max77651_sbb1_volt_range_sel,
+		.linear_ranges		= max77651_sbb1_volt_ranges,
+		.n_linear_ranges	= ARRAY_SIZE(max77651_sbb1_volt_ranges),
+		.n_voltages		= 58,
+		.vsel_range_mask	= MAX77651_REGULATOR_V_SBB1_RANGE_MASK,
+		.vsel_range_reg		= MAX77650_REG_CNFG_SBB1_A,
+		.vsel_mask		= MAX77651_REGULATOR_V_SBB1_MASK,
 		.vsel_reg		= MAX77650_REG_CNFG_SBB1_A,
 		.active_discharge_off	= MAX77650_REGULATOR_AD_DISABLED,
 		.active_discharge_on	= MAX77650_REGULATOR_AD_ENABLED,
-- 
2.17.1

