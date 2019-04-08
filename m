Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB1C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AC920863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DII4ZdIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfDHTju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:39:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41295 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfDHTjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:39:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so7913600plj.8;
        Mon, 08 Apr 2019 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n8M7yZS77yDr2htBbKlSnEeLAu95sbQ1FVJ5Vh9oVR4=;
        b=DII4ZdINVbIl4RxxRaT/0s9IA86LqanNMtYrR4S7m/0fD3U9AD353pEGYuo0NVUpJN
         O697luZEe1imkuofChHARthyNkS86/RV5CrKSeZxfcTrxqj6RSyJqw540ogOu63z1cmB
         TR91T2qywPs6WT7eewbxa0q5yLq1ZywPllo+UdHdU+a5MymjWzTDUFTySx0E9yz7fjMc
         6klTQHqvYiVbMVef8NQK4lQEHH/pYK8djWNDh7qrNltODLIlOvYshl0kn34/2/irXYnG
         eR6Q7es4Qa0mjUVDoGWoYw+CU4UsmF8Uef6DNqIBzznanVi2jzcgFtScBs4+8l1d8PHC
         Gv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=n8M7yZS77yDr2htBbKlSnEeLAu95sbQ1FVJ5Vh9oVR4=;
        b=Qeb7w0L0n886IjtG1dV3f/CAkA3Hf554sPC+IGNZFY32cAs2bR0jPL4+JI4mRTfCEe
         uTthggiD2/KxWNjljjly0uLA1hc/Sdq57FwT7jXQZboe3/q44kIOLt6RLKhHMeprTpHj
         5Kdth6wess7YYgNV51Wvu8+rX7JUNkAr2qesvTVdMjUYqn3/b2J9PvpA+B7JuHGnKQHw
         Qdx4NrdlnLTLhIb5zsHcQ3x2r0Rc/jyVcrvc25yH7DzCHrQiTKfTkoLqKODk22l52EtI
         KgfuQkuRqtlvOLkrLf7PHvqmSupsFLwWcgwUIjM4yREACZ4eZY2RC/0CBMWZxzPBoEYQ
         VMmg==
X-Gm-Message-State: APjAAAVlPTg3ewsWw/tl/+1aHpIHHOww76XNjkT7HXRAgeYImxrcHHhB
        HWpi/iWQFkph4flGHUscLzI=
X-Google-Smtp-Source: APXvYqzF1Qz+0o+N/KCYwo3uzL1Fuu8qWi75fCwj3Wadyb2+eRHk2ObZbn/0/MGICbDfwgldiolfIg==
X-Received: by 2002:a17:902:5a2:: with SMTP id f31mr31037240plf.119.1554752387258;
        Mon, 08 Apr 2019 12:39:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 19sm34964251pga.88.2019.04.08.12.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:39:46 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 07/22] watchdog: bcm_kona_wdt: Convert to use device managed functions and other improvements
Date:   Mon,  8 Apr 2019 12:38:31 -0700
Message-Id: <1554752326-13319-8-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
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

- Use local variable 'struct device *dev' consistently
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm_kona_wdt.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index d52334ab0805..e2ad44816359 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -271,11 +271,6 @@ static struct watchdog_device bcm_kona_wdt_wdd = {
 	.timeout =	SECWDOG_MAX_COUNT >> SECWDOG_DEFAULT_RESOLUTION,
 };
 
-static void bcm_kona_wdt_shutdown(struct platform_device *pdev)
-{
-	bcm_kona_wdt_stop(&bcm_kona_wdt_wdd);
-}
-
 static int bcm_kona_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -301,7 +296,7 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
-	bcm_kona_wdt_wdd.parent = &pdev->dev;
+	bcm_kona_wdt_wdd.parent = dev;
 
 	ret = bcm_kona_wdt_set_timeout_reg(&bcm_kona_wdt_wdd, 0);
 	if (ret) {
@@ -309,7 +304,9 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = watchdog_register_device(&bcm_kona_wdt_wdd);
+	watchdog_stop_on_reboot(&bcm_kona_wdt_wdd);
+	watchdog_stop_on_unregister(&bcm_kona_wdt_wdd);
+	ret = devm_watchdog_register_device(dev, &bcm_kona_wdt_wdd);
 	if (ret) {
 		dev_err(dev, "Failed to register watchdog device");
 		return ret;
@@ -324,8 +321,6 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 static int bcm_kona_wdt_remove(struct platform_device *pdev)
 {
 	bcm_kona_wdt_debug_exit(pdev);
-	bcm_kona_wdt_shutdown(pdev);
-	watchdog_unregister_device(&bcm_kona_wdt_wdd);
 	dev_dbg(&pdev->dev, "Watchdog driver disabled");
 
 	return 0;
@@ -344,7 +339,6 @@ static struct platform_driver bcm_kona_wdt_driver = {
 		  },
 	.probe = bcm_kona_wdt_probe,
 	.remove = bcm_kona_wdt_remove,
-	.shutdown = bcm_kona_wdt_shutdown,
 };
 
 module_platform_driver(bcm_kona_wdt_driver);
-- 
2.7.4

