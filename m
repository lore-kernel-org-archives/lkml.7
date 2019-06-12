Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A41C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D90D215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WiFBUdjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfFLT0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:26:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfFLT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so18129517wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVoz266rOhzBvq1+fckdm28R8FS758kT1jJN+dLbL8A=;
        b=WiFBUdjE8xWhBn9cC4dZyzht9pQDrd7MLBhLhWmk3GB2CQunKSEgt6uj3NIoSuy2/f
         Py2ewqFlKgHEEhoyaVNLcVMVSjW9146l4m0MOsgyBrVC6stj+jPg0gPPw0Bw11szuBPe
         za0uzX03kb3JeX5CX2q33rO3LKbQI0NC3mqThbYVoX9xp4ujwSt8fYymhaTBrZd/Jv4g
         sSchxuk/8xp4+a7GWlFACFxzIa+uZinksMrx8GOL8pLyUNH57zxzWkhcX9tt0EvIZYxI
         6UiGobqqIwf5E/MqgjwcHjKQPq9evXxrZAQJKBl1DlXRi9+6GzINpcop/pSKqmFhajqD
         DuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVoz266rOhzBvq1+fckdm28R8FS758kT1jJN+dLbL8A=;
        b=S3y7f+a262dna4BHw4qYpKTO98n5ZP0b5MeMMDG92MNkLIh/Y33amOcLM7sY9Pv6se
         3Uy1zASXfVkjIVPfUztSa1CVvNUaXHeFzoGTgmpLvf3Lncc2lpgLbmorPov4zgF3ImJs
         g5OrTS5GE6+ccofnrhQITr3naCxY/AUnLuVwNKAxDFosQ9GTkLqgL3Er4AAHrmPv3Xlv
         0ZSLgKPKKF5dtZTygAB/1au5+I9p+JClfs7cOQsvIc+w2QB99d9Ri9/E+jLS4/JnOgNd
         78KdMXa3NrXLFrS5P7iXqbhUIV1pffYDGJ03aBaL/dse1y4r0diFrxNfLuMksH+SRgVi
         3MOQ==
X-Gm-Message-State: APjAAAUwGE+udjuayBLf8b+cwGlN5wGMuf9/ltdQF/+ZTIrDyLCS6kav
        9kKDpkoFHUyva6YsV0N+68Gxf/1YflI=
X-Google-Smtp-Source: APXvYqx+PJkYZMSI9t5sNkdtGQlgjC+5XYuoJ3aCb5UMpFJcNHRTFUxNRNF/4WQnfBFB2DpiJhgRuw==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr13313189wrg.39.1560367601555;
        Wed, 12 Jun 2019 12:26:41 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:40 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 08/28] timens/kernel: Take into account timens clock offsets in clock_nanosleep
Date:   Wed, 12 Jun 2019 20:26:07 +0100
Message-Id: <20190612192628.23797-9-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire up clock_nanosleep() to timens offsets.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/hrtimer.h    |  2 +-
 kernel/time/alarmtimer.c   |  2 ++
 kernel/time/hrtimer.c      |  8 ++++----
 kernel/time/posix-stubs.c  | 12 ++++++++++--
 kernel/time/posix-timers.c | 19 ++++++++++++++++---
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2e8957eac4d4..5a3b3e17d0e8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -473,7 +473,7 @@ static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 /* Precise sleep: */
 
 extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
-extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
+extern long hrtimer_nanosleep(ktime_t rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 6346e6ee0d32..f1f42df179d0 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -819,6 +819,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].gettime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 41dfff23c1f9..b245f6ff9c8f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1716,7 +1716,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	return ret;
 }
 
-long hrtimer_nanosleep(const struct timespec64 *rqtp,
+long hrtimer_nanosleep(ktime_t rqtp,
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
@@ -1729,7 +1729,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 		slack = 0;
 
 	hrtimer_init_on_stack(&t.timer, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -1764,7 +1764,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
 #endif
@@ -1784,7 +1784,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 #endif
 
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index edaf075d1ee4..4ee0dc180866 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -129,6 +129,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		struct __kernel_timespec __user *, rmtp)
 {
 	struct timespec64 t;
+	ktime_t texp;
 
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -147,7 +148,10 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(clockid, texp;
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -215,6 +219,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 t;
+	ktime texp;
 
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -233,7 +238,10 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(clockid, texp;
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dba77ee48e74..bb457962fc7c 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1194,7 +1194,20 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
 {
-	return hrtimer_nanosleep(rqtp, flags & TIMER_ABSTIME ?
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+				 which_clock);
+}
+
+static int common_nsleep_timens(const clockid_t which_clock, int flags,
+			 const struct timespec64 *rqtp)
+{
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -1275,7 +1288,7 @@ static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_timespec,
 	.clock_get_ktime	= posix_get_ktime,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
@@ -1322,7 +1335,7 @@ static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_ktime	= posix_get_boottime_ktime,
 	.clock_get_timespec	= posix_get_boottime_timespec,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
-- 
2.22.0

