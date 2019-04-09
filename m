Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F39C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F012084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="AcEqKK9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDIQKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:10:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39472 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDIQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:10:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so9564659pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZpCa4KCQHdqKl2oL3mhDp4cKBTmdoa9/ZNCPYnpPtu8=;
        b=AcEqKK9RxNxeiiQq1sDZjfoV7657md7s389Afv4LvLQsJScJ+gvEWoq7okysE7DzF/
         HI2DplF9AyJkbFuTbo2adYAQWcbZ+qF5Y/77o9AnaVqHm8wskpUSe2zM3MAwputrqRt7
         /BGTvtyItbEk7axR0DwWNP42R4mByVTx81vOR3IkTSzXjJCsc1nBrjaxm3x/5oxFyJIT
         HP5B79xvFaGKlemYR5rTyN+8fLJMOsyYyN8oJ7aZuw5Zyn1YbOqDOJqujktvZqE8QjY/
         1/VUf+n+kVDBqIAESTciNbjBmXEHYEhNgmsI0+1mFAGGubgrUCNZRr70/+BL4ikvVCys
         eOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZpCa4KCQHdqKl2oL3mhDp4cKBTmdoa9/ZNCPYnpPtu8=;
        b=afUZnagBXU3b8jv298L85wlI4qo5vBNms7Y0Hd5aCb8vgqHeIknZ1FCPHy+GHzrmNY
         88aGChpdt/XdDxoC0sNCp7CykZpSoVufjShmfkFN3smW2CLfrAJjYUaSpsfjXa68uVnc
         ihadort1cVy+wMIRtxOc+y0yohI1kAdqcFaVJ2ndEgq/dkRg6fw+SgdqW81LCI6zBS6Q
         aUALeafgmaQTgoRPcRGvZnQ+3AWshuS6j+BLIyT7TbOejsUm5988UoegMFScTpkBxRHc
         cy8K23RGFmVk/0oYeTCokL9TJsurbMmWvsl4A1ka/zmgkwbboO3sR5gP6T82+FCWo61F
         HPyQ==
X-Gm-Message-State: APjAAAU48SNhGNMJ/vGDKQHAva8a38AG8CrOo9YKd8lUjK72mDlUy2Ai
        MugeEtvr4uoYqr3HDW/i11YNAA==
X-Google-Smtp-Source: APXvYqyA5wptfX7b3m4Sh/1rYqcKFaccgP9tlYManiSCB+OR3ieipNyN4KLCGG3mxTRpc9oLMoVKCA==
X-Received: by 2002:a63:618d:: with SMTP id v135mr35323953pgb.2.1554826248629;
        Tue, 09 Apr 2019 09:10:48 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id f2sm25403399pgc.30.2019.04.09.09.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:10:47 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ying-Chun Liu <paul.liu@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: anatop: Remove unneeded fields from struct anatop_regulator
Date:   Wed, 10 Apr 2019 00:10:39 +0800
Message-Id: <20190409161039.4451-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fields are only used in anatop_regulator_probe() so use local
variables instead. The *initdata is not used so can be removed.
The *anatop is renamed to *regmap for better readability.
Use u32 instead of int for the variables used as third argument of
of_property_read_u32().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/anatop-regulator.c | 63 ++++++++++++----------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index d9d8155ed8cb..754739d004e5 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -23,18 +23,10 @@
 #define LDO_FET_FULL_ON			0x1f
 
 struct anatop_regulator {
-	u32 control_reg;
-	struct regmap *anatop;
-	int vol_bit_shift;
-	int vol_bit_width;
 	u32 delay_reg;
 	int delay_bit_shift;
 	int delay_bit_width;
-	int min_bit_val;
-	int min_voltage;
-	int max_voltage;
 	struct regulator_desc rdesc;
-	struct regulator_init_data *initdata;
 	bool bypass;
 	int sel;
 };
