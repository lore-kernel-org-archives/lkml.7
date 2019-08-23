Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43208C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D9023401
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbfHWAzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:55:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33482 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732470AbfHWAzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 20:55:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0xrj-0000Ak-S7; Fri, 23 Aug 2019 02:55:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 35F8E1C07E4;
        Fri, 23 Aug 2019 02:55:43 +0200 (CEST)
Date:   Fri, 23 Aug 2019 00:55:39 -0000
From:   tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping/vsyscall: Prevent math overflow in
 BOOTTIME update
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <alpine.DEB.2.21.1908221257580.1983@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1908221257580.1983@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <156652173939.9311.7491866845285987289.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     b99328a60a482108f5195b4d611f90992ca016ba
Gitweb:        https://git.kernel.org/tip/b99328a60a482108f5195b4d611f90992ca016ba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 22 Aug 2019 13:00:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2019 02:12:11 +02:00

timekeeping/vsyscall: Prevent math overflow in BOOTTIME update

The VDSO update for CLOCK_BOOTTIME has a overflow issue as it shifts the
nanoseconds based boot time offset left by the clocksource shift. That
overflows once the boot time offset becomes large enough. As a consequence
CLOCK_BOOTTIME in the VDSO becomes a random number causing applications to
misbehave.

Fix it by storing a timespec64 representation of the offset when boot time
is adjusted and add that to the MONOTONIC base time value in the vdso data
page. Using the timespec64 representation avoids a 64bit division in the
update code.

Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
Reported-by: Chris Clayton <chris2553@googlemail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chris Clayton <chris2553@googlemail.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1908221257580.1983@nanos.tec.linutronix.de

---
 include/linux/timekeeper_internal.h |  5 -----
 kernel/time/timekeeping.c           |  5 -----
 kernel/time/vsyscall.c              | 22 +++++++++-------------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 84ff284..7acb953 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -57,7 +57,6 @@ struct tk_read_base {
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  * @next_leap_ktime:	CLOCK_MONOTONIC time value of a pending leap-second
  * @raw_sec:		CLOCK_MONOTONIC_RAW  time in seconds
- * @monotonic_to_boot:	CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
  * @cycle_interval:	Number of clock cycles in one NTP interval
  * @xtime_interval:	Number of clock shifted nano seconds in one NTP
  *			interval.
@@ -85,9 +84,6 @@ struct tk_read_base {
  *
  * wall_to_monotonic is no longer the boot time, getboottime must be
  * used instead.
- *
- * @monotonic_to_boottime is a timespec64 representation of @offs_boot to
- * accelerate the VDSO update for CLOCK_BOOTTIME.
  */
 struct timekeeper {
 	struct tk_read_base	tkr_mono;
@@ -103,7 +99,6 @@ struct timekeeper {
 	u8			cs_was_changed_seq;
 	ktime_t			next_leap_ktime;
 	u64			raw_sec;
-	struct timespec64	monotonic_to_boot;
 
 	/* The following members are for timekeeping internal use */
 	u64			cycle_interval;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ca69290..d911c84 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -146,11 +146,6 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
 	tk->offs_boot = ktime_add(tk->offs_boot, delta);
-	/*
-	 * Timespec representation for VDSO update to avoid 64bit division
-	 * on every update.
-	 */
-	tk->monotonic_to_boot = ktime_to_timespec64(tk->offs_boot);
 }
 
 /*
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 4bc37ac..8cf3596 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -17,7 +17,7 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 				    struct timekeeper *tk)
 {
 	struct vdso_timestamp *vdso_ts;
-	u64 nsec, sec;
+	u64 nsec;
 
 	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
 	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
@@ -45,27 +45,23 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 	}
 	vdso_ts->nsec	= nsec;
 
-	/* Copy MONOTONIC time for BOOTTIME */
-	sec	= vdso_ts->sec;
-	/* Add the boot offset */
-	sec	+= tk->monotonic_to_boot.tv_sec;
-	nsec	+= (u64)tk->monotonic_to_boot.tv_nsec << tk->tkr_mono.shift;
+	/* CLOCK_MONOTONIC_RAW */
+	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
+	vdso_ts->sec	= tk->raw_sec;
+	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
 
 	/* CLOCK_BOOTTIME */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
-	vdso_ts->sec	= sec;
-
+	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec = tk->tkr_mono.xtime_nsec;
+	nsec += ((u64)(tk->wall_to_monotonic.tv_nsec +
+		       ktime_to_ns(tk->offs_boot)) << tk->tkr_mono.shift);
 	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
 		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
 		vdso_ts->sec++;
 	}
 	vdso_ts->nsec	= nsec;
 
-	/* CLOCK_MONOTONIC_RAW */
-	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
-	vdso_ts->sec	= tk->raw_sec;
-	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
-
 	/* CLOCK_TAI */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
 	vdso_ts->sec	= tk->xtime_sec + (s64)tk->tai_offset;
