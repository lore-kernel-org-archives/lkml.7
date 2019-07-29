Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7437AC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5FF20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LJri4FMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfG2WCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:02:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38296 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389130AbfG2V6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so63467155wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amUBabhq3iz84v9jP6ehP07nPslt2z15Me58KiIaa/4=;
        b=LJri4FMzy4HQ0VM0DQPPW9fj40lkur/5Za1ItvFtIU7eaTBZPFq44Eoa6mmIips5Gk
         E+I5BbWv35m7JfgdYW2YIXnE01x6i1a1cqJEo6svqmlg7IWp+HxDVJfwik99RJhCNEbK
         vq2/ZrOvPitowSDAdWJ77hsHIP/85qOgHyzX6Vz5TqGfl66zKfOmQPVXWTfIlHXHmbuB
         394dxa6K6inBm+uFUKEo3NiNIJspoZjjM8ehqCmFJLT0pfmWuiSrbUN8ELfRM6j0jEdT
         nOcATeTHqbv9Ryfz99TplCsFVS/43U09U2Z1YLRXJPe7T0ksp3Jo8TPStOuoDWtr2e5q
         2goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amUBabhq3iz84v9jP6ehP07nPslt2z15Me58KiIaa/4=;
        b=V6lMBMsJqTvnZBmKli7gThSUJgQXHH8AuO25/uz4wWUGR8Ht4bnVeQM4E7ddw4IwC2
         q2CrWMY9GNdPdi5f6wM49FemIH6OE5ukPvhZCrOYyE6srbovWFch4ALMSCFUofuVqfVb
         3qAB0BKx/5SvGcEQCZgI7VaFD/YlEg2bBQpTK7ElgjNNQRfKjnOB3Qo5pDPyb6x6YYSC
         Sf1JcGFlPK9aQ0OmyfrrZ2XQC5mEla75kj0ANGS00BKsc+5QtW+9v76w3N/bZvu89p2S
         GWfeDKBD63jVIeXvZKFi60Rm4iewgyZW9R+X62sJzDPuMhTXn7WP+6unN6dVXngYtiyU
         iOBA==
X-Gm-Message-State: APjAAAWLY8mHXGNN4D0pWUSAXPyB/Fwwcp4ELXTJ+/kCh0JG1EQjON5o
        VTAAd1MXCfOWu2OCfWfBDYYaxv2OaikWwEVQoy+sk4P3B89WX9m+5e+gYEFciNBB4D+/Zd9SseF
        BlamK2epeNuSl3TTGiKN6pwATWA8RszsO5nhZs1wY8Qn+iznydFWS1Pd5FakJml4855SU0n1xEe
        MpgBTAlY2Fc2a+UXic6OpMwgbkgkoO4PfzstFS3E4=
X-Google-Smtp-Source: APXvYqyxozA2mr3fe17f+EuMvS8RIX3rw+EgQ9JPU4utUy9w+dY5LwUmmBe6KwjsphCnvXX1xz+gTA==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr48531624wrs.152.1564437485761;
        Mon, 29 Jul 2019 14:58:05 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:05 -0700 (PDT)
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
Subject: [PATCHv5 04/37] posix-clocks: Rename *_clock_get() functions into *_clock_get_timespec()
Date:   Mon, 29 Jul 2019 22:56:46 +0100
Message-Id: <20190729215758.28405-5-dima@arista.com>
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

The upcoming support for time namespaces requires to have access to:
  - The time in a task's time namespace for sys_clock_gettime()
  - The time in the root name space for common_timer_get()

That adds a valid reason to finally implement a separate callback which
returns the time in ktime_t format in (struct k_clock).

As a preparation ground for introducing clock_get_ktime(), the original
callback clock_get() was renamed into clock_get_timespec().
Reflect the renaming into callbacks realizations.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c   |  6 +++---
 kernel/time/posix-timers.c | 17 +++++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index cada96fdc615..c191254f178b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -644,13 +644,13 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
 }
 
 /**
- * alarm_clock_get - posix clock_get_timespec interface
+ * alarm_clock_get_timespec - posix clock_get_timespec interface
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
  * Provides the underlying alarm base time.
  */
-static int alarm_clock_get(clockid_t which_clock, struct timespec64 *tp)
+static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
 
@@ -824,7 +824,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
-	.clock_get_timespec	= alarm_clock_get,
+	.clock_get_timespec	= alarm_clock_get_timespec,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_del		= common_timer_del,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 6c9c0f2d2f1e..a71e43178a7d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -165,7 +165,8 @@ static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 }
 
 /* Get clock_realtime */
-static int posix_clock_realtime_get(clockid_t which_clock, struct timespec64 *tp)
+static int
+posix_clock_realtime_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
 	return 0;
@@ -187,7 +188,7 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 /*
  * Get monotonic time for posix timers
  */
-static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
 	return 0;
@@ -222,13 +223,13 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 	return 0;
 }
 
-static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
 	return 0;
 }
 
-static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_tai_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_clocktai_ts64(tp);
 	return 0;
@@ -1226,7 +1227,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_clock_realtime_get,
+	.clock_get_timespec	= posix_clock_realtime_get_timespec,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1243,7 +1244,7 @@ static const struct k_clock clock_realtime = {
 
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_ktime_get_ts,
+	.clock_get_timespec	= posix_get_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1273,7 +1274,7 @@ static const struct k_clock clock_monotonic_coarse = {
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_get_tai,
+	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1288,7 +1289,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_get_boottime,
+	.clock_get_timespec	= posix_get_boottime_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
-- 
2.22.0

