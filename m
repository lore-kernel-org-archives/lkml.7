Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A033C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F3820830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8tHrCHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbfDJQ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:29:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41627 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387925AbfDJQ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so1736153plj.8;
        Wed, 10 Apr 2019 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tR/tgWi0NWu/p8jUty40o4OgX03BGJEy7JzWJugTrTg=;
        b=l8tHrCHyh+IqMwRszJzBwTaDmzvJKoNJ+URalOMbDC3tvrW/bV25yFooCf1BzdDd8b
         /F/zQuupt3JljsBgfTuXXGPFwtqrmO4cUAsLBrMyBc4RQF//9JJr0d95N2lmnD4bJOgg
         6lAbjwGwohr7gH3DDbpqFu7T4gqN5NEVMHipmSKPy0P366huTIk0+GjLXakVqMh0reu3
         ZOW23PU9JfzgsX9/KFwgh+Y+Obil7r7HFYQOHA3p2B/n0z9WU0tZjWi/JvD39FZ1YYh5
         xuf/8/XBRQywJ4bFr7cLAcG2UYNjK27jVQvwIEYoX+k0+72SmyDd8isrNLbOuXaMcCPJ
         yb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=tR/tgWi0NWu/p8jUty40o4OgX03BGJEy7JzWJugTrTg=;
        b=hPH01HhAZSS9DQuK+GWuRNX9jNM3VB47PjAbv2rKjGeKaJ1MAuijIX076BuM0nH5s2
         EL1I2GQPYNP97kumq8bUYSjUOW+mgU5L/dMsg1W79oZZqs/6F3InA/C/DW2CTltJr5si
         g8L1lPJP8woeQQ9oJH4881dVcKhzsJnmCAsuI6QRh2Fb6xZeUCrfbmyvU1cvC5nhq2I9
         PzqymSnV38aNYH7hx/2cHUnSfndoCsfmPxE0a9ImKGQLJywOuB+twvFqtpx0TJwHU+EQ
         mq5Cz7NUOSED1ZFDZKBEA1V2Ybb2DTm+pYGhLtW0wWK/UrNfMkG7Xx7e0ELrm+hgorX+
         3sCA==
X-Gm-Message-State: APjAAAVi9XrQBRS0BwmDq0AmBM2EeMwZJODf2VV1MjCiqHxmloWpYz4+
        OlUBfCql0xBhbtOww5urtMc=
X-Google-Smtp-Source: APXvYqwJlYL+IfVOaai2ytLp+SH6HMDh9ZjHEEpEf7GoE87eBMjFLOfgam1WiYIfk0AXWgxR4hrqKQ==
X-Received: by 2002:a17:902:7d81:: with SMTP id a1mr44620383plm.202.1554913712767;
        Wed, 10 Apr 2019 09:28:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm44583797pgz.3.2019.04.10.09.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:32 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 18/22] watchdog: mt7621_wdt: Use 'dev' instead of dereferencing it repeatedly
Date:   Wed, 10 Apr 2019 09:27:59 -0700
Message-Id: <1554913683-25454-19-git-send-email-linux@roeck-us.net>
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

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mt7621_wdt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 9c943f1d57ec..cbb3c0dde136 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -133,18 +133,19 @@ static struct watchdog_device mt7621_wdt_dev = {
 
 static int mt7621_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	mt7621_wdt_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mt7621_wdt_base))
 		return PTR_ERR(mt7621_wdt_base);
 
-	mt7621_wdt_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	mt7621_wdt_reset = devm_reset_control_get_exclusive(dev, NULL);
 	if (!IS_ERR(mt7621_wdt_reset))
 		reset_control_deassert(mt7621_wdt_reset);
 
 	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
 
 	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
-			      &pdev->dev);
+			      dev);
 	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
 	if (mt7621_wdt_is_running(&mt7621_wdt_dev)) {
 		/*
@@ -161,7 +162,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &mt7621_wdt_dev.status);
 	}
 
-	return devm_watchdog_register_device(&pdev->dev, &mt7621_wdt_dev);
+	return devm_watchdog_register_device(dev, &mt7621_wdt_dev);
 }
 
 static void mt7621_wdt_shutdown(struct platform_device *pdev)
-- 
2.7.4

