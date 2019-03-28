Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EC7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9694206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfC1Mqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:46:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfC1Mqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:46:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2SCkCdb3322276
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 05:46:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2SCkBJK3322273;
        Thu, 28 Mar 2019 05:46:11 -0700
Date:   Thu, 28 Mar 2019 05:46:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7a8e61f8478639072d402a26789055a4a4de8f77@git.kernel.org>
Cc:     mlichvar@redhat.com, peterz@infradead.org,
        richardcochran@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        john.stultz@linaro.org, mingo@kernel.org, yaohongbo@huawei.com,
        wangxiongfeng2@huawei.com, sboyd@kernel.org
Reply-To: peterz@infradead.org, mlichvar@redhat.com,
          richardcochran@gmail.com, arnd@arndb.de,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          john.stultz@linaro.org, mingo@kernel.org, yaohongbo@huawei.com,
          wangxiongfeng2@huawei.com, sboyd@kernel.org
In-Reply-To: <alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Force upper bound for setting
 CLOCK_REALTIME
Git-Commit-ID: 7a8e61f8478639072d402a26789055a4a4de8f77
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

Commit-ID:  7a8e61f8478639072d402a26789055a4a4de8f77
Gitweb:     https://git.kernel.org/tip/7a8e61f8478639072d402a26789055a4a4de8f77
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sat, 23 Mar 2019 11:36:19 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Mar 2019 13:41:06 +0100

timekeeping: Force upper bound for setting CLOCK_REALTIME

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
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de

---
 include/linux/time64.h    | 21 +++++++++++++++++++++
 kernel/time/time.c        |  2 +-
 kernel/time/timekeeping.c |  6 +++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index f38d382ffec1..a620ee610b9f 100644
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
@@ -100,6 +111,16 @@ static inline bool timespec64_valid_strict(const struct timespec64 *ts)
 	return true;
 }
 
+static inline bool timespec64_valid_settod(const struct timespec64 *ts)
+{
+	if (!timespec64_valid(ts))
+		return false;
+	/* Disallow values which cause overflow issues vs. CLOCK_REALTIME */
+	if ((unsigned long long)ts->tv_sec >= TIME_SETTOD_SEC_MAX)
+		return false;
+	return true;
+}
+
 /**
  * timespec64_to_ns - Convert timespec64 to nanoseconds
  * @ts:		pointer to the timespec64 variable to be converted
diff --git a/kernel/time/time.c b/kernel/time/time.c
index c3f756f8534b..86656bbac232 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -171,7 +171,7 @@ int do_sys_settimeofday64(const struct timespec64 *tv, const struct timezone *tz
 	static int firsttime = 1;
 	int error = 0;
 
-	if (tv && !timespec64_valid(tv))
+	if (tv && !timespec64_valid_settod(tv))
 		return -EINVAL;
 
 	error = security_settime64(tv, tz);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 540145da33da..5716e28bfa3c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1221,7 +1221,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 	unsigned long flags;
 	int ret = 0;
 
-	if (!timespec64_valid_strict(ts))
+	if (!timespec64_valid_settod(ts))
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
@@ -1278,7 +1278,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
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
