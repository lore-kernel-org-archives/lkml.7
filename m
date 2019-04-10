Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72040C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB8520830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyKbWJwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfDJQ2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41342 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387884AbfDJQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1856016pgs.8;
        Wed, 10 Apr 2019 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JFv/8qpijJBi/9fN4f4BgoRTl0I89T7cUIqnwNgfi5A=;
        b=cyKbWJwEIouqNYxadt+0H1pjEPe1zG8jT/lZkrFPingsqh2a8NK8jER/bUy6OGpqMy
         qFsV4+GNoq3P1g/C9HmzUEqL7GEdTPt1aJS2fP0ucYkoWzXzI6YfCKZlw8jF3KxkfOZJ
         gN5PCdHV2HcK4hvNIxNBmZpNI3e04PdeWB4ogeC4LWcIZG5IZRsvJffhRtciuE9nHV/w
         aty3VBCDQdPYRJ4pYON+p/Q3w5kwRKnbdpqmV0MVeMkeobzomEAEzx7opteuDiudH8b6
         ee61GwOw9alfAs90DRGdIPNETqCcA6akyohfKbLErQXi600YEHERbkbawgcPorRFFq74
         niWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JFv/8qpijJBi/9fN4f4BgoRTl0I89T7cUIqnwNgfi5A=;
        b=VbH5nvc07wYlVKCoCAYa9tqQJ9XRMMyAF8/+u4OqaZHRd7+WGrKJ+GRvfA0NMpUFS0
         eyjD8pjxtGv2QQTEEql3AxFO+Otr2Awif6ur6yxHxeIutKYunESwtsyyCALK0tmIyEP/
         0LJOMoREmaT332elcYvpUsNDsM0ovp2d2EYgxYAUEIPwopIE9LUBTJ3CUp/YWbqwQCGH
         YxsCITDP73MyPcKzqC1qip2xLhLqt4u9z4hgpEITe6NJ/vLMuA6cxDISHgiCnNfE+4pq
         oUEYYFIZDhXIn3jIrDxhK4rDLsBFoKN+TQNDiccGcDMCbZ5WF7lF8ddvCvJv2+bNUmwD
         lOmQ==
X-Gm-Message-State: APjAAAVeDhWOKPIQMQ2kk9WJiV8T6oVF4Xz4I8Lsgvncrz9uFaIL6adB
        VhiWqLmE00cIfoGV+zLzAHE=
X-Google-Smtp-Source: APXvYqxKvKwV403NJxB3coP59geUiwZbzyTbPDCSujVLzZlaV3Uw17VFIBe3YwlfiH3cTIoKyqOJ4w==
X-Received: by 2002:a65:608a:: with SMTP id t10mr30773110pgu.125.1554913711421;
        Wed, 10 Apr 2019 09:28:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n3sm63468609pfa.99.2019.04.10.09.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:30 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 17/22] watchdog: loongson1_wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:58 -0700
Message-Id: <1554913683-25454-18-git-send-email-linux@roeck-us.net>
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
- Drop unnecessary braces around conditional return statements
- Drop empty remove function
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Keguang Zhang <keguang.zhang@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/loongson1_wdt.c | 48 ++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 1119634b5c87..d8075e2affa7 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -83,14 +83,20 @@ static const struct watchdog_ops ls1x_wdt_ops = {
 	.set_timeout = ls1x_wdt_set_timeout,
 };
 
+static void ls1x_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int ls1x_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct ls1x_wdt_drvdata *drvdata;
 	struct watchdog_device *ls1x_wdt;
 	unsigned long clk_rate;
 	int err;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
@@ -98,21 +104,23 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
-	drvdata->clk = devm_clk_get(&pdev->dev, pdev->name);
+	drvdata->clk = devm_clk_get(dev, pdev->name);
 	if (IS_ERR(drvdata->clk))
 		return PTR_ERR(drvdata->clk);
 
 	err = clk_prepare_enable(drvdata->clk);
 	if (err) {
-		dev_err(&pdev->dev, "clk enable failed\n");
+		dev_err(dev, "clk enable failed\n");
 		return err;
 	}
+	err = devm_add_action_or_reset(dev, ls1x_clk_disable_unprepare,
+				       drvdata->clk);
+	if (err)
+		return err;
 
 	clk_rate = clk_get_rate(drvdata->clk);
-	if (!clk_rate) {
-		err = -EINVAL;
-		goto err0;
-	}
+	if (!clk_rate)
+		return -EINVAL;
 	drvdata->clk_rate = clk_rate;
 
 	ls1x_wdt = &drvdata->wdt;
@@ -121,41 +129,27 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	ls1x_wdt->timeout = DEFAULT_HEARTBEAT;
 	ls1x_wdt->min_timeout = 1;
 	ls1x_wdt->max_hw_heartbeat_ms = U32_MAX / clk_rate * 1000;
-	ls1x_wdt->parent = &pdev->dev;
+	ls1x_wdt->parent = dev;
 
-	watchdog_init_timeout(ls1x_wdt, heartbeat, &pdev->dev);
+	watchdog_init_timeout(ls1x_wdt, heartbeat, dev);
 	watchdog_set_nowayout(ls1x_wdt, nowayout);
 	watchdog_set_drvdata(ls1x_wdt, drvdata);
 
-	err = watchdog_register_device(&drvdata->wdt);
+	err = devm_watchdog_register_device(dev, &drvdata->wdt);
 	if (err) {
-		dev_err(&pdev->dev, "failed to register watchdog device\n");
-		goto err0;
+		dev_err(dev, "failed to register watchdog device\n");
+		return err;
 	}
 
 	platform_set_drvdata(pdev, drvdata);
 
-	dev_info(&pdev->dev, "Loongson1 Watchdog driver registered\n");
-
-	return 0;
-err0:
-	clk_disable_unprepare(drvdata->clk);
-	return err;
-}
-
-static int ls1x_wdt_remove(struct platform_device *pdev)
-{
-	struct ls1x_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&drvdata->wdt);
-	clk_disable_unprepare(drvdata->clk);
+	dev_info(dev, "Loongson1 Watchdog driver registered\n");
 
 	return 0;
 }
 
 static struct platform_driver ls1x_wdt_driver = {
 	.probe = ls1x_wdt_probe,
-	.remove = ls1x_wdt_remove,
 	.driver = {
 		.name = "ls1x-wdt",
 	},
-- 
2.7.4

