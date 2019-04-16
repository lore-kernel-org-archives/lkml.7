Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650B1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9F8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfDPK0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:26:42 -0400
Received: from sauhun.de ([88.99.104.3]:48684 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfDPKZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:25:27 -0400
Received: from localhost (p54B332D3.dip0.t-ipconnect.de [84.179.50.211])
        by pokefinder.org (Postfix) with ESMTPSA id D5FBC2E3589;
        Tue, 16 Apr 2019 12:25:25 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/16] watchdog: ebc-c384_wdt: drop warning after calling watchdog_init_timeout
Date:   Tue, 16 Apr 2019 12:25:04 +0200
Message-Id: <20190416102515.12269-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core will print out details now.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/ebc-c384_wdt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
index 4c4c8ce78021..c176f59fea28 100644
--- a/drivers/watchdog/ebc-c384_wdt.c
+++ b/drivers/watchdog/ebc-c384_wdt.c
@@ -117,10 +117,7 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
 	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
 
 	watchdog_set_nowayout(wdd, nowayout);
-
-	if (watchdog_init_timeout(wdd, timeout, dev))
-		dev_warn(dev, "Invalid timeout (%u seconds), using default (%u seconds)\n",
-			timeout, WATCHDOG_TIMEOUT);
+	watchdog_init_timeout(wdd, timeout, dev);
 
 	return devm_watchdog_register_device(dev, wdd);
 }
-- 
2.11.0

