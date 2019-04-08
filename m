Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298E0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC87A20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708656;
	bh=7zorw6pAXsLd7TPEFZ9pFpYFTyGYRw4mwb/xCA0yYes=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yjEjPlCdZoknmeB8VKAGfXCq6hVALE8jebH95QST6qyJVktkyN8fYkgUucl1O3hDi
	 ZJzjRvZwL/gWHc7lpvA3JeaW8jRFoRybtqw4O4rTgy+l/SCBAsH4BNoCwLTwxx7pLa
	 i2DGdsThPcSMQanSYehioypGpnKspAud9njIkhNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDHHay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:30:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41724 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xtX1r5T//vKuUZ280k4Nt9JYOQ9mWoA46NsHRiwmzgI=; b=IxEECupdh4qw
        MEbpf5j+aVnscCfzenOhqXThOHoggKkHN+iG2TRAajv0yKHiwEgUXw2v5qRAAMk9+vF1VufAnLAA5
        5uEDpd+dEkIQLxUcZc/PyFqEbN3aLH4JXZ59J0Z6a8rtEzhL52+5hU/Qq42LooDg/RLotTonTa5to
        Gcqx4=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOjy-0003vS-3Y; Mon, 08 Apr 2019 07:30:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B722E441D3B; Mon,  8 Apr 2019 14:30:38 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: s2mpa01: Convert to use simplified DT parsing" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190408073038.B722E441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:30:38 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mpa01: Convert to use simplified DT parsing

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 0677c3ea53dcb38314718e8ed7d851972eabf102 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 4 Apr 2019 23:07:09 +0800
Subject: [PATCH] regulator: s2mpa01: Convert to use simplified DT parsing

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mpa01.c | 39 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 58a1fe583a6c..da11ac5c09f2 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -20,7 +20,6 @@
 #define S2MPA01_REGULATOR_CNT ARRAY_SIZE(regulators)
 
 struct s2mpa01_info {
-	struct of_regulator_match rdata[S2MPA01_REGULATOR_MAX];
 	int ramp_delay24;
 	int ramp_delay3;
 	int ramp_delay5;
@@ -232,6 +231,8 @@ static const struct regulator_ops s2mpa01_buck_ops = {
 
 #define regulator_desc_ldo(num, step) {			\
 	.name		= "LDO"#num,			\
+	.of_match	= of_match_ptr("LDO"#num),	\
+	.regulators_node = of_match_ptr("regulators"),	\
 	.id		= S2MPA01_LDO##num,		\
 	.ops		= &s2mpa01_ldo_ops,		\
 	.type		= REGULATOR_VOLTAGE,		\
@@ -247,6 +248,8 @@ static const struct regulator_ops s2mpa01_buck_ops = {
 
 #define regulator_desc_buck1_4(num)	{			\
 	.name		= "BUCK"#num,				\
+	.of_match	= of_match_ptr("BUCK"#num),		\
+	.regulators_node = of_match_ptr("regulators"),		\
 	.id		= S2MPA01_BUCK##num,			\
 	.ops		= &s2mpa01_buck_ops,			\
 	.type		= REGULATOR_VOLTAGE,			\
@@ -263,6 +266,8 @@ static const struct regulator_ops s2mpa01_buck_ops = {
 
 #define regulator_desc_buck5	{				\
 	.name		= "BUCK5",				\
+	.of_match	= of_match_ptr("BUCK5"),		\
+	.regulators_node = of_match_ptr("regulators"),		\
 	.id		= S2MPA01_BUCK5,			\
 	.ops		= &s2mpa01_buck_ops,			\
 	.type		= REGULATOR_VOLTAGE,			\
@@ -279,6 +284,8 @@ static const struct regulator_ops s2mpa01_buck_ops = {
 
 #define regulator_desc_buck6_10(num, min, step) {			\
 	.name		= "BUCK"#num,				\
+	.of_match	= of_match_ptr("BUCK"#num),		\
+	.regulators_node = of_match_ptr("regulators"),		\
 	.id		= S2MPA01_BUCK##num,			\
 	.ops		= &s2mpa01_buck_ops,			\
 	.type		= REGULATOR_VOLTAGE,			\
@@ -336,9 +343,7 @@ static int s2mpa01_pmic_probe(struct platform_device *pdev)
 {
 	struct sec_pmic_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct sec_platform_data *pdata = dev_get_platdata(iodev->dev);
-	struct device_node *reg_np = NULL;
 	struct regulator_config config = { };
-	struct of_regulator_match *rdata;
 	struct s2mpa01_info *s2mpa01;
 	int i;
 
@@ -346,39 +351,15 @@ static int s2mpa01_pmic_probe(struct platform_device *pdev)
 	if (!s2mpa01)
 		return -ENOMEM;
 
-	rdata = s2mpa01->rdata;
-	for (i = 0; i < S2MPA01_REGULATOR_CNT; i++)
-		rdata[i].name = regulators[i].name;
-
-	if (iodev->dev->of_node) {
-		reg_np = of_get_child_by_name(iodev->dev->of_node,
-							"regulators");
-		if (!reg_np) {
-			dev_err(&pdev->dev,
-				"could not find regulators sub-node\n");
-			return -EINVAL;
-		}
-
-		of_regulator_match(&pdev->dev, reg_np, rdata,
-						S2MPA01_REGULATOR_MAX);
-		of_node_put(reg_np);
-	}
-
-	platform_set_drvdata(pdev, s2mpa01);
-
-	config.dev = &pdev->dev;
+	config.dev = iodev->dev;
 	config.regmap = iodev->regmap_pmic;
 	config.driver_data = s2mpa01;
 
 	for (i = 0; i < S2MPA01_REGULATOR_MAX; i++) {
 		struct regulator_dev *rdev;
+
 		if (pdata)
 			config.init_data = pdata->regulators[i].initdata;
-		else
-			config.init_data = rdata[i].init_data;
-
-		if (reg_np)
-			config.of_node = rdata[i].of_node;
 
 		rdev = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
-- 
2.20.1

