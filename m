Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95052C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681F321874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLElhYcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfDHTkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42325 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbfDHTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:40:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so6762432pfi.9;
        Mon, 08 Apr 2019 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhq23W063Hg+OizeeK28CfYTYMrp8EDUYCfhW6z14sY=;
        b=bLElhYcYFIHUI4PMLwo+mkkxO1LdYxsFvtg8QtUX72PU72XksZD8ID77vf1r8FIEXB
         qHyQqeGM5QO1ZMcTpAFyF7fdoN8ox6W8an4WuOmcuhk5hLbtspDGhCluxB0CAwOHbMxf
         X3pcKjgBn4ux7pe638ktbKNbp+6izk36gJCL4VyyakriwMrmaVLnVISC3ZhyNYlGbI/E
         dsHn7lxqi8GIJfTlhvE+r8hJdtAzC8xz49iqE6HSHqKSp1PML2F2OfImg68PnZR+YbcD
         +ftkcheXb5nwxWoKwrLmr04rTqEZw2F2XRCPECI2IN/HqGZmo2Z1jZJWCkILB3FmqPg9
         0dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dhq23W063Hg+OizeeK28CfYTYMrp8EDUYCfhW6z14sY=;
        b=Mgy1LrJZ8AavhXmUjX/4Qsv0A6RvvaDtz0GU27ClFF4LrgUcMf+CnR6Bl/l+VGsEHu
         0Am7cuz9/Ucz/RgJBAiZzIjlLbHByWcMBH9syJNTllS3SGEQO6PKE3I8OPHP2cTC4woB
         ZbfrWE3+ywo9SSkAbF2BwU6BaUzfZ/iiwRTxNoNFkiplj1BNqF+ZXTaEks5Z4ocQmKc9
         FJdNz72wNitCItuAYXSLtwDtgKbzMcv+6z8LqkTHXthuI0F0Jm8FkE0vdEYEKEfF0mml
         +u4jkx7DyJKVRrHDQtq/3v1Ypz9t0BtR2cugT9CcbulM+mKlWSVm7M88P87dA+l8//80
         DQ8Q==
X-Gm-Message-State: APjAAAV22Gk+YoY8AnFBxUyFZQOQGmOEmQ2yibPeVSQxzzKLSP9XXIGY
        1MIM4tEvkE1XfBosXkzH3Os=
X-Google-Smtp-Source: APXvYqwQmcY55dNXBsesBAW6bKAszhKxj2s0FvNY0YD40M7Qp6VT8yysYpntoBAN2hox4RVH20tKJw==
X-Received: by 2002:a63:1918:: with SMTP id z24mr28803475pgl.406.1554752408016;
        Mon, 08 Apr 2019 12:40:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4sm51663676pfh.146.2019.04.08.12.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:40:07 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 22/22] watchdog: max63xx_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:46 -0700
Message-Id: <1554752326-13319-23-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/max63xx_wdt.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 5aaf13e5115a..3a899628a834 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -200,11 +200,12 @@ static int max63xx_mmap_init(struct platform_device *p, struct max63xx_wdt *wdt)
 
 static int max63xx_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct max63xx_wdt *wdt;
 	struct max63xx_timeout *table;
 	int err;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -215,7 +216,7 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 
 	wdt->timeout = max63xx_select_timeout(table, heartbeat);
 	if (!wdt->timeout) {
-		dev_err(&pdev->dev, "unable to satisfy %ds heartbeat request\n",
+		dev_err(dev, "unable to satisfy %ds heartbeat request\n",
 			heartbeat);
 		return -EINVAL;
 	}
@@ -227,30 +228,22 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, &wdt->wdd);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
-	wdt->wdd.parent = &pdev->dev;
+	wdt->wdd.parent = dev;
 	wdt->wdd.timeout = wdt->timeout->twd;
 	wdt->wdd.info = &max63xx_wdt_info;
 	wdt->wdd.ops = &max63xx_wdt_ops;
 
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
 
-	err = watchdog_register_device(&wdt->wdd);
+	err = devm_watchdog_register_device(dev, &wdt->wdd);
 	if (err)
 		return err;
 
-	dev_info(&pdev->dev, "using %ds heartbeat with %ds initial delay\n",
+	dev_info(dev, "using %ds heartbeat with %ds initial delay\n",
 		 wdt->timeout->twd, wdt->timeout->tdelay);
 	return 0;
 }
 
-static int max63xx_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(wdd);
-	return 0;
-}
-
 static const struct platform_device_id max63xx_id_table[] = {
 	{ "max6369_wdt", (kernel_ulong_t)max6369_table, },
 	{ "max6370_wdt", (kernel_ulong_t)max6369_table, },
@@ -264,7 +257,6 @@ MODULE_DEVICE_TABLE(platform, max63xx_id_table);
 
 static struct platform_driver max63xx_wdt_driver = {
 	.probe		= max63xx_wdt_probe,
-	.remove		= max63xx_wdt_remove,
 	.id_table	= max63xx_id_table,
 	.driver		= {
 		.name	= "max63xx_wdt",
-- 
2.7.4

