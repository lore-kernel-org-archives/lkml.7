Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77F920665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8T6931l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfHMSd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:33:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfHMSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:33:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so52081735pfp.7;
        Tue, 13 Aug 2019 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vs+bgsVu9FaTvXFpcvW8uhZc3ZxIp3T3ZKEdthDZ0Y=;
        b=O8T6931lDMni+EiqsrSPdvsowVkzmfcR2Qg9STRYf7Kzze+OQ7076/Yt+tZ7FLtbzc
         UUwnvr5A0Md+3RQX5/CN637gbB7WQCpqY5Ono0MTSsSd935smXz+An2nAgJl7Vk/8rgO
         v9Z6Y4KCv5qnaLSMMGC3RYWcecDA97l3XTU/iajUnoKwhiLQWztorFI0Dq1ZZb849gqR
         HoIz742ZprAb7SRC54AUqaxmaILtM+fDLnArxuGuaxebG87j0l8AmC/WB5Josbovbbra
         CewQanAGaodbEAvG4kTZYvVBkSliwPOThk6pQkrk6XL15c0rdMNn4aT8+rxZfDRxO1Bk
         3uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vs+bgsVu9FaTvXFpcvW8uhZc3ZxIp3T3ZKEdthDZ0Y=;
        b=K4YtJ0dUM+dNqtEjkid56yqXnRJQUXdZIk3rUSuVYipvzPms32tJ4DqNW4o10EJ58F
         +zxSEDQBHcytos1LxTOK1jgzwTvhHklihW5XUHZheS4ONX+jSyyy9O98BGVUkotEu90M
         nPelNX/QNLdhgdkqPuoIALpQXqlLIUsgqgwoq4xW4CzFEGHiddDHpd+w9DjOHjej+uLv
         krjftExBxu3+xTP2P8IrI3chDX2fTKz8TbQJpb9AwgAuWCuCLZ7Cf83GtgjuhhxXTMpK
         KLvnVUzkkHCU8BXu7pMjYCn09LWOU4iWQkZEpTdLQ2w4WdGFmP06hYMqw64FIPGhP9ED
         xTEg==
X-Gm-Message-State: APjAAAVQcUDIOZjqk8lSz7e3srnjPH3NdXoMnAp3ZSGzBUt5q+ihxr71
        /iEothQ8WFc7B/5A1wtHRjRzuj8jNoM=
X-Google-Smtp-Source: APXvYqz4isVpQRq70wHe/hf6bDYjcUf9uFqtXmQINklw6fMm4JArlkXruS41nyicYmKy0sPjdFZFqQ==
X-Received: by 2002:a63:5162:: with SMTP id r34mr34526617pgl.229.1565721202767;
        Tue, 13 Aug 2019 11:33:22 -0700 (PDT)
Received: from localhost.localdomain ([219.91.191.55])
        by smtp.gmail.com with ESMTPSA id g2sm176911142pfq.88.2019.08.13.11.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 11:33:22 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH v2 1/2] regulator: act8865: operating mode and suspend state support
Date:   Wed, 14 Aug 2019 00:02:55 +0530
Message-Id: <1565721176-8955-2-git-send-email-raagjadav@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565721176-8955-1-git-send-email-raagjadav@gmail.com>
References: <1565721176-8955-1-git-send-email-raagjadav@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ->set_mode(), ->get_mode() and ->set_suspend_xx() hooks
for act8865 with unlocked expert registers.

Based on work done by Borris Brezillon on [1].
[1] https://www.spinics.net/lists/kernel/msg2942960.html

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 drivers/regulator/act8865-regulator.c | 187 +++++++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 6a90d3c..0fa97f9 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -19,6 +19,7 @@
 #include <linux/power_supply.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regmap.h>
+#include <dt-bindings/regulator/active-semi,8865-regulator.h>
 
 /*
  * ACT8600 Global Register Map.
@@ -90,23 +91,31 @@
  */
 #define	ACT8865_SYS_MODE	0x00
 #define	ACT8865_SYS_CTRL	0x01
