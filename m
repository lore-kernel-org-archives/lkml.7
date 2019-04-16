Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDEAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084FC206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfDPKFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:05:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47505 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfDPKFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:05:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA3Hhx3398833
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:03:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA3HhC3398830;
        Tue, 16 Apr 2019 03:03:17 -0700
Date:   Tue, 16 Apr 2019 03:03:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-a338ecb07a338c9a8b0ca0010e862ebe598b1551@git.kernel.org>
Cc:     paulmck@linux.vnet.ibm.com, hpa@zytor.com, a.p.zijlstra@chello.nl,
        bp@alien8.de, dave@stgolabs.net, mingo@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        longman@redhat.com, peterz@infradead.org, dbueso@suse.de,
        tglx@linutronix.de, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        arnd@arndb.de
Reply-To: will.deacon@arm.com, linux-kernel@vger.kernel.org,
          tim.c.chen@linux.intel.com, arnd@arndb.de, longman@redhat.com,
          peterz@infradead.org, tglx@linutronix.de, dbueso@suse.de,
          torvalds@linux-foundation.org, mingo@kernel.org,
          akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
          hpa@zytor.com, dave@stgolabs.net, bp@alien8.de,
          a.p.zijlstra@chello.nl
In-Reply-To: <20190404174320.22416-5-longman@redhat.com>
References: <20190404174320.22416-5-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Micro-optimize
 rwsem_try_read_lock_unqueued()
Git-Commit-ID: a338ecb07a338c9a8b0ca0010e862ebe598b1551
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

Commit-ID:  a338ecb07a338c9a8b0ca0010e862ebe598b1551
Gitweb:     https://git.kernel.org/tip/a338ecb07a338c9a8b0ca0010e862ebe598b1551
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:13 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:56:01 +0200

locking/rwsem: Micro-optimize rwsem_try_read_lock_unqueued()

The atomic_long_cmpxchg_acquire() in rwsem_try_read_lock_unqueued() is
replaced by atomic_long_try_cmpxchg_acquire() to simpify the code and
generate slightly better assembly code.

There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: http://lkml.kernel.org/r/20190404174320.22416-5-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index c213869e1aa7..f6198e1a58f6 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -259,21 +259,16 @@ static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
  */
 static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
-	long old, count = atomic_long_read(&sem->count);
+	long count = atomic_long_read(&sem->count);
 
-	while (true) {
-		if (!(count == 0 || count == RWSEM_WAITING_BIAS))
-			return false;
-
-		old = atomic_long_cmpxchg_acquire(&sem->count, count,
-				      count + RWSEM_ACTIVE_WRITE_BIAS);
-		if (old == count) {
+	while (!count || count == RWSEM_WAITING_BIAS) {
+		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
+					count + RWSEM_ACTIVE_WRITE_BIAS)) {
 			rwsem_set_owner(sem);
 			return true;
 		}
-
-		count = old;
 	}
+	return false;
 }
 
 static inline bool owner_on_cpu(struct task_struct *owner)
