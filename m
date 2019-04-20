Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85EAC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6275621479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555746241;
	bh=5DkZr9CSd1HYGtheUBX60Sj3nBk1QF6fyUnQhauIZIQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XEK2MnFEs7hrfVRCJZZGzx4RUGpmxCNVIWeMQ40gHTo1r3m3A0h2dHvskU5RwYM6X
	 yoOfcGmJLKyHiU2BX7Awls9C/mlqa48ID1y/nJSXOXVvIUF6SJf817FQgdUeo8ZFjl
	 DBDZwj0Htslg3hrtgREWvw/FTNZ/11rGJHAy9LUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfDTHoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:44:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56212 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfDTHn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:43:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so8384321wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aIiU4SKsXaIwSaKcPPdJcYAJh9+SPbd82z4iE+HbIrU=;
        b=Mq6wtiwjqpnmHcFi3qIZEWT8B+AP99r3ohtW7wGev3SbIaYsc0klA0l23Ao2vsdyFf
         hg8imLFm9YVWHPaDICJs6sBFSCyFpiwbTBeSEQnDEpY+nxzTbhcqF86G8ZxOw8knEZT6
         opemXegMzOffB4iHmGv+da1LRDLjS3W0mpIhPu+r5rDVyKXpbkQnRErKFQk5Z6GACT0V
         57ABRoXEHIi3ToPLBWsb+1b0QnAHkXIi5xgFWBA1yoq+05VIpEeWdsWU/dbESZwYv/f/
         knjPKDa1iQYg1LYGZiEwVSfQarfNTtEy/M7GX52un++tM9ZwAEoIhBlESLHe7Y4eDp6U
         QM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=aIiU4SKsXaIwSaKcPPdJcYAJh9+SPbd82z4iE+HbIrU=;
        b=ffK7I5+Pv4r5EvKVqsVKTvsJUmHnszUZwQ8iMUcuP8a8TbSDHVIrLdxnuawduA9BaH
         8pqsYHDLPJE2mHUnO+G7yQGZQ0ft8dJRHHUB2MgLBYqsCBumHWhxTFFgHyKNBEOsy5Cm
         sXAPvjZKUz/20HhfXPqcW7xGL+HybeJNQcHz4F5SD85a3pNkCuZbR364vZIL0rMtQP9y
         LyFap4/9qA5aOGJ10YG4a5Il1KtJcH/WFqdthnsiZJ2gTj+8VZB9bOmpwXlGQr8IEtKY
         zJy+ZXBWf55JlZrVBKBmJ1narxgTd+9rwfh2REbUzHn+MUxLRQ8fua1MxmDvA5KJZGh3
         mnIQ==
X-Gm-Message-State: APjAAAUXDcmhp0Nf5Fr4gCRosn5WtjPF0xANH5h+0oXMCaSAyO8rsFQC
        cLgXdY74eZ/UcJ/0IU7EMeg=
X-Google-Smtp-Source: APXvYqzW3VDlfBrD1g7yh/QMnGE/tb9QEuOq/Y4z5CgNXfTJhugLk44kZ+wdjRtQtR7tFECf+zAaUw==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr5199799wml.110.1555746236428;
        Sat, 20 Apr 2019 00:43:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v1sm6172381wrd.47.2019.04.20.00.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 00:43:55 -0700 (PDT)
Date:   Sat, 20 Apr 2019 09:43:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL] perf fixes
Message-ID: <20190420074353.GA108422@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 7579dfc42d2e3bef901991803efc81dc1ac65f2b Merge tag 'perf-urgent-for-mingo-5.1-20190419' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Misc fixes:

 - various tooling fixes
 - kretprobe fixes
 - kprobes annotation fixes
 - kprobes error checking fix
 - fix the default events for AMD Family 17h CPUs
 - PEBS fix
 - AUX record fix
 - address filtering fix

 Thanks,

	Ingo

------------------>
Adrian Hunter (1):
      perf scripts python: export-to-sqlite.py: Fix use of parent_id in calls_view

Alexander Shishkin (2):
      perf/core: Fix the address filtering fix
      perf/ring_buffer: Fix AUX record suppression

Arnaldo Carvalho de Melo (1):
      tools include uapi: Sync sound/asound.h copy

