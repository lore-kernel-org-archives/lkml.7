Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE228CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A616121929
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="aryjRusw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfJTMdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 08:33:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43814 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfJTMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 08:33:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so5555886wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sD9MWdDQg3IiupvmuRemFxneRWukqhVaE+8WKscNL/o=;
        b=aryjRuswNQHA1zD8XM/xCQj8MsKPgigaAtlNQ++OoftUeG1uMUNlVfSGZ0uvxh3bB4
         zeUOrWzJSF+dH32s7gAzYRyDQzkzUEV68MbC08dgP7xvAy5YZQiJFYWOMsyF0NTxR4SR
         eYnxG1TX4o0HiNNrrlc+w3PmLoewXSSgKEDzdJO8nc35JfZ7TWKSbzLBTpAeV8DfHaPS
         GX5xreEqzJma8dyUoUGktK8Eg58CPCWkKNPOJKBGKGrEyWCGf8R3FJCnxIFxzcMSbwgO
         6UkktbsXsRA2fWEOIOqv9UseUNr/eTwjCebOQH3Vc8Ob1+Uv6jn4S5fApOlr1TZ7a3fJ
         vXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sD9MWdDQg3IiupvmuRemFxneRWukqhVaE+8WKscNL/o=;
        b=rzm4WJUCmVLKn5v50NNoOGMO5PYMrKAhvVZ36au34iIy6DX8p1wsg4chBd6PgFy9GI
         LdyJrzo7edPfkuJ9V3bC+TnIX3wrmerAbOmkvEyw1egmHcwoYKxoaHhqIdr9lQvBNIBV
         oCImcAwk6cxG1Gi9XuztwS9l6OHJmCM5PNmPgtXTaG+sO8Xk1oop/WT9zJYzi7kBnHUa
         MIMntaqaMPi7RX/v3XvqhhAbSdGLibHxgx51s9Z9jaktXHp8hoN51DGHj0yNMHKLPbTZ
         FTgj7tzRSc+liXMMjtKy6Vbrm0pKjUDyzp0sOrU+JiIV3bUE/hdbLHbL53PNrlQHDPky
         k+Bg==
X-Gm-Message-State: APjAAAWFMStLR8OzgYQaXAWsmgdiN4tL7aphwkBtVA1l4RumrGeTHUIg
        pMkbv2/y/06K7Mw04X1b6UtYT+ICRRU=
X-Google-Smtp-Source: APXvYqz1/OLjRZJoa+C9RlDzK2J4OumWLBdtHG9FnZ2kLQeOi2QvP4urSX1zywna2nh27sHy0OsNsA==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr14796479wrj.283.1571574800731;
        Sun, 20 Oct 2019 05:33:20 -0700 (PDT)
Received: from linux.fritz.box (p200300D99703FC00226A5479D1389944.dip0.t-ipconnect.de. [2003:d9:9703:fc00:226a:5479:d138:9944])
        by smtp.googlemail.com with ESMTPSA id t13sm15065400wra.70.2019.10.20.05.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 05:33:20 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/5] ipc/mqueue.c: Update/document memory barriers
Date:   Sun, 20 Oct 2019 14:33:03 +0200
Message-Id: <20191020123305.14715-4-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020123305.14715-1-manfred@colorfullife.com>
References: <20191020123305.14715-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update and document memory barriers for mqueue.c:
- ewp->state is read without any locks, thus READ_ONCE is required.

- add smp_aquire__after_ctrl_dep() after the READ_ONCE, we need
  acquire semantics if the value is STATE_READY.

- use wake_q_add_safe()

- document why __set_current_state() may be used:
  Reading task->state cannot happen before the wake_q_add() call,
  which happens while holding info->lock. Thus the spin_unlock()
  is the RELEASE, and the spin_lock() is the ACQUIRE.

For completeness: there is also a 3 CPU scenario, if the to be woken
up task is already on another wake_q.
Then:
- CPU1: spin_unlock() of the task that goes to sleep is the RELEASE
- CPU2: the spin_lock() of the waker is the ACQUIRE
- CPU2: smp_mb__before_atomic inside wake_q_add() is the RELEASE
- CPU3: smp_mb__after_spinlock() inside try_to_wake_up() is the ACQUIRE

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Waiman Long <longman@redhat.com>
---
 ipc/mqueue.c | 92 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 270456530f6a..49a05ba3000d 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -63,6 +63,66 @@ struct posix_msg_tree_node {
 	int			priority;
 };
 
