Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94C320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRMAKpMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfDHTkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37237 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbfDHTkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:40:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so8219146pfr.4;
        Mon, 08 Apr 2019 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CdCl5pjlsRcAsU57NrbNiVOKzAX3GmE0CFq2biJi1zk=;
        b=hRMAKpMYPT1uKmhMyNuWRvV87mWrm9EB2zy+sRzfgW1AHi4WQfSsk/vaIosAdDV6yo
         JzklwgPYwvelastFJHhc/t134mMFytkMwuMwqUOXIR/wHSkAbqn2JCbRMkmECZgQQ9ZL
         FEzqotbb/PKeNdOWf2s4pzCiC3Z3Z+QiGaKmdGP/DtFvL8URsXQeEemAhvUt20hCH4o0
         Gq01w67+WlMAetAshfzglfPTbcoumV7+pfxdHr/uPuqvDfqV0vf2aOdsXPUoMAiZgBNH
         L9+H45A1gCfh4g0uXuZfAG1mzMsgbUqi3yDL+Lh9/fr1zRbqhqjx5DEOOjs5AzREd51r
         7FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CdCl5pjlsRcAsU57NrbNiVOKzAX3GmE0CFq2biJi1zk=;
        b=laTINGspdGvT6JALRQh7/ObDHeJPum2cP69iHRzGxzzwbRtjHEPVFljEJd3kEJWXQc
         2mefJjR5An3A3dJgZnOtXShqDJumsMrEJb3FXGYhaEpnR7VFZpCsswPHLzsIOt/t6vII
         n0vCKB4Zq4WA4aZ2DhtTjOvh7vGKYcAUnQWOYqnlcPDAU8D64gQpEmL/w3xclbOJV+BP
         rBGKV0lYCR4ifrvBCUVvhRgwAWf9MqpMDL9E1NpcpgGm3W9/GoQwLnmEOOcESeEFk55P
         z3slTwJqPpL+D8EkGYx3O+iha7zdvhsolBw3cHiVKSfd1xtyCMXKjlx4R/oeVVvwAwFw
         tR7A==
X-Gm-Message-State: APjAAAXuFnnlr6IUNPpSzXFoJTQhT2hm+SMdyND8Z6mU+2b9VrIfeAn3
        gHbvGDeOO9Mq7mdKSDq2GXI=
X-Google-Smtp-Source: APXvYqzOSr1mvWulxUyZgVrCO0LW6xaXm+IYDobQ/PM0QMfMk5Rgeboy6YeQ7+MIiwtuZsssdhRkag==
X-Received: by 2002:aa7:8289:: with SMTP id s9mr31537977pfm.208.1554752405297;
        Mon, 08 Apr 2019 12:40:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4sm51663594pfh.146.2019.04.08.12.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:40:04 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 20/22] watchdog: kempld_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:44 -0700
Message-Id: <1554752326-13319-21-git-send-email-linux@roeck-us.net>
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
- Use local variable 'struct device *dev' consistently
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/kempld_wdt.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index e268add43010..543eb0f27a42 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -467,7 +467,7 @@ static int kempld_wdt_probe(struct platform_device *pdev)
 			KEMPLD_WDT_CFG_GLOBAL_LOCK)) {
 		if (!nowayout)
 			dev_warn(dev,
-				"Forcing nowayout - watchdog lock enabled!\n");
+				 "Forcing nowayout - watchdog lock enabled!\n");
 		nowayout = true;
 	}
 
@@ -492,7 +492,9 @@ static int kempld_wdt_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, wdt_data);
-	ret = watchdog_register_device(wdd);
+	watchdog_stop_on_reboot(wdd);
+	watchdog_stop_on_unregister(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
 		return ret;
 
@@ -501,26 +503,6 @@ static int kempld_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void kempld_wdt_shutdown(struct platform_device *pdev)
-{
-	struct kempld_wdt_data *wdt_data = platform_get_drvdata(pdev);
-
-	kempld_wdt_stop(&wdt_data->wdd);
-}
-
-static int kempld_wdt_remove(struct platform_device *pdev)
-{
-	struct kempld_wdt_data *wdt_data = platform_get_drvdata(pdev);
-	struct watchdog_device *wdd = &wdt_data->wdd;
-	int ret = 0;
-
-	if (!nowayout)
-		ret = kempld_wdt_stop(wdd);
-	watchdog_unregister_device(wdd);
-
-	return ret;
-}
-
 #ifdef CONFIG_PM
 /* Disable watchdog if it is active during suspend */
 static int kempld_wdt_suspend(struct platform_device *pdev,
@@ -567,8 +549,6 @@ static struct platform_driver kempld_wdt_driver = {
 		.name	= "kempld-wdt",
 	},
 	.probe		= kempld_wdt_probe,
-	.remove		= kempld_wdt_remove,
-	.shutdown	= kempld_wdt_shutdown,
 	.suspend	= kempld_wdt_suspend,
 	.resume		= kempld_wdt_resume,
 };
-- 
2.7.4

