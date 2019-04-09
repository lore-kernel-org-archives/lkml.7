Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93857C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E662084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQq586Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDIRYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43006 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfDIRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so9680466pgh.9;
        Tue, 09 Apr 2019 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pcq2ZYRBSeSNy0rJ3Utjw0J/rJxnyDG4Pd+n7XplGZg=;
        b=sQq586EkCdJ/9p7WXbf1+H4bh2TINrQgyFOaGEWzq73ea78a8TTtygrWBYsBm5D66l
         kGKJjl0zk4jxAbg57WROS2uL2sCDVjnbgVP4h/LFoHEEgH9fnVsuHf4sdrEi4CU40myD
         VCUPPjiiB/JPdVRLY+T/9w7vMX/tYSOjBlWBiWoKBe2dnOC/0p5e5goZKivDONbUiJJq
         yVx5mae2UZZpR8y+MBdIHJtgesJMYbLjOS22JpcSjE83/1sDPu8Q2EsXf9fTQmf4UWu6
         VCDEZX/mVtpocR4JnXjfq3gVx2D0qEf1uomR/QJXb/iv/IvUVxkneuk4BVGepltVlrpC
         ZeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=pcq2ZYRBSeSNy0rJ3Utjw0J/rJxnyDG4Pd+n7XplGZg=;
        b=f/D32akfRAU6XX144uPllIk4sm0HlJCRDP2mmpqlnaPYshDn2+tAY0jR4xRobMrK8p
         5wARjEQo+V99la8wnSWZfkRA1dTbhVRpFOIZ+JY+gKvVd3UoULeLufLZNYEeFUbHLNKd
         p8XpnODJafZTLqFePS0ChHSNuCmiif0XS4IwdqXIn+pof5Od9j8b0iLmekZNfwrdsLBE
         PslIQj6xx4r0JaeC9OCmYMfaOQc+Qs+cpudBWn9A345/zgzsCuhYoviK6pji3aPoIdAX
         J6oTJiCqpydAWPDDRXeqxcFciubk3X7MdXFAMB0waxKnfrWJ8IesTm2XSPBsAURLworJ
         NWlA==
X-Gm-Message-State: APjAAAVRRccL9xcUN/XOUVeLYe7A4wFvY/ENapmgvPsgPB5TbmeFyZFG
        OBWnf58GfCz4tLcxvPuWAWE=
X-Google-Smtp-Source: APXvYqz3ypuWQ/GC2tJ1glxa89gkZLD8vcBTfWvm5rHPTVsRsVMbcml5Afau1P2z4QXVsUP0hY+64Q==
X-Received: by 2002:a63:cf0f:: with SMTP id j15mr35672330pgg.329.1554830667025;
        Tue, 09 Apr 2019 10:24:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l88sm56756038pfb.104.2019.04.09.10.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:26 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 11/23] watchdog: pm8916_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue,  9 Apr 2019 10:23:49 -0700
Message-Id: <1554830641-9247-12-git-send-email-linux@roeck-us.net>
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/pm8916_wdt.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/pm8916_wdt.c b/drivers/watchdog/pm8916_wdt.c
index 7f10041fcf5b..2d3652004e39 100644
--- a/drivers/watchdog/pm8916_wdt.c
+++ b/drivers/watchdog/pm8916_wdt.c
@@ -132,15 +132,16 @@ static const struct watchdog_ops pm8916_wdt_ops = {
 
 static int pm8916_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pm8916_wdt *wdt;
 	struct device *parent;
 	int err, irq;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
-	parent = pdev->dev.parent;
+	parent = dev->parent;
 
 	/*
 	 * The pm8916-pon-wdt is a child of the pon device, which is a child
@@ -150,20 +151,20 @@ static int pm8916_wdt_probe(struct platform_device *pdev)
 	 */
 	wdt->regmap = dev_get_regmap(parent->parent, NULL);
 	if (!wdt->regmap) {
-		dev_err(&pdev->dev, "failed to locate regmap\n");
+		dev_err(dev, "failed to locate regmap\n");
 		return -ENODEV;
 	}
 
 	err = device_property_read_u32(parent, "reg", &wdt->baseaddr);
 	if (err) {
-		dev_err(&pdev->dev, "failed to get pm8916-pon address\n");
+		dev_err(dev, "failed to get pm8916-pon address\n");
 		return err;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq > 0) {
-		if (devm_request_irq(&pdev->dev, irq, pm8916_wdt_isr, 0,
-				     "pm8916_wdt", wdt))
+		if (devm_request_irq(dev, irq, pm8916_wdt_isr, 0, "pm8916_wdt",
+				     wdt))
 			irq = 0;
 	}
 
@@ -172,23 +173,23 @@ static int pm8916_wdt_probe(struct platform_device *pdev)
 			   wdt->baseaddr + PON_PMIC_WD_RESET_S2_CTL,
 			   RESET_TYPE_HARD);
 	if (err) {
-		dev_err(&pdev->dev, "failed configure watchdog\n");
+		dev_err(dev, "failed configure watchdog\n");
 		return err;
 	}
 
 	wdt->wdev.info = (irq > 0) ? &pm8916_wdt_pt_ident : &pm8916_wdt_ident,
 	wdt->wdev.ops = &pm8916_wdt_ops,
-	wdt->wdev.parent = &pdev->dev;
+	wdt->wdev.parent = dev;
 	wdt->wdev.min_timeout = PM8916_WDT_MIN_TIMEOUT;
 	wdt->wdev.max_timeout = PM8916_WDT_MAX_TIMEOUT;
 	wdt->wdev.timeout = PM8916_WDT_DEFAULT_TIMEOUT;
 	wdt->wdev.pretimeout = 0;
 	watchdog_set_drvdata(&wdt->wdev, wdt);
 
-	watchdog_init_timeout(&wdt->wdev, 0, &pdev->dev);
+	watchdog_init_timeout(&wdt->wdev, 0, dev);
 	pm8916_wdt_configure_timers(&wdt->wdev);
 
-	return devm_watchdog_register_device(&pdev->dev, &wdt->wdev);
+	return devm_watchdog_register_device(dev, &wdt->wdev);
 }
 
 static const struct of_device_id pm8916_wdt_id_table[] = {
-- 
2.7.4

