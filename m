Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ACBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE69120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNfv6zDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfDHTjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44879 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDHTjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so7892029pll.11;
        Mon, 08 Apr 2019 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9QzejewaFdMKjPQNyj8Ku/+3qlbUdJ83+naJQ570xrE=;
        b=GNfv6zDb32qh0zEdHefmpQoYu8Ae0k0ZB2yN9h/QU604LhJHiGC4pl1W1buJKJi9FA
         cEwLxHJiqXiPBYDvW8NJPZ+//sbOb4jqss+tO5PydCFcqQs4xKrK9YE0wA9rOCv8dP2G
         h3cU5LOac7EQ8gAH9DwrJ2SI7BVa+o3skRdKt+Egrzu89OLL7/V2oc0Mz2Eu2n6ML7+e
         VsuEJVqJGI4gaS0zXkcJSfkE0DgjsZYlauwnwm1pN+j/xi221V1LqODX+sGGyVZplzrn
         iMJmJWG1eTxVaUu09GETwIMWQzjHLy/XyQUyFL9SUwA5pHTjpS7jJApNpXNLKGU8AIOP
         XZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=9QzejewaFdMKjPQNyj8Ku/+3qlbUdJ83+naJQ570xrE=;
        b=D+ECQul8S0qDFhzmqCIylVT4FL1YBb6W8Cd7O7olzbA6CymGiod78Am9IvFBdi5lpy
         ueM2TyVRqv2oCiQumyiHRJF0GzayuVVb1uoDf2Nm+m7nS6YFNQ++JUDS570h0R6oWRjG
         HqRrNcr4TFoEIE2uY7eHMQyWFaJEqdM46DKWi8V6PMmcW1k3M/ek4A5F90wmjMvzCTEh
         hGIwSD050uCMj4DUTYxI1z1gb9wxTHgWqg3LPqoh1uh5DaNnP8etQNzSezPwAVe77sNc
         czByJn9J76uQLngl+kvgd4hoBjU4LUVw890TAqiuYtCQ6kQuPQoNkIPCEd/GY+cjum/A
         0pmQ==
X-Gm-Message-State: APjAAAVOOPrXc77HZyu09/vEsrm/2woPchep4ZGTRReDnmznoB6Xmv0C
        Pa17aDWt/2lFslofNA+w9q00g5y2
X-Google-Smtp-Source: APXvYqx9fezUY/IN0+pySCDULfKzbUUQcMoeOk1G1rU9Kk96vk8IYC1XFFWQGF5QS34GjNHPP1hsuw==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr32624572plz.216.1554752378716;
        Mon, 08 Apr 2019 12:39:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1sm35371700pgv.19.2019.04.08.12.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:38 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/22] watchdog: armada_37xx_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:25 -0700
Message-Id: <1554752326-13319-2-git-send-email-linux@roeck-us.net>
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
- Drop unnecessary braces around conditional return statements
- Drop empty remove function
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/armada_37xx_wdt.c | 43 +++++++++++++-------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
index 4b4054f54df9..e5dcb26d85f0 100644
--- a/drivers/watchdog/armada_37xx_wdt.c
+++ b/drivers/watchdog/armada_37xx_wdt.c
@@ -244,6 +244,11 @@ static const struct watchdog_ops armada_37xx_wdt_ops = {
 	.get_timeleft = armada_37xx_wdt_get_timeleft,
 };
 
+static void armada_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int armada_37xx_wdt_probe(struct platform_device *pdev)
 {
 	struct armada_37xx_watchdog *dev;
@@ -278,12 +283,14 @@ static int armada_37xx_wdt_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(dev->clk);
 	if (ret)
 		return ret;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       armada_clk_disable_unprepare, dev->clk);
+	if (ret)
+		return ret;
 
 	dev->clk_rate = clk_get_rate(dev->clk);
-	if (!dev->clk_rate) {
-		ret = -EINVAL;
-		goto disable_clk;
-	}
+	if (!dev->clk_rate)
+		return -EINVAL;
 
 	/*
 	 * Since the timeout in seconds is given as 32 bit unsigned int, and
@@ -307,35 +314,15 @@ static int armada_37xx_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
 
 	watchdog_set_nowayout(&dev->wdt, nowayout);
-	ret = watchdog_register_device(&dev->wdt);
+	watchdog_stop_on_reboot(&dev->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &dev->wdt);
 	if (ret)
-		goto disable_clk;
+		return ret;
 
 	dev_info(&pdev->dev, "Initial timeout %d sec%s\n",
 		 dev->wdt.timeout, nowayout ? ", nowayout" : "");
 
 	return 0;
-
-disable_clk:
-	clk_disable_unprepare(dev->clk);
-	return ret;
-}
-
-static int armada_37xx_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdt = platform_get_drvdata(pdev);
-	struct armada_37xx_watchdog *dev = watchdog_get_drvdata(wdt);
-
-	watchdog_unregister_device(wdt);
-	clk_disable_unprepare(dev->clk);
-	return 0;
-}
-
-static void armada_37xx_wdt_shutdown(struct platform_device *pdev)
-{
-	struct watchdog_device *wdt = platform_get_drvdata(pdev);
-
-	armada_37xx_wdt_stop(wdt);
 }
 
 static int __maybe_unused armada_37xx_wdt_suspend(struct device *dev)
@@ -370,8 +357,6 @@ MODULE_DEVICE_TABLE(of, armada_37xx_wdt_match);
 
 static struct platform_driver armada_37xx_wdt_driver = {
 	.probe		= armada_37xx_wdt_probe,
-	.remove		= armada_37xx_wdt_remove,
-	.shutdown	= armada_37xx_wdt_shutdown,
 	.driver		= {
 		.name	= "armada_37xx_wdt",
 		.of_match_table = of_match_ptr(armada_37xx_wdt_match),
-- 
2.7.4

