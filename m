Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C6C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAF520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n106AwkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfDHTkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40215 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfDHTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:40:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so8211360pfc.7;
        Mon, 08 Apr 2019 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PykYAkk8RSwT35YgeR0OtSm82fJq863ebQpRt9L2OPc=;
        b=n106AwkDvNxW8yoOchoLeo48fc0TaSXdlP1V07nTdWAEizcO6I+dDUb+0eJ4x8CsTz
         kTczAc9EKZYKa9SVEVHvBmIYdDec2oQVvIkJoKZryfDzAJX8poMk1Wk6u0zNsVvvgKpq
         3bhGgCnxoefXCwEh//W0V36IyYQkPqg2YvZKBZrCiIkHoogS87/wFnbyXc71CL3MqELW
         OLR1g0+aIzJjRkEhadvS2HiBAuaQJwDeaXzulxOAGwx/qNP5zeCMwyRfkP6fiq8LBmIF
         y/HEHjsh7RNypskEtMVqSunJipnezXTjQTcDShRNyN3f1+VZO0AKWySZzIvSAIg21VrQ
         9KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=PykYAkk8RSwT35YgeR0OtSm82fJq863ebQpRt9L2OPc=;
        b=IVSC5+Q0TqKjaCGwd2miFUZRtf6f2upYSq013K/PC+waM2w3CU8uQZzVkETepvqn3K
         M3SAYf5WgOgCrdEEEo63woIjQIou1fapnWyJo3Ye49GBYwME7QGSZQLNtfloiHhfgupL
         2YFR3H+uyNNdK0ddeQm9X8Reb1WQaGCxwLNw5nZDT2eyXt8BSSrLLGAPaN06jlMNKCnr
         pOSKDJxUkvHllzTYjAVGeZs/JOA9f+gI5R7W1RF8bOXaASYxqgDGzJVWTW8LgRJHurFx
         8AeJx1ltPulG2i/zvRyJm+MnMh+TpO52k6Y2L65h2zL0YEZxplwnbLXD1ZN6vjWSsTwS
         IO/A==
X-Gm-Message-State: APjAAAW70CPGi90kzqWB4iRinCt1xHZZ7AWYthY0sOB+y4GQEksDp7wG
        O/ICgHBiZneEWRgeN4sIw8Y=
X-Google-Smtp-Source: APXvYqxc5S02+2sTiKk7in55riXMLX69eadiRzm0UY2KTNfJbGuE22cgcpt3/o+YDnBMNR6CQrfgig==
X-Received: by 2002:a63:5a1d:: with SMTP id o29mr29985996pgb.320.1554752399673;
        Mon, 08 Apr 2019 12:39:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x66sm18406342pfb.78.2019.04.08.12.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:59 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 16/22] watchdog: gpio_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:40 -0700
Message-Id: <1554752326-13319-17-git-send-email-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/gpio_wdt.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index ea77cae03c9d..bc24674b4d9e 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -154,25 +154,14 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->wdd.parent	= dev;
 	priv->wdd.timeout	= SOFT_TIMEOUT_DEF;
 
-	watchdog_init_timeout(&priv->wdd, 0, &pdev->dev);
+	watchdog_init_timeout(&priv->wdd, 0, dev);
 
 	watchdog_stop_on_reboot(&priv->wdd);
 
 	if (priv->always_running)
 		gpio_wdt_start(&priv->wdd);
 
-	ret = watchdog_register_device(&priv->wdd);
-
-	return ret;
-}
-
-static int gpio_wdt_remove(struct platform_device *pdev)
-{
-	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&priv->wdd);
-
-	return 0;
+	return devm_watchdog_register_device(dev, &priv->wdd);
 }
 
 static const struct of_device_id gpio_wdt_dt_ids[] = {
@@ -187,7 +176,6 @@ static struct platform_driver gpio_wdt_driver = {
 		.of_match_table	= gpio_wdt_dt_ids,
 	},
 	.probe	= gpio_wdt_probe,
-	.remove	= gpio_wdt_remove,
 };
 
 #ifdef CONFIG_GPIO_WATCHDOG_ARCH_INITCALL
-- 
2.7.4

