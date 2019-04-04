Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF384C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F3E2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Q23cD+5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfDDPH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:07:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33754 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:07:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so1329736plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vEU0hElGSBKXNWQnOdtg/qnRUbGnqUX/uD6zGVKc+8c=;
        b=Q23cD+5z/nK7ng4E9mLGTCqiKGyMvO2c1JYhoIsUFa7ud4nXZYslWaal66XmHPLWeF
         pUeEDJDCG0fOvWZpa1q7wFyBzdJ1khzGiJixN1adQgon8iLyAGGZ9Ug6k/zj4es8Xdyd
         xyI2XzKkryPcm8b5LHFHRV3JhOwLaD71GVb/t2Z+hNESMi27nd35Zkw8ddXPT7qAzxI7
         0HYfBIdS6Ep/hZBBcsyWHb13QAvJYOF2qA9xLrT3vID/3SDyBv5mSSJAy29/fP1jOihl
         2BiNh8oExWK+kDvTgZrlN+0IraBMQ48WRoGtD25k447F3KIxauMXRtAasXHTL9amPtsB
         8dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vEU0hElGSBKXNWQnOdtg/qnRUbGnqUX/uD6zGVKc+8c=;
        b=mj53GTKXoOPWXO6NAdQxLFOkwEMcJPy9JoRVmDGcBC312V/khs2sNPH55MGZNixFa3
         U6l8fboxC3tBnli+h4i35NkSVXCNWiapMT1fFJTEep6mvkjFyy+ZWY4BMTIkEpNnnYZ3
         SACrILmT+sN5dr9QLqGikh/z8nF0VpxF9Y/JE0aaEIqqGeC+eXl3hjS8HEn1Gu5bPNbp
         BJVsEZ1kh2vtQFU5oPezdpQjPnvC9ixrTiyOGvHTbJ0xx3J/Bp54d7WHAWMpuAP6ISxr
         0XRK6NyLqCrCOQ4mHh7xgDbU/Qxw9shYH8cRI1k/OholyVhZHRtTeHusJNhoOcL317oB
         yB3Q==
X-Gm-Message-State: APjAAAX+cXkTG6JTFbxUHCAW9CgFmw8FyXnhzyzWOCK+rZ4JhMKQecDP
        64QyzaDliG9EITLcA0RmUXJ0yA==
X-Google-Smtp-Source: APXvYqzlgVjdc6ybq4L5YDNvMQS71JuQshOf9DaaF3eHu1lmtHf1LEjhIKYsRvf/JNbV93t1IJTLrQ==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr7112394plu.246.1554390444748;
        Thu, 04 Apr 2019 08:07:24 -0700 (PDT)
Received: from localhost.localdomain (36-239-229-248.dynamic-ip.hinet.net. [36.239.229.248])
        by smtp.gmail.com with ESMTPSA id u13sm42460126pfa.169.2019.04.04.08.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 08:07:23 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sachin Kamat <sachin.kamat@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: s2mpa01: Convert to use simplified DT parsing
Date:   Thu,  4 Apr 2019 23:07:09 +0800
Message-Id: <20190404150709.11940-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
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
2.17.1

