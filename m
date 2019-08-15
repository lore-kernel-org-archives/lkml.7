Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50D4C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725C22084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889291;
	bh=rdAhgsU/T0rdvWxEh/u6PJv5I20N9L1WrHHsK1wuhcQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Kk/b1P9xTYdQYlGGV++m2NRiV5ILaT/E8sUibHEa0vu7eN8Eujs0xIW7gn/uXLl1/
	 XwVkztHb62g9WnP0SwGfcLbi7WylHoj7s1TgRjlJeDk72y7z+CAspVdXbrqCcVH6XO
	 Ilg2+1VAFENNrJkGwRsmMR9r+Zyp+MT/81aqsj8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfHOROu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:50 -0400
Received: from mail-wr1-f100.google.com ([209.85.221.100]:33967 "EHLO
        mail-wr1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731780AbfHOROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:37 -0400
Received: by mail-wr1-f100.google.com with SMTP id s18so2101811wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=ySpgobJR5bj4Xkb3PdeTkzIbBwuG8mGjmRLvJCEofTc=;
        b=a/dPmYrMLi/4hMXMhIHoXiGPMILJa1FF5XHZm0thylxo8L9iCWHjEsCOVJnMLNkbci
         GAeUwOt3jHMEZ6GTnFt13ecx42HaxDD6wT9YB48n7OOrlsvNaTpM3WL+uySHUQZG/F5E
         oWwfN4icozbrAkE5Qk79hzLhjcs8pcWd6EuSqAjWQgfT2FTa/4onL4Bvj9EbvGbSF8hY
         6FsfbByYfIzmg1r8qI9SnEeRsXES0ti0dLkarM+n0Jg0UIX0FZWTVRlR99OPwlrK8eN1
         UIhSAaBqv6G+ZF+Yu2gDg2yB2g3V72UHyi0a/Krh9rbrJfTKkAKAx4R+pdSKmAlvh42K
         T2zA==
X-Gm-Message-State: APjAAAWxKDiod6VQUlCkrIrPZB83gmXeSX3m//KGZ/1HG1nkfWWKVzqf
        7yL6gncS0qSaaas7vrRjB2WWwTX8emYjSwL+/DY2vIVfQIErEDNQ19ANbumOmbB8cQ==
X-Google-Smtp-Source: APXvYqwtMysVdYskzvMOV85slj/0NfBByAhnxSu/8L2/jUmAQ6wO16GiTZtHF4dbwP0rFEb32eLYnsVRgZj6
X-Received: by 2002:adf:e782:: with SMTP id n2mr6427390wrm.1.1565889274755;
        Thu, 15 Aug 2019 10:14:34 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id w13sm46868wrp.62.2019.08.15.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:34 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKc-00052o-CW; Thu, 15 Aug 2019 17:14:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E2AC82742B9E; Thu, 15 Aug 2019 18:14:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: act8865: operating mode and suspend state support" to the regulator tree
In-Reply-To: <1565721176-8955-2-git-send-email-raagjadav@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171433.E2AC82742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8865: operating mode and suspend state support

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 955741a5120bb1ed19d3b12da90bb947d3a0cb99 Mon Sep 17 00:00:00 2001
From: Raag Jadav <raagjadav@gmail.com>
Date: Wed, 14 Aug 2019 00:02:55 +0530
Subject: [PATCH] regulator: act8865: operating mode and suspend state support

Implement ->set_mode(), ->get_mode() and ->set_suspend_xx() hooks
for act8865 with unlocked expert registers.

Based on work done by Borris Brezillon on [1].
[1] https://www.spinics.net/lists/kernel/msg2942960.html

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
Link: https://lore.kernel.org/r/1565721176-8955-2-git-send-email-raagjadav@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8865-regulator.c | 187 +++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 6a90d3c7a452..0fa97f934df4 100644
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
2.20.1

