Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606DD20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCGMdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:33:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42065 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfCGMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:33:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so17217795wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 04:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPt+DpJ71wGrzidCofPMDeBONSBgRC0YM7bGLfELBAE=;
        b=T0IqmTtKpA7lybUxpy+qhYEOC/VGDFvAPhVfNxNq7LwL6iJO3huRaPrzV0QFNHLgRV
         mbeQT0LiqKpOX4vB/+fMbhvawOPcCU9JTcUdIZATvEVkiiQU6IUz0/XZZP7EjfoJW3bJ
         utXXvwLdzADxvM0DG0mWw2rcQXVzEtgdbkX0TwImwGTX4d6Blr2qVgj6BUDq8pKo3uuF
         SCN/1IUmkGYDMSYBxDpoWmF8r3VPXbgQFG4/BECzTPGM6GoOWMmlR9DLd1jWBWq5I/+J
         gX1ITU/Jis39alS0dNJGqf0LBlHN03CgHBQFsNaL5EkSJ1ZN8uiKT3bTGl9/sDuJobXe
         Ji/Q==
X-Gm-Message-State: APjAAAWUiZO9QfeKcpSl2OyHvUYunrwy2eM1CZ1ySRZSpklt72FK2yHc
        9Y34lVDFof+P3tCPpBf29/RLkQ==
X-Google-Smtp-Source: APXvYqxPKyCfVGxBxjqbNIJJmQ6sApITBtGQy79T1nNvyZFjFpl5HNEHfLiU1vgjlZ0noKF6y0JSMQ==
X-Received: by 2002:adf:c593:: with SMTP id m19mr6662837wrg.124.1551961987901;
        Thu, 07 Mar 2019 04:33:07 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f68sm10063507wmg.5.2019.03.07.04.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 04:33:07 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH ghak10 v6 1/2] timekeeping: Audit clock adjustments
Date:   Thu,  7 Mar 2019 13:32:53 +0100
Message-Id: <20190307123254.348-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307123254.348-1-omosnace@redhat.com>
References: <20190307123254.348-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emit an audit record whenever the system clock is changed (i.e. shifted
by a non-zero offset) by a syscall from userspace. The syscalls than can
(at the time of writing) trigger such record are:
  - settimeofday(2), stime(2), clock_settime(2) -- via
    do_settimeofday64()
  - adjtimex(2), clock_adjtime(2) -- via do_adjtimex()

The new records have type AUDIT_TIME_INJOFFSET and contain the following
fields:
  - sec -- the 'seconds' part of the offset
  - nsec -- the 'nanoseconds' part of the offset

For reference, running the following commands:

    auditctl -D
    auditctl -a exit,always -F arch=b64 -S adjtimex
    chronyd -q

triggers (among others) a syscall that produces audit records like this:

type=TIME_INJOFFSET msg=audit(1530616049.652:13): sec=-16 nsec=124887145
type=SYSCALL msg=audit(1530616049.652:13): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78270 a1=1 a2=fffffffffffffff0 a3=137b828205ca12 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616049.652:13): proctitle=6368726F6E7964002D71 cd /home/omosnace/Dokumenty/Kernel/worktrees/audit/src/kernel/time
s

The above records have been produced by the following syscall from
chronyd (as per strace output):

adjtimex({modes=ADJ_SETOFFSET|ADJ_NANO, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616033, tv_usec=778717675}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)

(The struct timex fields above are from *after* the syscall was
executed, so they contain the current (new) values as set from the
kernel, except of the 'modes' field, which contains the original value
sent by the caller.)

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h      | 15 +++++++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/auditsc.c           |  8 ++++++++
 kernel/time/timekeeping.c  |  6 ++++++
 4 files changed, 30 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 1e69d9fe16da..43a60fbe74be 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -27,6 +27,7 @@
 #include <linux/ptrace.h>
 #include <linux/namei.h>  /* LOOKUP_* */
 #include <uapi/linux/audit.h>
+#include <uapi/linux/timex.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
@@ -365,6 +366,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_log_kern_module(char *name);
 extern void __audit_fanotify(unsigned int response);
+extern void __audit_tk_injoffset(struct timespec64 offset);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -467,6 +469,16 @@ static inline void audit_fanotify(unsigned int response)
 		__audit_fanotify(response);
 }
 
+static inline void audit_tk_injoffset(struct timespec64 offset)
+{
+	/* ignore no-op events */
+	if (offset.tv_sec == 0 && offset.tv_nsec == 0)
+		return;
+
+	if (!audit_dummy_context())
+		__audit_tk_injoffset(offset);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -580,6 +592,9 @@ static inline void audit_log_kern_module(char *name)
 static inline void audit_fanotify(unsigned int response)
 { }
 
+static inline void audit_tk_injoffset(struct timespec64 offset)
+{ }
+
 static inline void audit_ptrace(struct task_struct *t)
 { }
 #define audit_n_rules 0
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 36a7e3f18e69..2167d55bc800 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -114,6 +114,7 @@
 #define AUDIT_REPLACE		1329	/* Replace auditd if this packet unanswerd */
 #define AUDIT_KERN_MODULE	1330	/* Kernel Module events */
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
+#define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d1eab1d4a930..781336d0f2de 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2512,6 +2512,14 @@ void __audit_fanotify(unsigned int response)
 		AUDIT_FANOTIFY,	"resp=%u", response);
 }
 
+/* We need to allocate with GFP_ATOMIC here, since these two functions will be
+ * called while holding the timekeeping lock: */
+void __audit_tk_injoffset(struct timespec64 offset)
+{
+	audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
+		  "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ac5dbf2cd4a2..0f0b566afe61 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -21,6 +21,7 @@
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
 #include <linux/compiler.h>
+#include <linux/audit.h>
 
 #include "tick-internal.h"
 #include "ntp_internal.h"
@@ -1250,6 +1251,9 @@ out:
 	/* signal hrtimers about time change */
 	clock_was_set();
 
+	if (!ret)
+		audit_tk_injoffset(ts_delta);
+
 	return ret;
 }
 EXPORT_SYMBOL(do_settimeofday64);
@@ -2322,6 +2326,8 @@ int do_adjtimex(struct timex *txc)
 		ret = timekeeping_inject_offset(&delta);
 		if (ret)
 			return ret;
+
+		audit_tk_injoffset(delta);
 	}
 
 	ktime_get_real_ts64(&ts);
-- 
2.20.1

