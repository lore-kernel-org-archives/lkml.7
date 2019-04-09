Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C65C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1112133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWHcVwdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDIRYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42667 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfDIRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so9793447plb.9;
        Tue, 09 Apr 2019 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9wckhJHxSrM0tEjClZFzEqYk0LhohFKE4bYwFU5BfO8=;
        b=tWHcVwdh7iZ1KJO7SKn8rvrgz6u0RJtfuQplQLjcfaIn6q38WY9+yEiHJHK2+/1P0N
         LrNedCP0MrD93//XBBi+hxztvtQoftF/O1ys2ZfnhUpDlrG/7zEr210WmYlAc0BYfSit
         +pWOhIv4QwonUDkBPQcEqgeksbhfS+oLC9XoUhDEYI1AOvfGtXPARqN/HU9YFyS6SY+i
         Io1e8EfPZSorXyyAGR5jZGvVCb67rUIvrT2BtxM2pFImg+wZim20TDD9rLTZDr/3BYQD
         L/bPnTQAjMe4abtaFfakNdUEOr+V69CICGutJcPQUkWEyZpVKf5IHmDwcOd53mibYPdk
         U9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=9wckhJHxSrM0tEjClZFzEqYk0LhohFKE4bYwFU5BfO8=;
        b=bqIig1AYJD5dRM/pLQgB1jS4XsN7NKKEHXydpUpWDmVH/LPIUO/cRwFG8pJrR7bosn
         RSy+a6dTIpT22ojD5fOPo6oDCTIfIUy/zO3f/2c+297zrXsOsK9JQycVm8a6HGEpCqR4
         iQvEzznnoZN6XzZlRbIxaCyhvDiAGyuh7nrVqxRTR9pzxdgsE1ykyY5PU1EizDuDhCuf
         Oxq/8Oh9dAhYLGK1uUXCjTL+LCwMxi/Q9k8L2YZEqsO1fUjxFoCZm9PSpE4tHjODOeRa
         IpaOz3RpyJMDQALDxnFIXlxja/Mxr25CGAKk9eAGTNHeQrcJEnvDC4mxx0L4TYYLUsoh
         VuNw==
X-Gm-Message-State: APjAAAUVLuS30PhvcpXHIjcDVIBaITm+9CJWmrotdIPDypaUpPINOZiW
        UkTA4iv9PU8w4A8dWTdrHdU=
X-Google-Smtp-Source: APXvYqxyYJu5C86rFwHmRR0EQfBRSnBr8/PtrIui34ZVy03cV+Hq7lcCW3gHMHQ85Ji82FsfNJiQvg==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr38731835plb.171.1554830678364;
        Tue, 09 Apr 2019 10:24:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p26sm75177403pfa.49.2019.04.09.10.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:37 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 19/23] watchdog: st_lpc_wdt: Convert to use device managed functions
Date:   Tue,  9 Apr 2019 10:23:57 -0700
Message-Id: <1554830641-9247-20-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/st_lpc_wdt.c | 47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 196fb4b72c5d..9a5ed95c3403 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -142,10 +142,16 @@ static struct watchdog_device st_wdog_dev = {
 	.ops		= &st_wdog_ops,
 };
 
+static void st_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int st_wdog_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct st_wdog *st_wdog;
 	struct regmap *regmap;
 	struct clk *clk;
@@ -155,7 +161,7 @@ static int st_wdog_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
 	if (ret) {
-		dev_err(&pdev->dev, "An LPC mode must be provided\n");
+		dev_err(dev, "An LPC mode must be provided\n");
 		return -EINVAL;
 	}
 
@@ -163,13 +169,13 @@ static int st_wdog_probe(struct platform_device *pdev)
 	if (mode != ST_LPC_MODE_WDT)
 		return -ENODEV;
 
-	st_wdog = devm_kzalloc(&pdev->dev, sizeof(*st_wdog), GFP_KERNEL);
+	st_wdog = devm_kzalloc(dev, sizeof(*st_wdog), GFP_KERNEL);
 	if (!st_wdog)
 		return -ENOMEM;
 
-	match = of_match_device(st_wdog_match, &pdev->dev);
+	match = of_match_device(st_wdog_match, dev);
 	if (!match) {
-		dev_err(&pdev->dev, "Couldn't match device\n");
+		dev_err(dev, "Couldn't match device\n");
 		return -ENODEV;
 	}
 	st_wdog->syscfg	= (struct st_wdog_syscfg *)match->data;
@@ -180,17 +186,17 @@ static int st_wdog_probe(struct platform_device *pdev)
 
 	regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
 	if (IS_ERR(regmap)) {
-		dev_err(&pdev->dev, "No syscfg phandle specified\n");
+		dev_err(dev, "No syscfg phandle specified\n");
 		return PTR_ERR(regmap);
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Unable to request clock\n");
+		dev_err(dev, "Unable to request clock\n");
 		return PTR_ERR(clk);
 	}
 
-	st_wdog->dev		= &pdev->dev;
+	st_wdog->dev		= dev;
 	st_wdog->base		= base;
 	st_wdog->clk		= clk;
 	st_wdog->regmap		= regmap;
@@ -198,39 +204,40 @@ static int st_wdog_probe(struct platform_device *pdev)
 	st_wdog->clkrate	= clk_get_rate(st_wdog->clk);
 
 	if (!st_wdog->clkrate) {
-		dev_err(&pdev->dev, "Unable to fetch clock rate\n");
+		dev_err(dev, "Unable to fetch clock rate\n");
 		return -EINVAL;
 	}
 	st_wdog_dev.max_timeout = 0xFFFFFFFF / st_wdog->clkrate;
-	st_wdog_dev.parent = &pdev->dev;
+	st_wdog_dev.parent = dev;
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable clock\n");
+		dev_err(dev, "Unable to enable clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, st_clk_disable_unprepare, clk);
+	if (ret)
+		return ret;
 
 	watchdog_set_drvdata(&st_wdog_dev, st_wdog);
 	watchdog_set_nowayout(&st_wdog_dev, WATCHDOG_NOWAYOUT);
 
 	/* Init Watchdog timeout with value in DT */
-	ret = watchdog_init_timeout(&st_wdog_dev, 0, &pdev->dev);
+	ret = watchdog_init_timeout(&st_wdog_dev, 0, dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to initialise watchdog timeout\n");
-		clk_disable_unprepare(clk);
+		dev_err(dev, "Unable to initialise watchdog timeout\n");
 		return ret;
 	}
 
-	ret = watchdog_register_device(&st_wdog_dev);
+	ret = devm_watchdog_register_device(dev, &st_wdog_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to register watchdog\n");
-		clk_disable_unprepare(clk);
+		dev_err(dev, "Unable to register watchdog\n");
 		return ret;
 	}
 
 	st_wdog_setup(st_wdog, true);
 
-	dev_info(&pdev->dev, "LPC Watchdog driver registered, reset type is %s",
+	dev_info(dev, "LPC Watchdog driver registered, reset type is %s",
 		 st_wdog->warm_reset ? "warm" : "cold");
 
 	return ret;
@@ -241,8 +248,6 @@ static int st_wdog_remove(struct platform_device *pdev)
 	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
 
 	st_wdog_setup(st_wdog, false);
-	watchdog_unregister_device(&st_wdog_dev);
-	clk_disable_unprepare(st_wdog->clk);
 
 	return 0;
 }
-- 
2.7.4

