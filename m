Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D6DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB9021D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YA4CTyNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfJKBZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:25:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39374 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfJKBX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:23:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so8513799wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dBzLvUZ1HMUXlceGUmHo7g6VNvlKm3NRrmlMP5XS+bc=;
        b=YA4CTyNrq+S2AAd3dWymSjh3eFhhYkXT9dn873NDdsvU+YM6QsJvAzIFnCqTHISgZC
         5FN4/xU3gYbt4d+mcHIIVzXMeeMXDcPb1WRxF7ts/17auiWm9zQeXmDEk6lCtNK9g/8r
         /hKSRutP4PzylP6LsTx7EK7X0L2UZHvapS9jEpqw4hDY5icsq4sc2K/dBO4T46ttlLka
         3uzGRXWh7Rk0kdn++jMISrRgZm5gtPwSP7fvX4eBvuAn2HPxlaCfbi0J7MjFo4W6v6RC
         2iAZ7dL/Di2LBaZQ3GIvT92MbALybIlXJjOCUr1g+wF6Xhpy2QADk1qRoNHZJ0fBN9eC
         wLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBzLvUZ1HMUXlceGUmHo7g6VNvlKm3NRrmlMP5XS+bc=;
        b=ljCA++uCbIO1ACHjSg4i+hrlOKjUowveek9AEfDoNYYWd1nQjCG/5WoOs9Dg+xq+zq
         uZa5enVpfb1B1JQL9hnKlMuz0a9m7IBl2+KKhALYfz9ewMkrlNbmcdm4dzH7jagpbggy
         JbpJmSju92KqViboeOthAesxoKDsyB04q4EAsGqEwZL0Hq6oaCB1hKXRwvZuEznohrN2
         OfWBTU7hVnrW0SCDuptmQNM+kUnskoeyB0Rv2STNu9GfMi0ISFCGbWkDZeWdmKJ6jCDr
         XlZvo6jXVEXdqpjxzrMhgn/bzK/O8OqSaSyubO/9F8yMLZHJDZsLvGeghLtqNjYOViH2
         v+ug==
X-Gm-Message-State: APjAAAUx1NG7e3XE2U4jL5VZeh6cVsbFVxNqLC8RXpy7qmYoSntXDn0v
        +zOBzapbUFcY2Vc4NAWsX1yXlYaoa4c=
X-Google-Smtp-Source: APXvYqybiIwl0pZTsKXh/yu7nQ7Aapy0kAifhzHVE6wp4QALY8UILTozHOvIkCP+lvNeWhBDS97NQQ==
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr928611wmg.71.1570757035939;
        Thu, 10 Oct 2019 18:23:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:55 -0700 (PDT)
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
Subject: [PATCHv7 07/33] posix-clocks: Introduce clock_get_ktime() callback
Date:   Fri, 11 Oct 2019 02:23:15 +0100
Message-Id: <20191011012341.846266-8-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 73a5458194c7..9415c83f8cca 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -664,7 +664,7 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
- * Provides the underlying alarm base time.
+ * Provides the underlying alarm base time in a tasks time namespace.
  */
 static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
@@ -676,6 +676,22 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
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
@@ -839,6 +855,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
+	.clock_get_ktime	= alarm_clock_get_ktime,
 	.clock_get_timespec	= alarm_clock_get_timespec,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e65241a46038..1d7329e8425f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -171,6 +171,11 @@ int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 	return 0;
 }
 
+static ktime_t posix_get_realtime_ktime(clockid_t which_clock)
+{
+	return ktime_get_real();
+}
+
 /* Set clock_realtime */
 static int posix_clock_realtime_set(const clockid_t which_clock,
 				    const struct timespec64 *tp)
@@ -193,6 +198,11 @@ static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64
 	return 0;
 }
 
+static ktime_t posix_get_monotonic_ktime(clockid_t which_clock)
+{
+	return ktime_get();
+}
+
 /*
  * Get monotonic-raw time for posix timers
  */
@@ -228,12 +238,22 @@ int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *
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
@@ -781,7 +801,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
 	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
-	 * functions which use timr->kclock->clock_get_timespec() work.
+	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
 	 * use ABSTIME, so it needs to switch back.
@@ -1262,6 +1282,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_realtime_timespec,
+	.clock_get_ktime	= posix_get_realtime_ktime,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1280,6 +1301,7 @@ static const struct k_clock clock_realtime = {
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_monotonic_timespec,
+	.clock_get_ktime	= posix_get_monotonic_ktime,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1310,6 +1332,7 @@ static const struct k_clock clock_monotonic_coarse = {
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get_ktime	= posix_get_tai_ktime,
 	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
@@ -1326,6 +1349,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get_ktime	= posix_get_boottime_ktime,
 	.clock_get_timespec	= posix_get_boottime_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 070611b2c253..f32a2ebba9b8 100644
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
2.23.0

