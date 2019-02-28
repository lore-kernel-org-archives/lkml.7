Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2216F21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbfB1KXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:23:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56073 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfB1KXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:23:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1SAM96U2997259
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 02:22:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1SAM82f2997256;
        Thu, 28 Feb 2019 02:22:08 -0800
Date:   Thu, 28 Feb 2019 02:22:08 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Julia Cartwright <tipbot@zytor.com>
Message-ID: <tip-fe99a4f4d6022ec92f9b52a5528cb9b77513e7d1@git.kernel.org>
Cc:     s.trumtrar@pengutronix.de, tglx@linutronix.de, linux@roeck-us.net,
        tim@krieglstein.org, hpa@zytor.com, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        pmladek@suse.com, julia@ni.com
Reply-To: s.trumtrar@pengutronix.de, tim@krieglstein.org,
          linux@roeck-us.net, tglx@linutronix.de, bigeasy@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          julia@ni.com, pmladek@suse.com
In-Reply-To: <20190212162554.19779-1-bigeasy@linutronix.de>
References: <20190212162554.19779-1-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] kthread: Convert worker lock to raw spinlock
Git-Commit-ID: fe99a4f4d6022ec92f9b52a5528cb9b77513e7d1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fe99a4f4d6022ec92f9b52a5528cb9b77513e7d1
Gitweb:     https://git.kernel.org/tip/fe99a4f4d6022ec92f9b52a5528cb9b77513e7d1
Author:     Julia Cartwright <julia@ni.com>
AuthorDate: Tue, 12 Feb 2019 17:25:53 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Feb 2019 11:18:38 +0100

kthread: Convert worker lock to raw spinlock

In order to enable the queuing of kthread work items from hardirq context
even when PREEMPT_RT_FULL is enabled, convert the worker spin_lock to a
raw_spin_lock.

This is only acceptable to do because the work performed under the lock is
well-bounded and minimal.

Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reported-by: Tim Sander <tim@krieglstein.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Link: https://lkml.kernel.org/r/20190212162554.19779-1-bigeasy@linutronix.de

---
 include/linux/kthread.h |  4 ++--
 kernel/kthread.c        | 42 +++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c1961761311d..6b8c064f0cbc 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -85,7 +85,7 @@ enum {
 
 struct kthread_worker {
 	unsigned int		flags;
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct list_head	work_list;
 	struct list_head	delayed_work_list;
 	struct task_struct	*task;
@@ -106,7 +106,7 @@ struct kthread_delayed_work {
 };
 
 #define KTHREAD_WORKER_INIT(worker)	{				\
-	.lock = __SPIN_LOCK_UNLOCKED((worker).lock),			\
+	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
 	.delayed_work_list = LIST_HEAD_INIT((worker).delayed_work_list),\
 	}
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 087d18d771b5..5641b55783a6 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -599,7 +599,7 @@ void __kthread_init_worker(struct kthread_worker *worker,
 				struct lock_class_key *key)
 {
 	memset(worker, 0, sizeof(struct kthread_worker));
-	spin_lock_init(&worker->lock);
+	raw_spin_lock_init(&worker->lock);
 	lockdep_set_class_and_name(&worker->lock, key, name);
 	INIT_LIST_HEAD(&worker->work_list);
 	INIT_LIST_HEAD(&worker->delayed_work_list);
@@ -641,21 +641,21 @@ repeat:
 
 	if (kthread_should_stop()) {
 		__set_current_state(TASK_RUNNING);
-		spin_lock_irq(&worker->lock);
+		raw_spin_lock_irq(&worker->lock);
 		worker->task = NULL;
-		spin_unlock_irq(&worker->lock);
+		raw_spin_unlock_irq(&worker->lock);
 		return 0;
 	}
 
 	work = NULL;
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	if (!list_empty(&worker->work_list)) {
 		work = list_first_entry(&worker->work_list,
 					struct kthread_work, node);
 		list_del_init(&work->node);
 	}
 	worker->current_work = work;
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
 
 	if (work) {
 		__set_current_state(TASK_RUNNING);
@@ -812,12 +812,12 @@ bool kthread_queue_work(struct kthread_worker *worker,
 	bool ret = false;
 	unsigned long flags;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
 		kthread_insert_work(worker, work, &worker->work_list);
 		ret = true;
 	}
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_work);
@@ -843,7 +843,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	if (WARN_ON_ONCE(!worker))
 		return;
 
-	spin_lock(&worker->lock);
+	raw_spin_lock(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -852,7 +852,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
-	spin_unlock(&worker->lock);
+	raw_spin_unlock(&worker->lock);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
@@ -908,14 +908,14 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	bool ret = false;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	if (!queuing_blocked(worker, work)) {
 		__kthread_queue_delayed_work(worker, dwork, delay);
 		ret = true;
 	}
 
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
@@ -951,7 +951,7 @@ void kthread_flush_work(struct kthread_work *work)
 	if (!worker)
 		return;
 
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -963,7 +963,7 @@ void kthread_flush_work(struct kthread_work *work)
 	else
 		noop = true;
 
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
 
 	if (!noop)
 		wait_for_completion(&fwork.done);
@@ -996,9 +996,9 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
 		 * any queuing is blocked by setting the canceling counter.
 		 */
 		work->canceling++;
-		spin_unlock_irqrestore(&worker->lock, *flags);
+		raw_spin_unlock_irqrestore(&worker->lock, *flags);
 		del_timer_sync(&dwork->timer);
-		spin_lock_irqsave(&worker->lock, *flags);
+		raw_spin_lock_irqsave(&worker->lock, *flags);
 		work->canceling--;
 	}
 
@@ -1045,7 +1045,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	int ret = false;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
 	if (!work->worker)
@@ -1062,7 +1062,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 fast_queue:
 	__kthread_queue_delayed_work(worker, dwork, delay);
 out:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
@@ -1076,7 +1076,7 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 	if (!worker)
 		goto out;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -1090,13 +1090,13 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 	 * In the meantime, block any queuing by setting the canceling counter.
 	 */
 	work->canceling++;
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	kthread_flush_work(work);
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	work->canceling--;
 
 out_fast:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 out:
 	return ret;
 }
