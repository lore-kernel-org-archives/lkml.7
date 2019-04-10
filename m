Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1E2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1975A20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak4Doerc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbfDJQ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44917 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387916AbfDJQ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so1719955pll.11;
        Wed, 10 Apr 2019 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=25JklC8A4qyogv/IaoK9AgYKIsQkHJeUki9cBit+3VU=;
        b=ak4DoercFbxPpvsydlQjYOWYxP6CgPEp7VabpBizbOoeTsDVhWGEakU61rc48z81TR
         nMZctSX+j1dy9JzIZkpdXQ9KJQuq1hhkLdiGsdSlyCxzW7B+J7YzWi2EUvwO6GKv5CUf
         s24PQqvBI0ObnWoALxtD7bfBUSfUNLACagvnK0HFIpowVB3kIjSgYWb8nfMVUwjIrtpB
         IuWETP/c0yvLLvl5hrfsb/KHuO4RDqmh9ipTMRdfm5WdjlEYRaIdGEoGEbqaA5qt9sXU
         ADj3DBCDDG8EqkphoAfZpNE/9TW5/Ix+GFxw9s9TjAOSaA9lOJNO7R0mqDWNbRcf3jyd
         s5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=25JklC8A4qyogv/IaoK9AgYKIsQkHJeUki9cBit+3VU=;
        b=FIDZbsAEBQwpwuKrI/SjUN/cWU0N+qCPti43aj6orGqIHrIc5MgiPpDqZquSmcb+ZU
         VDE9qhs4BXuZ48vd7dPDs8H6zW0LQPuZVOOBqHHk9lVjMvtJYG2DGMgLnPknH3LpN6EL
         oEBpg4bqTiB02u4aOJ3L9LbhHjXqvjzJYPb+Kkyr19rpggk+x6QX8S+go73HiGl/Le+t
         A425asEII9BxAAZvRTpJA1ExoSffK1ouzuCLjfooUYl+EtCcpMEvcCFpjLfVL899m7lD
         nNmbNOmlLWFFftZxRf/xI/N0LgD1E32re+T8Ob5A/kcS+GbNnfEFhZeYTRYvGmpfyKvZ
         H4BA==
X-Gm-Message-State: APjAAAU/cconsd4+kosIHb03Ilsy1nruVW6ukKMgMUZi6XBBYgBxDCYq
        ZRznDHvfjG2Iwpxh6F5uZitLFQQo
X-Google-Smtp-Source: APXvYqxMz2E8UD9M1MOcqbN79WjCl0SKlTe8lYKGzBnvquwMX6vXODB+lbv8eA8NvroqkfS7bACy9w==
X-Received: by 2002:a17:902:9a4a:: with SMTP id x10mr45274440plv.113.1554913710028;
        Wed, 10 Apr 2019 09:28:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p17sm48206877pfn.157.2019.04.10.09.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:29 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 16/22] watchdog: pic32-wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:57 -0700
Message-Id: <1554913683-25454-17-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/pic32-wdt.c | 58 ++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index 455ec38363a6..540500940cc0 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -166,13 +166,19 @@ static const struct of_device_id pic32_wdt_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, pic32_wdt_dt_ids);
 
+static void pic32_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int pic32_wdt_drv_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	struct watchdog_device *wdd = &pic32_wdd;
 	struct pic32_wdt *wdt;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -180,73 +186,57 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->regs))
 		return PTR_ERR(wdt->regs);
 
-	wdt->rst_base = devm_ioremap(&pdev->dev, PIC32_BASE_RESET, 0x10);
+	wdt->rst_base = devm_ioremap(dev, PIC32_BASE_RESET, 0x10);
 	if (!wdt->rst_base)
 		return -ENOMEM;
 
-	wdt->clk = devm_clk_get(&pdev->dev, NULL);
+	wdt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(wdt->clk)) {
-		dev_err(&pdev->dev, "clk not found\n");
+		dev_err(dev, "clk not found\n");
 		return PTR_ERR(wdt->clk);
 	}
 
 	ret = clk_prepare_enable(wdt->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "clk enable failed\n");
+		dev_err(dev, "clk enable failed\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, pic32_clk_disable_unprepare,
+				       wdt->clk);
+	if (ret)
+		return ret;
 
 	if (pic32_wdt_is_win_enabled(wdt)) {
-		dev_err(&pdev->dev, "windowed-clear mode is not supported.\n");
-		ret = -ENODEV;
-		goto out_disable_clk;
+		dev_err(dev, "windowed-clear mode is not supported.\n");
+		return -ENODEV;
 	}
 
-	wdd->timeout = pic32_wdt_get_timeout_secs(wdt, &pdev->dev);
+	wdd->timeout = pic32_wdt_get_timeout_secs(wdt, dev);
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
 
 	wdd->bootstatus = pic32_wdt_bootstatus(wdt) ? WDIOF_CARDRESET : 0;
 
 	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
 	watchdog_set_drvdata(wdd, wdt);
 
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
-	clk_disable_unprepare(wdt->clk);
-
-	return ret;
-}
-
-static int pic32_wdt_drv_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-	struct pic32_wdt *wdt = watchdog_get_drvdata(wdd);
-
-	watchdog_unregister_device(wdd);
-	clk_disable_unprepare(wdt->clk);
-
-	return 0;
 }
 
 static struct platform_driver pic32_wdt_driver = {
 	.probe		= pic32_wdt_drv_probe,
-	.remove		= pic32_wdt_drv_remove,
 	.driver		= {
 		.name		= "pic32-wdt",
 		.of_match_table = of_match_ptr(pic32_wdt_dt_ids),
-- 
2.7.4

