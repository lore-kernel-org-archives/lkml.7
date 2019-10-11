Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943B7C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664F3222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LDcXU4LF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfJKBYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:24:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34948 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfJKBYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:24:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so9964484wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3q+f4NvVrAhoDuIEJ381U5JrF/SDOHUZLqiL0PqgTk=;
        b=LDcXU4LFJrDM3PaNdLgzqSfaK+fZWzTw49aOy7HUkrj0oZnkujBgDHrEfjp3wJDTSR
         6Cqxm4HSDkbRJ7n2cEvwtr/0sBpdeX57DnihFEbKSISquDreMbtvK7AXs0wftVKADk6/
         FkRF9WSUtkET521E/H4tqDsVuY9qnRdhkpdwil9IOv/CPGCPY8jHjK7L4qQaFaesJju8
         WEhUt9qcciLlqP0MudV6GGyuE8Tb7nzJyhvEQiR+IAir2A3iaNtXs2Kj7oOY7jh2bq4Q
         qYDspXTOmfoGWIQ0LTD/X7ROZyzZ0J9olLth4SceImIXPbGG0sqBhOj5l1ZROn0XVq0N
         Hm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3q+f4NvVrAhoDuIEJ381U5JrF/SDOHUZLqiL0PqgTk=;
        b=ia7KSC4oe1yN8kk5fnOGEb76LTPrJxN9DO3QclpWI64dZRDlXZNxVcmSg94dAh1/d6
         jCfnPAxIWcwrcfChIEsRV3S9NXLCn7J7j+h0hQRQBW4zFndAWeTuFGX4vHSgKgbdvn5X
         K6RSO3+qZbiNwKRlF2Bv2xoLim85egjoSFWKzogCHiebrbEcuf9I04Locmp6JdGaMa9y
         EJSxxIFA8JLz1SfkiH04KZlEIuRL2/HXNlypFR9dp4nVz4vdz84qoSmiLH0LWchK0HnP
         eA8UK/9aE0DgVkAd8oUiwn1CBQHV4EwG8Myj3aK7Tshn4oQUzcgrzIhYikWJ0JNONuRp
         GXdQ==
X-Gm-Message-State: APjAAAUpmy18ehVFzXxtT3PJ0BZjneYisN08k/6CF4BoQntITQDgaJFR
        tBsqvycJheScP0GdAq4fEpdzNR2zV5s=
X-Google-Smtp-Source: APXvYqzxL0v15OktBaQ7kHJ7K+TbQl2tyWfwup9BSfn4V7IEG18nMJsjXMC93JWip0t/jANFTiBnxQ==
X-Received: by 2002:a5d:674e:: with SMTP id l14mr10347581wrw.45.1570757046510;
        Thu, 10 Oct 2019 18:24:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:05 -0700 (PDT)
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
Subject: [PATCHv7 14/33] hrtimers: Prepare hrtimer_nanosleep() for time namespaces
Date:   Fri, 11 Oct 2019 02:23:22 +0100
Message-Id: <20191011012341.846266-15-dima@arista.com>
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
index 1b9a51a1bccb..cdcb2e9cd54a 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -502,7 +502,7 @@ static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 /* Precise sleep: */
 
 extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
-extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
+extern long hrtimer_nanosleep(ktime_t rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0d4dc241c0fb..19cc504bd7cc 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1907,7 +1907,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	return ret;
 }
 
-long hrtimer_nanosleep(const struct timespec64 *rqtp,
+long hrtimer_nanosleep(ktime_t rqtp,
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
@@ -1920,7 +1920,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -1955,7 +1955,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
 #endif
@@ -1975,7 +1975,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 
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
index 6e350cc8f600..c0ae1f6d2add 100644
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
2.23.0

