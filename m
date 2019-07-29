Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BDBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AE6216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ph1as7xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfG2V63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51181 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbfG2V6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so55211129wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZD/33EYsNqEzCkGdMeNCZ0TyamYZZvmW6eDfpRWPQu8=;
        b=Ph1as7xg/gaBW1DHIs/c0qsb5PixYtrtivQc0qQ6iZI79HoSESjBpIGMaYOblnayby
         S5fp9U3spj3iLlIBx09JYl5PcjDXnceK9RgTk4wN662q270mSlLKtZCboMFWCTPFpuMn
         5WlCUQ75ejOdc6R0Go1yisJVs8D69L8SKA/n95qr3cnFfJW+p92TyDqwr8d3EAD6JruU
         4rq92vsoZ0hXJkbI0/u9ewPdvAQT6ZXO/m1Y/sq67t1tRvUmeLFVy+fxo96x0/f+NRb+
         8wbysPwvuSUFHCCPJrCogl4AQxCRh7iuieGUhmIucuL5rZ3I33bEF2eNMlFpI6Nej8V7
         /wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZD/33EYsNqEzCkGdMeNCZ0TyamYZZvmW6eDfpRWPQu8=;
        b=Y6+oa+JgyLCJvIAemCHS/1i8GZTn6ZJ4CSfOwX1+7bxv4FIq/OPQTpjSrW2+cI0JxF
         rZJR+lvRLgFnhvm171fKttr/KCKrCVsHXu2rZEUQbdEGrj+KaH89xWdCC/ErH8xSQ4ka
         7973VuTsEaWFyvluH2fBTCGNnrZgMLLraRnAJkTIW7d13WWlwPxwd0KlXYLqQMGD8M3Q
         4NYV4iTS7NhkzmeB+F08p+8/cMkWdDbttlMENPPDMGsDUoysbvw5f5h0Viunah/2PU4R
         7do8IxfNzc6i4QD2da1Iz8NAkHwkl2awEWH/TwKVrzBLYNW8RoHaEMq/RTf9Avx5tBSI
         TgHg==
X-Gm-Message-State: APjAAAVARVDM9QifnseS0P6JXMrXlSBZw/tofv87byazDEGfKG6I6Cch
        nIIhwU9KDBUQ332yqVIyKbgVEDjMIB8r166yfeCJe7A8UM+WpfKGVfa3lEjhF/+mmIeOepKnSBC
        PYV9WDgXjCY8JBKHoGozfqllfYFYlWJYYM4IJfR27HemeSoRbBUR714DpDn6siQewaYDkfi0AOc
        YrRHam+JvGHc5fAm6VLoeryast6T26V+z4SpcS+1A=
X-Google-Smtp-Source: APXvYqwOOvbVEUILr0wWJIqDpi7/r6h2ZijHMaEWQ1hj5ao3ABGZvNHCxxl0owKFSC8B+1qtENGLcw==
X-Received: by 2002:a1c:d108:: with SMTP id i8mr105848176wmg.28.1564437502352;
        Mon, 29 Jul 2019 14:58:22 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:21 -0700 (PDT)
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
Subject: [PATCHv5 16/37] posix-timers: Make clock_nanosleep() time namespace aware
Date:   Mon, 29 Jul 2019 22:56:58 +0100
Message-Id: <20190729215758.28405-17-dima@arista.com>
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

clock_nanosleep() accepts absolute values of expiration time, if the
TIMER_ABSTIME flag is set. This value is in the task time namespace,
which has to be converted to the host time namespace.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-stubs.c  | 12 ++++++++++--
 kernel/time/posix-timers.c | 21 ++++++++++++++++++---
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 2ccefc9ce184..47ee2684d250 100644
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
-	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(clockid, texp);
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
-	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(clockid, texp);
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index c979e720a5a1..4dc46d697144 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1187,7 +1187,22 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
 {
-	return hrtimer_nanosleep(rqtp, flags & TIMER_ABSTIME ?
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+				 which_clock);
+}
+
+static int common_nsleep_timens(const clockid_t which_clock, int flags,
+			 const struct timespec64 *rqtp)
+{
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -1268,7 +1283,7 @@ static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_timespec,
 	.clock_get_ktime	= posix_get_ktime,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
@@ -1315,7 +1330,7 @@ static const struct k_clock clock_boottime = {
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

