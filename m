Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC89217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfI0IKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:10:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45160 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfI0IKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:10:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKs-0005aX-2A; Fri, 27 Sep 2019 10:10:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 863DE1C0740;
        Fri, 27 Sep 2019 10:10:41 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:41 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix preempt_schedule() interrupt
 return comment
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190923143620.29334-2-valentin.schneider@arm.com>
References: <20190923143620.29334-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <156957184150.9866.17072165851925129764.tip-bot2@tip-bot2>
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

Commit-ID:     a49b4f4012ef233143c5f7ce44f97851e54d5ef9
Gitweb:        https://git.kernel.org/tip/a49b4f4012ef233143c5f7ce44f97851e54d5ef9
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 23 Sep 2019 15:36:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:32 +02:00

sched/core: Fix preempt_schedule() interrupt return comment

preempt_schedule_irq() is the one that should be called on return from
interrupt, clean up the comment to avoid any ambiguity.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-riscv@lists.infradead.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Link: https://lkml.kernel.org/r/20190923143620.29334-2-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83ea23e..00ef44c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4218,9 +4218,8 @@ static void __sched notrace preempt_schedule_common(void)
 
 #ifdef CONFIG_PREEMPTION
 /*
- * this is the entry point to schedule() from in-kernel preemption
- * off of preempt_enable. Kernel preemptions off return from interrupt
- * occur there and call schedule directly.
+ * This is the entry point to schedule() from in-kernel preemption
+ * off of preempt_enable.
  */
 asmlinkage __visible void __sched notrace preempt_schedule(void)
 {
@@ -4291,7 +4290,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 #endif /* CONFIG_PREEMPTION */
 
 /*
- * this is the entry point to schedule() from kernel preemption
+ * This is the entry point to schedule() from kernel preemption
  * off of irq context.
  * Note, that this is called and return with irqs disabled. This will
  * protect us against recursive calling from irq.
