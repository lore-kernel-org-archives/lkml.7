Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B2FC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092B5217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbfKFXIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:08:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732779AbfKFXIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:13 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPL-0004jT-R3; Thu, 07 Nov 2019 00:08:12 +0100
Message-Id: <20191106224556.439511191@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:40 +0100
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
Subject: [patch 06/12] futex: Set task::futex state to DEAD right after
 handling futex exit
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting task::futex_state in do_exit() is rather arbitrarily placed for no
reason. Move it into the futex code.

Note, this is only done for the exit cleanup as the exec cleanup cannot set
the state to FUTEX_STATE_DEAD because the task struct is still in active
use.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/exit.c  |    1 -
 kernel/futex.c |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -837,7 +837,6 @@ void __noreturn do_exit(long code)
 	 * Make sure we are holding no locks:
 	 */
 	debug_check_no_locks_held();
-	futex_exit_done(tsk);
 
 	if (tsk->io_context)
 		exit_io_context(tsk);
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3682,6 +3682,7 @@ void futex_exec_release(struct task_stru
 void futex_exit_release(struct task_struct *tsk)
 {
 	futex_exec_release(tsk);
+	futex_exit_done(tsk);
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,


