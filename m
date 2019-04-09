Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63444C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324262084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnOq0YDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDIRYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46072 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDIRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so9669552pgk.12;
        Tue, 09 Apr 2019 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x4NI7aKQEmDUDGqQdkRAf06VY55NwroheFeIzCPepUQ=;
        b=UnOq0YDX3I9UMOlMOLvNS2ULRhEgKW7pcqv2y95ITByii3wQ8pU3wf8+/uNvAmfDaO
         VOM2SvxJT+k185Xp1W9ZOkDoUYeHjoDUkNXtqpCiPyrejV6F0n7b1vw7peDohh/UFPoe
         81vRshgsQGL6wFJTqMtn6ComOairMooEUopVEBCCwaSqt6iql3NAnviNOYpOSuSlNzm4
         07IQR+iXUY18ldsCr4ZY19DzqurMJuv9vTJv0b6K4bSGiCguncLGsBpxRdUPKWRbMD4I
         Jc9yWEakMrCCW1lJ9yQG5bVG03iwV3ZF0VMYZ1Vgzrg6lYEPXHJa7fp0soAx1pNkY+Tf
         cQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=x4NI7aKQEmDUDGqQdkRAf06VY55NwroheFeIzCPepUQ=;
        b=ZheYS9dEpfi1OXYh/h7TASBIyU/y46yZmk+hlASDJgnRdClS6nZFm0k+pgevaOpUcn
         rJ2PSb6Xs/4+8QMeb1nw4eE+QCZCnoSGC1bg81/3cCOJ7akof9agoHPoItdAdEqnI4Rg
         Uga8ZY2V1lIgk69ldZyaClO5dAZ1BmNdmv8tLqTmKt4QXU4NnhjG9dnbe/OfHnr6TVn7
         LKtZunYBIXrubJ+LpiKNw7ZI0d3eIIej9ZcM4SIIkuJWSSFReEuGDSLZsvxukuGxGl4W
         kd5I3XhHjWCSX2sZRzjAcExUNy/lisP1XIX7Rggd0CEpyDdq3QC0rWOhFfhzwGE/q29u
         HZxA==
X-Gm-Message-State: APjAAAW9YxIoOAgb5P9Cdg2hk0i5LnHlDBUy4jZ4rVjzUPTLfhf/XGzr
        pIn4xH0I0JsI4CHLdJbEcwI9Xv+V
X-Google-Smtp-Source: APXvYqwab62fyJkIdplK9SJ1FoLww3q88qk8OIJO6jRcWdGmsgH2x7dR9I4+Lp37LQLWdJ+pLFSi4Q==
X-Received: by 2002:a63:b811:: with SMTP id p17mr35932710pge.219.1554830655878;
        Tue, 09 Apr 2019 10:24:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z22sm17527816pgv.23.2019.04.09.10.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:15 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Andreas Werner <andreas.werner@men.de>
Subject: [PATCH 03/23] watchdog: menf21bmc_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:41 -0700
Message-Id: <1554830641-9247-4-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop empty remove function
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Andreas Werner <andreas.werner@men.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/menf21bmc_wdt.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/watchdog/menf21bmc_wdt.c b/drivers/watchdog/menf21bmc_wdt.c
index 3aefddebb386..b1dbff553cdc 100644
--- a/drivers/watchdog/menf21bmc_wdt.c
+++ b/drivers/watchdog/menf21bmc_wdt.c
@@ -117,12 +117,12 @@ static const struct watchdog_ops menf21bmc_wdt_ops = {
 
 static int menf21bmc_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret, bmc_timeout;
 	struct menf21bmc_wdt *drv_data;
-	struct i2c_client *i2c_client = to_i2c_client(pdev->dev.parent);
+	struct i2c_client *i2c_client = to_i2c_client(dev->parent);
 
-	drv_data = devm_kzalloc(&pdev->dev,
-				sizeof(struct menf21bmc_wdt), GFP_KERNEL);
+	drv_data = devm_kzalloc(dev, sizeof(struct menf21bmc_wdt), GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
 
@@ -130,7 +130,7 @@ static int menf21bmc_wdt_probe(struct platform_device *pdev)
 	drv_data->wdt.info = &menf21bmc_wdt_info;
 	drv_data->wdt.min_timeout = BMC_WD_TIMEOUT_MIN;
 	drv_data->wdt.max_timeout = BMC_WD_TIMEOUT_MAX;
-	drv_data->wdt.parent = &pdev->dev;
+	drv_data->wdt.parent = dev;
 	drv_data->i2c_client = i2c_client;
 
 	/*
@@ -140,40 +140,28 @@ static int menf21bmc_wdt_probe(struct platform_device *pdev)
 	bmc_timeout = i2c_smbus_read_word_data(drv_data->i2c_client,
 					       BMC_CMD_WD_TIME);
 	if (bmc_timeout < 0) {
-		dev_err(&pdev->dev, "failed to get current WDT timeout\n");
+		dev_err(dev, "failed to get current WDT timeout\n");
 		return bmc_timeout;
 	}
 
-	watchdog_init_timeout(&drv_data->wdt, bmc_timeout / 10, &pdev->dev);
+	watchdog_init_timeout(&drv_data->wdt, bmc_timeout / 10, dev);
 	watchdog_set_nowayout(&drv_data->wdt, nowayout);
 	watchdog_set_drvdata(&drv_data->wdt, drv_data);
 	platform_set_drvdata(pdev, drv_data);
 
 	ret = menf21bmc_wdt_set_bootstatus(drv_data);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to set Watchdog bootstatus\n");
+		dev_err(dev, "failed to set Watchdog bootstatus\n");
 		return ret;
 	}
 
-	ret = watchdog_register_device(&drv_data->wdt);
+	ret = devm_watchdog_register_device(dev, &drv_data->wdt);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register Watchdog device\n");
+		dev_err(dev, "failed to register Watchdog device\n");
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "MEN 14F021P00 BMC Watchdog device enabled\n");
-
-	return 0;
-}
-
-static int menf21bmc_wdt_remove(struct platform_device *pdev)
-{
-	struct menf21bmc_wdt *drv_data = platform_get_drvdata(pdev);
-
-	dev_warn(&pdev->dev,
-		 "Unregister MEN 14F021P00 BMC Watchdog device, board may reset\n");
-
-	watchdog_unregister_device(&drv_data->wdt);
+	dev_info(dev, "MEN 14F021P00 BMC Watchdog device enabled\n");
 
 	return 0;
 }
@@ -191,7 +179,6 @@ static struct  platform_driver menf21bmc_wdt = {
 		.name	= DEVNAME,
 	},
 	.probe		= menf21bmc_wdt_probe,
-	.remove		= menf21bmc_wdt_remove,
 	.shutdown	= menf21bmc_wdt_shutdown,
 };
 
-- 
2.7.4

