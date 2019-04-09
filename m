Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA262C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD1E2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shalK5ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDIRYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32937 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDIRYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so9701235pgh.0;
        Tue, 09 Apr 2019 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKbn0+uhPr/AYdBY5ar3yTCFhEOd5nLB6VfRC6MJRs4=;
        b=shalK5htuv5iTeHjjay2f9Y3ThgIXWaEiHASUHAjJLeFul0xMsWmwAijFo3QQNG3+n
         kyIfcFdqYlMnJmXIB4IZNWdEFxDk7QYNU9/IO8YS7tR4vJGsoNZ+fYLjchvx6si5y5Jt
         vrr7qKsSnRwWAYihNwLiLVHhNzsRSQ2G9+M34VbPixh/nlABu9pYlupp4Yc9MDHAcgfE
         epMhlHuYLpZikldCbXUFwvysFL0gp2OB52qk2n3QaUPPmn5dqOYMnM2DNk/DQ4FomCdw
         vVVPvifyM/Dg+YS9UIJZFiFt6W9UhMeIoSYOF+gSMZnLN/T7d6pnZkzN8o0Uerw6eX8h
         CLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=jKbn0+uhPr/AYdBY5ar3yTCFhEOd5nLB6VfRC6MJRs4=;
        b=bzDV3Ul09EifMpYrZHA2bKU4VVSs3RqgqWaN4lKOyrBO56zEut/+cS3FDeZO2GmTdg
         PIM+QhVynYxXhC+/yjz6D+IC04jMsqaqKc2ZNgYP737X0srP0gZdTzG4pRkX9D85j8AC
         u47nTI5RLH0FAZ0707kHk1rIDflFtvDWylMw4iNRriZIfGyMJYOA0xCnLvIzSo6ALfaq
         FERfDPM/ynZDtKUK9UoW+gEnQTcy/lUvY2CujKTCNhEdSRM1R4e157oEx5VCe1AxVHmN
         JRggAgQFeYW+HJO9qQEoUWop1uq3zjfZh9ohKNxtXeTdoMzRuQOhYLuXfcNIixx+LmFN
         Kw4g==
X-Gm-Message-State: APjAAAX7X5nJeSFgkKupBsn0urOmlpHXEAK7Snv/uSod6EFjcBK586RV
        EegLI9eeGT5Hywku/u3Bi7R8sdpf
X-Google-Smtp-Source: APXvYqyWqvGmg7h8q0DRYGXRO1e1TkVmxX/7G5h+mhILcL6AodF6B/LsfwYkj/OEg2rduen9pky5RQ==
X-Received: by 2002:a63:450f:: with SMTP id s15mr35323176pga.157.1554830654534;
        Tue, 09 Apr 2019 10:24:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a6sm46239723pfn.181.2019.04.09.10.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:14 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Johannes Thumshirn <morbidrsa@gmail.com>
Subject: [PATCH 02/23] watchdog: mena21_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue,  9 Apr 2019 10:23:40 -0700
Message-Id: <1554830641-9247-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
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

Cc: Johannes Thumshirn <morbidrsa@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mena21_wdt.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 6db69883ece6..e9ca4e0e25dc 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -127,19 +127,20 @@ static struct watchdog_device a21_wdt = {
 
 static int a21_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct a21_wdt_drv *drv;
 	unsigned int reset = 0;
 	int num_gpios;
 	int ret;
 	int i;
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(struct a21_wdt_drv), GFP_KERNEL);
+	drv = devm_kzalloc(dev, sizeof(struct a21_wdt_drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
-	num_gpios = gpiod_count(&pdev->dev, NULL);
+	num_gpios = gpiod_count(dev, NULL);
 	if (num_gpios != NUM_GPIOS) {
-		dev_err(&pdev->dev, "gpios DT property wrong, got %d want %d",
+		dev_err(dev, "gpios DT property wrong, got %d want %d",
 			num_gpios, NUM_GPIOS);
 		return -ENODEV;
 	}
@@ -152,12 +153,9 @@ static int a21_wdt_probe(struct platform_device *pdev)
 			gflags = GPIOD_ASIS;
 		else
 			gflags = GPIOD_IN;
-		drv->gpios[i] = devm_gpiod_get_index(&pdev->dev, NULL, i,
-						     gflags);
-		if (IS_ERR(drv->gpios[i])) {
-			ret = PTR_ERR(drv->gpios[i]);
-			return ret;
-		}
+		drv->gpios[i] = devm_gpiod_get_index(dev, NULL, i, gflags);
+		if (IS_ERR(drv->gpios[i]))
+			return PTR_ERR(drv->gpios[i]);
 
 		gpiod_set_consumer_name(drv->gpios[i], "MEN A21 Watchdog");
 
@@ -173,10 +171,10 @@ static int a21_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
-	watchdog_init_timeout(&a21_wdt, 30, &pdev->dev);
+	watchdog_init_timeout(&a21_wdt, 30, dev);
 	watchdog_set_nowayout(&a21_wdt, nowayout);
 	watchdog_set_drvdata(&a21_wdt, drv);
-	a21_wdt.parent = &pdev->dev;
+	a21_wdt.parent = dev;
 
 	reset = a21_wdt_get_bootstatus(drv);
 	if (reset == 2)
@@ -189,15 +187,15 @@ static int a21_wdt_probe(struct platform_device *pdev)
 		a21_wdt.bootstatus |= WDIOF_EXTERN2;
 
 	drv->wdt = a21_wdt;
-	dev_set_drvdata(&pdev->dev, drv);
+	dev_set_drvdata(dev, drv);
 
-	ret = devm_watchdog_register_device(&pdev->dev, &a21_wdt);
+	ret = devm_watchdog_register_device(dev, &a21_wdt);
 	if (ret) {
-		dev_err(&pdev->dev, "Cannot register watchdog device\n");
+		dev_err(dev, "Cannot register watchdog device\n");
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "MEN A21 watchdog timer driver enabled\n");
+	dev_info(dev, "MEN A21 watchdog timer driver enabled\n");
 
 	return 0;
 }
-- 
2.7.4

