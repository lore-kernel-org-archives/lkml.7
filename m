Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26BFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804F9206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T3QzJxwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLKAKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:10:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLKAKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2EenbOOaUoIqSXyQPJU1LzR0b/wkoNh3KS41jTLA5+0=; b=T3QzJxwa52kLG/l029a83NgTV
        x3GHdtKbJZuEJSSjobKgZZ0Ec1gxsBF3D+63VDtaG0bRovjqCMUjfoIjz4gSioTOS7YJN2PkPT0ln
        sbrD5JAqDdgTWn7aasAIVUbxtO2r5fl6XkDsuunXArgro6WM4ZLzJAnaPMtDZvKNjek+NINHuxVNT
        prceWWTTrKyJbBV5YRUl74f98b40XC2o0TNmhC0w5ae0WPvQVoyvfea13TkyXIdwgfA4jtDUlhA0c
        RmxDmC8hg+UUGcEfAXGbE68Dl0rXueTw6B6zJIOQ5nVoOBMC9k0weVIfFE0z9VDiw8aE39BtS73QY
        K1+hF2zAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iepZb-0005gU-HV; Wed, 11 Dec 2019 00:09:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43273300596;
        Wed, 11 Dec 2019 01:08:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3DD32057730F; Wed, 11 Dec 2019 01:09:43 +0100 (CET)
Date:   Wed, 11 Dec 2019 01:09:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -tip 1/2] x86/alternative: Sync bp_patching update for
 avoiding NULL pointer exception
Message-ID: <20191211000943.GG2871@hirez.programming.kicks-ass.net>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
 <157483421229.25881.15314414408559963162.stgit@devnote2>
 <20191209143940.GI2810@hirez.programming.kicks-ass.net>
 <20191211014401.2f0c27f259a83d1f32aa6f2e@kernel.org>
 <20191210173209.GP2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210173209.GP2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 06:32:09PM +0100, Peter Zijlstra wrote:

> I feel that is actually more complicated...  Let me try to see if I can
> simplify things.

How is this then?

---
 arch/x86/kernel/alternative.c | 84 +++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 30e86730655c..34360ca301a2 100644
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
