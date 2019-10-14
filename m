Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A418AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BCE205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfJNGj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:39:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbfJNGj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:39:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7317AD29;
        Mon, 14 Oct 2019 06:39:24 +0000 (UTC)
Date:   Sun, 13 Oct 2019 23:38:10 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/6] ipc/mqueue.c: Update/document memory barriers
Message-ID: <20191014063810.2delhkndor5v6bkp@linux-p48b>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-4-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191012054958.3624-4-manfred@colorfullife.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2019, Manfred Spraul wrote:

>Update and document memory barriers for mqueue.c:
>- ewp->state is read without any locks, thus READ_ONCE is required.
>
>- add smp_aquire__after_ctrl_dep() after the READ_ONCE, we need
>  acquire semantics if the value is STATE_READY.
>
>- add an explicit memory barrier to __pipelined_op(), the
>  refcount must have been increased before the updated state becomes
>  visible
>
>- document why __set_current_state() may be used:
>  Reading task->state cannot happen before the wake_q_add() call,
>  which happens while holding info->lock. Thus the spin_unlock()
>  is the RELEASE, and the spin_lock() is the ACQUIRE.
>
>For completeness: there is also a 3 CPU szenario, if the to be woken
     		   	    	     	 ^^^ scenario

>up task is already on another wake_q.
>Then:
>- CPU1: spin_unlock() of the task that goes to sleep is the RELEASE
>- CPU2: the spin_lock() of the waker is the ACQUIRE
>- CPU2: smp_mb__before_atomic inside wake_q_add() is the RELEASE
>- CPU3: smp_mb__after_spinlock() inside try_to_wake_up() is the ACQUIRE
>
>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>Cc: Waiman Long <longman@redhat.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>

Without considering the smp_store_release() in __pipelined_op(), feel
free to add my:

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

>---
> ipc/mqueue.c | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)
>
>diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>index be48c0ba92f7..b80574822f0a 100644
>--- a/ipc/mqueue.c
>+++ b/ipc/mqueue.c
>@@ -646,18 +646,26 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
> 	wq_add(info, sr, ewp);
>
> 	for (;;) {
>+		/* memory barrier not required, we hold info->lock */
> 		__set_current_state(TASK_INTERRUPTIBLE);
>
> 		spin_unlock(&info->lock);
> 		time = schedule_hrtimeout_range_clock(timeout, 0,
> 			HRTIMER_MODE_ABS, CLOCK_REALTIME);
>
>-		if (ewp->state == STATE_READY) {
>+		if (READ_ONCE(ewp->state) == STATE_READY) {
>+			/*
>+			 * Pairs, together with READ_ONCE(), with
>+			 * the barrier in __pipelined_op().
>+			 */
>+			smp_acquire__after_ctrl_dep();
> 			retval = 0;
> 			goto out;
> 		}
> 		spin_lock(&info->lock);
>-		if (ewp->state == STATE_READY) {
>+
>+		/* we hold info->lock, so no memory barrier required */
>+		if (READ_ONCE(ewp->state) == STATE_READY) {
> 			retval = 0;
> 			goto out_unlock;
> 		}
>@@ -925,14 +933,12 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
> 	list_del(&this->list);
> 	wake_q_add(wake_q, this->task);
> 	/*
>-	 * Rely on the implicit cmpxchg barrier from wake_q_add such
>-	 * that we can ensure that updating receiver->state is the last
>-	 * write operation: As once set, the receiver can continue,
>-	 * and if we don't have the reference count from the wake_q,
>-	 * yet, at that point we can later have a use-after-free
>-	 * condition and bogus wakeup.
>+	 * The barrier is required to ensure that the refcount increase
>+	 * inside wake_q_add() is completed before the state is updated.
>+	 *
>+	 * The barrier pairs with READ_ONCE()+smp_mb__after_ctrl_dep().
> 	 */
>-        this->state = STATE_READY;
>+        smp_store_release(&this->state, STATE_READY);
> }
>
> /* pipelined_send() - send a message directly to the task waiting in
>@@ -1049,7 +1055,9 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
> 		} else {
> 			wait.task = current;
> 			wait.msg = (void *) msg_ptr;
>-			wait.state = STATE_NONE;
>+
>+			/* memory barrier not required, we hold info->lock */
>+			WRITE_ONCE(wait.state, STATE_NONE);
> 			ret = wq_sleep(info, SEND, timeout, &wait);
> 			/*
> 			 * wq_sleep must be called with info->lock held, and
>@@ -1152,7 +1160,9 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
> 			ret = -EAGAIN;
> 		} else {
> 			wait.task = current;
>-			wait.state = STATE_NONE;
>+
>+			/* memory barrier not required, we hold info->lock */
>+			WRITE_ONCE(wait.state, STATE_NONE);
> 			ret = wq_sleep(info, RECV, timeout, &wait);
> 			msg_ptr = wait.msg;
> 		}
>-- 
>2.21.0
>
