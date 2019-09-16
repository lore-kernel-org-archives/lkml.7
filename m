Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE7DC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFDF2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 06:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfIPGyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 02:54:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfIPGx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 02:53:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 80A58BA64200747B6DDF;
        Mon, 16 Sep 2019 14:53:54 +0800 (CST)
Received: from HGHY2S004443181.china.huawei.com (10.184.52.157) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Sep 2019 14:53:53 +0800
From:   KeMeng Shi <shikemeng@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <valentin.schneider@arm.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] sched: fix migration to invalid cpu in __set_cpus_allowed_ptr
Date:   Mon, 16 Sep 2019 06:53:28 +0000
Message-ID: <1568616808-16808-1-git-send-email-shikemeng@huawei.com>
X-Mailer: git-send-email 2.7.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.52.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops occur when running qemu on arm64:
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

__set_cpus_allowed_ptr will choose an active dest_cpu in affinity mask to
migrage the process if process is not currently running on any one of the
CPUs specified in affinity mask. __set_cpus_allowed_ptr will choose an
invalid dest_cpu (dest_cpu >= nr_cpu_ids, 1024 in my virtual machine) if 
CPUS in an affinity mask are deactived by cpu_down after cpumask_intersects
check. cpumask_test_cpu of dest_cpu afterwards is overflow and may pass if
corresponding bit is coincidentally set. As a consequence, kernel will
access an invalid rq address associate with the invalid cpu in
migration_cpu_stop->__migrate_task->move_queued_task and the Oops occurs.

Process as follows may trigger the Oops:
1) A process repeatedly binds itself to cpu0 and cpu1 in turn by calling
sched_setaffinity.
2) A shell script repeatedly "echo 0 > /sys/devices/system/cpu/cpu1/online"
and "echo 1 > /sys/devices/system/cpu/cpu1/online" in turn.
3) Oops appears if the invalid cpu is set in memory after tested cpumask.

Signed-off-by: KeMeng Shi <shikemeng@huawei.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
---
Changes in v2:
-solve format problems in log

 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c7b90bcbe4e..087f4ac30b60 100644
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
-- 
2.19.1


