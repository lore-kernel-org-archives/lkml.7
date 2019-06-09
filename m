Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5E7C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681BC208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 11:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqaWaokA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfFILsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 07:48:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45023 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbfFILsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:48:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id b17so6344449wrq.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FvD92B+Ndby0ykEG5/HzkmJy1kaxK2b4kxErMOiHsbE=;
        b=aqaWaokA5RkmOS1xflD3IlkhPraAXJGTRlr36UZuESYdH8j7jjeALPm5Rsgsu81487
         SDK0a/ELcob4MkYnSVhwcLGHvvRiwPnraQVJONpsG/zSLiK6aFpykfVv5zJ/3fkBkION
         4iQZiPY5DR+UeIjBSNJRiXTrtfjSGvtn5DlpzFXz2+zdanupgN5sZ2VQlA9+vkaGC1rw
         fz2sbUerbH2yeV7ENBmh7/Rkb0EbEnXlCQaeTWK45mSPXZoyJyvpOJ+B9wa4jti/POCr
         nvFfpZdlXMQOZ+jhoVQO5OgityXjHBSifcpjTbeuaYkBxyaOyJEcGgIz9+BT3ry9XhpI
         tgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FvD92B+Ndby0ykEG5/HzkmJy1kaxK2b4kxErMOiHsbE=;
        b=MziKwubIrhirite/JXYHGENayfs/oADbROQMvV2Xqs6/htrxneu4AN3sR2QTpYspH8
         igT1byCExNkJrVk0ivxJjFjdeM0EFk4q7OgFqafHlTZSFETKbe2iLgqFRF6ttklK5Oc6
         wZvNxSO/1YINradwdGJx1/fWOR28wQoEksvio5BJlSzDlN0PleKmo/hYypkB8lYx9faj
         GUX0tpsIZEW+Jaqa0MF5GteYwBMA1SC18bUBxHFW4L99PlbXF1BZ4Zk6Y3GuiQeM2vhB
         1OCDQP28okj59tpOJDY1EkA4iaDgLXVN5/lSbhYQXEcWViThCVNI1zZyILfB1ZqEyQIc
         x7BA==
X-Gm-Message-State: APjAAAUQVN6LO5ctF8HYxDP1YkRRDfeU94qdFTr1SUvlhCvt62tf6Z+o
        YmL1UuDRLawx9VO8Rg07LDx/bSjjn3M=
X-Google-Smtp-Source: APXvYqwQbzuLSQJBPIasLqKEoMgN90WLs20aq8YVXANgY07IPC2vbCWZ0diJq+CGW1vvIiuMuNaRrg==
X-Received: by 2002:adf:f246:: with SMTP id b6mr16789236wrp.92.1560080894068;
        Sun, 09 Jun 2019 04:48:14 -0700 (PDT)
Received: from localhost.localdomain (catv-89-135-96-219.catv.broadband.hu. [89.135.96.219])
        by smtp.gmail.com with ESMTPSA id o15sm9413921wrw.42.2019.06.09.04.48.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 04:48:13 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tfiga@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] regulator: max8952: Convert to use GPIO descriptors
Date:   Sun,  9 Jun 2019 13:48:12 +0200
Message-Id: <20190609114812.28375-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This finalizes the descriptor conversion of the MAX8952 driver
by letting the VID0 and VID1 GPIOs be fetched from descriptors.

Both VID0 and VID1 must be supplied for the VID selection to work,
I add some code to preserve the semantics that if only one of
the two VID gpios is supplied, it will be initialized to low.
This might be a bit overzealous, but I want to preserve any
implicit semantics.

This is currently only used by device tree in-kernel but it is
still also possible to supply the same GPIOs using a machine
descriptor table if a board file is used.

Ideally this should be phased over to using gpio-regulator.c
that does the same thing, but it might require some refactoring
and needs testing on real hardware.

Cc: Tomasz Figa <tfiga@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/max8952.c       | 62 ++++++++++++++-----------------
 include/linux/regulator/max8952.h |  3 --
 2 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index cf2a2912cb1b..7056cb93715b 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -26,11 +26,9 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/max8952.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
