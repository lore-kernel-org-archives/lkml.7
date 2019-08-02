Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7225C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984BB20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404914AbfHBJlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:41:52 -0400
Received: from mail1.windriver.com ([147.11.146.13]:57139 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404893AbfHBJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:41:48 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x729f7Br010041
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 2 Aug 2019 02:41:07 -0700 (PDT)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.468.0; Fri, 2 Aug 2019
 02:41:07 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id 1F6A472190A; Fri,  2
 Aug 2019 17:41:03 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <joel@joelfernandes.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jiping.ma2@windriver.com>
Subject: [PATCH v3] tracing: Function stack size and its name mismatch in arm64
Date:   Fri, 2 Aug 2019 17:41:03 +0800
Message-ID: <20190802094103.163576-1-jiping.ma2@windriver.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is not PC in ARM64 stack, LR is used to for walk_stackframe in
ARM64. Tere is no the issue in ARM32 because there is PC in ARM32 stack.
PC is used to calculate the stack size in trace_stack.c, so the
function name and its stack size appear to be off-by-one.
ARM64 stack layout:
	LR
        FP
        ......
        LR
        FP
        ......

Wrong info:
Depth Size Location (16 entries)
----- ---- --------
0) 5400 16 __update_load_avg_se.isra.2+0x28/0x220
1) 5384 96 put_prev_entity+0x250/0x338
2) 5288 80 pick_next_task_fair+0x4c4/0x508
3) 5208 72 __schedule+0x100/0x600
4) 5136 184 preempt_schedule_common+0x28/0x48
5) 4952 32 preempt_schedule+0x28/0x30
6) 4920 16 vprintk_emit+0x170/0x1f8
7) 4904 128 vprintk_default+0x48/0x58
8) 4776 64 vprintk_func+0xf8/0x1c8
9) 4712 112 printk+0x70/0x90
10) 4600 176 occupy_stack_init+0x64/0xc0 [kernel_stack]
11) 4424 3376 do_one_initcall+0x68/0x248
12) 1048 144 do_init_module+0x60/0x1f0
13) 904 48 load_module+0x1d50/0x2340
14) 856 352 sys_finit_module+0xd0/0xe8
15) 504 504 el0_svc_naked+0x30/0x34

Correct info:
Depth Size Location (18 entries)
----- ---- --------
0) 5464 48 cgroup_rstat_updated+0x20/0x100
1) 5416 32 cgroup_base_stat_cputime_account_end.isra.0+0x30/0x60
2) 5384 32 __cgroup_account_cputime+0x3c/0x48
3) 5352 64 update_curr+0xc4/0x1d0
4) 5288 72 pick_next_task_fair+0x444/0x508
5) 5216 184 __schedule+0x100/0x600
6) 5032 32 preempt_schedule_common+0x28/0x48
7) 5000 16 preempt_schedule+0x28/0x30
8) 4984 128 vprintk_emit+0x170/0x1f8
9) 4856 64 vprintk_default+0x48/0x58
10) 4792 112 vprintk_func+0xf8/0x1c8
11) 4680 176 printk+0x70/0x90
12) 4504 80 func_test+0x7c/0xb8 [kernel_stack]
13) 4424 3376 occupy_stack_init+0x7c/0xc0 [kernel_stack]
14) 1048 144 do_one_initcall+0x68/0x248
15) 904 48 do_init_module+0x60/0x1f0
16) 856 352 load_module+0x1d50/0x2340
17) 504 504 sys_finit_module+0xd0/0xe8

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
---
 kernel/trace/trace_stack.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5d16f73898db..ed80b95abf06 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -40,16 +40,28 @@ static void print_max_stack(void)
 
 	pr_emerg("        Depth    Size   Location    (%d entries)\n"
 			   "        -----    ----   --------\n",
+#ifdef CONFIG_ARM64
+			   stack_trace_nr_entries - 1);
+#else
 			   stack_trace_nr_entries);
-
+#endif
+#ifdef CONFIG_ARM64
+	for (i = 1; i < stack_trace_nr_entries; i++) {
+#else
 	for (i = 0; i < stack_trace_nr_entries; i++) {
+#endif
 		if (i + 1 == stack_trace_nr_entries)
 			size = stack_trace_index[i];
 		else
 			size = stack_trace_index[i] - stack_trace_index[i+1];
 
+#ifdef CONFIG_ARM64
+		pr_emerg("%3ld) %8d   %5d   %pS\n", i-1, stack_trace_index[i],
+				size, (void *)stack_dump_trace[i-1]);
+#else
 		pr_emerg("%3ld) %8d   %5d   %pS\n", i, stack_trace_index[i],
 				size, (void *)stack_dump_trace[i]);
+#endif
 	}
 }
 
@@ -324,8 +336,11 @@ static int t_show(struct seq_file *m, void *v)
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
+#ifdef CONFIG_ARM64
+			   stack_trace_nr_entries - 1);
+#else
 			   stack_trace_nr_entries);
-
+#endif
 		if (!stack_tracer_enabled && !stack_trace_max_size)
 			print_disabled(m);
 
@@ -334,6 +349,10 @@ static int t_show(struct seq_file *m, void *v)
 
 	i = *(long *)v;
 
+#ifdef CONFIG_ARM64
+	if (i == 0)
+		return 0;
+#endif
 	if (i >= stack_trace_nr_entries)
 		return 0;
 
@@ -342,9 +361,14 @@ static int t_show(struct seq_file *m, void *v)
 	else
 		size = stack_trace_index[i] - stack_trace_index[i+1];
 
+#ifdef CONFIG_ARM64
+	seq_printf(m, "%3ld) %8d   %5d   ", i-1, stack_trace_index[i], size);
+	trace_lookup_stack(m, i-1);
+#else
 	seq_printf(m, "%3ld) %8d   %5d   ", i, stack_trace_index[i], size);
 
 	trace_lookup_stack(m, i);
+#endif
 
 	return 0;
 }
-- 
2.18.1

