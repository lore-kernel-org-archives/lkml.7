Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC272C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1DE2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCWKqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:46:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55749 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCWKqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 06:46:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2NAkTiq983266
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 23 Mar 2019 03:46:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2NAkRrS983263;
        Sat, 23 Mar 2019 03:46:27 -0700
Date:   Sat, 23 Mar 2019 03:46:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rasmus Villemoes <tipbot@zytor.com>
Message-ID: <tip-e1e41b6ce5f9c1a80bf4f2404ec5ab11c6c5a2ad@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, john.stultz@linaro.org, mingo@kernel.org,
        linux@rasmusvillemoes.dk, fweisbec@gmail.com
Reply-To: linux@rasmusvillemoes.dk, hpa@zytor.com,
          linux-kernel@vger.kernel.org, sboyd@kernel.org,
          tglx@linutronix.de, john.stultz@linaro.org, mingo@kernel.org,
          fweisbec@gmail.com
In-Reply-To: <20190318195557.20773-1-linux@rasmusvillemoes.dk>
References: <20190318195557.20773-1-linux@rasmusvillemoes.dk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Consistently use unsigned int for
 seqcount snapshot
Git-Commit-ID: e1e41b6ce5f9c1a80bf4f2404ec5ab11c6c5a2ad
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

Commit-ID:  e1e41b6ce5f9c1a80bf4f2404ec5ab11c6c5a2ad
Gitweb:     https://git.kernel.org/tip/e1e41b6ce5f9c1a80bf4f2404ec5ab11c6c5a2ad
Author:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate: Mon, 18 Mar 2019 20:55:56 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Mar 2019 11:43:56 +0100

timekeeping: Consistently use unsigned int for seqcount snapshot

The timekeeping code uses a random mix of "unsigned long" and "unsigned
int" for the seqcount snapshots (ratio 14:12). Since the seqlock.h API is
entirely based on unsigned int, use that throughout.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190318195557.20773-1-linux@rasmusvillemoes.dk

---
 kernel/time/jiffies.c     |  2 +-
 kernel/time/sched_clock.c |  4 ++--
 kernel/time/tick-common.c |  2 +-
 kernel/time/tick-sched.c  |  3 ++-
 kernel/time/timekeeping.c | 18 +++++++++---------
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index dc1b6f1929f9..95f8f3304c19 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -63,7 +63,7 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(jiffies_lock);
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
-	unsigned long seq;
+	unsigned int seq;
 	u64 ret;
 
 	do {
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 094b82ca95e5..16b80c2b4fe8 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -94,7 +94,7 @@ static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 unsigned long long notrace sched_clock(void)
 {
 	u64 cyc, res;
-	unsigned long seq;
+	unsigned int seq;
 	struct clock_read_data *rd;
 
 	do {
@@ -267,7 +267,7 @@ void __init generic_sched_clock_init(void)
  */
 static u64 notrace suspended_sched_clock_read(void)
 {
-	unsigned long seq = raw_read_seqcount(&cd.seq);
+	unsigned int seq = raw_read_seqcount(&cd.seq);
 
 	return cd.read_data[seq & 1].epoch_cyc;
 }
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 529143b4c8d2..561641b2153f 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -149,7 +149,7 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	    !tick_broadcast_oneshot_active()) {
 		clockevents_switch_state(dev, CLOCK_EVT_STATE_PERIODIC);
 	} else {
-		unsigned long seq;
+		unsigned int seq;
 		ktime_t next;
 
 		do {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6fa52cd6df0b..b50f6f22c88e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -645,7 +645,8 @@ static inline bool local_timer_softirq_pending(void)
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
 	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
-	unsigned long seq, basejiff;
+	unsigned long basejiff;
+	unsigned int seq;
 
 	/* Read jiffies and the time when jiffies were updated last */
 	do {
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f986e1918d12..540145da33da 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -720,7 +720,7 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 void ktime_get_real_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long seq;
+	unsigned int seq;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -829,7 +829,7 @@ EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 {
 	ktime_t *offset = offsets[offs];
-	unsigned long seq;
+	unsigned int seq;
 	ktime_t tconv;
 
 	do {
@@ -960,7 +960,7 @@ time64_t __ktime_get_real_seconds(void)
 void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long seq;
+	unsigned int seq;
 	ktime_t base_raw;
 	ktime_t base_real;
 	u64 nsec_raw;
@@ -1122,7 +1122,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 	ktime_t base_real, base_raw;
 	u64 nsec_real, nsec_raw;
 	u8 cs_was_changed_seq;
-	unsigned long seq;
+	unsigned int seq;
 	bool do_interp;
 	int ret;
 
@@ -1409,7 +1409,7 @@ int timekeeping_notify(struct clocksource *clock)
 void ktime_get_raw_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long seq;
+	unsigned int seq;
 	u64 nsecs;
 
 	do {
@@ -1431,7 +1431,7 @@ EXPORT_SYMBOL(ktime_get_raw_ts64);
 int timekeeping_valid_for_hres(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long seq;
+	unsigned int seq;
 	int ret;
 
 	do {
@@ -1450,7 +1450,7 @@ int timekeeping_valid_for_hres(void)
 u64 timekeeping_max_deferment(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long seq;
+	unsigned int seq;
 	u64 ret;
 
 	do {
@@ -2150,7 +2150,7 @@ EXPORT_SYMBOL_GPL(getboottime64);
 void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long seq;
+	unsigned int seq;
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
@@ -2164,7 +2164,7 @@ void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct timespec64 now, mono;
-	unsigned long seq;
+	unsigned int seq;
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
