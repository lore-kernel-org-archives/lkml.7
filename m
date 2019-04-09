Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3090C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36232084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuyKz2LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDIRY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44345 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDIRYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so10094842pfm.11;
        Tue, 09 Apr 2019 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YlBMQHRRMhSGuQhnSlFbWv+llB56GpesX1o6ChIhKxU=;
        b=SuyKz2LIVhEGOGyvfhvaUadmHhrM7ZmrNkdyPGDHc3n0iNnXeXR98eWmg51PgWiTM/
         /pTTMUCYsFulAXgGdRNFaAERml9yTaH5ud8UywW4DWXGLVifidthNk8DBwnxfT6wzXBB
         YD742r7C/N8skol38qrBrRhPTdfTFbHf6S0/L/+yTtqx2LFPcwfa++YbTZTcbNghCtOY
         4emS23u1wOtU1i8uh/+gfI0GNrvMLJQj0KFtfmkaCP3ITpETkakbWVNLNTo5C56NhEQG
         mUVmWb78rnJgW74rtgYgGevftCW6hicPmMdbjjOuUbp53yIUWifGOOnvW/KQOY4utksS
         Y2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YlBMQHRRMhSGuQhnSlFbWv+llB56GpesX1o6ChIhKxU=;
        b=F0XlbSazSntQL4tgLfnD290p7EULseR4KcrQO5cjM05IPaM4C6PRKC7onJaOjiGDwM
         R95Zed9U1/89X9+7I1FilWg5OGe9LuN0KIYv2z0cSl2NyWToS0VHIXndwLlXqvkvXtJT
         5gJHzAbMeH/vLNkxZvf8Ozwrqlg0hFch3pG3l3NmOv97wdt5Zdi9anFwcTPNZA+5pW08
         Cyb0pW8Q6U/YK6eTyZZ4GQ+tUuooc9gPBCWEMSCzlqWy67g8PW2ss2pHGyAeh0Uz18Bi
         IVUYa4Rc1t8vwdVE4YNQiMFfXfnTB4d7M4PBGpPwJpujJlrSXvnDNTptNvVnn2bzhy5p
         WgGQ==
X-Gm-Message-State: APjAAAV5bzRy1QXB5GhqJdAzoKvDPP/446Z8A1vKhBMZpeun6SeOcC72
        Rbm88KO19lJ978FStIta9j0=
X-Google-Smtp-Source: APXvYqx9Jsyrx5f90R2F39FekzKGJeQYtN2TqtqbIC9lm5866gmWcyDOFs5lfj4i0Zqp4D1QCreKbA==
X-Received: by 2002:a63:2747:: with SMTP id n68mr36008288pgn.317.1554830658622;
        Tue, 09 Apr 2019 10:24:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10sm15915554pgq.54.2019.04.09.10.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:18 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 05/23] watchdog: meson_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue,  9 Apr 2019 10:23:43 -0700
Message-Id: <1554830641-9247-6-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
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

Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/meson_wdt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 7fc6acb33c7f..01889cef81e1 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -164,11 +164,12 @@ MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
 
 static int meson_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct meson_wdt_dev *meson_wdt;
 	const struct of_device_id *of_id;
 	int err;
 
-	meson_wdt = devm_kzalloc(&pdev->dev, sizeof(*meson_wdt), GFP_KERNEL);
+	meson_wdt = devm_kzalloc(dev, sizeof(*meson_wdt), GFP_KERNEL);
 	if (!meson_wdt)
 		return -ENOMEM;
 
@@ -176,14 +177,14 @@ static int meson_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(meson_wdt->wdt_base))
 		return PTR_ERR(meson_wdt->wdt_base);
 
-	of_id = of_match_device(meson_wdt_dt_ids, &pdev->dev);
+	of_id = of_match_device(meson_wdt_dt_ids, dev);
 	if (!of_id) {
-		dev_err(&pdev->dev, "Unable to initialize WDT data\n");
+		dev_err(dev, "Unable to initialize WDT data\n");
 		return -ENODEV;
 	}
 	meson_wdt->data = of_id->data;
 
-	meson_wdt->wdt_dev.parent = &pdev->dev;
+	meson_wdt->wdt_dev.parent = dev;
 	meson_wdt->wdt_dev.info = &meson_wdt_info;
 	meson_wdt->wdt_dev.ops = &meson_wdt_ops;
 	meson_wdt->wdt_dev.max_timeout =
@@ -195,18 +196,18 @@ static int meson_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&meson_wdt->wdt_dev, meson_wdt);
 
-	watchdog_init_timeout(&meson_wdt->wdt_dev, timeout, &pdev->dev);
+	watchdog_init_timeout(&meson_wdt->wdt_dev, timeout, dev);
 	watchdog_set_nowayout(&meson_wdt->wdt_dev, nowayout);
 	watchdog_set_restart_priority(&meson_wdt->wdt_dev, 128);
 
 	meson_wdt_stop(&meson_wdt->wdt_dev);
 
 	watchdog_stop_on_reboot(&meson_wdt->wdt_dev);
-	err = devm_watchdog_register_device(&pdev->dev, &meson_wdt->wdt_dev);
+	err = devm_watchdog_register_device(dev, &meson_wdt->wdt_dev);
 	if (err)
 		return err;
 
-	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
+	dev_info(dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
 		 meson_wdt->wdt_dev.timeout, nowayout);
 
 	return 0;
-- 
2.7.4

