Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B8020883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXIHLeaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDIRZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:25:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42001 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfDIRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so9680840pgh.9;
        Tue, 09 Apr 2019 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LjXyeY61Q8IuuG1hh9T51lQPEaZHlcAN/+KWHwI+dVE=;
        b=dXIHLeaKyxHPjUY4JJgxryi/6ufUxkP/CHFSdqR+fmn0stHaLNbGM5agKZyAKvgMTD
         EOF5aSlOlf59xUDvJy6CfvpYsn0M9fUhOgyO3LoyWnoiUCQPDQ3r1bDRgtGa1jpXJWs9
         yD0ZZ1ZFC331fibCFf7eWP0QEEWFG4811ypbEUw1eDbieVcneiqnWyWFWRj8qJLKT0LQ
         L210dAJJ1HbGzBTlIwjh5zBW8MlF4VeMKX9MuZaIILM9VkwKFc6ZM52IJwdKQWz9sDju
         CwFns9vk6yZFC5AVJfqiZq2lDMQ+Ml1hZApt07Nsyfp+zr0XF3I+uAkWKAE1ruBJwZE1
         ZnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=LjXyeY61Q8IuuG1hh9T51lQPEaZHlcAN/+KWHwI+dVE=;
        b=Wvp5xhUBZJ6bqmrMueURxIITvC9i/QhNq24RSLTzk5lHrBPQBz3WivSdAjy6G6NYBH
         +s7wj1hP1qA0JKqCidGz4ns4UFNa8ez+GQSPne6VqUnPKlhBSVpwFzsLhoZu17fVAXIL
         6XKygLZRIGJ1qDy6Hrvjfu5giJBuCw29BG4DVYsix37R3KFrWDos4GCOo2NJQ6bMzHrq
         /8IKShL3ymHZPhEQhJncV3nQ1kaexde+gWfTR3nnU9h4hFd8bXDZnbESjG9ftVxNc0rp
         NL92rXeNzLPsy4f6G6FmV5eOVY4m7VdbpJaKmwVBLdYUp/InIig1Iz/MAiEAtCOA/iAG
         pmog==
X-Gm-Message-State: APjAAAWCO9Fsddtm8cDOPbtahKDNtBpTD/RhX2Qyy8gSgH7lMAgRDG0p
        0ea957eUAEXUO0Yo4hsGMvKqWbkO
X-Google-Smtp-Source: APXvYqwwX4X15/vOJSIOcGoNs31H6HZ1IkyLKtNz6ucoR3CGTvSkSnFaYZjXFCbBiPa0GCd/lU9leA==
X-Received: by 2002:a63:c104:: with SMTP id w4mr36190874pgf.409.1554830681136;
        Tue, 09 Apr 2019 10:24:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s9sm17492543pfe.183.2019.04.09.10.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:40 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 21/23] watchdog: stpmic1_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue,  9 Apr 2019 10:23:59 -0700
Message-Id: <1554830641-9247-22-git-send-email-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/stpmic1_wdt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/stpmic1_wdt.c b/drivers/watchdog/stpmic1_wdt.c
index ad431d8ad95f..45d0c543466f 100644
--- a/drivers/watchdog/stpmic1_wdt.c
+++ b/drivers/watchdog/stpmic1_wdt.c
@@ -81,18 +81,19 @@ static const struct watchdog_ops pmic_watchdog_ops = {
 
 static int pmic_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	struct stpmic1 *pmic;
 	struct stpmic1_wdt *wdt;
 
-	if (!pdev->dev.parent)
+	if (!dev->parent)
 		return -EINVAL;
 
-	pmic = dev_get_drvdata(pdev->dev.parent);
+	pmic = dev_get_drvdata(dev->parent);
 	if (!pmic)
 		return -EINVAL;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(struct stpmic1_wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(struct stpmic1_wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -102,15 +103,15 @@ static int pmic_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.ops = &pmic_watchdog_ops;
 	wdt->wdtdev.min_timeout = PMIC_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = PMIC_WDT_MAX_TIMEOUT;
-	wdt->wdtdev.parent = &pdev->dev;
+	wdt->wdtdev.parent = dev;
 
 	wdt->wdtdev.timeout = PMIC_WDT_DEFAULT_TIMEOUT;
-	watchdog_init_timeout(&wdt->wdtdev, 0, &pdev->dev);
+	watchdog_init_timeout(&wdt->wdtdev, 0, dev);
 
 	watchdog_set_nowayout(&wdt->wdtdev, nowayout);
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 
-	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
+	ret = devm_watchdog_register_device(dev, &wdt->wdtdev);
 	if (ret)
 		return ret;
 
-- 
2.7.4

