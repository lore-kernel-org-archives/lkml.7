Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B6CC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00832173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfEUKEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:04:52 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53054 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbfEUKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:04:47 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LA4bYC026003;
        Tue, 21 May 2019 05:04:41 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2sjff1uupp-1;
        Tue, 21 May 2019 05:04:40 -0500
Received: from EDIEX01.ad.cirrus.com (unknown [198.61.84.80])
        by mail2.cirrus.com (Postfix) with ESMTP id 56392605A698;
        Tue, 21 May 2019 05:04:40 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 21 May
 2019 11:04:39 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 21 May 2019 11:04:39 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B00252DA;
        Tue, 21 May 2019 11:04:39 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/3] regulator: arizona-ldo1: Add support for Cirrus Logic Madera codecs
Date:   Tue, 21 May 2019 11:04:38 +0100
Message-ID: <20190521100439.27383-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190521100439.27383-1-ckeepax@opensource.cirrus.com>
References: <20190521100439.27383-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

This adds a new driver identity "madera-ldo1" and probe function
so that this driver can be used to control the LDO1 regulator on
some Cirrus Logic Madera codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/Kconfig        |  8 ++--
 drivers/regulator/arizona-ldo1.c | 83 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6c37f0df93232..d2db658840f47 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -135,12 +135,12 @@ config REGULATOR_AB8500
 	  signal AB8500 PMIC
 
 config REGULATOR_ARIZONA_LDO1
-	tristate "Wolfson Arizona class devices LDO1"
-	depends on MFD_ARIZONA
+	tristate "Cirrus Madera and Wolfson Arizona class devices LDO1"
+	depends on MFD_ARIZONA || MFD_MADERA
 	depends on SND_SOC
 	help
-	  Support for the LDO1 regulators found on Wolfson Arizona class
-	  devices.
+	  Support for the LDO1 regulators found on Cirrus Logic Madera codecs
+	  and Wolfson Microelectronic Arizona codecs.
 
 config REGULATOR_ARIZONA_MICSUPP
 	tristate "Wolfson Arizona class devices MICSUPP"
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index e4bc7b1e5ccdd..1a3d7b720f5e0 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -25,6 +25,10 @@
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
 
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
 struct arizona_ldo1 {
 	struct regulator_dev *regulator;
 	struct regmap *regmap;
@@ -158,6 +162,31 @@ static const struct regulator_init_data arizona_ldo1_wm5110 = {
 	.num_consumer_supplies = 1,
 };
 
+static const struct regulator_desc madera_ldo1 = {
+	.name = "LDO1",
+	.supply_name = "LDOVDD",
+	.type = REGULATOR_VOLTAGE,
+	.ops = &arizona_ldo1_ops,
+
+	.vsel_reg = MADERA_LDO1_CONTROL_1,
+	.vsel_mask = MADERA_LDO1_VSEL_MASK,
+	.min_uV = 900000,
+	.uV_step = 25000,
+	.n_voltages = 13,
+	.enable_time = 3000,
+
+	.owner = THIS_MODULE,
+};
+
+static const struct regulator_init_data madera_ldo1_default = {
+	.constraints = {
+		.min_uV = 1200000,
+		.max_uV = 1200000,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = 1,
+};
+
 static int arizona_ldo1_of_get_pdata(struct arizona_ldo1_pdata *pdata,
 				     struct regulator_config *config,
 				     const struct regulator_desc *desc,
@@ -320,6 +349,32 @@ static int arizona_ldo1_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int madera_ldo1_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct arizona_ldo1 *ldo1;
+	bool external_dcvdd;
+	int ret;
+
+	ldo1 = devm_kzalloc(&pdev->dev, sizeof(*ldo1), GFP_KERNEL);
+	if (!ldo1)
+		return -ENOMEM;
+
+	ldo1->regmap = madera->regmap;
+
+	ldo1->init_data = madera_ldo1_default;
+
+	ret = arizona_ldo1_common_init(pdev, ldo1, &madera_ldo1,
+				       &madera->pdata.ldo1,
+				       &external_dcvdd);
+	if (ret)
+		return ret;
+
+	madera->internal_dcvdd = !external_dcvdd;
+
+	return 0;
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
 	.remove = arizona_ldo1_remove,
@@ -328,10 +383,36 @@ static struct platform_driver arizona_ldo1_driver = {
 	},
 };
 
-module_platform_driver(arizona_ldo1_driver);
+static struct platform_driver madera_ldo1_driver = {
+	.probe = madera_ldo1_probe,
+	.remove = arizona_ldo1_remove,
+	.driver		= {
+		.name	= "madera-ldo1",
+	},
+};
+
+static struct platform_driver * const madera_ldo1_drivers[] = {
+	&arizona_ldo1_driver,
+	&madera_ldo1_driver,
+};
+
+static int __init arizona_ldo1_init(void)
+{
+	return platform_register_drivers(madera_ldo1_drivers,
+					 ARRAY_SIZE(madera_ldo1_drivers));
+}
+module_init(arizona_ldo1_init);
+
+static void __exit madera_ldo1_exit(void)
+{
+	platform_unregister_drivers(madera_ldo1_drivers,
+				    ARRAY_SIZE(madera_ldo1_drivers));
+}
+module_exit(madera_ldo1_exit);
 
 /* Module information */
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("Arizona LDO1 driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:arizona-ldo1");
+MODULE_ALIAS("platform:madera-ldo1");
-- 
2.11.0

