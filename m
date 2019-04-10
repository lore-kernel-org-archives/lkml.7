Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DFDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65D1206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXw7C9KC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbfDJQ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44770 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387884AbfDJQ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so1775129pfm.11;
        Wed, 10 Apr 2019 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=orMF7rYuBW2QAgocXGhNUAGTXbgVNrgKUN3myFTKYbI=;
        b=hXw7C9KCi6C5kI5hpR/VW7d1TTVAbP32+DfiunuKtqgqY+QY3fb1K7cuKaUjfkXZ+G
         ZjkBqBJyEy3tXdU112kk2wChv3bk2jnctjbYuu+elfI4tEnKrOcZGK/5cen+GZqkUDLO
         OsiaUt2LpS2DTKDUe0V+kdugcpfFO3E5xRtC9R37LSkgygtJWHEAUgUNL6wx8ivAvwHJ
         PF3z7vh7B6zuqV3e+439tbKsTYuBss6mb2m8JlEeVMpO9sZfF955HKjHIrJ37/YD6GZO
         mBsDjqIHxom9Xa8DPlmISiVtwpzIG2wcafrcOEew7oKkLmwHZhmEo2fOh17+GsFwcUdp
         ASEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=orMF7rYuBW2QAgocXGhNUAGTXbgVNrgKUN3myFTKYbI=;
        b=XJs3spII8w7F6ZW/tnEHA6OWi8SrjkxexfBJc5NtQLa91zkw5x7nSoejgRv0S2OSwG
         VO1B/nV7GwjuQPK/SUbTqjrEgFRlfMICYW9eKf5bVenNoDAkZU8P17FUd9aKCOPiFhU6
         vd0JGJZ3W5zsWz91RKHNS0PYCgxBgIJXkMsYOCnFbMdLJ96YFdw1EEi332GddcMIel9B
         wyZO1BRYfeleJVPEGGdKs+ABUfVFUm199fy9l/I5neDNSlcNq3KJymZWRKAu1pOX/zm0
         6pl6s+rYQoEfAvw4yDOFnKc1FB8yikWeCXjm6j2uVH4wvKPAIuGdmJhsX3LTDFBh373r
         fGqA==
X-Gm-Message-State: APjAAAVX8NeXeYmstHkPjy2ruycbnpKzc7AKlI3DXQMNw9RTCo1rPexO
        19kOoZKehlSOAkQgZ7vji38=
X-Google-Smtp-Source: APXvYqzNmSxAlAVUAJ99Y9aLmZPx74E6fY+UOzkOVIRVwUEjP4DK9aoIKg8WV+kO6T7XHqXkQq6Pow==
X-Received: by 2002:aa7:91c8:: with SMTP id z8mr44553612pfa.110.1554913706126;
        Wed, 10 Apr 2019 09:28:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q87sm55726631pfa.133.2019.04.10.09.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:25 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 13/22] watchdog: stm32_iwdg: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:54 -0700
Message-Id: <1554913683-25454-14-git-send-email-linux@roeck-us.net>
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

- Drop assignments to otherwise unused variables
- Drop empty remove function
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/stm32_iwdg.c | 65 +++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 309563e002b8..68756a40eb36 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -138,38 +138,52 @@ static int stm32_iwdg_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static void stm32_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int stm32_iwdg_clk_init(struct platform_device *pdev,
 			       struct stm32_iwdg *wdt)
 {
+	struct device *dev = &pdev->dev;
 	u32 ret;
 
-	wdt->clk_lsi = devm_clk_get(&pdev->dev, "lsi");
+	wdt->clk_lsi = devm_clk_get(dev, "lsi");
 	if (IS_ERR(wdt->clk_lsi)) {
-		dev_err(&pdev->dev, "Unable to get lsi clock\n");
+		dev_err(dev, "Unable to get lsi clock\n");
 		return PTR_ERR(wdt->clk_lsi);
 	}
 
 	/* optional peripheral clock */
 	if (wdt->has_pclk) {
-		wdt->clk_pclk = devm_clk_get(&pdev->dev, "pclk");
+		wdt->clk_pclk = devm_clk_get(dev, "pclk");
 		if (IS_ERR(wdt->clk_pclk)) {
-			dev_err(&pdev->dev, "Unable to get pclk clock\n");
+			dev_err(dev, "Unable to get pclk clock\n");
 			return PTR_ERR(wdt->clk_pclk);
 		}
 
 		ret = clk_prepare_enable(wdt->clk_pclk);
 		if (ret) {
-			dev_err(&pdev->dev, "Unable to prepare pclk clock\n");
+			dev_err(dev, "Unable to prepare pclk clock\n");
 			return ret;
 		}
+		ret = devm_add_action_or_reset(dev,
+					       stm32_clk_disable_unprepare,
+					       wdt->clk_pclk);
+		if (ret)
+			return ret;
 	}
 
 	ret = clk_prepare_enable(wdt->clk_lsi);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to prepare lsi clock\n");
-		clk_disable_unprepare(wdt->clk_pclk);
+		dev_err(dev, "Unable to prepare lsi clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, stm32_clk_disable_unprepare,
+				       wdt->clk_lsi);
+	if (ret)
+		return ret;
 
 	wdt->rate = clk_get_rate(wdt->clk_lsi);
 
@@ -199,16 +213,17 @@ MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
 
 static int stm32_iwdg_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	const struct of_device_id *match;
 	struct stm32_iwdg *wdt;
 	int ret;
 
-	match = of_match_device(stm32_iwdg_of_match, &pdev->dev);
+	match = of_match_device(stm32_iwdg_of_match, dev);
 	if (!match)
 		return -ENODEV;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -217,7 +232,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	/* This is the timer base. */
 	wdt->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->regs)) {
-		dev_err(&pdev->dev, "Could not get resource\n");
+		dev_err(dev, "Could not get resource\n");
 		return PTR_ERR(wdt->regs);
 	}
 
@@ -231,46 +246,28 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	wdd->ops = &stm32_iwdg_ops;
 	wdd->min_timeout = ((RLR_MIN + 1) * 256) / wdt->rate;
 	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * 256 * 1000) / wdt->rate;
-	wdd->parent = &pdev->dev;
+	wdd->parent = dev;
 
 	watchdog_set_drvdata(wdd, wdt);
 	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
 
-	ret = watchdog_init_timeout(wdd, 0, &pdev->dev);
+	ret = watchdog_init_timeout(wdd, 0, dev);
 	if (ret)
-		dev_warn(&pdev->dev,
-			 "unable to set timeout value, using default\n");
+		dev_warn(dev, "unable to set timeout value, using default\n");
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register watchdog device\n");
-		goto err;
+		dev_err(dev, "failed to register watchdog device\n");
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, wdt);
 
 	return 0;
-err:
-	clk_disable_unprepare(wdt->clk_lsi);
-	clk_disable_unprepare(wdt->clk_pclk);
-
-	return ret;
-}
-
-static int stm32_iwdg_remove(struct platform_device *pdev)
-{
-	struct stm32_iwdg *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&wdt->wdd);
-	clk_disable_unprepare(wdt->clk_lsi);
-	clk_disable_unprepare(wdt->clk_pclk);
-
-	return 0;
 }
 
 static struct platform_driver stm32_iwdg_driver = {
 	.probe		= stm32_iwdg_probe,
-	.remove		= stm32_iwdg_remove,
 	.driver = {
 		.name	= "iwdg",
 		.of_match_table = of_match_ptr(stm32_iwdg_of_match),
-- 
2.7.4

