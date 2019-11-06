Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2946FC6196
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9875120869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfKFXIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:08:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732877AbfKFXIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:30 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPa-0004lM-UP; Thu, 07 Nov 2019 00:08:27 +0100
Message-Id: <20191106224556.935606117@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:45 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [patch 11/12] futex: Provide distinct return value when owner is
 exiting
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

attach_to_pi_owner() returns -EAGAIN for various cases:

 - Owner task is exiting
 - Futex value has changed

The caller drops the held locks (hash bucket, mmap_sem) and retries the
operation. In case of the owner task exiting this can result in a live
lock.

As a preparatory step for seperating those cases, provide a distinct return
value (EBUSY) for the owner exiting case.

No funcitonal change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1182,11 +1182,11 @@ static int handle_exit_race(u32 __user *
 	u32 uval2;
 
 	/*
-	 * If the futex exit state is not yet FUTEX_STATE_DEAD, wait
-	 * for it to finish.
+	 * If the futex exit state is not yet FUTEX_STATE_DEAD, tell the
+	 * caller that the alleged owner is busy.
 	 */
 	if (tsk && tsk->futex_state != FUTEX_STATE_DEAD)
-		return -EAGAIN;
+		return -EBUSY;
 
 	/*
 	 * Reread the user space value to handle the following situation:
@@ -2092,12 +2092,13 @@ static int futex_requeue(u32 __user *uad
 			if (!ret)
 				goto retry;
 			goto out;
+		case -EBUSY:
 		case -EAGAIN:
 			/*
 			 * Two reasons for this:
-			 * - Owner is exiting and we just wait for the
+			 * - EBUSY: Owner is exiting and we just wait for the
 			 *   exit to complete.
-			 * - The user space value changed.
+			 * - EAGAIN: The user space value changed.
 			 */
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
@@ -2843,12 +2844,13 @@ static int futex_lock_pi(u32 __user *uad
 			goto out_unlock_put_key;
 		case -EFAULT:
 			goto uaddr_faulted;
+		case -EBUSY:
 		case -EAGAIN:
 			/*
 			 * Two reasons for this:
-			 * - Task is exiting and we just wait for the
+			 * - EBUSY: Task is exiting and we just wait for the
 			 *   exit to complete.
-			 * - The user space value changed.
+			 * - EAGAIN: The user space value changed.
 			 */
 			queue_unlock(hb);
 			put_futex_key(&q.key);