Gustavo A. R. Silva (1):
      perf header: Fix lock/unlock imbalances when processing BPF/BTF info

Jiri Olsa (6):
      perf stat: Disable DIR_FORMAT feature for 'perf stat record'
      perf top: Always sample time to satisfy needs of use of ordered queuing
      perf bpf: Return NULL when RB tree lookup fails in perf_env__find_bpf_prog_info()
      perf evlist: Fix side band thread draining
      perf tools: Fix map reference counting
      perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf()

Kan Liang (1):
      perf/x86: Fix incorrect PEBS_REGS

Kim Phillips (1):
      perf/x86/amd: Add event map for AMD Family 17h

Mao Han (1):
      perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user)

Masami Hiramatsu (4):
      kprobes: Fix error check when reusing optimized probes
      x86/kprobes: Verify stack frame on kretprobe
      kprobes: Mark ftrace mcount handler functions nokprobe
      x86/kprobes: Avoid kretprobe recursion bug

Rikard Falkeborn (1):
      tools lib traceevent: Fix missing equality check for strcmp

Song Liu (1):
      perf tools: Check maps for bpf programs


 arch/x86/events/amd/core.c                    | 35 ++++++++++++++-----
 arch/x86/events/intel/core.c                  |  2 +-
 arch/x86/events/perf_event.h                  | 38 ++++++++++-----------
 arch/x86/kernel/kprobes/core.c                | 48 +++++++++++++++++++++++++--
 include/linux/kprobes.h                       |  1 +
 kernel/events/core.c                          | 37 ++++++++++++---------
 kernel/events/ring_buffer.c                   | 33 +++++++++---------
 kernel/kprobes.c                              |  6 ++--
 kernel/trace/ftrace.c                         |  6 +++-
 tools/include/uapi/sound/asound.h             |  1 +
 tools/lib/traceevent/event-parse.c            |  2 +-
 tools/perf/builtin-stat.c                     |  1 +
 tools/perf/builtin-top.c                      |  1 +
 tools/perf/scripts/python/export-to-sqlite.py |  2 +-
 tools/perf/util/env.c                         |  8 +++--
 tools/perf/util/evlist.c                      | 14 +++++---
 tools/perf/util/evsel.c                       | 12 +++----
 tools/perf/util/header.c                      | 22 +++++++-----
 tools/perf/util/map.c                         | 20 +++++++++--
 tools/perf/util/map.h                         |  4 ++-
 20 files changed, 195 insertions(+), 98 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 0ecfac84ba91..d45f3fbd232e 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -117,22 +117,39 @@ static __initconst const u64 amd_hw_cache_event_ids
 };
 
 /*
- * AMD Performance Monitor K7 and later.
+ * AMD Performance Monitor K7 and later, up to and including Family 16h:
  */
 static const u64 amd_perfmon_event_map[PERF_COUNT_HW_MAX] =
 {
-  [PERF_COUNT_HW_CPU_CYCLES]			= 0x0076,
-  [PERF_COUNT_HW_INSTRUCTIONS]			= 0x00c0,
-  [PERF_COUNT_HW_CACHE_REFERENCES]		= 0x077d,
-  [PERF_COUNT_HW_CACHE_MISSES]			= 0x077e,
-  [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]		= 0x00c2,
-  [PERF_COUNT_HW_BRANCH_MISSES]			= 0x00c3,
-  [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00d0, /* "Decoder empty" event */
-  [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x00d1, /* "Dispatch stalls" event */
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0x077d,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x077e,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00d0, /* "Decoder empty" event */
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x00d1, /* "Dispatch stalls" event */
+};
+
+/*
+ * AMD Performance Monitor Family 17h and later:
+ */
+static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
+{
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0xff60,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x0287,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x0187,
 };
 
 static u64 amd_pmu_event_map(int hw_event)
 {
+	if (boot_cpu_data.x86 >= 0x17)
+		return amd_f17h_perfmon_event_map[hw_event];
+
 	return amd_perfmon_event_map[hw_event];
 }
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f61dcbef20ff..f9451566cd9b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3131,7 +3131,7 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_REGS)
+	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
 		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
 	return flags;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a75955741c50..1e98a42b560a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -96,25 +96,25 @@ struct amd_nb {
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
 	PERF_SAMPLE_PERIOD)
 
-#define PEBS_REGS \
-	(PERF_REG_X86_AX | \
-	 PERF_REG_X86_BX | \
-	 PERF_REG_X86_CX | \
-	 PERF_REG_X86_DX | \
-	 PERF_REG_X86_DI | \
-	 PERF_REG_X86_SI | \
-	 PERF_REG_X86_SP | \
-	 PERF_REG_X86_BP | \
-	 PERF_REG_X86_IP | \
-	 PERF_REG_X86_FLAGS | \
-	 PERF_REG_X86_R8 | \
-	 PERF_REG_X86_R9 | \
-	 PERF_REG_X86_R10 | \
-	 PERF_REG_X86_R11 | \
-	 PERF_REG_X86_R12 | \
-	 PERF_REG_X86_R13 | \
-	 PERF_REG_X86_R14 | \
-	 PERF_REG_X86_R15)
+#define PEBS_GP_REGS			\
+	((1ULL << PERF_REG_X86_AX)    | \
+	 (1ULL << PERF_REG_X86_BX)    | \
+	 (1ULL << PERF_REG_X86_CX)    | \
+	 (1ULL << PERF_REG_X86_DX)    | \
+	 (1ULL << PERF_REG_X86_DI)    | \
+	 (1ULL << PERF_REG_X86_SI)    | \
+	 (1ULL << PERF_REG_X86_SP)    | \
+	 (1ULL << PERF_REG_X86_BP)    | \
+	 (1ULL << PERF_REG_X86_IP)    | \
+	 (1ULL << PERF_REG_X86_FLAGS) | \
+	 (1ULL << PERF_REG_X86_R8)    | \
+	 (1ULL << PERF_REG_X86_R9)    | \
+	 (1ULL << PERF_REG_X86_R10)   | \
+	 (1ULL << PERF_REG_X86_R11)   | \
+	 (1ULL << PERF_REG_X86_R12)   | \
+	 (1ULL << PERF_REG_X86_R13)   | \
+	 (1ULL << PERF_REG_X86_R14)   | \
+	 (1ULL << PERF_REG_X86_R15))
 
 /*
  * Per register state.
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a034cb808e7e..fed46ddb1eef 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -569,6 +569,7 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 	unsigned long *sara = stack_addr(regs);
 
 	ri->ret_addr = (kprobe_opcode_t *) *sara;
+	ri->fp = sara;
 
 	/* Replace the return addr with trampoline addr */
 	*sara = (unsigned long) &kretprobe_trampoline;
@@ -748,26 +749,48 @@ asm(
 NOKPROBE_SYMBOL(kretprobe_trampoline);
 STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 
+static struct kprobe kretprobe_kprobe = {
+	.addr = (void *)kretprobe_trampoline,
+};
+
 /*
  * Called from kretprobe_trampoline
  */
 static __used void *trampoline_handler(struct pt_regs *regs)
 {
+	struct kprobe_ctlblk *kcb;
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
 	struct hlist_node *tmp;
 	unsigned long flags, orig_ret_address = 0;
 	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
 	kprobe_opcode_t *correct_ret_addr = NULL;
+	void *frame_pointer;
+	bool skipped = false;
+
+	preempt_disable();
+
+	/*
+	 * Set a dummy kprobe for avoiding kretprobe recursion.
+	 * Since kretprobe never run in kprobe handler, kprobe must not
+	 * be running at this point.
+	 */
+	kcb = get_kprobe_ctlblk();
+	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
 	/* fixup registers */
 #ifdef CONFIG_X86_64
 	regs->cs = __KERNEL_CS;
+	/* On x86-64, we use pt_regs->sp for return address holder. */
+	frame_pointer = &regs->sp;
 #else
 	regs->cs = __KERNEL_CS | get_kernel_rpl();
 	regs->gs = 0;
+	/* On x86-32, we use pt_regs->flags for return address holder. */
+	frame_pointer = &regs->flags;
 #endif
 	regs->ip = trampoline_address;
 	regs->orig_ax = ~0UL;
@@ -789,8 +812,25 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 		if (ri->task != current)
 			/* another task is sharing our hash bucket */
 			continue;
+		/*
+		 * Return probes must be pushed on this hash list correct
+		 * order (same as return order) so that it can be poped
+		 * correctly. However, if we find it is pushed it incorrect
+		 * order, this means we find a function which should not be
+		 * probed, because the wrong order entry is pushed on the
+		 * path of processing other kretprobe itself.
+		 */
+		if (ri->fp != frame_pointer) {
+			if (!skipped)
+				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
+			skipped = true;
+			continue;
+		}
 
 		orig_ret_address = (unsigned long)ri->ret_addr;
+		if (skipped)
+			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
+				ri->rp->kp.addr);
 
 		if (orig_ret_address != trampoline_address)
 			/*
@@ -808,14 +848,15 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 		if (ri->task != current)
 			/* another task is sharing our hash bucket */
 			continue;
+		if (ri->fp != frame_pointer)
+			continue;
 
 		orig_ret_address = (unsigned long)ri->ret_addr;
 		if (ri->rp && ri->rp->handler) {
 			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
 			ri->ret_addr = correct_ret_addr;
 			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
+			__this_cpu_write(current_kprobe, &kretprobe_kprobe);
 		}
 
 		recycle_rp_inst(ri, &empty_rp);
@@ -831,6 +872,9 @@ static __used void *trampoline_handler(struct pt_regs *regs)
 
 	kretprobe_hash_unlock(current, &flags);
 
+	__this_cpu_write(current_kprobe, NULL);
+	preempt_enable();
+
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 201f0f2683f2..9a897256e481 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -173,6 +173,7 @@ struct kretprobe_instance {
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
+	void *fp;
 	char data[0];
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 534e01e7bc36..dc7dead2d2cc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9077,26 +9077,29 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 	if (task == TASK_TOMBSTONE)
 		return;
 
-	if (!ifh->nr_file_filters)
-		return;
-
-	mm = get_task_mm(event->ctx->task);
-	if (!mm)
-		goto restart;
+	if (ifh->nr_file_filters) {
+		mm = get_task_mm(event->ctx->task);
+		if (!mm)
+			goto restart;
 
-	down_read(&mm->mmap_sem);
+		down_read(&mm->mmap_sem);
+	}
 
 	raw_spin_lock_irqsave(&ifh->lock, flags);
 	list_for_each_entry(filter, &ifh->list, entry) {
-		event->addr_filter_ranges[count].start = 0;
-		event->addr_filter_ranges[count].size = 0;
+		if (filter->path.dentry) {
+			/*
+			 * Adjust base offset if the filter is associated to a
+			 * binary that needs to be mapped:
+			 */
+			event->addr_filter_ranges[count].start = 0;
+			event->addr_filter_ranges[count].size = 0;
 
-		/*
-		 * Adjust base offset if the filter is associated to a binary
-		 * that needs to be mapped:
-		 */
-		if (filter->path.dentry)
 			perf_addr_filter_apply(filter, mm, &event->addr_filter_ranges[count]);
+		} else {
+			event->addr_filter_ranges[count].start = filter->offset;
+			event->addr_filter_ranges[count].size  = filter->size;
+		}
 
 		count++;
 	}
@@ -9104,9 +9107,11 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 	event->addr_filters_gen++;
 	raw_spin_unlock_irqrestore(&ifh->lock, flags);
 
-	up_read(&mm->mmap_sem);
+	if (ifh->nr_file_filters) {
+		up_read(&mm->mmap_sem);
 
-	mmput(mm);
+		mmput(mm);
+	}
 
 restart:
 	perf_event_stop(event, 1);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 2545ac08cc77..5eedb49a65ea 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -455,24 +455,21 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		rb->aux_head += size;
 	}
 
-	if (size || handle->aux_flags) {
-		/*
-		 * Only send RECORD_AUX if we have something useful to communicate
-		 *
-		 * Note: the OVERWRITE records by themselves are not considered
-		 * useful, as they don't communicate any *new* information,
-		 * aside from the short-lived offset, that becomes history at
-		 * the next event sched-in and therefore isn't useful.
-		 * The userspace that needs to copy out AUX data in overwrite
-		 * mode should know to use user_page::aux_head for the actual
-		 * offset. So, from now on we don't output AUX records that
-		 * have *only* OVERWRITE flag set.
-		 */
-
-		if (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE)
-			perf_event_aux_event(handle->event, aux_head, size,
-			                     handle->aux_flags);
-	}
+	/*
+	 * Only send RECORD_AUX if we have something useful to communicate
+	 *
+	 * Note: the OVERWRITE records by themselves are not considered
+	 * useful, as they don't communicate any *new* information,
+	 * aside from the short-lived offset, that becomes history at
+	 * the next event sched-in and therefore isn't useful.
+	 * The userspace that needs to copy out AUX data in overwrite
+	 * mode should know to use user_page::aux_head for the actual
+	 * offset. So, from now on we don't output AUX records that
+	 * have *only* OVERWRITE flag set.
+	 */
+	if (size || (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE))
+		perf_event_aux_event(handle->event, aux_head, size,
+				     handle->aux_flags);
 
 	rb->user_page->aux_head = rb->aux_head;
 	if (rb_need_aux_wakeup(rb))
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c83e54727131..b1ea30a5540e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -709,7 +709,6 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 static int reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
-	int ret;
 
 	/*
 	 * Unused kprobe MUST be on the way of delayed unoptimizing (means
@@ -720,9 +719,8 @@ static int reuse_unused_kprobe(struct kprobe *ap)
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again (remove from op->list) */
-	ret = kprobe_optready(ap);
-	if (ret)
-		return ret;
+	if (!kprobe_optready(ap))
+		return -EINVAL;
 
 	optimize_kprobe(ap);
 	return 0;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 26c8ca9bd06b..b920358dd8f7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -33,6 +33,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/rcupdate.h>
+#include <linux/kprobes.h>
 
 #include <trace/events/sched.h>
 
@@ -6246,7 +6247,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
 	tr->ops->func = ftrace_stub;
 }
 
-static inline void
+static nokprobe_inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *ignored, struct pt_regs *regs)
 {
@@ -6306,11 +6307,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
 }
