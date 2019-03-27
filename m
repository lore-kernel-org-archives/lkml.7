Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE30CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920122082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="RPhTD+Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbfC0BaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:30:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44127 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbfC0BaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:30:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so2786409pfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 18:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MpGrroeaBMMfZ5NtEqWTvaWq/bUzaxMexcrp/8DtcFY=;
        b=RPhTD+VzAa2d6Qlgo+Kyt/bjbG09vMXD8MkDEDAhm77kzTu8RxmHCeb3ibpzJt/yJn
         7CqGgjp9+3wXioYAhFxXBUpqXDttvQZz3nkt1K37JklvnbfXWAqnCXfh8k8s4Bu4Kk+D
         gDnn5aSzzoZ9FutX+rEGfVQTJEMASo3QJQQ/5GJK42TZWFMmso3SbE2/jSS2mrFQdkT0
         GctJRUsBhOBd0Nu4Kg1xZYaufV3HMH1QD+ELKaX7OZwiRuV19JWD5PuQfmc8E8E9Poq5
         r9rIm5zLIP2Flg+CHKXEcyDzAbx3rJUnnjs/jJntfnN4EQ4jiMlFgzKmw9GXzKuPidtI
         eptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MpGrroeaBMMfZ5NtEqWTvaWq/bUzaxMexcrp/8DtcFY=;
        b=cp4tVeHh8doY42NMn7643DJielrORpd0Yu5AayaX9XFUVx4w/RHFKP6AwqPfvYD08a
         ohG/TuXIIiVWFP1drbtwPAWsRYmBRNVjuAbxz/Tfo6CTxBBBYe2k5ZBvriU3EnUFjcNn
         sDqb4ixyjpNLWmmreHuclH76VmWphkAsYSquFfGIN1P77ZAerFmHD6rXI7hiGrmEDBWr
         LAMIJSVcyIWlVrlDEXFdiAIvq/1i+D0S/Pi2AzPIsZZLlMgvVv+o7cShdk1B+UttIDFb
         MGZq1AdcDlyr77N/mC452fKJiwizVwNiSvUJdbXJBbxvJ5wFWpkmCeN9QPayKDzGlsL5
         JT1A==
X-Gm-Message-State: APjAAAVUY5OvpotH4r7s1LGaqMCoIeBhUL+0LVKR7NfeIxB0lCJ1Zraf
        Po/AKQCPuQfQsgCxQy6/mg33FQ==
X-Google-Smtp-Source: APXvYqw7Vu580MQl1kET3PaUiyDspVL/mfxERxRhJ2khf9RZ5ImPYb9MWZPweqvM6dWbYXi4xvYuUw==
X-Received: by 2002:a63:fb45:: with SMTP id w5mr31987518pgj.118.1553650203367;
        Tue, 26 Mar 2019 18:30:03 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id i31sm31158195pgi.36.2019.03.26.18.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 18:30:02 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Florian Lobmaier <florian.lobmaier@ams.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Vince Hsu <vinceh@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: as3722: Slightly improve readability
