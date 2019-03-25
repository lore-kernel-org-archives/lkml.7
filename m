Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA5BC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F283720896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfCYDFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:05:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:52829 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfCYDFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:05:41 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Mar 2019 12:05:39 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5DCBF6117D;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 25 Mar 2019 12:05:39 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 2305F4031A;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 11348120459;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 2/3] clocksource/drivers/timer-milbeaut: Add shutdown function
Date:   Mon, 25 Mar 2019 12:05:48 +0900
Message-Id: <1553483149-8922-3-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
References: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a shutdown operation to support shutdown timer.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/clocksource/timer-milbeaut.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
index 9fd5d08..f478061 100644
--- a/drivers/clocksource/timer-milbeaut.c
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -85,6 +85,15 @@ static int mlb_set_state_oneshot(struct clock_event_device *clk)
 	return 0;
 }
 
+static int mlb_set_state_shutdown(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
 static int mlb_clkevt_next_event(unsigned long event,
 				   struct clock_event_device *clk)
 {
@@ -125,6 +134,7 @@ static int mlb_config_clock_event(struct timer_of *to)
 		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
 		.set_state_oneshot = mlb_set_state_oneshot,
 		.set_state_periodic = mlb_set_state_periodic,
+		.set_state_shutdown = mlb_set_state_shutdown,
 		.set_next_event = mlb_clkevt_next_event,
 	},
 
-- 
1.9.1

