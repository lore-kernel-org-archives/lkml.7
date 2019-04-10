Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBDEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC6206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiLoy+uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbfDJQ2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45066 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387813AbfDJQ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so1841775pgk.12;
        Wed, 10 Apr 2019 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3medKjGV47ZOPN+yjhvR37qQjE3neDO4pCs+uQdUuow=;
        b=SiLoy+uv58kts4jBEs48iVumvE/HLvagIxBjXPUYtsQfKZqe5qcnM2+ig+ooKiSkFn
         E4gpQViNBSDQtQ3aI6Vg3lsVguei+TftF02nCcUy4IaSZxkddkgNWK3cE8B5RxAHiGZW
         OcmAx99CJ8QpL+kLOikMEi0fGtQmjAwAnjDrg5Jx3Ju1Ui9wOJ/bYaVEplEIwAP1+8/r
         uI54dkYcR8NQZZY/prbkdhUPq78mEmIm7P+s6jKZl8LtSQCAP7cIwMHyBq+WgZCvVGQ0
         AMtmTqXU/jnAiQcDL9vgJzxmHng+xOSEx2h9y0FoYaXvd5u9OFQjP9KSLreNQ389k1ng
         fBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3medKjGV47ZOPN+yjhvR37qQjE3neDO4pCs+uQdUuow=;
        b=VEN6hN7Mh5K4kNiLMsusNXgX1qiV3Mzkg0o6yeimR38zBta6g8PM4hJR84gHoQM6q6
         S77eWxjKUCvbT0/6/37kYcuRqjEwXoeHisxwM4DEcvDEILHPfo98NUL28PzEfvBL4Zek
         CzbKm1cQL8XA6GP13y27yUX6UK/foN5IZYnp+KJ32eUSp3U/Ct4IRm12bqkRI5NUT702
         a4XdC/w9J4UDLFgD645i8ysKGgcMVYpH92s4F4u0m/3QcoyiY1kWHUNBD9zPFo8HiHn5
         JR6WSupG/HmJtQd+sgg+SXhrY0BGvIJoTQUZoSlQ5hXC/QIz/66/6lqWJTkqv+KBLoNa
         UjEQ==
X-Gm-Message-State: APjAAAV/JVnt/tsrcydxkVSpyaOAmhpVxOJRbWCnZGM378C/8fE/5bbJ
        RBFuSUS5tSclFJkrq5lkAksw1aVW
X-Google-Smtp-Source: APXvYqwMD17pV8HqfUE8FecYaD+ZJ4CqA71db2mZ8Z139UVyRSd5PdhoUU73zQHncAnoHK1ZOvBzoA==
X-Received: by 2002:a63:6849:: with SMTP id d70mr41635996pgc.21.1554913693429;
        Wed, 10 Apr 2019 09:28:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k124sm61321660pgc.65.2019.04.10.09.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:12 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/22] watchdog: ts72xx_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Wed, 10 Apr 2019 09:27:45 -0700
Message-Id: <1554913683-25454-5-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/ts72xx_wdt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 3aa11c84dea9..bf918f5fa131 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -122,11 +122,12 @@ static const struct watchdog_ops ts72xx_wdt_ops = {
 
 static int ts72xx_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct ts72xx_wdt_priv *priv;
 	struct watchdog_device *wdd;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -143,20 +144,20 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &ts72xx_wdt_ops;
 	wdd->min_timeout = 1;
 	wdd->max_hw_heartbeat_ms = 8000;
-	wdd->parent = &pdev->dev;
+	wdd->parent = dev;
 
 	watchdog_set_nowayout(wdd, nowayout);
 
 	wdd->timeout = TS72XX_WDT_DEFAULT_TIMEOUT;
-	watchdog_init_timeout(wdd, timeout, &pdev->dev);
+	watchdog_init_timeout(wdd, timeout, dev);
 
 	watchdog_set_drvdata(wdd, priv);
 
-	ret = devm_watchdog_register_device(&pdev->dev, wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
 		return ret;
 
-	dev_info(&pdev->dev, "TS-72xx Watchdog driver\n");
+	dev_info(dev, "TS-72xx Watchdog driver\n");
 
 	return 0;
 }
-- 
2.7.4

