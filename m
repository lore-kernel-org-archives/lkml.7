Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E17FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3703720643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCGMdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:33:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfCGMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:33:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so9081146wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 04:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEqNbBiWS2Q12lmNzELzO2ZPkdi85YwCUcXmrGKoJ3s=;
        b=LaRPswVt+PjeEiPR8FLAzFjWjrAaQrmtCF86ZGuWic9Vzd/0oDIDmESg9NXdwKlhcf
         st8tz+StsaT1tmHs/Cgzk2OZjfr8wx8nuTavHkgc3VyIjkH6RAYmv11/+/xFhVPAZ+aA
         JA4cu5dPn30EF7SiGyISYhGN6/sv7/XaNs2PTZTH6rM5IiZMCAlHFsxA2CGh+0GJxJSP
         f4zUqo6/4fMcwStuPcWVzIpAoBuzi9eIeQFTvBPvmiIYXviPRGKtpxUNTaYZvCLlr7SK
         VTLqBCHHjdJs2XCdYBzmci6AyK9G/3hmkFM+Wa3QrG+Vy7nMwYgWF03fKKol0WVCIOK8
         KJvQ==
X-Gm-Message-State: APjAAAVJg/dWyfzOWIa+P+MuwJDJ0LSo3Xat/0d9jCHxJQy7wu4bBF3v
        OAEgaQ2VM6icGtpkNescZzjOSA==
X-Google-Smtp-Source: APXvYqxsDCoHhhMAg6ax+l8jd5mp1VY/zOwPZ9OcE1mmTlW/ONnuGPCsZ2CEcKlEi/CYNYNTVFlKzQ==
X-Received: by 2002:a1c:9c12:: with SMTP id f18mr5646574wme.16.1551961989272;
        Thu, 07 Mar 2019 04:33:09 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f68sm10063507wmg.5.2019.03.07.04.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 04:33:08 -0800 (PST)
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
Subject: [RFC PATCH ghak10 v6 2/2] ntp: Audit NTP parameters adjustment
Date:   Thu,  7 Mar 2019 13:32:54 +0100
Message-Id: <20190307123254.348-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307123254.348-1-omosnace@redhat.com>
References: <20190307123254.348-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emit an audit record every time selected NTP parameters are modified
from userspace (via adjtimex(2) or clock_adjtime(2)).

Such events will now generate records of type AUDIT_TIME_ADJNTPVAL
containing the following fields:
  - op -- which value was adjusted:
    - offset -- corresponding to the time_offset variable
    - freq   -- corresponding to the time_freq variable
    - status -- corresponding to the time_status variable
    - adjust -- corresponding to the time_adjust variable
    - tick   -- corresponding to the tick_usec variable
    - tai    -- corresponding to the timekeeping's TAI offset
  - old -- the old value
  - new -- the new value

For reference, running the following commands:

    auditctl -D
    auditctl -a exit,always -F arch=b64 -S adjtimex
    chronyd -q

produces audit records like this:

type=SYSCALL msg=audit(1530616044.507:5): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=0 a2=4 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:5): proctitle=6368726F6E7964002D71
type=SYSCALL msg=audit(1530616044.507:6): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=1 a2=1 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:6): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.507:7): op=status old=64 new=8256
type=SYSCALL msg=audit(1530616044.507:7): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=1 a2=1 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:7): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.507:8): op=status old=8256 new=8257
type=SYSCALL msg=audit(1530616044.507:8): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ab0 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:8): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.507:9): op=status old=8257 new=64
type=SYSCALL msg=audit(1530616044.507:9): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ab0 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:9): proctitle=6368726F6E7964002D71
type=SYSCALL msg=audit(1530616044.507:10): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78a70 a1=0 a2=55e129c850c0 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.507:10): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616044.511:11): op=freq old=0 new=49180377088000
type=SYSCALL msg=audit(1530616044.511:11): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78ad0 a1=0 a2=2710 a3=f42f82a800000 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.511:11): proctitle=6368726F6E7964002D71
type=SYSCALL msg=audit(1530616044.521:12): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78b40 a1=1 a2=40 a3=f91f6ef84fbab items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616044.521:12): proctitle=6368726F6E7964002D71
type=TIME_ADJNTPVAL msg=audit(1530616049.652:13): op=status old=64 new=8256
type=SYSCALL msg=audit(1530616049.652:13): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78270 a1=1 a2=fffffffffffffff0 a3=137b828205ca12 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616049.652:13): proctitle=6368726F6E7964002D71
type=SYSCALL msg=audit(1530616033.783:14): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78bc0 a1=0 a2=2710 a3=0 items=0 ppid=626 pid=629 auid=0 uid=385 gid=382 euid=385 suid=385 fsuid=385 egid=382 sgid=382 fsgid=382 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
type=PROCTITLE msg=audit(1530616033.783:14): proctitle=6368726F6E7964002D71

