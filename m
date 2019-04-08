Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3338C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8515221473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3tNEhM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfDHTk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35543 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbfDHTjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so7886505pgf.2;
        Mon, 08 Apr 2019 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q4IVqeF4eZZXzwVrhyw6JtwBOUJ05UVuGHVxZTEZZdU=;
        b=N3tNEhM4n5CfkxYTcyWJbYPcwVQRRdZLr2UhTXffPar0h9nfX6CfIxON0DdhDJVU52
         aFKqgKzMN21GkK+pYfVMGlNVkIT3By/9vKd9XtvDu8+wrNazmhcOBQ6rvvzxOJ7ODnvw
         W4qczJuODQwMRZme95bXyat9m+WnkhQ+2JetESXGSELDlpO1BsryR4tatwbSaiHos0g/
         LfpexKN9R4iU2ifWpf8IlmwpszQvWN+sXjpD69+pqGOSUQ8mX/KE0PpYBwZ/TPPIpz+3
         GdnyzDxZv55laIigHrUGrVkI0Vs+BnMsF6xPr5tBO2XtNTVEC6gX3/epECu7SXgpAEzS
         Vm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Q4IVqeF4eZZXzwVrhyw6JtwBOUJ05UVuGHVxZTEZZdU=;
        b=OF996+BJfKNfWF9VPXkKoh+12gV4vXPgrajF4zf18EnG/DmpejRG7soe158+4R6/Xq
         IYOGfPFn0yn8cBcVsLWvIuU/W22lxaq8GVZlaHbaEG+W8k0pNJDmO2XeYm4vzqt2ipP6
         cu2B+7DlwT+dN6QlwyFerReKNHqiXH3ESJrTytYDcDbZB98prsJy30RaPn/F7tIu6/nc
         Km7sevo99hS+Yx1g30c2uowuflCwCQ3Vz5Ggfc0GYJP6woMggOgLfxkm3sfwcvEY/Soa
         DC0C3Tm7IInOxhjjEVTCg+V0KHXDpQx8VIWkVgv6cNQ1yUrQ+a4hNgIn++pm2rd/5Wol
         RD1Q==
X-Gm-Message-State: APjAAAVxX2NgTiL7RKM9RACm9wiO7XC5su6GM9hjKC/MfQNHwHTqhy52
        jBlabIMtA4j2QTWmsQx814vRAAxC
X-Google-Smtp-Source: APXvYqwkn4qLegFXQdKoqO/f/kRIxwjxg2aiOghzxxTAxLFve2jRnPPAed5TyPnVcHpjf7fzBmY7vA==
X-Received: by 2002:a63:e004:: with SMTP id e4mr30532805pgh.344.1554752394183;
        Mon, 08 Apr 2019 12:39:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 20sm40639951pfn.131.2019.04.08.12.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:53 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 12/22] watchdog: da9063_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Mon,  8 Apr 2019 12:38:36 -0700
Message-Id: <1554752326-13319-13-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
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

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/da9063_wdt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 384dca16af8b..06eb9070203c 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -188,17 +188,18 @@ static const struct watchdog_ops da9063_watchdog_ops = {
 
 static int da9063_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct da9063 *da9063;
 	struct watchdog_device *wdd;
 
-	if (!pdev->dev.parent)
+	if (!dev->parent)
 		return -EINVAL;
 
-	da9063 = dev_get_drvdata(pdev->dev.parent);
+	da9063 = dev_get_drvdata(dev->parent);
 	if (!da9063)
 		return -EINVAL;
 
-	wdd = devm_kzalloc(&pdev->dev, sizeof(*wdd), GFP_KERNEL);
+	wdd = devm_kzalloc(dev, sizeof(*wdd), GFP_KERNEL);
 	if (!wdd)
 		return -ENOMEM;
 
@@ -208,7 +209,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	wdd->max_timeout = DA9063_WDT_MAX_TIMEOUT;
 	wdd->min_hw_heartbeat_ms = DA9063_RESET_PROTECTION_MS;
 	wdd->timeout = DA9063_WDG_TIMEOUT;
-	wdd->parent = &pdev->dev;
+	wdd->parent = dev;
 
 	wdd->status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
@@ -222,7 +223,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
-	return devm_watchdog_register_device(&pdev->dev, wdd);
+	return devm_watchdog_register_device(dev, wdd);
 }
 
 static struct platform_driver da9063_wdt_driver = {
-- 
2.7.4

