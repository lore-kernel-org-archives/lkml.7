Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1C9ECE596
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0B121929
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Q23XmaHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfJKBX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:23:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51385 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfJKBXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:23:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so8709337wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6IGs3DqCYWS3x9g6024V9Wrc1jExu7c/j35TX6JLyQ=;
        b=Q23XmaHyOJpkaxwXiDu45LsC+DIYelVH843K9ooQBsTnaYyQO9vJfzASJ5P6DkRlYF
         F5ZnQ4VKSeAz8aWEEPXWcwyTvcyWd3hmJguqzkh6LAO4MOhU/BPMbNNimYDf509Bwadg
         F1WZan4/Gy9/cMs9Otib8PRdTl9ATk4HBqa6FJ1g8s35Jcr7rIlwsX945zfBpysnI2Zi
         xBgMtqcgHyLzNP4Q3f480R7iMarBIsN6MJhxoLu0UeRhwcRyAQaX1SvKoQJ52wb9FcMN
         d+Cip6oJkCGYXdxjH7tfr7vN9GYLI1o50pxwWU84DZNMh5S5T0ngyk+BBfHpOzOBPsfp
         xZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6IGs3DqCYWS3x9g6024V9Wrc1jExu7c/j35TX6JLyQ=;
        b=cshEosd+h0fBosRuPz628uF/3lEM9SwJ/atqgVMeUPh01f9XsXykUVUryf0sI2uccp
         w688YhQaGzDDu/z+BQ34oW1QTQtQbJQsNMfvZbO5aM35mfvBgmuFWGsaNfikFbMwSqEX
         kt5Ai7ipDnMrFuhZ0A1y63ous8eD4CXYmIG10SqRGNnz2t70/zegWdrs6FlrdbMHkb8U
         VjX0KWrsC2ajQQ0WhzGQ6P6rporBrbIV2Do2JoCaXp4B9JjrCZpqGzCkJoX1t34HLCRn
         iSOIMlBRNvaUicPODSvIyJujJ1+2fUJ9VreqBbAtoqnKwAq2/O1qwq7brL9+2vE/IVfg
         tODg==
X-Gm-Message-State: APjAAAUC5ZYqu9cKbEdb2XGaItACHjESW4E4YNId5NE6MuJh7hHKbV1R
        hBLOv2G3k3mPgVZP/P8B/lE/j7N18po=
X-Google-Smtp-Source: APXvYqwJyzwLB/VN5PdfuhSc2UodAei8QtDcOoYPlKvd5mtJY/i7gZPVU23JIIZymy4b+xTYyRapRg==
X-Received: by 2002:a1c:a8c7:: with SMTP id r190mr878253wme.148.1570757031378;
        Thu, 10 Oct 2019 18:23:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:50 -0700 (PDT)
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
Subject: [PATCHv7 04/33] posix-clocks: Rename .clock_get_timespec() callbacks accordingly
Date:   Fri, 11 Oct 2019 02:23:12 +0100
Message-Id: <20191011012341.846266-5-dima@arista.com>
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
 kernel/time/posix-timers.c | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8523df726fee..62b06cfa710d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -657,13 +657,13 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
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
 
@@ -837,7 +837,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
-	.clock_get_timespec	= alarm_clock_get,
+	.clock_get_timespec	= alarm_clock_get_timespec,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_del		= common_timer_del,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 44d4f9cb782d..68d4690cc225 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -165,7 +165,7 @@ static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 }
 
 /* Get clock_realtime */
-static int posix_clock_realtime_get(clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
 	return 0;
@@ -187,7 +187,7 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 /*
  * Get monotonic time for posix timers
  */
-static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
+static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
 	return 0;
@@ -222,13 +222,13 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
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
@@ -1261,7 +1261,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_clock_realtime_get,
+	.clock_get_timespec	= posix_get_realtime_timespec,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1279,7 +1279,7 @@ static const struct k_clock clock_realtime = {
 
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_ktime_get_ts,
+	.clock_get_timespec	= posix_get_monotonic_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1310,7 +1310,7 @@ static const struct k_clock clock_monotonic_coarse = {
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_get_tai,
+	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1326,7 +1326,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_get_boottime,
+	.clock_get_timespec	= posix_get_boottime_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
-- 
2.23.0

