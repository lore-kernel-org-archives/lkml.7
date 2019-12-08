Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6792C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DB520637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 15:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfLHPAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 10:00:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36774 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfLHO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy16-0000SW-Ui; Sun, 08 Dec 2019 15:58:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9D2601C2887;
        Sun,  8 Dec 2019 15:58:31 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:31 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, xtensa: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xtensa@linux-xtensa.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-21-bigeasy@linutronix.de>
References: <20191015191821.11479-21-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711152.21853.11757251223055370019.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     6c5260d73d2b723f072c312eb80ef83711b4e166
Gitweb:        https://git.kernel.org/tip/6c5260d73d2b723f072c312eb80ef83711b4e166
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:07 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:35 +01:00

sched/rt, xtensa: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION. Add PREEMPT_RT
output to die().

[bigeasy: +traps.c]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-xtensa@linux-xtensa.org
Link: https://lore.kernel.org/r/20191015191821.11479-21-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/xtensa/kernel/entry.S | 2 +-
 arch/xtensa/kernel/traps.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index be89780..2c9e485 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -520,7 +520,7 @@ common_exception_return:
 	call4	schedule	# void schedule (void)
 	j	1b
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 6:
 	_bbci.l	a4, TIF_NEED_RESCHED, 4f
 
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 87bd68d..0976e27 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -519,12 +519,15 @@ DEFINE_SPINLOCK(die_lock);
 void die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
+	const char *pr = "";
+
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	console_verbose();
 	spin_lock_irq(&die_lock);
 
-	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter,
-		IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "");
+	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter, pr);
 	show_regs(regs);
 	if (!user_mode(regs))
 		show_stack(NULL, (unsigned long*)regs->areg[1]);
