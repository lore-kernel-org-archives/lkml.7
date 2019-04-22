Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B98C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160A020896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfDVQ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfDVQ1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:27:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC9E74E938;
        Mon, 22 Apr 2019 16:27:00 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69FDA1001E8B;
        Mon, 22 Apr 2019 16:26:54 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH v4] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
Date:   Tue, 23 Apr 2019 00:26:52 +0800
Message-Id: <20190422162652.15483-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Apr 2019 16:27:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
directly when the register is not a real snapshot. And Use SP
as the skip mark, unwinder will skip all the frames until it meet
the frame of the trace point caller.

Tested with frame pointer unwinder and ORC unwinder, this make perf
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
---

Update from V3:
  - Alway start the unwinding directly on fake registers, so we have
    a unified path for both with/without frame pointer and simplify
    the code, as posted by Josh Poimboeuf

Update from V2:
  - Instead of looking at if BP is 0, use X86_EFLAGS_FIXED flag bit as
    the indicator of where the pt_regs is valid for unwinding. As
    suggested by Peter Zijlstra
  - Update some comments accordingly.

Update from V1:
  Get rid of a lot of unneccessary code and just don't dump a inaccurate
  BP, and use SP as the marker for target frame.

 arch/x86/events/core.c            | 21 +++++++++++++++++----
 arch/x86/include/asm/perf_event.h |  7 +------
 arch/x86/include/asm/stacktrace.h | 13 -------------
 include/linux/perf_event.h        |  2 +-
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 81911e11a15d..9856b5b91b9c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2348,6 +2348,15 @@ void arch_perf_update_userpage(struct perf_event *event,
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
@@ -2359,11 +2368,15 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
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
index 8bdf74902293..f4854cd0905b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -260,14 +260,9 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
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
index e47ef764f613..ab135abe62e0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1059,7 +1059,7 @@ static inline void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned lo
  * the nth caller. We only need a few of the regs:
  * - ip for PERF_SAMPLE_IP
  * - cs for user_mode() tests
- * - bp for callchains
+ * - sp for callchains
  * - eflags, for future purposes, just in case
  */
 static inline void perf_fetch_caller_regs(struct pt_regs *regs)
-- 
2.20.1

