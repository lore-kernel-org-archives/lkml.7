Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FEC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54AA2239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfGWGp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:45:58 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46436 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732590AbfGWGp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:45:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=kerneljasonxing@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TXbisZS_1563864339;
Received: from localhost(mailfrom:kerneljasonxing@linux.alibaba.com fp:SMTPD_---0TXbisZS_1563864339)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jul 2019 14:45:54 +0800
From:   Jason Xing <kerneljasonxing@linux.alibaba.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org
Cc:     dennis@kernel.org, axboe@kernel.dk, lizefan@huawei.com,
        tj@kernel.org, kerneljasonxing@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] psi: get poll_work to run when calling poll syscall next time
Date:   Tue, 23 Jul 2019 14:45:39 +0800
Message-Id: <1563864339-2621-1-git-send-email-kerneljasonxing@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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

Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
---
 kernel/sched/psi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7acc632..66f4385 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1133,6 +1133,12 @@ static void psi_trigger_destroy(struct kref *ref)
 	if (kworker_to_destroy) {
 		kthread_cancel_delayed_work_sync(&group->poll_work);
 		kthread_destroy_worker(kworker_to_destroy);
+		/*
+		 * The poll_work should have the chance to be put into the
+		 * kthread queue when calling poll syscall next time. So
+		 * reset poll_scheduled to zero as group_init() does
+		 */
+		atomic_set(&group->poll_scheduled, 0);
 	}
 	kfree(t);
 }
-- 
1.8.3.1

