Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98160C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7458C20C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404722AbfITPyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:54:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404245AbfITPyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:54:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F302B8A1C94;
        Fri, 20 Sep 2019 15:54:23 +0000 (UTC)
Received: from llong.com (ovpn-122-210.rdu2.redhat.com [10.10.122.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4860160C18;
        Fri, 20 Sep 2019 15:54:20 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] ipc/sem: Fix race between to-be-woken task and waker
Date:   Fri, 20 Sep 2019 11:54:02 -0400
Message-Id: <20190920155402.28996-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 20 Sep 2019 15:54:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at a customr bug report about potential missed wakeup in
the system V semaphore code, I spot a potential problem.  The fact that
semaphore waiter stays in TASK_RUNNING state while checking queue status
may lead to missed wakeup if a spurious wakeup happens in the right
moment as try_to_wake_up() will do nothing if the task state isn't right.

To eliminate this possibility, the task state is now reset to
TASK_INTERRUPTIBLE immediately after wakeup before checking the queue
status. This should eliminate the race condition on the interaction
between the queue status and the task state and fix the potential missed
wakeup problem.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 ipc/sem.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 7da4504bcc7c..1bcd424be047 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2146,11 +2146,11 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		sma->complex_count++;
 	}
 
+	__set_current_state(TASK_INTERRUPTIBLE);
 	do {
 		WRITE_ONCE(queue.status, -EINTR);
 		queue.sleeper = current;
 
-		__set_current_state(TASK_INTERRUPTIBLE);
 		sem_unlock(sma, locknum);
 		rcu_read_unlock();
 
@@ -2159,6 +2159,24 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		else
 			schedule();
 
+		/*
+		 * A spurious wakeup at the right moment can cause race
+		 * between the to-be-woken task and the waker leading to
+		 * missed wakeup. Setting state back to TASK_INTERRUPTIBLE
+		 * before checking queue.status will ensure that the race
+		 * won't happen.
+		 *
+		 *	CPU0				CPU1
+		 *
+		 *  <spurious wakeup>		wake_up_sem_queue_prepare():
+		 *  state = TASK_INTERRUPTIBLE    status = error
+		 *				try_to_wake_up():
+		 *  smp_mb()			  smp_mb()
+		 *  if (status == -EINTR)	  if (!(p->state & state))
+		 *    schedule()		    goto out
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		/*
 		 * fastpath: the semop has completed, either successfully or
 		 * not, from the syscall pov, is quite irrelevant to us at this
@@ -2210,6 +2228,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	sem_unlock(sma, locknum);
 	rcu_read_unlock();
 out_free:
+	__set_current_state(TASK_RUNNING);
 	if (sops != fast_sops)
 		kvfree(sops);
 	return error;
-- 
2.18.1

