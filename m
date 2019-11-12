Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE757C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B6E2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Dtucj0Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfKLB3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:29:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52001 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKLB14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so1308917wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QSyARFWIK6uOGXZsENehl+9u6WqpNxgPV/MnuNjbc1w=;
        b=Dtucj0GkD6042y6rE/761DHzXGQycoNHqI6YrpuY/a+k+losT7M82FZB4jczHe+ePK
         T2+MUhORQVwyraNjCbXsVuid09DC5PJU9tYZxq///N7fyBs9HcvL7mpG51OOyLIo6Pxn
         OxGdDuLzXsVpOEU3JD4Z2yll0L6TSsmcPHFKFd3M+EnAOfb1EqPzpIrF6XuNawuZj4zC
         vKc6ttFLR0YQvtyoRs0szItNOdx4thAipxxYK+dyXE/qZQJ2ZNM7gThomLXgAPMs9K32
         IVlDrCaQLENmWR+x5MnNh16wZwoxzmFSS0rHGkpt/a2KtLwjsQYJXNiwFR+Tn6rsWYXQ
         Iy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QSyARFWIK6uOGXZsENehl+9u6WqpNxgPV/MnuNjbc1w=;
        b=rJqSP+pPu2dHp0OlRiG1qITEK3dTCFVNz1BBfLjNdPl11mKVKUpO6rZRdZak1vfcNx
         4BEWShi3F80Br3Z+/qV8/oW/fHqYo0ncSfoywpoNfilt5fy+eAgY0bBftOBekzfNFkf9
         uam3SOrnF3+DXB+SfxnBTfhrG7MtvmQZRAuooTE3ptGYa4x4amW8Y+W/2Wei6Kr6dACu
         fly8Cb2pX6X1+4T3Kdd88KcHqtYhIiPJ8IxH1L4hGWQz6gP0U0lE9fWqXnkvR+HphDxk
         nkGdUHnLthSibsiMichkboM4K1y1awUpZGdqd1ajjSsQoMVzrhdY53L1yzXL/OlwG8ip
         q7QA==
X-Gm-Message-State: APjAAAW11rFd+bofr5rfRSPWuCjFQzE4D8Bz5snQpBhlHJEzb83kbJR7
        pcg5bSCu2Bg6tlypVkqgsTOWosEyYjA=
X-Google-Smtp-Source: APXvYqxvCTBFohBTQdcAmfBQc4wl/6+iOL6PI5enbIKDW0YiZoJnqYbrMxJk2tR8PdtKAPiES1R1Fg==
X-Received: by 2002:a1c:46:: with SMTP id 67mr1624917wma.51.1573522074607;
        Mon, 11 Nov 2019 17:27:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:54 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: [PATCHv8 17/34] posix-timers: Make clock_nanosleep() time namespace aware
Date:   Tue, 12 Nov 2019 01:27:06 +0000
Message-Id: <20191112012724.250792-18-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

clock_nanosleep() accepts absolute values of expiration time, if the
TIMER_ABSTIME flag is set. This value is in the task time namespace,
which has to be converted to the host time namespace.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-stubs.c  | 12 ++++++++++--
 kernel/time/posix-timers.c | 17 +++++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 2ccefc9ce184..c9aba9c5df2b 100644
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
+		texp = timens_ktime_to_host(which_clock, texp);
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -215,6 +219,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 t;
+	ktime_t texp;
 
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -233,7 +238,10 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 75fee6e39e5a..ff0eb30de346 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1228,6 +1228,19 @@ static int common_nsleep(const clockid_t which_clock, int flags,
 				 which_clock);
 }
 
+static int common_nsleep_timens(const clockid_t which_clock, int flags,
+			 const struct timespec64 *rqtp)
+{
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+				 which_clock);
+}
+
 SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		const struct __kernel_timespec __user *, rqtp,
 		struct __kernel_timespec __user *, rmtp)
@@ -1305,7 +1318,7 @@ static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_monotonic_timespec,
 	.clock_get_ktime	= posix_get_monotonic_ktime,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
@@ -1354,7 +1367,7 @@ static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_ktime	= posix_get_boottime_ktime,
 	.clock_get_timespec	= posix_get_boottime_timespec,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
-- 
2.24.0

