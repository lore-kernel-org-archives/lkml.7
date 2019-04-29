Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDEAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EF02075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="LM/r+sFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfD2Lf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:35:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36666 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfD2Lfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:35:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id w20so4332364plq.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7YB68AOn5NlO086Zr2n2AuIrgzE7qSEebzLEMwr/Mk=;
        b=LM/r+sFGgsKryAGtFsIxtUtPJB5QXLuFNsh1YRwOYk5uDk+lxMN1NCHOv8ob44vOGz
         9ZCONldnAs5RCTNY/q5k9VwJ6MVEd+cHqUGy4ko5K/PFUoYoZxto1xh2nxEsQAhrWn4c
         xwZHwBAWE04iWHx7/zEnCk/kpB8EXURgX0s+gQDVI+6LRd/zZSH4ocEo4MfvI8djpUyU
         xLClI36M6rGJS1uOp9UoiVgE55tc7/aV2H/3E7fScvQ1ATisHKkxHg6bvFYYmtjHUPGJ
         3N4GkBHUyiB7i8V71BzEsWZ/SMLmonZn8i6Mp/yr/INoRlvOdL4mwYmv/I/nW/nlK1cM
         oJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7YB68AOn5NlO086Zr2n2AuIrgzE7qSEebzLEMwr/Mk=;
        b=jGtQgt62LAHKIwkRQ3DADwHBgWBs6HXOcjBT7YRC4W+BcswjBeHKqMuRzSqvuOeECt
         qmO0V3Nkrbh2XciOulVAuHygxZtX+jgglyFnusAYzGDihDRCWiU7QMEyFkAXuiApVSbF
         7mowe8OrSs3b4sAqsrMHThnL9Cm7veGWVdmAGbOM8zZoss9G4sk2ef+grxj0vxo+Sdr/
         u33HdHHrxIfDD6WIc/X+VvHlvVsJ4JnUSVUqMQFmEMzi8sztC7zbDshRpYTkmIG1/kLC
         7zD5qdVgwS6Z0Xoc00rYfWMm7hf35IchUm7SdkokFGHDSofHNQ9Zwpk3U90Q33Sgxou0
         G5Hg==
X-Gm-Message-State: APjAAAW6aLuecXhCXnZN9/jv41Q36ca2FxVgWUJHDOGs4RPejizZ0Kyh
        EPw7/SOOneN0Rq//eCCgXZElpg==
X-Google-Smtp-Source: APXvYqx/RNbkMzGYc6AGzgITmL7dguzLosorDprNLnCVtqozhQpm97Lq9l6aGYNBYNtma4+xfrZQBQ==
X-Received: by 2002:a17:902:b197:: with SMTP id s23mr2596099plr.153.1556537753901;
        Mon, 29 Apr 2019 04:35:53 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-181.dynamic-ip.hinet.net. [118.171.142.181])
        by smtp.gmail.com with ESMTPSA id b13sm45058844pfd.12.2019.04.29.04.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 04:35:52 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: vexpress: Get rid of struct vexpress_regulator
Date:   Mon, 29 Apr 2019 19:35:41 +0800
Message-Id: <20190429113542.476-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *regdev and *regmap can be replaced by local variables in probe().
Only desc of struct vexpress_regulator is really need, so just use
struct regulator_desc directly and remove struct vexpress_regulator.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/vexpress-regulator.c | 53 +++++++++++---------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index ca4230fe9e77..a15a1319436a 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -23,17 +23,10 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/vexpress.h>
 
-struct vexpress_regulator {
-	struct regulator_desc desc;
-	struct regulator_dev *regdev;
-	struct regmap *regmap;
-};
-
 static int vexpress_regulator_get_voltage(struct regulator_dev *regdev)
 {
-	struct vexpress_regulator *reg = rdev_get_drvdata(regdev);
-	u32 uV;
-	int err = regmap_read(reg->regmap, 0, &uV);
+	unsigned int uV;
+	int err = regmap_read(regdev->regmap, 0, &uV);
 
 	return err ? err : uV;
 }
@@ -41,9 +34,7 @@ static int vexpress_regulator_get_voltage(struct regulator_dev *regdev)
 static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
 		int min_uV, int max_uV, unsigned *selector)
 {
-	struct vexpress_regulator *reg = rdev_get_drvdata(regdev);
-
-	return regmap_write(reg->regmap, 0, min_uV);
+	return regmap_write(regdev->regmap, 0, min_uV);
 }
 
 static const struct regulator_ops vexpress_regulator_ops_ro = {
@@ -57,44 +48,44 @@ static const struct regulator_ops vexpress_regulator_ops = {
 
 static int vexpress_regulator_probe(struct platform_device *pdev)
 {
-	struct vexpress_regulator *reg;
+	struct regulator_desc *desc;
 	struct regulator_init_data *init_data;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
 
-	reg = devm_kzalloc(&pdev->dev, sizeof(*reg), GFP_KERNEL);
-	if (!reg)
+	desc = devm_kzalloc(&pdev->dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
 		return -ENOMEM;
 
-	reg->regmap = devm_regmap_init_vexpress_config(&pdev->dev);
-	if (IS_ERR(reg->regmap))
-		return PTR_ERR(reg->regmap);
+	regmap = devm_regmap_init_vexpress_config(&pdev->dev);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	reg->desc.name = dev_name(&pdev->dev);
-	reg->desc.type = REGULATOR_VOLTAGE;
-	reg->desc.owner = THIS_MODULE;
-	reg->desc.continuous_voltage_range = true;
+	desc->name = dev_name(&pdev->dev);
+	desc->type = REGULATOR_VOLTAGE;
+	desc->owner = THIS_MODULE;
+	desc->continuous_voltage_range = true;
 
 	init_data = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node,
-					       &reg->desc);
+					       desc);
 	if (!init_data)
 		return -EINVAL;
 
 	init_data->constraints.apply_uV = 0;
 	if (init_data->constraints.min_uV && init_data->constraints.max_uV)
-		reg->desc.ops = &vexpress_regulator_ops;
+		desc->ops = &vexpress_regulator_ops;
 	else
-		reg->desc.ops = &vexpress_regulator_ops_ro;
+		desc->ops = &vexpress_regulator_ops_ro;
 
+	config.regmap = regmap;
 	config.dev = &pdev->dev;
 	config.init_data = init_data;
-	config.driver_data = reg;
 	config.of_node = pdev->dev.of_node;
 
-	reg->regdev = devm_regulator_register(&pdev->dev, &reg->desc, &config);
-	if (IS_ERR(reg->regdev))
-		return PTR_ERR(reg->regdev);
-
-	platform_set_drvdata(pdev, reg);
+	rdev = devm_regulator_register(&pdev->dev, desc, &config);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
 
 	return 0;
 }
-- 
2.20.1

