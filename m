Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3942C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6029321721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxDmusP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDMI2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34970 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDMI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so6297243pgf.2;
        Sat, 13 Apr 2019 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQsMyf2shuQSAx8n91J8E24JrnB+zd/uMtPnxsTdOq8=;
        b=lxDmusP1U8w5ZTqrkePZm9h32buBQyCWF1N6BAoQGtj1E/YlJyvKPxrTpT1Po99GWf
         rdBn6coSTIZfuZiectGs2oi0tieGaXDyZOJjWB6nBhptijwv3qRczVxoJGQ0nlozUqOV
         f4haTqwZkQeIwy5zBCdoEIOG9tSfjQr6hPuGFgx2Ok/Tw61vbw3+t3JeB/2USwtWAjgY
         Pg7a9Lk0UJjjiQqVHxUsUSCRLJ2KJPNG4vgGGW7SHatZTcN81QYAmsg28ejg11XCqvFS
         CJCOi3VfJTKFyluUHqrqZCuzxMMm0e0eqr9mtqEFwYUlggR/Ah/htYuwwMUfvtcBvVNM
         ryOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQsMyf2shuQSAx8n91J8E24JrnB+zd/uMtPnxsTdOq8=;
        b=WqPEioDWCnNGBCpCRYa9tzZxy9aNGfb3+lH6vgXWpCV12RLpneqF7mO5PGNB92lL99
         cfEEWB+LGWnfumb4tf3+HlxcQ0g6tw6tcQfD8TZLgEcrXcd9pae1eLaAQjLK8EfroVLd
         VFZV5X/CB/q0cSokLKGRXCudMgKnivbX0NNxK//19gSlCjjgmkzfADQi0j4lZYHKwdUy
         1TMh7WKfSSZo/Jd9I0+xXOoCWVObbFqgaZOD3nUSxMgS64Wy/qooVLMmN9vAkmg2eyEH
         y/XXSZiglQSPqQmyCIYvSrLbU+OSTZFScIE0pXFAD53j9+7cSZIRuLZTO646cWIAavWm
         m+DA==
X-Gm-Message-State: APjAAAUc5ytsVXdmlluzxUPE7Psv/t6BTGj8C3kUSoKCLKKc3s1Pjt+H
        vi6qyz5kvNCSMrAjohgeIvCZLliE
X-Google-Smtp-Source: APXvYqyk8xiXzX/M3wCyHQuzQdu+I2DPVOgZd+fQBElew/piugNf/Q3oWdN22RQI4KjFmpKKAdhi5w==
X-Received: by 2002:a63:4558:: with SMTP id u24mr35569703pgk.225.1555144095643;
        Sat, 13 Apr 2019 01:28:15 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:14 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/12] thermal: qoriq: Convert driver to use regmap API
Date:   Sat, 13 Apr 2019 01:27:44 -0700
Message-Id: <20190413082748.29990-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use regmap API, drop custom LE/BE IO helpers and
simplify bit manipulation using regmap_update_bits(). This also allows
us to convert some register initialization to use loops and adds
convenient debug access to TMU registers via debugfs.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 159 +++++++++++++++-----------------
 1 file changed, 74 insertions(+), 85 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 64cad6d4c1d7..9774323a17bf 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
@@ -17,75 +18,37 @@
 /*
  * QorIQ TMU Registers
  */
-struct qoriq_tmu_site_regs {
-	u32 tritsr;		/* Immediate Temperature Site Register */
-	u32 tratsr;		/* Average Temperature Site Register */
-	u8 res0[0x8];
-};
 
-struct qoriq_tmu_regs {
-	u32 tmr;		/* Mode Register */
+#define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
-	u32 tsr;		/* Status Register */
-	u32 tmtmir;		/* Temperature measurement interval Register */
+
+#define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
-	u8 res0[0x14];
-	u32 tier;		/* Interrupt Enable Register */
+
+#define REGS_TIER	0x020	/* Interrupt Enable Register */
 #define TIER_DISABLE	0x0
-	u32 tidr;		/* Interrupt Detect Register */
-	u32 tiscr;		/* Interrupt Site Capture Register */
-	u32 ticscr;		/* Interrupt Critical Site Capture Register */
-	u8 res1[0x10];
-	u32 tmhtcrh;		/* High Temperature Capture Register */
-	u32 tmhtcrl;		/* Low Temperature Capture Register */
-	u8 res2[0x8];
-	u32 tmhtitr;		/* High Temperature Immediate Threshold */
-	u32 tmhtatr;		/* High Temperature Average Threshold */
-	u32 tmhtactr;	/* High Temperature Average Crit Threshold */
-	u8 res3[0x24];
-	u32 ttcfgr;		/* Temperature Configuration Register */
-	u32 tscfgr;		/* Sensor Configuration Register */
-	u8 res4[0x78];
-	struct qoriq_tmu_site_regs site[SITES_MAX];
-	u8 res5[0x9f8];
-	u32 ipbrr0;		/* IP Block Revision Register 0 */
-	u32 ipbrr1;		/* IP Block Revision Register 1 */
-	u8 res6[0x310];
-	u32 ttr0cr;		/* Temperature Range 0 Control Register */
-	u32 ttr1cr;		/* Temperature Range 1 Control Register */
-	u32 ttr2cr;		/* Temperature Range 2 Control Register */
-	u32 ttr3cr;		/* Temperature Range 3 Control Register */
-};
 
+#define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
+#define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
+
+#define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
+					    * Site Register
+					    */
+#define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
+					   * Control Register
+					   */
 struct qoriq_tmu_data {
-	struct qoriq_tmu_regs __iomem *regs;
-	bool little_endian;
+	struct regmap *regmap;
 };
 