@@ -50,7 +48,8 @@ enum {
 struct max8952_data {
 	struct i2c_client	*client;
 	struct max8952_platform_data *pdata;
-
+	struct gpio_desc *vid0_gpiod;
+	struct gpio_desc *vid1_gpiod;
 	bool vid0;
 	bool vid1;
 };
@@ -100,16 +99,15 @@ static int max8952_set_voltage_sel(struct regulator_dev *rdev,
 {
 	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
 
-	if (!gpio_is_valid(max8952->pdata->gpio_vid0) ||
-			!gpio_is_valid(max8952->pdata->gpio_vid1)) {
+	if (!max8952->vid0_gpiod || !max8952->vid1_gpiod) {
 		/* DVS not supported */
 		return -EPERM;
 	}
 
 	max8952->vid0 = selector & 0x1;
 	max8952->vid1 = (selector >> 1) & 0x1;
-	gpio_set_value(max8952->pdata->gpio_vid0, max8952->vid0);
-	gpio_set_value(max8952->pdata->gpio_vid1, max8952->vid1);
+	gpiod_set_value(max8952->vid0_gpiod, max8952->vid0);
+	gpiod_set_value(max8952->vid1_gpiod, max8952->vid1);
 
 	return 0;
 }
@@ -147,9 +145,6 @@ static struct max8952_platform_data *max8952_parse_dt(struct device *dev)
 	if (!pd)
 		return NULL;
 
-	pd->gpio_vid0 = of_get_named_gpio(np, "max8952,vid-gpios", 0);
-	pd->gpio_vid1 = of_get_named_gpio(np, "max8952,vid-gpios", 1);
-
 	if (of_property_read_u32(np, "max8952,default-mode", &pd->default_mode))
 		dev_warn(dev, "Default mode not specified, assuming 0\n");
 
@@ -200,7 +195,7 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	struct gpio_desc *gpiod;
 	enum gpiod_flags gflags;
 
-	int ret = 0, err = 0;
+	int ret = 0;
 
 	if (client->dev.of_node)
 		pdata = max8952_parse_dt(&client->dev);
@@ -253,32 +248,31 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	max8952->vid0 = pdata->default_mode & 0x1;
 	max8952->vid1 = (pdata->default_mode >> 1) & 0x1;
 
-	if (gpio_is_valid(pdata->gpio_vid0) &&
-			gpio_is_valid(pdata->gpio_vid1)) {
-		unsigned long gpio_flags;
-
-		gpio_flags = max8952->vid0 ?
-			     GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
-		if (devm_gpio_request_one(&client->dev, pdata->gpio_vid0,
-					  gpio_flags, "MAX8952 VID0"))
-			err = 1;
-
-		gpio_flags = max8952->vid1 ?
-			     GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
-		if (devm_gpio_request_one(&client->dev, pdata->gpio_vid1,
-					  gpio_flags, "MAX8952 VID1"))
-			err = 2;
-	} else
-		err = 3;
-
-	if (err) {
+	/* Fetch vid0 and vid1 GPIOs if available */
+	gflags = max8952->vid0 ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	max8952->vid0_gpiod = devm_gpiod_get_index_optional(&client->dev,
+							    "max8952,vid",
+							    0, gflags);
+	if (IS_ERR(max8952->vid0_gpiod))
+		return PTR_ERR(max8952->vid0_gpiod);
+	gflags = max8952->vid1 ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	max8952->vid1_gpiod = devm_gpiod_get_index_optional(&client->dev,
+							    "max8952,vid",
+							    1, gflags);
+	if (IS_ERR(max8952->vid1_gpiod))
+		return PTR_ERR(max8952->vid1_gpiod);
+
+	/* If either VID GPIO is missing just disable this */
+	if (!max8952->vid0_gpiod || !max8952->vid1_gpiod) {
 		dev_warn(&client->dev, "VID0/1 gpio invalid: "
-				"DVS not available.\n");
+			 "DVS not available.\n");
 		max8952->vid0 = 0;
 		max8952->vid1 = 0;
-		/* Mark invalid */
-		pdata->gpio_vid0 = -1;
-		pdata->gpio_vid1 = -1;
+		/* Make sure if we have any descriptors they get set to low */
+		if (max8952->vid0_gpiod)
+			gpiod_set_value(max8952->vid0_gpiod, 0);
+		if (max8952->vid1_gpiod)
+			gpiod_set_value(max8952->vid1_gpiod, 0);
 
 		/* Disable Pulldown of EN only */
 		max8952_write_reg(max8952, MAX8952_REG_CONTROL, 0x60);
diff --git a/include/linux/regulator/max8952.h b/include/linux/regulator/max8952.h
index 686c42c041b5..33b6e2c09c05 100644
--- a/include/linux/regulator/max8952.h
+++ b/include/linux/regulator/max8952.h
@@ -118,9 +118,6 @@ enum {
 #define MAX8952_NUM_DVS_MODE	4
 
 struct max8952_platform_data {
-	int gpio_vid0;
-	int gpio_vid1;
-
 	u32 default_mode;
 	u32 dvs_mode[MAX8952_NUM_DVS_MODE]; /* MAX8952_DVS_MODEx_XXXXmV */
 
-- 
2.20.1

