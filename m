Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B23C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B3206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkPqN11s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbfDJQ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45710 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387812AbfDJQ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so1716845plb.12;
        Wed, 10 Apr 2019 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t3iZkPj/7QCSXgrBm7/GlIk+twTdtIQx1Nhm2nRrQHg=;
        b=tkPqN11s969TlYPx3VFZ2A3McPaHTkOy4MsIFU1DOC+BsBvlSipzYD7wELfzaw7s9I
         j1slMpZIvPm5+VQN7qc2eZWKjb+duuGvPnUa/Pf8S1haN4xfXnuiNHrtpJVq53S2iXTz
         V5sCdIFZOkYN/Lm31o0Koms+2Y0yFpDgOV2OdHpDSqVfimblpGHDXRlIkEItua4PLCF/
         o6l98JmnG13/VmX+8yHbZLPjvMdztrnidV1uZb0BUu4WmoJOnAORT8gq1Sii87jkq1NM
         ieTedG9TT0XM4ZxCodZ9b8Wk6M7tqDpH8MDKsatEdkc+A31ayneXjzQ1jJVzkdX/C2ne
         8VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=t3iZkPj/7QCSXgrBm7/GlIk+twTdtIQx1Nhm2nRrQHg=;
        b=LVxljmFy7xM+Jr8e5wd6hFrSQTPoSRu73hdCFgVs53LHTekJfFL5aEN8MjsHctjHMc
         JL9T6sjVbwCCjicJhCjnKYENbg/G569YbyK55/aq0X7OTpt62U01w8KzmisrX6Go8xW1
         vKXAPxrDUUe4uxGJVG/LWwAqlzD218QFqLZkG03HKzHF4sLnfmLoQfodUg+HW8VO2PDB
         a2cm+NCbzYmKWzowLwIXDhSiYd82zR+BEDT+jzlMsqm8tZX0wk3N12dxk33+Lcx7KiAj
         4ZH+qbWFqOJ3gvkwbLCajiSMCtSFMHk1OmRARGkvsOErB5iLCALwucWc74UhgScMN6IV
         pseg==
X-Gm-Message-State: APjAAAVuEHdoBO2tWaFLL3K3RbkxSyNN3v0/tbeUqQx7sk2D/Bm/uWAz
        3/znB1BHs/5nHV2M6a1Soac=
X-Google-Smtp-Source: APXvYqxeklMPCnCSirHPjI0gup8IyZvEBoC+EMNKwfezsgxQfVBeWhDJfQQ2v+f/wRAJoCNE6sQu0Q==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr19938275plr.185.1554913690705;
        Wed, 10 Apr 2019 09:28:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m25sm49166154pfa.175.2019.04.10.09.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:10 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/22] watchdog: tqmx86_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Wed, 10 Apr 2019 09:27:43 -0700
Message-Id: <1554913683-25454-3-git-send-email-linux@roeck-us.net>
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
 drivers/watchdog/tqmx86_wdt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/tqmx86_wdt.c b/drivers/watchdog/tqmx86_wdt.c
index 52941207a12a..72d0b0adde38 100644
--- a/drivers/watchdog/tqmx86_wdt.c
+++ b/drivers/watchdog/tqmx86_wdt.c
@@ -70,11 +70,12 @@ static struct watchdog_ops tqmx86_wdt_ops = {
 
 static int tqmx86_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct tqmx86_wdt *priv;
 	struct resource *res;
 	int err;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -82,14 +83,13 @@ static int tqmx86_wdt_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 
-	priv->io_base = devm_ioport_map(&pdev->dev, res->start,
-					resource_size(res));
+	priv->io_base = devm_ioport_map(dev, res->start, resource_size(res));
 	if (!priv->io_base)
 		return -ENOMEM;
 
 	watchdog_set_drvdata(&priv->wdd, priv);
 
-	priv->wdd.parent = &pdev->dev;
+	priv->wdd.parent = dev;
 	priv->wdd.info = &tqmx86_wdt_info;
 	priv->wdd.ops = &tqmx86_wdt_ops;
 	priv->wdd.min_timeout = 1;
@@ -97,16 +97,16 @@ static int tqmx86_wdt_probe(struct platform_device *pdev)
 	priv->wdd.max_hw_heartbeat_ms = 4096*1000;
 	priv->wdd.timeout = WDT_TIMEOUT;
 
-	watchdog_init_timeout(&priv->wdd, timeout, &pdev->dev);
+	watchdog_init_timeout(&priv->wdd, timeout, dev);
 	watchdog_set_nowayout(&priv->wdd, WATCHDOG_NOWAYOUT);
 
 	tqmx86_wdt_set_timeout(&priv->wdd, priv->wdd.timeout);
 
-	err = devm_watchdog_register_device(&pdev->dev, &priv->wdd);
+	err = devm_watchdog_register_device(dev, &priv->wdd);
 	if (err)
 		return err;
 
-	dev_info(&pdev->dev, "TQMx86 watchdog\n");
+	dev_info(dev, "TQMx86 watchdog\n");
 
 	return 0;
 }
-- 
2.7.4

