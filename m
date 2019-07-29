Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118CEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A49217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Xy548qQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfG2V7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:59:07 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40518 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbfG2V7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:59:05 -0400
Received: by mail-wr1-f44.google.com with SMTP id r1so63464341wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lH88XV9r6cFcrzQoc1UDCcNiRR0jvPMk1+ATCF2kgD4=;
        b=Xy548qQSb+xfuZ2hDKkBweJzrXVNTw3/V1XctADC2LGljB1FivSMofnUVT7LCBHpMK
         iIh4/bQoGLJqTN5qWKtcV2zw5A/z05YGFsYnOLnRT87haxXtQ8mM6dYIXbsck0K337ub
         B2LuwiOIDmgzUUFeZnYXkHU+v1o+RjsuzRtHR0s0lEhKlNZs+auJBiedthZMcV8KJ1Ew
         o3i8LcRQ5z1cOui+N6zjFYupIRdOm2GqFm5G+DvEh19AdhU3Prvd67iz/NuxLndpnrTL
         hvtZfAzrd/WgSBPksMdNiZqJ9A1HgID82Ko9gpL3iPVJjoABkNx0bUZBP61iXxN7SbN7
         KUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lH88XV9r6cFcrzQoc1UDCcNiRR0jvPMk1+ATCF2kgD4=;
        b=rqpes0kawoS/p0Ota56wCkh3F9lXOZSVjkzrdqC9zIvbR6khPHdl4bYLbFb6D6Ns1M
         R3ezzwVlW02NUSVT/4qbH/sd+XZN64FkjC7z8a4CWHJNYIVQoRN78GCygL7GiZAQz62a
         HuFMGnW5taMGWST4Rl708+G/S995w0fJ3R0nL4SnZtNPCSTwOz9bqvBV3f11tGnaZr2e
         7hCZcg136dznFNK37ZjNRJ56akNtjDf/iBYvC6t8GQXqP+qpWD5SsL2zC7sO+YLrqQup
         /8l0Cutej0A1nlHNnx39+YDWveQsJ2b6YrQxWUTjSBHIBxZquIEhN0lxquPs8QwYOT0T
         IE5g==
X-Gm-Message-State: APjAAAVr802DGlCgk3vswV+8rBW4XYJk9xe8t5wJV+N5Qo+IsT5mCpgi
        Y1mptOuaKkZDnCK7ol9VGmprPjdcHE35O8+k9S+cuE9m19vBwsKFVLWFTM8g2nlbOExIOZmTfE9
        Dw2yJtSWv/sHhLpaixJbWCP2St0Atd23ApCkjdEX7KgPkSGzL4wJX7PBDuL9aXbWuFdQo1ydCdm
        wkJKbrmeKUfw07DfniXlqVnW1m03ZAZXQ3eQg/GtU=
X-Google-Smtp-Source: APXvYqwCKIBxknKA1+GQRLo59N3ZkV5ymLn4qw2YKJXd3bG+w5CHQN8kRN1y3Ej3K9Gmm8LHX3Ny7g==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr78549454wrm.87.1564437543085;
        Mon, 29 Jul 2019 14:59:03 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 07/37] posix-clocks: Introduce clock_get_ktime() callback
Date:   Mon, 29 Jul 2019 22:57:27 +0100
Message-Id: <20190729215758.28405-46-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

The callsite in common_timer_get() has already a comment:
    /*
     * The timespec64 based conversion is suboptimal, but it's not
     * worth to implement yet another callback.
     */
    kc->clock_get(timr->it_clock, &ts64);
    now = timespec64_to_ktime(ts64);

The upcoming support for time namespaces requires to have access to:
- The time in a task's time namespace for sys_clock_gettime()
- The time in the root name space for common_timer_get()

