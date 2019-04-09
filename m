Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D011D2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgO5WhP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDIRYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35594 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDIRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so7796636pfh.2;
        Tue, 09 Apr 2019 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BTbLDR4gnZ7lFPmSCCa0QIInTL3LtlTlBWa9cvu84sM=;
        b=NgO5WhP0ViQOQ67MmOnc7P+BOFX3ODs7bfwlSYsjIjsI5fLs7fClX2BQb9B74V9V2r
         B2+0DNQz7+Sd2ACrzYmYPZh9jkuOZrdQ4ViO4Vxbk8c6z6MsXk3hKxD2dT0b5DBFKKdt
         h1j43GRpUvri0iiGPK0zp3Q66FvPqEpIPrxTHWg4p9JLdMwBe2p66s1w2QYi+0iYTpFY
         vMw9ltLbGBH03rQ4f/Y8N+vl3m2LHycYqUzyn6qDVbQCDAj3LyizmZD2sXc5YG5pbCcL
         HsORUjjWHifwHn1sFQxQc/ZS+gZi3fSzJlsOVefy+sl94Is0Pui2LxnthGmws+9HDekX
         IQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=BTbLDR4gnZ7lFPmSCCa0QIInTL3LtlTlBWa9cvu84sM=;
        b=f8n97yX9F5l1UkKvzJ06Dcf7ImjaqJuv12yQuxnWluGgZxzg9ENY81wuntcA6tuK3S
         a8T1EjHAJeNx64g9PNEGriIpqa5nFJxILU4lIffA2yusYXuzcBYz3S6kA5gVKB0Q1L1L
         bj6lo5mW3+6lwy4WEf2Dbmkt9mu18/c9sTFSGZg46+Hwe0y/Y96uC1obQBw3h4HUDBDd
         5xuK2IjkwNVMmQ5y6GiVS4G4rZWnJw4dhfCPgETCHS3C+up7dbO3dZHZeTEzi3huLRn5
         IqEGrIGtjwz37TjHrNn1gzMJX/8sCaHh7g09qaxJ+je5s5apzguKx/u9CAU2O8c2Nzw5
         ptLg==
X-Gm-Message-State: APjAAAU3WnpFqGncExh5cCPulc5wMqzzo3zDUQRlZVZCr75REeousi6B
        OSGHpyh6+8Bxt+k3oC3TF+M=
X-Google-Smtp-Source: APXvYqyZbGEfHz99IbERUPIpeCYQUuPgVmJryMgmJIIz/W2Vu7ABU/1nqFf6vzsqsu0Q0MAQGbGecA==
X-Received: by 2002:a63:2f44:: with SMTP id v65mr35494829pgv.141.1554830660198;
        Tue, 09 Apr 2019 10:24:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm45069219pfn.159.2019.04.09.10.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:19 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/23] watchdog: mlx_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue,  9 Apr 2019 10:23:44 -0700
Message-Id: <1554830641-9247-7-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/mlx_wdt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/mlx_wdt.c b/drivers/watchdog/mlx_wdt.c
index 70c2cbf9c993..03b9ac4b99af 100644
--- a/drivers/watchdog/mlx_wdt.c
+++ b/drivers/watchdog/mlx_wdt.c
@@ -233,20 +233,21 @@ static int mlxreg_wdt_init_timeout(struct mlxreg_wdt *wdt,
 
 static int mlxreg_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct mlxreg_core_platform_data *pdata;
 	struct mlxreg_wdt *wdt;
 	int rc;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "Failed to get platform data.\n");
+		dev_err(dev, "Failed to get platform data.\n");
 		return -EINVAL;
 	}
-	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
-	wdt->wdd.parent = &pdev->dev;
+	wdt->wdd.parent = dev;
 	wdt->regmap = pdata->regmap;
 	mlxreg_wdt_config(wdt, pdata);
 
@@ -266,12 +267,11 @@ static int mlxreg_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	}
 	mlxreg_wdt_check_card_reset(wdt);
-	rc = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
+	rc = devm_watchdog_register_device(dev, &wdt->wdd);
 
 register_error:
 	if (rc)
-		dev_err(&pdev->dev,
-			"Cannot register watchdog device (err=%d)\n", rc);
+		dev_err(dev, "Cannot register watchdog device (err=%d)\n", rc);
 	return rc;
 }
 
-- 
2.7.4

