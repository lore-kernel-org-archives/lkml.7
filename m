Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8C5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92554214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqjoxiyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390244AbfDRT6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:58:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45943 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390208AbfDRT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:58:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so1562236pfi.12;
        Thu, 18 Apr 2019 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B+LNAKL2mwreepfAxVSDlLeu1nTRg9NDiYI0VC4TC00=;
        b=rqjoxiyNXurY80FdMqb1XIcVY1Nud70uNtYmfruRMk2u2YXL4fTnC7SeQsHVDfnZIv
         +2wwohnJUklymDYYzMcsp0nJDENdX0qkePVfhDHjPngp88FT+qHbXcQNgUVft7MUszgD
         BhlRol4n1F82v74M5vehGKqa01BQy1u+S0ospxjCt+ZHr4NIBNpq0TCN28WsZ0j8lmVZ
         tl+khSzxsQIk4LG5374Sd2h6C3YAhNHv2WooJRvYf/LZUUvPKDOLCg2TqmL2tNKrfKa0
         pnRm/jqjXJ58kgtDS3oQacPwWYljpZN6GmieljHz1cnbDVJCd3DHWGIJFCYn+c66KCP0
         nZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=B+LNAKL2mwreepfAxVSDlLeu1nTRg9NDiYI0VC4TC00=;
        b=iAy64Bf9ieVj9tcwPAjy548f2B8IMEaeSnPUvZWq1Bk4A9hJw6Q2X6KaJEDs9LOGyC
         mKL8IzGr0MbpVDedM+9vujp8plj5K+sIcMNAkmstUINxC07CDvhy0wNJ7cpAPYUSg1Uv
         1fD2Hm8S0XYgTvEmI2oNHvwfHljSrrghYdw50FoWLd+7vRes7K16h6S6IcC0cMsLEpPv
         XRr5vTJxLxTem4s6cVAgzzZEAkPjsGQWALHXTSrwTGRI0UiVB2E+oG7AzXcdTeerxTBX
         JaTY2X0z8AzKSR/1lkapEceBBThTOggCfkrihCXRsz3omwIRIQQi92LBuBoh7pS+vLtX
         Gwrg==
X-Gm-Message-State: APjAAAXSuCJ/zPPgNCVw938Xd4lNUm5MCDLWCZzOkst5CyQW/I+A2yD4
        pG8BcK7YxzL0RIBRb8XVkzsF1GoVS6w=
X-Google-Smtp-Source: APXvYqyrcCmw+O4OFChgOEXhNjU0JwgPzu/CWUETVfyzN5U3Q8MjuDahbKsOjMdag3oLd5f74B99MA==
X-Received: by 2002:a65:6144:: with SMTP id o4mr90124351pgv.247.1555617512356;
        Thu, 18 Apr 2019 12:58:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s9sm4219784pfe.183.2019.04.18.12.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:58:31 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 6/6] hwmon: (pwm-fan) Use devm_thermal_of_cooling_device_register
Date:   Thu, 18 Apr 2019 12:58:20 -0700
Message-Id: <1555617500-10862-7-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_thermal_of_cooling_device_register() to register the cooling
device. Also use devm_add_action_or_reset() to stop the fan on device
removal, and to disable the pwm. Introduce a local 'dev' variable in
the probe function to make the code easier to read.

As a side effect, this fixes a bug seen if pwm_fan_of_get_cooling_data()
returned an error. In that situation, the pwm was not disabled, and
the fan was not stopped. Using devm functions also ensures that the
pwm is disabled and that the fan is stopped only after the hwmon device
has been unregistered.

Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 73 ++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 167221c7628a..0243ba70107e 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -207,33 +207,44 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 	return 0;
 }
 
+static void pwm_fan_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static void pwm_fan_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
 static int pwm_fan_probe(struct platform_device *pdev)
 {
 	struct thermal_cooling_device *cdev;
+	struct device *dev = &pdev->dev;
 	struct pwm_fan_ctx *ctx;
 	struct device *hwmon;
 	int ret;
 	struct pwm_state state = { };
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
 	mutex_init(&ctx->lock);
 
-	ctx->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
+	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
 	if (IS_ERR(ctx->pwm)) {
 		ret = PTR_ERR(ctx->pwm);
 
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get PWM: %d\n", ret);
+			dev_err(dev, "Could not get PWM: %d\n", ret);
 
 		return ret;
 	}
 
 	platform_set_drvdata(pdev, ctx);
 
-	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
+	ctx->reg_en = devm_regulator_get_optional(dev, "fan");
 	if (IS_ERR(ctx->reg_en)) {
 		if (PTR_ERR(ctx->reg_en) != -ENODEV)
 			return PTR_ERR(ctx->reg_en);
@@ -242,10 +253,11 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	} else {
 		ret = regulator_enable(ctx->reg_en);
 		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable fan supply: %d\n", ret);
+			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
 			return ret;
 		}
+		devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
+					 ctx->reg_en);
 	}
 
 	ctx->pwm_value = MAX_PWM;
@@ -257,62 +269,36 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ret = pwm_apply_state(ctx->pwm, &state);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to configure PWM\n");
-		goto err_reg_disable;
+		dev_err(dev, "Failed to configure PWM\n");
+		return ret;
 	}
+	devm_add_action_or_reset(dev, pwm_fan_pwm_disable, ctx->pwm);
 
-	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
+	hwmon = devm_hwmon_device_register_with_groups(dev, "pwmfan",
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
-		dev_err(&pdev->dev, "Failed to register hwmon device\n");
-		ret = PTR_ERR(hwmon);
-		goto err_pwm_disable;
+		dev_err(dev, "Failed to register hwmon device\n");
+		return PTR_ERR(hwmon);
 	}
 
-	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
+	ret = pwm_fan_of_get_cooling_data(dev, ctx);
 	if (ret)
 		return ret;
 
 	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
 	if (IS_ENABLED(CONFIG_THERMAL)) {
-		cdev = thermal_of_cooling_device_register(pdev->dev.of_node,
-							  "pwm-fan", ctx,
-							  &pwm_fan_cooling_ops);
+		cdev = devm_thermal_of_cooling_device_register(dev,
+			dev->of_node, "pwm-fan", ctx, &pwm_fan_cooling_ops);
 		if (IS_ERR(cdev)) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"Failed to register pwm-fan as cooling device");
-			ret = PTR_ERR(cdev);
-			goto err_pwm_disable;
+			return PTR_ERR(cdev);
 		}
 		ctx->cdev = cdev;
 		thermal_cdev_update(cdev);
 	}
 
 	return 0;
-
-err_pwm_disable:
-	state.enabled = false;
-	pwm_apply_state(ctx->pwm, &state);
-
-err_reg_disable:
-	if (ctx->reg_en)
-		regulator_disable(ctx->reg_en);
-
-	return ret;
-}
-
-static int pwm_fan_remove(struct platform_device *pdev)
-{
-	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
-
-	thermal_cooling_device_unregister(ctx->cdev);
-	if (ctx->pwm_value)
-		pwm_disable(ctx->pwm);
-
-	if (ctx->reg_en)
-		regulator_disable(ctx->reg_en);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -380,7 +366,6 @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
 
 static struct platform_driver pwm_fan_driver = {
 	.probe		= pwm_fan_probe,
-	.remove		= pwm_fan_remove,
 	.driver	= {
 		.name		= "pwm-fan",
 		.pm		= &pwm_fan_pm,
-- 
2.7.4

