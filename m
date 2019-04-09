Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410ACC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143AD2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpwxrvub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDIRYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:24:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37295 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDIRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:24:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so9686844pgc.4;
        Tue, 09 Apr 2019 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wCXHrOsWqXSwK8IC/YC+rDt+Fx5DNdMSraig28kMeIs=;
        b=mpwxrvubsnHrRUQtwmvZrNHCNi7Q/q1+vHEdRG/TriC9+JvoBUwhaM6IEHDoKRrEuV
         S+71QQoSHQwUH+TJRh3Cq5BJf3fUfMlmnzWzFjxMdhvSemuA3g81R5FOq6ceNTozTJol
         hV0JsMj0MxAhV+NyY7di3Y9cSTXeqHnpCEWInRs23MJ6Zjq1CtrQi+98x79Zt9T27934
         maj70O6yRjKfjnkDhCAosJpYIDmSdllc7gpsbWbbiBpgcOzxs1gkOiG280EdmyxHSqgm
         kaO+n9+RZL0QpfiDlk3PewK8unON20eM5V8MbvShTGJ2UfbtQya6/Z6GlXh+H744Qq3g
         8KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=wCXHrOsWqXSwK8IC/YC+rDt+Fx5DNdMSraig28kMeIs=;
        b=aZC3Gv+kFCoyU/uhKuV6XV5dl0U3s7xiLowbzKROUkh8PkA4soKPTFVztfghjfMMP/
         Cb/GdpS9tjspNOZZWWdKq5fefFsdbzF5wTt76ipImu0P5udih/JKU/qvkLFpZiRlJjQF
         GM0TiDl4QmkQkdy7P0wuOxoO0MDUfjN9M62+bZOq2ad2p6CiOUGSljvddhPLD4k0MUmn
         wy6JX0ZQkcQ1P8FkaC0i02UGDo1vSBTWuQPb1pJembPAoSQG7H8kmxxv9K6GL40aXe1G
         NMIBnEaRCQD297zrpFdjvawgxAeVQ26eCJsGdcKC6ezcwYhhN9r70FT7zMgV/hFzPhOP
         qMvA==
X-Gm-Message-State: APjAAAU/0PgThSZZDCGqCFMqyciuMT/8EEdkkwTcLRHYGAAvflQI35Ki
        BChJPoa/HLbArOsamif92M4=
X-Google-Smtp-Source: APXvYqx7DrLyrMimYHWjerCF4nTRqpMoTuqxLhS2qiGsz+sSBX7rHt5y0STqMuiVIIFME2lx9p31VQ==
X-Received: by 2002:a65:6259:: with SMTP id q25mr35969443pgv.103.1554830662973;
        Tue, 09 Apr 2019 10:24:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q75sm7345068pfi.102.2019.04.09.10.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:24:22 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 08/23] watchdog: mtk_wdt: Convert to use device managed functions and other improvements
Date:   Tue,  9 Apr 2019 10:23:46 -0700
Message-Id: <1554830641-9247-9-git-send-email-linux@roeck-us.net>
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
- Drop empty remove function
- Introduce local variable 'struct device *dev' and use it instead of
  dereferencing it repeatedly
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mtk_wdt.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 113a48d54058..9c3d0033260d 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -153,10 +153,11 @@ static const struct watchdog_ops mtk_wdt_ops = {
 
 static int mtk_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct mtk_wdt_dev *mtk_wdt;
 	int err;
 
-	mtk_wdt = devm_kzalloc(&pdev->dev, sizeof(*mtk_wdt), GFP_KERNEL);
+	mtk_wdt = devm_kzalloc(dev, sizeof(*mtk_wdt), GFP_KERNEL);
 	if (!mtk_wdt)
 		return -ENOMEM;
 
@@ -171,9 +172,9 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	mtk_wdt->wdt_dev.timeout = WDT_MAX_TIMEOUT;
 	mtk_wdt->wdt_dev.max_timeout = WDT_MAX_TIMEOUT;
 	mtk_wdt->wdt_dev.min_timeout = WDT_MIN_TIMEOUT;
-	mtk_wdt->wdt_dev.parent = &pdev->dev;
+	mtk_wdt->wdt_dev.parent = dev;
 
-	watchdog_init_timeout(&mtk_wdt->wdt_dev, timeout, &pdev->dev);
+	watchdog_init_timeout(&mtk_wdt->wdt_dev, timeout, dev);
 	watchdog_set_nowayout(&mtk_wdt->wdt_dev, nowayout);
 	watchdog_set_restart_priority(&mtk_wdt->wdt_dev, 128);
 
@@ -181,29 +182,13 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	mtk_wdt_stop(&mtk_wdt->wdt_dev);
 
-	err = watchdog_register_device(&mtk_wdt->wdt_dev);
+	watchdog_stop_on_reboot(&mtk_wdt->wdt_dev);
+	err = devm_watchdog_register_device(dev, &mtk_wdt->wdt_dev);
 	if (unlikely(err))
 		return err;
 
-	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
-			mtk_wdt->wdt_dev.timeout, nowayout);
-
-	return 0;
-}
-
-static void mtk_wdt_shutdown(struct platform_device *pdev)
-{
-	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
-
-	if (watchdog_active(&mtk_wdt->wdt_dev))
-		mtk_wdt_stop(&mtk_wdt->wdt_dev);
-}
-
-static int mtk_wdt_remove(struct platform_device *pdev)
-{
-	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&mtk_wdt->wdt_dev);
+	dev_info(dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
+		 mtk_wdt->wdt_dev.timeout, nowayout);
 
 	return 0;
 }
@@ -245,8 +230,6 @@ static const struct dev_pm_ops mtk_wdt_pm_ops = {
 
 static struct platform_driver mtk_wdt_driver = {
 	.probe		= mtk_wdt_probe,
-	.remove		= mtk_wdt_remove,
-	.shutdown	= mtk_wdt_shutdown,
 	.driver		= {
 		.name		= DRV_NAME,
 		.pm		= &mtk_wdt_pm_ops,
-- 
2.7.4