+#define	ACT8865_SYS_UNLK_REGS	0x0b
 #define	ACT8865_DCDC1_VSET1	0x20
 #define	ACT8865_DCDC1_VSET2	0x21
 #define	ACT8865_DCDC1_CTRL	0x22
+#define	ACT8865_DCDC1_SUS	0x24
 #define	ACT8865_DCDC2_VSET1	0x30
 #define	ACT8865_DCDC2_VSET2	0x31
 #define	ACT8865_DCDC2_CTRL	0x32
+#define	ACT8865_DCDC2_SUS	0x34
 #define	ACT8865_DCDC3_VSET1	0x40
 #define	ACT8865_DCDC3_VSET2	0x41
 #define	ACT8865_DCDC3_CTRL	0x42
+#define	ACT8865_DCDC3_SUS	0x44
 #define	ACT8865_LDO1_VSET	0x50
 #define	ACT8865_LDO1_CTRL	0x51
+#define	ACT8865_LDO1_SUS	0x52
 #define	ACT8865_LDO2_VSET	0x54
 #define	ACT8865_LDO2_CTRL	0x55
+#define	ACT8865_LDO2_SUS	0x56
 #define	ACT8865_LDO3_VSET	0x60
 #define	ACT8865_LDO3_CTRL	0x61
+#define	ACT8865_LDO3_SUS	0x62
 #define	ACT8865_LDO4_VSET	0x64
 #define	ACT8865_LDO4_CTRL	0x65
