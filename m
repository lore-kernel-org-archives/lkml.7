Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF4C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB797222EA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfDSSRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:17:24 -0400
Received: from sauhun.de ([88.99.104.3]:50570 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfDSSQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:15 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id 713602E35C3;
        Fri, 19 Apr 2019 20:16:14 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/16] watchdog: nic7018_wdt: drop warning after calling watchdog_init_timeout
Date:   Fri, 19 Apr 2019 20:15:55 +0200
Message-Id: <20190419181601.7412-11-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
References: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core will print out details now.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/nic7018_wdt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/nic7018_wdt.c b/drivers/watchdog/nic7018_wdt.c
index dcd265685837..82843abe38f8 100644
--- a/drivers/watchdog/nic7018_wdt.c
+++ b/drivers/watchdog/nic7018_wdt.c
@@ -211,10 +211,7 @@ static int nic7018_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(wdd, wdt);
 	watchdog_set_nowayout(wdd, nowayout);
-
-	ret = watchdog_init_timeout(wdd, timeout, dev);
-	if (ret)
-		dev_warn(dev, "unable to set timeout value, using default\n");
+	watchdog_init_timeout(wdd, timeout, dev);
 
 	/* Unlock WDT register */
 	outb(UNLOCK, wdt->io_base + WDT_REG_LOCK);
-- 
2.11.0

