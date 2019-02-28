Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A43C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D00E218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbfB1KW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:22:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58663 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732321AbfB1KW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:22:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1SAMmFX2997298
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 02:22:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1SAMll82997294;
        Thu, 28 Feb 2019 02:22:47 -0800
Date:   Thu, 28 Feb 2019 02:22:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-ad01423aedaa7c6dd62d560b73a3cb39e6da3901@git.kernel.org>
Cc:     hpa@zytor.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        pmladek@suse.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          hpa@zytor.com, tglx@linutronix.de, pmladek@suse.com,
          mingo@kernel.org
In-Reply-To: <20190212162554.19779-2-bigeasy@linutronix.de>
References: <20190212162554.19779-2-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] kthread: Do not use TIMER_IRQSAFE
Git-Commit-ID: ad01423aedaa7c6dd62d560b73a3cb39e6da3901
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

Commit-ID:  ad01423aedaa7c6dd62d560b73a3cb39e6da3901
Gitweb:     https://git.kernel.org/tip/ad01423aedaa7c6dd62d560b73a3cb39e6da3901
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Tue, 12 Feb 2019 17:25:54 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Feb 2019 11:18:38 +0100

kthread: Do not use TIMER_IRQSAFE

The TIMER_IRQSAFE usage was introduced in commit 22597dc3d97b1 ("kthread:
initial support for delayed kthread work") which modelled the delayed
kthread code after workqueue's code. The workqueue code requires the flag
TIMER_IRQSAFE for synchronisation purpose. This is not true for kthread's
delay timer since all operations occur under a lock.

Remove TIMER_IRQSAFE from the timer initialisation and use timer_setup()
for initialisation purpose which is the official function.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lkml.kernel.org/r/20190212162554.19779-2-bigeasy@linutronix.de

---
 include/linux/kthread.h | 5 ++---
 kernel/kthread.c        | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 6b8c064f0cbc..3d9d834c66a2 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -164,9 +164,8 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 #define kthread_init_delayed_work(dwork, fn)				\
 	do {								\
 		kthread_init_work(&(dwork)->work, (fn));		\
-		__init_timer(&(dwork)->timer,				\
-			     kthread_delayed_work_timer_fn,		\
-			     TIMER_IRQSAFE);				\
+		timer_setup(&(dwork)->timer,				\
+			     kthread_delayed_work_timer_fn, 0);		\
 	} while (0)
 
 int kthread_worker_fn(void *worker_ptr);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5641b55783a6..537335541267 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -835,6 +835,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	struct kthread_delayed_work *dwork = from_timer(dwork, t, timer);
 	struct kthread_work *work = &dwork->work;
 	struct kthread_worker *worker = work->worker;
+	unsigned long flags;
 
 	/*
 	 * This might happen when a pending work is reinitialized.
@@ -843,7 +844,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	if (WARN_ON_ONCE(!worker))
 		return;
 
-	raw_spin_lock(&worker->lock);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -852,7 +853,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
-	raw_spin_unlock(&worker->lock);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
