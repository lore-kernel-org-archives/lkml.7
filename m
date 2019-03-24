Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F09222E4
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfCXOOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:14:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43617 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfCXOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:14:01 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h83st-0001yx-PV; Sun, 24 Mar 2019 15:13:59 +0100
Date:   Sun, 24 Mar 2019 14:12:21 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking updates for 5.1
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
Message-ID: <155343674151.28403.8597495949023094608.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

Two small fixes;

 - Cure a recently introduces error path hickup which tries to
   unregister a not registered lockdep key in te workqueue code.

 - Prevent unaligned cmpxchg() crashes in the robust list handling code by
   sanity checking the user space supplied futex pointer.

Thanks,

	tglx

------------------>
Bart Van Assche (1):
      workqueue: Only unregister a registered lockdep key

Chen Jie (1):
      futex: Ensure that futex address is aligned in handle_futex_death()


 kernel/futex.c     | 4 ++++
 kernel/workqueue.c | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index c3b73b0311bc..9e40cf7be606 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3436,6 +3436,10 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int p
 {
 	u32 uval, uninitialized_var(nval), mval;
 
+	/* Futex address must be 32bit aligned */
+	if ((((unsigned long)uaddr) % sizeof(*uaddr)) != 0)
+		return -1;
+
 retry:
 	if (get_user(uval, uaddr))
 		return -1;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4026d1871407..ddee541ea97a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4266,7 +4266,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	INIT_LIST_HEAD(&wq->list);
 
 	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_free_wq;
+		goto err_unreg_lockdep;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -4292,9 +4292,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
-err_free_wq:
+err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
+err_free_wq:
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;

