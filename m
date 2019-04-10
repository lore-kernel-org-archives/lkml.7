Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7EFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E35420830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q82NDTlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbfDJQ3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:29:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40159 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387860AbfDJQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so1859178pgl.7;
        Wed, 10 Apr 2019 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y0Tfyx52U1gnhb4CI3YOiBgsMKA1CP/i626KdchFSTE=;
        b=Q82NDTlG9wa7YzLyMSjoMyx+H3vIH5Gr6IOtw6nucPu9SuUIvoChdsKT1VyBKkznAH
         5VLx6o+SbV6gPQf5Mg8OWJdJQA1SgfLjydJMgXamTK7bXhhwB6dJ0O4SlyS6hb/GBmTv
         lYuzmriuwamizvLnENTg781vYK0RaZShttYctKL7E29puRk+28eSCxx+dZ0XGrYmftVQ
         0LPKSitONLSAIN5Zc8c4xUpgk4UYM5SjwsXby68g5YluvXtizQEfVp+dvMj4WiDfxEfS
         HOCm01Ou2LmldGwx0Ur9SlrY8k+JqMQE9L38WL6eHAnoz+PDnweGhCzfGpNwrbtbhq62
         gGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Y0Tfyx52U1gnhb4CI3YOiBgsMKA1CP/i626KdchFSTE=;
        b=hLqCKkM2WO1hPPXSoE68C6gUHAfq/oXkKIuJ7V3rtCgtngvwg/5VKhRLsmVmNAmtnG
         x9ia6kTKDt94f2GnjAlD0TBg2unVm3Inxd4RRqgxmZ5rcshEUKEpC385wXTMRpqfR9TZ
         vGsOB77/x8S/Hkc176+re7NrHCmh7J2GL8ekzwycsTRlyaWRB79WHv9dQv9GhUh0JzYf
         sTOuM71VsHYl4pFBC40su7gbjJ36XvYXmud26YKXuD1LEkAoGdMsSrIrEvuQXB0WW04k
         fWPPO0h5KEbQg5ycl4kDXw+c0bCRYGQ7zQy1IIihQ0JCieFcFAGAb9x6ybfuJmVlpwbX
         /8Yw==
X-Gm-Message-State: APjAAAVOrGwKbd3tRNWh++BkKlNlBw+8EbbqG2OYszJgo5dEcOst4EuP
        B5j9S7U9vFtwQQXAXSBVVm0=
X-Google-Smtp-Source: APXvYqy3+NLX6FD5hO4V3KoLt+72aXQmJJf2KB1W3ugIJDjX1FQt6aXKCVGUrXanhV+bq5NcWrJy6Q==
X-Received: by 2002:a63:7141:: with SMTP id b1mr41779549pgn.331.1554913708702;
        Wed, 10 Apr 2019 09:28:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13sm51605956pgc.25.2019.04.10.09.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:28 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 15/22] watchdog: pic32-dmt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:56 -0700
Message-Id: <1554913683-25454-16-git-send-email-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/pic32-dmt.c | 46 ++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
index 052751c224fd..9a3c53e03c60 100644
--- a/drivers/watchdog/pic32-dmt.c
+++ b/drivers/watchdog/pic32-dmt.c
@@ -168,13 +168,19 @@ static struct watchdog_device pic32_dmt_wdd = {
 	.ops		= &pic32_dmt_fops,
 };
 
+static void pic32_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int pic32_dmt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	struct pic32_dmt *dmt;
 	struct watchdog_device *wdd = &pic32_dmt_wdd;
 
-	dmt = devm_kzalloc(&pdev->dev, sizeof(*dmt), GFP_KERNEL);
+	dmt = devm_kzalloc(dev, sizeof(*dmt), GFP_KERNEL);
 	if (!dmt)
 		return -ENOMEM;
 
@@ -182,54 +188,41 @@ static int pic32_dmt_probe(struct platform_device *pdev)
 	if (IS_ERR(dmt->regs))
 		return PTR_ERR(dmt->regs);
 
-	dmt->clk = devm_clk_get(&pdev->dev, NULL);
+	dmt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(dmt->clk)) {
-		dev_err(&pdev->dev, "clk not found\n");
+		dev_err(dev, "clk not found\n");
 		return PTR_ERR(dmt->clk);
 	}
 
 	ret = clk_prepare_enable(dmt->clk);
 	if (ret)
 		return ret;
+	ret = devm_add_action_or_reset(dev, pic32_clk_disable_unprepare,
+				       dmt->clk);
+	if (ret)
+		return ret;
 
 	wdd->timeout = pic32_dmt_get_timeout_secs(dmt);
 	if (!wdd->timeout) {
-		dev_err(&pdev->dev,
-			"failed to read watchdog register timeout\n");
-		ret = -EINVAL;
-		goto out_disable_clk;
+		dev_err(dev, "failed to read watchdog register timeout\n");
+		return -EINVAL;
 	}
 
-	dev_info(&pdev->dev, "timeout %d\n", wdd->timeout);
+	dev_info(dev, "timeout %d\n", wdd->timeout);
 
 	wdd->bootstatus = pic32_dmt_bootstatus(dmt) ? WDIOF_CARDRESET : 0;
 
 	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
 	watchdog_set_drvdata(wdd, dmt);
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret) {
-		dev_err(&pdev->dev, "watchdog register failed, err %d\n", ret);
-		goto out_disable_clk;
+		dev_err(dev, "watchdog register failed, err %d\n", ret);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, wdd);
 	return 0;
-
-out_disable_clk:
-	clk_disable_unprepare(dmt->clk);
-	return ret;
-}
-
-static int pic32_dmt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-	struct pic32_dmt *dmt = watchdog_get_drvdata(wdd);
-
-	watchdog_unregister_device(wdd);
-	clk_disable_unprepare(dmt->clk);
-
-	return 0;
 }
 
 static const struct of_device_id pic32_dmt_of_ids[] = {
@@ -240,7 +233,6 @@ MODULE_DEVICE_TABLE(of, pic32_dmt_of_ids);
 
 static struct platform_driver pic32_dmt_driver = {
 	.probe		= pic32_dmt_probe,
-	.remove		= pic32_dmt_remove,
 	.driver		= {
 		.name		= "pic32-dmt",
 		.of_match_table = of_match_ptr(pic32_dmt_of_ids),
-- 
2.7.4

