Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BA8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A59721582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfLQMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55289 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbfLQMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8r-0001oy-LB; Tue, 17 Dec 2019 13:39:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B77FB1C2A3C;
        Tue, 17 Dec 2019 13:39:51 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:51 -0000
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/psi: Fix sampling error and rare div0
 crashes with cgroups and high uptime
Cc:     Jingfeng Xie <xiejingfeng@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191203183524.41378-2-hannes@cmpxchg.org>
References: <20191203183524.41378-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <157658639165.30329.505471573143589808.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     3dfbe25c27eab7c90c8a7e97b4c354a9d24dd985
Gitweb:        https://git.kernel.org/tip/3dfbe25c27eab7c90c8a7e97b4c354a9d24dd985
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Tue, 03 Dec 2019 13:35:23 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:47 +01:00

sched/psi: Fix sampling error and rare div0 crashes with cgroups and high uptime

Jingfeng reports rare div0 crashes in psi on systems with some uptime:

[58914.066423] divide error: 0000 [#1] SMP
[58914.070416] Modules linked in: ipmi_poweroff ipmi_watchdog toa overlay fuse tcp_diag inet_diag binfmt_misc aisqos(O) aisqos_hotfixes(O)
[58914.083158] CPU: 94 PID: 140364 Comm: kworker/94:2 Tainted: G W OE K 4.9.151-015.ali3000.alios7.x86_64 #1
[58914.093722] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.23.34 02/14/2019
[58914.102728] Workqueue: events psi_update_work
[58914.107258] task: ffff8879da83c280 task.stack: ffffc90059dcc000
[58914.113336] RIP: 0010:[] [] psi_update_stats+0x1c1/0x330
[58914.122183] RSP: 0018:ffffc90059dcfd60 EFLAGS: 00010246
[58914.127650] RAX: 0000000000000000 RBX: ffff8858fe98be50 RCX: 000000007744d640
[58914.134947] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00003594f700648e
[58914.142243] RBP: ffffc90059dcfdf8 R08: 0000359500000000 R09: 0000000000000000
[58914.149538] R10: 0000000000000000 R11: 0000000000000000 R12: 0000359500000000
[58914.156837] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8858fe98bd78
[58914.164136] FS: 0000000000000000(0000) GS:ffff887f7f380000(0000) knlGS:0000000000000000
[58914.172529] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[58914.178467] CR2: 00007f2240452090 CR3: 0000005d5d258000 CR4: 00000000007606f0
[58914.185765] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[58914.193061] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[58914.200360] PKRU: 55555554
[58914.203221] Stack:
[58914.205383] ffff8858fe98bd48 00000000000002f0 0000002e81036d09 ffffc90059dcfde8
[58914.213168] ffff8858fe98bec8 0000000000000000 0000000000000000 0000000000000000
[58914.220951] 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[58914.228734] Call Trace:
[58914.231337] [] psi_update_work+0x22/0x60
[58914.237067] [] process_one_work+0x189/0x420
[58914.243063] [] worker_thread+0x4e/0x4b0
[58914.248701] [] ? process_one_work+0x420/0x420
[58914.254869] [] kthread+0xe6/0x100
[58914.259994] [] ? kthread_park+0x60/0x60
[58914.265640] [] ret_from_fork+0x39/0x50
[58914.271193] Code: 41 29 c3 4d 39 dc 4d 0f 42 dc <49> f7 f1 48 8b 13 48 89 c7 48 c1
[58914.279691] RIP [] psi_update_stats+0x1c1/0x330

The crashing instruction is trying to divide the observed stall time
by the sampling period. The period, stored in R8, is not 0, but we are
dividing by the lower 32 bits only, which are all 0 in this instance.

We could switch to a 64-bit division, but the period shouldn't be that
big in the first place. It's the time between the last update and the
next scheduled one, and so should always be around 2s and comfortably
fit into 32 bits.

The bug is in the initialization of new cgroups: we schedule the first
sampling event in a cgroup as an offset of sched_clock(), but fail to
initialize the last_update timestamp, and it defaults to 0. That
results in a bogusly large sampling period the first time we run the
sampling code, and consequently we underreport pressure for the first
2s of a cgroup's life. But worse, if sched_clock() is sufficiently
advanced on the system, and the user gets unlucky, the period's lower
32 bits can all be 0 and the sampling division will crash.

Fix this by initializing the last update timestamp to the creation
time of the cgroup, thus correctly marking the start of the first
pressure sampling period in a new cgroup.

Reported-by: Jingfeng Xie <xiejingfeng@linux.alibaba.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Link: https://lkml.kernel.org/r/20191203183524.41378-2-hannes@cmpxchg.org
---
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 517e371..970db46 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -185,7 +185,8 @@ static void group_init(struct psi_group *group)
 
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
-	group->avg_next_update = sched_clock() + psi_period;
+	group->avg_last_update = sched_clock();
+	group->avg_next_update = group->avg_last_update + psi_period;
 	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
 	/* Init trigger-related members */
