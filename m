Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47351C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1457D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4LymmXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfDHTlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:41:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45907 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfDHTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so7891432plb.12;
        Mon, 08 Apr 2019 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jneh01n1+bIhANgepGSuhAjCJdMw/IuW338uETIBMa8=;
        b=N4LymmXzj+cfs0sFJ+tcmMXo15eMUNCQAdAfR9ZvQAhNz4WWzE710lnjAVplzdAI4s
         p5jDuXvGl1WWIir/esDEUMoPPMuNsMYtiFb28JPdnafAjnzUvUKIDDJRDyqk0w8cGKdH
         kQCy4HMEehk2AUZ2e855/wyxXcoCuVn/JBDOsYWJFeIxHAOAktKtTnXWrMNHzFnIE1hU
         83fdAV7ppxUkO9NL1uOtw2I/q0WIoyMIX+T3UZlmA2DVrkHMFQTQ1lrp6YwK8xV0Txu7
         EszVtobE1bTijON+tgeCvvbrXy7E2+C2Sf+cR9JsRDJg3MkUYcJdx8xCVVVDgcprv7IK
         hiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Jneh01n1+bIhANgepGSuhAjCJdMw/IuW338uETIBMa8=;
        b=Gadin6sJxlMRblGuf5JfJWc/THNE2uWJUwUrHZUu6sfphmcvAVXi+soWU6ZUART7jW
         yFcG6VHGhhqanjG/x+sHoblvpqQzKugxO3C20wZTYtl/I5L1WGDSFDvj+tboPpRsT7Wo
         gsH5Efk3uO3pZaBavmiTq8MNMjjqSBmxflNYbNeY4+8HbugF4ewdGmEEDYArRlV843VQ
         fRrORCIpizNKCO73p1icZO/4huH/KnlhaX2RQF2hLrkwEiZ8Pf1M+LQIzlJ/YZKQncE3
         EgdCwTAqTsuiuMB02iyg4KrXF8sgg8RSvc0jOlUHbkZ3HB0QQKFEIdMU3MDmSbkQ33/B
         dVpg==
X-Gm-Message-State: APjAAAVgeYe+d3u9RrVKNDOAqw2Xk1cmrIJO/hYf1enoaKNSubaP/qnM
        a0Yb6yZ5HWgKbhrYnpe+QYU=
X-Google-Smtp-Source: APXvYqy41qvPRPhPSOP1qoziMgnoeg/x0mdw6RZnOZQCJ29M+Oekz5gsa6+YkF2v1pxhpJIkjPvINw==
X-Received: by 2002:a17:902:4101:: with SMTP id e1mr31119676pld.25.1554752382864;
        Mon, 08 Apr 2019 12:39:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2sm36481508pfo.150.2019.04.08.12.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:42 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/22] watchdog: atlas7_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:28 -0700
Message-Id: <1554752326-13319-5-git-send-email-linux@roeck-us.net>
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
- Replace 'of_clk_get(np, 0)' with 'devm_clk_get(dev, NULL)'
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/atlas7_wdt.c | 61 ++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
index e170933aa0a8..79337d2a8a8e 100644
--- a/drivers/watchdog/atlas7_wdt.c
+++ b/drivers/watchdog/atlas7_wdt.c
@@ -125,78 +125,57 @@ static const struct of_device_id atlas7_wdt_ids[] = {
 	{}
 };
 
+static void atlas7_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int atlas7_wdt_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct atlas7_wdog *wdt;
 	struct clk *clk;
 	int ret;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 	wdt->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	clk = of_clk_get(np, 0);
+	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "clk enable failed\n");
-		goto err;
+		dev_err(dev, "clk enable failed\n");
+		return ret;
 	}
+	ret = devm_add_action_or_reset(dev, atlas7_clk_disable_unprepare, clk);
+	if (ret)
+		return ret;
 
 	/* disable watchdog hardware */
 	writel(0, wdt->base + ATLAS7_WDT_CNT_CTRL);
 
 	wdt->tick_rate = clk_get_rate(clk);
-	if (!wdt->tick_rate) {
-		ret = -EINVAL;
-		goto err1;
-	}
+	if (!wdt->tick_rate)
+		return -EINVAL;
 
 	wdt->clk = clk;
 	atlas7_wdd.min_timeout = 1;
 	atlas7_wdd.max_timeout = UINT_MAX / wdt->tick_rate;
 
-	watchdog_init_timeout(&atlas7_wdd, 0, &pdev->dev);
+	watchdog_init_timeout(&atlas7_wdd, 0, dev);
 	watchdog_set_nowayout(&atlas7_wdd, nowayout);
 
 	watchdog_set_drvdata(&atlas7_wdd, wdt);
 	platform_set_drvdata(pdev, &atlas7_wdd);
 
-	ret = watchdog_register_device(&atlas7_wdd);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	clk_disable_unprepare(clk);
-err:
-	clk_put(clk);
-	return ret;
-}
-
-static void atlas7_wdt_shutdown(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
-
-	atlas7_wdt_disable(wdd);
-	clk_disable_unprepare(wdt->clk);
-}
-
-static int atlas7_wdt_remove(struct platform_device *pdev)
-{
-	struct watchdog_device *wdd = platform_get_drvdata(pdev);
-	struct atlas7_wdog *wdt = watchdog_get_drvdata(wdd);
-
-	atlas7_wdt_shutdown(pdev);
-	clk_put(wdt->clk);
-	return 0;
+	watchdog_stop_on_reboot(&atlas7_wdd);
+	watchdog_stop_on_unregister(&atlas7_wdd);
+	return devm_watchdog_register_device(dev, &atlas7_wdd);
 }
 
 static int __maybe_unused atlas7_wdt_suspend(struct device *dev)
@@ -234,8 +213,6 @@ static struct platform_driver atlas7_wdt_driver = {
 		.of_match_table	= atlas7_wdt_ids,
 	},
 	.probe = atlas7_wdt_probe,
-	.remove = atlas7_wdt_remove,
-	.shutdown = atlas7_wdt_shutdown,
 };
 module_platform_driver(atlas7_wdt_driver);
 
-- 
2.7.4

