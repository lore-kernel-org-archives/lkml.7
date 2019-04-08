Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE42CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD56D20863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMQO4d+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfDHTjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36867 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfDHTjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so7918289ply.4;
        Mon, 08 Apr 2019 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IAzbxkJlpTQ2aw4GmH8bUwHqrx58SWUqD0TKIw07vIM=;
        b=AMQO4d+l1S3uvkKrlHtSrlCMAbtDbeySQL1pX7CC5U0gWnuUDX6TQBbYVVn9I2gI82
         9/+EulQerD50YUabYbmTcza7T3vebvxJly62KOBi5mP+E5CHSA/kDHZ5n8l3k5/VFEgp
         WhyZu5vCkNN/4BLv6mqaj1/yXcr9SHgkRunOJ/kY21u3ncbCdrzjHXIFBGKRPMGCyvJ3
         aufT35+4kQppms44VGOR3St8ah5ItogttPi//4GDYfuCKw48NDEFeKwteZAsfqEV4xJF
         Z69Y0jYdDUtpbxo8KQCpRFt8nQzi3lxjYvvXMVF7DPc0YlSPUxJ+i+VRpLZeuuorBGS8
         MTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=IAzbxkJlpTQ2aw4GmH8bUwHqrx58SWUqD0TKIw07vIM=;
        b=Fzgo6v4zb7SgYtWG2zkBmLu7UGUWDlYFf+u29w5g+xH7qhA08cfO2Ym8hCoRcCwJCV
         EW8jIDA6POLtBxJ37xA/fTWA9wf5WCaUT/1fA8348bv9ZRV1r7G4EaIaIZCTvrrJL228
         FsXSR42IzpKY9eb2by+D6Omeec1xnqoC5Kmk618W4MctnnEpWG/nohBG8UzvzyfU7INP
         K3nmQOt4v8zWgSaM1SrUf8vidpYYVdIeoB16Y0Puk2vIxGhkNLzXeusmppqn7ioxuwTr
         QoWO7U4UDwAUdoT+Zxil87CISW0ecVxw5thRdOnTqXrkXh2cm01gUZLCTMTWhCBtcyD3
         XeGQ==
X-Gm-Message-State: APjAAAURIZihdg9E3RIFqmp/xm2338ajmYriVUZrL73soQvXIDT0Zl8i
        NHUPRltxWw3b28X65ESnk+g=
X-Google-Smtp-Source: APXvYqy7XEMnu428nXuTVmDPQPk8Y7+bsYzitSMxqPpNU3hvN5iT+Pz+BSWTwTd/Av/Q8Wgo0e2xIQ==
X-Received: by 2002:a17:902:1124:: with SMTP id d33mr7821386pla.268.1554752391318;
        Mon, 08 Apr 2019 12:39:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z20sm42163181pgf.70.2019.04.08.12.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:50 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 10/22] watchdog: da9055_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Mon,  8 Apr 2019 12:38:34 -0700
Message-Id: <1554752326-13319-11-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/da9055_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 26a5b2984094..389a4bdd208c 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -119,13 +119,13 @@ static const struct watchdog_ops da9055_wdt_ops = {
 
 static int da9055_wdt_probe(struct platform_device *pdev)
 {
-	struct da9055 *da9055 = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct da9055 *da9055 = dev_get_drvdata(dev->parent);
 	struct da9055_wdt_data *driver_data;
 	struct watchdog_device *da9055_wdt;
 	int ret;
 
-	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
-				   GFP_KERNEL);
+	driver_data = devm_kzalloc(dev, sizeof(*driver_data), GFP_KERNEL);
 	if (!driver_data)
 		return -ENOMEM;
 
@@ -136,17 +136,17 @@ static int da9055_wdt_probe(struct platform_device *pdev)
 	da9055_wdt->timeout = DA9055_DEF_TIMEOUT;
 	da9055_wdt->info = &da9055_wdt_info;
 	da9055_wdt->ops = &da9055_wdt_ops;
-	da9055_wdt->parent = &pdev->dev;
+	da9055_wdt->parent = dev;
 	watchdog_set_nowayout(da9055_wdt, nowayout);
 	watchdog_set_drvdata(da9055_wdt, driver_data);
 
 	ret = da9055_wdt_stop(da9055_wdt);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to stop watchdog, %d\n", ret);
+		dev_err(dev, "Failed to stop watchdog, %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_watchdog_register_device(&pdev->dev, &driver_data->wdt);
+	ret = devm_watchdog_register_device(dev, &driver_data->wdt);
 	if (ret != 0)
 		dev_err(da9055->dev, "watchdog_register_device() failed: %d\n",
 			ret);
-- 
2.7.4

