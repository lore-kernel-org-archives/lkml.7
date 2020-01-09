Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BE2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF60206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="ZtDK2xS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbgAIP6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:58:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36208 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgAIP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:58:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so2728941plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BPTWduUiPpkQQz/NLnoJepM5qt0upnnqyEmWlEz6Zw=;
        b=ZtDK2xS8AoS9XCFqm1RWHqiGOlZD+OLGo25neoMlK7bMy6BojuME0LAWffFp668Jhl
         66T8KqzghdDIzdnP0KyH5S6PcfZAom9nQQAoX2XBTtOItSkxu60EdJ1QSoqdcOt9LsIo
         kSCCgzsGzKQ+1id1W3DgrCLBeoI75zUwV1fH5cFSM+/655ID2uQMFdhurEQyqocMLFGH
         OIUYoFoRSI0L+VLwpOj0hiS+inFTu5pwmDKALnji+tG9K7HnZAL6uTuEzR7mN7jl3t34
         RK3ObG77LaANQO33heRbfgriEQ5D2rUUlRw73NAoUC7B8/flKnjVdIYvk74g87Qb1W5U
         Qmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BPTWduUiPpkQQz/NLnoJepM5qt0upnnqyEmWlEz6Zw=;
        b=ZrRVtVtEVQ+7NoFTK4digseMEnbi0f+j6VV1yf82rnbfDR5tRwoXpQGeg1nDQLyUVD
         LJfKw5M1vG8cykmT2TUMHnVMD7TmVy8Yzw5gXf+Xrb0yEQzfJdzSdC1p4A9E/DONOVf5
         XNqllEJEUlpHVg8RS1v7jmYRY9nGqi+tw1R5XdDsx660pGytd0Cu71G4Bhg+Opczo7Ax
         KHdGQaYkfBsjXJb7RFfr/kccvU67lRMfYFG0OKDylJSMdG0phv34nZ000bKfR+Sq8bXS
         4jr7mvvphaOv4KUhN4BLlyHhREJsWvbTINTO2lFhLC/el8M8JAcva9okXPBcO7YccPVC
         tW4w==
X-Gm-Message-State: APjAAAXFImycmC6gP23fUIgoRHaxKzLLxQ9qBRvkDlEeEysqi4FETbkI
        aBs4uuU8tk84ZjhsRyoyfGlR7Q==
X-Google-Smtp-Source: APXvYqw0qdK69XEufBzrUzJvuUnIqppzgCrMgNnQeOirCn+Ne1+94m6FMrm8dXVvmtXlXpsWF2fp6w==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr12522965pls.285.1578585500520;
        Thu, 09 Jan 2020 07:58:20 -0800 (PST)
Received: from localhost.localdomain (118-171-129-36.dynamic-ip.hinet.net. [118.171.129.36])
        by smtp.gmail.com with ESMTPSA id y20sm8509051pfe.107.2020.01.09.07.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:58:19 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: Convert i2c drivers to use .probe_new
Date:   Thu,  9 Jan 2020 23:58:08 +0800
Message-Id: <20200109155808.22003-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new .probe_new for i2c drivers.
These drivers do not use const struct i2c_device_id * argument, so convert
them to utilise the simplified i2c driver registration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This conversion is pretty trivial, so I think it should be fine in single commit.

 drivers/regulator/da9210-regulator.c   | 5 ++---
 drivers/regulator/da9211-regulator.c   | 5 ++---
 drivers/regulator/isl9305.c            | 5 ++---
 drivers/regulator/lp3971.c             | 5 ++---
 drivers/regulator/ltc3676.c            | 5 ++---
 drivers/regulator/mt6311-regulator.c   | 5 ++---
 drivers/regulator/pv88060-regulator.c  | 5 ++---
 drivers/regulator/pv88090-regulator.c  | 5 ++---
 drivers/regulator/slg51000-regulator.c | 5 ++---
 drivers/regulator/sy8106a-regulator.c  | 5 ++---
 drivers/regulator/sy8824x.c            | 5 ++---
 drivers/regulator/tps65132-regulator.c | 5 ++---
 12 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index f9448ed50e05..0cdeb6186529 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -131,8 +131,7 @@ static const struct of_device_id da9210_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, da9210_dt_ids);
 
