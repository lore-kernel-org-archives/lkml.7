Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FC9C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E816F20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="m63Jd0nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfFSOYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:24:13 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55123 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfFSOYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:24:13 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id bc50ebed;
        Wed, 19 Jun 2019 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=oQdrKImMCKqyw1vdhgoyL18i+yY=; b=m63Jd0nDH93RkAadDJ0Z
        iHcovby5TLYtT2uaXZOQDqZTheJw8moI03cYsLMllc0PLGIot01QoBLCYQ5O7fKs
        SrpwqZgD7FiJRIhclOqgcjRiZfnnnuELkp3FWwVUV9WzaoLwDtV4kGuasZ6rpo3/
        6gQ/T8KlyhY+k7PEG3eM18Vqe79ME43T0o+Ldd94b09E9t4g4KLqyhqXdO0M3CLf
        TVmWXvYQN/+R9Z52PZo8/qMu2sQD9FCj7irUqq6ENemHMN8AGR3rrKbXqKB8Mvh/
        9ITs/tMph1oleKdfVxTVME3jCtiMGq/Pfd8jmThcCt7swCcE40EmH7PCKAf6lw2Y
        wg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bba5e044 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jun 2019 13:51:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] timekeeping: get_jiffies_boot_64() for jiffies that include sleep time
Date:   Wed, 19 Jun 2019 16:23:50 +0200
Message-Id: <20190619142350.1985-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables using the usual get_jiffies_64() but taking into account
time spent sleeping, giving the high performance characteristics of
querying jiffies without the drawback.

We accomplish this by precomputing the boottime jiffies offset whenever
it is updated, rather than doing the expensive-ish div_u64 on each
query.

Since the resolution of this is in terms of jiffies, this allows
determining limits for comparison in terms of jiffies too, which makes
the comparisons more exact, despite jiffies being a fairly coarse stamp.

Adding the suspend offset to jiffies as such doesn't actually race in a
way different from the usual races associated with the suspend offset:
either boot offset has been updated before the call to
get_jiffies_boot_64(), in which case we're fine, or it hasn't in which
case, this is no different than any of the existing suspend querying
functions, which may be invoked early in system resumption before the
offset is updated.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc; John Stultz <john.stultz@linaro.org>
---
 include/linux/jiffies.h             |  1 +
 include/linux/timekeeper_internal.h |  2 ++
 kernel/time/timekeeping.c           | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1b6d31da7cbc..e4a9776d8b2a 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -80,6 +80,7 @@ extern int register_refined_jiffies(long clock_tick_rate);
 extern u64 __cacheline_aligned_in_smp jiffies_64;
 extern unsigned long volatile __cacheline_aligned_in_smp __jiffy_arch_data jiffies;
 
+u64 get_jiffies_boot_64(void);
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);
 #else
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 7acb953298a7..2e4c52fe0250 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -51,6 +51,7 @@ struct tk_read_base {
  * @wall_to_monotonic:	CLOCK_REALTIME to CLOCK_MONOTONIC offset
  * @offs_real:		Offset clock monotonic -> clock realtime
  * @offs_boot:		Offset clock monotonic -> clock boottime
+ * @offs_boot_jiffies64	Offset clock monotonic -> clock boottime in jiffies64
  * @offs_tai:		Offset clock monotonic -> clock tai
  * @tai_offset:		The current UTC to TAI offset in seconds
  * @clock_was_set_seq:	The sequence number of clock was set events
@@ -93,6 +94,7 @@ struct timekeeper {
 	struct timespec64	wall_to_monotonic;
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
+	u64			offs_boot_jiffies64;
 	ktime_t			offs_tai;
 	s32			tai_offset;
 	unsigned int		clock_was_set_seq;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 85f5912d8f70..a3707b454446 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -146,6 +146,7 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
 	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+	tk->offs_boot_jiffies64 = nsecs_to_jiffies64(ktime_to_ns(tk->offs_boot));
 }
 
 /*
@@ -539,6 +540,16 @@ u64 ktime_get_real_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
 
+/**
+ * get_jiffies_boot_64 - The normal get_jiffies_64(), but taking into
+ * account the time spent sleeping.
+ */
+u64 get_jiffies_boot_64(void)
+{
+	return get_jiffies_64() + tk_core.timekeeper.offs_boot_jiffies64;
+}
+EXPORT_SYMBOL(get_jiffies_boot_64);
+
 /**
  * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
  * @tk: Timekeeper to snapshot.
-- 
2.21.0

