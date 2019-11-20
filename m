Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915AF2243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfKTJib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:38:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55853 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbfKTJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:38:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXMRN-0003xN-La; Wed, 20 Nov 2019 10:38:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3EC3A1C19FF;
        Wed, 20 Nov 2019 10:38:25 +0100 (CET)
Date:   Wed, 20 Nov 2019 09:38:25 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Add mutex around futex exit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.845798895@linutronix.de>
References: <20191106224556.845798895@linutronix.de>
MIME-Version: 1.0
Message-ID: <157424270520.12247.4105968743634421206.tip-bot2@tip-bot2>
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

Commit-ID:     3f186d974826847a07bc7964d79ec4eded475ad9
Gitweb:        https://git.kernel.org/tip/3f186d974826847a07bc7964d79ec4eded475ad9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Nov 2019 09:40:10 +01:00

futex: Add mutex around futex exit

The mutex will be used in subsequent changes to replace the busy looping of
a waiter when the futex owner is currently executing the exit cleanup to
prevent a potential live lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.845798895@linutronix.de


---
 include/linux/futex.h |  1 +
 include/linux/sched.h |  1 +
 kernel/futex.c        | 16 ++++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9f27924..5cc3fed 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -65,6 +65,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
 	tsk->futex_state = FUTEX_STATE_OK;
+	mutex_init(&tsk->futex_exit_mutex);
 }
 
 void futex_exit_recursive(struct task_struct *tsk);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 85dab2f..1ebe540 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1053,6 +1053,7 @@ struct task_struct {
 #endif
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
+	struct mutex			futex_exit_mutex;
 	unsigned int			futex_state;
 #endif
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/futex.c b/kernel/futex.c
index 0c9850a..46a81e6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3698,12 +3698,23 @@ static void futex_cleanup(struct task_struct *tsk)
  */
 void futex_exit_recursive(struct task_struct *tsk)
 {
+	/* If the state is FUTEX_STATE_EXITING then futex_exit_mutex is held */
+	if (tsk->futex_state == FUTEX_STATE_EXITING)
+		mutex_unlock(&tsk->futex_exit_mutex);
 	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
 static void futex_cleanup_begin(struct task_struct *tsk)
 {
 	/*
+	 * Prevent various race issues against a concurrent incoming waiter
+	 * including live locks by forcing the waiter to block on
+	 * tsk->futex_exit_mutex when it observes FUTEX_STATE_EXITING in
+	 * attach_to_pi_owner().
+	 */
+	mutex_lock(&tsk->futex_exit_mutex);
+
+	/*
 	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
 	 *
 	 * This ensures that all subsequent checks of tsk->futex_state in
@@ -3726,6 +3737,11 @@ static void futex_cleanup_end(struct task_struct *tsk, int state)
 	 * take another loop until it becomes visible.
 	 */
 	tsk->futex_state = state;
+	/*
+	 * Drop the exit protection. This unblocks waiters which observed
+	 * FUTEX_STATE_EXITING to reevaluate the state.
+	 */
+	mutex_unlock(&tsk->futex_exit_mutex);
 }
 
 void futex_exec_release(struct task_struct *tsk)
