Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C84A20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV2EbIcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfDIRYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41317 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfDIRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so10101963pfd.8;
        Tue, 09 Apr 2019 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wD2DSazscH8pXYOvV/UE8CSsvEV5LX5/5sBBOGKP7p8=;
        b=eV2EbIcXbFp6kSeKeMNvf5UqnqRATv1xl1WZ+nYPml+zy6bcX/dFqOoeXypThBKXpI
         Lf1dEWoGHeHrQanv3ZMbUbvQiaDOx9yRszWjxb/3qyadSGi+0kysQFgNSIBl5ZIHPoJk
         m85t125W/rODREVLJW8JeKQNjJ2P2EmyibFTOWEpiUmZp6FgQvqlQ/ltXJybYKalw5kb
         iFnfw2dEQezAwcjwCYyxKtTmHSx2hPRWixPTu3xGLEVWPuf4cEcnK24sLp1rUaX+0R+j
         HDE7DEYoO9MjGADWk0M7EIV8tpPj3UECDpJlJL/24LJGCo0nGHrs8pEgBdHSZRuOZ/Jt
         IpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=wD2DSazscH8pXYOvV/UE8CSsvEV5LX5/5sBBOGKP7p8=;
        b=FyrNeUyEbxeh+EN/GzMgOdhPNp33PKfL4vBv980gsObHKWdx6yxm0dKakFv4dX3k4G
         QSogSJzsd+GAnjE2RTbIUdq/rCAbn14JHwXRBp02iZQ4Uh36KvEjYLjj9RtbZKVNxmV8
         aLJD/PtVtnUfLTXArLYHzil95U+6Pwxtd+Erp4hSMl9qp5glSyexEQ6zXbu4k6zGhGSK
         sL86BjBVfTnSNJ+UFFIGh8cyraMoK6cyXbn3haw4+wXakfRQe2xakS32XIqcxYfJsdQW
         Bkq8n7KtHYDMwqb2wLTJ2VQgGkW3udk13SPEgBS87qBLSObGdTptIs9nQych1wcufsYR
         mwvw==
X-Gm-Message-State: APjAAAXxYoqQ+zlgpNsQQRV9PMFJ3akzk1fPXC4ulO86X8uIKh4DbUx/
        nYta2VkjcDcwo4iLFacUuy+e/S0K
X-Google-Smtp-Source: APXvYqxX7yq7oeJCIHOJZAA6eu5MS+m+Z8J0sAWhG5A7iGuMBYVg8Q46PO4tCBnuFW2fSL6aOmJKGQ==
X-Received: by 2002:a65:5286:: with SMTP id y6mr35447051pgp.79.1554830675591;
        Tue, 09 Apr 2019 10:24:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v43sm25926590pgn.57.2019.04.09.10.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:35 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 17/23] watchdog: sirfsoc_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:55 -0700
Message-Id: <1554830641-9247-18-git-send-email-linux@roeck-us.net>
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

- Drop empty remove function
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Replace shutdown function with call to watchdog_stop_on_reboot()
- Replace stop on remove with call to watchdog_stop_on_unregister()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sirfsoc_wdt.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 2559062d35da..e79a4097d50b 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -146,6 +146,7 @@ static struct watchdog_device sirfsoc_wdd = {
 
 static int sirfsoc_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	void __iomem *base;
 
@@ -155,11 +156,13 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&sirfsoc_wdd, (__force void *)base);
 
-	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
+	watchdog_init_timeout(&sirfsoc_wdd, timeout, dev);
 	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
-	sirfsoc_wdd.parent = &pdev->dev;
+	sirfsoc_wdd.parent = dev;
 
-	ret = watchdog_register_device(&sirfsoc_wdd);
+	watchdog_stop_on_reboot(&sirfsoc_wdd);
+	watchdog_stop_on_unregister(&sirfsoc_wdd);
+	ret = devm_watchdog_register_device(dev, &sirfsoc_wdd);
 	if (ret)
 		return ret;
 
@@ -168,19 +171,6 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void sirfsoc_wdt_shutdown(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-
-	sirfsoc_wdt_disable(wdd);
-}
-
-static int sirfsoc_wdt_remove(struct platform_device *pdev)
-{
-	sirfsoc_wdt_shutdown(pdev);
-	return 0;
-}
-
 #ifdef	CONFIG_PM_SLEEP
 static int sirfsoc_wdt_suspend(struct device *dev)
 {
@@ -218,8 +208,6 @@ static struct platform_driver sirfsoc_wdt_driver = {
 		.of_match_table	= sirfsoc_wdt_of_match,
 	},
 	.probe = sirfsoc_wdt_probe,
-	.remove = sirfsoc_wdt_remove,
-	.shutdown = sirfsoc_wdt_shutdown,
 };
 module_platform_driver(sirfsoc_wdt_driver);
 
-- 
2.7.4

