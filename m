Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C544BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AF62075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OrvYAuBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfD2GiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:38:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfD2GiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:38:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3T6bhbL783875
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 28 Apr 2019 23:37:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3T6bhbL783875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556519864;
        bh=c1pJt+pj9gad8oxIz3aOg/Rogv+OXtT4TtGgLss8fyg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OrvYAuBa4oBZyD0ZWYq89fIE+6tE5QIzcVkU4o+3o/nrZUeVwXeCkYTNepvgaPV6s
         oo88GIZp+rbt0UmLcJ4fe3mB7E1kbXI+TKbkjmtz2hY7xqwXeYuIA4vR2sxUgUcAD3
         8V7aB7IBI1Nad+zXjHa779WuhpP3DMYCA+ZGllH00TIJ2af+JJN/YyYyJCVpgDGN7H
         D+yk7FavBDkHI3q+0U/c6qZYH1qaHrJupEJGnc7L/3krPj3QIXgbzDdktbmKoh4Ydh
         YpnnLWR0p0z4zo4f7VYLgZgx6UkzrcVBg+eO1wa5FsUVfIWrY3b9sK3h7vovjcRSOz
         RMI3kjRiKpSQQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3T6be7k783870;
        Sun, 28 Apr 2019 23:37:40 -0700
Date:   Sun, 28 Apr 2019 23:37:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kairui Song <tipbot@zytor.com>
Message-ID: <tip-d15d356887e770c5f2dcf963b52c7cb510c9e42d@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, acme@kernel.org, alexei.starovoitov@gmail.com,
        jolsa@redhat.com, hpa@zytor.com, kasong@redhat.com,
        dyoung@redhat.com, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, bp@alien8.de, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Reply-To: dyoung@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jpoimboe@redhat.com, bp@alien8.de,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          peterz@infradead.org, acme@kernel.org, jolsa@redhat.com,
          hpa@zytor.com, alexei.starovoitov@gmail.com, kasong@redhat.com
In-Reply-To: <20190422162652.15483-1-kasong@redhat.com>
References: <20190422162652.15483-1-kasong@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Make perf callchains work without
 CONFIG_FRAME_POINTER
Git-Commit-ID: d15d356887e770c5f2dcf963b52c7cb510c9e42d
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

Commit-ID:  d15d356887e770c5f2dcf963b52c7cb510c9e42d
Gitweb:     https://git.kernel.org/tip/d15d356887e770c5f2dcf963b52c7cb510c9e42d
Author:     Kairui Song <kasong@redhat.com>
AuthorDate: Tue, 23 Apr 2019 00:26:52 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Apr 2019 08:25:05 +0200

perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER

Currently perf callchain doesn't work well with ORC unwinder
when sampling from trace point. We'll get useless in kernel callchain
like this:

perf  6429 [000]    22.498450:             kmem:mm_page_alloc: page=0x176a17 pfn=1534487 order=0 migratetype=0 gfp_flags=GFP_KERNEL
    ffffffffbe23e32e __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
	7efdf7f7d3e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
	5651468729c1 [unknown] (/usr/bin/perf)
	5651467ee82a main+0x69a (/usr/bin/perf)
	7efdf7eaf413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
    5541f689495641d7 [unknown] ([unknown])

The root cause is that, for trace point events, it doesn't provide a
real snapshot of the hardware registers. Instead perf tries to get
required caller's registers and compose a fake register snapshot
which suppose to contain enough information for start a unwinding.
However without CONFIG_FRAME_POINTER, if failed to get caller's BP as the
frame pointer, so current frame pointer is returned instead. We get
a invalid register combination which confuse the unwinder, and end the
stacktrace early.

So in such case just don't try dump BP, and let the unwinder start
directly when the register is not a real snapshot. Use SP
as the skip mark, unwinder will skip all the frames until it meet
the frame of the trace point caller.

Tested with frame pointer unwinder and ORC unwinder, this makes perf
callchain get the full kernel space stacktrace again like this:

