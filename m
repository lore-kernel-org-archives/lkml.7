Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE295C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13EF2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfCWKgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:36:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42493 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCWKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 06:36:25 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7e0i-0000kB-1q; Sat, 23 Mar 2019 11:36:20 +0100
Date:   Sat, 23 Mar 2019 11:36:19 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] timekeeping: Force upper bound for setting CLOCK_REALTIME
Message-ID: <alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several people reported testing failures after setting CLOCK_REALTIME close
to the limits of the kernel internal representation in nanoseconds,
i.e. year 2262.

The failures are exposed in subsequent operations, i.e. when arming timers
or when the advancing CLOCK_MONOTONIC makes the calculation of
CLOCK_REALTIME overflow into negative space.

Now people start to paper over the underlying problem by clamping
calculations to the valid range, but that's just wrong because such
workarounds will prevent detection of real issues as well.

It is reasonable to force an upper bound for the various methods of setting
CLOCK_REALTIME. Year 2262 is the absolute upper bound. Assume a maximum
uptime of 30 years which is plenty enough even for esoteric embedded
systems. That results in an upper bound of year 2232 for setting the time.

Once that limit is reached in reality this limit is only a small part of
the problem space. But until then this stops people from trying to paper
over the problem at the wrong places.

Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Reported-by: Hongbo Yao <yaohongbo@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Cochran <richardcochran@gmail.com>
---
 include/linux/time64.h    |   21 +++++++++++++++++++++
 kernel/time/time.c        |    2 +-
 kernel/time/timekeeping.c |    6 +++---
 3 files changed, 25 insertions(+), 4 deletions(-)

--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -33,6 +33,17 @@ struct itimerspec64 {
 #define KTIME_MAX			((s64)~((u64)1 << 63))
 #define KTIME_SEC_MAX			(KTIME_MAX / NSEC_PER_SEC)
 
+/*
+ * Limits for settimeofday():
+ *
+ * To prevent setting the time close to the wraparound point time setting
+ * is limited so a reasonable uptime can be accomodated. Uptime of 30 years
+ * should be really sufficient, which means the cutoff is 2232. At that
+ * point the cutoff is just a small part of the larger problem.
+ */
+#define TIME_UPTIME_SEC_MAX		(30LL * 365 * 24 *3600)
+#define TIME_SETTOD_SEC_MAX		(KTIME_SEC_MAX - TIME_UPTIME_SEC_MAX)
+
 static inline int timespec64_equal(const struct timespec64 *a,
 				   const struct timespec64 *b)
 {
@@ -99,6 +110,16 @@ static inline bool timespec64_valid_stri
 		return false;
 	return true;
 }
+
+static inline bool timespec64_valid_settod(const struct timespec64 *ts)
+{
+	if (!timespec64_valid(ts))
+		return false;
+	/* Disallow values which cause overflow issues vs. CLOCK_REALTIME */
+	if ((unsigned long long)ts->tv_sec >= TIME_SETTOD_SEC_MAX)
+		return false;
+	return true;
+}
 
 /**
  * timespec64_to_ns - Convert timespec64 to nanoseconds
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -171,7 +171,7 @@ int do_sys_settimeofday64(const struct t
 	static int firsttime = 1;
 	int error = 0;
 
-	if (tv && !timespec64_valid(tv))
+	if (tv && !timespec64_valid_settod(tv))
 		return -EINVAL;
 
 	error = security_settime64(tv, tz);
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1221,7 +1221,7 @@ int do_settimeofday64(const struct times
 	unsigned long flags;
 	int ret = 0;
 
-	if (!timespec64_valid_strict(ts))
+	if (!timespec64_valid_settod(ts))
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
@@ -1278,7 +1278,7 @@ static int timekeeping_inject_offset(con
 	/* Make sure the proposed value is valid */
 	tmp = timespec64_add(tk_xtime(tk), *ts);
 	if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_strict(&tmp)) {
+	    !timespec64_valid_settod(&tmp)) {
 		ret = -EINVAL;
 		goto error;
 	}
@@ -1527,7 +1527,7 @@ void __init timekeeping_init(void)
 	unsigned long flags;
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
-	if (timespec64_valid_strict(&wall_time) &&
+	if (timespec64_valid_settod(&wall_time) &&
 	    timespec64_to_ns(&wall_time) > 0) {
 		persistent_clock_exists = true;
 	} else if (timespec64_to_ns(&wall_time) != 0) {
