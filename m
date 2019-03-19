Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCFF2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="1tE+0ECS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfCSHjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:39:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47078 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSHjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:39:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so13249005pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ysj5yLkRVgCUvVwY5iH5Jac/AWM65O0IxwMcV/9Lgvk=;
        b=1tE+0ECSeA7MJM4AkEnYox4GdY75jjn+lnbsREJ7YnnTfRVKHc8ekwEdoVcG92SPFH
         1EU/jPS+PdLKkovuHxoKQNp7gqjzsbO8/W84ZKJJauqRFsLZPFCpOwfFTfP2SHqybvLt
         qKW1Jom4oBcb0pvkGKqnHhqvA+Ty/35TAq2r3xrKvhKDL1ik3bLe5qxs/V0anR5w4J5o
         CCVWlNQ1sL53eoBLDQBmt/TPY1+aEOwtwf/HN7Y7+zMjKQkaX/NXuYL7ncIbgG4Kp4vj
         hONIa0oC+L390X5pNoRokA2kvJfjCpHADxpkzNCogRW1qZ+2ZEe5kSc5qNBkhNI9ZfIj
         2Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ysj5yLkRVgCUvVwY5iH5Jac/AWM65O0IxwMcV/9Lgvk=;
        b=S06C7elI64kG86M/t2XgPOK4KMvZwzFPTRgh7fYq2qqcZsikSwGTZnfFY3/UOb9g0+
         rAaMYMZ69z4R3IkZlfnfovCJ95+FVhuz5uRAeuWioaZGHP6gnUujDosYECkjbPhZbDwW
         9ionNTRJxpkYAPfAD5VRUDI+S3tjE4zIxrBeCR6R3L3hmTpmmYYrsOoZ8NKBLOD+bFnE
         iy0vnjoOZqYmNw/5Vrn7L9uJrO9obNPql8jJtJQ8Eir9uiRPmtdsOwDbP4OR87PcoYa3
         lKSdvgkmT7KS2N5JLJy/5gfGEEapfIcCoPV2Uu2JAtWYdsClrfa/pjVA5gitOFovq2CZ
         B32w==
X-Gm-Message-State: APjAAAV6TNB+udh+h5XNmJ7fkEMbQaKsMtB2tfaB63aGzkvZ24eS23sM
        x+wyeMBFSccN1mlp0CcMKLUROw==
X-Google-Smtp-Source: APXvYqwoZuUMztoCoa5JpbUqmjuTtXHY1Jh9l1z96dKJQUKk8ZKaUipG2oWuLDbD0QBTYDP2yAy8Rg==
X-Received: by 2002:a62:41cc:: with SMTP id g73mr991519pfd.145.1552981180361;
        Tue, 19 Mar 2019 00:39:40 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-96.dynamic-ip.hinet.net. [118.171.142.96])
        by smtp.gmail.com with ESMTPSA id k75sm38375443pfj.46.2019.03.19.00.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 00:39:39 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Jett . Zhou" <jtzhou@marvell.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: 88pm8607: Convert to regulator core's simplified DT parsing code
Date:   Tue, 19 Mar 2019 15:39:27 +0800
Message-Id: <20190319073927.11436-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator core's simplified DT parsing code to simply the driver
implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/88pm8607.c | 43 ++++++++----------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 753a6a1b30c3..35d767aeeb57 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -235,6 +235,8 @@ static const struct regulator_ops pm8606_preg_ops = {
 {									\
 	.desc	= {							\
 		.name	= "PREG",					\
+		.of_match = of_match_ptr("PREG"),			\
+		.regulators_node = of_match_ptr("regulators"),		\
 		.ops	= &pm8606_preg_ops,				\
 		.type	= REGULATOR_CURRENT,				\
 		.id	= PM8606_ID_PREG,				\
@@ -249,6 +251,8 @@ static const struct regulator_ops pm8606_preg_ops = {
 {									\
 	.desc	= {							\
 		.name	= #vreg,					\
+		.of_match = of_match_ptr(#vreg),			\
+		.regulators_node = of_match_ptr("regulators"),		\
 		.ops	= &pm8607_regulator_ops,			\
 		.type	= REGULATOR_VOLTAGE,				\
 		.id	= PM8607_ID_##vreg,				\
@@ -270,6 +274,8 @@ static const struct regulator_ops pm8606_preg_ops = {
 {									\
 	.desc	= {							\
 		.name	= "LDO" #_id,					\
+		.of_match = of_match_ptr("LDO" #_id),			\
+		.regulators_node = of_match_ptr("regulators"),		\
 		.ops	= &pm8607_regulator_ops,			\
 		.type	= REGULATOR_VOLTAGE,				\
 		.id	= PM8607_ID_LDO##_id,				\
@@ -309,36 +315,6 @@ static struct pm8607_regulator_info pm8606_regulator_info[] = {
 	PM8606_PREG(PREREGULATORB, 5),
 };
 
-#ifdef CONFIG_OF
-static int pm8607_regulator_dt_init(struct platform_device *pdev,
-				    struct pm8607_regulator_info *info,
-				    struct regulator_config *config)
-{
-	struct device_node *nproot, *np;
-	nproot = pdev->dev.parent->of_node;
-	if (!nproot)
-		return -ENODEV;
-	nproot = of_get_child_by_name(nproot, "regulators");
-	if (!nproot) {
-		dev_err(&pdev->dev, "failed to find regulators node\n");
-		return -ENODEV;
-	}
-	for_each_child_of_node(nproot, np) {
-		if (of_node_name_eq(np, info->desc.name)) {
-			config->init_data =
-				of_get_regulator_init_data(&pdev->dev, np,
-							   &info->desc);
-			config->of_node = np;
-			break;
-		}
-	}
-	of_node_put(nproot);
-	return 0;
-}
-#else
-#define pm8607_regulator_dt_init(x, y, z)	(-1)
-#endif
-
 static int pm8607_regulator_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
@@ -373,12 +349,11 @@ static int pm8607_regulator_probe(struct platform_device *pdev)
 	if ((i == PM8607_ID_BUCK3) && chip->buck3_double)
 		info->slope_double = 1;
 
-	config.dev = &pdev->dev;
+	config.dev = chip->dev;
 	config.driver_data = info;
 
-	if (pm8607_regulator_dt_init(pdev, info, &config))
-		if (pdata)
-			config.init_data = pdata;
+	if (pdata)
+		config.init_data = pdata;
 
 	if (chip->id == CHIP_PM8607)
 		config.regmap = chip->regmap;
-- 
2.17.1

