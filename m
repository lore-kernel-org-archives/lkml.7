Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD3C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B30208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="JUgi6oJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfDTDBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:01:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35654 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDTDBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:01:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so3341558plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 20:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Rg+mXht3mS9wGTPPKm62qjSe+aRN/k0EU2A/VE8bfgc=;
        b=JUgi6oJes2S8O9BqGD7Oene41DccQD3ZfTtxTlsLMrUMGbhM4I9JH9HKEv97KnxkbM
         JCQdj/bn1F5JchXdcYLzlsz3zXc+A/UddKzbgkkMZpPRczJae4Mcmjjsofvj7EPY1e1w
         RqXujb29QQn1S257B9uxXhdZoZxIMiY8Dw6CPwDE4bk+3UErnS44sVfPDZHxEjboFnI3
         RPNLqZSEc/k3Vl8tcBOk8q3MIKW8+A0UfnVlI3JdExvgdY95y4Tc+vkorSEXeJCB3IPb
         vbr95l0tqMuzSFx6o+XwlAa+TVKFZocfUtzbU7rxUPuGN543KwdRvwqDlTy4Kftm9QuK
         X/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rg+mXht3mS9wGTPPKm62qjSe+aRN/k0EU2A/VE8bfgc=;
        b=VG1nXJ4w/fDvC8OetU6dR0b6xPJk6SzoVRKa2B7lOalMYceOJrb8WFbkN3UGY1aT6c
         yn+pmbzOB6d7GVBxzI2mphNFWW4sIzJvod1jlNIHgUZS7BME3Gun1HYW0wpHqvH3jI1D
         GKjTav9Qzu3KfODKOQTYOm1fVw4hNgqhKH3seucvT6bLOzITAUeA/kc0KLTqTE6rUnQX
         nThKQ6aHEwD9XJOxLruRVs1GfzfPUyf2Tvo6YrzZDDZF78wL4UMmBukEJWZwxfDmJuzc
         GYof3IThROw5k66gWTIrRsCN8oJ2/JABvMR0rs2mnUaEzd/Lg6uA9dJ0Sye2xCUP5UKM
         V20Q==
X-Gm-Message-State: APjAAAWl2zXSLU/I66P83UoZeIhkf8WH9n7/xZhUsittuty1KWW40xT5
        ISXGV3sxZOMYY3V7SFBKvGjFJg==
X-Google-Smtp-Source: APXvYqxXC5kv/3SsIJbrWIIuIs0YR05NsVsqEPSbQlunJzFQEQS3BTvOpFsSQlrBpmSXoSZ0Kec/Ng==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr7277964pld.204.1555729297416;
        Fri, 19 Apr 2019 20:01:37 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id q128sm8662951pga.60.2019.04.19.20.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 20:01:36 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: sy8106a: Get rid of struct sy8106a
Date:   Sat, 20 Apr 2019 11:01:25 +0800
Message-Id: <20190420030125.6661-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the fields in struct sy8106a are only used in sy8106a_i2c_probe(), so
use local variables instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/sy8106a-regulator.c | 40 +++++++++------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
index 65fbd1f0b612..42e03b2c10a0 100644
--- a/drivers/regulator/sy8106a-regulator.c
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -22,12 +22,6 @@
  */
 #define SY8106A_GO_BIT			BIT(7)
 
-struct sy8106a {
-	struct regulator_dev *rdev;
-	struct regmap *regmap;
-	u32 fixed_voltage;
-};
-
 static const struct regmap_config sy8106a_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -70,36 +64,32 @@ static const struct regulator_desc sy8106a_reg = {
 static int sy8106a_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct sy8106a *chip;
 	struct device *dev = &i2c->dev;
-	struct regulator_dev *rdev = NULL;
+	struct regulator_dev *rdev;
 	struct regulator_config config = { };
+	struct regmap *regmap;
 	unsigned int reg, vsel;
+	u32 fixed_voltage;
 	int error;
 
-	chip = devm_kzalloc(&i2c->dev, sizeof(struct sy8106a), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
 	error = of_property_read_u32(dev->of_node, "silergy,fixed-microvolt",
-				     &chip->fixed_voltage);
+				     &fixed_voltage);
 	if (error)
 		return error;
 
-	if (chip->fixed_voltage < SY8106A_MIN_MV * 1000 ||
-	    chip->fixed_voltage > SY8106A_MAX_MV * 1000)
+	if (fixed_voltage < SY8106A_MIN_MV * 1000 ||
+	    fixed_voltage > SY8106A_MAX_MV * 1000)
 		return -EINVAL;
 
-	chip->regmap = devm_regmap_init_i2c(i2c, &sy8106a_regmap_config);
-	if (IS_ERR(chip->regmap)) {
-		error = PTR_ERR(chip->regmap);
+	regmap = devm_regmap_init_i2c(i2c, &sy8106a_regmap_config);
+	if (IS_ERR(regmap)) {
+		error = PTR_ERR(regmap);
 		dev_err(dev, "Failed to allocate register map: %d\n", error);
 		return error;
 	}
 
 	config.dev = &i2c->dev;
-	config.regmap = chip->regmap;
-	config.driver_data = chip;
+	config.regmap = regmap;
 
 	config.of_node = dev->of_node;
 	config.init_data = of_get_regulator_init_data(dev, dev->of_node,
@@ -109,15 +99,15 @@ static int sy8106a_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	/* Ensure GO_BIT is enabled when probing */
-	error = regmap_read(chip->regmap, SY8106A_REG_VOUT1_SEL, &reg);
+	error = regmap_read(regmap, SY8106A_REG_VOUT1_SEL, &reg);
 	if (error)
 		return error;
 
 	if (!(reg & SY8106A_GO_BIT)) {
-		vsel = (chip->fixed_voltage / 1000 - SY8106A_MIN_MV) /
+		vsel = (fixed_voltage / 1000 - SY8106A_MIN_MV) /
 		       SY8106A_STEP_MV;
 
-		error = regmap_write(chip->regmap, SY8106A_REG_VOUT1_SEL,
+		error = regmap_write(regmap, SY8106A_REG_VOUT1_SEL,
 				     vsel | SY8106A_GO_BIT);
 		if (error)
 			return error;
@@ -131,10 +121,6 @@ static int sy8106a_i2c_probe(struct i2c_client *i2c,
 		return error;
 	}
 
-	chip->rdev = rdev;
-
-	i2c_set_clientdata(i2c, chip);
-
 	return 0;
 }
 
-- 
2.17.1