-static int da9210_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int da9210_i2c_probe(struct i2c_client *i2c)
 {
 	struct da9210 *chip;
 	struct device *dev = &i2c->dev;
@@ -228,7 +227,7 @@ static struct i2c_driver da9210_regulator_driver = {
 		.name = "da9210",
 		.of_match_table = of_match_ptr(da9210_dt_ids),
 	},
-	.probe = da9210_i2c_probe,
+	.probe_new = da9210_i2c_probe,
 	.id_table = da9210_i2c_id,
 };
 
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 523dc1b95826..2ea4362ffa5c 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -416,8 +416,7 @@ static int da9211_regulator_init(struct da9211 *chip)
 /*
  * I2C driver interface functions
  */
-static int da9211_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int da9211_i2c_probe(struct i2c_client *i2c)
 {
 	struct da9211 *chip;
 	int error, ret;
@@ -526,7 +525,7 @@ static struct i2c_driver da9211_regulator_driver = {
 		.name = "da9211",
 		.of_match_table = of_match_ptr(da9211_dt_ids),
 	},
-	.probe = da9211_i2c_probe,
+	.probe_new = da9211_i2c_probe,
 	.id_table = da9211_i2c_id,
 };
 
diff --git a/drivers/regulator/isl9305.c b/drivers/regulator/isl9305.c
index 978f5e903cae..cfb765986d0d 100644
--- a/drivers/regulator/isl9305.c
+++ b/drivers/regulator/isl9305.c
@@ -137,8 +137,7 @@ static const struct regmap_config isl9305_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int isl9305_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int isl9305_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_config config = { };
 	struct isl9305_pdata *pdata = i2c->dev.platform_data;
@@ -198,7 +197,7 @@ static struct i2c_driver isl9305_regulator_driver = {
 		.name = "isl9305",
 		.of_match_table	= of_match_ptr(isl9305_dt_ids),
 	},
-	.probe = isl9305_i2c_probe,
+	.probe_new = isl9305_i2c_probe,
 	.id_table = isl9305_i2c_id,
 };
 
diff --git a/drivers/regulator/lp3971.c b/drivers/regulator/lp3971.c
index bc96e65ef7c0..8be252f81b09 100644
--- a/drivers/regulator/lp3971.c
+++ b/drivers/regulator/lp3971.c
@@ -400,8 +400,7 @@ static int setup_regulators(struct lp3971 *lp3971,
 	return 0;
 }
 
-static int lp3971_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int lp3971_i2c_probe(struct i2c_client *i2c)
 {
 	struct lp3971 *lp3971;
 	struct lp3971_platform_data *pdata = dev_get_platdata(&i2c->dev);
@@ -449,7 +448,7 @@ static struct i2c_driver lp3971_i2c_driver = {
 	.driver = {
 		.name = "LP3971",
 	},
-	.probe    = lp3971_i2c_probe,
+	.probe_new = lp3971_i2c_probe,
 	.id_table = lp3971_i2c_id,
 };
 
diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index d934540eb8c4..e12e52c69e52 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -301,8 +301,7 @@ static irqreturn_t ltc3676_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int ltc3676_regulator_probe(struct i2c_client *client,
-				    const struct i2c_device_id *id)
+static int ltc3676_regulator_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct regulator_init_data *init_data = dev_get_platdata(dev);
@@ -380,7 +379,7 @@ static struct i2c_driver ltc3676_driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(ltc3676_of_match),
 	},
-	.probe = ltc3676_regulator_probe,
+	.probe_new = ltc3676_regulator_probe,
 	.id_table = ltc3676_i2c_id,
 };
 module_i2c_driver(ltc3676_driver);
diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index af95449d3590..69e6af3cd505 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -85,8 +85,7 @@ static const struct regulator_desc mt6311_regulators[] = {
 /*
  * I2C driver interface functions
  */
-static int mt6311_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int mt6311_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -154,7 +153,7 @@ static struct i2c_driver mt6311_regulator_driver = {
 		.name = "mt6311",
 		.of_match_table = of_match_ptr(mt6311_dt_ids),
 	},
-	.probe = mt6311_i2c_probe,
+	.probe_new = mt6311_i2c_probe,
 	.id_table = mt6311_i2c_id,
 };
 
diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 3d3415839ba2..787ced918372 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -279,8 +279,7 @@ static irqreturn_t pv88060_irq_handler(int irq, void *data)
 /*
  * I2C driver interface functions
  */
-static int pv88060_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int pv88060_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_init_data *init_data = dev_get_platdata(&i2c->dev);
 	struct pv88060 *chip;
@@ -385,7 +384,7 @@ static struct i2c_driver pv88060_regulator_driver = {
 		.name = "pv88060",
 		.of_match_table = of_match_ptr(pv88060_dt_ids),
 	},
-	.probe = pv88060_i2c_probe,
+	.probe_new = pv88060_i2c_probe,
 	.id_table = pv88060_i2c_id,
 };
 
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index b1d0d97ae935..784729ec2182 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -272,8 +272,7 @@ static irqreturn_t pv88090_irq_handler(int irq, void *data)
 /*
  * I2C driver interface functions
  */
-static int pv88090_i2c_probe(struct i2c_client *i2c,
-		const struct i2c_device_id *id)
+static int pv88090_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_init_data *init_data = dev_get_platdata(&i2c->dev);
 	struct pv88090 *chip;
@@ -406,7 +405,7 @@ static struct i2c_driver pv88090_regulator_driver = {
 		.name = "pv88090",
 		.of_match_table = of_match_ptr(pv88090_dt_ids),
 	},
-	.probe = pv88090_i2c_probe,
+	.probe_new = pv88090_i2c_probe,
 	.id_table = pv88090_i2c_id,
 };
 
diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index bf1a3508ebc4..44e4cecbf6de 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -439,8 +439,7 @@ static void slg51000_clear_fault_log(struct slg51000 *chip)
 		dev_dbg(chip->dev, "Fault log: FLT_POR\n");
 }
 
-static int slg51000_i2c_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static int slg51000_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct slg51000 *chip;
@@ -509,7 +508,7 @@ static struct i2c_driver slg51000_regulator_driver = {
 	.driver = {
 		.name = "slg51000-regulator",
 	},
-	.probe = slg51000_i2c_probe,
+	.probe_new = slg51000_i2c_probe,
 	.id_table = slg51000_i2c_id,
 };
 
diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
index 42e03b2c10a0..2222e739e62b 100644
--- a/drivers/regulator/sy8106a-regulator.c
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -61,8 +61,7 @@ static const struct regulator_desc sy8106a_reg = {
 /*
  * I2C driver interface functions
  */
-static int sy8106a_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int sy8106a_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct regulator_dev *rdev;
@@ -141,7 +140,7 @@ static struct i2c_driver sy8106a_regulator_driver = {
 		.name = "sy8106a",
 		.of_match_table	= of_match_ptr(sy8106a_i2c_of_match),
 	},
-	.probe = sy8106a_i2c_probe,
+	.probe_new = sy8106a_i2c_probe,
 	.id_table = sy8106a_i2c_id,
 };
 
diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 92adb4f3ee19..62d243f3b904 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -112,8 +112,7 @@ static const struct regmap_config sy8824_regmap_config = {
 	.val_bits = 8,
 };
 
-static int sy8824_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int sy8824_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
@@ -222,7 +221,7 @@ static struct i2c_driver sy8824_regulator_driver = {
 		.name = "sy8824-regulator",
 		.of_match_table = of_match_ptr(sy8824_dt_ids),
 	},
-	.probe = sy8824_i2c_probe,
+	.probe_new = sy8824_i2c_probe,
 	.id_table = sy8824_id,
 };
 module_i2c_driver(sy8824_regulator_driver);
diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 7b0e38f8d627..0edc83089ba2 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -220,8 +220,7 @@ static const struct regmap_config tps65132_regmap_config = {
 	.wr_table	= &tps65132_no_reg_table,
 };
 
-static int tps65132_probe(struct i2c_client *client,
-			  const struct i2c_device_id *client_id)
+static int tps65132_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct tps65132_regulator *tps;
@@ -272,7 +271,7 @@ static struct i2c_driver tps65132_i2c_driver = {
 	.driver = {
 		.name = "tps65132",
 	},
-	.probe = tps65132_probe,
+	.probe_new = tps65132_probe,
 	.id_table = tps65132_id,
 };
 
-- 
2.20.1

