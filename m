Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6DBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FA2206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMQnMd0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfDJQ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:29:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42694 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbfDJQ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so1733478plb.9;
        Wed, 10 Apr 2019 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A8S7XSTI64ZGz7QExfklYyYSF03nx6KnqMOGBDym5s0=;
        b=JMQnMd0jgU/sfz3TH4kN8lc9efu1s4ojoJzK+hZapgzO2uNoLa5R5REyfo4/pbWIqo
         3Bg98SiLvffA66jqYCDMEU5aLqPfWWYqgEQ2uiIzXVk0LDYLG08dm0L9arn3fGFtrnlb
         jIxov/WJdunwemW/Vh17ayT8aXISK7Ama6IzcmKK0Jz8J7Y4009uFj7/5xm/5C+EBAr3
         5xf2o9fhpMbVlEbIwZxP0WM+fh0kIlC7m0EClSDHEqSOk6RJSqOmWZ0/syjq2gNPrmsD
         uay8TT93oUnfBH6xccDFckp/yDHZAS8qT1DMEfvwRBu6YSvlRC9HZ7gxxI+BVKmyb6IS
         GUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=A8S7XSTI64ZGz7QExfklYyYSF03nx6KnqMOGBDym5s0=;
        b=CJzMOYwRK6pnr7+5UDvUbMEbROY+1rq/5oBNvVaw71ewamMcoX6okaqtwmkjiolQ2N
         x/QG17FZOPC156PS6gPnIbQEU5XbqoIKOul5czgFXOMAtIrGmTVNuZ7k/Iq3Jmdx7qXp
         lgCwHT7Xm31CiKSyGjbLKQK6T7yamH3Uj/dBcRlUsylz1NYzwjw4x/vi2jeUyfO2f0Zx
         feyIEpEsBWZPch+qfxPDqrQZSW7mEP9bOEnWrnbq7yldb8lXi8OKWu6LYz1SlReKzxWI
         K2DKTTc/g6qdhPuqWMg2tj+00FClnqzA7RD4DBWvTRlsVt3Wlvvh6YhfQrQshE3On1x3
         Ef9g==
X-Gm-Message-State: APjAAAWUKRAabe9crOMZDETJo9p6FPyybNRDz96gfIE+ztRG8T2Fgvha
        sDTWrBHQXYi29ePGvTZAsoY=
X-Google-Smtp-Source: APXvYqxepkhR3FUPAhTEmfCpxVe8OwgJcM7oSnH0Oe6TpcQFP43WDl7lBVa05nAGT0iGXFtvYsEB3g==
X-Received: by 2002:a17:902:da4:: with SMTP id 33mr13142734plv.20.1554913703373;
        Wed, 10 Apr 2019 09:28:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f71sm51876276pfc.109.2019.04.10.09.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:22 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 11/22] watchdog: sbsa_gwdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:52 -0700
Message-Id: <1554913683-25454-12-git-send-email-linux@roeck-us.net>
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
- Use local variable 'struct device *dev' consistently
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sbsa_gwdt.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 68aff828bf7e..e17af8939c93 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -310,7 +310,8 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	 */
 	sbsa_gwdt_set_timeout(wdd, wdd->timeout);
 
-	ret = watchdog_register_device(wdd);
+	watchdog_stop_on_reboot(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
 		return ret;
 
@@ -321,22 +322,6 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void sbsa_gwdt_shutdown(struct platform_device *pdev)
-{
-	struct sbsa_gwdt *gwdt = platform_get_drvdata(pdev);
-
-	sbsa_gwdt_stop(&gwdt->wdd);
-}
-
-static int sbsa_gwdt_remove(struct platform_device *pdev)
-{
-	struct sbsa_gwdt *gwdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&gwdt->wdd);
-
-	return 0;
-}
-
 /* Disable watchdog if it is active during suspend */
 static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
 {
@@ -382,8 +367,6 @@ static struct platform_driver sbsa_gwdt_driver = {
 		.of_match_table = sbsa_gwdt_of_match,
 	},
 	.probe = sbsa_gwdt_probe,
-	.remove = sbsa_gwdt_remove,
-	.shutdown = sbsa_gwdt_shutdown,
 	.id_table = sbsa_gwdt_pdev_match,
 };
 
-- 
2.7.4

