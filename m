Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52098C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F35208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfG3RaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:30:14 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:33247 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730828AbfG3RaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:30:14 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsVwv-000A0W-U5; Tue, 30 Jul 2019 19:30:09 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hsVwv-000BNr-Oh; Tue, 30 Jul 2019 19:30:09 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>
Subject: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to fixed-regulator
Date:   Tue, 30 Jul 2019 19:30:04 +0200
Message-Id: <20190730173006.15823-2-dev@pschenker.ch>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730173006.15823-1-dev@pschenker.ch>
References: <20190730173006.15823-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This adds the possibility to enable a fixed-regulator with a clock.

Signed-off-by: <philippe.schenker@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/regulator/core.c         | 15 +++++++++++++++
 drivers/regulator/fixed.c        |  6 ++++++
 include/linux/regulator/driver.h |  3 +++
 include/linux/regulator/fixed.h  |  1 +
 4 files changed, 25 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e0c0cf462004..f16f6c147858 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -26,6 +26,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/module.h>
+#include <linux/clk.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/regulator.h>
@@ -2385,6 +2386,11 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		ret = rdev->desc->ops->enable(rdev);
 		if (ret < 0)
 			return ret;
+	} else if (rdev->ena_clk) {
+		ret = clk_prepare_enable(rdev->ena_clk);
+		if (ret)
+			return ret;
+		rdev->ena_clk_state++;
 	} else {
 		return -EINVAL;
 	}
@@ -2565,6 +2571,9 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 		ret = rdev->desc->ops->disable(rdev);
 		if (ret != 0)
 			return ret;
+	} else if (rdev->ena_clk) {
+		clk_disable_unprepare(rdev->ena_clk);
+		rdev->ena_clk_state--;
 	}
 
 	/* cares about last_off_jiffy only if off_on_delay is required by
@@ -2796,6 +2805,9 @@ static int _regulator_is_enabled(struct regulator_dev *rdev)
 	if (rdev->ena_pin)
 		return rdev->ena_gpio_state;
 
+	if (rdev->ena_clk)
+		return (rdev->ena_clk_state > 0) ? 1 : 0;
+
 	/* If we don't know then assume that the regulator is always on */
 	if (!rdev->desc->ops->is_enabled)
 		return 1;
@@ -5098,6 +5110,9 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		dangling_of_gpiod = false;
 	}
 
+	if (cfg->ena_clk)
+		rdev->ena_clk = cfg->ena_clk;
+
 	/* register with sysfs */
 	rdev->dev.class = &regulator_class;
 	rdev->dev.parent = dev;
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 999547dde99d..0093c26cda3c 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
+#include <linux/clk.h>
 
 struct fixed_voltage_data {
 	struct regulator_desc desc;
@@ -78,6 +79,10 @@ of_get_fixed_voltage_config(struct device *dev,
 	if (of_find_property(np, "vin-supply", NULL))
 		config->input_supply = "vin";
 
+	config->ena_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(config->ena_clk))
+		config->ena_clk = NULL;
+
 	return config;
 }
 
@@ -172,6 +177,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	cfg.init_data = config->init_data;
 	cfg.driver_data = drvdata;
 	cfg.of_node = pdev->dev.of_node;
+	cfg.ena_clk = config->ena_clk;
 
 	drvdata->dev = devm_regulator_register(&pdev->dev, &drvdata->desc,
 					       &cfg);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 9a911bb5fb61..335ac1272bbd 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -414,6 +414,7 @@ struct regulator_config {
 	void *driver_data;
 	struct device_node *of_node;
 	struct regmap *regmap;
+	struct clk *ena_clk;
 
 	struct gpio_desc *ena_gpiod;
 };
@@ -477,6 +478,8 @@ struct regulator_dev {
 
 	struct regulator_enable_gpio *ena_pin;
 	unsigned int ena_gpio_state:1;
+	struct clk *ena_clk;
+	unsigned int ena_clk_state;
 
 	unsigned int is_switch:1;
 
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index d44ce5f18a56..c291e1130381 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -38,6 +38,7 @@ struct fixed_voltage_config {
 	unsigned startup_delay;
 	unsigned enabled_at_boot:1;
 	struct regulator_init_data *init_data;
+	struct clk *ena_clk;
 };
 
 struct regulator_consumer_supply;
-- 
2.22.0

