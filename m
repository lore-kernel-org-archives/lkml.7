Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32290C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4172086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfDPKZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:25:35 -0400
Received: from sauhun.de ([88.99.104.3]:48678 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfDPKZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:25:31 -0400
Received: from localhost (p54B332D3.dip0.t-ipconnect.de [84.179.50.211])
        by pokefinder.org (Postfix) with ESMTPSA id 4D0A52E35C4;
        Tue, 16 Apr 2019 12:25:30 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/16] watchdog: st_lpc_wdt: drop warning after calling watchdog_init_timeout
Date:   Tue, 16 Apr 2019 12:25:12 +0200
Message-Id: <20190416102515.12269-14-wsa+renesas@sang-engineering.com>
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
 drivers/watchdog/st_lpc_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 9a5ed95c3403..7a90184eb950 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -224,10 +224,8 @@ static int st_wdog_probe(struct platform_device *pdev)
 
 	/* Init Watchdog timeout with value in DT */
 	ret = watchdog_init_timeout(&st_wdog_dev, 0, dev);
-	if (ret) {
-		dev_err(dev, "Unable to initialise watchdog timeout\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = devm_watchdog_register_device(dev, &st_wdog_dev);
 	if (ret) {
-- 
2.11.0

