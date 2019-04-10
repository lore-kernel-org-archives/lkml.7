Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C6CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5D620854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISHxPmh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfDJQ2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45133 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbfDJQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so1771512pfi.12;
        Wed, 10 Apr 2019 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+GV2SyW/bymaq3EbCzp8kJz5OheCRJsZsCuHkP6+Lk=;
        b=ISHxPmh/QzYSLGOp8LuhzL0Q0EsIY4ErgK3l+3cba+3f3CEaJwG4iHjOK0/repCk0b
         5Oit5uj3K794/pmOG2WUaD/V1bDX53o+ubC6iTdb9Lx9onWnauMQOcohmApbA0/1qjY1
         4xR7ptT04em1XUqskBFxclM/as0blmWjnyITWBghy6AY70GyN2x+TGQ10RlYwWyFr99A
         cG/C2GPrRdIf3rC8ul0hqfx2s5MVE8A8eMJsAsMVzzHTPBUWhZ/HvpNlM+f25Y43GABt
         ZyCDtcRsQoJC+lOuE++XNLzdjsd2nUVEaWGMSnE+c03ZB9BhCDnYgqJkQEHL55de9MXc
         scaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=S+GV2SyW/bymaq3EbCzp8kJz5OheCRJsZsCuHkP6+Lk=;
        b=RkwzFlXdkjzU5PelndMyRdnzY3qi0P85nbaOvp1qOZEJDjl/ui7mc9p4RCv9+iOkyL
         3aUo55GjiG7CQGfntWM7brC4KmqxHHfGyGX7jSdA5gSnTZxZBS9vTM3lDTUA17jHzrDN
         9IUaZkh/v/XR4cZnGTtUKDFl7RwACOBFb0PC01UaZ+oQbKbc3wVKi8o4CEsI+3R5ShdO
         NrvPjOpMei6I8EBKwviGda4ghaZ0n/EEzFh7Yqs5oqdfk2FHEjy2GCgXJ3GxRZPMgkem
         OxYN4hFWjvREslJExKSgnE1LKTI3SFVBCi1fRTrqbRqOY/+1se7iVbhqKkO62kocVPkO
         EYVw==
X-Gm-Message-State: APjAAAXIrk1k9cFjpUb5xd74qevECXTU3ycvkpt378UnWLHUSXaVCJLY
        joxbHcYunthcvmndsepVHeQ=
X-Google-Smtp-Source: APXvYqySBxJ14wgGhdZPcHzxBvmFCjH9W7qm+4v/DcXfzLmrOGyaIFieUZx64NrDk2tBWg3s/ipJ/Q==
X-Received: by 2002:a63:5b4b:: with SMTP id l11mr12611446pgm.95.1554913718420;
        Wed, 10 Apr 2019 09:28:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f71sm51877312pfc.109.2019.04.10.09.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:37 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: [PATCH 22/22] watchdog: pnx4008_wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:28:03 -0700
Message-Id: <1554913683-25454-23-git-send-email-linux@roeck-us.net>
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
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/pnx4008_wdt.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 24c266a9e1dc..f94d844e596c 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -183,52 +183,49 @@ static struct watchdog_device pnx4008_wdd = {
 	.max_timeout = MAX_HEARTBEAT,
 };
 
+static void pnx4008_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int pnx4008_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret = 0;
 
-	watchdog_init_timeout(&pnx4008_wdd, heartbeat, &pdev->dev);
+	watchdog_init_timeout(&pnx4008_wdd, heartbeat, dev);
 
 	wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt_base))
 		return PTR_ERR(wdt_base);
 
-	wdt_clk = devm_clk_get(&pdev->dev, NULL);
+	wdt_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
 
 	ret = clk_prepare_enable(wdt_clk);
 	if (ret)
 		return ret;
+	ret = devm_add_action_or_reset(dev, pnx4008_clk_disable_unprepare,
+				       wdt_clk);
+	if (ret)
+		return ret;
 
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
-	pnx4008_wdd.parent = &pdev->dev;
+	pnx4008_wdd.parent = dev;
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
 	watchdog_set_restart_priority(&pnx4008_wdd, 128);
 
 	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
 
-	ret = watchdog_register_device(&pnx4008_wdd);
+	ret = devm_watchdog_register_device(dev, &pnx4008_wdd);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot register watchdog device\n");
-		goto disable_clk;
+		dev_err(dev, "cannot register watchdog device\n");
+		return ret;
 	}
 
-	dev_info(&pdev->dev, "heartbeat %d sec\n", pnx4008_wdd.timeout);
-
-	return 0;
-
-disable_clk:
-	clk_disable_unprepare(wdt_clk);
-	return ret;
-}
-
-static int pnx4008_wdt_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&pnx4008_wdd);
-
-	clk_disable_unprepare(wdt_clk);
+	dev_info(dev, "heartbeat %d sec\n", pnx4008_wdd.timeout);
 
 	return 0;
 }
@@ -247,7 +244,6 @@ static struct platform_driver platform_wdt_driver = {
 		.of_match_table = of_match_ptr(pnx4008_wdt_match),
 	},
 	.probe = pnx4008_wdt_probe,
-	.remove = pnx4008_wdt_remove,
 };
 
 module_platform_driver(platform_wdt_driver);
-- 
2.7.4

