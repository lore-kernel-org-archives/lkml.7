Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0523C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8389B2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKOSUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:20:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44308 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKOSTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:19:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVgBk-0005A8-G3; Fri, 15 Nov 2019 19:19:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 33C161C18CD;
        Fri, 15 Nov 2019 19:19:20 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:19:20 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Set task::futex_state to DEAD right after
 handling futex exit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.439511191@linutronix.de>
References: <20191106224556.439511191@linutronix.de>
MIME-Version: 1.0
Message-ID: <157384196017.12247.8393173233687979016.tip-bot2@tip-bot2>
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

Commit-ID:     c60f4b41102c0dcf359010b0fcf24600ad0a41b8
Gitweb:        https://git.kernel.org/tip/c60f4b41102c0dcf359010b0fcf24600ad0a41b8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 19:10:51 +01:00

futex: Set task::futex_state to DEAD right after handling futex exit

Setting task::futex_state in do_exit() is rather arbitrarily placed for no
reason. Move it into the futex code.

Note, this is only done for the exit cleanup as the exec cleanup cannot set
the state to FUTEX_STATE_DEAD because the task struct is still in active
use.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.439511191@linutronix.de

---
 kernel/exit.c  | 1 -
 kernel/futex.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index cd893b5..f3b8fa1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -837,7 +837,6 @@ void __noreturn do_exit(long code)
 	 * Make sure we are holding no locks:
 	 */
 	debug_check_no_locks_held();
-	futex_exit_done(tsk);
 
 	if (tsk->io_context)
 		exit_io_context(tsk);
diff --git a/kernel/futex.c b/kernel/futex.c
index 909e4d3..426dd71 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3682,6 +3682,7 @@ void futex_exec_release(struct task_struct *tsk)
 void futex_exit_release(struct task_struct *tsk)
 {
 	futex_exec_release(tsk);
+	futex_exit_done(tsk);
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
