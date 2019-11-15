Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BEFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6E32073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKOSUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:20:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44304 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfKOSTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:19:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVgBj-00059Q-PH; Fri, 15 Nov 2019 19:19:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5A7AB1C18CD;
        Fri, 15 Nov 2019 19:19:19 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:19:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Provide distinct return value when owner
 is exiting
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.935606117@linutronix.de>
References: <20191106224556.935606117@linutronix.de>
MIME-Version: 1.0
Message-ID: <157384195933.12247.11433099250736652898.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8d4da5b197dc2aa3d10d9f1246d02e33b8f17acc
Gitweb:        https://git.kernel.org/tip/8d4da5b197dc2aa3d10d9f1246d02e33b8f17acc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 19:10:54 +01:00

futex: Provide distinct return value when owner is exiting

attach_to_pi_owner() returns -EAGAIN for various cases:

 - Owner task is exiting
 - Futex value has changed

The caller drops the held locks (hash bucket, mmap_sem) and retries the
operation. In case of the owner task exiting this can result in a live
lock.

As a preparatory step for seperating those cases, provide a distinct return
value (EBUSY) for the owner exiting case.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.935606117@linutronix.de

---
 kernel/futex.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 46a81e6..4f9d7a4 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1182,11 +1182,11 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
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
@@ -2092,12 +2092,13 @@ retry_private:
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
@@ -2843,12 +2844,13 @@ retry_private:
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