+#define	ACT8865_LDO4_SUS	0x66
 #define	ACT8865_MSTROFF		0x20
 
 /*
@@ -225,6 +234,171 @@ static const struct regulator_linear_range act8600_sudcdc_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(41400000, 248, 255, 0),
 };
 
+static int act8865_set_suspend_state(struct regulator_dev *rdev, bool enable)
+{
+	struct regmap *regmap = rdev->regmap;
+	int id = rdev->desc->id, reg, val;
+
+	switch (id) {
+	case ACT8865_ID_DCDC1:
+		reg = ACT8865_DCDC1_SUS;
+		val = 0xa8;
+		break;
+	case ACT8865_ID_DCDC2:
+		reg = ACT8865_DCDC2_SUS;
+		val = 0xa8;
+		break;
+	case ACT8865_ID_DCDC3:
+		reg = ACT8865_DCDC3_SUS;
+		val = 0xa8;
+		break;
+	case ACT8865_ID_LDO1:
+		reg = ACT8865_LDO1_SUS;
+		val = 0xe8;
+		break;
+	case ACT8865_ID_LDO2:
+		reg = ACT8865_LDO2_SUS;
+		val = 0xe8;
+		break;
+	case ACT8865_ID_LDO3:
+		reg = ACT8865_LDO3_SUS;
+		val = 0xe8;
+		break;
+	case ACT8865_ID_LDO4:
+		reg = ACT8865_LDO4_SUS;
+		val = 0xe8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (enable)
+		val |= BIT(4);
+
+	/*
+	 * Ask the PMIC to enable/disable this output when entering hibernate
+	 * mode.
+	 */
+	return regmap_write(regmap, reg, val);
+}
+
+static int act8865_set_suspend_enable(struct regulator_dev *rdev)
+{
+	return act8865_set_suspend_state(rdev, true);
+}
+
+static int act8865_set_suspend_disable(struct regulator_dev *rdev)
+{
+	return act8865_set_suspend_state(rdev, false);
+}
+
+static unsigned int act8865_of_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case ACT8865_REGULATOR_MODE_FIXED:
+		return REGULATOR_MODE_FAST;
+	case ACT8865_REGULATOR_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case ACT8865_REGULATOR_MODE_LOWPOWER:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static int act8865_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct regmap *regmap = rdev->regmap;
+	int id = rdev_get_id(rdev);
+	int reg, val = 0;
+
+	switch (id) {
+	case ACT8865_ID_DCDC1:
+		reg = ACT8865_DCDC1_CTRL;
+		break;
+	case ACT8865_ID_DCDC2:
+		reg = ACT8865_DCDC2_CTRL;
+		break;
+	case ACT8865_ID_DCDC3:
+		reg = ACT8865_DCDC3_CTRL;
+		break;
+	case ACT8865_ID_LDO1:
+		reg = ACT8865_LDO1_CTRL;
+		break;
+	case ACT8865_ID_LDO2:
+		reg = ACT8865_LDO2_CTRL;
+		break;
+	case ACT8865_ID_LDO3:
+		reg = ACT8865_LDO3_CTRL;
+		break;
+	case ACT8865_ID_LDO4:
+		reg = ACT8865_LDO4_CTRL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+	case REGULATOR_MODE_NORMAL:
+		if (id <= ACT8865_ID_DCDC3)
+			val = BIT(5);
+		break;
+	case REGULATOR_MODE_STANDBY:
+		if (id > ACT8865_ID_DCDC3)
+			val = BIT(5);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(regmap, reg, BIT(5), val);
+}
+
+static unsigned int act8865_get_mode(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev->regmap;
+	int id = rdev_get_id(rdev);
+	int reg, ret, val = 0;
+
+	switch (id) {
+	case ACT8865_ID_DCDC1:
+		reg = ACT8865_DCDC1_CTRL;
+		break;
+	case ACT8865_ID_DCDC2:
+		reg = ACT8865_DCDC2_CTRL;
+		break;
+	case ACT8865_ID_DCDC3:
+		reg = ACT8865_DCDC3_CTRL;
+		break;
+	case ACT8865_ID_LDO1:
+		reg = ACT8865_LDO1_CTRL;
+		break;
+	case ACT8865_ID_LDO2:
+		reg = ACT8865_LDO2_CTRL;
+		break;
+	case ACT8865_ID_LDO3:
+		reg = ACT8865_LDO3_CTRL;
+		break;
+	case ACT8865_ID_LDO4:
+		reg = ACT8865_LDO4_CTRL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	if (id <= ACT8865_ID_DCDC3 && (val & BIT(5)))
+		return REGULATOR_MODE_FAST;
+	else if	(id > ACT8865_ID_DCDC3 && !(val & BIT(5)))
+		return REGULATOR_MODE_NORMAL;
+	else
+		return REGULATOR_MODE_STANDBY;
+}
+
 static const struct regulator_ops act8865_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
@@ -232,7 +406,11 @@ static const struct regulator_ops act8865_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
+	.set_mode		= act8865_set_mode,
+	.get_mode		= act8865_get_mode,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_suspend_enable	= act8865_set_suspend_enable,
+	.set_suspend_disable	= act8865_set_suspend_disable,
 };
 
 static const struct regulator_ops act8865_ldo_ops = {
@@ -242,7 +420,11 @@ static const struct regulator_ops act8865_ldo_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
+	.set_mode		= act8865_set_mode,
+	.get_mode		= act8865_get_mode,
 	.is_enabled		= regulator_is_enabled_regmap,
+	.set_suspend_enable	= act8865_set_suspend_enable,
+	.set_suspend_disable	= act8865_set_suspend_disable,
 	.set_pull_down		= regulator_set_pull_down_regmap,
 };
 
@@ -256,6 +438,7 @@ static const struct regulator_ops act8865_fixed_ldo_ops = {
 	[_family##_ID_##_id] = {					\
 		.name			= _name,			\
 		.of_match		= of_match_ptr(_name),		\
+		.of_map_mode		= act8865_of_map_mode,		\
 		.regulators_node	= of_match_ptr("regulators"),	\
 		.supply_name		= _supply,			\
 		.id			= _family##_ID_##_id,		\
@@ -590,7 +773,9 @@ static int act8865_pmic_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, act8865);
 
-	return 0;
+	/* Unlock expert registers for ACT8865. */
+	return type != ACT8865 ? 0 : regmap_write(act8865->regmap,
+						  ACT8865_SYS_UNLK_REGS, 0xef);
 }
 
 static const struct i2c_device_id act8865_ids[] = {
-- 
2.7.4

