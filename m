Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849A4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4073021734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356218;
	bh=mjHGeq2IuEo4uvRbu6hmkTTPwxDDWDuXigkxo5IAcQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lnhekcZU8pLZ4xt4os2ZmTxlPJ4WXBSwpEXOS+m05e0CjeO03TE1eZGgqLC9mWypJ
	 eiQae/r5SLssfgQLjU1666sXzby2lV/uowUhPuU9jG4Zud1Ujmzu+9NC5oMvpG8nnY
	 2Ig2YPttbg4do94nuZaEBReQY4UICc7FPZe7/aUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfCLCDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfCLCDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:03:35 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2865214AE;
        Tue, 12 Mar 2019 02:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356214;
        bh=mjHGeq2IuEo4uvRbu6hmkTTPwxDDWDuXigkxo5IAcQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ycJ8CBeKvz/V3aA352lDePQkEHhshf3NxZlRG8cIPpmVKlVuMOq2rZ4Fk2iaibtBr
         QImHZL89E/pRYJ4r2jqmQlaeIrwlbGK19XC/M0SdP45JvWEKYxkrXgO5boozDT81zw
         R2BDZrMqYlim/CpzcdKMzQRH8bLuZEeGpBrEchbY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 20/30] tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
Date:   Mon, 11 Mar 2019 23:01:54 -0300
Message-Id: <20190312020204.22092-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  c8ce48f06503 ("asm-generic: Make time32 syscall numbers optional")

Silencing these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/unistd.h' differs from latest version at 'arch/arm64/include/uapi/asm/unistd.h'
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Test built it under the ubuntu:14.04.4-x-linaro-arm64 cross build
environment and looked at the syscall table at
/tmp/build/perf/arch/arm64/include/generated/asm/syscalls.c, looks ok.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/n/tip-e4w7ngsmkq48bd6st52ty2kb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/unistd.h |   2 +
 tools/include/uapi/asm-generic/unistd.h    | 149 ++++++++++++++++-----
 2 files changed, 118 insertions(+), 33 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index dae1584cf017..4703d218663a 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -17,5 +17,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index d90127298f12..12cdf611d217 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -38,8 +38,10 @@ __SYSCALL(__NR_io_destroy, sys_io_destroy)
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
 __SYSCALL(__NR_io_cancel, sys_io_cancel)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_getevents 4
-__SC_COMP(__NR_io_getevents, sys_io_getevents, compat_sys_io_getevents)
+__SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
+#endif
 
 /* fs/xattr.c */
 #define __NR_setxattr 5
@@ -179,7 +181,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -222,10 +224,12 @@ __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
 /* fs/select.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_pselect6 72
-__SC_COMP(__NR_pselect6, sys_pselect6, compat_sys_pselect6)
+__SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
 #define __NR_ppoll 73
-__SC_COMP(__NR_ppoll, sys_ppoll, compat_sys_ppoll)
+__SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
+#endif
 
 /* fs/signalfd.c */
 #define __NR_signalfd4 74
