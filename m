Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A9DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0339522440
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfKTJiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:38:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55878 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfKTJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:38:36 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXMRO-0003y4-0Z; Wed, 20 Nov 2019 10:38:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AED2D1C19FE;
        Wed, 20 Nov 2019 10:38:25 +0100 (CET)
Date:   Wed, 20 Nov 2019 09:38:25 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Sanitize exit state handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.645603214@linutronix.de>
References: <20191106224556.645603214@linutronix.de>
MIME-Version: 1.0
Message-ID: <157424270563.12247.11474112046933064148.tip-bot2@tip-bot2>
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

Commit-ID:     4a8e991b91aca9e20705d434677ac013974e0e30
Gitweb:        https://git.kernel.org/tip/4a8e991b91aca9e20705d434677ac013974e0e30
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Nov 2019 09:40:09 +01:00

futex: Sanitize exit state handling

Instead of having a smp_mb() and an empty lock/unlock of task::pi_lock move
the state setting into to the lock section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.645603214@linutronix.de


---
 kernel/futex.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 3488fb0..f618562 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3703,16 +3703,19 @@ void futex_exit_recursive(struct task_struct *tsk)
 
 void futex_exit_release(struct task_struct *tsk)
 {
-	tsk->futex_state = FUTEX_STATE_EXITING;
-	/*
-	 * Ensure that all new tsk->pi_lock acquisitions must observe
-	 * FUTEX_STATE_EXITING. Serializes against attach_to_pi_owner().
-	 */
-	smp_mb();
 	/*
-	 * Ensure that we must observe the pi_state in exit_pi_state_list().
+	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
+	 *
+	 * This ensures that all subsequent checks of tsk->futex_state in
+	 * attach_to_pi_owner() must observe FUTEX_STATE_EXITING with
+	 * tsk->pi_lock held.
+	 *
+	 * It guarantees also that a pi_state which was queued right before
+	 * the state change under tsk->pi_lock by a concurrent waiter must
+	 * be observed in exit_pi_state_list().
 	 */
 	raw_spin_lock_irq(&tsk->pi_lock);
+	tsk->futex_state = FUTEX_STATE_EXITING;
 	raw_spin_unlock_irq(&tsk->pi_lock);
 
 	futex_exec_release(tsk);
