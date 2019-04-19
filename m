Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68C5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD865222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfDSSR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:17:56 -0400
Received: from sauhun.de ([88.99.104.3]:50578 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfDSSQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:14 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id C01752E35BF;
        Fri, 19 Apr 2019 20:16:12 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/16] watchdog: i6300esb: drop warning after calling watchdog_init_timeout
Date:   Fri, 19 Apr 2019 20:15:52 +0200
Message-Id: <20190419181601.7412-8-wsa+renesas@sang-engineering.com>
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

