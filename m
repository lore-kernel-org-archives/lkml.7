Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E0C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666A820880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk2bovSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfDHTlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:41:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43594 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDHTjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so3348980plp.10;
        Mon, 08 Apr 2019 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tratJcb8Iua0rnSEaA89+NPVkvokWzZYSDeGf4OVw4I=;
        b=Zk2bovSywM3Ur+04hllbLRzaUD91Wx6PzV/4XuB9A1DxaZwJu3Zh0d7Uc+UXPVAJPB
         KbHOXWuXRSYDu0s/rHiQNC8HqJAWZZ4w0eyMqojEAM2CBCgjSUs9+yiDnD3h2HWNzMHV
         uTKMp5bSgjYXSgU6c9wjCLYjJxVazgRG1GaeQ5PvLXZZK/9wAV0XhGAXiJ6RM3pvA8vV
         bG22J/yP5Oyi+iZYiMT1lDTtm7s2SFC0oCL0NtpylsnqwNdXybaqBi7T8+w+vTm5a++J
         xdm5dp2eoFKYdfZBOcWcZtVv/wEGwCSFM2Jrq6eCp6rAomk1DqPJLzPzkyre7x2tLyoh
         Vhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=tratJcb8Iua0rnSEaA89+NPVkvokWzZYSDeGf4OVw4I=;
        b=EwkLVMaVfusCT0dhPGeYy5LuZ3v/Ti2PCVKhWa5eBrvHbPGiaQ9CBtUlNoIDn32v42
         GvKGnlUfNHW+4PEV2a45GDaAWKk0q0XbfLNJUgUDUxgVybTuuyYKBMclpUDn5FOqNi7T
         BHxXpMjNlGax516kuyOAHUNdYSqA5thkVoQCkL2PzPXZLo8MRsDK1ADhS+pMksrTL+Q7
         3nRZVi3S8N82gBauYeFZOg3utCAWriumsk1Tqk3TLZGF93dC3jrz4RM5uZiZbDxc9Jm3
         FEa+sdqLQKAf7PxXPOXdl1ig0vQi+L20VvQ2TT6yV7RUxCUhb6ZjjC6ymX+GTEKGvYBr
         QSHg==
X-Gm-Message-State: APjAAAW25AUVWNbf0rj6Dn81RAXsNbCKYtC+E8gF/wJarfrL8wBC2Dxw
        6O6e4rWf5nnfjsBlJfRR3V8=
X-Google-Smtp-Source: APXvYqxWj89KBIYtugNnCerajl7uEOwhQXJ0MbWG2xRvyjZjtu7xrZVFYf0xInMYKZx0s8pjf6/RgQ==
X-Received: by 2002:a17:902:820c:: with SMTP id x12mr32397325pln.199.1554752388568;
        Mon, 08 Apr 2019 12:39:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v189sm80671830pgd.77.2019.04.08.12.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:48 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/22] watchdog: cadence_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:32 -0700
Message-Id: <1554752326-13319-9-git-send-email-linux@roeck-us.net>
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
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/cadence_wdt.c | 83 ++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 56 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 5986f18f97e2..c5051907df00 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -274,6 +274,11 @@ static const struct watchdog_ops cdns_wdt_ops = {
 	.set_timeout = cdns_wdt_settimeout,
 };
 
+static void cdns_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 /************************Platform Operations*****************************/
 /**
  * cdns_wdt_probe - Probe call for the device.
@@ -285,12 +290,13 @@ static const struct watchdog_ops cdns_wdt_ops = {
  */
 static int cdns_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret, irq;
 	unsigned long clock_f;
 	struct cdns_wdt *wdt;
 	struct watchdog_device *cdns_wdt_device;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -306,13 +312,13 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 		return PTR_ERR(wdt->regs);
 
 	/* Register the interrupt */
