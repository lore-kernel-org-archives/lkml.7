Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBB920830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554184021;
	bh=FuVZZ49BpPo9xCUqthe0Edco2/zv8JmBm3N/MIVoQbE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GH84S/5wKW7RS/gTLD+U63zP6EP0UCFdR8Nbv8m8Dg5VEyv72P5BcbF1UDSIaxOXX
	 ESrobx1xSt3bvXaow/0SX7EtRcl/4QfhRsYJPy3e1DeeQBJIYVK1iTKli8fP8fjlUe
	 tN20/ayZk7a13hXmas5f0HGAzTqQH/IoWtxLmBmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfDBFq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:46:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46692 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDBFq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KkZhymn0jGjGB4i3GkMdkP8pIa3OS5O3PNizJ587Xnk=; b=GSmAFBwLc+kG
        41ZEtrT3bTGmMWwe6jkV8OgHC3pheWmql6Ut74eFe7C0qM7QJWDfIROl6omfTytrdgpXRQY6YvYib
        nByheQFbLdEhPgrWtM5rD9qWzzgVfG1nWDhTpsK+ayWP+1tZyNGUrzHqS8p3BpZWuzDOaNtTrSRoa
        gCNe0=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBCG8-0005zE-Pz; Tue, 02 Apr 2019 05:46:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BFA1D44133F; Tue,  2 Apr 2019 06:46:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bcm590xx: Convert to use simplified DT parsing" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190402054653.BFA1D44133F@finisterre.ee.mobilebroadband>
Date:   Tue,  2 Apr 2019 06:46:53 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bcm590xx: Convert to use simplified DT parsing

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

From a4e73625cb12f662b2a72d292f34232c61cca47f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 1 Apr 2019 22:42:36 +0800
Subject: [PATCH] regulator: bcm590xx: Convert to use simplified DT parsing

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bcm590xx-regulator.c | 105 +------------------------
 1 file changed, 2 insertions(+), 103 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index e49c0a7d5dd5..85ccc93b2bb6 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -103,10 +103,6 @@
 	((n > BCM590XX_REG_VSR) && (n < BCM590XX_REG_VBUS))
 #define BCM590XX_REG_IS_VBUS(n)	(n == BCM590XX_REG_VBUS)
 
