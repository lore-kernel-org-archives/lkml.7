Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28011C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41332073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gk8acHSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfG2WBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:01:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfG2V6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so63467774wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fNHGKrtYyQ4hfdzT0liaJu2rBvdvAZGs0hrh0PW8vk=;
        b=gk8acHSxAp1IHneLzg0GntOlQ1xc3FsUKllc/4QpuOUOLzvP1NStI+tQ9k3k8XC6w2
         GrSp6gSpxU6Svx2RPhjGJw7jbrZqHiDykvT0Pof7cxXvz0AmL5nUHZM/FOTC/k2LouEY
         /l9GT4u36q2lT2urZtfiH3W2T8inOkkVi5sVWphM5mdzktPd3tWpvdg1+1G44LdI65xO
         3Xgjo5cBq/d0yFCeZJh+1g8EvAbqI/wyNcz3+s8dwbEAzKkm24vNtDQNwT9h9qYi8ZUZ
         HptSGSG8kZ+V33caxXlz1piDKoPOmFLx9FrFlcu46f/aLWjX6TVpsPaWlhBqgGkCjSFE
         kp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fNHGKrtYyQ4hfdzT0liaJu2rBvdvAZGs0hrh0PW8vk=;
        b=dbFYdWLlX77qEwroQ/gPcF0eCuEUxjvvn8UhIc77Kem/1dzBdWNl3NWPxl7Z8ZCbXZ
         cHpS244ZVotwQNtdvwk0J5RCfvN4AjHvjK913G5bjzwkmeBbd0PB6kAHd6SviBzbQR1w
         JPEJiTqQnqHHDMNxQlVxfedCXxRM7EOW+0x0QzH5ZsVBIr1bYc3qCHxmXbFlnbzCy/V9
         ClVQaR6CznuO5r/JXjvmF9Lh3jxdSJaTFWASxE70+EAnm1KV5ll8gtLEwWUBJEKEcqOk
         jmil1YYc8GTLSUl7iIFPNMp8T+CjMobJRvLpXj4cUgoheq8F8b4pVtQmQRGK70OF2Y9D
         1bfQ==
X-Gm-Message-State: APjAAAX2Ek9GZ7mTxw1lqp5UODpkn2bB37B/8HwzgI9s73JGOIImH1dS
        ImlJL6LxAEPS18mHHFhBmOkvzmOQXRpD/P0F36Awhmrc8lpqa6USA6ZqeHlAtqEpeoD6ifF145g
        8zSrHezFKhjpRIf9Q2bjkVO5eSuEMXlMp0k2h8KePMLXNO2JHCxsT64TjO8pAlQp/ReTZuO81bT
        t/UpLl0LSljQZ66/0mDHZXDArjXZCD/8IjuJ8yxqQ=
X-Google-Smtp-Source: APXvYqyYK9fQgpnFWfxFBTucWDklwF9Z+aLUzbTMb7xKPg7fA80MEKrgyR/hUhInjTgAmLUAasM6Cw==
X-Received: by 2002:adf:f812:: with SMTP id s18mr52239162wrp.32.1564437500898;
        Mon, 29 Jul 2019 14:58:20 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:20 -0700 (PDT)
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
Subject: [PATCHv5 15/37] hrtimers: Prepare hrtimer_nanosleep() for time namespaces
Date:   Mon, 29 Jul 2019 22:56:57 +0100
Message-Id: <20190729215758.28405-16-dima@arista.com>
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
 include/linux/hrtimer.h   | 2 +-
 kernel/time/hrtimer.c     | 8 ++++----
 kernel/time/posix-stubs.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4971100a8cab..3285d75b5a0f 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -459,7 +459,7 @@ static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 /* Precise sleep: */
 
 extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
-extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
+extern long hrtimer_nanosleep(ktime_t rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5ee77f1a8a92..b67927c65410 100644
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
-- 
2.22.0

