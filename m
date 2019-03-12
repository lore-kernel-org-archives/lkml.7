Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F1A2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411251;
	bh=3EjlDeuy8M98cjXPCaKP0oWMXSUSLFqGeu+8TYkmz4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5bnYHWuJJM4mcToSpgccXruVgOLKSKMt1Mw6Xl014t3PY9dkYAYFr2Q0xLOpMZme
	 SN88x3ynZWCRLtpn89qvfjN25dxVaF0lc2eyhS7EMA1UW3NLGjnIL8BE/sM2jToKxl
	 6Zhu592kiFFpc8+T07NSkss0Gr12XMJblm+ohbPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfCLRUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbfCLRST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:19 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1205A206DF;
        Tue, 12 Mar 2019 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411098;
        bh=3EjlDeuy8M98cjXPCaKP0oWMXSUSLFqGeu+8TYkmz4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0SSSymHAvYLGkY1y+iFnkCIS93GdZCVa8DAKGQjPMs1m1LsJ9CR8H4gyJvGthURU
         HtKT4OrXitSNsUNyNqCVR2kzayv55/Wt7MKUJoGx1ZSBhgJ69IYGNGEVx27ZRIKApi
         ZfGGgqD4iaL94YAZqlWTsDzqQ1bJHdc3fB6yvOy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        juri.lelli@arm.com, bigeasy@linutronix.de, xlpang@redhat.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jdesfossez@efficios.com, dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.9 88/96] futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()
Date:   Tue, 12 Mar 2019 10:10:46 -0700
Message-Id: <20190312171041.118839499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 38d589f2fd08f1296aea3ce62bebd185125c6d81 upstream.

With the ultimate goal of keeping rt_mutex wait_list and futex_q waiters
consistent it's necessary to split 'rt_mutex_futex_lock()' into finer
parts, such that only the actual blocking can be done without hb->lock
held.

Split split_mutex_finish_proxy_lock() into two parts, one that does the
blocking and one that does remove_waiter() when the lock acquire failed.

When the rtmutex was acquired successfully the waiter can be removed in the
acquisiton path safely, since there is no concurrency on the lock owner.

This means that, except for futex_lock_pi(), all wait_list modifications
are done with both hb->lock and wait_lock held.

[bigeasy@linutronix.de: fix for futex_requeue_pi_signal_restart]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104152.001659630@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/futex.c                  |    7 +++--
 kernel/locking/rtmutex.c        |   52 ++++++++++++++++++++++++++++++++++------
 kernel/locking/rtmutex_common.h |    8 +++---
 3 files changed, 55 insertions(+), 12 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2966,10 +2966,13 @@ static int futex_wait_requeue_pi(u32 __u
 		 */
 		WARN_ON(!q.pi_state);
 		pi_mutex = &q.pi_state->pi_mutex;
-		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter);
-		debug_rt_mutex_free_waiter(&rt_waiter);
+		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
 		spin_lock(q.lock_ptr);
+		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
+			ret = 0;
+
+		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
 		 * haven't already.
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1746,21 +1746,23 @@ struct task_struct *rt_mutex_next_owner(
 }
 
 /**
- * rt_mutex_finish_proxy_lock() - Complete lock acquisition
+ * rt_mutex_wait_proxy_lock() - Wait for lock acquisition
  * @lock:		the rt_mutex we were woken on
  * @to:			the timeout, null if none. hrtimer should already have
  *			been started.
  * @waiter:		the pre-initialized rt_mutex_waiter
  *
- * Complete the lock acquisition started our behalf by another thread.
+ * Wait for the the lock acquisition started on our behalf by
+ * rt_mutex_start_proxy_lock(). Upon failure, the caller must call
+ * rt_mutex_cleanup_proxy_lock().
  *
  * Returns:
  *  0 - success
  * <0 - error, one of -EINTR, -ETIMEDOUT
  *
- * Special API call for PI-futex requeue support
+ * Special API call for PI-futex support
  */
-int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
+int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
@@ -1773,9 +1775,6 @@ int rt_mutex_finish_proxy_lock(struct rt
 	/* sleep on the mutex */
 	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter);
 
-	if (unlikely(ret))
-		remove_waiter(lock, waiter);
-
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
@@ -1786,3 +1785,42 @@ int rt_mutex_finish_proxy_lock(struct rt
 
 	return ret;
 }
+
+/**
+ * rt_mutex_cleanup_proxy_lock() - Cleanup failed lock acquisition
+ * @lock:		the rt_mutex we were woken on
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ *
+ * Attempt to clean up after a failed rt_mutex_wait_proxy_lock().
+ *
+ * Unless we acquired the lock; we're still enqueued on the wait-list and can
+ * in fact still be granted ownership until we're removed. Therefore we can
+ * find we are in fact the owner and must disregard the
+ * rt_mutex_wait_proxy_lock() failure.
+ *
+ * Returns:
+ *  true  - did the cleanup, we done.
+ *  false - we acquired the lock after rt_mutex_wait_proxy_lock() returned,
+ *          caller should disregards its return value.
+ *
+ * Special API call for PI-futex support
+ */
+bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+				 struct rt_mutex_waiter *waiter)
+{
+	bool cleanup = false;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	/*
+	 * Unless we're the owner; we're still enqueued on the wait_list.
+	 * So check if we became owner, if not, take us off the wait_list.
+	 */
+	if (rt_mutex_owner(lock) != current) {
+		remove_waiter(lock, waiter);
+		fixup_rt_mutex_waiters(lock);
+		cleanup = true;
+	}
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	return cleanup;
+}
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -107,9 +107,11 @@ extern void rt_mutex_proxy_unlock(struct
 extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-extern int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
-				      struct hrtimer_sleeper *to,
-				      struct rt_mutex_waiter *waiter);
+extern int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
+			       struct hrtimer_sleeper *to,
+			       struct rt_mutex_waiter *waiter);
+extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+				 struct rt_mutex_waiter *waiter);
 extern int rt_mutex_timed_futex_lock(struct rt_mutex *l, struct hrtimer_sleeper *to);
 extern bool rt_mutex_futex_unlock(struct rt_mutex *lock,
 				  struct wake_q_head *wqh);


