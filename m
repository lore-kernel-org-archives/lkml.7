Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C37C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7803D20863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFSCD2+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfDHTj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33611 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfDHTju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so7896408pgh.0;
        Mon, 08 Apr 2019 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmPUEUcV2qWha6hVjFgTxBEPjINUfNIEc6V+OTChC98=;
        b=vFSCD2+WKiyO5vjfy8BRP9sBopWQONpzQhaCRjI5pj82bJ4VxHKwjdnzqiF7i+7N+b
         gFL7TPWx4nKhHGtLvUu7aqtxTltpM7NK1KRGWy2D2d9X+bPZeObmc0tp0/WC3ZdRsX/3
         8Yvd3FJsKwuCRtDNWUzYXyfvTzIIXB6+8/ppophDUdm04BNdIJ0Fgytqz9Y7/gO2CbW4
         TnOd9KzJvfZ9oY2nDdpzTsNbiSoovsCWIZcYKPNPoC23bVFSO914zogSMOLKyaBsLkzF
         3+ydKfdsP9RemeLyPDIDyrL1pclU5/KylGSr6e1LtGHJXbvenK0Uh1Ac9SZcBSJODhSs
         7SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=MmPUEUcV2qWha6hVjFgTxBEPjINUfNIEc6V+OTChC98=;
        b=hvNUrPnhEsc0VUfdI7bVFQ3nnG/zroQEYZjmNBSXfmLq8DfnSAaZpkzDW+tq6rOFMs
         Ds7UjGxz6t5ZiNaQjy5vZ6RXqZcCvtAOnW7WXUazCimxkW6Ly5Vy6t/nOW3EaYYOeKDd
         iGSrP+r7/sT4+ZOFTL/hEVXBhy3JQ6jPaN9CHlzhHulBvY88nD2pXoRxys9PEKTivlcw
         pmcrvgEdctUwK+4oh67GXIlTFbQD5jda/RgIz8xAwMBXKeqCF1wmBR4HdXl1rbQKWbWn
         avHuNYuL/7DUHscFAAe+RGdSNkRvpiR7mXhLSVtub31CjU2e/VUPPIl5JaJQ5whTIse2
         aB2Q==
X-Gm-Message-State: APjAAAWXSjoCQjzhK2iWuA56zwKDsXGjPFZJYrEyVpKEO9AXZX/b34/D
        1+Bv5PGfXP5vFyF7Gw/OSVs=
X-Google-Smtp-Source: APXvYqxrtWwrSowQTRBbPiIgX3V5NRNYn9JOKkRoUnwTpDkuOVT+vc3rPiHPcMnrRSs9CVLX2BuAUg==
X-Received: by 2002:a63:5c43:: with SMTP id n3mr28009486pgm.163.1554752389921;
        Mon, 08 Apr 2019 12:39:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b6sm37325708pgl.49.2019.04.08.12.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:49 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 09/22] watchdog: da9052_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Mon,  8 Apr 2019 12:38:33 -0700
Message-Id: <1554752326-13319-10-git-send-email-linux@roeck-us.net>
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

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/da9052_wdt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index e263bad99574..a2feef1ff307 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -150,13 +150,13 @@ static const struct watchdog_ops da9052_wdt_ops = {
 
 static int da9052_wdt_probe(struct platform_device *pdev)
 {
-	struct da9052 *da9052 = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct da9052 *da9052 = dev_get_drvdata(dev->parent);
 	struct da9052_wdt_data *driver_data;
 	struct watchdog_device *da9052_wdt;
 	int ret;
 
-	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
-				   GFP_KERNEL);
+	driver_data = devm_kzalloc(dev, sizeof(*driver_data), GFP_KERNEL);
 	if (!driver_data)
 		return -ENOMEM;
 	driver_data->da9052 = da9052;
@@ -166,18 +166,17 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	da9052_wdt->timeout = DA9052_DEF_TIMEOUT;
 	da9052_wdt->info = &da9052_wdt_info;
 	da9052_wdt->ops = &da9052_wdt_ops;
-	da9052_wdt->parent = &pdev->dev;
+	da9052_wdt->parent = dev;
 	watchdog_set_drvdata(da9052_wdt, driver_data);
 
 	ret = da9052_reg_update(da9052, DA9052_CONTROL_D_REG,
 				DA9052_CONTROLD_TWDSCALE, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to disable watchdog bits, %d\n",
-			ret);
+		dev_err(dev, "Failed to disable watchdog bits, %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_watchdog_register_device(&pdev->dev, &driver_data->wdt);
+	ret = devm_watchdog_register_device(dev, &driver_data->wdt);
 	if (ret != 0) {
 		dev_err(da9052->dev, "watchdog_register_device() failed: %d\n",
 			ret);
-- 
2.7.4

