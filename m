Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FBFC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659FA214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561808703;
	bh=IJaOnylsAxRMYgoxcOD5Q95Js8KcjchKhL4EIpgWAjM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M6SDnzEW1FxatAgJCfzcHCVZ8ggQfLNGPeloSpMdL3R0jJ6zy/X2LrG57mDBI/Kbu
	 BveTKTksRbBzde+Makw/F9zpwRfNfW/vo3qlbd0Wh7RmO8ZS4kzoP3yB4ukzierPgN
	 tgRI0utjp7RjLn0DFbFOrs+Nx/ZPyuwy7Rc79YAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfF2LpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 07:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfF2LpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 07:45:00 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5377321670;
        Sat, 29 Jun 2019 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561808699;
        bh=IJaOnylsAxRMYgoxcOD5Q95Js8KcjchKhL4EIpgWAjM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=elG/4PuiGEVsmw1DlaaCFhHO23CCD/Yy52KejpQ+2kydp7iPcd0ACRBzCxU6016n1
         nuU8wJFlbrHNWl+IcjcpI3qNOrjfrst5xgmgc5X9SVZeCOQOp0oZgCWUISiAQBb9b5
         fa9NSx/dC/YJu1LbkbY0WmeVf3rUT4LkHcbVz6b0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] regulator: s2mps11: Adjust supported buck voltages to real values
Date:   Sat, 29 Jun 2019 13:44:46 +0200
Message-Id: <20190629114446.11381-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629114446.11381-1-krzk@kernel.org>
References: <20190629114446.11381-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was registering buck regulators with unsupported range of
voltages for S2MPS11 devices.  Basically it assumed that all 256 values
are possible for a single 8-bit I2C register controlling buck's voltage.
This is not true, as datasheet describes subset of these which can be
used.

