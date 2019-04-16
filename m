Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB27C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DDB206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfDPK0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:26:24 -0400
Received: from sauhun.de ([88.99.104.3]:48700 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfDPKZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:25:29 -0400
Received: from localhost (p54B332D3.dip0.t-ipconnect.de [84.179.50.211])
        by pokefinder.org (Postfix) with ESMTPSA id EF4392E35BD;
        Tue, 16 Apr 2019 12:25:26 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/16] watchdog: i6300esb: drop warning after calling watchdog_init_timeout
Date:   Tue, 16 Apr 2019 12:25:06 +0200
Message-Id: <20190416102515.12269-8-wsa+renesas@sang-engineering.com>
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
 drivers/watchdog/i6300esb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index e312a2aeecad..17941c03996b 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -311,10 +311,7 @@ static int esb_probe(struct pci_dev *pdev,
 	edev->wdd.min_timeout = ESB_HEARTBEAT_MIN;
 	edev->wdd.max_timeout = ESB_HEARTBEAT_MAX;
 	edev->wdd.timeout = ESB_HEARTBEAT_DEFAULT;
-	if (watchdog_init_timeout(&edev->wdd, heartbeat, NULL))
-		dev_info(&pdev->dev,
-			"heartbeat value must be " ESB_HEARTBEAT_RANGE
-			", using %u\n", edev->wdd.timeout);
+	watchdog_init_timeout(&edev->wdd, heartbeat, NULL);
 	watchdog_set_nowayout(&edev->wdd, nowayout);
 	watchdog_stop_on_reboot(&edev->wdd);
 	watchdog_stop_on_unregister(&edev->wdd);
-- 
2.11.0

