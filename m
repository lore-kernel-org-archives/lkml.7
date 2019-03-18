Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3972BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFE5205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BQV70ToP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfCRT4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:56:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41165 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfCRT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:56:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so7398490edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ks2f6K1v3pmQsnUANuJk1vJs5LvSL9UtnUykELQ1JnE=;
        b=BQV70ToPl74PMtnMRQOpLzmkCnOV/G6QKWYCMfSOdGsaiXtpy6rId+W8K2LBz1Qt6H
         AmEPFFrl0zRqplM7PBHVrg5hJt6scwBjGTfTzX2klt+CNv8Sm0OOi5N2Brj2d5ArIWSt
         Mt9jErapd33zQNby9y6cXIVlCNS662OltvOWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ks2f6K1v3pmQsnUANuJk1vJs5LvSL9UtnUykELQ1JnE=;
        b=k2j28dbWQeAA+GNVs8IRRoIth2jynofTMqRMbvv10y5SeOty0UYk3XlNciCvZDACmD
         pObqonWzBiSywVNALangdy51zDC5gX3J1I2VRpR41gucME6ISLVKpg7BnCuSB8gG1TuX
         bCzeZnxUBhvicJoVzlLg4SiXW2l00v+lX2530i283b8XJZsSeker1KP5MIuAgFzS4LXC
         I4m11HPWMPKPy6ZXTo/ImuHJxQuQqJi0yM7cBEPtZXKvQnTIYXUNeX2PGhCqUWRdeDf8
         xS8P1qrRaAj0oaYdF+orHhekGXxfnNU4Czwd7gbHpN3YuJ14cD1G/fdE0b+YFhtgUXVB
         4eyg==
X-Gm-Message-State: APjAAAVEyoS0y+eQ1y3rjdUgjibaSYSNtWuai0bSbwKR7+Z6CN/4GDCZ
        uM5ddjAmCaDaeGlSoHrXC6BkyA==
X-Google-Smtp-Source: APXvYqz6jTNQvNvqdje+IaL/T1GBLTPlcJEOsMl9qFH+JLkzy+f//NvdgVP4btlX/5YEMCY8+VDTSg==
X-Received: by 2002:a50:b641:: with SMTP id c1mr13852657ede.155.1552938963415;
        Mon, 18 Mar 2019 12:56:03 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-117-200.cgn.fibianet.dk. [5.186.117.200])
        by smtp.gmail.com with ESMTPSA id b46sm3651730edd.18.2019.03.18.12.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 12:56:02 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] timekeeping: consistently use unsigned int for seqcount snapshot
Date:   Mon, 18 Mar 2019 20:55:56 +0100
Message-Id: <20190318195557.20773-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timekeeping code uses a random mix of "unsigned long" and
"unsigned int" for the seqcount snapshots (ratio 14:12). Since the
seqlock.h API is entirely based on unsigned (int), use that
throughout.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
-- 
2.20.1

