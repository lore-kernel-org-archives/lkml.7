Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD2C20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="l8gVjGEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfDAOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:43:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43264 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:43:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so4871782pgu.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qBye3YN0+6elUnhPMDzZtyL+cn56XPqshYm01DE1Vo8=;
        b=l8gVjGEVUO4wlG/Valkl3BFYZPioN4aSLfitLtJ4pd32HFycxe2HrxgVpKPlcSkBcJ
         cDyb6JpOMckVmx4mC52auGf41N7fbMKeMca9xsloMoQoqM+6FFwiw/oXaneHG8M4L4Vj
         WlFSYzM9etvSmDh12FDpjJuiQwcyMmMg8ka/uGvKUpxXpAQ+EKy0Yg5AzOQiWQPoMJVk
         5SkrsAt6nXwmJFVvuIwZsZWyuV7UzDVIBD/wkddbbS6fanqsfEVcQIGLbO/e/a95j1f0
         HmwkCTzJia+6A4ULVOtmxMlyl4oYx480QWxAV0zEB5+C8kYCiMQy78FbkOSGUla6Er0y
         507A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qBye3YN0+6elUnhPMDzZtyL+cn56XPqshYm01DE1Vo8=;
        b=llf0s4v800lXDAYjKZydvZwnc5BEqw5SXI9ho2tbximy6cI5CQXTmk7e5GRHqj7YmB
         MPvmQ3u0CXEstbdaV+oV9iqgdyfH1j9vrDCOSztw967+du7jQehAA2+rEnJkEYxsBBcM
         h2tFBdEmlv7Le/rYVglG2CQsKdyIUpYy6V+xnwpkYk1nHLNfTzU0h0rnk12GUGtwxmku
         9p77PhU8SuMqroRrMqtNZyPNCxQtztoePSJSPLA8I/DXVX1yrufLeBKuF3BmZjxpFewP
         iTZy0NVyrmbTW3WJrONPjW0gfx1yYsSFFjB2uBDSWp16P1Mj24CmOQ5SuM3h2nd0/58y
         TMXg==
X-Gm-Message-State: APjAAAXBLJdgYQJGoLa6fYJtgaW9q/oRePicgmWkrWhK2XP1dpeHv57H
        bUXkkdB1WWWs9yOn7BAG8RVNgw==
X-Google-Smtp-Source: APXvYqyJ6SkuO4miE6qpvD5ANttlUiXDJUYt1Bf5JqLC7O06xqurjG0G/IxC+9ybHjBdvl3noGLiRA==
X-Received: by 2002:a63:5b64:: with SMTP id l36mr62308861pgm.182.1554129790039;
        Mon, 01 Apr 2019 07:43:10 -0700 (PDT)
Received: from localhost.localdomain (36-239-218-23.dynamic-ip.hinet.net. [36.239.218.23])
        by smtp.gmail.com with ESMTPSA id e21sm15723982pfd.177.2019.04.01.07.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 07:43:08 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matt Porter <mporter@linaro.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Graham Williams <graham.williams@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bcm590xx: Convert to use simplified DT parsing
Date:   Mon,  1 Apr 2019 22:42:36 +0800
Message-Id: <20190401144236.1301-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
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
2.17.1

