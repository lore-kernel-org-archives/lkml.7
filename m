Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CECC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F29207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfCJLdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 07:33:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfCJLdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 07:33:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h2wiB-00005z-SW; Sun, 10 Mar 2019 12:33:48 +0100
Subject: [GIT pull] locking fixes for 5.1
Message-ID: <155221755096.13878.17210891228269439774.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
Date:   Sun, 10 Mar 2019 12:33:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

A few fixes for lockdep:

 - Initialize lockdep internal RCU head after initializing RCU

 - Prevent use after free in a alloc_workqueue() error handling path

 - Plug a memory leak in the workqueue core which fails to free a
   dynamically allocated lock name.

 - Make Clang happy


Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      locking/lockdep: Avoid a Clang warning

Bart Van Assche (2):
      locking/lockdep: Only call init_rcu_head() after RCU has been initialized
      workqueue, lockdep: Fix an alloc_workqueue() error path

Qian Cai (1):
      workqueue, lockdep: Fix a memory leak in wq->lock_name


 kernel/locking/lockdep.c | 19 ++++++++++++++-----
 kernel/workqueue.c       |  4 ++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 21cb81fe6359..34cdcbedda49 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -842,7 +842,9 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 	return true;
 }
 
-static u16 chain_hlocks[];
+#ifdef CONFIG_PROVE_LOCKING
+static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+#endif
 
 static bool check_lock_chain_key(struct lock_chain *chain)
 {
@@ -980,15 +982,22 @@ static inline void check_data_structures(void) { }
  */
 static void init_data_structures_once(void)
 {
-	static bool initialization_happened;
+	static bool ds_initialized, rcu_head_initialized;
 	int i;
 
-	if (likely(initialization_happened))
+	if (likely(rcu_head_initialized))
+		return;
+
+	if (system_state >= SYSTEM_SCHEDULING) {
+		init_rcu_head(&delayed_free.rcu_head);
+		rcu_head_initialized = true;
+	}
+
+	if (ds_initialized)
 		return;
 
-	initialization_happened = true;
+	ds_initialized = true;
 
-	init_rcu_head(&delayed_free.rcu_head);
 	INIT_LIST_HEAD(&delayed_free.pf[0].zapped);
 	INIT_LIST_HEAD(&delayed_free.pf[1].zapped);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e163e7a7f5e5..e14da4f599ab 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3348,6 +3348,8 @@ static void wq_init_lockdep(struct workqueue_struct *wq)
 	lock_name = kasprintf(GFP_KERNEL, "%s%s", "(wq_completion)", wq->name);
 	if (!lock_name)
 		lock_name = wq->name;
+
+	wq->lock_name = lock_name;
 	lockdep_init_map(&wq->lockdep_map, lock_name, &wq->key, 0);
 }
 
@@ -4194,6 +4196,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	return wq;
 
 err_free_wq:
+	wq_unregister_lockdep(wq);
+	wq_free_lockdep(wq);
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
 	return NULL;