perf  6503 [000]  1567.570191:             kmem:mm_page_alloc: page=0x16c904 pfn=1493252 order=0 migratetype=0 gfp_flags=GFP_KERNEL
    ffffffffb523e2ae __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
    ffffffffb52383bd __get_free_pages+0xd (/lib/modules/5.1.0-rc3+/build/vmlinux)
    ffffffffb52fd28a __pollwait+0x8a (/lib/modules/5.1.0-rc3+/build/vmlinux)
    ffffffffb521426f perf_poll+0x2f (/lib/modules/5.1.0-rc3+/build/vmlinux)
    ffffffffb52fe3e2 do_sys_poll+0x252 (/lib/modules/5.1.0-rc3+/build/vmlinux)
    ffffffffb52ff027 __x64_sys_poll+0x37 (/lib/modules/5.1.0-rc3+/build/vmlinux)
    ffffffffb500418b do_syscall_64+0x5b (/lib/modules/5.1.0-rc3+/build/vmlinux)
    ffffffffb5a0008c entry_SYSCALL_64_after_hwframe+0x44 (/lib/modules/5.1.0-rc3+/build/vmlinux)
	7f71e92d03e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
	55a22960d9c1 [unknown] (/usr/bin/perf)
	55a22958982a main+0x69a (/usr/bin/perf)
	7f71e9202413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
    5541f689495641d7 [unknown] ([unknown])

Co-developed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190422162652.15483-1-kasong@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c            | 21 +++++++++++++++++----
 arch/x86/include/asm/perf_event.h |  7 +------
 arch/x86/include/asm/stacktrace.h | 13 -------------
 include/linux/perf_event.h        | 14 ++++++++++----
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index de1a924a4914..f315425d8468 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2382,6 +2382,15 @@ void arch_perf_update_userpage(struct perf_event *event,
 	cyc2ns_read_end();
 }
 
+/*
+ * Determine whether the regs were taken from an irq/exception handler rather
+ * than from perf_arch_fetch_caller_regs().
+ */
+static bool perf_hw_regs(struct pt_regs *regs)
+{
+	return regs->flags & X86_EFLAGS_FIXED;
+}
+
 void
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
@@ -2393,11 +2402,15 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 		return;
 	}
 
-	if (perf_callchain_store(entry, regs->ip))
-		return;
+	if (perf_hw_regs(regs)) {
+		if (perf_callchain_store(entry, regs->ip))
+			return;
+		unwind_start(&state, current, regs, NULL);
+	} else {
+		unwind_start(&state, current, NULL, (void *)regs->sp);
+	}
 
-	for (unwind_start(&state, current, regs, NULL); !unwind_done(&state);
-	     unwind_next_frame(&state)) {
+	for (; !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
 		if (!addr || perf_callchain_store(entry, addr))
 			return;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 04768a3a5454..1392d5e6e8d6 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -308,14 +308,9 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
  */
 #define perf_arch_fetch_caller_regs(regs, __ip)		{	\
 	(regs)->ip = (__ip);					\
-	(regs)->bp = caller_frame_pointer();			\
+	(regs)->sp = (unsigned long)__builtin_frame_address(0);	\
 	(regs)->cs = __KERNEL_CS;				\
 	regs->flags = 0;					\
-	asm volatile(						\
-		_ASM_MOV "%%"_ASM_SP ", %0\n"			\
-		: "=m" ((regs)->sp)				\
-		:: "memory"					\
-	);							\
 }
 
 struct perf_guest_switch_msr {
diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index f335aad404a4..beef7ad9e43a 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -98,19 +98,6 @@ struct stack_frame_ia32 {
     u32 return_address;
 };
 
-static inline unsigned long caller_frame_pointer(void)
-{
-	struct stack_frame *frame;
-
-	frame = __builtin_frame_address(0);
-
-#ifdef CONFIG_FRAME_POINTER
-	frame = frame->next_frame;
-#endif
-
-	return (unsigned long)frame;
-}
-
 void show_opcodes(struct pt_regs *regs, const char *loglvl);
 void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f3864e1c5569..cf023db0e8a2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1058,12 +1058,18 @@ static inline void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned lo
 #endif
 
 /*
- * Take a snapshot of the regs. Skip ip and frame pointer to
- * the nth caller. We only need a few of the regs:
+ * When generating a perf sample in-line, instead of from an interrupt /
+ * exception, we lack a pt_regs. This is typically used from software events
+ * like: SW_CONTEXT_SWITCHES, SW_MIGRATIONS and the tie-in with tracepoints.
+ *
+ * We typically don't need a full set, but (for x86) do require:
  * - ip for PERF_SAMPLE_IP
  * - cs for user_mode() tests
- * - bp for callchains
- * - eflags, for future purposes, just in case
+ * - sp for PERF_SAMPLE_CALLCHAIN
+ * - eflags for MISC bits and CALLCHAIN (see: perf_hw_regs())
+ *
+ * NOTE: assumes @regs is otherwise already 0 filled; this is important for
+ * things like PERF_SAMPLE_REGS_INTR.
  */
 static inline void perf_fetch_caller_regs(struct pt_regs *regs)
 {
