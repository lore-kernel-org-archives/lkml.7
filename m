Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A211C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C553C20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="vDgRIj0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfCFBB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:01:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43070 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCFBB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:01:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so7058218pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=wGYUSS81DF+rea0Ig/PCf5BAckfqTQ+VCSd6SKO3JVw=;
        b=vDgRIj0ylcQkfMGHzaYpUXvSSI2IRMqvyoPT+vZ9iKVtJMxxLDRC0GkAPlrZCHeQ39
         n/n/tzhZbkMUJBNOojcURBY8MYFLpKjXEx8DM9usgfPMyfdY77t03WhYWjiLqwT+5oH9
         urcDJQgjIejg6K6bJhNxbmYaoV64XQdKEn5b/65atQKr/SiUGsAhei37qBryI46lQTPd
         MpqQELw+4H7ZIDRJMLj8cc88oe1JP90jbxMm7DoOdjqUQJYG9auGEmX0pWeN8EgiCxMt
         amLrfE7OElryNl8TdgQ4zWHEbqhcuOyx7pUH9km67ARJ+7XsTXSp8BpVYoTVM+D8b9Im
         hiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wGYUSS81DF+rea0Ig/PCf5BAckfqTQ+VCSd6SKO3JVw=;
        b=WxBnoG/l1NGF+zPcPNYOtLvdYDxR1m96TwKttxUwl21qHWhx92yCcQUsfLk+RZsaHV
         4vdP8MC1KsZLfJfeTBrGKLaqeI58jZ1eWaZcu/EW62IB9tKhZGGhII+TL4W3uu5ktn3w
         39Gl/UXHnQcv8j39YTFJRQAPP24DOayut11T9ka8RzloyXC5kdVxmEt9EK6v22p8Q3zK
         osattaGsOjO/v68ju+SqU6MTrddyesjUFoOzTc864uBGDRI8L/6A0xm08/HWAEaMWrOZ
         yvYinKeDQ3Oja9fL45oUqg/cusu++k7vW/gvGbLqE88Fepizg9DrS7qB4obokd8Bsa6O
         7Wag==
X-Gm-Message-State: APjAAAUkfXe1FF0WDQZzboRpEnIv3m63vkX41tnZU3tm9xTSg07cpeCN
        0UhjuvCTypaaZQhMBTSwlfjIHg==
X-Google-Smtp-Source: APXvYqwklCH5DlxNilTujy0ByA4C2Y3BOhAgbSSQBfs9BZmlWoXJe3k12MWwh4kxiFsZAzFF+QdS3w==
X-Received: by 2002:a63:6244:: with SMTP id w65mr3813162pgb.300.1551834086816;
        Tue, 05 Mar 2019 17:01:26 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id g3sm254820pfo.125.2019.03.05.17.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 17:01:25 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: as3711: Remove struct as3711_regulator_info and as3711_regulator
Date:   Wed,  6 Mar 2019 09:01:02 +0800
Message-Id: <20190306010102.30612-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not really need struct as3711_regulator_info and
struct as3711_regulator, remove them.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/as3711-regulator.c | 37 ++++++----------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/as3711-regulator.c b/drivers/regulator/as3711-regulator.c
index f7fe218bb3e4..ece88103f2fd 100644
--- a/drivers/regulator/as3711-regulator.c
+++ b/drivers/regulator/as3711-regulator.c
@@ -17,14 +17,6 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
-struct as3711_regulator_info {
-	struct regulator_desc	desc;
-};
-
-struct as3711_regulator {
-	struct as3711_regulator_info *reg_info;
-};
-
 /*
  * The regulator API supports 4 modes of operataion: FAST, NORMAL, IDLE and
  * STANDBY. We map them in the following way to AS3711 SD1-4 DCDC modes:
@@ -129,7 +121,6 @@ static const struct regulator_linear_range as3711_dldo_ranges[] = {
 
 #define AS3711_REG(_id, _en_reg, _en_bit, _vmask, _sfx)			   \
 	[AS3711_REGULATOR_ ## _id] = {					   \
-	.desc = {							   \
 		.name = "as3711-regulator-" # _id,			   \
 		.id = AS3711_REGULATOR_ ## _id,				   \
 		.n_voltages = (_vmask + 1),				   \
@@ -142,10 +133,9 @@ static const struct regulator_linear_range as3711_dldo_ranges[] = {
 		.enable_mask = BIT(_en_bit),				   \
 		.linear_ranges = as3711_ ## _sfx ## _ranges,		   \
 		.n_linear_ranges = ARRAY_SIZE(as3711_ ## _sfx ## _ranges), \
-	},								   \
 }
 
-static struct as3711_regulator_info as3711_reg_info[] = {
+static const struct regulator_desc as3711_reg_desc[] = {
 	AS3711_REG(SD_1, SD_CONTROL, 0, 0x7f, sd),
 	AS3711_REG(SD_2, SD_CONTROL, 1, 0x7f, sd),
 	AS3711_REG(SD_3, SD_CONTROL, 2, 0x7f, sd),
@@ -161,7 +151,7 @@ static struct as3711_regulator_info as3711_reg_info[] = {
 	/* StepUp output voltage depends on supplying regulator */
 };
 
-#define AS3711_REGULATOR_NUM ARRAY_SIZE(as3711_reg_info)
+#define AS3711_REGULATOR_NUM ARRAY_SIZE(as3711_reg_desc)
 
 static struct of_regulator_match
 as3711_regulator_matches[AS3711_REGULATOR_NUM] = {
@@ -215,11 +205,8 @@ static int as3711_regulator_probe(struct platform_device *pdev)
 	struct as3711_regulator_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct as3711 *as3711 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = {.dev = &pdev->dev,};
-	struct as3711_regulator *reg = NULL;
-	struct as3711_regulator *regs;
 	struct device_node *of_node[AS3711_REGULATOR_NUM] = {};
 	struct regulator_dev *rdev;
-	struct as3711_regulator_info *ri;
 	int ret;
 	int id;
 
@@ -236,30 +223,20 @@ static int as3711_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	regs = devm_kcalloc(&pdev->dev,
-			    AS3711_REGULATOR_NUM,
-			    sizeof(struct as3711_regulator),
-			    GFP_KERNEL);
-	if (!regs)
-		return -ENOMEM;
-
-	for (id = 0, ri = as3711_reg_info; id < AS3711_REGULATOR_NUM; ++id, ri++) {
-		reg = &regs[id];
-		reg->reg_info = ri;
-
+	for (id = 0; id < AS3711_REGULATOR_NUM; id++) {
 		config.init_data = pdata->init_data[id];
-		config.driver_data = reg;
 		config.regmap = as3711->regmap;
 		config.of_node = of_node[id];
 
-		rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
+		rdev = devm_regulator_register(&pdev->dev, &as3711_reg_desc[id],
+					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "Failed to register regulator %s\n",
-				ri->desc.name);
+				as3711_reg_desc[id].name);
 			return PTR_ERR(rdev);
 		}
 	}
-	platform_set_drvdata(pdev, regs);
+
 	return 0;
 }
 
-- 
2.17.1

