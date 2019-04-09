Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7214C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F0B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTu6A/z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDIRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41327 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfDIRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so10102180pfd.8;
        Tue, 09 Apr 2019 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lKK60SRn4Yg+ug3ZuVwplfkDLIPIcVbLLqOT7dazmwU=;
        b=eTu6A/z3loUpBg9jMjGriS2YEdRi2lhXjNsk299FLuyTIlMs9mn5pXh9IK8usUqBCM
         bGVzRS62USkpvoAT993gZcysI7EFxALhiVeKM8Q2Qm3h4DnG6d+0FLOsB/VyBFahg201
         XDxgsivig3v/J47SsN8JR5wnP3YK8vuTzzWag1v9rj17Tm8yk7d1TIO20uk6b9BTlCzi
         rjC3f3qzq5HHsYpRMyp5f4rx0UYx7TzBEf4iHHeA2it7S7bUxwxRgjirNJVuU8xbXZyP
         /UpHp+OX721fxmLsjGO7XZ6OoiHjRlE6ZtGKn6CAbylUhJmgu/swa1dbRhWaylzD5DA0
         iQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=lKK60SRn4Yg+ug3ZuVwplfkDLIPIcVbLLqOT7dazmwU=;
        b=s2WXv5XCq4ygBgm9QNIF3aet53qq1lyhy9lPNVqqfbWV/YkwEo2umrl1VfRkgtrmKZ
         X+fMWvgM4J7UMoMGjviFrX5QcvJJnyMUaexlJWlFLen1i0iJRZTK/qrdg/3OKDdlsM5T
         RJR7q7BRdyWtOVO39ZanTUT0IafVIG8b2LCeBfGlw+oq8qEp+nxQLfV78375yWp7+NDS
         6EUdY5WaXmJM4ZOkchfvQxq5UKAiBxNj/KxTks6YKroWol3QrW+lLDX8f/3gAPyJgL8m
         cKBb6374n3PUHMzuqRJH8Hlus04rEFs7gst9mqcGAWC0inB1i3Wz5usEmKRZgJq0w6H4
         m5BQ==
X-Gm-Message-State: APjAAAXivQLcmJX6QcABwRuLcrj21oIwnBXiAQYhRdwD74/cA5QJk3V9
        sDOrzeUGsTI+Apk8Hks4eqU=
X-Google-Smtp-Source: APXvYqwfI7ksbaYhkYikx2wZpQ4iyZ4y4kMAlflNq1y6hNW6n6dSs/KzPW88VTxWq22/2MJ2KTOkvw==
X-Received: by 2002:a65:414a:: with SMTP id x10mr36248725pgp.237.1554830682425;
        Tue, 09 Apr 2019 10:24:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x128sm34556912pfx.103.2019.04.09.10.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:41 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 22/23] watchdog: sunxi_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue,  9 Apr 2019 10:24:00 -0700
Message-Id: <1554830641-9247-23-git-send-email-linux@roeck-us.net>
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

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sunxi_wdt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index f0e7ef40b1e4..9c22f7753c6b 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -233,14 +233,15 @@ MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
 
 static int sunxi_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sunxi_wdt_dev *sunxi_wdt;
 	int err;
 
-	sunxi_wdt = devm_kzalloc(&pdev->dev, sizeof(*sunxi_wdt), GFP_KERNEL);
+	sunxi_wdt = devm_kzalloc(dev, sizeof(*sunxi_wdt), GFP_KERNEL);
 	if (!sunxi_wdt)
 		return -EINVAL;
 
-	sunxi_wdt->wdt_regs = of_device_get_match_data(&pdev->dev);
+	sunxi_wdt->wdt_regs = of_device_get_match_data(dev);
 	if (!sunxi_wdt->wdt_regs)
 		return -ENODEV;
 
@@ -253,9 +254,9 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	sunxi_wdt->wdt_dev.timeout = WDT_MAX_TIMEOUT;
 	sunxi_wdt->wdt_dev.max_timeout = WDT_MAX_TIMEOUT;
 	sunxi_wdt->wdt_dev.min_timeout = WDT_MIN_TIMEOUT;
-	sunxi_wdt->wdt_dev.parent = &pdev->dev;
+	sunxi_wdt->wdt_dev.parent = dev;
 
-	watchdog_init_timeout(&sunxi_wdt->wdt_dev, timeout, &pdev->dev);
+	watchdog_init_timeout(&sunxi_wdt->wdt_dev, timeout, dev);
 	watchdog_set_nowayout(&sunxi_wdt->wdt_dev, nowayout);
 	watchdog_set_restart_priority(&sunxi_wdt->wdt_dev, 128);
 
@@ -264,12 +265,12 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
 
 	watchdog_stop_on_reboot(&sunxi_wdt->wdt_dev);
-	err = devm_watchdog_register_device(&pdev->dev, &sunxi_wdt->wdt_dev);
+	err = devm_watchdog_register_device(dev, &sunxi_wdt->wdt_dev);
 	if (unlikely(err))
 		return err;
 
-	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
-			sunxi_wdt->wdt_dev.timeout, nowayout);
+	dev_info(dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
+		 sunxi_wdt->wdt_dev.timeout, nowayout);
 
 	return 0;
 }
-- 
2.7.4

