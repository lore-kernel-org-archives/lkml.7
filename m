Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF193C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B130C214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyvPZcHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDIRYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33254 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfDIRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so9814266plo.0;
        Tue, 09 Apr 2019 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNDnzLXz1M9MSkyEZMz6quwTIkABp6XTHUa7hYI37yA=;
        b=oyvPZcHqnlHdgiRZDB5jsULoTOtPtknd2/Waso5/p6kHDzsFx3p3+dByrK489s7Rxk
         Hs/Ujzr28q7paOljX8GUYjOsZASMZK855GzwQaYluEDHhQK7H8g/O2g7EUkYcwaAtgLl
         f7oXQfcnJFPDXiH4uysFT4u++OyzOrS1y4kmM04OhOFbEWboBGtEKZzumgsvWo7BeU93
         f04bnjt3uCmWgrdwafc0NaiqxnZYBPzfYCE4BoB3etDKWmFrOUjTO6jjw8p97zVHnOca
         OVwanvXv/vQraKWXWiVWRV54uyMM5D2MHjLt7IKxCWyB2ZBy+QckleKIdM3ZBaNJSA3+
         nF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=LNDnzLXz1M9MSkyEZMz6quwTIkABp6XTHUa7hYI37yA=;
        b=jjcruHs+Qpk5BA45ZvAmhoymlaNvUhZpoPUgVqqyZTSrBDZ6tzTmY+IZ6BTYsGa6Hh
         AGGCb0zRJO1fjt4J1ZmbRPFpeu54vsshT2TD/H/UCwEJbrTCz/hK3wYwLQlW7PD5Fbj0
         OHgGRBQx+clCGyf2BNDqqngUn16O/24Kx9Yl1Zkt5lD3Hkpf0K4Ouo9eBTDjNjjou440
         6S8Y7+IHKszEInyPc5FFNkTE2up7y+M0zuEw6nEnzhddl4rCvKaaUJ4bwWtfqd0vUYCE
         VCdFJAVA8wUQBbYLmGbl+SeW6X3vEb445Ppu7rLVBG4kH/Sb8t6gKwmXEGWaCj7heUQM
         PAWg==
X-Gm-Message-State: APjAAAWQlisTvGnD1PFaviToJEFmoyX1bu5sDYIA6aWBQ3qt3P7F4yTx
        P4VKwyHi7hDMLpX2mx0yoqE=
X-Google-Smtp-Source: APXvYqxZZ8RIukBlIh13zt56Di78o4PSlG2zS7O/1U4YoGaqEkhgh+1BPYEYB+YjLNecHVeaaEsrtQ==
X-Received: by 2002:a17:902:d68d:: with SMTP id v13mr38736001ply.55.1554830683763;
        Tue, 09 Apr 2019 10:24:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k79sm15526383pfj.28.2019.04.09.10.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:43 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>
Subject: [PATCH 23/23] watchdog: tangox_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:24:01 -0700
Message-Id: <1554830641-9247-24-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
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
- Replace stop on remove with call to watchdog_stop_on_unregister()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/tangox_wdt.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index 16611fe0d9d1..1afb0e9d808c 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -108,6 +108,11 @@ static const struct watchdog_ops tangox_wdt_ops = {
 	.restart	= tangox_wdt_restart,
 };
 
+static void tangox_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 static int tangox_wdt_probe(struct platform_device *pdev)
 {
 	struct tangox_wdt_device *dev;
@@ -129,12 +134,14 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(dev->clk);
 	if (err)
 		return err;
+	err = devm_add_action_or_reset(&pdev->dev,
+				       tangox_clk_disable_unprepare, dev->clk);
+	if (err)
+		return err;
 
 	dev->clk_rate = clk_get_rate(dev->clk);
-	if (!dev->clk_rate) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (!dev->clk_rate)
+		return -EINVAL;
 
 	dev->wdt.parent = &pdev->dev;
 	dev->wdt.info = &tangox_wdt_info;
@@ -168,31 +175,16 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_restart_priority(&dev->wdt, 128);
 
-	err = watchdog_register_device(&dev->wdt);
+	watchdog_stop_on_unregister(&dev->wdt);
+	err = devm_watchdog_register_device(&pdev->dev, &dev->wdt);
 	if (err)
-		goto err;
+		return err;
 
 	platform_set_drvdata(pdev, dev);
 
 	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
 
 	return 0;
-
- err:
-	clk_disable_unprepare(dev->clk);
-	return err;
-}
-
-static int tangox_wdt_remove(struct platform_device *pdev)
-{
-	struct tangox_wdt_device *dev = platform_get_drvdata(pdev);
-
-	tangox_wdt_stop(&dev->wdt);
-	clk_disable_unprepare(dev->clk);
-
-	watchdog_unregister_device(&dev->wdt);
-
-	return 0;
 }
 
 static const struct of_device_id tangox_wdt_dt_ids[] = {
@@ -204,7 +196,6 @@ MODULE_DEVICE_TABLE(of, tangox_wdt_dt_ids);
 
 static struct platform_driver tangox_wdt_driver = {
 	.probe	= tangox_wdt_probe,
-	.remove	= tangox_wdt_remove,
 	.driver	= {
 		.name		= "tangox-wdt",
 		.of_match_table	= tangox_wdt_dt_ids,
-- 
2.7.4

