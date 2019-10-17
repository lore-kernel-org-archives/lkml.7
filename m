Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8300ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729E921835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6caHkzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394628AbfJQT7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:59:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394480AbfJQT7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rWhtcGMmlVmZEqh7YsEQAvLzMYMmhzfOQOJEuSnktdg=; b=i6caHkzY2WGLuYTJfLU+G/C1+
        cbTOf97Vq4yUKGQnMV9PymjC3ev9BClclXhiKJlRyOVa5Pcm/F9yX6gVZ5o4plrCA3SHjL9+n0LPU
        gmVEl4oOKvMOrm2pLFe0uFAvxzCInGukzHADMSUrkUkQz9nJcG/5qDJUQWWRiH9d8zAInI1bWHyuk
        VyrMY/K1JgxyYVtLn1c7Hr51oN0OMuy6l6non5X8xw2Rz3gxNG/YwMc6pQKrVLx9YzMsJpRbB3mc7
        XeW9EqE+BdRfohNkwqv9c+N4PYQrhLeCK7FcLho0RmXKSP99G5r8v0IVdDvluYandPyBRVMTM6v1T
        /1aIr9D3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLBvO-0003p9-3w; Thu, 17 Oct 2019 19:59:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54C3A980D8F; Thu, 17 Oct 2019 21:59:03 +0200 (CEST)
Date:   Thu, 17 Oct 2019 21:59:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        rostedt <rostedt@goodmis.org>, bristot <bristot@redhat.com>,
        paulmck <paulmck@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: x86/kprobes bug? (was: [PATCH 1/3] x86/alternatives: Teach
 text_poke_bp() to emulate instructions)
Message-ID: <20191017195903.GG22902@worktop.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.053490768@infradead.org>
 <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
 <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
 <20191003110106.GI4581@hirez.programming.kicks-ass.net>
 <20191004224540.766dc0fd824bcd5b8baa2f4c@kernel.org>
 <20191009130754.GL2311@hirez.programming.kicks-ass.net>
 <968659278.8871.1570631195078.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968659278.8871.1570631195078.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:26:35AM -0400, Mathieu Desnoyers wrote:

> Yes, I think you are right on both counts. synchronize_rcu() is not enough
> to guarantee that other cores have observed the required core serializing
> instructions.

*phew*, not crazy then ;-)

> I would also be more comfortable if we ensure core serialization for all
> cores after arming the kprobe with text_poke() (before doing the text_poke_bp
> to JMP32), and after the text_poke(old) in DISARM (before freeing, and possibly
> re-using, the memory).
> 
> I think originally it might have been OK to text_poke the INT3 without core serialization
> before introducing optimized kprobes, since it would only switch back and forth between
> the original instruction { 0xAA, 0xBB, 0xCC, ... } and the breakpoint
> { INT3, 0xBB, 0xCC, ... }. But now that the optimized kprobes are adding
> additional states, we end up requiring core serialization in case a core
> observes the original instruction and the optimized kprobes jump without
> observing the INT3.
> 
> The follow up patch you propose at https://lore.kernel.org/lkml/20191009132844.GG2359@hirez.programming.kicks-ass.net/
> makes sense.

Thanks; full patch with Changelog below.

> Now depending on whether we care mostly about speed or robustness in this
> code, there is a small tweak we could do. The approach you propose aims for
> robustness by issuing a text_poke_sync() after each ARM/DISARM, which
> effectively adds IPIs to all cores even in !opt cases. If we aim for speed
> in the !opt case, we might want to move the text_poke_sync() within the
> if (opt) branches so it only IPIs if the probe happens to be optimized.
> 
> In my personal opinion, I would prefer simple and robust over clever and fast
> for inserting kprobes, but you guys know more about the performance trade-offs
> than I do.

I chose for this variant because it also provides the guarantee that the
kprobe is visible/active the moment we return from installing it. I
would personally find it really confusing to have to wait $random period
before being able to observe the probe on all CPUs.


---
Subject: x86/kprobes: Fix ordering
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Oct  9 21:15:28 CEST 2019

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

