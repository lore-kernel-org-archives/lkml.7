Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB466C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB85520883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX3lekic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDIRYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42638 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDIRYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so9792782plb.9;
        Tue, 09 Apr 2019 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDkdjCuCoMl4klGjBikpqpnhMyWOhlVzWHe2RSdyLn0=;
        b=TX3lekicuwdd7C++LfiUuLaqPbrTD3Spl0GMuuAv9LUWdOWbBQhnsXzW9GFO8p3I+W
         6j5Ykqe3nhTs4MKMkWufVVbH7f0BDWYDdsgJl2y4IMRNETk4k+5gpen4jfR1JrerUwEv
         hDcpcd/eSq0foA2J9OYBalqPNR8i+d9ZzRCYoSrMLOActt5BOadq9C3u+rPH3rBiXBnG
         gCSdKu8HyPL0jETy6QpkoOJ2WKaGUnpxp4ht0SH8LgLT1QuyH9x0MsZY7W5j84c3Oze9
         DRmXaX+tZViYWn2v6aFHX3NNcuz0NQq5/bb1Rr9zePhxo7cPa2bhZXlwyMXw4lT99xAG
         k88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=WDkdjCuCoMl4klGjBikpqpnhMyWOhlVzWHe2RSdyLn0=;
        b=DqJW3NmDkeMzREcHwi4M5a1FI39xHWQVyPJ9ovCrIM5SWRYZStvpRSqzsR7CN2+EGP
         uvXtZSfLk1ryhS83Twkg074p83KZmkipVWGWuKBPSCoDjvhedDTJpT5xPrm1Autq9I38
         pjy2v6iVdYuo+8bt1SoHpEgU4beK9qqMMRIcIABFXo8slZYm2AEUXmAlEbOco4B+i8D3
         dYedXT9AvULcq2Du6CEVFlbXSbModaICRNWfdJIHoy+Yl3CkBKBAaTx7htwbZNIK+ryQ
         l0skkD0YqIXct2pfqFQ4+/nyl6Ti/jdTXDvA++yf5HC9oYjNqpX8Z2UB0ktPyPQVv/zk
         UmBA==
X-Gm-Message-State: APjAAAVLnoT3KV+qYZB5Rr45mia0LtGXrARyCeIQOWmYmpfNu/+J8Rm2
        3p0YYjyfhhiKFPbjdBA11Akcuq34
X-Google-Smtp-Source: APXvYqwVcFu9w2KErfPWvjoL2Iq7SKADR+E81dsVQ7tlI2u7cBlGnLxyX6ixz52AWUCZyqnbdehC/A==
X-Received: by 2002:a17:902:d83:: with SMTP id 3mr14265678plv.125.1554830653174;
        Tue, 09 Apr 2019 10:24:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m16sm83832033pfi.29.2019.04.09.10.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:12 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/23] watchdog: max77620_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:39 -0700
Message-Id: <1554830641-9247-2-git-send-email-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/max77620_wdt.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index 70c9cd3ba938..3ca6b9337932 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -112,17 +112,18 @@ static const struct watchdog_ops max77620_wdt_ops = {
 
 static int max77620_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct max77620_wdt *wdt;
 	struct watchdog_device *wdt_dev;
 	unsigned int regval;
 	int ret;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
-	wdt->dev = &pdev->dev;
-	wdt->rmap = dev_get_regmap(pdev->dev.parent, NULL);
+	wdt->dev = dev;
+	wdt->rmap = dev_get_regmap(dev->parent, NULL);
 	if (!wdt->rmap) {
 		dev_err(wdt->dev, "Failed to get parent regmap\n");
 		return -ENODEV;
@@ -183,25 +184,16 @@ static int max77620_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(wdt_dev, nowayout);
 	watchdog_set_drvdata(wdt_dev, wdt);
 
-	ret = watchdog_register_device(wdt_dev);
+	watchdog_stop_on_unregister(wdt_dev);
+	ret = devm_watchdog_register_device(dev, wdt_dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
+		dev_err(dev, "watchdog registration failed: %d\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
-static int max77620_wdt_remove(struct platform_device *pdev)
-{
-	struct max77620_wdt *wdt = platform_get_drvdata(pdev);
-
-	max77620_wdt_stop(&wdt->wdt_dev);
-	watchdog_unregister_device(&wdt->wdt_dev);
-
-	return 0;
-}
-
 static const struct platform_device_id max77620_wdt_devtype[] = {
 	{ .name = "max77620-watchdog", },
 	{ },
@@ -213,7 +205,6 @@ static struct platform_driver max77620_wdt_driver = {
 		.name	= "max77620-watchdog",
 	},
 	.probe	= max77620_wdt_probe,
-	.remove	= max77620_wdt_remove,
 	.id_table = max77620_wdt_devtype,
 };
 
-- 
2.7.4

