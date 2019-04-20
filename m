Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8F9C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0D4208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 08:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfDTIX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 04:23:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfDTIX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 04:23:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 800FDDF35A468244ACFA;
        Sat, 20 Apr 2019 16:23:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Sat, 20 Apr 2019 16:23:44 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <cj.chengjian@huawei.com>
Subject: [PATCH] sched: fix a potential divide error
Date:   Sat, 20 Apr 2019 16:34:16 +0800
Message-ID: <20190420083416.170446-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We meet a divide error on 3.10.0 kernel, the error message is bellow:

[499992.287996] divide error: 0000 [#1] SMP
[499992.297796] do nothing after die!
[499992.299108] Modules linked in: signo_catch macvlan binfmt_misc
ip_set_hash_netport ip_set_hash_ipport vport_vxlan ipt_REJECT
xt_statistic xt_physdev xt_nat xt_recent xt_mark xt_comment ...
[499992.312751] CPU: 8 PID: 23352 Comm: bash Tainted: G ----V-------   3.10.0+ #1
[499992.314308] Hardware name: OpenStack Foundation OpenStack Nova, BIOS
rel-1.9.1-0-gb3ef39f-20170329_185309-build9a64a246a231 04/01/2014
[499992.317411] task: ffff880033fc9700 ti: ffff8807fed60000 task.ti:ffff8807fed60000
[499992.318967] RIP: 0010:[<ffffffff810c15c2>]  [<ffffffff810c15c2>] task_numa_fault+0x1c2/0xbb0
[499992.320515] RSP: 0000:ffff8807fed63d38  EFLAGS: 00010246
[499992.322018] RAX: 0000002b7efd0000 RBX: ffff880033fc9700 RCX:0000000000000003
[499992.323563] RDX: 0000000000000000 RSI: 0000000000000400 RDI:ffffffff81a80f60
[499992.325052] RBP: ffff8807fed63db8 R08: ffffffff81a80f68 R09:0000000000000000
[499992.326531] R10: ffff88083ffda000 R11: 0000000000000000 R12:0000000000000424
[499992.327987] R13: 00000000002b7efd R14: 0000000000000000 R15:ffffea001ea42a00
[499992.329420] FS:  00007fa01a3b7740(0000) GS:ffff88103ec00000(0000)knlGS:0000000000000000
[499992.330866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[499992.332302] CR2: 0000000000ff1fb0 CR3: 00000007ff1d1000 CR4:00000000003407e0
[499992.333763] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
[499992.335187] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
[499992.336595] Stack:
[499992.337974]  0000000000000000 00000001bc9598a8 ffffea001ea42a00 0000000100000001
[499992.339374]  0000000300000001 0000000000000001 ffffea001ea42a00 ffff8807fed63db8
[499992.340768]  0000000000000000 0000000000000000 00000000bc9598a8 0000000000000001
[499992.342148] Call Trace:
[499992.343494]  [<ffffffff8119ab62>] do_numa_page+0x162/0x1f0
[499992.344831]  [<ffffffff8119bde7>] handle_mm_fault+0x627/0xf50
[499992.346145]  [<ffffffff8164e486>] __do_page_fault+0x166/0x470
[499992.347442]  [<ffffffff8164e853>] trace_do_page_fault+0x43/0x110
[499992.348711]  [<ffffffff8164df29>] do_async_page_fault+0x29/0xe0
[499992.349948]  [<ffffffff8164a9f8>] async_page_fault+0x28/0x30
[499992.351149] Code: 00 3d 00 04 00 00 44 0f 4e d8 41 81 fb 00 04 00 00
0f 84 67 07 00 00 4c 89 e8 49 83 c6 01 31 d2 48 c1 e0 10 49 83 c4 01 45
31 c9 <49> f7 f6 48 c7 45 a8 00 00 00 00 48 c7 45 b0 00 00 00 00 49 89
[499992.353707] RIP  [<ffffffff810c15c2>] task_numa_fault+0x1c2/0xbb0
[499992.354927]  RSP <ffff8807fed63d38>
[499992.358114] ---[ end trace 4f2465cac18ff65e ]---
[499992.359304] Kernel panic - not syncing: Fatal exception

sched_clock_cpu may not be consistent bwtwen cpus. If a task migrate
to another cpu, the se.exec_start was set to that cpu's rq_clock_task
by update_stats_curr_start(). Which may not be monotonic.

update_stats_curr_start
  <- set_next_entity
     <- set_curr_task_fair
        <- sched_move_task

So, if  now - p->last_task_numa_placement is -1, then (*period + 1) is
0, and divide error was triggerred at the div operation:
  task_numa_placement:
    runtime = numa_get_avg_runtime(p, &period);
    f_weight = div64_u64(runtime << 16, period + 1);  // divide error here

In this patch, we make sure period is not less than 0 to avoid this
divide error.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 40bd1e27b1b7..f2abb258fc85 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2007,6 +2007,10 @@ static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
 	if (p->last_task_numa_placement) {
 		delta = runtime - p->last_sum_exec_runtime;
 		*period = now - p->last_task_numa_placement;
+
+		/* Avoid backward, and prevent potential divide error */
+		if ((s64)*period < 0)
+			*period = 0;
 	} else {
 		delta = p->se.avg.load_sum;
 		*period = LOAD_AVG_MAX;
-- 
2.20.1

