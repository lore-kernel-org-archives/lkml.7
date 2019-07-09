Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFFC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8A12173E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562680116;
	bh=fXkuDk6YYSk4suUzFc2Y+wC0sy4EF6NVY4YxJj25J+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gU761a3ZIHLSXcvj86oAw6r2BGw3lqbB2MxWQqI1HOcaCInu0Gl9grWxn6+xoLDOs
	 eY74dQDCeJZjPFkENFeFlgrgSzmDm7jIigQgAP/7j0n9FhHzvnI8rkf7JUQ7NBs/hM
	 aoE0UrX1ejVsmNIslxLtSh+Nmu4YEWHx0QM/qLSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfGINsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGINsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:48:33 -0400
Received: from lerouge.home (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA142173C;
        Tue,  9 Jul 2019 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562680111;
        bh=fXkuDk6YYSk4suUzFc2Y+wC0sy4EF6NVY4YxJj25J+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1WaA0Sd3Hb9e04fcCXKpqEGl54k+/6hDt4djp4K9yfqcS9F5lBgMXLwkHrFQNtjjV
         X6tkNTTrMryz0WSOM24zYeoDBrh2zkNeJqaI2W+v94SOyZLjzEVOWHQCeBIns4Dxxj
         F/pNtoYVS21oYCEZx8HpJj/q5MRqBZogUdE/x+Gc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Borislav Petkov <bp@suse.de>,
        syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/2] perf/hw_breakpoints: Pin perf contexts of breakpoints
Date:   Tue,  9 Jul 2019 15:48:21 +0200
Message-Id: <20190709134821.8027-3-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709134821.8027-1-frederic@kernel.org>
References: <20190709134821.8027-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The breakpoints core deals with limited architecture resources that need
to be shared among all the breakpoint perf events. For example x86 has
4 breakpoint registers per-CPU. This means that a task can't open more
than 4 breakpoints in this architecture.

To control that we must track the number of breakpoints held for each
task. This is simply implemented with a global list of all breakpoints
that we walk and count on top of their target task.

But this wrongly assume that the target task of a perf event remains
stable after the event creation. Context tasks can get swapped on context
switches and it's fairly common for a perf event's initial target
(event->hw.target) to become irrelevantly out of date at
struct perf_event::destroy() time.

Here is an interesting scenario where it matters: TASK A and B are clones
that share 4 equivalent breakpoints. A and B contexts are swapped on
context switch. So task A now carries the breakpoints that were initialized
in B. Task A quits and release its breakpoints whose target (event->hw.target)
still point to B. Therefore the breakpoints slots are spuriously released
on B. Afterward, if task B were to create a 5th breakpoint then it would
be accepted. But on architecture breakpoint installation time, that 5th
breakpoint will be eventually rejected:

	Can't find any breakpoint slot
	 WARNING: CPU: 6 PID: 2433 at arch/x86/kernel/hw_breakpoint.c:109 arch_install_hw_breakpoint+0x176/0x180
	 Modules linked in:
	 CPU: 6 PID: 2433 Comm: bp5 Not tainted 5.2.0-rc6+ #20
	 Hardware name: MSI MS-7850/Z87-G41 PC Mate(MS-7850), BIOS V1.3 08/18/2013
	 RIP: 0010:arch_install_hw_breakpoint+0x176/0x180
	 Code: 57 ff ff ff 0f 23 c8 e9 4f ff ff ff 0f 23 d0 e9 47 ff ff ff 48 c7 c7 d8 cd 2b 82 89 45 d0 c6 05 d4 bc 4f 01 01 e8 0a b8 09 00 <0f> 0b 8b 45 d0 e9 ed fe ff ff 0f 1f 44 00 00 55 48 89 e5 41 57 41
	 RSP: 0018:ffffc900006dfa48 EFLAGS: 00010082
	 RAX: 0000000000000000 RBX: ffff88821fb17f78 RCX: 0000000000000000
	 RDX: ffffffff81148b59 RSI: 0000000000000001 RDI: ffffffff81148bb5
	 RBP: ffffc900006dfa78 R08: 0000000000000000 R09: 0000000000000000
	 R10: ffffc900006dfaa0 R11: 0000000000000981 R12: 0000000000000003
	 R13: ffff88821206b800 R14: 0000000000017f80 R15: 0000000000000004
	 FS:  00007f46d1a54440(0000) GS:ffff88821fb00000(0000) knlGS:0000000000000000
	 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	 CR2: 00007f46d1590450 CR3: 000000020f1c8004 CR4: 00000000001706e0
	 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
	 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000999906aa
	 Call Trace:
	  hw_breakpoint_add+0x44/0x50
	  event_sched_in.isra.119+0xab/0x240
	  group_sched_in+0x60/0x150
	  pinned_sched_in+0x85/0x170
	  ? group_sched_in+0x150/0x150
	  visit_groups_merge+0x10a/0x180
	  ctx_sched_in.isra.89+0x12b/0x150
	  perf_event_sched_in.isra.91+0x2f/0x70
	  ctx_resched+0x54/0x90
	  __perf_install_in_context+0x144/0x170
	  ? perf_duration_warn+0x40/0x40
	  remote_function+0x4a/0x60
	  generic_exec_single+0xad/0x110
	  ? perf_duration_warn+0x40/0x40
	  smp_call_function_single+0x9c/0x150
	  ? perf_duration_warn+0x40/0x40
	  task_function_call+0x4b/0x80
	  ? task_function_call+0x4b/0x80
	  ? __perf_event_enable+0x140/0x140
	  perf_install_in_context+0x99/0x160
	  __do_sys_perf_event_open+0xaf5/0xd80
	  __x64_sys_perf_event_open+0x20/0x30
	  do_syscall_64+0x4f/0x1b0
	  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	 RIP: 0033:0x7f46d1590469
	 Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
	 RSP: 002b:00007ffc86f0f488 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
	 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f46d1590469
	 RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000564f0c3a0080
	 RBP: 00007ffc86f0f4b0 R08: 0000000000000000 R09: 00007ffc86f0f598
	 R10: 00000000ffffffff R11: 0000000000000246 R12: 0000564f0c19f7e0
	 R13: 00007ffc86f0f590 R14: 0000000000000000 R15: 0000000000000000
	 irq event stamp: 12252
	 hardirqs last  enabled at (12251): [<ffffffff81282909>] kmem_cache_alloc+0xb9/0x6e0
	 hardirqs last disabled at (12252): [<ffffffff81184637>] generic_exec_single+0xa7/0x110
	 softirqs last  enabled at (12234): [<ffffffff81e003e7>] __do_softirq+0x3e7/0x497
	 softirqs last disabled at (12227): [<ffffffff810d4558>] irq_exit+0xc8/0xd0

We can't easily support dynamic event context swap when breakpoints are
involved. The easiest solution to fix the issue is to pin a context as
long as it contains a breakpoint PMU.

Reported-by: syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com
Cc: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/events/hw_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index c5cd852fe86b..514d704d60a2 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -656,6 +656,7 @@ static struct pmu perf_breakpoint = {
 	.start		= hw_breakpoint_start,
 	.stop		= hw_breakpoint_stop,
 	.read		= hw_breakpoint_pmu_read,
+	.pin_ctx	= 1,
 };
 
 int __init init_hw_breakpoint(void)
-- 
2.21.0

