Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C37C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C5206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLDIds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:33:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDIdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6J-0005Fk-0b; Wed, 04 Dec 2019 09:33:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 961681C2655;
        Wed,  4 Dec 2019 09:33:34 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:34 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] kprobes: Set unoptimized flag after unoptimizing code
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157483422375.25881.13508326028469515760.stgit@devnote2>
References: <157483422375.25881.13508326028469515760.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157544841446.21853.5014344352579147600.tip-bot2@tip-bot2>
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

Commit-ID:     f66c0447cca1281116224d474cdb37d6a18e4b5b
Gitweb:        https://git.kernel.org/tip/f66c0447cca1281116224d474cdb37d6a18e4b5b
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 27 Nov 2019 14:57:04 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:25 +01:00

kprobes: Set unoptimized flag after unoptimizing code

Set the unoptimized flag after confirming the code is completely
unoptimized. Without this fix, when a kprobe hits the intermediate
modified instruction (the first byte is replaced by an INT3, but
later bytes can still be a jump address operand) while unoptimizing,
it can return to the middle byte of the modified code, which causes
an invalid instruction exception in the kernel.

Usually, this is a rare case, but if we put a probe on the function
call while text patching, it always causes a kernel panic as below:

 # echo p text_poke+5 > kprobe_events
 # echo 1 > events/kprobes/enable
 # echo 0 > events/kprobes/enable

invalid opcode: 0000 [#1] PREEMPT SMP PTI
 RIP: 0010:text_poke+0x9/0x50
 Call Trace:
  arch_unoptimize_kprobe+0x22/0x28
  arch_unoptimize_kprobes+0x39/0x87
  kprobe_optimizer+0x6e/0x290
  process_one_work+0x2a0/0x610
  worker_thread+0x28/0x3d0
  ? process_one_work+0x610/0x610
  kthread+0x10d/0x130
  ? kthread_park+0x80/0x80
  ret_from_fork+0x3a/0x50

text_poke() is used for patching the code in optprobes.

This can happen even if we blacklist text_poke() and other functions,
because there is a small time window during which we show the intermediate
code to other CPUs.

 [ mingo: Edited the changelog. ]

Tested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Fixes: 6274de4984a6 ("kprobes: Support delayed unoptimizing")
Link: https://lkml.kernel.org/r/157483422375.25881.13508326028469515760.stgit@devnote2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 53534aa..34e28b2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -510,6 +510,8 @@ static void do_unoptimize_kprobes(void)
 	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 	/* Loop free_list for disarming */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
+		/* Switching from detour code to origin */
+		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 		/* Disarm probes if marked disabled */
 		if (kprobe_disabled(&op->kp))
 			arch_disarm_kprobe(&op->kp);
@@ -649,6 +651,7 @@ static void force_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	lockdep_assert_cpus_held();
 	arch_unoptimize_kprobe(op);
+	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 	if (kprobe_disabled(&op->kp))
 		arch_disarm_kprobe(&op->kp);
 }
@@ -676,7 +679,6 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 		return;
 	}
 
-	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 	if (!list_empty(&op->list)) {
 		/* Dequeue from the optimization queue */
 		list_del_init(&op->list);
