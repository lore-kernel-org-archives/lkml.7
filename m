Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93F4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1B221734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2hfqMMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDIRYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45014 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfDIRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so9669728pgj.11;
        Tue, 09 Apr 2019 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JZEYa3ly8OHfRyblvnsc1Mq4A63GITyn9+eW6LRG6T8=;
        b=a2hfqMMqsMQkahqYCKaeGT1+SqfxIyR5b7acDrrjM+SxM+Y+2hjgqElVnXF+AdSLF4
         dBhCA0hjY7/vFb7cjjr2SCIK6q4Mzu9y7Fu2aU4Hh/UlHWMR0a/LugrJ9TIO115DVGHn
         kSX8yr1ph+nRWwmAwHqD5pgHaniE9S+evn/vpJliw7hEhQGQQ+7pKWHTScWo6m4fMTOS
         5SyYAA5+0ycXfAOdjO3+bRpin3pM82FJMmN+mmHs9olPS9pBSI5jp2bGacwpetitgXw5
         5UoYI0dtsH78MxYRVSdSALv/U/BQO0kdZpd1qOx2rDA9tXmCR3jgYTWfHxtmZdKkLSRv
         VvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JZEYa3ly8OHfRyblvnsc1Mq4A63GITyn9+eW6LRG6T8=;
        b=jzgLI6C7E7H2wPz/2i/ETCeV+JRRRnS1iuiRs7bYuLH7WAgx09B7dywWogj1s/p+ql
         ibUrBwXkM+8AjcpTRefwXYVAisB4UxBnv1D9INZ06dmfED0IZlHWSfLyb9ORlyEK0obD
         8kCLPuvfEGRX6366iuCSXqvM416ez5/OZa5iKVXF7uComOP3VclcFGgJL87y06qW3PfJ
         q1684LC+x6Q0la9ClCE1qany1D6FKUimRG0WeT7byUt+Z6it1wXJihg+KuOGcgWQ+Ybz
         UnSS/dwtQXaxyExZGy7pnrPjY9swxsUY6czclU8hIjOQFVRXYw5ZRuxp3CEI/BR2A/25
         M7kA==
X-Gm-Message-State: APjAAAWW5/r05mg6N6jImc0Gb4ei3RXxL7eK7N+cvfTnQ0foF5TSZk9N
        sQ6dLGlU2F47JQjJzgdTyYY=
X-Google-Smtp-Source: APXvYqw7WFvTSSxwx0Vw8QBSB/a/O41O6ttJyXFXT+MMs+zyX3WsUQ782Hwa80CNoI68FOdQtx3xvA==
X-Received: by 2002:a63:1548:: with SMTP id 8mr33492294pgv.277.1554830661645;
        Tue, 09 Apr 2019 10:24:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n22sm38977234pfa.51.2019.04.09.10.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:21 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/23] watchdog: moxart_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:45 -0700
Message-Id: <1554830641-9247-8-git-send-email-linux@roeck-us.net>
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
- Replace 'of_clk_get(np, 0)' with 'devm_clk_get(dev, NULL)'
- Use local variable 'struct device *dev' consistently
- Replace stop on remove with call to watchdog_stop_on_unregister()
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/moxart_wdt.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 740215a247fc..6340a1f5f471 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -91,7 +91,6 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 {
 	struct moxart_wdt_dev *moxart_wdt;
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
 	struct clk *clk;
 	int err;
 	unsigned int max_timeout;
@@ -107,7 +106,7 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(moxart_wdt->base))
 		return PTR_ERR(moxart_wdt->base);
 
-	clk = of_clk_get(node, 0);
+	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
 		pr_err("%s: of_clk_get failed\n", __func__);
 		return PTR_ERR(clk);
@@ -134,7 +133,8 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&moxart_wdt->dev, moxart_wdt);
 
-	err = watchdog_register_device(&moxart_wdt->dev);
+	watchdog_stop_on_unregister(&moxart_wdt->dev);
+	err = devm_watchdog_register_device(dev, &moxart_wdt->dev);
 	if (err)
 		return err;
 
@@ -144,15 +144,6 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int moxart_wdt_remove(struct platform_device *pdev)
-{
-	struct moxart_wdt_dev *moxart_wdt = platform_get_drvdata(pdev);
-
-	moxart_wdt_stop(&moxart_wdt->dev);
-
-	return 0;
-}
-
 static const struct of_device_id moxart_watchdog_match[] = {
 	{ .compatible = "moxa,moxart-watchdog" },
 	{ },
@@ -161,7 +152,6 @@ MODULE_DEVICE_TABLE(of, moxart_watchdog_match);
 
 static struct platform_driver moxart_wdt_driver = {
 	.probe      = moxart_wdt_probe,
-	.remove     = moxart_wdt_remove,
 	.driver     = {
 		.name		= "moxart-watchdog",
 		.of_match_table	= moxart_watchdog_match,
-- 
2.7.4