That adds a valid reason to finally implement a separate callback which
returns the time in ktime_t format.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c   | 19 ++++++++++++++++++-
 kernel/time/posix-timers.c | 26 +++++++++++++++++++++++++-
 kernel/time/posix-timers.h |  3 +++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index d9e6baa9976a..55cb6e78d082 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -651,7 +651,7 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
- * Provides the underlying alarm base time.
+ * Provides the underlying alarm base time in a tasks time namespace.
  */
 static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
@@ -663,6 +663,22 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	return base->get_timespec(base->base_clockid, tp);
 }
 
+/**
+ * alarm_clock_get_ktime - posix clock_get_ktime interface
+ * @which_clock: clockid
+ *
+ * Provides the underlying alarm base time in the root namespace.
+ */
+static ktime_t alarm_clock_get_ktime(clockid_t which_clock)
+{
+	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
+
+	if (!alarmtimer_get_rtcdev())
+		return -EINVAL;
+
+	return base->get_ktime();
+}
+
 /**
  * alarm_timer_create - posix timer_create interface
  * @new_timer: k_itimer pointer to manage
@@ -826,6 +842,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
+	.clock_get_ktime	= alarm_clock_get_ktime,
 	.clock_get_timespec	= alarm_clock_get_timespec,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a600b8b3e9bf..fb1848c84241 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -172,6 +172,11 @@ posix_clock_realtime_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 	return 0;
 }
 
+static ktime_t posix_clock_realtime_get_ktime(clockid_t which_clock)
+{
+	return ktime_get_real();
+}
+
 /* Set clock_realtime */
 static int posix_clock_realtime_set(const clockid_t which_clock,
 				    const struct timespec64 *tp)
@@ -194,6 +199,11 @@ int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 	return 0;
 }
 
+static ktime_t posix_get_ktime(clockid_t which_clock)
+{
+	return ktime_get();
+}
+
 /*
  * Get monotonic-raw time for posix timers
  */
@@ -229,12 +239,22 @@ int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *
 	return 0;
 }
 
+static ktime_t posix_get_boottime_ktime(const clockid_t which_clock)
+{
+	return ktime_get_boottime();
+}
+
 static int posix_get_tai_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_clocktai_ts64(tp);
 	return 0;
 }
 
+static ktime_t posix_get_tai_ktime(clockid_t which_clock)
+{
+	return ktime_get_clocktai();
+}
+
 static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 {
 	tp->tv_sec = 0;
@@ -782,7 +802,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
 	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
-	 * functions which use timr->kclock->clock_get_timespec() work.
+	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
 	 * use ABSTIME, so it needs to switch back.
@@ -1228,6 +1248,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_clock_realtime_get_timespec,
+	.clock_get_ktime	= posix_clock_realtime_get_ktime,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1245,6 +1266,7 @@ static const struct k_clock clock_realtime = {
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_timespec,
+	.clock_get_ktime	= posix_get_ktime,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1274,6 +1296,7 @@ static const struct k_clock clock_monotonic_coarse = {
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get_ktime	= posix_get_tai_ktime,
 	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
@@ -1289,6 +1312,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get_ktime	= posix_get_boottime_ktime,
 	.clock_get_timespec	= posix_get_boottime_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index b3cc9ee36a6b..183994f7e466 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -6,8 +6,11 @@ struct k_clock {
 				struct timespec64 *tp);
 	int	(*clock_set)(const clockid_t which_clock,
 			     const struct timespec64 *tp);
+	/* Returns the clock value in the current time namespace. */
 	int	(*clock_get_timespec)(const clockid_t which_clock,
 				      struct timespec64 *tp);
+	/* Returns the clock value in the root time namespace. */
+	ktime_t	(*clock_get_ktime)(const clockid_t which_clock);
 	int	(*clock_adj)(const clockid_t which_clock, struct __kernel_timex *tx);
 	int	(*timer_create)(struct k_itimer *timer);
 	int	(*nsleep)(const clockid_t which_clock, int flags,
-- 
2.22.0

