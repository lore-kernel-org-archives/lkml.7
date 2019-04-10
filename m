Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C85C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE4C206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3I1vWgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbfDJQ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:29:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37280 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbfDJQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so1736640ply.4;
        Wed, 10 Apr 2019 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+OYZTkxC1btQoTo+CXY+tiiGNBQ6X0e0abBF8L5gRR4=;
        b=u3I1vWgIYAG1nPvzX26Da5tisPuNKB9cxwqh1pMkGSbCPoBJBp6tZQTS3go9ZrYbyt
         y2jNQKjFXDsVC9OIiEnrK932Nh2sfkXubCpxzcf/joQrXfSfIzqeYW3z3m2GTFtCwSAI
         zLFW3D5cNam26XALxRMRsEEbR1BQkSQGHHlj7lA7qCu09iKlMB9Z4HxTLVb3SfHR11ME
         FMarREPQH8X0YKuuSgnbi3Ecwh0qj0lOc5giip+kBpRZfsij8xCkhXDpNUAbncDApulQ
         C3c8bRCMN5mxrDBXp2lbIQptjrnGMRx8uAAQq/qmIM8VsNnSJKcfCa62z8VX0nOwDTSS
         jfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+OYZTkxC1btQoTo+CXY+tiiGNBQ6X0e0abBF8L5gRR4=;
        b=ITTeloJN7g/G5ihv86KB+S255h6+8+mn8rG4Ysr4Nvg7h+suWfc+kynKYp0GN/5XEl
         /r/vMIuSL5wBD3+io2S1eK1j+f7XZ6lkRDmD9YgXzUzX4HjXSPm0spZMwnEgORHlc3iE
         c4HOCSug9tx5n0aBpNJXljVtFFhcxNYVBKfQd1i8noGXDubjN+ETSPnWmJiFsZkjLd2B
         6dK8fYpwP8YN5pkqcoDebaAL36nvefWD/bMtMU3oszcXvEnx6YIfWr9WG0vMBtspPjC7
         7h3LVtvL+jXo/aJ5lhVaU1TsBYgeKpjztnQhnMRpZxACGpHDX3vedtntVj+zxwzm50PP
         0Rgw==
X-Gm-Message-State: APjAAAWemLFcyD//LuHkfXegcuD4Q0Y9y8wQcbomVVk940krJd668hnS
        MASSANlteUuJehAH/y4p+D7NHsGt
X-Google-Smtp-Source: APXvYqw/YrilPAqum7c4xuLJSrII8eI42TVZgzHkeyWwyBnBEQOlx/p3EQ+pLq1TxrBO5xxWc6WyVQ==
X-Received: by 2002:a17:902:362:: with SMTP id 89mr45258536pld.172.1554913700597;
        Wed, 10 Apr 2019 09:28:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2sm59541605pgr.74.2019.04.10.09.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:19 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/22] watchdog: xen_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Wed, 10 Apr 2019 09:27:50 -0700
Message-Id: <1554913683-25454-10-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/xen_wdt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index f1c016d015b3..6c1ca1f31cbc 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -122,35 +122,35 @@ static struct watchdog_device xen_wdt_dev = {
 
 static int xen_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct sched_watchdog wd = { .id = ~0 };
 	int ret = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wd);
 
 	if (ret == -ENOSYS) {
-		dev_err(&pdev->dev, "watchdog not supported by hypervisor\n");
+		dev_err(dev, "watchdog not supported by hypervisor\n");
 		return -ENODEV;
 	}
 
 	if (ret != -EINVAL) {
-		dev_err(&pdev->dev, "unexpected hypervisor error (%d)\n", ret);
+		dev_err(dev, "unexpected hypervisor error (%d)\n", ret);
 		return -ENODEV;
 	}
 
 	if (watchdog_init_timeout(&xen_wdt_dev, timeout, NULL))
-		dev_info(&pdev->dev, "timeout value invalid, using %d\n",
-			xen_wdt_dev.timeout);
+		dev_info(dev, "timeout value invalid, using %d\n",
+			 xen_wdt_dev.timeout);
 	watchdog_set_nowayout(&xen_wdt_dev, nowayout);
 	watchdog_stop_on_reboot(&xen_wdt_dev);
 	watchdog_stop_on_unregister(&xen_wdt_dev);
 
-	ret = devm_watchdog_register_device(&pdev->dev, &xen_wdt_dev);
+	ret = devm_watchdog_register_device(dev, &xen_wdt_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot register watchdog device (%d)\n",
-			ret);
+		dev_err(dev, "cannot register watchdog device (%d)\n", ret);
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "initialized (timeout=%ds, nowayout=%d)\n",
-		xen_wdt_dev.timeout, nowayout);
+	dev_info(dev, "initialized (timeout=%ds, nowayout=%d)\n",
+		 xen_wdt_dev.timeout, nowayout);
 
 	return 0;
 }
-- 
2.7.4

