Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FD2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A67218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oEbKViya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGCOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:02:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:02:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E1vJc3318360
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:01:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E1vJc3318360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162518;
        bh=v9j/26SReNNRVgynrR370OC5fuNDoJxWauvoNLizL4E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=oEbKViyavuh+ydLPruZqY1oAXEYWzlBVAhaTN7rOA738+acLZWCStpgDm2jd44Q23
         AmkirscL54C1EEuEd5IAlzkgkh6YECTDX/C2PyWCJuZR5LxgriDU5DFWYwODgdcv/B
         LlKHo8EpjSgmabz/Imt4+lVPw+EBBv3fNmdqYJ/iUCU0Ik29pitxg3Cp0kbqJjfnvX
         OhFaoFfDnfGZIBt2ocEB34VoheyXZSJ4dKc0ektVbMBoU4GP1cEIW9gonjb7pF1NT8
         HbCwgnfS3ExLFpxGT2AjQns4/g1joNfkDByH0epqmbISoc9vw+SDUljJYH2p/Hz7j2
         GxtffG/85C4rg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E1vf53318357;
        Wed, 3 Jul 2019 07:01:57 -0700
Date:   Wed, 3 Jul 2019 07:01:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-97860b483c5597663a174ff7405be957b4838391@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        adrian.hunter@intel.com, jolsa@redhat.com, mingo@kernel.org,
        acme@redhat.com
Reply-To: acme@redhat.com, mingo@kernel.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190619064429.14940-2-adrian.hunter@intel.com>
References: <20190619064429.14940-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread-stack: Fix thread stack return from
 kernel for kernel-only case
Git-Commit-ID: 97860b483c5597663a174ff7405be957b4838391
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

Commit-ID:  97860b483c5597663a174ff7405be957b4838391
Gitweb:     https://git.kernel.org/tip/97860b483c5597663a174ff7405be957b4838391
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 19 Jun 2019 09:44:28 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf thread-stack: Fix thread stack return from kernel for kernel-only case

Commit f08046cb3082 ("perf thread-stack: Represent jmps to the start of a
different symbol") had the side-effect of introducing more stack entries
before return from kernel space.

When user space is also traced, those entries are popped before entry to
user space, but when user space is not traced, they get stuck at the
bottom of the stack, making the stack grow progressively larger.

Fix by detecting a return-from-kernel branch type, and popping kernel
addresses from the stack then.

Note, the problem and fix affect the exported Call Graph / Tree but not
the callindent option used by "perf script --call-trace".

Example:

  perf-with-kcore record example -e intel_pt//k -- ls
  perf-with-kcore script example --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py example.db branches calls
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

Committer notes:

The first arg to the perf-with-kcore needs to be the same for the
'record' and 'script' lines, otherwise we'll record the perf.data file
and kcore_dir/ files in one directory ('example') to then try to use it
from the 'bep' directory, fix the instructions above it so that both use
'example'.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: f08046cb3082 ("perf thread-stack: Represent jmps to the start of a different symbol")
Link: http://lkml.kernel.org/r/20190619064429.14940-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c485186a8b6d..4c826a2e08d8 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -628,6 +628,23 @@ static int thread_stack__bottom(struct thread_stack *ts,
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
@@ -910,7 +927,18 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
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
