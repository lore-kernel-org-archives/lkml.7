Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F380EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE305222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfDSSQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:16:55 -0400
Received: from sauhun.de ([88.99.104.3]:50570 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfDSSQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:18 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id 434E42E35C8;
        Fri, 19 Apr 2019 20:16:17 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/16] watchdog: xen_wdt: drop warning after calling watchdog_init_timeout
Date:   Fri, 19 Apr 2019 20:16:00 +0200
Message-Id: <20190419181601.7412-16-wsa+renesas@sang-engineering.com>
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
 drivers/watchdog/xen_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index f1c016d015b3..d54da2e0f2e1 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -135,9 +135,7 @@ static int xen_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (watchdog_init_timeout(&xen_wdt_dev, timeout, NULL))
-		dev_info(&pdev->dev, "timeout value invalid, using %d\n",
-			xen_wdt_dev.timeout);
+	watchdog_init_timeout(&xen_wdt_dev, timeout, NULL);
 	watchdog_set_nowayout(&xen_wdt_dev, nowayout);
 	watchdog_stop_on_reboot(&xen_wdt_dev);
 	watchdog_stop_on_unregister(&xen_wdt_dev);
-- 
2.11.0