+NOKPROBE_SYMBOL(ftrace_ops_list_func);
 #else
 static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
 }
+NOKPROBE_SYMBOL(ftrace_ops_no_ops);
 #endif
 
 /*
@@ -6337,6 +6340,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
 }
+NOKPROBE_SYMBOL(ftrace_ops_assist_func);
 
 /**
  * ftrace_ops_get_func - get the function a trampoline should call
diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index 404d4b9ffe76..df1153cea0b7 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -32,6 +32,7 @@
 
 #ifndef __KERNEL__
 #include <stdlib.h>
+#include <time.h>
 #endif
 
 /*
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 87494c7c619d..981c6ce2da2c 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2233,7 +2233,7 @@ eval_type_str(unsigned long long val, const char *type, int pointer)
 		return val & 0xffffffff;
 
 	if (strcmp(type, "u64") == 0 ||
-	    strcmp(type, "s64"))
+	    strcmp(type, "s64") == 0)
 		return val;
 
 	if (strcmp(type, "s8") == 0)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 49ee3c2033ec..c3625ec374e0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1308,6 +1308,7 @@ static void init_features(struct perf_session *session)
 	for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
 		perf_header__set_feat(&session->header, feat);
 
+	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
 	perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 	perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
 	perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1999d6533d12..fbbb0da43abb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1377,6 +1377,7 @@ int cmd_top(int argc, const char **argv)
 			 * */
 			.overwrite	= 0,
 			.sample_time	= true,