+/*
+ * Locking:
+ *
+ * Accesses to a message queue are synchronized by acquiring info->lock.
+ *
+ * There are two notable exceptions:
+ * - The actual wakeup of a sleeping task is performed using the wake_q
+ *   framework. info->lock is already released when wake_up_q is called.
+ * - The exit codepaths after sleeping check ext_wait_queue->state without
+ *   any locks. If it is STATE_READY, then the syscall is completed without
+ *   acquiring info->lock.
+ *
+ * MQ_BARRIER:
+ * To achieve proper release/acquire memory barrier pairing, the state is set to
+ * STATE_READY with smp_store_release(), and it is read with READ_ONCE followed
+ * by smp_acquire__after_ctrl_dep(). In addition, wake_q_add_safe() is used.
+ *
+ * This prevents the following races:
+ *
+ * 1) With the simple wake_q_add(), the task could be gone already before
+ *    the increase of the reference happens
+ * Thread A
+ *				Thread B
+ * WRITE_ONCE(wait.state, STATE_NONE);
+ * schedule_hrtimeout()
+ *				wake_q_add(A)
+ *				if (cmpxchg()) // success
+ *				   ->state = STATE_READY (reordered)
+ * <timeout returns>
+ * if (wait.state == STATE_READY) return;
+ * sysret to user space
+ * sys_exit()
+ *				get_task_struct() // UaF
+ *
+ * Solution: Use wake_q_add_safe() and perform the get_task_struct() before
+ * the smp_store_release() that does ->state = STATE_READY.
+ *
+ * 2) Without proper _release/_acquire barriers, the woken up task
+ *    could read stale data
+ *
+ * Thread A
+ *				Thread B
+ * do_mq_timedreceive
+ * WRITE_ONCE(wait.state, STATE_NONE);
+ * schedule_hrtimeout()
+ *				state = STATE_READY;
+ * <timeout returns>
+ * if (wait.state == STATE_READY) return;
+ * msg_ptr = wait.msg;		// Access to stale data!
+ *				receiver->msg = message; (reordered)
+ *
+ * Solution: use _release and _acquire barriers.
+ *
+ * 3) There is intentionally no barrier when setting current->state
+ *    to TASK_INTERRUPTIBLE: spin_unlock(&info->lock) provides the
+ *    release memory barrier, and the wakeup is triggered when holding
+ *    info->lock, i.e. spin_lock(&info->lock) provided a pairing
+ *    acquire memory barrier.
+ */
+
 struct ext_wait_queue {		/* queue of sleeping tasks */
 	struct task_struct *task;
 	struct list_head list;
@@ -646,18 +706,23 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
 	wq_add(info, sr, ewp);
 
 	for (;;) {
+		/* memory barrier not required, we hold info->lock */
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		spin_unlock(&info->lock);
 		time = schedule_hrtimeout_range_clock(timeout, 0,
 			HRTIMER_MODE_ABS, CLOCK_REALTIME);
 
-		if (ewp->state == STATE_READY) {
+		if (READ_ONCE(ewp->state) == STATE_READY) {
+			/* see MQ_BARRIER for purpose/pairing */
+			smp_acquire__after_ctrl_dep();
 			retval = 0;
 			goto out;
 		}
 		spin_lock(&info->lock);
-		if (ewp->state == STATE_READY) {
+
+		/* we hold info->lock, so no memory barrier required */
+		if (READ_ONCE(ewp->state) == STATE_READY) {
 			retval = 0;
 			goto out_unlock;
 		}
@@ -923,16 +988,11 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
 				  struct ext_wait_queue *this)
 {
 	list_del(&this->list);
-	wake_q_add(wake_q, this->task);
-	/*
-	 * Rely on the implicit cmpxchg barrier from wake_q_add such
-	 * that we can ensure that updating receiver->state is the last
-	 * write operation: As once set, the receiver can continue,
-	 * and if we don't have the reference count from the wake_q,
-	 * yet, at that point we can later have a use-after-free
-	 * condition and bogus wakeup.
-	 */
-	this->state = STATE_READY;
+	get_task_struct(this->task);
+
+	/* see MQ_BARRIER for purpose/pairing */
+	smp_store_release(&this->state, STATE_READY);
+	wake_q_add_safe(wake_q, this->task);
 }
 
 /* pipelined_send() - send a message directly to the task waiting in
@@ -1049,7 +1109,9 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 		} else {
 			wait.task = current;
 			wait.msg = (void *) msg_ptr;
-			wait.state = STATE_NONE;
+
+			/* memory barrier not required, we hold info->lock */
+			WRITE_ONCE(wait.state, STATE_NONE);
 			ret = wq_sleep(info, SEND, timeout, &wait);
 			/*
 			 * wq_sleep must be called with info->lock held, and
@@ -1152,7 +1214,9 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 			ret = -EAGAIN;
 		} else {
 			wait.task = current;
-			wait.state = STATE_NONE;
+
+			/* memory barrier not required, we hold info->lock */
+			WRITE_ONCE(wait.state, STATE_NONE);
 			ret = wq_sleep(info, RECV, timeout, &wait);
 			msg_ptr = wait.msg;
 		}
-- 
2.21.0

