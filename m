Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319BEC2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F12C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLYKjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40589 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfLYKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44B-00088W-U1; Wed, 25 Dec 2019 11:39:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8B0CB1C2B1E;
        Wed, 25 Dec 2019 11:38:59 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:38:59 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/alternatives: Implement a better
 poke_int3_handler() completion scheme
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157727033938.30329.14333219738427372011.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1f676247f36a4bdea134de5e8bc5041db9678c4e
Gitweb:        https://git.kernel.org/tip/1f676247f36a4bdea134de5e8bc5041db9678c4e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 11 Dec 2019 01:25:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:43:29 +01:00

x86/alternatives: Implement a better poke_int3_handler() completion scheme

Commit:

  285a54efe386 ("x86/alternatives: Sync bp_patching update for avoiding NULL pointer exception")

added an additional text_poke_sync() IPI to text_poke_bp_batch() to
handle the rare case where another CPU is still inside an INT3 handler
while we clear the global state.

Instead of spraying IPIs around, count the active INT3 handlers and
wait for them to go away before proceeding to clear/reuse the data.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 84 +++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 30e8673..34360ca 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -948,10 +948,29 @@ struct text_poke_loc {
 	const u8 text[POKE_MAX_OPCODE_SIZE];
 };
 
-static struct bp_patching_desc {
+struct bp_patching_desc {
 	struct text_poke_loc *vec;
 	int nr_entries;
-} bp_patching;
+	atomic_t refs;
+};
+
+static struct bp_patching_desc *bp_desc;
+
+static inline struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
+{
+	struct bp_patching_desc *desc = READ_ONCE(*descp); /* rcu_dereference */
+
+	if (!desc || !atomic_inc_not_zero(&desc->refs))
+		return NULL;
+
+	return desc;
+}
+
+static inline void put_desc(struct bp_patching_desc *desc)
+{
+	smp_mb__before_atomic();
+	atomic_dec(&desc->refs);
+}
 
 static inline void *text_poke_addr(struct text_poke_loc *tp)
 {
@@ -972,26 +991,26 @@ NOKPROBE_SYMBOL(patch_cmp);
 
 int notrace poke_int3_handler(struct pt_regs *regs)
 {
+	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
+	int len, ret = 0;
 	void *ip;
-	int len;
+
+	if (user_mode(regs))
+		return 0;
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
-	 * bp_patching.nr_entries.
+	 * bp_desc:
 	 *
-	 *	nr_entries != 0			INT3
+	 *	bp_desc = desc			INT3
 	 *	WMB				RMB
-	 *	write INT3			if (nr_entries)
-	 *
-	 * Idem for other elements in bp_patching.
+	 *	write INT3			if (desc)
 	 */
 	smp_rmb();
 
-	if (likely(!bp_patching.nr_entries))
-		return 0;
-
-	if (user_mode(regs))
+	desc = try_get_desc(&bp_desc);
+	if (!desc)
 		return 0;
 
 	/*
@@ -1002,16 +1021,16 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 	/*
 	 * Skip the binary search if there is a single member in the vector.
 	 */
-	if (unlikely(bp_patching.nr_entries > 1)) {
-		tp = bsearch(ip, bp_patching.vec, bp_patching.nr_entries,
+	if (unlikely(desc->nr_entries > 1)) {
+		tp = bsearch(ip, desc->vec, desc->nr_entries,
 			     sizeof(struct text_poke_loc),
 			     patch_cmp);
 		if (!tp)
-			return 0;
+			goto out_put;
 	} else {
-		tp = bp_patching.vec;
+		tp = desc->vec;
 		if (text_poke_addr(tp) != ip)
-			return 0;
+			goto out_put;
 	}
 
 	len = text_opcode_size(tp->opcode);
@@ -1023,7 +1042,7 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 		 * Someone poked an explicit INT3, they'll want to handle it,
 		 * do not consume.
 		 */
-		return 0;
+		goto out_put;
 
 	case CALL_INSN_OPCODE:
 		int3_emulate_call(regs, (long)ip + tp->rel32);
@@ -1038,7 +1057,11 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 		BUG();
 	}
 
-	return 1;
+	ret = 1;
+
+out_put:
+	put_desc(desc);
+	return ret;
 }
 NOKPROBE_SYMBOL(poke_int3_handler);
 
@@ -1069,14 +1092,18 @@ static int tp_vec_nr;
  */
 static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
+	struct bp_patching_desc desc = {
+		.vec = tp,
+		.nr_entries = nr_entries,
+		.refs = ATOMIC_INIT(1),
+	};
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
 	int do_sync;
 
 	lockdep_assert_held(&text_mutex);
 
-	bp_patching.vec = tp;
-	bp_patching.nr_entries = nr_entries;
+	smp_store_release(&bp_desc, &desc); /* rcu_assign_pointer */
 
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
@@ -1131,17 +1158,12 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		text_poke_sync();
 
 	/*
-	 * sync_core() implies an smp_mb() and orders this store against
-	 * the writing of the new instruction.
+	 * Remove and synchronize_rcu(), except we have a very primitive
+	 * refcount based completion.
 	 */
-	bp_patching.nr_entries = 0;
-	/*
-	 * This sync_core () call ensures that all INT3 handlers in progress
-	 * have finished. This allows poke_int3_handler() after this to
-	 * avoid touching bp_paching.vec by checking nr_entries == 0.
-	 */
-	text_poke_sync();
-	bp_patching.vec = NULL;
+	WRITE_ONCE(bp_desc, NULL); /* RCU_INIT_POINTER */
+	if (!atomic_dec_and_test(&desc.refs))
+		atomic_cond_read_acquire(&desc.refs, !VAL);
 }
 
 void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
