Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D5FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE0C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfG3FRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:17:21 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42009 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729002AbfG3FRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:17:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=kerneljasonxing@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TY9ePpV_1564463819;
Received: from localhost(mailfrom:kerneljasonxing@linux.alibaba.com fp:SMTPD_---0TY9ePpV_1564463819)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Jul 2019 13:17:17 +0800
From:   Jason Xing <kerneljasonxing@linux.alibaba.com>
To:     hannes@cmpxchg.org, surenb@google.com
Cc:     dennis@kernel.org, mingo@redhat.com, axboe@kernel.dk,
        lizefan@huawei.com, peterz@infradead.org, tj@kernel.org,
        kerneljasonxing@linux.alibaba.com, linux-kernel@vger.kernel.org,
        caspar@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v2] psi: get poll_work to run when calling poll syscall next time
Date:   Tue, 30 Jul 2019 13:16:59 +0800
Message-Id: <1564463819-120014-1-git-send-email-kerneljasonxing@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
References: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only when calling the poll syscall the first time can user
receive POLLPRI correctly. After that, user always fails to
acquire the event signal.

Reproduce case:
1. Get the monitor code in Documentation/accounting/psi.txt
2. Run it, and wait for the event triggered.
3. Kill and restart the process.

If the user doesn't kill the monitor process, it seems the
poll_work works fine. After killing and restarting the monitor,
the poll_work in kernel will never run again due to the wrong
value of poll_scheduled. Therefore, we should reset the value
as group_init() does after the last trigger is destroyed.

[PATCH V2]
In the patch v2, I put the atomic_set(&group->poll_scheduled, 0);
into the right place.
Here I quoted from Johannes as the best explaination:
"The question is why we can end up with poll_scheduled = 1 but the work
not running (which would reset it to 0). And the answer is because the
scheduling side sees group->poll_kworker under RCU protection and then
schedules it, but here we cancel the work and destroy the worker. The
cancel needs to pair with resetting the poll_scheduled flag."

Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
Reviewed-by: Caspar Zhang <caspar@linux.alibaba.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7acc632..acdada0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1131,7 +1131,14 @@ static void psi_trigger_destroy(struct kref *ref)
 	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
 	 */
 	if (kworker_to_destroy) {
+		/*
+		 * After the RCU grace period has expired, the worker
+		 * can no longer be found through group->poll_kworker.
+		 * But it might have been already scheduled before
+		 * that - deschedule it cleanly before destroying it.
+		 */
 		kthread_cancel_delayed_work_sync(&group->poll_work);
+		atomic_set(&group->poll_scheduled, 0);
 		kthread_destroy_worker(kworker_to_destroy);
 	}
 	kfree(t);
-- 
1.8.3.1

