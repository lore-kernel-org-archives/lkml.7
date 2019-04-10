Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B4DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2608B206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFsQFKHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbfDJQaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:30:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34163 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387826AbfDJQ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so1877911pgq.1;
        Wed, 10 Apr 2019 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7d8y9AaFPQzWfMw+rRzXEYOrli0Bj0Hj+AuP2Kt4PtY=;
        b=PFsQFKHPY7fZi5sHcitxzm8lzcIf3CbKyaLPucO7NXshFKZHyg5ca4llgbbnUlTQU6
         HeAurxc/iQhctxiIuPbX3l0XO69QjGoMa6bY8hKvXiLMtJSrjzhN8aDOKFUyhz4ReVga
         2h70mgrrnwlTOYz+gnnVRw6CjdIS28hCNi/RnitrxvlSoh63bmaxbQn+ScPCG0uQbt6A
         dyOvr9dB+fk3A5J+oY+C2oeAnTXoGMJH32oWW3p5oG9JE4T2NDkeLIy9SDEkGLkj0xbL
         LfTajllZwcYaaXExukomxlEbrBbtGKKPgBiycfusdEPAmqePDUx7WrJ22rD0QyJECgeq
         RZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7d8y9AaFPQzWfMw+rRzXEYOrli0Bj0Hj+AuP2Kt4PtY=;
        b=SOaBPzW5qbHO7u5ehf2HVYWe+ar/P4inp4BFmz3/qCIv/YOAhG5V6WOFtKXz4D5Ngx
         LQJImuDAwWuzA47d+YRq5beW7f79dnoJ4hJ+P5fyVu+/d5v+Td9J5qW2c/n8a3ST9hY1
         yjrcGW3fbwE3uHloMa018tCGYegCTBP7xJklX/2Hnj2Q+VJqWzO1raO+Q5WbFgP0EaJU
         7qqDfwGyJr6lC00rGS73G240Dy1E4wD6eAzddQ8jw5jbFrVUmpex5/br1AG9J8g+Hd2X
         ZjPrtOWHOOdqIdsGvkrYJDe6DjPSctdqa4N98aInMdsO10Hz9ei4Vp8IUpx0OKRhycyF
         twRg==
X-Gm-Message-State: APjAAAX6GBb37AF77s77IYTQR5qxjkXJGbpSXdg1/wKfXIE103qX43sl
        Pt9c1ixV7CsD8bOfat0pN7bFiYdY
X-Google-Smtp-Source: APXvYqwQc4XE5V6f4wnfvXH/Emk+pwYA4neiEWr2Ald8g4SZNB4yhNihE8LzzRbV1LC7MwLtZqV/pQ==
X-Received: by 2002:a62:4602:: with SMTP id t2mr44116656pfa.26.1554913694884;
        Wed, 10 Apr 2019 09:28:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8sm28585202pgp.48.2019.04.10.09.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:14 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/22] watchdog: twl4030_wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:46 -0700
Message-Id: <1554913683-25454-6-git-send-email-linux@roeck-us.net>
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
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/twl4030_wdt.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 569fe85e52da..74c5737cd934 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -70,10 +70,10 @@ static const struct watchdog_ops twl4030_wdt_ops = {
 
 static int twl4030_wdt_probe(struct platform_device *pdev)
 {
-	int ret = 0;
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdt;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -83,27 +83,14 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
 	wdt->timeout		= 30;
 	wdt->min_timeout	= 1;
 	wdt->max_timeout	= 30;
-	wdt->parent = &pdev->dev;
+	wdt->parent = dev;
 
 	watchdog_set_nowayout(wdt, nowayout);
 	platform_set_drvdata(pdev, wdt);
 
 	twl4030_wdt_stop(wdt);
 
-	ret = watchdog_register_device(wdt);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int twl4030_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(wdt);
-
-	return 0;
+	return devm_watchdog_register_device(dev, wdt);
 }
 
 #ifdef CONFIG_PM
@@ -137,7 +124,6 @@ MODULE_DEVICE_TABLE(of, twl_wdt_of_match);
 
 static struct platform_driver twl4030_wdt_driver = {
 	.probe		= twl4030_wdt_probe,
-	.remove		= twl4030_wdt_remove,
 	.suspend	= twl4030_wdt_suspend,
 	.resume		= twl4030_wdt_resume,
 	.driver		= {
-- 
2.7.4

