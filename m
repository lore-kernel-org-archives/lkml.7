Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F3DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F72720854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHV49RXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfDJQ3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:29:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43129 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387888AbfDJQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so1848328pgu.10;
        Wed, 10 Apr 2019 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ni05DFO6BTYbaFzG8C2LxYO4iAiA1+2nom8reemvhW0=;
        b=BHV49RXlJ+LnAtzJUDLJPBhI6oftKO6ggo/tYg0beVFFgGFAW16TVzGY40c/oJEEgk
         vNeuc8lzC9LA6gxb/yJVVXncXZIxI7+g8OfLcSTJX1UGp8Gm8ezKtli/pWus7gxFUPOn
         zbVrFOxv1EOooPOAP9RvsHipose3la9DuBlPhJ9Qxbr6wAiTufnE8mi8c2Eu8bH7JEKg
         xveVNLFEoxWiWTSUncEbE9fs1UGE1htExMsX9EBKONdSnzezcgLVcYDlzxFb1/IkDOCP
         LgllhIPyUALWJMClljI4d68Xhq7A8rl5EX0YcBCe+DObGvQx91zzXvJK6O4vlyeZtu8+
         5yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ni05DFO6BTYbaFzG8C2LxYO4iAiA1+2nom8reemvhW0=;
        b=K7bPFDxEU0lWI9pWT28aqe9A1IaBsQk8NgikJnPq5xDhYCaFwcarZKw1EZkorWqnK3
         hk9MDK9nffxe13iYduw+r6ZEvxUkFG8RcL5Fh7dYvIkfX6u/1SoRu5LwMdQO2aGc5yGC
         UvESxwWK+sSorQELtsV3O/bMcw/tj6Tt2S16y5ofPueNls7DBR3c5fevNrF+nN2sSQfY
         cuH6bAW7K0rTcfUquKM7psQN4h7xdlrTfpyl30ol7sgfFuI7aB1hB23Nm5yFlQKgH728
         Yls9f+0Nwy8wTfWTiWeuOJIxXSrZMUiT97+NJKUCku0Ja08DOZDnGkZYzLws65K0mJPk
         AFzw==
X-Gm-Message-State: APjAAAVxGGtXj6DP2z43zeDnyOsHvrkgadXSsEjT8/c8kS122SxI3LWp
        mn0cDL/sWtYwyDFGn+mE+Sg=
X-Google-Smtp-Source: APXvYqzlUuzCp8ECHII9y6rvtUAlfUbEEsdz7C4EwgFLGvJZb0uDu69XYrk8PoDaikhoTPD1w9Rq2A==
X-Received: by 2002:aa7:943b:: with SMTP id y27mr20615184pfo.59.1554913707408;
        Wed, 10 Apr 2019 09:28:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m23sm54815037pfa.117.2019.04.10.09.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:26 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 14/22] watchdog: ux500_wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:55 -0700
Message-Id: <1554913683-25454-15-git-send-email-linux@roeck-us.net>
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

- Drop empty remove function
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ux500_wdt.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index 37c084353cce..9fa7f95f7554 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -86,8 +86,9 @@ static struct watchdog_device ux500_wdt = {
 
 static int ux500_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
-	struct ux500_wdt_data *pdata = dev_get_platdata(&pdev->dev);
+	struct ux500_wdt_data *pdata = dev_get_platdata(dev);
 
 	if (pdata) {
 		if (pdata->timeout > 0)
@@ -96,7 +97,7 @@ static int ux500_wdt_probe(struct platform_device *pdev)
 			ux500_wdt.max_timeout = WATCHDOG_MAX28;
 	}
 
-	ux500_wdt.parent = &pdev->dev;
+	ux500_wdt.parent = dev;
 	watchdog_set_nowayout(&ux500_wdt, nowayout);
 
 	/* disable auto off on sleep */
@@ -105,18 +106,11 @@ static int ux500_wdt_probe(struct platform_device *pdev)
 	/* set HW initial value */
 	prcmu_load_a9wdog(PRCMU_WDOG_ALL, timeout * 1000);
 
-	ret = watchdog_register_device(&ux500_wdt);
+	ret = devm_watchdog_register_device(dev, &ux500_wdt);
 	if (ret)
 		return ret;
 
-	dev_info(&pdev->dev, "initialized\n");
-
-	return 0;
-}
-
-static int ux500_wdt_remove(struct platform_device *dev)
-{
-	watchdog_unregister_device(&ux500_wdt);
+	dev_info(dev, "initialized\n");
 
 	return 0;
 }
@@ -153,7 +147,6 @@ static int ux500_wdt_resume(struct platform_device *pdev)
 
 static struct platform_driver ux500_wdt_driver = {
 	.probe		= ux500_wdt_probe,
-	.remove		= ux500_wdt_remove,
 	.suspend	= ux500_wdt_suspend,
 	.resume		= ux500_wdt_resume,
 	.driver		= {
-- 
2.7.4

