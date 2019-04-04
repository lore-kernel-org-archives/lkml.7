Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E595BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20FF206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfDDR0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfDDR0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:26:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B2E859447;
        Thu,  4 Apr 2019 17:26:00 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9636D60BF7;
        Thu,  4 Apr 2019 17:25:51 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
Date:   Fri,  5 Apr 2019 01:25:45 +0800
Message-Id: <20190404172545.20928-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 04 Apr 2019 17:26:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf callchain is not working properly with ORC unwinder,
we'll get useless in kernel callchain like this:

perf  6429 [000]    22.498450:             kmem:mm_page_alloc: page=0x176a17 pfn=1534487 order=0 migratetype=0 gfp_flags=GFP_KERNEL
        ffffffffbe23e32e __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
            7efdf7f7d3e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
            5651468729c1 [unknown] (/usr/bin/perf)
            5651467ee82a main+0x69a (/usr/bin/perf)
            7efdf7eaf413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
        5541f689495641d7 [unknown] ([unknown])

Without CONFIG_FRAME_POINTER, bp is not reserved as frame pointer so
can't get callers frame pointer, instead current frame pointer is
returned when trying to fetch caller registers. The unwinder will error
out early, and end the stacktrace early.

So instead of let the unwinder start with the dumped register, we start
it right where the unwinding started when the stacktrace is triggered by
trace event directly. And skip until the frame pointer is reached.

This makes the callchain get the full in kernel stacktrace again:

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

----

Just found with ORC unwinder the perf callchain is unusable, and this
seems fixes it well, any suggestion is welcome, thanks!

---
 arch/x86/events/core.c     | 34 ++++++++++++++++++++++++++++------
 include/linux/perf_event.h |  3 ++-
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 13 +++++++++++--
 kernel/events/core.c       |  2 +-
 5 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447192a8..3f3e110794ac 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2355,8 +2355,9 @@ void arch_perf_update_userpage(struct perf_event *event,
 	cyc2ns_read_end();
 }
 
-void
-perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
+static void
+__perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs,
+			bool direct_call)
 {
 	struct unwind_state state;
 	unsigned long addr;
@@ -2366,17 +2367,38 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 		return;
 	}
 
-	if (perf_callchain_store(entry, regs->ip))
-		return;
+	/*
+	 * Without frame pointer, we can't get a reliable caller bp value.
+	 * If this is called directly from a trace point, just start the
+	 * unwind from here and skip until the frame is reached.
+	 */
+	if (IS_ENABLED(CONFIG_FRAME_POINTER) || !direct_call) {
+		if (perf_callchain_store(entry, regs->ip))
+			return;
+		unwind_start(&state, current, regs, NULL);
+	} else {
+		unwind_start(&state, current, NULL, (unsigned long*)regs->bp);
+	}
 
-	for (unwind_start(&state, current, regs, NULL); !unwind_done(&state);
-	     unwind_next_frame(&state)) {
+	for (; !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
 		if (!addr || perf_callchain_store(entry, addr))
 			return;
 	}
 }
 
+void
+perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
+{
+	__perf_callchain_kernel(entry, regs, false);
+}
+
+void
+perf_callchain_kernel_direct(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
+{
+	__perf_callchain_kernel(entry, regs, true);
+}
+
 static inline int
 valid_user_frame(const void __user *fp, unsigned long size)
 {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e47ef764f613..b0e33ba36695 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1154,9 +1154,10 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
+extern void perf_callchain_kernel_direct(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool crosstask, bool add_mark, bool direct_call);
 extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 950ab2f28922..376d774da6b5 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -368,7 +368,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		return -EINVAL;
 
 	trace = get_perf_callchain(regs, init_nr, kernel, user,
-				   sysctl_perf_event_max_stack, false, false);
+				   sysctl_perf_event_max_stack, false, false, false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -476,7 +476,7 @@ BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size,
 	else
 		init_nr = sysctl_perf_event_max_stack - num_elem;
 	trace = get_perf_callchain(regs, init_nr, kernel, user,
-				   sysctl_perf_event_max_stack, false, false);
+				   sysctl_perf_event_max_stack, false, false, false);
 	if (unlikely(!trace))
 		goto err_fault;
 
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index c2b41a263166..4cb5861f57ee 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -40,6 +40,12 @@ __weak void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 {
 }
 
+__weak void perf_callchain_kernel_direct(struct perf_callchain_entry_ctx *entry,
+				  struct pt_regs *regs)
+{
+	perf_callchain_kernel(entry, regs);
+}
+
 __weak void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 				struct pt_regs *regs)
 {
@@ -176,7 +182,7 @@ put_callchain_entry(int rctx)
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool crosstask, bool add_mark, bool direct_call)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -198,7 +204,10 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	if (kernel && !user_mode(regs)) {
 		if (add_mark)
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
-		perf_callchain_kernel(&ctx, regs);
+		if (direct_call)
+			perf_callchain_kernel_direct(&ctx, regs);
+		else
+			perf_callchain_kernel(&ctx, regs);
 	}
 
 	if (user) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 72d06e302e99..af9fb9b03283 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6377,7 +6377,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 		return &__empty_callchain;
 
 	callchain = get_perf_callchain(regs, 0, kernel, user,
-				       max_stack, crosstask, true);
+				       max_stack, crosstask, true, true);
 	return callchain ?: &__empty_callchain;
 }
 
-- 
2.20.1

