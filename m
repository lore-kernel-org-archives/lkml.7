Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95F5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F54206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLDIed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56433 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLDId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6L-0005GS-A6; Wed, 04 Dec 2019 09:33:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E4AA11C2658;
        Wed,  4 Dec 2019 09:33:35 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/kprobes: Fix ordering while text-patching
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132458.162172862@infradead.org>
References: <20191111132458.162172862@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841582.21853.10575755111378317696.tip-bot2@tip-bot2>
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

Commit-ID:     5c02ece81848db29b411139cc923d66050a6a40c
Gitweb:        https://git.kernel.org/tip/5c02ece81848db29b411139cc923d66050a6a40c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Oct 2019 21:15:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:24 +01:00

x86/kprobes: Fix ordering while text-patching

Kprobes does something like:

register:
	arch_arm_kprobe()
	  text_poke(INT3)
          /* guarantees nothing, INT3 will become visible at some point, maybe */

        kprobe_optimizer()
	  /* guarantees the bytes after INT3 are unused */
	  synchronize_rcu_tasks();
	  text_poke_bp(JMP32);
	  /* implies IPI-sync, kprobe really is enabled */

unregister:
	__disarm_kprobe()
	  unoptimize_kprobe()
	    text_poke_bp(INT3 + tail);
	    /* implies IPI-sync, so tail is guaranteed visible */
          arch_disarm_kprobe()
            text_poke(old);
	    /* guarantees nothing, old will maybe become visible */

	synchronize_rcu()

        free-stuff

Now the problem is that on register, the synchronize_rcu_tasks() does
not imply sufficient to guarantee all CPUs have already observed INT3
(although in practice this is exceedingly unlikely not to have
happened) (similar to how MEMBARRIER_CMD_PRIVATE_EXPEDITED does not
imply MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).

Worse, even if it did, we'd have to do 2 synchronize calls to provide
the guarantee we're looking for, the first to ensure INT3 is visible,
the second to guarantee nobody is then still using the instruction
bytes after INT3.

Similar on unregister; the synchronize_rcu() between
__unregister_kprobe_top() and __unregister_kprobe_bottom() does not
guarantee all CPUs are free of the INT3 (and observe the old text).

Therefore, sprinkle some IPI-sync love around. This guarantees that
all CPUs agree on the text and RCU once again provides the required
guaranteed.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132458.162172862@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        | 11 ++++++++---
 arch/x86/kernel/kprobes/core.c       |  2 ++
 arch/x86/kernel/kprobes/opt.c        | 12 ++++--------
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 4c09f42..67315fa 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -42,6 +42,7 @@ extern void text_poke_early(void *addr, const void *opcode, size_t len);
  * an inconsistent instruction while you patch.
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
+extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 526cc5f..6455902 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -936,6 +936,11 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
+void text_poke_sync(void)
+{
+	on_each_cpu(do_sync_core, NULL, 1);
+}
+
 struct text_poke_loc {
 	s32 rel_addr; /* addr := _stext + rel_addr */
 	s32 rel32;
@@ -1085,7 +1090,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	for (i = 0; i < nr_entries; i++)
 		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
 
-	on_each_cpu(do_sync_core, NULL, 1);
+	text_poke_sync();
 
 	/*
 	 * Second step: update all but the first byte of the patched range.
@@ -1107,7 +1112,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		 * not necessary and we'd be safe even without it. But
 		 * better safe than sorry (plus there's not only Intel).
 		 */
-		on_each_cpu(do_sync_core, NULL, 1);
+		text_poke_sync();
 	}
 
 	/*
@@ -1123,7 +1128,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	}
 
 	if (do_sync)
-		on_each_cpu(do_sync_core, NULL, 1);
+		text_poke_sync();
 
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 697c059..579d30e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -502,11 +502,13 @@ int arch_prepare_kprobe(struct kprobe *p)
 void arch_arm_kprobe(struct kprobe *p)
 {
 	text_poke(p->addr, ((unsigned char []){INT3_INSN_OPCODE}), 1);
+	text_poke_sync();
 }
 
 void arch_disarm_kprobe(struct kprobe *p)
 {
 	text_poke(p->addr, &p->opcode, 1);
+	text_poke_sync();
 }
 
 void arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 0d9ea48..26e0d6c 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -444,14 +444,10 @@ void arch_optimize_kprobes(struct list_head *oplist)
 /* Replace a relative jump with a breakpoint (int3).  */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
-	u8 insn_buff[JMP32_INSN_SIZE];
-
-	/* Set int3 to first byte for kprobes */
-	insn_buff[0] = INT3_INSN_OPCODE;
-	memcpy(insn_buff + 1, op->optinsn.copied_insn, DISP32_SIZE);
-
-	text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE,
-		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
+	arch_arm_kprobe(&op->kp);
+	text_poke(op->kp.addr + INT3_INSN_SIZE,
+		  op->optinsn.copied_insn, DISP32_SIZE);
+	text_poke_sync();
 }
 
 /*
