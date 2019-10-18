Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4368CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854DF222CB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mgdk6gRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504837AbfJRHv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34350 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504800AbfJRHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KKIIY0TEskL45XyjUD7Tj4hwzU8zlqgR+s91aX4oRZ8=; b=mgdk6gRlcwnFlnAy3c8NGmPBx9
        PpjrXZj5AOt80cYoyckPHOgYjAsJlEHpdYiaJmqldwr75bmel8YwqdAsdyKnHnXy2x39s/hLVm2K3
        muj9Qg+qP480suqL4EOAlxtATHPJT1t7ZksFeW9c/yn8oumbDwd0wi4K/6awoPNDN+z+abI/ufrC+
        g+ymCnSkPSrAgpNTdrbTEmFTUg/RKXBcoPSsjGUngqUzYBFuHcOFViwCnvZeWVDSAX3XBSUvAm8i+
        32mBVS8N7rMcxvEDLMkUHtB7RT9BI84O3Mm0VTT4DxDFX+yv+lgEWqLviOLtx0u3zq7lxlWJmFrHM
        A6K8Bl/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2d-0007my-Oc; Fri, 18 Oct 2019 07:51:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23DD8306BC0;
        Fri, 18 Oct 2019 09:50:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5D89F2B178118; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.629386219@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, paulmck@kernel.org,
        mathieu.desnoyers@efficios.com
Subject: [PATCH v4 12/16] x86/kprobes: Fix ordering
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobes does something like:

register:
	arch_arm_kprobe()
	  text_poke(INT3)
          /* guarantees nothing, INT3 will become visible at some point, maybe */

        kprobe_optimizer()
	  /* guarantees the bytes after INT3 are unused */
	  syncrhonize_rcu_tasks();
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
(although in practise this is exceedingly unlikely not to have
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

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: hpa@zytor.com
Cc: paulmck@kernel.org
Cc: mathieu.desnoyers@efficios.com
---
 arch/x86/include/asm/text-patching.h |    1 +
 arch/x86/kernel/alternative.c        |   11 ++++++++---
 arch/x86/kernel/kprobes/core.c       |    2 ++
 arch/x86/kernel/kprobes/opt.c        |   12 ++++--------
 4 files changed, 15 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -42,6 +42,7 @@ extern void text_poke_early(void *addr,
  * an inconsistent instruction while you patch.
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
+extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
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
@@ -1085,7 +1090,7 @@ static void text_poke_bp_batch(struct te
 	for (i = 0; i < nr_entries; i++)
 		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
 
-	on_each_cpu(do_sync_core, NULL, 1);
+	text_poke_sync();
 
 	/*
 	 * Second step: update all but the first byte of the patched range.
@@ -1107,7 +1112,7 @@ static void text_poke_bp_batch(struct te
 		 * not necessary and we'd be safe even without it. But
 		 * better safe than sorry (plus there's not only Intel).
 		 */
-		on_each_cpu(do_sync_core, NULL, 1);
+		text_poke_sync();
 	}
 
 	/*
@@ -1123,7 +1128,7 @@ static void text_poke_bp_batch(struct te
 	}
 
 	if (do_sync)
-		on_each_cpu(do_sync_core, NULL, 1);
+		text_poke_sync();
 
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -502,11 +502,13 @@ int arch_prepare_kprobe(struct kprobe *p
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
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -444,14 +444,10 @@ void arch_optimize_kprobes(struct list_h
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


