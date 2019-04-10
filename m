Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33187206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+15h4ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbfDJQ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46776 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfDJQ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so1762976pfj.13;
        Wed, 10 Apr 2019 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zrDUSZL8oOFl0c6GbsQEbRckVQXbnwOfvuwFmAPymj8=;
        b=l+15h4ldd1iec8qB4IrPTh4ZGMcUXZTucTr0LjXaSBnMDl2ssY88y3Izj1Vo0KB/or
         gNtDFienJiWKkQ5TEk+T87d37d13XjyRq7xxWlqnj9yXJpqdfmxJJ/f6ewhLGNTqrOwm
         5x+HDwCZ2psknY/TDUY8S2xqZILg7S6yaK45UNCCKL84hHpzgdbWxM1fNB7YUWJa+D/Y
         Do0AuNoCrYE84o0xpcV7Sbnh0ZEWJpqy25VtgMdoRuHveCTPxojmxI+1hVgVxAlw3Wz4
         ItY8AoLVnPQGriRhUf+9bgnyxKRUNF+1YRZN+778/6WWWM6Ah2z7fVRP/+ZfZFSabJBt
         zJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zrDUSZL8oOFl0c6GbsQEbRckVQXbnwOfvuwFmAPymj8=;
        b=BD3iKbdbOAhhA2oMu12SDLKiV2gMURRplZkkVlyTlfKI4EVxrQS9SpoSCdAYF2HPx9
         yQA4exwtqO/8Uk7NtW4MspAN0ocNl624CwTi0j4vsJbfr6HvAYdMiqhbletLP93+EUON
         G9ypa0x9tdmpV4amZ4DRdDMLF+4QZCXk4QmzI9uiinwf8t4YRFMq4QbehTZ1+1WDNEmE
         4EMc4GVN6Sqz4EyIzLjYprfmNZW1sj4X7yfstF7tvo8EiXTJa0fdhrUrzixNyWVpYYyg
         CZgnVwqTMvRh9PryGURqk5HhpY0pI7qHy/jVeeFsBypxg50bFLL9orrJTq0bLqqQ7mn8
         fSbA==
X-Gm-Message-State: APjAAAUVzfYC0I7RiP8qAsOw45upG5dOAEL7LvdFrNY4NER8cPd2Gbw9
        2ZORioG2f9Z3I3L+vw5BdPk=
X-Google-Smtp-Source: APXvYqwNLFXTygwYO3O6xLlZHRI7ExSyZk8N/cFj3Ig5PQ9zvvBLHQAwT4Y2AeXEkx7CpkJzXcdZiQ==
X-Received: by 2002:a63:6907:: with SMTP id e7mr34269308pgc.209.1554913689373;
        Wed, 10 Apr 2019 09:28:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t13sm27159345pgo.14.2019.04.10.09.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:08 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 01/22] watchdog: tegra_wdt: Use watchdog_stop_on_unregister and other improvements
Date:   Wed, 10 Apr 2019 09:27:42 -0700
Message-Id: <1554913683-25454-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use watchdog_stop_on_unregister() in probe instead of calling
tegra_wdt_stop() in the remove function. Also introduce local variable
'struct device *dev' and use it instead of dereferencing it repeatedly.
Finally, drop the now empty remove function.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/tegra_wdt.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index fc3cf5edf6c7..a58b000acc4f 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -181,6 +181,7 @@ static const struct watchdog_ops tegra_wdt_ops = {
 
 static int tegra_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct tegra_wdt *wdt;
 	void __iomem *regs;
@@ -195,7 +196,7 @@ static int tegra_wdt_probe(struct platform_device *pdev)
 	 * Allocate our watchdog driver data, which has the
 	 * struct watchdog_device nested within it.
 	 */
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -210,39 +211,27 @@ static int tegra_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &tegra_wdt_ops;
 	wdd->min_timeout = MIN_WDT_TIMEOUT;
 	wdd->max_timeout = MAX_WDT_TIMEOUT;
-	wdd->parent = &pdev->dev;
+	wdd->parent = dev;
 
 	watchdog_set_drvdata(wdd, wdt);
 
 	watchdog_set_nowayout(wdd, nowayout);
 
-	ret = devm_watchdog_register_device(&pdev->dev, wdd);
+	watchdog_stop_on_unregister(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"failed to register watchdog device\n");
+		dev_err(dev, "failed to register watchdog device\n");
 		return ret;
 	}
 
 	platform_set_drvdata(pdev, wdt);
 
-	dev_info(&pdev->dev,
-		 "initialized (heartbeat = %d sec, nowayout = %d)\n",
+	dev_info(dev, "initialized (heartbeat = %d sec, nowayout = %d)\n",
 		 heartbeat, nowayout);
 
 	return 0;
 }
 
-static int tegra_wdt_remove(struct platform_device *pdev)
-{
-	struct tegra_wdt *wdt = platform_get_drvdata(pdev);
-
-	tegra_wdt_stop(&wdt->wdd);
-
-	dev_info(&pdev->dev, "removed wdt\n");
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int tegra_wdt_runtime_suspend(struct device *dev)
 {
@@ -278,7 +267,6 @@ static const struct dev_pm_ops tegra_wdt_pm_ops = {
 
 static struct platform_driver tegra_wdt_driver = {
 	.probe		= tegra_wdt_probe,
-	.remove		= tegra_wdt_remove,
 	.driver		= {
 		.name	= "tegra-wdt",
 		.pm	= &tegra_wdt_pm_ops,
-- 
2.7.4

