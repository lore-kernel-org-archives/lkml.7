Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADE320830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC44KMiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfDJQ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34940 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387942AbfDJQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so1875292pgf.2;
        Wed, 10 Apr 2019 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CH6L2uzJtaCz65XjzhhlNI5Vmu2UxURtpsq3Xl1aHTE=;
        b=FC44KMiWHeYquqM77/vv8osNSx8MExE7lnkqrdXnDG92l2bd8wZhKbNygLt0bmwn2v
         SxCkFOFn8jCxi4Ar+CqGnEjIQDy/fz1xQLxfj8UsLoC2tuEswYUMTAXcETG8mXYmWAZ9
         sYecaVVAg5e032atVlIbmmtasnNbFXULGqNz3AO+9tW9g7qBMaYGXVmoBXOVp4N3DRQU
         PQl8UTyFycslNwgtv7QId/2CYpbxpnTsB3QJ0iI9CM3qDkpOFI0CEgfJYmpkE5Cv0C+I
         SoQRUqsnk8af9kI0EKT0NLVeUD93rt/4knMXmkrQvrvH0BwNjNCrMXw7X2gGFm3q9tCo
         CFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CH6L2uzJtaCz65XjzhhlNI5Vmu2UxURtpsq3Xl1aHTE=;
        b=iKjmuyg1pBQ2Kwk7x2hI9wF2KKlLaSrI8kXE8e+Zt/FkwrWvGFMg/5VubAXu1idbel
         2+CIAz8kl9m4VyESA0VJFZRb6nJqqzj/tp3zqujmsv3vzVN1rOaRAO7KjQ9e8736oBgU
         OesFJbFu1zuMg7qT+4roDthhZeDd6FZSN8H5vVJRX0gIl6Gcd9oxCq9nxysyegoMghkL
         YqoB1bvG6aYvf2h9/1dA3X6YaYd5PP3JNr4E3R472GtsAjprT8bz6k5g9UYdfMFI1IGv
         2Nh9o3Rjylmtb8MYl7KjS8fUYqXObRyZwCmcSS1owlUwK24iAM9U3PV/xe4kYqMdHx63
         6ojw==
X-Gm-Message-State: APjAAAUFTT1Bytksgp/UGPf+eb+G3ivZm9i+t2qRy5JGvz6k6F7dccA+
        9+puJuuCXTHIOnnsfI1SrAc=
X-Google-Smtp-Source: APXvYqxFNaDdvdR1InKhC+bT5ZC9DT+l2EnAJbuIa9WZ1Yju4F8nqVo0cRbMMt1oOcDr4Jqmn8rE6A==
X-Received: by 2002:a62:e501:: with SMTP id n1mr21039555pff.17.1554913715427;
        Wed, 10 Apr 2019 09:28:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a12sm41051784pgq.21.2019.04.10.09.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:34 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 20/22] watchdog: jz4740_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Wed, 10 Apr 2019 09:28:01 -0700
Message-Id: <1554913683-25454-21-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce local variable 'struct device *dev' and use it instead of
dereferencing it repeatedly. Also, there is no call to dev_get_drvdata()
or platform_get_drvdata() in the driver, so drop the unnecessary
call to platform_set_drvdata().

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index aa9d3523addd..d1bc7cbd4f2b 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -163,11 +163,12 @@ MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
 
 static int jz4740_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct jz4740_wdt_drvdata *drvdata;
 	struct watchdog_device *jz4740_wdt;
 	int ret;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
+	drvdata = devm_kzalloc(dev, sizeof(struct jz4740_wdt_drvdata),
 			       GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -181,7 +182,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	jz4740_wdt->timeout = heartbeat;
 	jz4740_wdt->min_timeout = 1;
 	jz4740_wdt->max_timeout = MAX_HEARTBEAT;
-	jz4740_wdt->parent = &pdev->dev;
+	jz4740_wdt->parent = dev;
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
@@ -189,18 +190,16 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
-	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
+	drvdata->rtc_clk = devm_clk_get(dev, "rtc");
 	if (IS_ERR(drvdata->rtc_clk)) {
-		dev_err(&pdev->dev, "cannot find RTC clock\n");
+		dev_err(dev, "cannot find RTC clock\n");
 		return PTR_ERR(drvdata->rtc_clk);
 	}
 
-	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
+	ret = devm_watchdog_register_device(dev, &drvdata->wdt);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, drvdata);
-
 	return 0;
 }
 
-- 
2.7.4

