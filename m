Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55522C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3F22171F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDCOL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:11:58 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49423 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfDCOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:11:55 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 501B3240019;
        Wed,  3 Apr 2019 14:11:51 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 05/12] clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
Date:   Wed,  3 Apr 2019 16:11:13 +0200
Message-Id: <20190403141120.32754-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
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
index c7eec9808289..10350dffd157 100644
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
@@ -327,6 +338,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	struct atmel_tc tc;
 	struct clk *t0_clk;
 	const struct of_device_id *match;
+	u64 (*tc_sched_clock)(void);
 	int irq;
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
@@ -416,6 +428,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		clksrc.read = tc_get_cycles32;
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read32;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -427,6 +440,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		}
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read;
 	}
 
 	/* and away we go! */
@@ -439,6 +453,8 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	if (ret)
 		goto err_unregister_clksrc;
 
+	sched_clock_register(tc_sched_clock, 32, divided_rate);
+
 	return 0;
 
 err_unregister_clksrc:
-- 
2.20.1

