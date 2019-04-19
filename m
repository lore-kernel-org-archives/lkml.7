Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF8C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B9222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfDSSRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:17:03 -0400
Received: from sauhun.de ([88.99.104.3]:50598 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfDSSQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:16:18 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id AC9822E35C7;
        Fri, 19 Apr 2019 20:16:16 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/16] watchdog: stm32_iwdg: drop warning after calling watchdog_init_timeout
Date:   Fri, 19 Apr 2019 20:15:59 +0200
Message-Id: <20190419181601.7412-15-wsa+renesas@sang-engineering.com>
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
 drivers/watchdog/stm32_iwdg.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 309563e002b8..50ce762bddb2 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -235,11 +235,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(wdd, wdt);
 	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
-
-	ret = watchdog_init_timeout(wdd, 0, &pdev->dev);
-	if (ret)
-		dev_warn(&pdev->dev,
-			 "unable to set timeout value, using default\n");
+	watchdog_init_timeout(wdd, 0, &pdev->dev);
 
 	ret = watchdog_register_device(wdd);
 	if (ret) {
-- 
2.11.0

