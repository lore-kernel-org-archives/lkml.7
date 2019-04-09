Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84462C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5642A2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLLKyga6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDIRZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:25:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37781 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDIRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so9810934ply.4;
        Tue, 09 Apr 2019 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HlrSdebMSpMB59zkY9xN76aLFZr/Ctm0yTCe9ZBi980=;
        b=HLLKyga69ly1A+xOgUCvVvP97m8rZDtjUrGpSm5S7PhTcxgLf/j6rKSxEl3pnBqG+u
         49YcO+2vDBZBcrEzUZJdpJJ/zZHVJbv069rz3h+XbO/dMFGQW0O8jjkU3JSik18dIVKH
         qlaXuutwWDB22uoe03gfe3vkixisvDR6uo26U3C5vrd6iWjPOpSpC0DOFlqvwocmhQQ4
         SRrBZlpwjRtDj14riwj5QmyhAT4I19hJHiSk+CTehFSeBkJMR6D5GRjX6ee6MTNRe58o
         CLk59fzW41eu9BbZLLI2ER8tTnJiP7C5axwXcRy9ZNoDJGxXWF0Gg2ESy+nlepu/p10P
         Qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=HlrSdebMSpMB59zkY9xN76aLFZr/Ctm0yTCe9ZBi980=;
        b=eC2R6TVeVBiG01xumCZHcnC7UQAFtqFG5Q+/hN2fswFaBF8xfOv9xXBfzb85YlVEbX
         qx1a8FcAEb2A+mAlTQ/1vtWd6R96bKO2gPOlVoGzmFdTIB+F9aGdvIJ92faMZv8iUOPf
         XG7Hm3c26WKEl4oDdYtb31vX3NdVj9GLVO75bK1QmbeTxg9w8+6onscgKqDh7Pp7GHzN
         sD2MrWs/gPwNFx6y+fF9yGm3y+3d6lyr9DQIEhVav5DwbFxPoxBNmSY3sSh+dGjNw47s
         xXXnbaiQ8wghdM6tjIcEL4KY1688IUGurr1kMvpuslHHachMuBfngL4jtV7U4tU6jJOY
         eIrg==
X-Gm-Message-State: APjAAAUFohICE5UTbbfjilw7xz4IdUKtj1EteZ84yQeJB9vr2iYOiOEx
        YObxP2nq4cgncOtePQQagtA=
X-Google-Smtp-Source: APXvYqxVvzSxIHnrbUQ/MfrN6XcZFUz8agbNWg0zJwbhRlF4CoN6VFKCQsSaIWtjqhYtA3rqZv49cw==
X-Received: by 2002:a17:902:168:: with SMTP id 95mr37424847plb.212.1554830674203;
        Tue, 09 Apr 2019 10:24:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9sm30813023pfc.43.2019.04.09.10.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:33 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 16/23] watchdog: sama5d4_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:54 -0700
Message-Id: <1554830641-9247-17-git-send-email-linux@roeck-us.net>
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
- Replace stop on remove with call to watchdog_stop_on_unregister()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sama5d4_wdt.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index ea72fa0aa3ec..111695223aae 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -199,6 +199,7 @@ static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
 
 static int sama5d4_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct sama5d4_wdt *wdt;
 	void __iomem *regs;
@@ -206,7 +207,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	u32 timeout;
 	int ret;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -226,26 +227,25 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 
 	wdt->reg_base = regs;
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!irq)
-		dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
+		dev_warn(dev, "failed to get IRQ from DT\n");
 
-	ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
+	ret = of_sama5d4_wdt_init(dev->of_node, wdt);
 	if (ret)
 		return ret;
 
 	if ((wdt->mr & AT91_WDT_WDFIEN) && irq) {
-		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
+		ret = devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
 				       IRQF_SHARED | IRQF_IRQPOLL |
 				       IRQF_NO_SUSPEND, pdev->name, pdev);
 		if (ret) {
-			dev_err(&pdev->dev,
-				"cannot register interrupt handler\n");
+			dev_err(dev, "cannot register interrupt handler\n");
 			return ret;
 		}
 	}
 
-	watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
+	watchdog_init_timeout(wdd, wdt_timeout, dev);
 
 	timeout = WDT_SEC2TICKS(wdd->timeout);
 
@@ -258,31 +258,21 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(wdd, nowayout);
 
-	ret = watchdog_register_device(wdd);
+	watchdog_stop_on_unregister(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register watchdog device\n");
+		dev_err(dev, "failed to register watchdog device\n");
 		return ret;
 	}
 
 	platform_set_drvdata(pdev, wdt);
 
-	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
+	dev_info(dev, "initialized (timeout = %d sec, nowayout = %d)\n",
 		 wdd->timeout, nowayout);
 
 	return 0;
 }
 
-static int sama5d4_wdt_remove(struct platform_device *pdev)
-{
-	struct sama5d4_wdt *wdt = platform_get_drvdata(pdev);
-
-	sama5d4_wdt_stop(&wdt->wdd);
-
-	watchdog_unregister_device(&wdt->wdd);
-
-	return 0;
-}
-
 static const struct of_device_id sama5d4_wdt_of_match[] = {
 	{ .compatible = "atmel,sama5d4-wdt", },
 	{ }
@@ -310,7 +300,6 @@ static SIMPLE_DEV_PM_OPS(sama5d4_wdt_pm_ops, NULL,
 
 static struct platform_driver sama5d4_wdt_driver = {
 	.probe		= sama5d4_wdt_probe,
-	.remove		= sama5d4_wdt_remove,
 	.driver		= {
 		.name	= "sama5d4_wdt",
 		.pm	= &sama5d4_wdt_pm_ops,
-- 
2.7.4

