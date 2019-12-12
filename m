Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0466AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BCC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfLLMZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:25:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729159AbfLLMZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:25:35 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2465B976074174AA5891;
        Thu, 12 Dec 2019 20:25:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 12 Dec 2019 20:25:24 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/debug: fix trival print task format
Date:   Thu, 12 Dec 2019 20:22:44 +0800
Message-ID: <20191212122244.132751-1-xiexiuqi@huawei.com>
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

Ensure levave a whitespace between state and task name.

w/o patch:
runnable tasks:
 S           task   PID         tree-key  switches  prio     wait
-----------------------------------------------------------------
 I    kworker/0:2   656     87693.884557      8255   120
 Sirq/10-ACPI:Ged   829         0.000000         3    49
 Sirq/11-ACPI:Ged   830         0.000000         3    49
 Sirq/50-arm-smmu   945         0.000000         3    49

with patch:
runnable tasks:
 S            task   PID         tree-key  switches  prio     wait
------------------------------------------------------------------
 I     kworker/0:2   656     87693.884557      8255   120
 S irq/10-ACPI:Ged   829         0.000000         3    49
 S irq/11-ACPI:Ged   830         0.000000         3    49
 S irq/50-arm-smmu   945         0.000000         3    49

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 kernel/sched/debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..a1b5a4c1213e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -434,9 +434,9 @@ static void
 print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 {
 	if (rq->curr == p)
-		SEQ_printf(m, ">R");
+		SEQ_printf(m, ">R ");
 	else
-		SEQ_printf(m, " %c", task_state_to_char(p));
+		SEQ_printf(m, " %c ", task_state_to_char(p));
 
 	SEQ_printf(m, "%15s %5d %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
@@ -465,10 +465,10 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S           task   PID         tree-key  switches  prio"
+	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
 		   "     wait-time             sum-exec        sum-sleep\n");
 	SEQ_printf(m, "-------------------------------------------------------"
-		   "----------------------------------------------------\n");
+		   "------------------------------------------------------\n");
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
-- 
2.20.1