Date:   Wed, 27 Mar 2019 09:29:47 +0800
Message-Id: <20190327012947.6029-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327012947.6029-1-axel.lin@ingics.com>
References: <20190327012947.6029-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a local variable *desc to avoid too many change lines due to over 80
characters.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/as3722-regulator.c | 137 ++++++++++++---------------
 1 file changed, 58 insertions(+), 79 deletions(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index 4dda77417300..dc75c33bd950 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -674,49 +674,45 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 	config.regmap = as3722->regmap;
 
 	for (id = 0; id < AS3722_REGULATOR_ID_MAX; id++) {
+		struct regulator_desc *desc;
+
+		desc = &as3722_regs->desc[id];
 		reg_config = &as3722_regs->reg_config_data[id];
 
-		as3722_regs->desc[id].name = as3722_reg_lookup[id].name;
-		as3722_regs->desc[id].supply_name = as3722_reg_lookup[id].sname;
-		as3722_regs->desc[id].id = as3722_reg_lookup[id].regulator_id;
-		as3722_regs->desc[id].n_voltages =
-					as3722_reg_lookup[id].n_voltages;
-		as3722_regs->desc[id].type = REGULATOR_VOLTAGE;
-		as3722_regs->desc[id].owner = THIS_MODULE;
-		as3722_regs->desc[id].enable_reg =
-					as3722_reg_lookup[id].enable_reg;
-		as3722_regs->desc[id].enable_mask =
-					as3722_reg_lookup[id].enable_mask;
-		as3722_regs->desc[id].vsel_reg = as3722_reg_lookup[id].vsel_reg;
-		as3722_regs->desc[id].vsel_mask =
-					as3722_reg_lookup[id].vsel_mask;
+		desc->name = as3722_reg_lookup[id].name;
+		desc->supply_name = as3722_reg_lookup[id].sname;
+		desc->id = as3722_reg_lookup[id].regulator_id;
+		desc->n_voltages = as3722_reg_lookup[id].n_voltages;
+		desc->type = REGULATOR_VOLTAGE;
+		desc->owner = THIS_MODULE;
+		desc->enable_reg = as3722_reg_lookup[id].enable_reg;
+		desc->enable_mask = as3722_reg_lookup[id].enable_mask;
+		desc->vsel_reg = as3722_reg_lookup[id].vsel_reg;
+		desc->vsel_mask = as3722_reg_lookup[id].vsel_mask;
 		switch (id) {
 		case AS3722_REGULATOR_ID_LDO0:
 			if (reg_config->ext_control)
 				ops = &as3722_ldo0_extcntrl_ops;
 			else
 				ops = &as3722_ldo0_ops;
-			as3722_regs->desc[id].min_uV = 825000;
-			as3722_regs->desc[id].uV_step = 25000;
-			as3722_regs->desc[id].linear_min_sel = 1;
-			as3722_regs->desc[id].enable_time = 500;
-			as3722_regs->desc[id].curr_table = as3722_ldo_current;
-			as3722_regs->desc[id].n_current_limits =
-				ARRAY_SIZE(as3722_ldo_current);
-			as3722_regs->desc[id].csel_reg =
-				as3722_reg_lookup[id].vsel_reg;
-			as3722_regs->desc[id].csel_mask =
-				AS3722_LDO_ILIMIT_MASK;
+			desc->min_uV = 825000;
+			desc->uV_step = 25000;
+			desc->linear_min_sel = 1;
+			desc->enable_time = 500;
+			desc->curr_table = as3722_ldo_current;
+			desc->n_current_limits = ARRAY_SIZE(as3722_ldo_current);
+			desc->csel_reg = as3722_reg_lookup[id].vsel_reg;
+			desc->csel_mask = AS3722_LDO_ILIMIT_MASK;
 			break;
 		case AS3722_REGULATOR_ID_LDO3:
 			if (reg_config->ext_control)
 				ops = &as3722_ldo3_extcntrl_ops;
 			else
 				ops = &as3722_ldo3_ops;
-			as3722_regs->desc[id].min_uV = 620000;
-			as3722_regs->desc[id].uV_step = 20000;
-			as3722_regs->desc[id].linear_min_sel = 1;
-			as3722_regs->desc[id].enable_time = 500;
+			desc->min_uV = 620000;
+			desc->uV_step = 20000;
+			desc->linear_min_sel = 1;
+			desc->enable_time = 500;
 			if (reg_config->enable_tracking) {
 				ret = as3722_ldo3_set_tracking_mode(as3722_regs,
 					id, AS3722_LDO3_MODE_PMOS_TRACKING);
@@ -733,25 +729,17 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 				ops = &as3722_ldo6_extcntrl_ops;
 			else
 				ops = &as3722_ldo6_ops;
-			as3722_regs->desc[id].enable_time = 500;
-			as3722_regs->desc[id].bypass_reg =
-						AS3722_LDO6_VOLTAGE_REG;
-			as3722_regs->desc[id].bypass_mask =
-						AS3722_LDO_VSEL_MASK;
-			as3722_regs->desc[id].bypass_val_on =
-						AS3722_LDO6_VSEL_BYPASS;
-			as3722_regs->desc[id].bypass_val_off =
-						AS3722_LDO6_VSEL_BYPASS;
-			as3722_regs->desc[id].linear_ranges = as3722_ldo_ranges;
-			as3722_regs->desc[id].n_linear_ranges =
-						ARRAY_SIZE(as3722_ldo_ranges);
-			as3722_regs->desc[id].curr_table = as3722_ldo_current;
-			as3722_regs->desc[id].n_current_limits =
-				ARRAY_SIZE(as3722_ldo_current);
-			as3722_regs->desc[id].csel_reg =
-				as3722_reg_lookup[id].vsel_reg;
-			as3722_regs->desc[id].csel_mask =
-				AS3722_LDO_ILIMIT_MASK;
+			desc->enable_time = 500;
+			desc->bypass_reg = AS3722_LDO6_VOLTAGE_REG;
+			desc->bypass_mask = AS3722_LDO_VSEL_MASK;
+			desc->bypass_val_on = AS3722_LDO6_VSEL_BYPASS;
+			desc->bypass_val_off = AS3722_LDO6_VSEL_BYPASS;
+			desc->linear_ranges = as3722_ldo_ranges;
+			desc->n_linear_ranges = ARRAY_SIZE(as3722_ldo_ranges);
+			desc->curr_table = as3722_ldo_current;
+			desc->n_current_limits = ARRAY_SIZE(as3722_ldo_current);
+			desc->csel_reg = as3722_reg_lookup[id].vsel_reg;
+			desc->csel_mask = AS3722_LDO_ILIMIT_MASK;
 			break;
 		case AS3722_REGULATOR_ID_SD0:
 		case AS3722_REGULATOR_ID_SD1:
@@ -770,26 +758,23 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 					AS3722_SD0_VSEL_MAX + 1;
 				as3722_regs->desc[id].min_uV = 610000;
 			}
-			as3722_regs->desc[id].uV_step = 10000;
-			as3722_regs->desc[id].linear_min_sel = 1;
-			as3722_regs->desc[id].enable_time = 600;
-			as3722_regs->desc[id].curr_table = as3722_sd016_current;
-			as3722_regs->desc[id].n_current_limits =
+			desc->uV_step = 10000;
+			desc->linear_min_sel = 1;
+			desc->enable_time = 600;
+			desc->curr_table = as3722_sd016_current;
+			desc->n_current_limits =
 				ARRAY_SIZE(as3722_sd016_current);
 			if (id == AS3722_REGULATOR_ID_SD0) {
-				as3722_regs->desc[id].csel_reg =
-					AS3722_OVCURRENT_REG;
-				as3722_regs->desc[id].csel_mask =
+				desc->csel_reg = AS3722_OVCURRENT_REG;
+				desc->csel_mask =
 					AS3722_OVCURRENT_SD0_TRIP_MASK;
 			} else if (id == AS3722_REGULATOR_ID_SD1) {
-				as3722_regs->desc[id].csel_reg =
-					AS3722_OVCURRENT_REG;
-				as3722_regs->desc[id].csel_mask =
+				desc->csel_reg = AS3722_OVCURRENT_REG;
+				desc->csel_mask =
 					AS3722_OVCURRENT_SD1_TRIP_MASK;
 			} else if (id == AS3722_REGULATOR_ID_SD6) {
-				as3722_regs->desc[id].csel_reg =
-					AS3722_OVCURRENT_DEB_REG;
-				as3722_regs->desc[id].csel_mask =
+				desc->csel_reg = AS3722_OVCURRENT_DEB_REG;
+				desc->csel_mask =
 					AS3722_OVCURRENT_SD6_TRIP_MASK;
 			}
 			break;
@@ -801,9 +786,8 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 				ops = &as3722_sd2345_extcntrl_ops;
 			else
 				ops = &as3722_sd2345_ops;
-			as3722_regs->desc[id].linear_ranges =
-						as3722_sd2345_ranges;
-			as3722_regs->desc[id].n_linear_ranges =
+			desc->linear_ranges = as3722_sd2345_ranges;
+			desc->n_linear_ranges =
 					ARRAY_SIZE(as3722_sd2345_ranges);
 			break;
 		default:
@@ -811,24 +795,19 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 				ops = &as3722_ldo_extcntrl_ops;
 			else
 				ops = &as3722_ldo_ops;
-			as3722_regs->desc[id].enable_time = 500;
-			as3722_regs->desc[id].linear_ranges = as3722_ldo_ranges;
-			as3722_regs->desc[id].n_linear_ranges =
-						ARRAY_SIZE(as3722_ldo_ranges);
-			as3722_regs->desc[id].curr_table = as3722_ldo_current;
-			as3722_regs->desc[id].n_current_limits =
-						ARRAY_SIZE(as3722_ldo_current);
-			as3722_regs->desc[id].csel_reg =
-						as3722_reg_lookup[id].vsel_reg;
-			as3722_regs->desc[id].csel_mask =
-						AS3722_LDO_ILIMIT_MASK;
+			desc->enable_time = 500;
+			desc->linear_ranges = as3722_ldo_ranges;
+			desc->n_linear_ranges = ARRAY_SIZE(as3722_ldo_ranges);
+			desc->curr_table = as3722_ldo_current;
+			desc->n_current_limits = ARRAY_SIZE(as3722_ldo_current);
+			desc->csel_reg = as3722_reg_lookup[id].vsel_reg;
+			desc->csel_mask = AS3722_LDO_ILIMIT_MASK;
 			break;
 		}
-		as3722_regs->desc[id].ops = ops;
+		desc->ops = ops;
 		config.init_data = reg_config->reg_init;
 		config.of_node = as3722_regulator_matches[id].of_node;
-		rdev = devm_regulator_register(&pdev->dev,
-					&as3722_regs->desc[id], &config);
+		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
 			ret = PTR_ERR(rdev);
 			dev_err(&pdev->dev, "regulator %d register failed %d\n",
-- 
2.17.1

