Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C331C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D39D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIK46fsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfDHTjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41457 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfDHTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so8206851pfd.8;
        Mon, 08 Apr 2019 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLZWoglaHpenSl2BSHPcSajCjhQskwq7KOznv+AB9hQ=;
        b=YIK46fsThrj89x1NgCCmjcgIQWAkmKUaXF+QMCneAMPTflM95ST0ulTKCzPLh8mKZc
         pnUbX2O8MyZJdPUJ0YvY+SbBY58ClOuizmIWcFXVlv+MtFUwO5zw6UJNIqF5ji1yCS9D
         ApGAtwsk8/UwdCDbhyjVmZQ1+RuknbAwpUkOLtEPktoO8PZ8IzdfXjc2KyeUrKY9bUO/
         7sucP2i7VWdR3qzJmIbRVO0AVv6Irc/5GbakUVb5ycgFXf3qOXnJZEEiRgYBpmxCfLVt
         +ooUJcOneFtBBVqfeDnp3h0+dpfxgPoAgEXeG+d5N09+ljgcbCFXMCyML6o9A/VpyH4a
         V8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sLZWoglaHpenSl2BSHPcSajCjhQskwq7KOznv+AB9hQ=;
        b=Ebe1ixZzLfg3E4zHU8vut6uZfTSTd0s71PkPJTj+Tco0CkzvlTI2p6/XkgZF7k72Gs
         RMf1AmqczQLUe+AXEyYjkUNm8XwHI6W2+AYijgBGQoWKSqGHJkHttkgrbBgffbWg9Nil
         UzWsPu/xHZaHLSHbPAdHIQBpQ8ERazJco2XNlCUtkLG1zpp1wPeKonDE06vPDtOblgaE
         z1BX1IUTVVhHyngow1kw0oCKnOMvFXoRRuwrcd8MS4DiKAB7+0FDUO/o98pQjlG0Y8dl
         u/5/3a6v1UfbQ0q0ueS9D/7F1/xbXt7hOoXPszIVKuXnbyIdcbXF0zZHrN0xEvp9vEAp
         VfRA==
X-Gm-Message-State: APjAAAUwszT/QeMamFYvIW96ko5so0CqUy/lxTmW4hQ1wKKJKEq7yiJ4
        CQjJssZcJpLlBav85q1xe8M=
X-Google-Smtp-Source: APXvYqzwNBx8JMyKR0M/FLo+aFaFrbzYZe2Nhz9Nr02BXWQTgAGekWQa94t69mZgu+ghrPJmQzzctA==
X-Received: by 2002:a63:6a45:: with SMTP id f66mr28876087pgc.7.1554752384264;
        Mon, 08 Apr 2019 12:39:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17sm70509493pfw.65.2019.04.08.12.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:43 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 05/22] watchdog: bcm2835_wdt: drop platform_set_drvdata
Date:   Mon,  8 Apr 2019 12:38:29 -0700
Message-Id: <1554752326-13319-6-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no call to platform_get_drvdata() in the driver,
so platform_set_drvdata() is unnecessary and can be dropped.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm2835_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 1834524ae373..560c1c54c177 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -177,7 +177,6 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	wdt = devm_kzalloc(dev, sizeof(struct bcm2835_wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
-	platform_set_drvdata(pdev, wdt);
 
 	spin_lock_init(&wdt->lock);
 
-- 
2.7.4

