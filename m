Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D2520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+F8vW7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDHTkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35064 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfDHTj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so5899982pfh.2;
        Mon, 08 Apr 2019 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pw3HtNip1IHtP8y+sCxbjAno2YKsFoKwmHCwnLCGi7I=;
        b=C+F8vW7sqTWrE02DXh+S4hq4pT+Ec/222R8DUTuIyEO31DZgRWsAZqRldj9e1OfK0K
         Vmwan4KIvDy0tRGLW0L0mk17nv0VoF5v+x/k2Q89fP7YnpFiv8nH+qsqGhJn85hnWkSr
         32QXR/xXfiZHtgcgOsoYHJchiazQfQ0JIl4hazWWkKFuYCyHxvMhSbVJD/bT2M710bBs
         q83kiy3P0tf3LsCx84IqC5374Z/HiGBljpFGiSJ82hUwsgbL+k7H0pZ6GYhKYIKUryaY
         CrozDomweZYBhdMd5i9z84OCvtOLnBG5NgwvZCEyeiuxvJ+m94XBenOWpYvegNqsckTG
         dO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=pw3HtNip1IHtP8y+sCxbjAno2YKsFoKwmHCwnLCGi7I=;
        b=PeP2kAiHrJJ4JIejnDFy1xXXukK9lmN3BtkYfy9pnHP/fwUQBBzQWdyMuYaq8cIAD2
         ybx5qZH9YOXejAhfa9r4/80fzVllNIu/Lv3RKLh3x5kz4tIKvuoRtjq4ygT6aPYHmX7c
         LPg5zMv+8wLURGMSthZcFjk2quVcZ4J/RX4NH53vOzQhR+dCsmshp/C20UlJVRxeEJxA
         VgrI5Gj6g2M57UxbuDs+tmBasfq5M3xGQZtJxkwOnqITIlZb2jnQqYiIxBXloOuo2rsX
         QXJ4dtXGbna75oDZ3Ncwul81rFUdeDAIlmEtG91qeB838iviE8MxGJ3A6kmDUe4J17gP
         FUXg==
X-Gm-Message-State: APjAAAUGzVfEa58bWAH8dM9xnLPleNQZEGG5AH+CQ6voHTOE0xS3vopV
        cxB9ETQMLrRw1hn2vRMhJys=
X-Google-Smtp-Source: APXvYqxjtF8jnrnSnuBJi/TnsZseD4NxSwoPwmGlQKxBuhtw5SPJJBOnqJDwSYwYZzvSTLQdGBfiAQ==
X-Received: by 2002:aa7:90ca:: with SMTP id k10mr31884363pfk.144.1554752395493;
        Mon, 08 Apr 2019 12:39:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9sm25315182pfc.43.2019.04.08.12.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:55 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 13/22] watchdog: davinci_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:37 -0700
Message-Id: <1554752326-13319-14-git-send-email-linux@roeck-us.net>
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
- Drop unnecessary braces around conditional return statements
- Drop empty remove function
- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use local variable 'struct device *dev' consistently
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/davinci_wdt.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 7daa15df74a5..7b2ee35b5ffd 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -191,6 +191,11 @@ static const struct watchdog_ops davinci_wdt_ops = {
 	.restart	= davinci_wdt_restart,
 };
 
+static void davinci_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int davinci_wdt_probe(struct platform_device *pdev)
 {
 	int ret = 0;
@@ -206,15 +211,19 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 
 	if (IS_ERR(davinci_wdt->clk)) {
 		if (PTR_ERR(davinci_wdt->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get clock node\n");
+			dev_err(dev, "failed to get clock node\n");
 		return PTR_ERR(davinci_wdt->clk);
 	}
 
 	ret = clk_prepare_enable(davinci_wdt->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to prepare clock\n");
+		dev_err(dev, "failed to prepare clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, davinci_clk_disable_unprepare,
+				       davinci_wdt->clk);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, davinci_wdt);
 
@@ -224,7 +233,7 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout	= 1;
 	wdd->max_timeout	= MAX_HEARTBEAT;
 	wdd->timeout		= DEFAULT_HEARTBEAT;
-	wdd->parent		= &pdev->dev;
+	wdd->parent		= dev;
 
 	watchdog_init_timeout(wdd, heartbeat, dev);
 
@@ -235,33 +244,16 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	watchdog_set_restart_priority(wdd, 128);
 
 	davinci_wdt->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(davinci_wdt->base)) {
-		ret = PTR_ERR(davinci_wdt->base);
-		goto err_clk_disable;
-	}
+	if (IS_ERR(davinci_wdt->base))
+		return PTR_ERR(davinci_wdt->base);
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret) {
 		dev_err(dev, "cannot register watchdog device\n");
-		goto err_clk_disable;
+		return ret;
 	}
 
 	return 0;
-
-err_clk_disable:
-	clk_disable_unprepare(davinci_wdt->clk);
-
-	return ret;
-}
-
-static int davinci_wdt_remove(struct platform_device *pdev)
-{
-	struct davinci_wdt_device *davinci_wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&davinci_wdt->wdd);
-	clk_disable_unprepare(davinci_wdt->clk);
-
-	return 0;
 }
 
 static const struct of_device_id davinci_wdt_of_match[] = {
@@ -276,7 +268,6 @@ static struct platform_driver platform_wdt_driver = {
 		.of_match_table = davinci_wdt_of_match,
 	},
 	.probe = davinci_wdt_probe,
-	.remove = davinci_wdt_remove,
 };
 
 module_platform_driver(platform_wdt_driver);
-- 
2.7.4

