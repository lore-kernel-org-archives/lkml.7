Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C334EC4646C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C41C20665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFWMC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:02:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54208 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfFWMCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:02:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B5DF12003BB;
        Sun, 23 Jun 2019 14:02:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C6AEB200277;
        Sun, 23 Jun 2019 14:02:42 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D96E14030C;
        Sun, 23 Jun 2019 20:02:31 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, ccaione@baylibre.com, angus@akkea.ca,
        andrew.smirnov@gmail.com, agx@sigxcpu.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/3] clocksource: imx-sysctr: Add of_clk skip option
Date:   Sun, 23 Jun 2019 20:04:33 +0800
Message-Id: <20190623120434.19556-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190623120434.19556-1-Anson.Huang@nxp.com>
References: <20190623120434.19556-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

On some i.MX8M platforms, clock driver uses platform driver
model and it is NOT ready during timer initialization phase,
the clock operations will fail and system counter driver will
fail too. As all the i.MX8M platforms' system counter clock
are from OSC which is always enabled, so it is no need to enable
clock for system counter driver, the ONLY thing is to pass
clock frequence to driver.

This patch adds an option of skipping of_clk operation for
system counter driver, an optional property "clock-frequency"
is introduced to pass the frequency value to system counter
driver and indicate driver to skip of_clk operations.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 drivers/clocksource/timer-imx-sysctr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index fd7d680..8ff3d7e 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -129,6 +129,14 @@ static void __init sysctr_clockevent_init(void)
 static int __init sysctr_timer_init(struct device_node *np)
 {
 	int ret = 0;
+	u32 rate;
+
+	if (!of_property_read_u32(np, "clock-frequency",
+				  &rate)) {
+		to_sysctr.of_clk.rate = rate;
+		to_sysctr.of_clk.period = DIV_ROUND_UP(rate, HZ);
+		to_sysctr.flags &= ~TIMER_OF_CLOCK;
+	}
 
 	ret = timer_of_init(np, &to_sysctr);
 	if (ret)
-- 
2.7.4

