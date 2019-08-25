Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF40EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7B820674
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfHYJpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 05:45:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfHYJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:45:15 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1p5F-0004tL-Hk; Sun, 25 Aug 2019 11:45:13 +0200
Date:   Sun, 25 Aug 2019 09:43:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.3-rc5
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
Message-ID: <156672618029.19810.11392026209249158095.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

up to:  b99328a60a48: timekeeping/vsyscall: Prevent math overflow in BOOTTIME update

A single fix for a regression caused by the generic VDSO implementation
where a math overflow causes CLOCK_BOOTTIME to become a random number
generator.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      timekeeping/vsyscall: Prevent math overflow in BOOTTIME update


 include/linux/timekeeper_internal.h |  5 +++++
 kernel/time/timekeeping.c           |  5 +++++
 kernel/time/vsyscall.c              | 22 +++++++++++++---------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 7acb953298a7..84ff2844df2a 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -57,6 +57,7 @@ struct tk_read_base {
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  * @next_leap_ktime:	CLOCK_MONOTONIC time value of a pending leap-second
  * @raw_sec:		CLOCK_MONOTONIC_RAW  time in seconds
+ * @monotonic_to_boot:	CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
  * @cycle_interval:	Number of clock cycles in one NTP interval
  * @xtime_interval:	Number of clock shifted nano seconds in one NTP
  *			interval.
@@ -84,6 +85,9 @@ struct tk_read_base {
  *
  * wall_to_monotonic is no longer the boot time, getboottime must be
  * used instead.
+ *
+ * @monotonic_to_boottime is a timespec64 representation of @offs_boot to
+ * accelerate the VDSO update for CLOCK_BOOTTIME.
  */
 struct timekeeper {
 	struct tk_read_base	tkr_mono;
@@ -99,6 +103,7 @@ struct timekeeper {
 	u8			cs_was_changed_seq;
 	ktime_t			next_leap_ktime;
 	u64			raw_sec;
+	struct timespec64	monotonic_to_boot;
 
 	/* The following members are for timekeeping internal use */
 	u64			cycle_interval;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d911c8470149..ca69290bee2a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -146,6 +146,11 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
 	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+	/*
+	 * Timespec representation for VDSO update to avoid 64bit division
+	 * on every update.
+	 */
+	tk->monotonic_to_boot = ktime_to_timespec64(tk->offs_boot);
 }
 
 /*
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 8cf3596a4ce6..4bc37ac3bb05 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -17,7 +17,7 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 				    struct timekeeper *tk)
 {
 	struct vdso_timestamp *vdso_ts;
-	u64 nsec;
+	u64 nsec, sec;
 
 	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
 	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
@@ -45,23 +45,27 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 	}
 	vdso_ts->nsec	= nsec;
 
-	/* CLOCK_MONOTONIC_RAW */
-	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
-	vdso_ts->sec	= tk->raw_sec;
-	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
+	/* Copy MONOTONIC time for BOOTTIME */
+	sec	= vdso_ts->sec;
+	/* Add the boot offset */
+	sec	+= tk->monotonic_to_boot.tv_sec;
+	nsec	+= (u64)tk->monotonic_to_boot.tv_nsec << tk->tkr_mono.shift;
 
 	/* CLOCK_BOOTTIME */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
-	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec = tk->tkr_mono.xtime_nsec;
-	nsec += ((u64)(tk->wall_to_monotonic.tv_nsec +
-		       ktime_to_ns(tk->offs_boot)) << tk->tkr_mono.shift);
+	vdso_ts->sec	= sec;
+
 	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
 		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
 		vdso_ts->sec++;
 	}
 	vdso_ts->nsec	= nsec;
 
+	/* CLOCK_MONOTONIC_RAW */
+	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
+	vdso_ts->sec	= tk->raw_sec;
+	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
+
 	/* CLOCK_TAI */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
 	vdso_ts->sec	= tk->xtime_sec + (s64)tk->tai_offset;


