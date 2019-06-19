Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85634C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683252084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfFSGpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:45:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:50797 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfFSGpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:45:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 23:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="243224081"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2019 23:45:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf thread-stack: Fix thread stack return from kernel for kernel-only case
Date:   Wed, 19 Jun 2019 09:44:28 +0300
Message-Id: <20190619064429.14940-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190619064429.14940-1-adrian.hunter@intel.com>
References: <20190619064429.14940-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f08046cb3082 ("perf thread-stack: Represent jmps to the start of a
different symbol") had the side-effect of introducing more stack entries
before return from kernel space. When user space is also traced, those
entries are popped before entry to user space, but when user space is not
traced, they get stuck at the bottom of the stack, making the stack grow
progressively larger. Fix by detecting a return-from-kernel branch type,
and popping kernel addresses from the stack then.

Note, the problem and fix affect the exported Call Graph / Tree but not
the callindent option used by "perf script --call-trace".

Example:

  perf-with-kcore record example -e intel_pt//k -- ls
  perf-with-kcore script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py example.db branches calls
  ~/libexec/perf-core/scripts/python/exported-sql-viewer.py example.db

  Menu option: Reports -> Context-Sensitive Call Graph

  Before: (showing Call Path column only)

    Call Path
    ▶ perf
    ▼ ls
      ▼ 12111:12111
        ▶ setup_new_exec
        ▶ __task_pid_nr_ns
        ▶ perf_event_pid_type
        ▶ perf_event_comm_output
        ▶ perf_iterate_ctx
        ▶ perf_iterate_sb
        ▶ perf_event_comm
        ▶ __set_task_comm
        ▶ load_elf_binary
        ▶ search_binary_handler
        ▶ __do_execve_file.isra.41
        ▶ __x64_sys_execve
        ▶ do_syscall_64
        ▼ entry_SYSCALL_64_after_hwframe
          ▼ swapgs_restore_regs_and_return_to_usermode
            ▼ native_iret
              ▶ error_entry
              ▶ do_page_fault
              ▼ error_exit
                ▼ retint_user
                  ▶ prepare_exit_to_usermode
                  ▼ native_iret
                    ▶ error_entry
                    ▶ do_page_fault
                    ▼ error_exit
                      ▼ retint_user
                        ▶ prepare_exit_to_usermode
                        ▼ native_iret
                          ▶ error_entry
                          ▶ do_page_fault
                          ▼ error_exit
                            ▼ retint_user
                              ▶ prepare_exit_to_usermode
                              ▶ native_iret

  After: (showing Call Path column only)

    Call Path
    ▶ perf
    ▼ ls
      ▼ 12111:12111
        ▶ setup_new_exec
        ▶ __task_pid_nr_ns
        ▶ perf_event_pid_type
        ▶ perf_event_comm_output
        ▶ perf_iterate_ctx
        ▶ perf_iterate_sb
        ▶ perf_event_comm
        ▶ __set_task_comm
        ▶ load_elf_binary
        ▶ search_binary_handler
        ▶ __do_execve_file.isra.41
        ▶ __x64_sys_execve
        ▶ do_syscall_64
        ▶ entry_SYSCALL_64_after_hwframe
        ▶ page_fault
        ▼ entry_SYSCALL_64
          ▼ do_syscall_64
            ▶ __x64_sys_brk
            ▶ __x64_sys_access
            ▶ __x64_sys_openat
            ▶ __x64_sys_newfstat
            ▶ __x64_sys_mmap
            ▶ __x64_sys_close
            ▶ __x64_sys_read
            ▶ __x64_sys_mprotect
            ▶ __x64_sys_arch_prctl
            ▶ __x64_sys_munmap
            ▶ exit_to_usermode_loop
            ▶ __x64_sys_set_tid_address
            ▶ __x64_sys_set_robust_list
            ▶ __x64_sys_rt_sigaction
            ▶ __x64_sys_rt_sigprocmask
            ▶ __x64_sys_prlimit64
            ▶ __x64_sys_statfs
            ▶ __x64_sys_ioctl
            ▶ __x64_sys_getdents64
            ▶ __x64_sys_write
            ▶ __x64_sys_exit_group

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: f08046cb3082 ("perf thread-stack: Represent jmps to the start of a different symbol")
Cc: stable@vger.kernel.org
---
 tools/perf/util/thread-stack.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 8e390f78486f..f91c00dfe23b 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -637,6 +637,23 @@ static int thread_stack__bottom(struct thread_stack *ts,
 				     true, false);
 }
 
+static int thread_stack__pop_ks(struct thread *thread, struct thread_stack *ts,
+				struct perf_sample *sample, u64 ref)
+{
+	u64 tm = sample->time;
+	int err;
+
+	/* Return to userspace, so pop all kernel addresses */
+	while (thread_stack__in_kernel(ts)) {
+		err = thread_stack__call_return(thread, ts, --ts->cnt,
+						tm, ref, true);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int thread_stack__no_call_return(struct thread *thread,
 					struct thread_stack *ts,
 					struct perf_sample *sample,
@@ -919,7 +936,18 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 			ts->rstate = X86_RETPOLINE_DETECTED;
 
 	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
-		if (!sample->ip || !sample->addr)
+		if (!sample->addr) {
+			u32 return_from_kernel = PERF_IP_FLAG_SYSCALLRET |
+						 PERF_IP_FLAG_INTERRUPT;
+
+			if (!(sample->flags & return_from_kernel))
+				return 0;
+
+			/* Pop kernel stack */
+			return thread_stack__pop_ks(thread, ts, sample, ref);
+		}
+
+		if (!sample->ip)
 			return 0;
 
 		/* x86 retpoline 'return' doesn't match the stack */
-- 
2.17.1

