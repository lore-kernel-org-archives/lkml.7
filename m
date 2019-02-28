Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78564C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEDB21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfB1HI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:08:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfB1HI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:08:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S77tOJ2938786
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:07:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S77tGI2938782;
        Wed, 27 Feb 2019 23:07:55 -0800
Date:   Wed, 27 Feb 2019 23:07:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-cdc84d794947b5431c0a6916c303aee7114819d2@git.kernel.org>
Cc:     hpa@zytor.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, bvanassche@acm.org,
        longman@redhat.com, tglx@linutronix.de, will.deacon@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        johannes@sipsolutions.net
Reply-To: tglx@linutronix.de, bvanassche@acm.org, longman@redhat.com,
          torvalds@linux-foundation.org, akpm@linux-foundation.org,
          hpa@zytor.com, johannes@sipsolutions.net,
          paulmck@linux.vnet.ibm.com, mingo@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          will.deacon@arm.com
In-Reply-To: <20190214230058.196511-10-bvanassche@acm.org>
References: <20190214230058.196511-10-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Make it easy to detect whether
 or not inside a selftest
Git-Commit-ID: cdc84d794947b5431c0a6916c303aee7114819d2
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

Commit-ID:  cdc84d794947b5431c0a6916c303aee7114819d2
Gitweb:     https://git.kernel.org/tip/cdc84d794947b5431c0a6916c303aee7114819d2
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:44 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:43 +0100

locking/lockdep: Make it easy to detect whether or not inside a selftest

The patch that frees unused lock classes will modify the behavior of
lockdep_free_key_range() and lockdep_reset_lock() depending on whether
or not these functions are called from the context of the lockdep
selftests. Hence make it easy to detect whether or not lockdep code
is called from the context of a lockdep selftest.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20190214230058.196511-10-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h  | 5 +++++
 kernel/locking/lockdep.c | 6 ++++++
 lib/locking-selftest.c   | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b5e6bfe0ae4a..66eee1ba0f2a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -265,6 +265,7 @@ extern void lockdep_reset(void);
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
 extern asmlinkage void lockdep_sys_exit(void);
+extern void lockdep_set_selftest_task(struct task_struct *task);
 
 extern void lockdep_off(void);
 extern void lockdep_on(void);
@@ -395,6 +396,10 @@ static inline void lockdep_on(void)
 {
 }
 
+static inline void lockdep_set_selftest_task(struct task_struct *task)
+{
+}
+
 # define lock_acquire(l, s, t, r, c, n, i)	do { } while (0)
 # define lock_release(l, n, i)			do { } while (0)
 # define lock_downgrade(l, i)			do { } while (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2d4c21a02546..34cd87c65f5d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -81,6 +81,7 @@ module_param(lock_stat, int, 0644);
  * code to recurse back into the lockdep code...
  */
 static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static struct task_struct *lockdep_selftest_task_struct;
 
 static int graph_lock(void)
 {
@@ -331,6 +332,11 @@ void lockdep_on(void)
 }
 EXPORT_SYMBOL(lockdep_on);
 
+void lockdep_set_selftest_task(struct task_struct *task)
+{
+	lockdep_selftest_task_struct = task;
+}
+
 /*
  * Debugging switches:
  */
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 1e1bbf171eca..a1705545e6ac 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1989,6 +1989,7 @@ void locking_selftest(void)
 
 	init_shared_classes();
 	debug_locks_silent = !debug_locks_verbose;
+	lockdep_set_selftest_task(current);
 
 	DO_TESTCASE_6R("A-A deadlock", AA);
 	DO_TESTCASE_6R("A-B-B-A deadlock", ABBA);
@@ -2097,5 +2098,6 @@ void locking_selftest(void)
 		printk("---------------------------------\n");
 		debug_locks = 1;
 	}
+	lockdep_set_selftest_task(NULL);
 	debug_locks_silent = 0;
 }
