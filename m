Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B9EC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8703421721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KdrPOwRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfFNJss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:48:48 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42673 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfFNJsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:48:47 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 804ca5b2;
        Fri, 14 Jun 2019 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=VkYJVYtHlt5aBo7n1DqDvX0ye
        30=; b=KdrPOwRWd8YUIDI35oOnyeZ3aJYw09QgkyKSN1lS3VPVDgGs82sHBKoYC
        s35uyyKwRcMtvrp51HMy3QcrKYn2wopyryWFIM6o3WYMP38/Wn4nSZV0C2/prGLd
        sr1W1+SMxfNL44v6svSJiP2MaSoKXWtj47UeZv5SookWETJDKehEUT+TPy5VBQ1E
        UxQeAWdJQP1KIs6ATlamnSBYNJuhiz9cZzEfsJGx//mk8cTQ7eXX04wdTk+mqTox
        1NaX0NDxi3+TM20oHAP5R4RsmiQM3Y44cnfXw3wNnfmPPLTg9cX55PbMnWGw2vXv
        NQCZLQPknF9ng66BFYZ3ZTvvM8iTw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5fa78a8d (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 14 Jun 2019 09:16:17 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] timekeeping: add get_jiffies_boot_64() for jiffies including sleep
Date:   Fri, 14 Jun 2019 11:48:31 +0200
Message-Id: <20190614094831.14087-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9qa-8J0-x8zmcBrSg_iyPNS02h5CFvhFfXpNth60OQsBg@mail.gmail.com>
References: <CAHmME9qa-8J0-x8zmcBrSg_iyPNS02h5CFvhFfXpNth60OQsBg@mail.gmail.com>
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

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeper_internal.h |  2 ++
 include/linux/timekeeping.h         |  2 ++
 kernel/time/timekeeping.c           | 12 ++++++++++++
 3 files changed, 16 insertions(+)

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
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index a8ab0f143ac4..511803c9cae2 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -151,6 +151,8 @@ extern u64 ktime_get_raw_fast_ns(void);
 extern u64 ktime_get_boot_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
+extern u64 get_jiffies_boot_64(void);
+
 /*
  * timespec64/time64_t interfaces utilizing the ktime based ones
  * for API completeness, these could be implemented more efficiently
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 85f5912d8f70..83c675bcd88a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -146,6 +146,7 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
 	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+	tk->offs_boot_jiffies64 = nsecs_to_jiffies64(ktime_to_ns(tk->offs_boot));
 }
 
 /*
@@ -539,6 +540,17 @@ u64 ktime_get_real_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
 
+/**
+ * get_jiffies_boot_64 - The normal get_jiffies_64(), but taking into
+ * account the time spent sleeping. This does not do any sort of locking
+ * on the time spent sleeping.
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