+			.sample_time_set = true,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 3b71902a5a21..bf271fbc3a88 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -331,7 +331,7 @@ if perf_db_export_calls:
 			'return_id,'
 			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
 			'parent_call_path_id,'
-			'parent_id'
+			'calls.parent_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
 do_query(query, 'CREATE VIEW samples_view AS '
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index c6351b557bb0..9494f9dc61ec 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -57,9 +57,11 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 		else if (prog_id > node->info_linear->info.id)
 			n = n->rb_right;
 		else
-			break;
+			goto out;
 	}
+	node = NULL;
 
+out:
 	up_read(&env->bpf_progs.lock);
 	return node;
 }
@@ -109,10 +111,12 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 		else if (btf_id > node->id)
 			n = n->rb_right;
 		else
-			break;
+			goto out;
 	}
+	node = NULL;
 
 	up_read(&env->bpf_progs.lock);
+out:
 	return node;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6689378ee577..51ead577533f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1868,12 +1868,12 @@ static void *perf_evlist__poll_thread(void *arg)
 {
 	struct perf_evlist *evlist = arg;
 	bool draining = false;
-	int i;
+	int i, done = 0;
+
+	while (!done) {
+		bool got_data = false;
 
-	while (draining || !(evlist->thread.done)) {
-		if (draining)
-			draining = false;
-		else if (evlist->thread.done)
+		if (evlist->thread.done)
 			draining = true;
 
 		if (!draining)
@@ -1894,9 +1894,13 @@ static void *perf_evlist__poll_thread(void *arg)
 					pr_warning("cannot locate proper evsel for the side band event\n");
 
 				perf_mmap__consume(map);
+				got_data = true;
 			}
 			perf_mmap__read_done(map);
 		}
+
+		if (draining && !got_data)
+			break;
 	}
 	return NULL;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66d066f18b5b..966360844fff 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2368,7 +2368,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->user_regs.abi) {
 			u64 mask = evsel->attr.sample_regs_user;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->user_regs.mask = mask;
 			data->user_regs.regs = (u64 *)array;
@@ -2424,7 +2424,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
 			u64 mask = evsel->attr.sample_regs_intr;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->intr_regs.mask = mask;
 			data->intr_regs.regs = (u64 *)array;
@@ -2552,7 +2552,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2580,7 +2580,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2710,7 +2710,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			*array++ = sample->user_regs.abi;
-			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
 			memcpy(array, sample->user_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
@@ -2746,7 +2746,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			*array++ = sample->intr_regs.abi;
-			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
 			memcpy(array, sample->intr_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b9e693825873..2d2af2ac2b1e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
+	up_write(&env->bpf_progs.lock);
 	return 0;
 out:
 	free(info_linear);
@@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
 static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 {
 	struct perf_env *env = &ff->ph->env;
+	struct btf_node *node = NULL;
 	u32 count, i;
+	int err = -1;
 
 	if (ff->ph->needs_swap) {
 		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
@@ -2636,31 +2639,32 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 	down_write(&env->bpf_progs.lock);
 
 	for (i = 0; i < count; ++i) {
-		struct btf_node *node;
 		u32 id, data_size;
 
 		if (do_read_u32(ff, &id))
-			return -1;
+			goto out;
 		if (do_read_u32(ff, &data_size))
-			return -1;
+			goto out;
 
 		node = malloc(sizeof(struct btf_node) + data_size);
 		if (!node)
-			return -1;
+			goto out;
 
 		node->id = id;
 		node->data_size = data_size;
 
-		if (__do_read(ff, node->data, data_size)) {
-			free(node);
-			return -1;
-		}
+		if (__do_read(ff, node->data, data_size))
+			goto out;
 
 		perf_env__insert_btf(env, node);
+		node = NULL;
 	}
 
+	err = 0;
+out:
 	up_write(&env->bpf_progs.lock);
-	return 0;
+	free(node);
+	return err;
 }
 
 struct feature_ops {
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e32628cd20a7..ee71efb9db62 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -261,6 +261,22 @@ bool __map__is_extra_kernel_map(const struct map *map)
 	return kmap && kmap->name[0];
 }
 
+bool __map__is_bpf_prog(const struct map *map)
+{
+	const char *name;
+
+	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return true;
+
+	/*
+	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
+	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
+	 * guess the type based on name.
+	 */
+	name = map->dso->short_name;
+	return name && (strstr(name, "bpf_prog_") == name);
+}
+
 bool map__has_symbols(const struct map *map)
 {
 	return dso__has_symbols(map->dso);
@@ -910,10 +926,8 @@ static void __maps__insert_name(struct maps *maps, struct map *map)
 		rc = strcmp(m->dso->short_name, map->dso->short_name);
 		if (rc < 0)
 			p = &(*p)->rb_left;
-		else if (rc  > 0)
-			p = &(*p)->rb_right;
 		else
-			return;
+			p = &(*p)->rb_right;
 	}
 	rb_link_node(&map->rb_node_name, parent, p);
 	rb_insert_color(&map->rb_node_name, &maps->names);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 0e20749f2c55..dc93787c74f0 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -159,10 +159,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 
 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
+bool __map__is_bpf_prog(const struct map *map);
 
 static inline bool __map__is_kmodule(const struct map *map)
 {
-	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map);
+	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &&
+	       !__map__is_bpf_prog(map);
 }
 
 bool map__has_symbols(const struct map *map);
