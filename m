Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C194C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57A6206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raT8M/tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbfDJQ2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35756 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731977AbfDJQ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so1800253pfh.2;
        Wed, 10 Apr 2019 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3IlgT7nY07HPFlMA+WrAZzzctpP7991Q2yQyFRscuWw=;
        b=raT8M/tM7l611F0M2XPq9Iu8xGx43KTlbeKmxJwEsLZJ7eNg4nHXwgQmly1OWHAhrw
         APMC6l1gjBZsb9ECHGaVEl3MAu+HVrBROQxRb8T/uGM9Y+c+clEG6tR5t7+LUBAfMCD3
         bZgXTHoB72BpvD/8DkHHV2aecbwgpibDMSeb1gd6ILEqaC5SIjqB+NJ4yfKy2wZPClxs
         Cvlogxhtx4ONLXJyNEXo1Pcq+JrGTkqcZr3DASNaI9w0I5zWKWZGkxiIdFH2HQr9nm7b
         PnHCoZ4gBohCJwEXWtiKAwl6A5ZJ+9wyNTDBQlmSDpJoI0zfLj+35RKtAo5GtmxYVVv2
         yKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3IlgT7nY07HPFlMA+WrAZzzctpP7991Q2yQyFRscuWw=;
        b=I8CZFDZ/cGNZFbAoSnJ72yOrT/JbTqMWrDxBwsafPl+zBh2fU0PVV8dbIlUDc+bPo1
         0ojdROue5p1IFintTbq+ejfl1oHZRJWZq660vJa/os2Ynf7c13bccplWIv715NXs2rYE
         D/4UTR2zamxy7cVusY15dKqaG/EcC41esv2AAJItRED8Z/in8XnB77q1sYw5xj4N4zDl
         Lco6EoXqWX0EEdQ0zQtWr+R3HnAXuOB3/YJqG6+gvU1xo3qJopbSFK5K0hx24b5Ai9Kx
         cxvMScRFC4zFoFotdzdpo+Zyj5iVxdk03DnBJCf6UPMTBM25gc+K7HkYvuCh33OELIL4
         +UjQ==
X-Gm-Message-State: APjAAAW6hcInixcJ1lJoqd2ZXSie/8EQ9Q14UXkxVrrCz9u/Djr7HVn4
        YYcKfHEHJIns4OugoMoUcOI=
X-Google-Smtp-Source: APXvYqxyv6BTQFrrkV9Xb+gRkQUmsuO/4/tAqUxjHyfyxbCZ5lfLPt3lWzaVlZlQcQuKNkc1attHLQ==
X-Received: by 2002:a63:1f52:: with SMTP id q18mr42969142pgm.134.1554913692074;
        Wed, 10 Apr 2019 09:28:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm113221936pfi.73.2019.04.10.09.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:11 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/22] watchdog: ts4800_wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:44 -0700
Message-Id: <1554913683-25454-4-git-send-email-linux@roeck-us.net>
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
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ts4800_wdt.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
index 89843b16b04a..9dc6d7f45806 100644
--- a/drivers/watchdog/ts4800_wdt.c
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -108,7 +108,8 @@ static const struct watchdog_info ts4800_wdt_info = {
 
 static int ts4800_wdt_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct device_node *syscon_np;
 	struct watchdog_device *wdd;
 	struct ts4800_wdt *wdt;
@@ -117,18 +118,18 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 
 	syscon_np = of_parse_phandle(np, "syscon", 0);
 	if (!syscon_np) {
-		dev_err(&pdev->dev, "no syscon property\n");
+		dev_err(dev, "no syscon property\n");
 		return -ENODEV;
 	}
 
 	ret = of_property_read_u32_index(np, "syscon", 1, &reg);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "no offset in syscon\n");
+		dev_err(dev, "no offset in syscon\n");
 		return ret;
 	}
 
 	/* allocate memory for watchdog struct */
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -137,13 +138,13 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 	wdt->regmap = syscon_node_to_regmap(syscon_np);
 	of_node_put(syscon_np);
 	if (IS_ERR(wdt->regmap)) {
-		dev_err(&pdev->dev, "cannot get parent's regmap\n");
+		dev_err(dev, "cannot get parent's regmap\n");
 		return PTR_ERR(wdt->regmap);
 	}
 
 	/* Initialize struct watchdog_device */
 	wdd = &wdt->wdd;
-	wdd->parent = &pdev->dev;
+	wdd->parent = dev;
 	wdd->info = &ts4800_wdt_info;
 	wdd->ops = &ts4800_wdt_ops;
 	wdd->min_timeout = ts4800_wdt_map[0].timeout;
@@ -151,7 +152,7 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(wdd, wdt);
 	watchdog_set_nowayout(wdd, nowayout);
-	watchdog_init_timeout(wdd, 0, &pdev->dev);
+	watchdog_init_timeout(wdd, 0, dev);
 
 	/*
 	 * As this watchdog supports only a few values, ts4800_wdt_set_timeout
@@ -169,31 +170,20 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
 	 */
 	ts4800_wdt_stop(wdd);
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"failed to register watchdog device\n");
+		dev_err(dev, "failed to register watchdog device\n");
 		return ret;
 	}
 
 	platform_set_drvdata(pdev, wdt);
 
-	dev_info(&pdev->dev,
-		 "initialized (timeout = %d sec, nowayout = %d)\n",
+	dev_info(dev, "initialized (timeout = %d sec, nowayout = %d)\n",
 		 wdd->timeout, nowayout);
 
 	return 0;
 }
 
-static int ts4800_wdt_remove(struct platform_device *pdev)
-{
-	struct ts4800_wdt *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&wdt->wdd);
-
-	return 0;
-}
-
 static const struct of_device_id ts4800_wdt_of_match[] = {
 	{ .compatible = "technologic,ts4800-wdt", },
 	{ },
@@ -202,7 +192,6 @@ MODULE_DEVICE_TABLE(of, ts4800_wdt_of_match);
 
 static struct platform_driver ts4800_wdt_driver = {
 	.probe		= ts4800_wdt_probe,
-	.remove		= ts4800_wdt_remove,
 	.driver		= {
 		.name	= "ts4800_wdt",
 		.of_match_table = ts4800_wdt_of_match,
-- 
2.7.4

