Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F35C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE3C2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfCXUTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:19:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfCXUTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:19:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2OKJ54x1614990
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 24 Mar 2019 13:19:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2OKJ36P1614984;
        Sun, 24 Mar 2019 13:19:03 -0700
Date:   Sun, 24 Mar 2019 13:19:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-d6b87eaf10bd061914f6d277d7428b3285d8850e@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, anna-maria@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190321120921.16463-2-anna-maria@linutronix.de>
References: <20190321120921.16463-2-anna-maria@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tick/sched: Update tick_sched struct
 documentation
Git-Commit-ID: d6b87eaf10bd061914f6d277d7428b3285d8850e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d6b87eaf10bd061914f6d277d7428b3285d8850e
Gitweb:     https://git.kernel.org/tip/d6b87eaf10bd061914f6d277d7428b3285d8850e
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Thu, 21 Mar 2019 13:09:18 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Mar 2019 20:29:32 +0100

tick/sched: Update tick_sched struct documentation

Adapt the documentation order of struct members to the effective order of
struct members and add missing descriptions.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fweisbec@gmail.com
Cc: peterz@infradead.org
Link: https://lkml.kernel.org/r/20190321120921.16463-2-anna-maria@linutronix.de

---
 kernel/time/tick-sched.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 6de959a854b2..4fb06527cf64 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -24,12 +24,19 @@ enum tick_nohz_mode {
  * struct tick_sched - sched tick emulation and no idle tick control/stats
  * @sched_timer:	hrtimer to schedule the periodic tick in high
  *			resolution mode
+ * @check_clocks:	Notification mechanism about clocksource changes
+ * @nohz_mode:		Mode - one state of tick_nohz_mode
+ * @inidle:		Indicator that the CPU is in the tick idle mode
+ * @tick_stopped:	Indicator that the idle tick has been stopped
+ * @idle_active:	Indicator that the CPU is actively in the tick idle mode;
+ *			it is resetted during irq handling phases.
+ * @do_timer_lst:	CPU was the last one doing do_timer before going idle
+ * @got_idle_tick:	Tick timer function has run with @inidle set
  * @last_tick:		Store the last tick expiry time when the tick
  *			timer is modified for nohz sleeps. This is necessary
  *			to resume the tick timer operation in the timeline
  *			when the CPU returns from nohz sleep.
  * @next_tick:		Next tick to be fired when in dynticks mode.
- * @tick_stopped:	Indicator that the idle tick has been stopped
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_calls:		Total number of idle calls
  * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
@@ -40,8 +47,8 @@ enum tick_nohz_mode {
  * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
  * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
- * @do_timer_lst:	CPU was the last one doing do_timer before going idle
- * @got_idle_tick:	Tick timer function has run with @inidle set
+ * @next_timer:		Expiry time of next expiring timer for debugging purpose only
+ * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
