Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD21C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E34420880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkYJ+EYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfDHTkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46209 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfDHTkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:40:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so7895690pll.13;
        Mon, 08 Apr 2019 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xIRF9jSr1iNa9wj40bY49yAz39Ev5BypASacngynVKY=;
        b=DkYJ+EYTf815hQkznGXsTK/3ux2iVlO9yJfiA0ug79lnboY+XxN/yKswcZXFZrD1AQ
         B2maCLy0YKH7MfFRz5pbOm+sq5xAa518jjoGc76Zn/HEB7FZOL8U0sQFtBnfG80oqJ/a
         dRjzE3mKjBsa8GM8TsuXYq3s28XTcpWzyoruYQVIpXmV4FJKY3LN5v9LdLg6BgV/QQ16
         UkHdVHtrZHcW9MKcT9X0oU+zYDZ4mnJ1ooTtV5WdxMokAiqvStuaGTTV+vBNFomV/NNd
         o/GEdvJLIKccECGg0GxHn6fndRubdzh9Gq3vAsNupD6rApD5w3DYdyudqTp97u0M0Qzy
         rzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=xIRF9jSr1iNa9wj40bY49yAz39Ev5BypASacngynVKY=;
        b=l6iuMggWke+unfAm3hLMDNKe5t19IunlJfwk//tY9Te2FYEV7Lp+b2Wpy3u9g10+Yi
         ApTmYbnfHq+Gin1G2Ty0mDDY5VBwMjf6bT8f4OUJbCa+ujeNqXl1x4FpoK4nznQE62iy
         YhPgLMVvDLiACRXGz/ME2Wjo8LLRw+Gk9QS7dXBPnX8B3G2ZGum4ltIrxEnMBCDQidui
         yjQA/GUwWey2NyAtSfXFeKGRcEjl3X3IPuPAuNVwIKekfzJKlri8paDV3n5sLMpClpGX
         6oeyxiKP3xIHapezl9KgjU6Bd6SyUuA2m2oAG5K74v6KIb4q6UCH57KmvUyG80iOkfm5
         3vBg==
X-Gm-Message-State: APjAAAXPffXZJAZZxQvYM9doJQWa/HPk9qRcf/mtaunZ3rAScP5+RcCl
        SVw6ipWBbKxJhezyBk8tjuo=
X-Google-Smtp-Source: APXvYqzK9BG3tKmqXh2yElYBXeannXSCvdvlTYkVnAiMVM0cATsZG8PjrIgwYlDmglmJPrDF0l5h8g==
X-Received: by 2002:a17:902:76c1:: with SMTP id j1mr5024988plt.98.1554752403952;
        Mon, 08 Apr 2019 12:40:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k186sm19536778pfc.137.2019.04.08.12.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:40:03 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 19/22] watchdog: intel-mid_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Mon,  8 Apr 2019 12:38:43 -0700
Message-Id: <1554752326-13319-20-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/intel-mid_wdt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 72c108a12c19..6cf7cc1ff615 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -110,12 +110,13 @@ static const struct watchdog_ops mid_wdt_ops = {
 
 static int mid_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdt_dev;
-	struct intel_mid_wdt_pdata *pdata = pdev->dev.platform_data;
+	struct intel_mid_wdt_pdata *pdata = dev->platform_data;
 	int ret;
 
 	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform data\n");
+		dev_err(dev, "missing platform data\n");
 		return -EINVAL;
 	}
 
@@ -125,7 +126,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	wdt_dev = devm_kzalloc(&pdev->dev, sizeof(*wdt_dev), GFP_KERNEL);
+	wdt_dev = devm_kzalloc(dev, sizeof(*wdt_dev), GFP_KERNEL);
 	if (!wdt_dev)
 		return -ENOMEM;
 
@@ -134,16 +135,15 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
 	wdt_dev->max_timeout = MID_WDT_TIMEOUT_MAX;
 	wdt_dev->timeout = MID_WDT_DEFAULT_TIMEOUT;
-	wdt_dev->parent = &pdev->dev;
+	wdt_dev->parent = dev;
 
-	watchdog_set_drvdata(wdt_dev, &pdev->dev);
+	watchdog_set_drvdata(wdt_dev, dev);
 
-	ret = devm_request_irq(&pdev->dev, pdata->irq, mid_wdt_irq,
+	ret = devm_request_irq(dev, pdata->irq, mid_wdt_irq,
 			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
 			       wdt_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "error requesting warning irq %d\n",
-			pdata->irq);
+		dev_err(dev, "error requesting warning irq %d\n", pdata->irq);
 		return ret;
 	}
 
@@ -163,13 +163,13 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	/* Make sure the watchdog is serviced */
 	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
 
-	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
+	ret = devm_watchdog_register_device(dev, wdt_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "error registering watchdog device\n");
+		dev_err(dev, "error registering watchdog device\n");
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "Intel MID watchdog device probed\n");
+	dev_info(dev, "Intel MID watchdog device probed\n");
 
 	return 0;
 }
-- 
2.7.4

