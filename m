Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773A420830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jif+mwfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfDJQ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38610 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387850AbfDJQ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so1864837pgl.5;
        Wed, 10 Apr 2019 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QwAPcVTaRjeqfsFr8XXwNRJEpE416YFfDiIeqJBF43g=;
        b=jif+mwfAxK/aeRxRT38GaXeBRHVweFZMnOQEl05ep50rY+Zuc0QFpqVrAxAdvcP4iV
         QpM8w2sKG7Zyr5ZRAM16LKowPTImWCxz7PJJeyjWT4skraSYlMHQ9O+qYwMmMLkFyao8
         HcFx+uSvaeyLnFnJyVjqgDquDkgWrcAtxeASdn/RBo1DtLDuKXejoQxGWdVIUOKEulH3
         ZcXyAJj3on663R40l+1TtuG66KlEatd/rG6qOhRCbCD6NG2E+gN8ZJ4zG+RatZ7ac1+J
         ihtloAKtbOsERn80OhnIIWVCsfZgalTRgFnRDlZZrTq47lt9rrG0wCBS4DFt/RZugDoa
         aBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=QwAPcVTaRjeqfsFr8XXwNRJEpE416YFfDiIeqJBF43g=;
        b=h0Z0WQEyIUBKdOMkPL4YoD+fttSH9DsenIRSEOh1g6Ih/V418Q8SJ9KgUdzl7wToKG
         yEqPOE0L6XBBP4HP/yTjEnqFeYnD1Jcw9SCqCc2k0AA4tIQ5BK7TWPp5oE0hO3PUnwUR
         WBks96GA1R8XcPU6mXGBXyINpw09/IAaBWdzlq0Goyw1UnA+EkResKkp074Y98aDf8Pr
         2DUCDRu8ZFjQS68ByXiJ7Z6FC9QN26dbapDNydA0iFkYpTVbsqr0FI8C/b+dtd8hc7II
         uH/NEqh+mwOENqJYKMPg7TlbnGUOf78PpFQUbM+2y+rIt33EXxz99BkJlENgfyId6OAG
         1tDA==
X-Gm-Message-State: APjAAAVG45VM4nxhmSzxO38qxeb62yFy8pATSa32n+bXpeD1B+nQegjv
        9+mptDQ+QqtqNBH19YyqEBc=
X-Google-Smtp-Source: APXvYqwqhw4nFCU7IjLHo/biDMFNZzKeeocxwx64eAHs4qDA5c/oPvV+aDBqBj0OODLQg2/hx3v+LQ==
X-Received: by 2002:a63:195f:: with SMTP id 31mr42145008pgz.116.1554913697545;
        Wed, 10 Apr 2019 09:28:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r145sm82062726pgr.84.2019.04.10.09.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:17 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/22] watchdog: wdat_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Wed, 10 Apr 2019 09:27:48 -0700
Message-Id: <1554913683-25454-8-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/wdat_wdt.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 387892fe63b4..430ee4e9b185 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -308,6 +308,7 @@ static const struct watchdog_ops wdat_wdt_ops = {
 
 static int wdat_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct acpi_wdat_entry *entries;
 	const struct acpi_table_wdat *tbl;
 	struct wdat_wdt *wdat;
@@ -321,11 +322,11 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	wdat = devm_kzalloc(&pdev->dev, sizeof(*wdat), GFP_KERNEL);
+	wdat = devm_kzalloc(dev, sizeof(*wdat), GFP_KERNEL);
 	if (!wdat)
 		return -ENOMEM;
 
-	regs = devm_kcalloc(&pdev->dev, pdev->num_resources, sizeof(*regs),
+	regs = devm_kcalloc(dev, pdev->num_resources, sizeof(*regs),
 			    GFP_KERNEL);
 	if (!regs)
 		return -ENOMEM;
@@ -350,15 +351,15 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 		res = &pdev->resource[i];
 		if (resource_type(res) == IORESOURCE_MEM) {
-			reg = devm_ioremap_resource(&pdev->dev, res);
+			reg = devm_ioremap_resource(dev, res);
 			if (IS_ERR(reg))
 				return PTR_ERR(reg);
 		} else if (resource_type(res) == IORESOURCE_IO) {
-			reg = devm_ioport_map(&pdev->dev, res->start, 1);
+			reg = devm_ioport_map(dev, res->start, 1);
 			if (!reg)
 				return -ENOMEM;
 		} else {
-			dev_err(&pdev->dev, "Unsupported resource\n");
+			dev_err(dev, "Unsupported resource\n");
 			return -EINVAL;
 		}
 
@@ -376,12 +377,11 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 		action = entries[i].action;
 		if (action >= MAX_WDAT_ACTIONS) {
-			dev_dbg(&pdev->dev, "Skipping unknown action: %u\n",
-				action);
+			dev_dbg(dev, "Skipping unknown action: %u\n", action);
 			continue;
 		}
 
-		instr = devm_kzalloc(&pdev->dev, sizeof(*instr), GFP_KERNEL);
+		instr = devm_kzalloc(dev, sizeof(*instr), GFP_KERNEL);
 		if (!instr)
 			return -ENOMEM;
 
@@ -398,7 +398,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 			r.flags = IORESOURCE_IO;
 		} else {
-			dev_dbg(&pdev->dev, "Unsupported address space: %d\n",
+			dev_dbg(dev, "Unsupported address space: %d\n",
 				gas->space_id);
 			continue;
 		}
@@ -413,14 +413,15 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 		}
 
 		if (!instr->reg) {
-			dev_err(&pdev->dev, "I/O resource not found\n");
+			dev_err(dev, "I/O resource not found\n");
 			return -EINVAL;
 		}
 
 		instructions = wdat->instructions[action];
 		if (!instructions) {
-			instructions = devm_kzalloc(&pdev->dev,
-					sizeof(*instructions), GFP_KERNEL);
+			instructions = devm_kzalloc(dev,
+						    sizeof(*instructions),
+						    GFP_KERNEL);
 			if (!instructions)
 				return -ENOMEM;
 
@@ -441,7 +442,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdat);
 
 	watchdog_set_nowayout(&wdat->wdd, nowayout);
-	return devm_watchdog_register_device(&pdev->dev, &wdat->wdd);
+	return devm_watchdog_register_device(dev, &wdat->wdd);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.7.4

