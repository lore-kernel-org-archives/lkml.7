Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775BF206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYGZRtP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfDJQ2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:28:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37306 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfDJQ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:28:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so1737093ply.4;
        Wed, 10 Apr 2019 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y3q0kgdoTOk/eYTK2ErICl6tYKEu68Zi7htktucMeOA=;
        b=SYGZRtP85ydvrBfzCxF3iJZJkmnJCQuMpxv6Ziq4bMU2tmZ+dORYAzFK2kBV24ssFk
         AXAWhIZh79xPKCfoWdAZlWzvjMUbl6Z836KZdh7xBAyzccE+2YX34BMjzcpONPFdqRxc
         OEoiMFdrn6RhEBs6LXCOXQ1oDc/+/qhtZx+4qj5Hlz9fkOSfhHdj2/1J7InBg44FJu8o
         FpsYvJBDBbG/Muu8A5gYk3d7IkYnxNx36v4Qrhe+Y0Y6TlzCRUCzzthUHRiEseQsectq
         wuab7nhI+msT6rYCJrXhIitVikO0XcCWblLjt4c5NTHKH5rvO8pElMuJhV4W80ab+Ar+
         tsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Y3q0kgdoTOk/eYTK2ErICl6tYKEu68Zi7htktucMeOA=;
        b=crva7mcpSaisBMVd1tlKiwReT4qGLV2gp6UbR2yfsVSYgMXfkKA6QI0iwLiNUtMVAs
         sPqVGaBIVwwv+KR8vVjanJrGTGJHB9Er0WfV4dHm4MjozybA41CP5SK0LCNH4uzpwtUo
         /Ev44BweppSQXhbuD2OVRJ0Lmpu1IMVQbopd4VIeyiQs7SurQtgBo4UUBCHtNm7vXDZ0
         1hU+zdGsOQ7zCULJ+RuAuWirtSPpiwBS3vBEkfWfttPACU7iohOSXlEcPTZzH7pVhX1V
         zX8/XlF1OTOCPEPVXppK2514EL7gKwn6zkvMMqRIB2+t12v0uTnZWS7F9HawTwPc5T43
         Xr5w==
X-Gm-Message-State: APjAAAVRT84RPG2KrIQ7ZRcpVV3WXPoAkaFkPPHxZBaHQhq2/4Ggenx7
        giCNTF7Ivo51tgEjHkPSVschNbNm
X-Google-Smtp-Source: APXvYqwresMKhaadD1wyYs5Vx35MBq8gOEU1GAguLyQ7xLsPtnH2nYJUdtAIeLbre3JnscHerOMYNg==
X-Received: by 2002:a17:902:b597:: with SMTP id a23mr43264926pls.284.1554913717080;
        Wed, 10 Apr 2019 09:28:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t82sm97448554pfa.153.2019.04.10.09.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:28:36 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 21/22] watchdog: mpc8xxx_wdt: Convert to use device managed functions and other improvements
Date:   Wed, 10 Apr 2019 09:28:02 -0700
Message-Id: <1554913683-25454-22-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
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
  This also drops the inaccurate message on remove; the driver won't be
  removed if the hardware watchdog is running, no matter if the watchdog
  device is open or not.
- Use local variable 'struct device *dev' consistently
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mpc8xxx_wdt.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 3b5b446b690c..9b6d6a5a27ad 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -204,9 +204,10 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	if (ddata->wdd.timeout < ddata->wdd.min_timeout)
 		ddata->wdd.timeout = ddata->wdd.min_timeout;
 
-	ret = watchdog_register_device(&ddata->wdd);
+	ret = devm_watchdog_register_device(dev, &ddata->wdd);
 	if (ret) {
-		dev_err(dev, "cannot register watchdog device (err=%d)\n", ret);
+		dev_err(dev, "cannot register watchdog device (err=%d)\n",
+			ret);
 		return ret;
 	}
 
@@ -218,17 +219,6 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
-{
-	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
-
-	dev_crit(&ofdev->dev, "Watchdog removed, expect the %s soon!\n",
-		 reset ? "reset" : "machine check exception");
-	watchdog_unregister_device(&ddata->wdd);
-
-	return 0;
-}
-
 static const struct of_device_id mpc8xxx_wdt_match[] = {
 	{
 		.compatible = "mpc83xx_wdt",
@@ -259,7 +249,6 @@ MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
 
 static struct platform_driver mpc8xxx_wdt_driver = {
 	.probe		= mpc8xxx_wdt_probe,
-	.remove		= mpc8xxx_wdt_remove,
 	.driver = {
 		.name = "mpc8xxx_wdt",
 		.of_match_table = mpc8xxx_wdt_match,
-- 
2.7.4

