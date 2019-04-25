Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F124C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08CC20891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OSPt8Ztk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfDYQOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44279 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfDYQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id i13so358259edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urGE7RsYWfrxuhGh0Y1unjpCoXHfajqVcJKKblT8dro=;
        b=OSPt8ZtkPnUrrcuqiuDhMecShBY2HQ6izC1I3kBm9OxWuCAUrKkp74OyzxYn7vRmH2
         EmKzF2mJQB0YXSSTdNN/xqt5GvanueLrcdwbmXxHwDtSAkGRXfWXrmph3Z0mp4biABZv
         YvqCdg7XYrDA9zd9Qy7gxgk4ntA+h108lOiciKspUzvX+EOJZum/wMwNbGK7TFdx5vf5
         fzD6ICiZey9xoOM7QEsKlK+97bYmtIl1KUwPJMOXIojMOzYqTsgKFsWw4pyB0KMqI6MK
         Q8EX3P3wjp1aMNplz/irxoX3kK5mmdRyDsk+YsIgh7GBYt0JbGcs0BUgJqxZJ5Y2Bkyz
         aFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urGE7RsYWfrxuhGh0Y1unjpCoXHfajqVcJKKblT8dro=;
        b=fwxvNGER6gnzM/CeAzV2lHrsRP3AdjWwqm4P5NJ/TyaPq53SiN45bA8ybdgOaj/mMz
         NoO6wTos00vHr1A5rjLVEFV29DiG99LVqKmhJ7N4Y2woASZXzAHlHjRiQUTn9Uu2bpyb
         OVuOlwUa62dZayOijNKLw/i9PCa9KDuo/W/fJmcdvPP7++ZfPlSK0jHDN21Yioq/Qz0w
         Ex7NAuBZPSMyyLGN8EXN8Ihioy1J+Yqqf5sqWudyXTk5Q8jqAI66L7VgytrXBOuxoO/0
         oTA6fzER6v9RTStTYCG8RIu/hQLQA08bI7X5OlWRtyX4ZjYrTz4sqJjlTJDhlvQ4T2ZP
         7Ytg==
X-Gm-Message-State: APjAAAXRIOct+qDPVdGcxRCwDpOcQhhIxCBYY/76aECri/aLor2q/ne4
        m1f0nQlJvF0dPnqYh4WxA0yqZYEmnyY=
X-Google-Smtp-Source: APXvYqwx9CH2+8WdOihn5HJ8ZuwDzskf01Jmuf47vKrAQqYiSGJ7Oa19aTdiXzGLf3/cF755cx7G8w==
X-Received: by 2002:aa7:da92:: with SMTP id q18mr24092750eds.223.1556208869621;
        Thu, 25 Apr 2019 09:14:29 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:29 -0700 (PDT)
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
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 07/27] timens/kernel: Take into account timens clock offsets in clock_nanosleep
Date:   Thu, 25 Apr 2019 17:13:56 +0100
Message-Id: <20190425161416.26600-8-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire up clock_nanosleep() to timens offsets.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c   |  2 ++
 kernel/time/posix-stubs.c  |  8 ++++----
 kernel/time/posix-timers.c | 12 ++++++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 23f5c39c8d23..409d518acbb3 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -816,6 +816,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].gettime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(alarm_bases[type].base_clockid, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index edaf075d1ee4..f319d51e2e01 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -147,8 +147,8 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
-				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+	return hrtimer_nanosleep(&t, HRTIMER_MODE_NS | (flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL),
 				 which_clock);
 }
 
@@ -233,8 +233,8 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
-				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+	return hrtimer_nanosleep(&t, HRTIMER_MODE_NS | (flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL),
 				 which_clock);
 }
 #endif
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 7922731f98cd..39c0330464a3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1188,6 +1188,14 @@ static int common_nsleep(const clockid_t which_clock, int flags,
 				 which_clock);
 }
 
+static int common_nsleep_timens(const clockid_t which_clock, int flags,
+			 const struct timespec64 *rqtp)
+{
+	return hrtimer_nanosleep(rqtp, HRTIMER_MODE_NS | (flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL),
+				 which_clock);
+}
+
 SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		const struct __kernel_timespec __user *, rqtp,
 		struct __kernel_timespec __user *, rmtp)
@@ -1262,7 +1270,7 @@ static const struct k_clock clock_realtime = {
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_ktime_get_ts,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
@@ -1307,7 +1315,7 @@ static const struct k_clock clock_tai = {
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_get_boottime,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
-- 
2.21.0

