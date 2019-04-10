Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35463C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E6A20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuzrEs3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfDJQ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33100 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbfDJQ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so1806858pfo.0;
        Wed, 10 Apr 2019 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIFkfAZMLG3ZtjNbK1/QwyzTqgHbls9I5r5J/yPn+AM=;
        b=UuzrEs3D/iI4GnkUQsBc1f5DUUAWNrrCSXsMdOWmJOxXYH2MGmZffr+4yqKSZ3d1rS
         IXm+w43bLGo+1RzvRlYWQeF4k2eOFjV99y9SDZrcar7g9Jp26rLFn5pjC2ImL0qU6/PB
         S/N+eGn7dTQUOQY3zs6Zuqbn/cZnxfHowWx+fVOOTZS3nMLZvxvGQ/zBdN6YSUnwosee
         F5BeRvOmCrvsZH6hBKApEYTKeZqHTxZb+95Qa4iUrfnyxuzhJtdCd+YFZCDsFbugbmob
         m2oe6KXzTSLK+q27IXF8fHbAMNbRHh1EDYtWB2OABoWpN98RfIEWsDDdAoHAkcKkSE6Z
         RtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZIFkfAZMLG3ZtjNbK1/QwyzTqgHbls9I5r5J/yPn+AM=;
        b=EPDOdsBEYPb7QJCKLOTQ2Q+jiH5fXcwzU3U77BtRf1erWf/FCLp+m9T853V/KE+jBw
         w/dbdEwzpGAbQyTDaR5tXS06sJk/YYlHkCUJANKeoGqWXszA6whwF8rNZbsVuk7ni+Mb
         /yTC/hAUJuNzfDNccYUdSP/s3G3fjzTW15c7J4mkUKMNuuB2K+2FrRaNmmWyYfU+bpqS
         fz49zJX8CcKyB1WrZq9kPBf30+AruBccRmIuSUYiT8dMQQzfFOkEebhl4zU6+papcwwb
         Ap/2dy8FP07dGVHP3v8CkzOhgApVz1kkmuK5FOypzuVg6Bkdgw+PFAyOi42w4svj3jDu
         slhg==
X-Gm-Message-State: APjAAAXdaO8ByukW9vL1lE+JwYNEUlUj3e7zga8mK483GHPUaCbp7ChX
        HnpZZSrI7WKNS/lpP9TZay8=
X-Google-Smtp-Source: APXvYqzyEHlqxTJGrUfXPg7Z3KBRGvKQpyVsi+uIBSjC+6/o7VKpiX0xSAjPnN2QPUB2y14UM1+Sew==
X-Received: by 2002:a63:36ce:: with SMTP id d197mr42761951pga.180.1554913714112;
        Wed, 10 Apr 2019 09:28:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n5sm42295817pgp.80.2019.04.10.09.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:33 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 19/22] watchdog: rt2880_wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:28:00 -0700
Message-Id: <1554913683-25454-20-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
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

- Drop empty remove function
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/rt2880_wdt.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 4adf5f39fdd9..905e60f45eec 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -141,17 +141,18 @@ static struct watchdog_device rt288x_wdt_dev = {
 
 static int rt288x_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	rt288x_wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rt288x_wdt_base))
 		return PTR_ERR(rt288x_wdt_base);
 
-	rt288x_wdt_clk = devm_clk_get(&pdev->dev, NULL);
+	rt288x_wdt_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(rt288x_wdt_clk))
 		return PTR_ERR(rt288x_wdt_clk);
 
-	rt288x_wdt_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	rt288x_wdt_reset = devm_reset_control_get_exclusive(dev, NULL);
 	if (!IS_ERR(rt288x_wdt_reset))
 		reset_control_deassert(rt288x_wdt_reset);
 
@@ -159,31 +160,20 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 
 	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
 	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
-	rt288x_wdt_dev.parent = &pdev->dev;
+	rt288x_wdt_dev.parent = dev;
 
 	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
-			      &pdev->dev);
+			      dev);
 	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
 
-	ret = watchdog_register_device(&rt288x_wdt_dev);
+	watchdog_stop_on_reboot(&rt288x_wdt_dev);
+	ret = devm_watchdog_register_device(dev, &rt288x_wdt_dev);
 	if (!ret)
-		dev_info(&pdev->dev, "Initialized\n");
+		dev_info(dev, "Initialized\n");
 
 	return 0;
 }
 
-static int rt288x_wdt_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&rt288x_wdt_dev);
-
-	return 0;
-}
-
-static void rt288x_wdt_shutdown(struct platform_device *pdev)
-{
-	rt288x_wdt_stop(&rt288x_wdt_dev);
-}
-
 static const struct of_device_id rt288x_wdt_match[] = {
 	{ .compatible = "ralink,rt2880-wdt" },
 	{},
@@ -192,8 +182,6 @@ MODULE_DEVICE_TABLE(of, rt288x_wdt_match);
 
 static struct platform_driver rt288x_wdt_driver = {
 	.probe		= rt288x_wdt_probe,
-	.remove		= rt288x_wdt_remove,
-	.shutdown	= rt288x_wdt_shutdown,
 	.driver		= {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= rt288x_wdt_match,
-- 
2.7.4

