Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FAFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA50D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDKTOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:14:42 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59853 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKTOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:14:42 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D531E1C000C;
        Thu, 11 Apr 2019 19:14:38 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2] watchdog: pnx4008: readout watchdog state
Date:   Thu, 11 Apr 2019 21:14:37 +0200
Message-Id: <20190411191437.12173-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Readout the enabled state so it is possible to get the pre-userspace
handler working. Also, avoid disabling the watchdog to ensure it continues
working and triggers if there is an issue later in the boot or if userspace
fails to start.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/watchdog/pnx4008_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 8e261799c84e..4ce0389d1442 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -209,7 +209,8 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
 	watchdog_set_restart_priority(&pnx4008_wdd, 128);
 
-	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
+	if (readl(WDTIM_CTRL(wdt_base)) & COUNT_ENAB)
+		set_bit(WDOG_HW_RUNNING, &pnx4008_wdd.status);
 
 	ret = watchdog_register_device(&pnx4008_wdd);
 	if (ret < 0) {
-- 
2.20.1