@@ -55,7 +47,7 @@ static int anatop_regmap_set_voltage_time_sel(struct regulator_dev *reg,
 		 * to calculate how many steps LDO need to
 		 * ramp up, and how much delay needed. (us)
 		 */
-		regmap_read(anatop_reg->anatop, anatop_reg->delay_reg, &val);
+		regmap_read(reg->regmap, anatop_reg->delay_reg, &val);
 		val = (val >> anatop_reg->delay_bit_shift) &
 			((1 << anatop_reg->delay_bit_width) - 1);
 		ret = (new_sel - old_sel) * (LDO_RAMP_UP_UNIT_IN_CYCLES <<
@@ -170,6 +162,13 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	struct anatop_regulator *sreg;
 	struct regulator_init_data *initdata;
 	struct regulator_config config = { };
+	struct regmap *regmap;
+	u32 control_reg;
+	u32 vol_bit_shift;
+	u32 vol_bit_width;
+	u32 min_bit_val;
+	u32 min_voltage;
+	u32 max_voltage;
 	int ret = 0;
 	u32 val;
 
@@ -192,48 +191,41 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	initdata->supply_regulator = "vin";
-	sreg->initdata = initdata;
 
 	anatop_np = of_get_parent(np);
 	if (!anatop_np)
 		return -ENODEV;
-	sreg->anatop = syscon_node_to_regmap(anatop_np);
+	regmap = syscon_node_to_regmap(anatop_np);
 	of_node_put(anatop_np);
-	if (IS_ERR(sreg->anatop))
-		return PTR_ERR(sreg->anatop);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	ret = of_property_read_u32(np, "anatop-reg-offset",
-				   &sreg->control_reg);
+	ret = of_property_read_u32(np, "anatop-reg-offset", &control_reg);
 	if (ret) {
 		dev_err(dev, "no anatop-reg-offset property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-vol-bit-width",
-				   &sreg->vol_bit_width);
+	ret = of_property_read_u32(np, "anatop-vol-bit-width", &vol_bit_width);
 	if (ret) {
 		dev_err(dev, "no anatop-vol-bit-width property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-vol-bit-shift",
-				   &sreg->vol_bit_shift);
+	ret = of_property_read_u32(np, "anatop-vol-bit-shift", &vol_bit_shift);
 	if (ret) {
 		dev_err(dev, "no anatop-vol-bit-shift property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-min-bit-val",
-				   &sreg->min_bit_val);
+	ret = of_property_read_u32(np, "anatop-min-bit-val", &min_bit_val);
 	if (ret) {
 		dev_err(dev, "no anatop-min-bit-val property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-min-voltage",
-				   &sreg->min_voltage);
+	ret = of_property_read_u32(np, "anatop-min-voltage", &min_voltage);
 	if (ret) {
 		dev_err(dev, "no anatop-min-voltage property set\n");
 		return ret;
 	}
-	ret = of_property_read_u32(np, "anatop-max-voltage",
-				   &sreg->max_voltage);
+	ret = of_property_read_u32(np, "anatop-max-voltage", &max_voltage);
 	if (ret) {
 		dev_err(dev, "no anatop-max-voltage property set\n");
 		return ret;
@@ -247,24 +239,23 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	of_property_read_u32(np, "anatop-delay-bit-shift",
 			     &sreg->delay_bit_shift);
 
-	rdesc->n_voltages = (sreg->max_voltage - sreg->min_voltage) / 25000 + 1
-			    + sreg->min_bit_val;
-	rdesc->min_uV = sreg->min_voltage;
+	rdesc->n_voltages = (max_voltage - min_voltage) / 25000 + 1
+			    + min_bit_val;
+	rdesc->min_uV = min_voltage;
 	rdesc->uV_step = 25000;
-	rdesc->linear_min_sel = sreg->min_bit_val;
-	rdesc->vsel_reg = sreg->control_reg;
-	rdesc->vsel_mask = ((1 << sreg->vol_bit_width) - 1) <<
-			   sreg->vol_bit_shift;
+	rdesc->linear_min_sel = min_bit_val;
+	rdesc->vsel_reg = control_reg;
+	rdesc->vsel_mask = ((1 << vol_bit_width) - 1) << vol_bit_shift;
 	rdesc->min_dropout_uV = 125000;
 
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
 	config.driver_data = sreg;
 	config.of_node = pdev->dev.of_node;
-	config.regmap = sreg->anatop;
+	config.regmap = regmap;
 
 	/* Only core regulators have the ramp up delay configuration. */
-	if (sreg->control_reg && sreg->delay_bit_width) {
+	if (control_reg && sreg->delay_bit_width) {
 		rdesc->ops = &anatop_core_rops;
 
 		ret = regmap_read(config.regmap, rdesc->vsel_reg, &val);
@@ -273,7 +264,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		sreg->sel = (val & rdesc->vsel_mask) >> sreg->vol_bit_shift;
+		sreg->sel = (val & rdesc->vsel_mask) >> vol_bit_shift;
 		if (sreg->sel == LDO_FET_FULL_ON) {
 			sreg->sel = 0;
 			sreg->bypass = true;
@@ -306,7 +297,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 			anatop_rops.disable = regulator_disable_regmap;
 			anatop_rops.is_enabled = regulator_is_enabled_regmap;
 
-			rdesc->enable_reg = sreg->control_reg;
+			rdesc->enable_reg = control_reg;
 			rdesc->enable_mask = BIT(enable_bit);
 		}
 	}
-- 
2.17.1

