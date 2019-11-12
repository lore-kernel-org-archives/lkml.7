Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7A1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96CC2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YfW72cB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKLB32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:29:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42929 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfKLB1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so16648327wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBito+/l3IqXmDV4xYj44FezJEYYgWp7LEfeLT3JXrU=;
        b=YfW72cB6X6rroTnbl3+70Nq9IVS6dXj1u/sfssusKLJsc8m1TOvF9pqRtHHUCS/qVk
         hdg98V9z1AWifFezUAXnpNs9V8+F0H8zubDflD7lppwexU+jGa889w/bjLW98oMpWkuM
         lU2La54kJ4mwJ9ZU5ULOaYeLoGGSHFRfBzm4UgOaMXG2zR+RHMXMFTm8lARjq7yZRCd3
         c/RJ/EpxiYFujj4G9jKBtTJfkNlMHWekhLa6WtmZiFnrPVpdD3XrfepDS2FISvJvKT4u
         2nmqqJmmQEX0q9KtAk5dqDDRlHUmu7W9fzHpTZAazxAhA6nv4HDwC832kGyPZGLnFvpl
         Qksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBito+/l3IqXmDV4xYj44FezJEYYgWp7LEfeLT3JXrU=;
        b=ILyUw6UleEgE0izuzJBM7l0WTW00yUcaQNOxHQihKsuHlC3WfeaVm3oK8w8QrJX9ss
         2Rt5LOLkcuL9aClfP8QRMx94uyQ9fy5RV5D9hEZ26haztGzreoB3PRbIBKc77/Xt7eng
         aXb8Wds92NvhAZQlDD/42028AU7H0AI9rfVYsk45s4E3wNSMo+o/9SCcvYgdpN9KeCc4
         BpU534A28mFtDeYBY6SyuImgCbG2UfXNvm+s3naUfnPgYfGrxu2XI8/tYRU+NLaf77X8
         nX4QaQaapsYbpXXMVuDOgilzHJ6mkoEwEPxq72T+gvjh7axrBFczbVVj4kvik2q55Ya6
         fBcA==
X-Gm-Message-State: APjAAAUbEknATCJK+pdOjjD+I7xUZbEjDQ93cZJJVvukDF9V0rTuziZ+
        JYEUoFhg8UJOllPd0gZhm3dKdn9Xrv8=
X-Google-Smtp-Source: APXvYqw4y1ly/vonx9GJfvkl8OwSJLxLLaN1+Axbg2k/KGYTgtR1QZNN+t5f+S13HwUsz0ffOeLiWg==
X-Received: by 2002:adf:e911:: with SMTP id f17mr5008166wrm.300.1573522073277;
        Mon, 11 Nov 2019 17:27:53 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:52 -0800 (PST)
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
Subject: [PATCHv8 16/34] hrtimers: Prepare hrtimer_nanosleep() for time namespaces
Date:   Tue, 12 Nov 2019 01:27:05 +0000
Message-Id: <20191112012724.250792-17-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

clock_nanosleep() accepts absolute values of expiration time when
TIMER_ABSTIME flag is set. This absolute value is inside the task's
time namespace, and has to be converted to the host's time.

There is timens_ktime_to_host() helper for converting time, but
it accepts ktime argument.

As a preparation, make hrtimer_nanosleep() accept a clock value in ktime
instead of timespec64.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/hrtimer.h        | 2 +-
 kernel/time/hrtimer.c          | 8 ++++----
 kernel/time/posix-stubs.c      | 4 ++--
 kernel/time/posix-timers.c     | 4 +++-
 tools/perf/examples/bpf/5sec.c | 6 ++++--
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 1f98b52118f0..07c7c7b8b5cc 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -508,7 +508,7 @@ static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 /* Precise sleep: */
 
 extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
-extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
+extern long hrtimer_nanosleep(ktime_t rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7f31932216a1..b331128bd585 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1910,7 +1910,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	return ret;
 }
 
-long hrtimer_nanosleep(const struct timespec64 *rqtp,
+long hrtimer_nanosleep(ktime_t rqtp,
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
@@ -1923,7 +1923,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -1958,7 +1958,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
 #endif
@@ -1978,7 +1978,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 #endif
 
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index edaf075d1ee4..2ccefc9ce184 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -147,7 +147,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
+	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -233,7 +233,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
+	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 473082b0b57f..75fee6e39e5a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1221,7 +1221,9 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
 {
-	return hrtimer_nanosleep(rqtp, flags & TIMER_ABSTIME ?
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index b9c203219691..e6b6181c6dc6 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -41,9 +41,11 @@
 
 #include <bpf.h>
 
-int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
+#define NSEC_PER_SEC	1000000000L
+
+int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
 {
-	return sec == 5;
+	return sec / NSEC_PER_SEC == 5ULL;
 }
 
 license(GPL);
-- 
2.24.0

