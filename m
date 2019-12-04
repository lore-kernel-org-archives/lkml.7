Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA125C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E352068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLDIeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfLDIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6J-0005Fq-GE; Wed, 04 Dec 2019 09:33:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 220FB1C2658;
        Wed,  4 Dec 2019 09:33:35 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/kprobe: Add comments to arch_{,un}optimize_kprobes()
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132458.401696663@infradead.org>
References: <20191111132458.401696663@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841504.21853.14009303480737761897.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     f2cb4f95b7571f2bebcf226cd92b448fd58950ca
Gitweb:        https://git.kernel.org/tip/f2cb4f95b7571f2bebcf226cd92b448fd58950ca
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 11 Nov 2019 14:02:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:25 +01:00

x86/kprobe: Add comments to arch_{,un}optimize_kprobes()

Add a few words describing how it is safe to overwrite the 4 bytes
after a kprobe. In specific it is possible the JMP.d32 required for
the optimized kprobe overwrites multiple instructions.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132458.401696663@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 26e0d6c..3f45b5c 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -414,8 +414,12 @@ err:
 }
 
 /*
- * Replace breakpoints (int3) with relative jumps.
+ * Replace breakpoints (INT3) with relative jumps (JMP.d32).
  * Caller must call with locking kprobe_mutex and text_mutex.
+ *
+ * The caller will have installed a regular kprobe and after that issued
+ * syncrhonize_rcu_tasks(), this ensures that the instruction(s) that live in
+ * the 4 bytes after the INT3 are unused and can now be overwritten.
  */
 void arch_optimize_kprobes(struct list_head *oplist)
 {
@@ -441,7 +445,13 @@ void arch_optimize_kprobes(struct list_head *oplist)
 	}
 }
 
-/* Replace a relative jump with a breakpoint (int3).  */
+/*
+ * Replace a relative jump (JMP.d32) with a breakpoint (INT3).
+ *
+ * After that, we can restore the 4 bytes after the INT3 to undo what
+ * arch_optimize_kprobes() scribbled. This is safe since those bytes will be
+ * unused once the INT3 lands.
+ */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	arch_arm_kprobe(&op->kp);
