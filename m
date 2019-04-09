Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC16EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824672133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNkEqJEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDIRYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39370 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfDIRY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so9688530pga.6;
        Tue, 09 Apr 2019 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0rD/0tJd1ah52P5emLg7Kwg4Ngw1RXkxMOo+hYFX6MI=;
        b=TNkEqJEkBx11Z87Um62dQeUYMLD78aDSQJTsH0bGvKsXigMUQ7AXWQLcP/2rFVwLTS
         67D0fsmr83d4OwsAgeONdsylz5zA77sVyWcbV+jud0MDafxr604gClwrQkFgYuTBDkL4
         tW7ji66vBFBSy5UHb0ophx+vza1qDEn3CSp5gWIjrsqZD6Wja7XUNyGJcm+LrG9dhBGL
         AOujuXTFgWmU7sKcmIleNx7GLKBPbHO27BcCFOcHZeWdXbu51hgREfqLIvJOnvkRcIx9
         jMzBeZAOFF/egGvBgfjeQ3+5Par2vobiad5tjyXWlFYOTpNy7v9XOezDBZoQF49AoX6l
         ue0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=0rD/0tJd1ah52P5emLg7Kwg4Ngw1RXkxMOo+hYFX6MI=;
        b=Jk32xKECIaDdgG5G2ETMnevxhcM04lyu3p1JlPFzd415heWto1bjV3n9XMlmmFNL3H
         m74Zg/FWOzrc0sVqjh5ItqvZeeOK5e3oReMSvYSh6IHgYfn9APkLS05A/7k1EmrcYsud
         ED3Jz7nhgO4cdZuSQCvZUC8NvlgDwnToyDO/qDfKHBm7tgiEB/Il2RIMP7/qFDEYs4fm
         nmTYnVjxk4JZWT9gny9VSDr199DlBsUoIt5vWmzqlAJB2agELUQDSxJfmx3XWBmbARyk
         mriwXFi6feD4XodmBEiqy1TpSHmYbdm6kdqsFlRVEMDI5NbnXD+yj8vT/GH4u6Ogade1
         Uehg==
X-Gm-Message-State: APjAAAV2zFp/Dc3XF4edezshnwmPzJ64mgnBrAfqNMKQqEheox6KgYu5
        grf5/YJRXkjKa/7uw0vuiCs=
X-Google-Smtp-Source: APXvYqwDijYB0a3pB9nyXb+JBQ1AIuie29eF2lTvGapEcsA8jWNYq9kNES7hwAkm0x1OXP/1xWKLag==
X-Received: by 2002:a62:7549:: with SMTP id q70mr27889935pfc.112.1554830668375;
        Tue, 09 Apr 2019 10:24:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f1sm40310238pgl.35.2019.04.09.10.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:27 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Subject: [PATCH 12/23] watchdog: qcom-wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:50 -0700
Message-Id: <1554830641-9247-13-git-send-email-linux@roeck-us.net>
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
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/qcom-wdt.c | 55 +++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 5dfd604477a4..6d29c33b1316 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -142,22 +142,28 @@ static const struct watchdog_info qcom_wdt_info = {
 	.identity	= KBUILD_MODNAME,
 };
 
+static void qcom_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int qcom_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct qcom_wdt *wdt;
 	struct resource *res;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	const u32 *regs;
 	u32 percpu_offset;
 	int ret;
 
-	regs = of_device_get_match_data(&pdev->dev);
+	regs = of_device_get_match_data(dev);
 	if (!regs) {
-		dev_err(&pdev->dev, "Unsupported QCOM WDT module\n");
+		dev_err(dev, "Unsupported QCOM WDT module\n");
 		return -ENODEV;
 	}
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -172,21 +178,25 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	res->start += percpu_offset;
 	res->end += percpu_offset;
 
-	wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	wdt->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	wdt->clk = devm_clk_get(&pdev->dev, NULL);
+	wdt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(wdt->clk)) {
-		dev_err(&pdev->dev, "failed to get input clock\n");
+		dev_err(dev, "failed to get input clock\n");
 		return PTR_ERR(wdt->clk);
 	}
 
 	ret = clk_prepare_enable(wdt->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup clock\n");
+		dev_err(dev, "failed to setup clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, qcom_clk_disable_unprepare,
+				       wdt->clk);
+	if (ret)
+		return ret;
 
 	/*
 	 * We use the clock rate to calculate the max timeout, so ensure it's
@@ -199,16 +209,15 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->rate = clk_get_rate(wdt->clk);
 	if (wdt->rate == 0 ||
 	    wdt->rate > 0x10000000U) {
-		dev_err(&pdev->dev, "invalid clock rate\n");
-		ret = -EINVAL;
-		goto err_clk_unprepare;
+		dev_err(dev, "invalid clock rate\n");
+		return -EINVAL;
 	}
 
 	wdt->wdd.info = &qcom_wdt_info;
 	wdt->wdd.ops = &qcom_wdt_ops;
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
-	wdt->wdd.parent = &pdev->dev;
+	wdt->wdd.parent = dev;
 	wdt->layout = regs;
 
 	if (readl(wdt_addr(wdt, WDT_STS)) & 1)
@@ -220,29 +229,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	 * the max instead.
 	 */
 	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
-	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
+	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
-	ret = watchdog_register_device(&wdt->wdd);
+	ret = devm_watchdog_register_device(dev, &wdt->wdd);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register watchdog\n");
-		goto err_clk_unprepare;
+		dev_err(dev, "failed to register watchdog\n");
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, wdt);
 	return 0;
-
-err_clk_unprepare:
-	clk_disable_unprepare(wdt->clk);
-	return ret;
-}
-
-static int qcom_wdt_remove(struct platform_device *pdev)
-{
-	struct qcom_wdt *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&wdt->wdd);
-	clk_disable_unprepare(wdt->clk);
-	return 0;
 }
 
 static int __maybe_unused qcom_wdt_suspend(struct device *dev)
@@ -277,7 +273,6 @@ MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
 
 static struct platform_driver qcom_watchdog_driver = {
 	.probe	= qcom_wdt_probe,
-	.remove	= qcom_wdt_remove,
 	.driver	= {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= qcom_wdt_of_table,
-- 
2.7.4