@@ -269,16 +273,20 @@ __SC_COMP(__NR_sync_file_range, sys_sync_file_range, \
 /* fs/timerfd.c */
 #define __NR_timerfd_create 85
 __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timerfd_settime 86
-__SC_COMP(__NR_timerfd_settime, sys_timerfd_settime, \
-	  compat_sys_timerfd_settime)
+__SC_3264(__NR_timerfd_settime, sys_timerfd_settime32, \
+	  sys_timerfd_settime)
 #define __NR_timerfd_gettime 87
-__SC_COMP(__NR_timerfd_gettime, sys_timerfd_gettime, \
-	  compat_sys_timerfd_gettime)
+__SC_3264(__NR_timerfd_gettime, sys_timerfd_gettime32, \
+	  sys_timerfd_gettime)
+#endif
 
 /* fs/utimes.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_utimensat 88
-__SC_COMP(__NR_utimensat, sys_utimensat, compat_sys_utimensat)
+__SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
+#endif
 
 /* kernel/acct.c */
 #define __NR_acct 89
@@ -309,8 +317,10 @@ __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
 __SYSCALL(__NR_unshare, sys_unshare)
 
 /* kernel/futex.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
-__SC_COMP(__NR_futex, sys_futex, compat_sys_futex)
+__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+#endif
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 	  compat_sys_set_robust_list)
@@ -319,8 +329,10 @@ __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 	  compat_sys_get_robust_list)
 
 /* kernel/hrtimer.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
-__SC_COMP(__NR_nanosleep, sys_nanosleep, compat_sys_nanosleep)
+__SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
+#endif
 
 /* kernel/itimer.c */
 #define __NR_getitimer 102
@@ -341,23 +353,29 @@ __SYSCALL(__NR_delete_module, sys_delete_module)
 /* kernel/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_gettime 108
-__SC_COMP(__NR_timer_gettime, sys_timer_gettime, compat_sys_timer_gettime)
+__SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
+#endif
 #define __NR_timer_getoverrun 109
 __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_settime 110
-__SC_COMP(__NR_timer_settime, sys_timer_settime, compat_sys_timer_settime)
+__SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
+#endif
 #define __NR_timer_delete 111
 __SYSCALL(__NR_timer_delete, sys_timer_delete)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_settime 112
-__SC_COMP(__NR_clock_settime, sys_clock_settime, compat_sys_clock_settime)
+__SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
 #define __NR_clock_gettime 113
-__SC_COMP(__NR_clock_gettime, sys_clock_gettime, compat_sys_clock_gettime)
+__SC_3264(__NR_clock_gettime, sys_clock_gettime32, sys_clock_gettime)
 #define __NR_clock_getres 114
-__SC_COMP(__NR_clock_getres, sys_clock_getres, compat_sys_clock_getres)
+__SC_3264(__NR_clock_getres, sys_clock_getres_time32, sys_clock_getres)
 #define __NR_clock_nanosleep 115
-__SC_COMP(__NR_clock_nanosleep, sys_clock_nanosleep, \
-	  compat_sys_clock_nanosleep)
+__SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
+	  sys_clock_nanosleep)
+#endif
 
 /* kernel/printk.c */
 #define __NR_syslog 116
@@ -388,9 +406,11 @@ __SYSCALL(__NR_sched_yield, sys_sched_yield)
 __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
 #define __NR_sched_get_priority_min 126
 __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_sched_rr_get_interval 127
-__SC_COMP(__NR_sched_rr_get_interval, sys_sched_rr_get_interval, \
-	  compat_sys_sched_rr_get_interval)
+__SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, \
+	  sys_sched_rr_get_interval)
+#endif
 
 /* kernel/signal.c */
 #define __NR_restart_syscall 128
@@ -411,9 +431,11 @@ __SC_COMP(__NR_rt_sigaction, sys_rt_sigaction, compat_sys_rt_sigaction)
 __SC_COMP(__NR_rt_sigprocmask, sys_rt_sigprocmask, compat_sys_rt_sigprocmask)
 #define __NR_rt_sigpending 136
 __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpending)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_rt_sigtimedwait 137
