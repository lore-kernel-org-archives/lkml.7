Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E7C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630142146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfI0IK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:10:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45187 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfI0IKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:10:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKs-0005ad-Lr; Fri, 27 Sep 2019 10:10:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 27BCB1C073C;
        Fri, 27 Sep 2019 10:10:42 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:42 -0000
From:   "tip-bot2 for KeMeng Shi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix migration to invalid CPU in
 __set_cpus_allowed_ptr()
Cc:     KeMeng Shi <shikemeng@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1568616808-16808-1-git-send-email-shikemeng@huawei.com>
References: <1568616808-16808-1-git-send-email-shikemeng@huawei.com>
MIME-Version: 1.0
Message-ID: <156957184212.9866.17332309018333415855.tip-bot2@tip-bot2>
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

Commit-ID:     714e501e16cd473538b609b3e351b2cc9f7f09ed
Gitweb:        https://git.kernel.org/tip/714e501e16cd473538b609b3e351b2cc9f7f09ed
Author:        KeMeng Shi <shikemeng@huawei.com>
AuthorDate:    Mon, 16 Sep 2019 06:53:28 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:31 +02:00

sched/core: Fix migration to invalid CPU in __set_cpus_allowed_ptr()

An oops can be triggered in the scheduler when running qemu on arm64:

 Unable to handle kernel paging request at virtual address ffff000008effe40
 Internal error: Oops: 96000007 [#1] SMP
 Process migration/0 (pid: 12, stack limit = 0x00000000084e3736)
 pstate: 20000085 (nzCv daIf -PAN -UAO)
 pc : __ll_sc___cmpxchg_case_acq_4+0x4/0x20
 lr : move_queued_task.isra.21+0x124/0x298
 ...
 Call trace:
  __ll_sc___cmpxchg_case_acq_4+0x4/0x20
  __migrate_task+0xc8/0xe0
  migration_cpu_stop+0x170/0x180
  cpu_stopper_thread+0xec/0x178
  smpboot_thread_fn+0x1ac/0x1e8
  kthread+0x134/0x138
  ret_from_fork+0x10/0x18

__set_cpus_allowed_ptr() will choose an active dest_cpu in affinity mask to
migrage the process if process is not currently running on any one of the
CPUs specified in affinity mask. __set_cpus_allowed_ptr() will choose an
invalid dest_cpu (dest_cpu >= nr_cpu_ids, 1024 in my virtual machine) if
CPUS in an affinity mask are deactived by cpu_down after cpumask_intersects
check. cpumask_test_cpu() of dest_cpu afterwards is overflown and may pass if
corresponding bit is coincidentally set. As a consequence, kernel will
access an invalid rq address associate with the invalid CPU in
migration_cpu_stop->__migrate_task->move_queued_task and the Oops occurs.

The reproduce the crash:

  1) A process repeatedly binds itself to cpu0 and cpu1 in turn by calling
  sched_setaffinity.

  2) A shell script repeatedly does "echo 0 > /sys/devices/system/cpu/cpu1/online"
  and "echo 1 > /sys/devices/system/cpu/cpu1/online" in turn.

  3) Oops appears if the invalid CPU is set in memory after tested cpumask.

Signed-off-by: KeMeng Shi <shikemeng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1568616808-16808-1-git-send-email-shikemeng@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9a394..83ea23e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1656,7 +1656,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_equal(p->cpus_ptr, new_mask))
 		goto out;
 
-	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
+	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
+	if (dest_cpu >= nr_cpu_ids) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1677,7 +1678,6 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_test_cpu(task_cpu(p), new_mask))
 		goto out;
 
-	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		struct migration_arg arg = { p, dest_cpu };
 		/* Need help from migration thread: drop lock and wait. */