The chronyd command that produced the above records executed the
following adjtimex(2) syscalls (as per strace output):

adjtimex({modes=ADJ_OFFSET|0x8000, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507215}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_MAXERROR, offset=0, freq=0, maxerror=0, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507438}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_SETOFFSET|ADJ_NANO, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507604737}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_OFFSET|ADJ_STATUS, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_PLL|STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507698330}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_STATUS, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=507792}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=0, offset=0, freq=0, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=508000}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_FREQUENCY|ADJ_TICK, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=512146}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_MAXERROR|ADJ_ESTERROR|ADJ_STATUS, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616044, tv_usec=522506}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_SETOFFSET|ADJ_NANO, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616033, tv_usec=778717675}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)
adjtimex({modes=ADJ_FREQUENCY|ADJ_TICK, offset=0, freq=750433, maxerror=16000000, esterror=16000000, status=STA_UNSYNC|STA_NANO, constant=2, precision=1, tolerance=32768000, time={tv_sec=1530616033, tv_usec=784644657}, tick=10000, ppsfreq=0, jitter=0, shift=0, stabil=0, jitcnt=0, calcnt=0, errcnt=0, stbcnt=0, tai=0}) = 5 (TIME_ERROR)

(The struct timex fields above are from *after* the syscall was
executed, so they contain the current (new) values as set from the
kernel, except of the 'modes' field, which contains the original value
sent by the caller.)

The changes to the time_maxerror, time_esterror, and time_constant
variables are not logged, as these are not important for security. Also,
no-op adjustments that do not actually change the value are not logged.

An overview of parameter changes that can be done via do_adjtimex()
(based on information from Miroslav Lichvar) and whether they are
audited:
  __timekeeping_set_tai_offset() -- sets the offset from the
                                    International Atomic Time
                                    (AUDITED)
  NTP variables:
    time_offset -- can adjust the clock by up to 0.5 seconds per call
                   and also speed it up or slow down by up to about
                   0.05% (43 seconds per day) (AUDITED)
    time_freq -- can speed up or slow down by up to about 0.05%
    time_status -- can insert/delete leap seconds and it also enables/
                   disables synchronization of the hardware real-time
                   clock (AUDITED)
    time_maxerror, time_esterror -- change error estimates used to
                                    inform userspace applications
                                    (NOT AUDITED)
    time_constant -- controls the speed of the clock adjustments that
                     are made when time_offset is set (NOT AUDITED)
    time_adjust -- can temporarily speed up or slow down the clock by up
                   to 0.05% (AUDITED)
    tick_usec -- a more extreme version of time_freq; can speed up or
                 slow down the clock by up to 10% (AUDITED)

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h      | 14 ++++++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/auditsc.c           |  7 +++++++
 kernel/time/ntp.c          | 38 ++++++++++++++++++++++++++++++--------
 4 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 43a60fbe74be..0f67964544cc 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -367,6 +367,7 @@ extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_log_kern_module(char *name);
 extern void __audit_fanotify(unsigned int response);
 extern void __audit_tk_injoffset(struct timespec64 offset);
+extern void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -479,6 +480,16 @@ static inline void audit_tk_injoffset(struct timespec64 offset)
 		__audit_tk_injoffset(offset);
 }
 