-__SC_COMP(__NR_rt_sigtimedwait, sys_rt_sigtimedwait, \
-	  compat_sys_rt_sigtimedwait)
+__SC_COMP_3264(__NR_rt_sigtimedwait, sys_rt_sigtimedwait_time32, \
+	  sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
+#endif
 #define __NR_rt_sigqueueinfo 138
 __SC_COMP(__NR_rt_sigqueueinfo, sys_rt_sigqueueinfo, \
 	  compat_sys_rt_sigqueueinfo)
@@ -467,10 +489,15 @@ __SYSCALL(__NR_uname, sys_newuname)
 __SYSCALL(__NR_sethostname, sys_sethostname)
 #define __NR_setdomainname 162
 __SYSCALL(__NR_setdomainname, sys_setdomainname)
+
+#ifdef __ARCH_WANT_SET_GET_RLIMIT
+/* getrlimit and setrlimit are superseded with prlimit64 */
 #define __NR_getrlimit 163
 __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
 #define __NR_setrlimit 164
 __SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
+#endif
+
 #define __NR_getrusage 165
 __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
 #define __NR_umask 166
@@ -481,12 +508,14 @@ __SYSCALL(__NR_prctl, sys_prctl)
 __SYSCALL(__NR_getcpu, sys_getcpu)
 
 /* kernel/time.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
 #define __NR_settimeofday 170
 __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
 #define __NR_adjtimex 171
-__SC_COMP(__NR_adjtimex, sys_adjtimex, compat_sys_adjtimex)
+__SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
+#endif
 
 /* kernel/timer.c */
 #define __NR_getpid 172
@@ -511,11 +540,13 @@ __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
 __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_mq_timedsend 182
-__SC_COMP(__NR_mq_timedsend, sys_mq_timedsend, compat_sys_mq_timedsend)
+__SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
 #define __NR_mq_timedreceive 183
-__SC_COMP(__NR_mq_timedreceive, sys_mq_timedreceive, \
-	  compat_sys_mq_timedreceive)
+__SC_3264(__NR_mq_timedreceive, sys_mq_timedreceive_time32, \
+	  sys_mq_timedreceive)
+#endif
 #define __NR_mq_notify 184
 __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
 #define __NR_mq_getsetattr 185
@@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
 __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semctl 191
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
+__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+#endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
 
@@ -658,8 +691,10 @@ __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
 __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
 __SYSCALL(__NR_accept4, sys_accept4)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_recvmmsg 243
-__SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
+__SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recvmmsg_time32)
+#endif
 
 /*
  * Architectures may provide up to 16 syscalls of their own
@@ -667,8 +702,10 @@ __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
  */
 #define __NR_arch_specific_syscall 244
 
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_wait4 260
 __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
+#endif
 #define __NR_prlimit64 261
 __SYSCALL(__NR_prlimit64, sys_prlimit64)
 #define __NR_fanotify_init 262
@@ -678,10 +715,11 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_adjtime 266
-__SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
+__SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
+#endif
 #define __NR_syncfs 267
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_setns 268
@@ -734,15 +772,60 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_pgetevents 292
-__SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+__SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents, compat_sys_io_pgetevents)
+#endif
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+/* 295 through 402 are unassigned to sync up with generic numbers, don't use */
+#if __BITS_PER_LONG == 32
+#define __NR_clock_gettime64 403
+__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+#define __NR_clock_settime64 404
+__SYSCALL(__NR_clock_settime64, sys_clock_settime)
+#define __NR_clock_adjtime64 405
+__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+#define __NR_clock_getres_time64 406
+__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+#define __NR_clock_nanosleep_time64 407
+__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+#define __NR_timer_gettime64 408
+__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+#define __NR_timer_settime64 409
+__SYSCALL(__NR_timer_settime64, sys_timer_settime)
+#define __NR_timerfd_gettime64 410
+__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+#define __NR_timerfd_settime64 411
+__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+#define __NR_utimensat_time64 412
+__SYSCALL(__NR_utimensat_time64, sys_utimensat)
+#define __NR_pselect6_time64 413
+__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
+#define __NR_ppoll_time64 414
+__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
+#define __NR_io_pgetevents_time64 416
+__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+#define __NR_recvmmsg_time64 417
+__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
+#define __NR_mq_timedsend_time64 418
+__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+#define __NR_mq_timedreceive_time64 419
+__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
+#define __NR_semtimedop_time64 420
+__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+#define __NR_rt_sigtimedwait_time64 421
+__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
+#define __NR_futex_time64 422
+__SYSCALL(__NR_futex_time64, sys_futex)
+#define __NR_sched_rr_get_interval_time64 423
+__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+#endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 295
+#define __NR_syscalls 424
 
 /*
  * 32 bit systems traditionally used different
-- 
2.20.1

