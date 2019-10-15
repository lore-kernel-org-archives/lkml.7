Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B4ECE595
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05DE2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbfJOTSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:18:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45653 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389386AbfJOTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:42 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL9-00067i-MN; Tue, 15 Oct 2019 21:18:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 20/34] xtensa: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:07 +0200
Message-Id: <20191015191821.11479-21-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION. Add PREEMPT_RT
output to die().

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +traps.c]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/xtensa/kernel/entry.S | 2 +-
 arch/xtensa/kernel/traps.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 9e3676879168a..a6434813df6c8 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -520,7 +520,7 @@ ENTRY(kernel_exception)
 	call4	schedule	# void schedule (void)
 	j	1b
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 6:
 	_bbci.l	a4, TIF_NEED_RESCHED, 4f
=20
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 4a6c495ce9b6d..2e7cf56412a05 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -524,12 +524,15 @@ DEFINE_SPINLOCK(die_lock);
 void die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
+	const char *pr =3D "";
+
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		pr =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
=20
 	console_verbose();
 	spin_lock_irq(&die_lock);
=20
-	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter,
-		IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "");
+	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter, pr);
 	show_regs(regs);
 	if (!user_mode(regs))
 		show_stack(NULL, (unsigned long*)regs->areg[1]);
--=20
2.23.0

