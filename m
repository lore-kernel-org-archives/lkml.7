Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE67C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B80120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAFvQ5zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfDHTlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:41:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45950 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfDHTjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so8192570pfi.12;
        Mon, 08 Apr 2019 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=meLAD+DIRCeVzo4Af4ZKbYchnE6bZYikYlq7WnlFmvk=;
        b=gAFvQ5zr4J9jE74VwbVs3gUDQ97/w7t4usH9xYXgZ0n6MqAa5ujFsq2/J7WYCdO838
         UeXcNCT8dLohEirg/pafbacDryKiAe6WfuXfuY9s6xWXrEORXeVoH4Ek8112yQwUdLbG
         g4L+jFYJwCb2+mvg9XKBpch/gKbQl1bxe1PUQvA9L+Bbl8v0+xxpENzdSHg9zh0iMnBh
         u3oxhKtT4hhUg7DzxjXmNYZ/2Qvd1gShzssF4aL1LKWLpdTSlnLfrGyjx6+7VZjkS1sY
         DhKHr9XMyZENfxdOWQxUsSiokCcX1vcCZfpGYisNmxY/xo+cQ2O0TVcrh+azFlcRKhbT
         DXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=meLAD+DIRCeVzo4Af4ZKbYchnE6bZYikYlq7WnlFmvk=;
        b=r20Q+3UEQQYMWOZiXvAMKLyPTl4cVFr1qOANazqOBbrYnbMO0JKIwTiB6IQxxfpoob
         pnxaSv7MKz9DeHCdhOkyHW83vT9bsZKgTYJbYZ37+2rwJDMYj1k1WoHrWRDhqAfurzw6
         UR1dviz6Bv6T0x3fyaLtMQa2TMUugRyaPyQlfUGdjSwtZYJtwe4Amnl5j0nXY0wQQWa9
         uQGF1WPm1ee9HKaPrmSB6BKGnXBr593DaR7u/+Gwh8tz0R8Iri6xbVMGtXvTWfb6SUPV
         Nxlhx7pvuvSFi/HRrPmn0cyO92RYnOb+vabt+IQ2ExxoLxh9ajHZaQ2dCQtKhUsQ+Hno
         qs7A==
X-Gm-Message-State: APjAAAUi8e07gyTHH4/U/cTnchkJAdI2MyInCODoapgcrNRcC/bWX3ZK
        jPqpV/2NH1DENBpta12p3d2OwKxn
X-Google-Smtp-Source: APXvYqxGFayllojPsdajA+bDfCNiiZHVEKIiy1BhKYJ4IPmDsY7uYcs6rtAhvoJtNwpdY5TPkPS7eA==
X-Received: by 2002:a65:5106:: with SMTP id f6mr29649210pgq.253.1554752385664;
        Mon, 08 Apr 2019 12:39:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm41393928pfn.62.2019.04.08.12.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:45 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/22] watchdog: bcm7038_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:30 -0700
Message-Id: <1554752326-13319-7-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
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
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use local variable 'struct device *dev' consistently
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm7038_wdt.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index 71fca45eab5d..d3d88f6703d7 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -107,6 +107,11 @@ static const struct watchdog_ops bcm7038_wdt_ops = {
 	.get_timeleft	= bcm7038_wdt_get_timeleft,
 };
 
+static void bcm7038_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int bcm7038_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -129,6 +134,11 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 		err = clk_prepare_enable(wdt->clk);
 		if (err)
 			return err;
+		err = devm_add_action_or_reset(dev,
+					       bcm7038_clk_disable_unprepare,
+					       wdt->clk);
+		if (err)
+			return err;
 		wdt->rate = clk_get_rate(wdt->clk);
 		/* Prevent divide-by-zero exception */
 		if (!wdt->rate)
@@ -146,10 +156,11 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.parent		= dev;
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
-	err = watchdog_register_device(&wdt->wdd);
+	watchdog_stop_on_reboot(&wdt->wdd);
+	watchdog_stop_on_unregister(&wdt->wdd);
+	err = devm_watchdog_register_device(dev, &wdt->wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device\n");
-		clk_disable_unprepare(wdt->clk);
 		return err;
 	}
 
@@ -158,19 +169,6 @@ static int bcm7038_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int bcm7038_wdt_remove(struct platform_device *pdev)
-{
-	struct bcm7038_watchdog *wdt = platform_get_drvdata(pdev);
-
-	if (!nowayout)
-		bcm7038_wdt_stop(&wdt->wdd);
-
-	watchdog_unregister_device(&wdt->wdd);
-	clk_disable_unprepare(wdt->clk);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int bcm7038_wdt_suspend(struct device *dev)
 {
@@ -196,14 +194,6 @@ static int bcm7038_wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(bcm7038_wdt_pm_ops, bcm7038_wdt_suspend,
 			 bcm7038_wdt_resume);
 
-static void bcm7038_wdt_shutdown(struct platform_device *pdev)
-{
-	struct bcm7038_watchdog *wdt = platform_get_drvdata(pdev);
-
-	if (watchdog_active(&wdt->wdd))
-		bcm7038_wdt_stop(&wdt->wdd);
-}
-
 static const struct of_device_id bcm7038_wdt_match[] = {
 	{ .compatible = "brcm,bcm7038-wdt" },
 	{},
@@ -212,8 +202,6 @@ MODULE_DEVICE_TABLE(of, bcm7038_wdt_match);
 
 static struct platform_driver bcm7038_wdt_driver = {
 	.probe		= bcm7038_wdt_probe,
-	.remove		= bcm7038_wdt_remove,
-	.shutdown	= bcm7038_wdt_shutdown,
 	.driver		= {
 		.name		= "bcm7038-wdt",
 		.of_match_table	= bcm7038_wdt_match,
-- 
2.7.4

