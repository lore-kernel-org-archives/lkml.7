Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A838C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2721B21905
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9mfTKe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfDHTjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46368 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfDHTjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so8194339pfj.13;
        Mon, 08 Apr 2019 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kepgUGpZfR5uAkMzvzU4BdaVdRicSAbSlfhmAD09THE=;
        b=u9mfTKe2I2QPmesjPlwcFJ284y6eMgvW1Ic8EFkZzputOYSc6tI0BALxPeFBNbYc/e
         Ga6g01BLlU2zfRgLDtbJoLiKisdeXJlS84z9VYnfUrsG2SeoeLZrLAfM337YErwV6con
         pxfQ7yeiGKlILWmBhEcZriU9l2HZYKz0e+7JAAmXyzdOuhms31hqSp0p/3nG2gbMlfAL
         AszmoJRA42SqoOEgCj8JW3wyFLNF8cNnUfq6rTbg8Xa5sdubc6qibPT1U8jEMp3PGoCK
         8eX10nQokZguMA7Usx9sZH1AsMV8BLtkcataYL6qbyfIbG4r2KVR850LSv7NqRqntimp
         jZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kepgUGpZfR5uAkMzvzU4BdaVdRicSAbSlfhmAD09THE=;
        b=PnEjk0Gj9nkax3DDCAM+ZBMCpu++64gUoT1V9iRHoCv3ugaZLk8scaDepp2Jy8fw6m
         zlCVI/EQMHyJnlGQfWiSmo5WOoLLx0vlnGPIVcfCNUXep1IQsmtX3FRs1OGDmDV5DnRm
         YctvKSjWPvoveGYDfX2Fu0OobVusIDuUlRkjIvRyLB1fpbseUV2TQ1FYjK0E06E6nO9g
         PtiYBgEDzhX4ll85iqKVLiIEZJstRgOUoCGdsqFPUsWFhEWJubVQgSLUu82hwXy6RPzy
         N071CdnLmY52VncWb4EwC4PyGGXQb/gFWxFyyGAEih3BjXGm75ssNpsbkN5T24Da34yQ
         IQnw==
X-Gm-Message-State: APjAAAUlydOivJUfLCFZ34ZFiP6LD8ehmG3RlaJJq9iKeGpWoeOeTzwl
        lEZ9gm+1ebxLgD32GvBMHUdbU9Vk
X-Google-Smtp-Source: APXvYqwiGzJbVJFaGS/pS5vsSDZWgfVEo+PIdWkL41UK9fWJ8HBjeGzhJ3DZdKhsblibK5DsZRprqQ==
X-Received: by 2002:a63:1d4f:: with SMTP id d15mr3134625pgm.347.1554752381464;
        Mon, 08 Apr 2019 12:39:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g67sm47921553pfg.94.2019.04.08.12.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:41 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 03/22] watchdog: aspeed_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Mon,  8 Apr 2019 12:38:27 -0700
Message-Id: <1554752326-13319-4-git-send-email-linux@roeck-us.net>
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

Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/aspeed_wdt.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index f09333fd54b4..34117745c65f 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -187,6 +187,7 @@ static const struct watchdog_info aspeed_wdt_info = {
 
 static int aspeed_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct aspeed_wdt_config *config;
 	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
@@ -196,7 +197,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	u32 status;
 	int ret;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -212,12 +213,12 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.info = &aspeed_wdt_info;
 	wdt->wdd.ops = &aspeed_wdt_ops;
 	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
-	wdt->wdd.parent = &pdev->dev;
+	wdt->wdd.parent = dev;
 
 	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
-	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
+	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
-	np = pdev->dev.of_node;
+	np = dev->of_node;
 
 	ofdid = of_match_node(aspeed_wdt_of_table, np);
 	if (!ofdid)
@@ -286,11 +287,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		u32 max_duration = config->ext_pulse_width_mask + 1;
 
 		if (duration == 0 || duration > max_duration) {
-			dev_err(&pdev->dev, "Invalid pulse duration: %uus\n",
-					duration);
+			dev_err(dev, "Invalid pulse duration: %uus\n",
+				duration);
 			duration = max(1U, min(max_duration, duration));
-			dev_info(&pdev->dev, "Pulse duration set to %uus\n",
-					duration);
+			dev_info(dev, "Pulse duration set to %uus\n",
+				 duration);
 		}
 
 		/*
@@ -312,9 +313,9 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
-	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
+	ret = devm_watchdog_register_device(dev, &wdt->wdd);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register\n");
+		dev_err(dev, "failed to register\n");
 		return ret;
 	}
 
-- 
2.7.4

