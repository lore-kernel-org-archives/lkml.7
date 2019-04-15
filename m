Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BBCC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8DE20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfDOPJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:09:18 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54025 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfDOPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:09:16 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F33E4C0006;
        Mon, 15 Apr 2019 15:09:13 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 3/9] clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
Date:   Mon, 15 Apr 2019 17:08:50 +0200
Message-Id: <20190415150856.9384-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415150856.9384-1-alexandre.belloni@bootlin.com>
References: <20190415150856.9384-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver is registered early enough, use the TCB as the
sched_clock which is much more accurate than the jiffies implementation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/tcb_clksrc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index bf68504da94a..9de8c10ab546 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 #include <linux/syscore_ops.h>
 #include <soc/at91/atmel_tcb.h>
 
@@ -114,6 +115,16 @@ static struct clocksource clksrc = {
 	.resume		= tc_clksrc_resume,
 };
 
+static u64 notrace tc_sched_clock_read(void)
+{
+	return tc_get_cycles(&clksrc);
+}
+
+static u64 notrace tc_sched_clock_read32(void)
+{
+	return tc_get_cycles32(&clksrc);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 struct tc_clkevt_device {
@@ -335,6 +346,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	struct atmel_tc tc;
 	struct clk *t0_clk;
 	const struct of_device_id *match;
+	u64 (*tc_sched_clock)(void);
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
 	int clk32k_divisor_idx = -1;
@@ -419,6 +431,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		clksrc.read = tc_get_cycles32;
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read32;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -430,6 +443,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		}
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read;
 	}
 
 	/* and away we go! */
@@ -442,6 +456,8 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	if (ret)
 		goto err_unregister_clksrc;
 
+	sched_clock_register(tc_sched_clock, 32, divided_rate);
+
 	return 0;
 
 err_unregister_clksrc:
-- 
2.20.1

