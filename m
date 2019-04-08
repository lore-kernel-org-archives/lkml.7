Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09449C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF5C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U45ifiFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfDHTkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:40:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33620 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbfDHTkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:40:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so7896648pgh.0;
        Mon, 08 Apr 2019 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IPmXWb96ab6qvHWkVTNbeUB9IFTYvMvkFCL+VTS1Hvg=;
        b=U45ifiFbSifUd79X6Op6LKecZqFgNu18jChNk76xxt+LqYys3OkwUtdwWQiIckcA8b
         QPy3+67aqM5Mza3iPFXHqRgPxEnowWPmyK2CBKGBvNYZQWMl8343J1x701h/tTf32Ptx
         x1NgLbWyIjExOzENHyYk0YINIuk2i2uh65aktXPXBWSgFE0CRqRxGkbq7RaOth0hXh3b
         qMZQFDDBEv3a0pNsmIeHmN704/OEtcd28wc/ag1errGOuc1Hj1nIe0grU4mFkjCmkANo
         kRPbbAm96x93hLTzoNhY4c5iACRxLYN4Pmmx5ul3Th9v+kKzv6HN2iY7/r/PMnUoL9Tg
         WR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=IPmXWb96ab6qvHWkVTNbeUB9IFTYvMvkFCL+VTS1Hvg=;
        b=aWa4k08AK2X8RDgEA+ke8EwIKL/BWMjop7UNoKAc2sjUi+avzmZwFCmkhf4cvMoS5T
         hm40JUJe1JMmMzjk2cw5yQxSU1n1oChOV0XmU+GHdl70EhvwWSCEomyzi5yzcm8QZtZF
         gGZO6uNkDX579DpweQ0ioNFlCPCY9EWebv/M+aSCF7KOymoyxEX51OnGfBCS0BIJmnCR
         QJaWHzZr71oUgYIdHzw9PTIbGEL4on9D+oIjpjMhhXUy8Z9v+NcZqvwaRcn1wh0CC3Ii
         qn12gg6xWpM8l8PkX0kH81mh5u5jBckYpPIFnAezcPgia9ClgIx4pl2pYfKZ+2hK84Yu
         HpmQ==
X-Gm-Message-State: APjAAAVmLqwP5W8Y03fcZSe2cctqSdGGwtTpAz2F4T7Y7LlSAMidZGP1
        GClYobEWzshlif/wM7664f4=
X-Google-Smtp-Source: APXvYqyPBQI+qf55rCe5VGj8miavjJ6JUhNGY1HJlsVe5sZ4K7+UcwtckLX8oEtZKdxZ/NWwnYse5g==
X-Received: by 2002:aa7:9095:: with SMTP id i21mr31640467pfa.134.1554752401061;
        Mon, 08 Apr 2019 12:40:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g64sm70975351pfg.13.2019.04.08.12.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:40:00 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 17/22] watchdog: iTCO_wdt: Various improvements
Date:   Mon,  8 Apr 2019 12:38:41 -0700
Message-Id: <1554752326-13319-18-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various coccinelle driven transformations as detailed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use watchdog_stop_on_unregister to stop the watchdog on remove
- Drop assignments to otherwise unused variables
- Drop empty remove function

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/iTCO_wdt.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 0a5318b7865e..89cea6ce9a08 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -545,6 +545,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	}
 
 	watchdog_stop_on_reboot(&p->wddev);
+	watchdog_stop_on_unregister(&p->wddev);
 	ret = devm_watchdog_register_device(dev, &p->wddev);
 	if (ret != 0) {
 		pr_err("cannot register watchdog device (err=%d)\n", ret);
@@ -557,17 +558,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int iTCO_wdt_remove(struct platform_device *pdev)
-{
-	struct iTCO_wdt_private *p = platform_get_drvdata(pdev);
-
-	/* Stop the timer before we leave */
-	if (!nowayout)
-		iTCO_wdt_stop(&p->wddev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 /*
  * Suspend-to-idle requires this, because it stops the ticks and timekeeping, so
@@ -620,7 +610,6 @@ static const struct dev_pm_ops iTCO_wdt_pm = {
 
 static struct platform_driver iTCO_wdt_driver = {
 	.probe          = iTCO_wdt_probe,
-	.remove         = iTCO_wdt_remove,
 	.driver         = {
 		.name   = DRV_NAME,
 		.pm     = ITCO_WDT_PM_OPS,
-- 
2.7.4