-static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
-{
-	if (p->little_endian)
-		iowrite32(val, addr);
-	else
-		iowrite32be(val, addr);
-}
-
-static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
-{
-	if (p->little_endian)
-		return ioread32(addr);
-	else
-		return ioread32be(addr);
-}
-
 static int tmu_get_temp(int id, void *p, int *temp)
 {
 	struct qoriq_tmu_data *qdata = p;
 	u32 val;
 
-	val = tmu_read(qdata, &qdata->regs->site[id].tritsr);
+	regmap_read(qdata->regmap, REGS_TRITSR(id), &val);
 	*temp = (val & 0xff) * 1000;
 
 	return 0;
@@ -117,7 +80,8 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 	/* Enable monitoring */
 	if (sites != 0)
-		tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
+		regmap_write(qdata->regmap, REGS_TMR,
+			     sites | TMR_ME | TMR_ALPF);
 
 	return 0;
 }
@@ -136,10 +100,8 @@ static int qoriq_tmu_calibration(struct device *dev,
 	}
 
 	/* Init temperature range registers */
-	tmu_write(data, range[0], &data->regs->ttr0cr);
-	tmu_write(data, range[1], &data->regs->ttr1cr);
-	tmu_write(data, range[2], &data->regs->ttr2cr);
-	tmu_write(data, range[3], &data->regs->ttr3cr);
+	for (i = 0; i < ARRAY_SIZE(range); i++)
+		regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
@@ -149,9 +111,9 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	for (i = 0; i < len; i += 8, calibration += 2) {
 		val = of_read_number(calibration, 1);
-		tmu_write(data, val, &data->regs->ttcfgr);
+		regmap_write(data->regmap, REGS_TTCFGR, val);
 		val = of_read_number(calibration + 1, 1);
-		tmu_write(data, val, &data->regs->tscfgr);
+		regmap_write(data->regmap, REGS_TSCFGR, val);
 	}
 
 	return 0;
@@ -160,15 +122,32 @@ static int qoriq_tmu_calibration(struct device *dev,
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
 	/* Disable interrupt, using polling instead */
-	tmu_write(data, TIER_DISABLE, &data->regs->tier);
+	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
 	/* Set update_interval */
-	tmu_write(data, TMTMIR_DEFAULT, &data->regs->tmtmir);
+	regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 
 	/* Disable monitoring */
-	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
+	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
 
+static const struct regmap_range qoriq_yes_ranges[] = {
+	regmap_reg_range(REGS_TMR, REGS_TSCFGR),
+	regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
+	/* Read only registers below */
+	regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
+};
+
+static const struct regmap_access_table qoriq_wr_table = {
+	.yes_ranges	= qoriq_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(qoriq_yes_ranges) - 1,
+};
+
+static const struct regmap_access_table qoriq_rd_table = {
+	.yes_ranges	= qoriq_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(qoriq_yes_ranges),
+};
+
 static int qoriq_tmu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -176,26 +155,44 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct resource *io;
+	const bool little_endian = of_property_read_bool(np, "little-endian");
+	const enum regmap_endian format_endian =
+		little_endian ? REGMAP_ENDIAN_LITTLE : REGMAP_ENDIAN_BIG;
+	const struct regmap_config regmap_config = {
+		.reg_bits		= 32,
+		.val_bits		= 32,
+		.reg_stride		= 4,
+		.rd_table		= &qoriq_rd_table,
+		.wr_table		= &qoriq_wr_table,
+		.val_format_endian	= format_endian,
+		.max_register		= SZ_4K,
+	};
+	void __iomem *base;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->little_endian = of_property_read_bool(np, "little-endian");
-
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
 		dev_err(dev, "Failed to get memory region\n");
 		return -ENODEV;
 	}
 
-	data->regs = devm_ioremap(dev, io->start, resource_size(io));
-	if (!data->regs) {
+	base = devm_ioremap(dev, io->start, resource_size(io));
+	if (!base) {
 		dev_err(dev, "Failed to get memory region\n");
 		return -ENODEV;
 	}
 
+	data->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
+	if (IS_ERR(data->regmap)) {
+		ret = PTR_ERR(data->regmap);
+		dev_err(dev, "Failed to init regmap (%d)\n", ret);
+		return ret;
+	}
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
@@ -218,7 +215,7 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
 
 	/* Disable monitoring */
-	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
+	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 
 	platform_set_drvdata(pdev, NULL);
 
@@ -226,30 +223,22 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int qoriq_tmu_suspend(struct device *dev)
+
+static int qoriq_tmu_suspend_resume(struct device *dev, unsigned int val)
 {
-	u32 tmr;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
 
-	/* Disable monitoring */
-	tmr = tmu_read(data, &data->regs->tmr);
-	tmr &= ~TMR_ME;
-	tmu_write(data, tmr, &data->regs->tmr);
+	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, val);
+}
 
-	return 0;
+static int qoriq_tmu_suspend(struct device *dev)
+{
+	return qoriq_tmu_suspend_resume(dev, 0);
 }
 
 static int qoriq_tmu_resume(struct device *dev)
 {
-	u32 tmr;
-	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
-
-	/* Enable monitoring */
-	tmr = tmu_read(data, &data->regs->tmr);
-	tmr |= TMR_ME;
-	tmu_write(data, tmr, &data->regs->tmr);
-
-	return 0;
+	return qoriq_tmu_suspend_resume(dev, TMR_ME);
 }
 #endif
 
-- 
2.20.1

