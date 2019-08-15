Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59649C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE1720578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fmuYKy9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfHOQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:40:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39787 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbfHOQjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:39:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so1770574wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NM4X74jIwcnHq1r67TExPgVuNMqwsxjWup6KENuG4es=;
        b=fmuYKy9dX3DE97i4daTodFc58Ewit1k7fuxivIiOjvD4AlXLf1n59ICI/wIwf6rGAk
         Aao0mqLzL1wLXqwZgD0Ty0SuC15CqmPAENYJQm6dFDt/v40oHkgr7RFDrqqYt+94zbbG
         v5ThMW3aBoHMCtb+CM0JFl8yPmJVBc5/TCzaFrnqbp81vzNi9xcGIijUOrglVCSmMFOP
         f6vwPzVvlE3wnOD5wlNgORNP1AJruYdl1txpBnmpIbwbliTFUT98LyyF1kym4J7UnCdk
         p6l8yBxCsJZbtdF4U+lAKtWAUfc2/t+RkLch8uuQK19SYRlajF/Lyd4Naa0oNgHrgcw6
         pwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NM4X74jIwcnHq1r67TExPgVuNMqwsxjWup6KENuG4es=;
        b=XLrGpJYfA7bfyz/7E7TfXg3P+QrpI8C31EvQpQ9GeBSgFudmVxzTTFQSV9PUs1cu9W
         iX/FK3Df9d76YlZfsijGv2G8IsZ346KetY3xLM5ZteOYkW3GDyins9XkXQ9UFrgO/V54
         wh5WUTe8XSmVDD0gSgxVcWVSguqcFNGRVxFKzMDbESykAaiSWChHPzKwN5r654BudJ6P
         dwmiIlV3dGnqCSOtp3MYmHCwlmKVw2C5fRXlknvjN+ryPJ2QLJdA3SFIG9siURxC01No
         ML8T/SvNB0h2LUNkZVNfZNJRE9kVmwrWxdNYSTMTQdv1tIQlyI2NkkaM+YSVlRNGR/92
         Np9Q==
X-Gm-Message-State: APjAAAXhmXeHSV5kaGv3yRpTsBpmuYAuQx3NbYGXG3CKfndSoM22sRPy
        ZfoCV0dDCNjMiP3hz2Tn9ga6CS3+a+I=
X-Google-Smtp-Source: APXvYqw+uOOaqpETyhYMYscj7ZAUI2Gm+BSCU/ZByiehGzTvoGMXk7nTd8XFrFMrOO3DmdsKJrVksA==
X-Received: by 2002:a7b:c7c4:: with SMTP id z4mr3572872wmk.13.1565887138446;
        Thu, 15 Aug 2019 09:38:58 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:57 -0700 (PDT)
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
Subject: [PATCHv6 14/36] hrtimers: Prepare hrtimer_nanosleep() for time namespaces
Date:   Thu, 15 Aug 2019 17:38:14 +0100
Message-Id: <20190815163836.2927-15-dima@arista.com>
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
index 5df4bcff96d5..ed49ef359f26 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -500,7 +500,7 @@ static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 /* Precise sleep: */
 
 extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
-extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
+extern long hrtimer_nanosleep(ktime_t rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 499122752649..fc972ae0de02 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1886,7 +1886,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	return ret;
 }
 
-long hrtimer_nanosleep(const struct timespec64 *rqtp,
+long hrtimer_nanosleep(ktime_t rqtp,
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
@@ -1899,7 +1899,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -1934,7 +1934,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
 #endif
@@ -1954,7 +1954,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 
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