For example for buck[12346] the minimum voltage is 650 mV which
corresponds to register value of 0x8.  The driver was however
registering regulator starting at 600 mV, so for a step of 6.25 mV this
gave the same result.  However this allowed to try to configure
regulators to unsupported values.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/s2mps11.c         | 27 +++++++++++++++++----------
 include/linux/mfd/samsung/core.h    |  1 +
 include/linux/mfd/samsung/s2mps11.h |  4 +++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 8f3c8730dc0d..054baaadfdfd 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -376,9 +376,10 @@ static const struct regulator_ops s2mps11_buck_ops = {
 	.ops		= &s2mps11_buck_ops,			\
 	.type		= REGULATOR_VOLTAGE,			\
 	.owner		= THIS_MODULE,				\
-	.min_uV		= MIN_600_MV,				\
+	.min_uV		= MIN_650_MV,				\
 	.uV_step	= STEP_6_25_MV,				\
-	.n_voltages	= S2MPS11_BUCK_N_VOLTAGES,		\
+	.linear_min_sel	= 8,					\
+	.n_voltages	= S2MPS11_BUCK12346_N_VOLTAGES,		\
 	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
 	.vsel_reg	= S2MPS11_REG_B1CTRL2 + (num - 1) * 2,	\
 	.vsel_mask	= S2MPS11_BUCK_VSEL_MASK,		\
@@ -392,9 +393,10 @@ static const struct regulator_ops s2mps11_buck_ops = {
 	.ops		= &s2mps11_buck_ops,			\
 	.type		= REGULATOR_VOLTAGE,			\
 	.owner		= THIS_MODULE,				\
-	.min_uV		= MIN_600_MV,				\
+	.min_uV		= MIN_650_MV,				\
 	.uV_step	= STEP_6_25_MV,				\
-	.n_voltages	= S2MPS11_BUCK_N_VOLTAGES,		\
+	.linear_min_sel	= 8,					\
+	.n_voltages	= S2MPS11_BUCK5_N_VOLTAGES,		\
 	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
 	.vsel_reg	= S2MPS11_REG_B5CTRL2,			\
 	.vsel_mask	= S2MPS11_BUCK_VSEL_MASK,		\
@@ -402,7 +404,7 @@ static const struct regulator_ops s2mps11_buck_ops = {
 	.enable_mask	= S2MPS11_ENABLE_MASK			\
 }
 
-#define regulator_desc_s2mps11_buck67810(num, min, step) {	\
+#define regulator_desc_s2mps11_buck67810(num, min, step, min_sel, voltages) {	\
 	.name		= "BUCK"#num,				\
 	.id		= S2MPS11_BUCK##num,			\
 	.ops		= &s2mps11_buck_ops,			\
@@ -410,7 +412,8 @@ static const struct regulator_ops s2mps11_buck_ops = {
 	.owner		= THIS_MODULE,				\
 	.min_uV		= min,					\
 	.uV_step	= step,					\
-	.n_voltages	= S2MPS11_BUCK_N_VOLTAGES,		\
+	.linear_min_sel	= min_sel,				\
+	.n_voltages	= voltages,				\
 	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
 	.vsel_reg	= S2MPS11_REG_B6CTRL2 + (num - 6) * 2,	\
 	.vsel_mask	= S2MPS11_BUCK_VSEL_MASK,		\
@@ -478,11 +481,15 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_buck1_4(3),
 	regulator_desc_s2mps11_buck1_4(4),
 	regulator_desc_s2mps11_buck5,
-	regulator_desc_s2mps11_buck67810(6, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(7, MIN_750_MV, STEP_12_5_MV),
-	regulator_desc_s2mps11_buck67810(8, MIN_750_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(6, MIN_650_MV, STEP_6_25_MV, 8,
+					 S2MPS11_BUCK12346_N_VOLTAGES),
+	regulator_desc_s2mps11_buck67810(7, MIN_750_MV, STEP_12_5_MV, 0,
+					 S2MPS11_BUCK7810_N_VOLTAGES),
+	regulator_desc_s2mps11_buck67810(8, MIN_750_MV, STEP_12_5_MV, 0,
+					 S2MPS11_BUCK7810_N_VOLTAGES),
 	regulator_desc_s2mps11_buck9,
-	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV, 0,
+					 S2MPS11_BUCK7810_N_VOLTAGES),
 };
 
 static const struct regulator_ops s2mps14_reg_ops;
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index 3ca17eb89aa2..f1631a39acfc 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -20,6 +20,7 @@
 #define MIN_850_MV		850000
 #define MIN_800_MV		800000
 #define MIN_750_MV		750000
+#define MIN_650_MV		650000
 #define MIN_600_MV		600000
 #define MIN_500_MV		500000
 
diff --git a/include/linux/mfd/samsung/s2mps11.h b/include/linux/mfd/samsung/s2mps11.h
index f6c035eb87be..4805c90609c4 100644
--- a/include/linux/mfd/samsung/s2mps11.h
+++ b/include/linux/mfd/samsung/s2mps11.h
@@ -170,7 +170,9 @@ enum s2mps11_regulators {
 #define S2MPS11_ENABLE_MASK	(0x03 << S2MPS11_ENABLE_SHIFT)
 #define S2MPS11_ENABLE_SHIFT	0x06
 #define S2MPS11_LDO_N_VOLTAGES	(S2MPS11_LDO_VSEL_MASK + 1)
-#define S2MPS11_BUCK_N_VOLTAGES (S2MPS11_BUCK_VSEL_MASK + 1)
+#define S2MPS11_BUCK12346_N_VOLTAGES	153
+#define S2MPS11_BUCK5_N_VOLTAGES	216
+#define S2MPS11_BUCK7810_N_VOLTAGES	225
 #define S2MPS11_BUCK9_N_VOLTAGES (S2MPS11_BUCK9_VSEL_MASK + 1)
 #define S2MPS11_RAMP_DELAY	25000		/* uV/us */
 
-- 
2.17.1

