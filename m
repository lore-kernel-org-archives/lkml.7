Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D185DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCE6214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfF1DkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:40:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51602 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfF1Dj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:39:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D3801A02E9;
        Fri, 28 Jun 2019 05:39:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C205D1A02D8;
        Fri, 28 Jun 2019 05:39:46 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BE9644030E;
        Fri, 28 Jun 2019 11:39:33 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, angus@akkea.ca,
        agx@sigxcpu.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 3/5] clocksource: imx-sysctr: Make timer work with clock driver using platform driver model
Date:   Fri, 28 Jun 2019 11:30:39 +0800
Message-Id: <20190628033041.8513-3-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190628033041.8513-1-Anson.Huang@nxp.com>
References: <20190628033041.8513-1-Anson.Huang@nxp.com>
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

To make system counter driver work for upper scenario, if DT's
system counter node has property "clock-frequency" present,
setting TIMER_OF_CLOCK_FREQUENCY flag to indicate timer-of driver
to get clock frequency from DT directly instead of of_clk operation
via clk APIs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- do runtime check to decide whether using TIMER_OF_CLOCK_FREQUENCY or TIMER_OF_CLOCK
	  according to DT node settings.
---
 drivers/clocksource/timer-imx-sysctr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index fd7d680..73e3193 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -98,7 +98,7 @@ static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
 }
 
 static struct timer_of to_sysctr = {
-	.flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE,
 	.clkevt = {
 		.name			= "i.MX system counter timer",
 		.features		= CLOCK_EVT_FEAT_ONESHOT |
@@ -114,6 +114,7 @@ static struct timer_of to_sysctr = {
 	},
 	.of_clk = {
 		.name = "per",
+		.prop_name = "clock-frequency",
 	},
 };
 
@@ -130,6 +131,9 @@ static int __init sysctr_timer_init(struct device_node *np)
 {
 	int ret = 0;
 
+	to_sysctr.flags |= of_find_property(np, "clock-frequency", NULL) ?
+			   TIMER_OF_CLOCK_FREQUENCY : TIMER_OF_CLOCK;
+
 	ret = timer_of_init(np, &to_sysctr);
 	if (ret)
 		return ret;
-- 
2.7.4