-struct bcm590xx_board {
-	struct regulator_init_data *bcm590xx_pmu_init_data[BCM590XX_NUM_REGS];
-};
-
 /* LDO group A: supported voltages in microvolts */
 static const unsigned int ldo_a_table[] = {
 	1200000, 1800000, 2500000, 2700000, 2800000,
@@ -280,105 +276,15 @@ static const struct regulator_ops bcm590xx_ops_vbus = {
 	.disable		= regulator_disable_regmap,
 };
 
-#define BCM590XX_MATCH(_name, _id) \
-	{ \
-		.name = #_name, \
-		.driver_data = (void *)&bcm590xx_regs[BCM590XX_REG_##_id], \
-	}
-
-static struct of_regulator_match bcm590xx_matches[] = {
-	BCM590XX_MATCH(rfldo, RFLDO),
-	BCM590XX_MATCH(camldo1, CAMLDO1),
-	BCM590XX_MATCH(camldo2, CAMLDO2),
-	BCM590XX_MATCH(simldo1, SIMLDO1),
-	BCM590XX_MATCH(simldo2, SIMLDO2),
-	BCM590XX_MATCH(sdldo, SDLDO),
-	BCM590XX_MATCH(sdxldo, SDXLDO),
-	BCM590XX_MATCH(mmcldo1, MMCLDO1),
-	BCM590XX_MATCH(mmcldo2, MMCLDO2),
-	BCM590XX_MATCH(audldo, AUDLDO),
-	BCM590XX_MATCH(micldo, MICLDO),
-	BCM590XX_MATCH(usbldo, USBLDO),
-	BCM590XX_MATCH(vibldo, VIBLDO),
-	BCM590XX_MATCH(csr, CSR),
-	BCM590XX_MATCH(iosr1, IOSR1),
-	BCM590XX_MATCH(iosr2, IOSR2),
-	BCM590XX_MATCH(msr, MSR),
-	BCM590XX_MATCH(sdsr1, SDSR1),
-	BCM590XX_MATCH(sdsr2, SDSR2),
-	BCM590XX_MATCH(vsr, VSR),
-	BCM590XX_MATCH(gpldo1, GPLDO1),
-	BCM590XX_MATCH(gpldo2, GPLDO2),
-	BCM590XX_MATCH(gpldo3, GPLDO3),
-	BCM590XX_MATCH(gpldo4, GPLDO4),
-	BCM590XX_MATCH(gpldo5, GPLDO5),
-	BCM590XX_MATCH(gpldo6, GPLDO6),
-	BCM590XX_MATCH(vbus, VBUS),
-};
-
-static struct bcm590xx_board *bcm590xx_parse_dt_reg_data(
-		struct platform_device *pdev,
-		struct of_regulator_match **bcm590xx_reg_matches)
-{
-	struct bcm590xx_board *data;
-	struct device_node *np = pdev->dev.parent->of_node;
-	struct device_node *regulators;
-	struct of_regulator_match *matches = bcm590xx_matches;
-	int count = ARRAY_SIZE(bcm590xx_matches);
-	int idx = 0;
-	int ret;
-
-	if (!np) {
-		dev_err(&pdev->dev, "of node not found\n");
-		return NULL;
-	}
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return NULL;
-
-	np = of_node_get(np);
-	regulators = of_get_child_by_name(np, "regulators");
-	if (!regulators) {
-		dev_warn(&pdev->dev, "regulator node not found\n");
-		return NULL;
-	}
-
-	ret = of_regulator_match(&pdev->dev, regulators, matches, count);
-	of_node_put(regulators);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error parsing regulator init data: %d\n",
-			ret);
-		return NULL;
-	}
-
-	*bcm590xx_reg_matches = matches;
-
-	for (idx = 0; idx < count; idx++) {
-		if (!matches[idx].init_data || !matches[idx].of_node)
-			continue;
-
-		data->bcm590xx_pmu_init_data[idx] = matches[idx].init_data;
-	}
-
-	return data;
-}
-
 static int bcm590xx_probe(struct platform_device *pdev)
 {
 	struct bcm590xx *bcm590xx = dev_get_drvdata(pdev->dev.parent);
-	struct bcm590xx_board *pmu_data = NULL;
 	struct bcm590xx_reg *pmu;
 	struct regulator_config config = { };
 	struct bcm590xx_info *info;
-	struct regulator_init_data *reg_data;
 	struct regulator_dev *rdev;
-	struct of_regulator_match *bcm590xx_reg_matches = NULL;
 	int i;
 
-	pmu_data = bcm590xx_parse_dt_reg_data(pdev,
-					      &bcm590xx_reg_matches);
-
 	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
 	if (!pmu)
 		return -ENOMEM;
@@ -397,13 +303,10 @@ static int bcm590xx_probe(struct platform_device *pdev)
 	info = bcm590xx_regs;
 
 	for (i = 0; i < BCM590XX_NUM_REGS; i++, info++) {
-		if (pmu_data)
-			reg_data = pmu_data->bcm590xx_pmu_init_data[i];
-		else
-			reg_data = NULL;
-
 		/* Register the regulators */
 		pmu->desc[i].name = info->name;
+		pmu->desc[i].of_match = of_match_ptr(info->name);
+		pmu->desc[i].regulators_node = of_match_ptr("regulators");
 		pmu->desc[i].supply_name = info->vin_name;
 		pmu->desc[i].id = i;
 		pmu->desc[i].volt_table = info->volt_table;
@@ -433,16 +336,12 @@ static int bcm590xx_probe(struct platform_device *pdev)
 		pmu->desc[i].owner = THIS_MODULE;
 
 		config.dev = bcm590xx->dev;
-		config.init_data = reg_data;
 		config.driver_data = pmu;
 		if (BCM590XX_REG_IS_GPLDO(i) || BCM590XX_REG_IS_VBUS(i))
 			config.regmap = bcm590xx->regmap_sec;
 		else
 			config.regmap = bcm590xx->regmap_pri;
 
-		if (bcm590xx_reg_matches)
-			config.of_node = bcm590xx_reg_matches[i].of_node;
-
 		rdev = devm_regulator_register(&pdev->dev, &pmu->desc[i],
 					       &config);
 		if (IS_ERR(rdev)) {
-- 
2.20.1

