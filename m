Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EDBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98473217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptnitUg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390213AbfDRT6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:58:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33681 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:58:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so1676375pgh.0;
        Thu, 18 Apr 2019 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWQMJ2qTXasITQgDK7vc9YMGIL8w6QMaEOeMp9MVgzI=;
        b=ptnitUg6IR26fWprpiE9SfWzcu4vKN3PFmzfsz+4CDYEGeIqed3/8Lo9tQysZUG4Lv
         SGLNuz5reGyNFVfirM8CCbcaXLvTAcwDEgUNrIdldCkCvUMcqtz+SUzeeYsxEbAhrhe8
         OZV4IdpJ/JrDKgyaiDznPuk+NqeEQ+jdLfRbHLUzkg+Mi1UVxsBjWuVyNwUATQGgOyAi
         Ur8Ltu5Z/kfZiNlkj5lQHDvgInKi5nOQho3eNt1oc8wHMjoaJVJpgrlgv/bsrCPNbZ2p
         uBvINGwHLyrn0+sEuBYiyqP1Yz3q4x1JO738O87cTk3RZL6XE3D7tVRwHfsrL5pwO/Mq
         XG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iWQMJ2qTXasITQgDK7vc9YMGIL8w6QMaEOeMp9MVgzI=;
        b=mOa8j/gH6UtyteU43Dx8J9z9DIFiZrid+cUPuGmiTVCQdSOb1wVEEqBQievt+miDG0
         Uu41SbPbvpPN6M6DhP3yVRWjBFgCQKIY3wScWJOJjP9uE2U3t/4s2y4yXzR/a2PMQIG3
         i0m7GR6qozXn6hHgPAA8t/JavEqWIpzYQysm8PR7oRd/wVHeqfYKXSMkLcRK4ZPA+QrH
         UyMbyNcanIrjSi1BIz7o5o4C1DkNZvdE2wg+AeGzzR3dJyv3NYd+UY/HyWQGyHv5Do01
         nYvKLLOZkJUlcNBW7s42SUPwuS0h+n1mUKbAUSnISl2qFD85xh4VrM8VFeVjvWA8Tiaj
         XcOg==
X-Gm-Message-State: APjAAAUHqHCr8BnAtmHm3wwkvEH8vQZuW8Wd/X2gy9FVv6R9fAb64Qlb
        l/JQzvc7D7J4mKAb8c6iDObPHVwVFFI=
X-Google-Smtp-Source: APXvYqwapDl66OdPq4SqQZL/qnGUXMG1TzJPI+cBC4ddbm9BEsja+OuErjgE2UHtPRBNttg6+aDKSg==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr89147313pgk.382.1555617509572;
        Thu, 18 Apr 2019 12:58:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n21sm10519669pfb.42.2019.04.18.12.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:58:29 -0700 (PDT)
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
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/6] hwmon: (mlxreg-fan) Use devm_thermal_of_cooling_device_register
Date:   Thu, 18 Apr 2019 12:58:18 -0700
Message-Id: <1555617500-10862-5-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call devm_thermal_of_cooling_device_register() to register the cooling
device. Also introduce struct device *dev = &pdev->dev; to make the code
easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/mlxreg-fan.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index db8c6de0b6a0..a14347ea0d77 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -420,42 +420,42 @@ static int mlxreg_fan_config(struct mlxreg_fan *fan,
 static int mlxreg_fan_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *pdata;
+	struct device *dev = &pdev->dev;
 	struct mlxreg_fan *fan;
 	struct device *hwm;
 	int err;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "Failed to get platform data.\n");
+		dev_err(dev, "Failed to get platform data.\n");
 		return -EINVAL;
 	}
 
-	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
+	fan = devm_kzalloc(dev, sizeof(*fan), GFP_KERNEL);
 	if (!fan)
 		return -ENOMEM;
 
-	fan->dev = &pdev->dev;
+	fan->dev = dev;
 	fan->regmap = pdata->regmap;
-	platform_set_drvdata(pdev, fan);
 
 	err = mlxreg_fan_config(fan, pdata);
 	if (err)
 		return err;
 
-	hwm = devm_hwmon_device_register_with_info(&pdev->dev, "mlxreg_fan",
+	hwm = devm_hwmon_device_register_with_info(dev, "mlxreg_fan",
 						   fan,
 						   &mlxreg_fan_hwmon_chip_info,
 						   NULL);
 	if (IS_ERR(hwm)) {
-		dev_err(&pdev->dev, "Failed to register hwmon device\n");
+		dev_err(dev, "Failed to register hwmon device\n");
 		return PTR_ERR(hwm);
 	}
 
 	if (IS_REACHABLE(CONFIG_THERMAL)) {
-		fan->cdev = thermal_cooling_device_register("mlxreg_fan", fan,
-						&mlxreg_fan_cooling_ops);
+		fan->cdev = devm_thermal_of_cooling_device_register(dev,
+			NULL, "mlxreg_fan", fan, &mlxreg_fan_cooling_ops);
 		if (IS_ERR(fan->cdev)) {
-			dev_err(&pdev->dev, "Failed to register cooling device\n");
+			dev_err(dev, "Failed to register cooling device\n");
 			return PTR_ERR(fan->cdev);
 		}
 	}
@@ -463,22 +463,11 @@ static int mlxreg_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mlxreg_fan_remove(struct platform_device *pdev)
-{
-	struct mlxreg_fan *fan = platform_get_drvdata(pdev);
-
-	if (IS_REACHABLE(CONFIG_THERMAL))
-		thermal_cooling_device_unregister(fan->cdev);
-
-	return 0;
-}
-
 static struct platform_driver mlxreg_fan_driver = {
 	.driver = {
 	    .name = "mlxreg-fan",
 	},
 	.probe = mlxreg_fan_probe,
-	.remove = mlxreg_fan_remove,
 };
 
 module_platform_driver(mlxreg_fan_driver);
-- 
2.7.4

