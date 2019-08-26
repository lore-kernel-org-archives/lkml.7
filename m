Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E76C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfHZLyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:54:13 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47294 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfHZLyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:54:13 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 07:54:11 EDT
Received: from martinqiao.loongson.cn (unknown [10.50.122.134])
        by mail (Coremail) with SMTP id QMiowPDxv1evxmNdnmcyAA--.271S2;
        Mon, 26 Aug 2019 19:47:05 +0800 (CST)
From:   QiaoChong <qiaochong@loongson.cn>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, QiaoChong <qiaochong@loongson.cn>
Subject: [PATCH] sched/fair: update_curr changed sum_exec_runtime to 1 when sum_exec_runtime is 0 beacuse some kernel code use sum_exec_runtime==0 to test task just be forked.
Date:   Mon, 26 Aug 2019 19:46:50 +0800
Message-Id: <20190826114650.10948-1-qiaochong@loongson.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: QMiowPDxv1evxmNdnmcyAA--.271S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fWr13JF4kJF1rJrWDurg_yoW8KF1Upw
        4DWF43trWFq340yFWDAF93Xrnxt3s3Gr4xXrn0y3WfAr4Sg34ftFy0qF4SvF4jyr97tFy3
        Jr4SyrWxuwn5tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4x0x7Aq67IIx4CE
        Vc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        fU0OJ5UUUUU
X-CM-SenderInfo: 5tld0upkrqwqxorr0wxvrqhubq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chong Qiao <qiaochong@loongson.cn>

Such as:
cpu_cgroup_attach>
 sched_move_task>
  task_change_group_fair>
   task_move_group_fair>
    detach_task_cfs_rq>
     vruntime_normalized>

	/*
	 * When !on_rq, vruntime of the task has usually NOT been normalized.
	 * But there are some cases where it has already been normalized:
	 *
	 * - A forked child which is waiting for being woken up by
	 *   wake_up_new_task().
	 * - A task which has been woken up by try_to_wake_up() and
	 *   waiting for actually being woken up by sched_ttwu_pending().
	 */
	if (!se->sum_exec_runtime ||
	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
		return true;

p->se.sum_exec_runtime is 0, does not mean task not been run (A forked child which is waiting for being woken up by  wake_up_new_task()).

Task may have been scheduled multimes, but p->se.sum_exec_runtime is still 0, because delta_exec maybe 0 in update_curr.

static void update_curr(struct cfs_rq *cfs_rq)
{
...
	delta_exec = now - curr->exec_start;
	if (unlikely((s64)delta_exec <= 0))
		return;
...

	curr->sum_exec_runtime += delta_exec;
...
}

Task has been run and is stopped(on_rq == 0), vruntime not been normalized, but se->sum_exec_runtime == 0.
This cause vruntime_normalized set on_rq 1, and does not normalize vruntime.
This may cause task use old vruntime in old cgroup, which maybe very large than task's vruntime in new cgroup.
Which may cause task may not scheduled in run queue for long time after been waked up.

Now I change sum_exec_runtime to 1 when sum_exec_runtime == 0 in update_curr to make sun_exec_runtime not 0.

Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
---
 kernel/sched/fair.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd2..c4cd6249d9d2c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -841,8 +841,15 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		return;
 
 	delta_exec = now - curr->exec_start;
-	if (unlikely((s64)delta_exec <= 0))
+	if (unlikely((s64)delta_exec <= 0)) {
+		/*
+		 * se.sum_exec_runtime == 0 means task is forked and wait to be run.
+		 * So here change se.sum_exec_runtime to 1, to make it not 0.
+		 */
+		if (!curr->sum_exec_runtime)
+			curr->sum_exec_runtime++;
 		return;
+	}
 
 	curr->exec_start = now;
 
-- 
2.17.1


