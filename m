Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D8C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5620217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfEVD3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfEVD3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DEB93688B;
        Wed, 22 May 2019 03:29:12 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F6177C489;
        Wed, 22 May 2019 03:29:08 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] tick/sched: Drop duplicated tick_sched.inidle
Date:   Wed, 22 May 2019 11:29:06 +0800
Message-Id: <20190522032906.11963-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 22 May 2019 03:29:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is set before entering idle and cleared when quitting idle, though
it seems to be a complete duplicate of tick_sched.idle_active.  We
should probably be able to use any one of them to replace the other.

CC: Frederic Weisbecker <fweisbec@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@kernel.org>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 kernel/time/tick-sched.c | 11 ++++-------
 kernel/time/tick-sched.h |  3 +--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f4ee1a3428ae..6bb5ad03e962 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -137,7 +137,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	if (tick_do_timer_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
-	if (ts->inidle)
+	if (ts->idle_active)
 		ts->got_idle_tick = 1;
 }
 
@@ -534,7 +534,6 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 {
 	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
 	ts->idle_active = 0;
-
 	sched_clock_idle_wakeup_event();
 }
 
@@ -999,7 +998,6 @@ void tick_nohz_idle_enter(void)
 
 	WARN_ON_ONCE(ts->timer_expires_base);
 
-	ts->inidle = 1;
 	tick_nohz_start_idle(ts);
 
 	local_irq_enable();
@@ -1017,7 +1015,7 @@ void tick_nohz_irq_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->inidle)
+	if (ts->idle_active)
 		tick_nohz_start_idle(ts);
 	else
 		tick_nohz_full_update_tick(ts);
@@ -1067,7 +1065,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	ktime_t now = ts->idle_entrytime;
 	ktime_t next_event;
 
-	WARN_ON_ONCE(!ts->inidle);
+	WARN_ON_ONCE(!ts->idle_active);
 
 	*delta_next = ktime_sub(dev->next_event, now);
 
@@ -1163,10 +1161,9 @@ void tick_nohz_idle_exit(void)
 
 	local_irq_disable();
 
-	WARN_ON_ONCE(!ts->inidle);
+	WARN_ON_ONCE(!ts->idle_active);
 	WARN_ON_ONCE(ts->timer_expires_base);
 
-	ts->inidle = 0;
 	idle_active = ts->idle_active;
 	tick_stopped = ts->tick_stopped;
 
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 4fb06527cf64..ae9335d019f0 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -31,7 +31,7 @@ enum tick_nohz_mode {
  * @idle_active:	Indicator that the CPU is actively in the tick idle mode;
  *			it is resetted during irq handling phases.
  * @do_timer_lst:	CPU was the last one doing do_timer before going idle
- * @got_idle_tick:	Tick timer function has run with @inidle set
+ * @got_idle_tick:	Tick timer function has run with @idle_active set
  * @last_tick:		Store the last tick expiry time when the tick
  *			timer is modified for nohz sleeps. This is necessary
  *			to resume the tick timer operation in the timeline
@@ -55,7 +55,6 @@ struct tick_sched {
 	unsigned long			check_clocks;
 	enum tick_nohz_mode		nohz_mode;
 
-	unsigned int			inidle		: 1;
 	unsigned int			tick_stopped	: 1;
 	unsigned int			idle_active	: 1;
 	unsigned int			do_timer_last	: 1;
-- 
2.17.1

