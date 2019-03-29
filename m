Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79597C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B4218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfC2Uk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:40:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32895 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfC2Uk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:40:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKdvPR3938360
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:39:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKdu6v3938357;
        Fri, 29 Mar 2019 13:39:56 -0700
Date:   Fri, 29 Mar 2019 13:39:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p0ars3otuc52x5iznf21shhw@git.kernel.org>
Cc:     jolsa@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kafai@fb.com, mingo@kernel.org, christian@brauner.io,
        adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org,
        andrii.nakryiko@gmail.com, songliubraving@fb.com, axboe@kernel.dk,
        yhs@fb.com, daniel@iogearbox.net, acme@redhat.com
Reply-To: jolsa@kernel.org, tglx@linutronix.de, kafai@fb.com,
          christian@brauner.io, mingo@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          andrii.nakryiko@gmail.com, namhyung@kernel.org,
          songliubraving@fb.com, axboe@kernel.dk, yhs@fb.com,
          daniel@iogearbox.net, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Update x86's syscall_64.tbl and
 uapi/asm-generic/unistd
Git-Commit-ID: 8142bd82a59e452fefea7b21113101d6a87d9fa8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8142bd82a59e452fefea7b21113101d6a87d9fa8
Gitweb:     https://git.kernel.org/tip/8142bd82a59e452fefea7b21113101d6a87d9fa8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 25 Mar 2019 11:34:04 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:41:11 -0300

tools headers: Update x86's syscall_64.tbl and uapi/asm-generic/unistd

To pick up the changes introduced in the following csets:

  2b188cc1bb85 ("Add io_uring IO interface")
  edafccee56ff ("io_uring: add support for pre-mapped user IO buffers")
  3eb39f47934f ("signal: add pidfd_send_signal() syscall")

This makes 'perf trace' to become aware of these new syscalls, so that
one can use them like 'perf trace -e ui_uring*,*signal' to do a system
wide strace-like session looking at those syscalls, for instance.

For example:

  # perf trace -s io_uring-cp ~acme/isos/RHEL-x86_64-dvd1.iso ~/bla

   Summary of events:

   io_uring-cp (383), 1208866 events, 100.0%

     syscall         calls   total    min     avg     max   stddev
                             (msec) (msec)  (msec)  (msec)     (%)
     -------------- ------ -------- ------ ------- -------  ------
     io_uring_enter 605780 2955.615  0.000   0.005  33.804   1.94%
     openat              4  459.446  0.004 114.861 459.435 100.00%
     munmap              4    0.073  0.009   0.018   0.042  44.03%
     mmap               10    0.054  0.002   0.005   0.026  43.24%
     brk                28    0.038  0.001   0.001   0.003   7.51%
     io_uring_setup      1    0.030  0.030   0.030   0.030   0.00%
     mprotect            4    0.014  0.002   0.004   0.005  14.32%
     close               5    0.012  0.001   0.002   0.004  28.87%
     fstat               3    0.006  0.001   0.002   0.003  35.83%
     read                4    0.004  0.001   0.001   0.002  13.58%
     access              1    0.003  0.003   0.003   0.003   0.00%
     lseek               3    0.002  0.001   0.001   0.001   9.00%
     arch_prctl          2    0.002  0.001   0.001   0.001   0.69%
     execve              1    0.000  0.000   0.000   0.000   0.00%
  #
  # perf trace -e io_uring* -s io_uring-cp ~acme/isos/RHEL-x86_64-dvd1.iso ~/bla

   Summary of events:

   io_uring-cp (390), 1191250 events, 100.0%

     syscall         calls   total    min    avg    max  stddev
                             (msec) (msec) (msec) (msec)    (%)
     -------------- ------ -------- ------ ------ ------ ------
     io_uring_enter 597093 2706.060  0.001  0.005 14.761  1.10%
     io_uring_setup      1    0.038  0.038  0.038  0.038  0.00%
  #

More work needed to make the tools/perf/examples/bpf/augmented_raw_syscalls.c
BPF program to copy the 'struct io_uring_params' arguments to perf's ring
buffer so that 'perf trace' can use the BTF info put in place by pahole's
conversion of the kernel DWARF and then auto-beautify those arguments.

This patch produces the expected change in the generated syscalls table
for x86_64:

  --- /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before	2019-03-26 13:37:46.679057774 -0300
  +++ /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c	2019-03-26 13:38:12.755990383 -0300
  @@ -334,5 +334,9 @@ static const char *syscalltbl_x86_64[] =
   	[332] = "statx",
   	[333] = "io_pgetevents",
   	[334] = "rseq",
  +	[424] = "pidfd_send_signal",
  +	[425] = "io_uring_setup",
  +	[426] = "io_uring_enter",
  +	[427] = "io_uring_register",
   };
  -#define SYSCALLTBL_x86_64_MAX_ID 334
  +#define SYSCALLTBL_x86_64_MAX_ID 427

This silences these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-p0ars3otuc52x5iznf21shhw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h           | 11 ++++++++++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 12cdf611d217..dee7292e1df6 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -824,8 +824,17 @@ __SYSCALL(__NR_futex_time64, sys_futex)
 __SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
 #endif
 
+#define __NR_pidfd_send_signal 424
+__SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
+#define __NR_io_uring_setup 425
+__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
+#define __NR_io_uring_enter 426
+__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
+#define __NR_io_uring_register 427
+__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+
 #undef __NR_syscalls
-#define __NR_syscalls 424
+#define __NR_syscalls 428
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 2ae92fddb6d5..92ee0b4378d4 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,10 @@
 334	common	rseq			__x64_sys_rseq
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
+424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
+425	common	io_uring_setup		__x64_sys_io_uring_setup
+426	common	io_uring_enter		__x64_sys_io_uring_enter
+427	common	io_uring_register	__x64_sys_io_uring_register
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