+static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
+{
+	/* ignore no-op events */
+	if (newval == oldval)
+		return;
+
+	if (!audit_dummy_context())
+		__audit_ntp_adjust(type, oldval, newval);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -595,6 +606,9 @@ static inline void audit_fanotify(unsigned int response)
 static inline void audit_tk_injoffset(struct timespec64 offset)
 { }
 
+static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
+{ }
+
 static inline void audit_ptrace(struct task_struct *t)
 { }
 #define audit_n_rules 0
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 2167d55bc800..e9781f0385eb 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -115,6 +115,7 @@
 #define AUDIT_KERN_MODULE	1330	/* Kernel Module events */
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
 #define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
+#define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 781336d0f2de..946806174cd9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2520,6 +2520,13 @@ void __audit_tk_injoffset(struct timespec64 offset)
 		  "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
 }
 
+void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
+{
+	audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_ADJNTPVAL,
+		  "op=%s old=%lli new=%lli", type,
+		  (long long)oldval, (long long)newval);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 36a2bef00125..5f456a84151a 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
+#include <linux/audit.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -293,6 +294,8 @@ static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
 
 static void ntp_update_offset(long offset)
 {
+	s64 old_offset = time_offset;
+	s64 old_freq = time_freq;
 	s64 freq_adj;
 	s64 offset64;
 	long secs;
@@ -341,6 +344,9 @@ static void ntp_update_offset(long offset)
 	time_freq   = max(freq_adj, -MAXFREQ_SCALED);
 
 	time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
+
+	audit_ntp_adjust("offset", old_offset, time_offset);
+	audit_ntp_adjust("freq", old_freq, time_freq);
 }
 
 /**
@@ -658,21 +664,31 @@ static inline void process_adj_status(const struct timex *txc)
 
 static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai)
 {
-	if (txc->modes & ADJ_STATUS)
-		process_adj_status(txc);
+	if (txc->modes & (ADJ_STATUS | ADJ_NANO | ADJ_MICRO)) {
+		int old_status = time_status;
+
+		if (txc->modes & ADJ_STATUS)
+			process_adj_status(txc);
 
-	if (txc->modes & ADJ_NANO)
-		time_status |= STA_NANO;
+		if (txc->modes & ADJ_NANO)
+			time_status |= STA_NANO;
 
-	if (txc->modes & ADJ_MICRO)
-		time_status &= ~STA_NANO;
+		if (txc->modes & ADJ_MICRO)
+			time_status &= ~STA_NANO;
+
+		audit_ntp_adjust("status", old_status, time_status);
+	}
 
 	if (txc->modes & ADJ_FREQUENCY) {
+		s64 old_freq = time_freq;
+
 		time_freq = txc->freq * PPM_SCALE;
 		time_freq = min(time_freq, MAXFREQ_SCALED);
 		time_freq = max(time_freq, -MAXFREQ_SCALED);
 		/* update pps_freq */
 		pps_set_freq(time_freq);
+
+		audit_ntp_adjust("freq", old_freq, time_freq);
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
@@ -689,14 +705,18 @@ static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai
 		time_constant = max(time_constant, 0l);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant > 0)
+	if (txc->modes & ADJ_TAI && txc->constant > 0) {
+		audit_ntp_adjust("tai", *time_tai, txc->constant);
 		*time_tai = txc->constant;
+	}
 
 	if (txc->modes & ADJ_OFFSET)
 		ntp_update_offset(txc->offset);
 
-	if (txc->modes & ADJ_TICK)
+	if (txc->modes & ADJ_TICK) {
+		audit_ntp_adjust("tick", tick_usec, txc->tick);
 		tick_usec = txc->tick;
+	}
 
 	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
 		ntp_update_frequency();
@@ -718,6 +738,8 @@ int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai)
 			/* adjtime() is independent from ntp_adjtime() */
 			time_adjust = txc->offset;
 			ntp_update_frequency();
+
+			audit_ntp_adjust("adjust", save_adjust, txc->offset);
 		}
 		txc->offset = save_adjust;
 	} else {
-- 
2.20.1

