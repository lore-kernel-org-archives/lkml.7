Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B85C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E31206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhnCtIi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbfDJQ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:29:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36424 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfDJQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so1798098pfn.3;
        Wed, 10 Apr 2019 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=seHjBqaBud1mYkVOqcRVoUipgYEoJz3N4GGlHqlC5Ho=;
        b=fhnCtIi/YM7sz501nGK9jfCOfSn5uGcPccRiGXqQsNdL8CphFvZdvZ+t+x3wiPxf7p
         9tSdt2QnVruhXY9X7CpSPCvboTQWbLC6yblGnLSVCt7LlHu2GtY/1kxtolcV30OM7AZU
         r4J+tIbAUGLWRXb+wwDVcYBWEykK1ZqoT8nTsSfFl5OaRMlWu5M6QCe6pbL9clUqfYWd
         6WJXpBhQtXFuvUoX8/PDvvWtWT5eyTCqvrcOHrfr+NQsEKs+1MMv9U2AhXweMtENDHRg
         wq1q/7O0tyCpEWk/BFl9o1zk4s5idfVxzaThEZV+rSJSZwSOi9dW6b3FsKnCrzOmdw/8
         MTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=seHjBqaBud1mYkVOqcRVoUipgYEoJz3N4GGlHqlC5Ho=;
        b=RrPg6WsXUFhqjWi4hmv4OtfN4KNDILweSkuHA+wVylOojB5+b4U+S4Em0+EyJurifx
         fXb/DN0h0Xzy7LZoa8oTa3CGb6NEfMj+WKWcor+BszNGJGII929rHKl2SgiSzkuhzxsU
         3Krv38bwJYa0sFqMNfd/2LCy49QGddo4zEQx8aXT3JPGqiMAYbn3g1E21iSoGlYQZ/vP
         3DNzIJDtN7ZIvHcgx+kl4Qzfzg/b+y4YtBFZ/8NJgMgMyCNLquit3D0qw0O1HURIgCRH
         KE/e6nPOcUGc9taPsHh/KJfpULoV5nxRIxXNp6AY+ahHQrQehJUJUGlIRLOEBZEX8uDQ
         VBfQ==
X-Gm-Message-State: APjAAAXx/iLKLlA/6moTtW2DNdYQ2cZl5aJQZxpXssXG2qunizvWHFs2
        WM5ZutQ44Lw13dYNPY77XvU=
X-Google-Smtp-Source: APXvYqzTyaALieo4zGPvtCFTNsVd2VNQz1hrvpZxEH9Wh+I2YsiK3p8l0Vnt/ZhqPkUwlGD+xSEe2g==
X-Received: by 2002:a63:ef4c:: with SMTP id c12mr29053510pgk.43.1554913699097;
        Wed, 10 Apr 2019 09:28:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j12sm43483028pgg.79.2019.04.10.09.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:18 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/22] watchdog: wm831x_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Wed, 10 Apr 2019 09:27:49 -0700
Message-Id: <1554913683-25454-9-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce local variable 'struct device *dev' and use it instead of
dereferencing it repeatedly.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/wm831x_wdt.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 116c2f47b463..9b6565a3fab4 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -180,8 +180,9 @@ static const struct watchdog_ops wm831x_wdt_ops = {
 
 static int wm831x_wdt_probe(struct platform_device *pdev)
 {
-	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
-	struct wm831x_pdata *chip_pdata = dev_get_platdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct wm831x *wm831x = dev_get_drvdata(dev->parent);
+	struct wm831x_pdata *chip_pdata = dev_get_platdata(dev->parent);
 	struct wm831x_watchdog_pdata *pdata;
 	struct wm831x_wdt_drvdata *driver_data;
 	struct watchdog_device *wm831x_wdt;
@@ -198,8 +199,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 	if (reg & WM831X_WDOG_DEBUG)
 		dev_warn(wm831x->dev, "Watchdog is paused\n");
 
-	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
-				   GFP_KERNEL);
+	driver_data = devm_kzalloc(dev, sizeof(*driver_data), GFP_KERNEL);
 	if (!driver_data)
 		return -ENOMEM;
 
@@ -210,7 +210,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 
 	wm831x_wdt->info = &wm831x_wdt_info;
 	wm831x_wdt->ops = &wm831x_wdt_ops;
-	wm831x_wdt->parent = &pdev->dev;
+	wm831x_wdt->parent = dev;
 	watchdog_set_nowayout(wm831x_wdt, nowayout);
 	watchdog_set_drvdata(wm831x_wdt, driver_data);
 
@@ -240,10 +240,9 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 		reg |= pdata->software << WM831X_WDOG_RST_SRC_SHIFT;
 
 		if (pdata->update_gpio) {
-			ret = devm_gpio_request_one(&pdev->dev,
-						pdata->update_gpio,
-						GPIOF_OUT_INIT_LOW,
-						"Watchdog update");
+			ret = devm_gpio_request_one(dev, pdata->update_gpio,
+						    GPIOF_OUT_INIT_LOW,
+						    "Watchdog update");
 			if (ret < 0) {
 				dev_err(wm831x->dev,
 					"Failed to request update GPIO: %d\n",
@@ -268,7 +267,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_watchdog_register_device(&pdev->dev, &driver_data->wdt);
+	ret = devm_watchdog_register_device(dev, &driver_data->wdt);
 	if (ret != 0) {
 		dev_err(wm831x->dev, "watchdog_register_device() failed: %d\n",
 			ret);
-- 
2.7.4