-	wdt->rst = of_property_read_bool(pdev->dev.of_node, "reset-on-timeout");
+	wdt->rst = of_property_read_bool(dev->of_node, "reset-on-timeout");
 	irq = platform_get_irq(pdev, 0);
 	if (!wdt->rst && irq >= 0) {
-		ret = devm_request_irq(&pdev->dev, irq, cdns_wdt_irq_handler, 0,
+		ret = devm_request_irq(dev, irq, cdns_wdt_irq_handler, 0,
 				       pdev->name, pdev);
 		if (ret) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"cannot register interrupt handler err=%d\n",
 				ret);
 			return ret;
@@ -320,11 +326,11 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize the members of cdns_wdt structure */
-	cdns_wdt_device->parent = &pdev->dev;
+	cdns_wdt_device->parent = dev;
 
-	ret = watchdog_init_timeout(cdns_wdt_device, wdt_timeout, &pdev->dev);
+	ret = watchdog_init_timeout(cdns_wdt_device, wdt_timeout, dev);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to set timeout value\n");
+		dev_err(dev, "unable to set timeout value\n");
 		return ret;
 	}
 
@@ -332,18 +338,21 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	watchdog_stop_on_reboot(cdns_wdt_device);
 	watchdog_set_drvdata(cdns_wdt_device, wdt);
 
-	wdt->clk = devm_clk_get(&pdev->dev, NULL);
+	wdt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(wdt->clk)) {
-		dev_err(&pdev->dev, "input clock not found\n");
-		ret = PTR_ERR(wdt->clk);
-		return ret;
+		dev_err(dev, "input clock not found\n");
+		return PTR_ERR(wdt->clk);
 	}
 
 	ret = clk_prepare_enable(wdt->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to enable clock\n");
+		dev_err(dev, "unable to enable clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, cdns_clk_disable_unprepare,
+				       wdt->clk);
+	if (ret)
+		return ret;
 
 	clock_f = clk_get_rate(wdt->clk);
 	if (clock_f <= CDNS_WDT_CLK_75MHZ) {
@@ -356,56 +365,20 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 
 	spin_lock_init(&wdt->io_lock);
 
-	ret = watchdog_register_device(cdns_wdt_device);
+	watchdog_stop_on_reboot(cdns_wdt_device);
+	watchdog_stop_on_unregister(cdns_wdt_device);
+	ret = devm_watchdog_register_device(dev, cdns_wdt_device);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register wdt device\n");
-		goto err_clk_disable;
+		dev_err(dev, "Failed to register wdt device\n");
+		return ret;
 	}
 	platform_set_drvdata(pdev, wdt);
 
-	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
+	dev_info(dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
 		 wdt->regs, cdns_wdt_device->timeout,
 		 nowayout ? ", nowayout" : "");
 
 	return 0;
-
-err_clk_disable:
-	clk_disable_unprepare(wdt->clk);
-
-	return ret;
-}
-
-/**
- * cdns_wdt_remove - Probe call for the device.
- *
- * @pdev: handle to the platform device structure.
- * Return: 0 on success, otherwise negative error.
- *
- * Unregister the device after releasing the resources.
- */
-static int cdns_wdt_remove(struct platform_device *pdev)
-{
-	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
-
-	cdns_wdt_stop(&wdt->cdns_wdt_device);
-	watchdog_unregister_device(&wdt->cdns_wdt_device);
-	clk_disable_unprepare(wdt->clk);
-
-	return 0;
-}
-
-/**
- * cdns_wdt_shutdown - Stop the device.
- *
- * @pdev: handle to the platform structure.
- *
- */
-static void cdns_wdt_shutdown(struct platform_device *pdev)
-{
-	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
-
-	cdns_wdt_stop(&wdt->cdns_wdt_device);
-	clk_disable_unprepare(wdt->clk);
 }
 
 /**
@@ -460,8 +433,6 @@ MODULE_DEVICE_TABLE(of, cdns_wdt_of_match);
 /* Driver Structure */
 static struct platform_driver cdns_wdt_driver = {
 	.probe		= cdns_wdt_probe,
-	.remove		= cdns_wdt_remove,
-	.shutdown	= cdns_wdt_shutdown,
 	.driver		= {
 		.name	= "cdns-wdt",
 		.of_match_table = cdns_wdt_of_match,
-- 
2.7.4

