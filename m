Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C76C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34D720863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6UfDSdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfDHTj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40207 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfDHTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so8211198pfc.7;
        Mon, 08 Apr 2019 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g0Y1r2JeuOsU6r31ExCrDv6Aq8kzHhgXdZSTmOFnQ84=;
        b=M6UfDSdvglgCaK4OunQJQpk46h7E+emNHYfsuHwdsQxt/7ksNnlUQyk5cASVinqbv5
         UBMq/iBV80Qg4fmJT0h6619xEHrm+nGR7Gze6rygq+S2tuAPYWOrJ/ShfeEg3TONSaA7
         fwCI245o+digv0vcx1g+/R+skwgqxASO/dfzGd3uSXDwI4ZBrzsYMydEgRxCGLAn2Onu
         DYb4+S/DSXDbKRECKguMFboFaKjWCKZgLHIed1Q+m0vyIqBuBx8O0UQD6OARWky6oNy3
         LhlYw7pPRrEb4xoF+t2wfYt5OBDd/SDizOhREux1FlYF6Sra1fB0QJ0uIjyTDJnhMjkO
         iXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=g0Y1r2JeuOsU6r31ExCrDv6Aq8kzHhgXdZSTmOFnQ84=;
        b=WRQd1b1HILcJqh1K7f3dfeG7QFcf/ARrQfGwKzxPGcv/NFrSDgG9oX6hYhEH+ZmGpl
         xgmPLU9zJVmAEYZL/RONIXhpwdbf4zP/WmND+itDhjUnQ57gAhJH++dvC6KhJWexu+zj
         dtIXxS2U67vbywut3Fpp01kAUtE357UPcA5XvqGXGWxYfkQJEY6WespYWSTLCDk8cqkY
         Ke8k3/j5NZzAMgQ8DHYaQGy3FyzMswF3p1On+n2H3qM8Xa22JnyURAavwhA4laZGg5rl
         sfyV2DX1dC3gfY+MTr8CQcj2QxAVf1CHPBHfpsiqkxIDgAWVYa01GKCFy5/VmdpStvoG
         pOEA==
X-Gm-Message-State: APjAAAVWh69cgr8Ls+AdS2gb3wBMrKL6asxuTIZq9XiTeu5S0P42N/rd
        VV1rgQbDpHnsQSMia6yeqZ4=
X-Google-Smtp-Source: APXvYqxPvtlNeqzBrg/utQKwhLP5o97jkqiobxvQkDxQwaLRLfV8eFMCoQsbGJXtri6wlzKjvMyWiw==
X-Received: by 2002:a63:6786:: with SMTP id b128mr30464093pgc.318.1554752392767;
        Mon, 08 Apr 2019 12:39:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c25sm44259208pfo.69.2019.04.08.12.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:52 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 11/22] watchdog: da9062_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Mon,  8 Apr 2019 12:38:35 -0700
Message-Id: <1554752326-13319-12-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce local variable 'struct device *dev' and use it instead of
dereferencing it repeatedly. Also replace 'ret = func(); return ret;'
with 'return func();'.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/da9062_wdt.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index fe169d8e1fb2..aac749cfaccb 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -46,14 +46,9 @@ static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
 
 static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
 {
-	int ret;
-
-	ret = regmap_update_bits(wdt->hw->regmap,
-			   DA9062AA_CONTROL_F,
-			   DA9062AA_WATCHDOG_MASK,
-			   DA9062AA_WATCHDOG_MASK);
-
-	return ret;
+	return regmap_update_bits(wdt->hw->regmap, DA9062AA_CONTROL_F,
+				  DA9062AA_WATCHDOG_MASK,
+				  DA9062AA_WATCHDOG_MASK);
 }
 
 static int da9062_wdt_update_timeout_register(struct da9062_watchdog *wdt,
@@ -190,15 +185,16 @@ MODULE_DEVICE_TABLE(of, da9062_compatible_id_table);
 
 static int da9062_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 	struct da9062 *chip;
 	struct da9062_watchdog *wdt;
 
-	chip = dev_get_drvdata(pdev->dev.parent);
+	chip = dev_get_drvdata(dev->parent);
 	if (!chip)
 		return -EINVAL;
 
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
@@ -211,13 +207,13 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.min_hw_heartbeat_ms = DA9062_RESET_PROTECTION_MS;
 	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
-	wdt->wdtdev.parent = &pdev->dev;
+	wdt->wdtdev.parent = dev;
 
 	watchdog_set_restart_priority(&wdt->wdtdev, 128);
 
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 
-	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdtdev);
+	ret = devm_watchdog_register_device(dev, &wdt->wdtdev);
 	if (ret < 0) {
 		dev_err(wdt->hw->dev,
 			"watchdog registration failed (%d)\n", ret);
-- 
2.7.4

