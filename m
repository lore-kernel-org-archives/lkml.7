Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A05CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5BC20883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfCYDFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:05:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:52827 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbfCYDFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:05:40 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Mar 2019 12:05:39 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 3A1666117D;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 25 Mar 2019 12:05:39 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 0E6C41A15B7;
        Mon, 25 Mar 2019 12:05:39 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id F10E0120459;
        Mon, 25 Mar 2019 12:05:38 +0900 (JST)
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
Subject: [PATCH 1/3] clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
Date:   Mon, 25 Mar 2019 12:05:47 +0900
Message-Id: <1553483149-8922-2-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
References: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix mlb_set_oneshot_state() to enable one-shot timer.
The function should stop and start a timer, but "start" statement was
dropped. Kick the register to start one-shot timer.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/clocksource/timer-milbeaut.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
index f2019a8..9fd5d08 100644
--- a/drivers/clocksource/timer-milbeaut.c
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -80,6 +80,8 @@ static int mlb_set_state_oneshot(struct clock_event_device *clk)
 	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
 	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
 	return 0;
 }
 
-- 
1.9.1

