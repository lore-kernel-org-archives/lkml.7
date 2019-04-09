Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2FFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3D02084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf7voPLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfDIRZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:25:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44377 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfDIRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so10095408pfm.11;
        Tue, 09 Apr 2019 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MUlrOc0HiJHRTPNOKs/f+k1Z+oIQtcna7qAe/Y1Um4=;
        b=Tf7voPLO3YZyyvjoPhKA55fjMXGPckPHhuKqPs/zJuKMFQqdDboJMxxw+wNjDH+NN4
         su6u8KalO1AWWle/fwU7PDanEvUdmyvai92GnZWucZEBr/TDcPq3LuWw8U0BEuWMKZpr
         wd2Lu3lTp2LIVj0tMqP4EY1fRarbkGaxyiXtjeMT3bkmTDM9K9eRuWIcBrVs0TlaMmeP
         pPprvCYeOH6wFH7dBiitLU8whe3UhamgOVFItdLqooviFVebaRsgUDH+sVVIMyO05br3
         zKG4xLNAGzXTya6+dGYjhPNbrNEpk99IaIq065gpxGd0QNbjaHo98mQn2n1eVv6mtUZW
         b/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2MUlrOc0HiJHRTPNOKs/f+k1Z+oIQtcna7qAe/Y1Um4=;
        b=cdbRXRGt4c2h8sYkvQKwlAkySWDO1+UsJdzQROVVULs0NvMaStM7PZycafsxsR5NiH
         juu0gwdWmFCtwqKf7jlgexwBmbc8u+RHyIXXu4/j62m+DsRTLuzZITVL21uYicjRavrG
         f2QoGqFDHKBy47p8C//H3osqOYvsHhorm7xmM2eEdNxL37/nMcLshUfXbRmA7nbw3gnH
         k9cM4vXwwjHSHi+DK+IhZesZ9M+ZCY8hvNvTvEifXv6c8KfFapHiWNilHqmsB9mgiVrK
         vbpws+SXdzRZXuC8Zq9jjktOvZ5xB+xjVf+orMPa5WvGLI7W1G2yBsVW16+sH0ghizkv
         hw/A==
X-Gm-Message-State: APjAAAVSxhKqI8Ja/MUPdEP1h9K6Mq2z0MKjhcDnr0Vt4C4Po4xNLdfk
        56DhTcCZ64xL7j72dFpLamo=
X-Google-Smtp-Source: APXvYqxvHgvqSPGuGh+v9BXgG5WEaAHjCxJ+PK2aTuh/igv2sfuPFjVnFVMPMCX4gzOeDwEd6t+G0A==
X-Received: by 2002:a63:1d45:: with SMTP id d5mr14543285pgm.184.1554830676980;
        Tue, 09 Apr 2019 10:24:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v189sm83838525pgd.77.2019.04.09.10.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:36 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 18/23] watchdog: 1: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:56 -0700
Message-Id: <1554830641-9247-19-git-send-email-linux@roeck-us.net>
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

- Replace devm_add_action() followed by failure action with
  devm_add_action_or_reset()
- Replace 'val = e; return val;' with 'return e;'
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sprd_wdt.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index a63163a93777..14874e9b207b 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -245,9 +245,7 @@ static u32 sprd_wdt_get_timeleft(struct watchdog_device *wdd)
 	u32 val;
 
 	val = sprd_wdt_get_cnt_value(wdt);
-	val = val / SPRD_WDT_CNT_STEP;
-
-	return val;
+	return val / SPRD_WDT_CNT_STEP;
 }
 
 static const struct watchdog_ops sprd_wdt_ops = {
@@ -269,10 +267,11 @@ static const struct watchdog_info sprd_wdt_info = {
 
 static int sprd_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sprd_wdt *wdt;
 	int ret;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -280,57 +279,56 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	wdt->enable = devm_clk_get(&pdev->dev, "enable");
+	wdt->enable = devm_clk_get(dev, "enable");
 	if (IS_ERR(wdt->enable)) {
-		dev_err(&pdev->dev, "can't get the enable clock\n");
+		dev_err(dev, "can't get the enable clock\n");
 		return PTR_ERR(wdt->enable);
 	}
 
-	wdt->rtc_enable = devm_clk_get(&pdev->dev, "rtc_enable");
+	wdt->rtc_enable = devm_clk_get(dev, "rtc_enable");
 	if (IS_ERR(wdt->rtc_enable)) {
-		dev_err(&pdev->dev, "can't get the rtc enable clock\n");
+		dev_err(dev, "can't get the rtc enable clock\n");
 		return PTR_ERR(wdt->rtc_enable);
 	}
 
 	wdt->irq = platform_get_irq(pdev, 0);
 	if (wdt->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ resource\n");
+		dev_err(dev, "failed to get IRQ resource\n");
 		return wdt->irq;
 	}
 
-	ret = devm_request_irq(&pdev->dev, wdt->irq, sprd_wdt_isr,
-			       IRQF_NO_SUSPEND, "sprd-wdt", (void *)wdt);
+	ret = devm_request_irq(dev, wdt->irq, sprd_wdt_isr, IRQF_NO_SUSPEND,
+			       "sprd-wdt", (void *)wdt);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register irq\n");
+		dev_err(dev, "failed to register irq\n");
 		return ret;
 	}
 
 	wdt->wdd.info = &sprd_wdt_info;
 	wdt->wdd.ops = &sprd_wdt_ops;
-	wdt->wdd.parent = &pdev->dev;
+	wdt->wdd.parent = dev;
 	wdt->wdd.min_timeout = SPRD_WDT_MIN_TIMEOUT;
 	wdt->wdd.max_timeout = SPRD_WDT_MAX_TIMEOUT;
 	wdt->wdd.timeout = SPRD_WDT_MAX_TIMEOUT;
 
 	ret = sprd_wdt_enable(wdt);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable wdt\n");
+		dev_err(dev, "failed to enable wdt\n");
 		return ret;
 	}
-	ret = devm_add_action(&pdev->dev, sprd_wdt_disable, wdt);
+	ret = devm_add_action_or_reset(dev, sprd_wdt_disable, wdt);
 	if (ret) {
-		sprd_wdt_disable(wdt);
-		dev_err(&pdev->dev, "Failed to add wdt disable action\n");
+		dev_err(dev, "Failed to add wdt disable action\n");
 		return ret;
 	}
 
 	watchdog_set_nowayout(&wdt->wdd, WATCHDOG_NOWAYOUT);
-	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
+	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
-	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
+	ret = devm_watchdog_register_device(dev, &wdt->wdd);
 	if (ret) {
 		sprd_wdt_disable(wdt);
-		dev_err(&pdev->dev, "failed to register watchdog\n");
+		dev_err(dev, "failed to register watchdog\n");
 		return ret;
 	}
 	platform_set_drvdata(pdev, wdt);
-- 
2.7.4

