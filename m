Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A23DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B922146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="wdQwDRgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfC0LyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:54:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46859 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfC0LyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:54:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so9578451pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 04:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=wednB933GUVMv5afJHPgRRzc9IOnfueaW6I+JBubaL0=;
        b=wdQwDRgoZsS9MHExjHa0J43Y7HSNUyH0pZRw2fc4WRIVXa5Y8Mwi3DiSKB+0Qfw3uL
         z3ohcejm6OsGK/Lrt4cf2js3HJbX/+E5utp3A9f2xr4s76JFmENRN2dzSQkAnxVZ/EfY
         211FKLU5mX5FwkgquEggygY5Qa9/bCt9u/WT4P1C9UQivc9h1kSIOg61CCM1fsjO/pml
         MoMEE7e2vC+OxG98jskyPNww7Biw+bCEzARCtK4BqgnrLPsLMlm8kbXdxHGvjxfwAIvw
         DF7Lnc/zF7PrHm0Nk9F4w+TlvwbtzHPE8mCKNufKBWdZvZs0QS+x6m1XWjRPOrOLkAj2
         a3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wednB933GUVMv5afJHPgRRzc9IOnfueaW6I+JBubaL0=;
        b=iiMqYJtCPsyO6omYlnBcTXDBtijEfFOEQvOUaT/vJqIRth6g0E2f1TD4KWNOfHrAF9
         yM7ESAk+B7fSVsdxWye/8MB9sxYx8eh7B0Sx6LXUJR1I29gdUd2+GOQ/NsOcHvL6l2Fe
         1Swn8zw8M1BZ9ian5bhLcM6Ca8LoKxaXO9dsbmbM/u7A5W31jVsT9zyXYLSW3TYk24uH
         l6c9+ssW5N7zP2clEe2AjEIm+ZdUo/cNwuBhhNdMK6LCl0zdGLI/9M5sSQWh99lLvqM0
         8E8YjVRvQrPLBWUyaCERM2en1UQydiza26p2xW9yLYCy2cUPJNZfAd0ddH9kWMoIGEli
         FfRQ==
X-Gm-Message-State: APjAAAUTz3hw0HXk+WNpRAWq1zEO/xi2SU6T6VDI+UQpmiLRkedBqQ35
        bli/RVVOEZg/qm/dMzbzR99fcQ==
X-Google-Smtp-Source: APXvYqyjlf6wnCPn0Vi8w340hdDNGkhjeoCUNcSkmWIFgvQEmXLnhsQfQ0opXV7oEcpBLK22r0P7PQ==
X-Received: by 2002:a63:e70c:: with SMTP id b12mr34385350pgi.399.1553687663494;
        Wed, 27 Mar 2019 04:54:23 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id i25sm29455629pfd.52.2019.03.27.04.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 04:54:21 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rc5t583: Get rid of struct rc5t583_regulator
Date:   Wed, 27 Mar 2019 19:54:13 +0800
Message-Id: <20190327115413.11155-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct rc5t583_regulator only has 2 members, the *rdev is no longer
used because this driver is using devm_regulator_register now. After remove
*rdev, only *reg_info left. We can use struct rc5t583_regulator_info
directly, so remove struct rc5t583_regulator.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rc5t583-regulator.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/rc5t583-regulator.c b/drivers/regulator/rc5t583-regulator.c
index 2ec51af43673..9446653e7a89 100644
--- a/drivers/regulator/rc5t583-regulator.c
+++ b/drivers/regulator/rc5t583-regulator.c
@@ -47,18 +47,13 @@ struct rc5t583_regulator_info {
 	struct regulator_desc	desc;
 };
 
-struct rc5t583_regulator {
-	struct rc5t583_regulator_info *reg_info;
-	struct regulator_dev	*rdev;
-};
-
 static int rc5t583_regulator_enable_time(struct regulator_dev *rdev)
 {
-	struct rc5t583_regulator *reg = rdev_get_drvdata(rdev);
+	struct rc5t583_regulator_info *reg_info = rdev_get_drvdata(rdev);
 	int vsel = regulator_get_voltage_sel_regmap(rdev);
 	int curr_uV = regulator_list_voltage_linear(rdev, vsel);
 
-	return DIV_ROUND_UP(curr_uV, reg->reg_info->enable_uv_per_us);
+	return DIV_ROUND_UP(curr_uV, reg_info->enable_uv_per_us);
 }
 
 static const struct regulator_ops rc5t583_ops = {
@@ -120,8 +115,6 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 	struct rc5t583 *rc5t583 = dev_get_drvdata(pdev->dev.parent);
 	struct rc5t583_platform_data *pdata = dev_get_platdata(rc5t583->dev);
 	struct regulator_config config = { };
-	struct rc5t583_regulator *reg = NULL;
-	struct rc5t583_regulator *regs;
 	struct regulator_dev *rdev;
 	struct rc5t583_regulator_info *ri;
 	int ret;
@@ -132,18 +125,8 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	regs = devm_kcalloc(&pdev->dev,
-			    RC5T583_REGULATOR_MAX,
-			    sizeof(struct rc5t583_regulator),
-			    GFP_KERNEL);
-	if (!regs)
-		return -ENOMEM;
-
-
 	for (id = 0; id < RC5T583_REGULATOR_MAX; ++id) {
-		reg = &regs[id];
 		ri = &rc5t583_reg_info[id];
-		reg->reg_info = ri;
 
 		if (ri->deepsleep_id == RC5T583_DS_NONE)
 			goto skip_ext_pwr_config;
@@ -163,7 +146,7 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 skip_ext_pwr_config:
 		config.dev = &pdev->dev;
 		config.init_data = pdata->reg_init_data[id];
-		config.driver_data = reg;
+		config.driver_data = ri;
 		config.regmap = rc5t583->regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, &ri->desc, &config);
@@ -172,9 +155,7 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 						ri->desc.name);
 			return PTR_ERR(rdev);
 		}
-		reg->rdev = rdev;
 	}
-	platform_set_drvdata(pdev, regs);
 	return 0;
 }
 
-- 
2.17.1

