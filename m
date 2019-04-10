Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC09C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB8220830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAV+KB4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbfDJQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44681 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387860AbfDJQ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so1845033pgj.11;
        Wed, 10 Apr 2019 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jsfm7LCM8d51wy7QbSzyHhCcp61nfHGejXB4g2c1IIg=;
        b=PAV+KB4V+Qdx5iBwU9mDMigyahZjt2ONZB466UKGbiP1Tps2IgtM6SyRuUfi/LRqAL
         Kkwtw9mOBIOKkG+n644tALN6WTyGbseCF+L7FYOgVCvKEtCL9LyKAEEKPGw7tGJCoKhu
         ak5xdwvYMggVsEq4JzD0OoOKm0QNVZ8MIKjwPuO48quSZZht2S/YLa4ZUL91rIn8Sj+W
         YXoEssAQWpOn1EEDGnGDfeA3NGeTh3GOjfl+nUpMoo7jxEesdmY+AKfXFkF27i9XHcC3
         whiUl2dvexLxyVaECrvRBIOB89Ymwrmfb/PfkItHEObZI7uXBCUJpysRElf0IYi8YKhz
         aCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=jsfm7LCM8d51wy7QbSzyHhCcp61nfHGejXB4g2c1IIg=;
        b=gK9o+VEAToxWNHKhx8JswjyItx5MJcLc6RDXBN2j6+WNwrUQJlTXK4uBDSRPXAw6W2
         Wq/+lXUCa+WUbPagdivPC89xBLoYIaAWZQjAtSYn56hg+8Gv38i22Rd+HedwK5wo64Ry
         W74wjyDFnwRNcoOj8lGZlBazAqkS+RBtMT7e77vjRZiRvhC5NtuX8kwrQXqzFh2y5T0o
         j+jGBQj+qiFxagrq7CBg6NYnHP5acOpnoYd6banfyEcS1eUIWH/i/iEpt3vr3uY9hNUB
         OouUcNittmsdFX4f7o2mnP2f2trzGOr33QddYcOB81/FVIDxU/nRaIGAgh9pkj7cXJHk
         +dcA==
X-Gm-Message-State: APjAAAUE0w/An/nRYj5J5OCn5RcNHHMSUMzFcO1GBdDimHH0xcaIW6F4
        xs76M829/tY/xd3ciSAobHM=
X-Google-Smtp-Source: APXvYqwUhKNJ3dcspIyvPvRpxMPpqAqydynO+j7OTMauoosZ3rLfU6wCV8kAATbFLPAd7bcVJCaBlA==
X-Received: by 2002:a65:5304:: with SMTP id m4mr41319400pgq.281.1554913702000;
        Wed, 10 Apr 2019 09:28:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d38sm42024691pgd.40.2019.04.10.09.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:21 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 10/22] watchdog: imx_sc_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Wed, 10 Apr 2019 09:27:51 -0700
Message-Id: <1554913683-25454-11-git-send-email-linux@roeck-us.net>
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

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/imx_sc_wdt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
index 86c2722f2a09..d154f66e659a 100644
--- a/drivers/watchdog/imx_sc_wdt.c
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -101,10 +101,11 @@ static const struct watchdog_info imx_sc_wdt_info = {
 
 static int imx_sc_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct watchdog_device *imx_sc_wdd;
 	int ret;
 
-	imx_sc_wdd = devm_kzalloc(&pdev->dev, sizeof(*imx_sc_wdd), GFP_KERNEL);
+	imx_sc_wdd = devm_kzalloc(dev, sizeof(*imx_sc_wdd), GFP_KERNEL);
 	if (!imx_sc_wdd)
 		return -ENOMEM;
 
@@ -114,19 +115,19 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
 	imx_sc_wdd->ops = &imx_sc_wdt_ops;
 	imx_sc_wdd->min_timeout = 1;
 	imx_sc_wdd->max_timeout = MAX_TIMEOUT;
-	imx_sc_wdd->parent = &pdev->dev;
+	imx_sc_wdd->parent = dev;
 	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;
 
-	ret = watchdog_init_timeout(imx_sc_wdd, 0, &pdev->dev);
+	ret = watchdog_init_timeout(imx_sc_wdd, 0, dev);
 	if (ret)
-		dev_warn(&pdev->dev, "Failed to set timeout value, using default\n");
+		dev_warn(dev, "Failed to set timeout value, using default\n");
 
 	watchdog_stop_on_reboot(imx_sc_wdd);
 	watchdog_stop_on_unregister(imx_sc_wdd);
 
-	ret = devm_watchdog_register_device(&pdev->dev, imx_sc_wdd);
+	ret = devm_watchdog_register_device(dev, imx_sc_wdd);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register watchdog device\n");
+		dev_err(dev, "Failed to register watchdog device\n");
 		return ret;
 	}
 
-- 
2.7.4

