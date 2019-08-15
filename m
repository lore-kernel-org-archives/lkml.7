Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A566C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6851206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QYefj//T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfHOQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:41:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42477 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732072AbfHOQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:38:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so2751830wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x100HYg7XEpnnql2dOjok1c77wTF4zDTfnIuP2SPZV4=;
        b=QYefj//TJq7g2yjqJf2c/I2y7cz7N08zt73FEwaHiAN4HbBvQbnW3i3gO9NlezY1mj
         l5HPHO3yIBOasztabZO9D2nFd7caKB13RKqfZFtsdQReSeMRab91+8OOJ9FZVOv99mw7
         EXqjmipgh5gmQ1n8EXw/DhrOpO2Oxp4UzJKck3abPhXa7lOLaRIAjMP8qUUh5QMNOkVU
         IyKSqBW2sWFNiQmkiwnYEpnjnzt4zlDl5VVhWeFVuiYQvPY+dpXbcc8QVDUKyBfwOFt/
         ZRHxs4vvdN2mGH9XE7PtP7oxO4SK3QMdMODUDqy1y6s+KkCs3Kri/59GIIHLJQBVFgJN
         xa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x100HYg7XEpnnql2dOjok1c77wTF4zDTfnIuP2SPZV4=;
        b=YYIWZ/0fkPW4cky5wiEWSazVdF/ALTJR3/sN85jhjOBHU53TJtlPfBZrdBhOrgA+0N
         KhD0ZK3Uh2/XlEx4zX3KadlsiobeRdy5y2c2wMOaFDVqlvJ50FKJygLaVTXmvHTFaxmO
         nYL9ZSKdaz1Q7eu10sx75pD6LyqPLtyvCRN3w/Tm4KfedSacVaw/rAE4lqS2P3mX09gC
         er5KNvFGgkj56vnNCdUkKJb/05+wP62Zz0jiQvq2Fl5oHRODJ/8R87HJprXWPoosUiW4
         92ruHUq7WXZBcmAmWWTjXFibcsQQ+WUI9ESO06SRyTgWG6o2rXDMuYm2uhy4qnlmk26A
         SeUQ==
X-Gm-Message-State: APjAAAVIhq2lp4qj4AuDQiPqULo/lEQsnq3Y124y4lDECPxTBPpiE16R
        xgv4+wEDf5XAa09hBGrG97a3AyxN5Do=
X-Google-Smtp-Source: APXvYqy26CJxAp5FQbMdmP6OuvXK+Yc1g24ds0uxbQQjTRGDgnEXgbovBmRZ+ZAyo3VKXU7xAS3HKA==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr6181264wrg.325.1565887124062;
        Thu, 15 Aug 2019 09:38:44 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:43 -0700 (PDT)
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
Subject: [PATCHv6 04/36] posix-clocks: Rename .clock_get_timespec() callbacks accordingly
Date:   Thu, 15 Aug 2019 17:38:04 +0100
Message-Id: <20190815163836.2927-5-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
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
index b5f3779eae57..995dd5aa68f0 100644
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
index 36a4f6a7c4d6..4e89e342cfcc 100644
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
@@ -1267,7 +1267,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_clock_realtime_get,
+	.clock_get_timespec	= posix_get_realtime_timespec,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1284,7 +1284,7 @@ static const struct k_clock clock_realtime = {
 
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_ktime_get_ts,
+	.clock_get_timespec	= posix_get_monotonic_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1314,7 +1314,7 @@ static const struct k_clock clock_monotonic_coarse = {
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_get_tai,
+	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1329,7 +1329,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get_timespec	= posix_get_boottime,
+	.clock_get_timespec	= posix_get_boottime_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
-- 
2.22.0

