Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C602CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DE7214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572275268;
	bh=cJMrQBmRRDz/62veZ93a0sKQIk1acNGPtdue49LiYbs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NSz84T2E7B3VQVBikTChshXLTpkqCWyaB5GRRa95FLADtLDTCTCvQPRvnX2fPa+Wh
	 vSynStdhb7j3Rs5uuhL3xnRmhBWLzy6i5gvDB26QQsU7cixDFmjANzZ7fxS2A8oUmX
	 ZpfQ9NiXusLDV9/oCwpi2Csbv0gUDEfdJpustIro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbfJ1PHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfJ1PHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:07:47 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381F621783;
        Mon, 28 Oct 2019 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572275266;
        bh=cJMrQBmRRDz/62veZ93a0sKQIk1acNGPtdue49LiYbs=;
        h=From:To:Cc:Subject:Date:From;
        b=AFOiqgHOn4bnIA/yXpqo/OVM/Zt94fxcrVsVZNAa+Ovs2QpfFZpj3Ps5x0C5VS/RK
         ON9J97+O52qxT0Tq4SARIcCqNV5AwlAHh6I69cfTJAz9SQKpmrXTaN2zEWdbIc/yhI
         ypy5BipHf5ltz/RjxpxOFA2IcoqkbkHBcwW6+rAY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Scott Wood <swood@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] timers/nohz: Update nohz load even if tick already stopped
Date:   Mon, 28 Oct 2019 16:07:16 +0100
Message-Id: <20191028150716.22890-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

The way loadavg is tracked during nohz only pays attention to the load
upon entering nohz. This can be particularly noticeable if nohz is
entered while non-idle, and then the cpu goes idle and stays that way for
a long time. We've had reports of a loadavg near 150 on a mostly idle
system.

Calling calc_load_nohz_start() regardless of whether the tick is already
stopped addresses the issue when going idle. Tracking load changes when
not going idle (e.g. multiple SCHED_FIFO tasks coming and going) is not
addressed by this patch.

Signed-off-by: Scott Wood <swood@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c2748232f607..f55ddeb652a3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -763,6 +763,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		ts->do_timer_last = 0;
 	}
 
+	/* Even if the tick was already stopped, load may have changed */
+	calc_load_nohz_start();
+
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -783,7 +786,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * the scheduler tick in nohz_restart_sched_tick.
 	 */
 	if (!ts->tick_stopped) {
-		calc_load_nohz_start();
 		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
-- 
2.23.0

