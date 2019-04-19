Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981C0C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB2F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfDSSZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:25:39 -0400
Received: from sauhun.de ([88.99.104.3]:50556 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfDSSQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:12 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id 15C052E358C;
        Fri, 19 Apr 2019 20:16:11 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/16] watchdog: cadence_wdt: still probe if user supplied timeout is invalid
Date:   Fri, 19 Apr 2019 20:15:49 +0200
Message-Id: <20190419181601.7412-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
References: <20190419181601.7412-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a default timeout value in the driver which we will fall back to
if the user supplied values are out of bounce.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/cadence_wdt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index e6eaeaf3dfb1..a22f2d431a35 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -328,10 +328,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	/* Initialize the members of cdns_wdt structure */
 	cdns_wdt_device->parent = dev;
 
-	ret = watchdog_init_timeout(cdns_wdt_device, wdt_timeout, dev);
-	if (ret)
-		return ret;
-
+	watchdog_init_timeout(cdns_wdt_device, wdt_timeout, dev);
 	watchdog_set_nowayout(cdns_wdt_device, nowayout);
 	watchdog_stop_on_reboot(cdns_wdt_device);
 	watchdog_set_drvdata(cdns_wdt_device, wdt);
-- 
2.11.0

