Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BCC206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9f3lkU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbfDJQ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:29:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36479 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbfDJQ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so1871047pgc.3;
        Wed, 10 Apr 2019 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c2FEfcVttbNCfJqC2hCYAaLdDZL89jf2XIDcZsihWPM=;
        b=g9f3lkU59N+uE6DpaaWLGIA9SIwrj/sxem3hLSydb3IiDmVVSRGek+LpNi6HaTHHfa
         YNXJ3wf6mSvZ3dHxOq+0l+3bwcfIq22573tm/HCmJdaMut3qd8+36xPFxfsmh5HM+Rbq
         Zes9fQiADEN7VWibEgfNUOhgOndNtJrHVlEcY8HD+dO/QUWt4FdlRy2Jj1EBwwZJUMtE
         IONQ6aYXp1BHl+w1sAfkTnbMcNwEH9EoiLgTvqBN3xWJAOgKZc1OFupvskd6/WmFfjLu
         MYiiS/YFwdddgGU6o/s0pCaDRT6Y3h/bFtx9TDw6JcJ5ljZiSTmoRdAjaDixNnvzDUBA
         zu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=c2FEfcVttbNCfJqC2hCYAaLdDZL89jf2XIDcZsihWPM=;
        b=CMt10TDLNlPy4WgXJSfha4hpaSNdtlbG5y1o0B/MySQdtgP689g2QL3w31jdDQye2H
         Hf4MQLiRJ40959ozCVXg0kqpNbqA3LN9wqsplEG7iwVPVbEvqNF9gv25Rf40LLiBmBzH
         s7ZFOyJg/bCH9MFoR3Qz3sEilz6FFm9ty3yUFWNWULut7Gcd+atSNDWLlk2aECjKsYbt
         64Idha75rTaIOtW/U+18LGoZjbS+TVjMd2C2Dk2kOjgTcKOoxhFdGtXt03brSBlD//y3
         3FxYk6gE5ueWa2C1YcvIj/TzdOCZ+dFxiIH2RyNZti2KM24T6UmpkQDeLPnhfHX6bf6g
         KE7w==
X-Gm-Message-State: APjAAAXiPMQwsFGpmunEfi7OFbicf1O1diofVoGwyVBx/s6dixWEuROT
        mCIobN7ZauxyScxHM5asNxI=
X-Google-Smtp-Source: APXvYqwH07qiZMrOhchAQWnu9rp9fNTxesBTNLq5dtBo21Ev7zC+mNkO08CKanU5OvYbisK5ESC8Rw==
X-Received: by 2002:a62:1d0d:: with SMTP id d13mr44593907pfd.96.1554913704771;
        Wed, 10 Apr 2019 09:28:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1sm68511373pgc.63.2019.04.10.09.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:24 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 12/22] watchdog: zx2967_wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:27:53 -0700
Message-Id: <1554913683-25454-13-git-send-email-linux@roeck-us.net>
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
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use local variable 'struct device *dev' consistently
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/zx2967_wdt.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
index 9ccc83f526f3..c8549bf07cc9 100644
--- a/drivers/watchdog/zx2967_wdt.c
+++ b/drivers/watchdog/zx2967_wdt.c
@@ -188,6 +188,11 @@ static void zx2967_wdt_reset_sysctrl(struct device *dev)
 	of_node_put(out_args.np);
 }
 
+static void zx2967_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int zx2967_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -206,7 +211,7 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
 	wdt->wdt_device.timeout = ZX2967_WDT_DEFAULT_TIMEOUT;
 	wdt->wdt_device.max_timeout = ZX2967_WDT_MAX_TIMEOUT;
 	wdt->wdt_device.min_timeout = ZX2967_WDT_MIN_TIMEOUT;
-	wdt->wdt_device.parent = &pdev->dev;
+	wdt->wdt_device.parent = dev;
 
 	wdt->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->reg_base))
@@ -225,13 +230,16 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to enable clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, zx2967_clk_disable_unprepare,
+				       wdt->clock);
+	if (ret)
+		return ret;
 	clk_set_rate(wdt->clock, ZX2967_WDT_CLK_FREQ);
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rstc)) {
 		dev_err(dev, "failed to get rstc");
-		ret = PTR_ERR(rstc);
-		goto err;
+		return PTR_ERR(rstc);
 	}
 
 	reset_control_assert(rstc);
@@ -242,28 +250,14 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
 			ZX2967_WDT_DEFAULT_TIMEOUT, dev);
 	watchdog_set_nowayout(&wdt->wdt_device, WATCHDOG_NOWAYOUT);
 
-	ret = watchdog_register_device(&wdt->wdt_device);
+	ret = devm_watchdog_register_device(dev, &wdt->wdt_device);
 	if (ret)
-		goto err;
+		return ret;
 
 	dev_info(dev, "watchdog enabled (timeout=%d sec, nowayout=%d)",
 		 wdt->wdt_device.timeout, WATCHDOG_NOWAYOUT);
 
 	return 0;
-
-err:
-	clk_disable_unprepare(wdt->clock);
-	return ret;
-}
-
-static int zx2967_wdt_remove(struct platform_device *pdev)
-{
-	struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&wdt->wdt_device);
-	clk_disable_unprepare(wdt->clock);
-
-	return 0;
 }
 
 static const struct of_device_id zx2967_wdt_match[] = {
@@ -274,7 +268,6 @@ MODULE_DEVICE_TABLE(of, zx2967_wdt_match);
 
 static struct platform_driver zx2967_wdt_driver = {
 	.probe		= zx2967_wdt_probe,
-	.remove		= zx2967_wdt_remove,
 	.driver		= {
 		.name	= "zx2967-wdt",
 		.of_match_table	= of_match_ptr(zx2967_wdt_match),
-- 
2.7.4

