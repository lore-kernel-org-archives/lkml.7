Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26275C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC72320850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDKPgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:36:52 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33821 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:36:52 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 635EA2000B;
        Thu, 11 Apr 2019 15:36:48 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] watchdog: pnx4008: readout watchddog state
Date:   Thu, 11 Apr 2019 17:36:46 +0200
Message-Id: <20190411153646.32228-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Readout the enabled state so it is possible to get the pre-userspace
handler working. Also, avoid disabling the watchdog when nowayout is set to
ensure the watchdog continues working and triggers if there is an issue
later in the boot or if userspace fails to start.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/watchdog/pnx4008_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 8e261799c84e..9e3714e3814c 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -209,7 +209,11 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
 	watchdog_set_restart_priority(&pnx4008_wdd, 128);
 
-	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
+	if (readl(WDTIM_CTRL(wdt_base)) & COUNT_ENAB)
+		set_bit(WDOG_HW_RUNNING, &pnx4008_wdd.status);
+
+	if (!nowayout)
+		pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
 
 	ret = watchdog_register_device(&pnx4008_wdd);
 	if (ret < 0) {
-- 
2.20.1

