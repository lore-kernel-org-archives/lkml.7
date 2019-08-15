Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ABFC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7A5217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="oeeLvr+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbfHOQiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:38:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34691 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbfHOQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:38:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so2005569wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpnShLtxSjv8bNhwNw3xUPvCSq4OfTkEweQNTWUWoCQ=;
        b=oeeLvr+DqfsU+oEXVVjpJpYHHeUYWcXKB4vEG3EKNQA9yBK6q7oR9/35pTbxYxorVY
         DmWtxF4jMy0vJrqRodwFuVTIXsE0uvZQxO1tGtp8vgq9TwQ4bk6UZT4x7r7CCK34xB+9
         +hQlsAj/PYy2mmYo82nlTHQnUeeiL0Z7P8Cg0VWyXZL2gTExjizhNXQknYBPwUl32Uo+
         2jYRLEIP+kzSjlQsPMHbAmcRKo/o8QeAKC2ETpOor8f2kft40lpxjhjLuqZWPieyTt8R
         3jq5rX+f9O4yr3SsQ/momJU+VZwdr63PkVLcCNq3JsrVxMiw1XUFK3HbAIHbE890Y0sd
         aXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpnShLtxSjv8bNhwNw3xUPvCSq4OfTkEweQNTWUWoCQ=;
        b=eoh0OkhV48L9mF8r+nvn9Jt0typidc8WJM3PAU461AunaWYTfKCKyS+Y0b1QkZLGzI
         zl99QmhNV6dYaOR80x96J4TB96ej1E3O/zHpWvr4QBbMf8dks/V3GN1dLupywi9ZfLUl
         fIr2d+G7115nxNYwyqGBLQSLV3HO05Gbc06a79FM7vUBSDyCb38qxZymsobqMpRPwe8d
         eO9lyYTWYoB+8rNg2mq1XdXHGUPhEo5uU0gske31n6LfLzF6nDMiuTxsugu/CKm14zjE
         dUhY/hcO+qIY19UCtOPLTIzXnapGMaBkBYH4MiALtm2CHmeGY51+finwCKmVCbKx+h0W
         zlkg==
X-Gm-Message-State: APjAAAWA3dE3/kap1yfXoKSbqcuyFBB2xUNuhyhzT8MYYcyiZNgHFod3
        5LNcjCSKukj87xwAKfjWA4IcOSRFB7I=
X-Google-Smtp-Source: APXvYqyCIpskmxmyTPJe4+Oxv8AhZs/90aoq/MYCXb1OGB5ilCrhPaqUl/vyxT1SgypGHsIKSFS65w==
X-Received: by 2002:a5d:480e:: with SMTP id l14mr6301076wrq.96.1565887126933;
        Thu, 15 Aug 2019 09:38:46 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:46 -0700 (PDT)
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
Subject: [PATCHv6 06/36] alarmtimer: Provide get_timespec() callback
Date:   Thu, 15 Aug 2019 17:38:06 +0100
Message-Id: <20190815163836.2927-7-dima@arista.com>
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

Wire up alarm bases with get_timespec().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/posix-timers.h | 3 +++
 kernel/time/alarmtimer.c     | 8 ++++++--
 kernel/time/posix-timers.c   | 4 ++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 604cec0e41ba..ec2b2d8b95f6 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -128,4 +128,7 @@ void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
 void posixtimer_rearm(struct kernel_siginfo *info);
+
+int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp);
+int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp);
 #endif
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5af13c859d03..7732f0aabf6a 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -37,12 +37,15 @@
  * @lock:		Lock for syncrhonized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
  * @get_ktime:		Function to read the time correlating to the base
+ * @get_timespec:	Function to read the namespace time correlating to the base
  * @base_clockid:	clockid for the base
  */
 static struct alarm_base {
 	spinlock_t		lock;
 	struct timerqueue_head	timerqueue;
 	ktime_t			(*get_ktime)(void);
+	int			(*get_timespec)(const clockid_t which_clock,
+						struct timespec64 *tp);
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
@@ -657,8 +660,7 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
-	*tp = ktime_to_timespec64(base->get_ktime());
-	return 0;
+	return base->get_timespec(base->base_clockid, tp);
 }
 
 /**
@@ -869,8 +871,10 @@ static int __init alarmtimer_init(void)
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
 	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
+	alarm_bases[ALARM_REALTIME].get_timespec = posix_get_realtime_timespec,
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_timespec = posix_get_boottime_timespec;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4e89e342cfcc..43049c5f1a22 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -165,7 +165,7 @@ static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 }
 
 /* Get clock_realtime */
-static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
+int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
 	return 0;
@@ -222,7 +222,7 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 	return 0;
 }
 
-static int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
+int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
 	return 0;
-- 
2.22.0

