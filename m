Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5179AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D48206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K753bTah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404534AbfFKMJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:09:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53788 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfFKMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iADvzNHxrj3aEEZQS4BDjuzQUDhxOJwFwSW7vltHCTI=; b=K753bTahcHF+Rs2Eljx/ON3D5
        qtvxcR8shCT1oenJwJac7IcRvDseDZxbjKGUqKFXIamb/iwBJ8Rkiio1UHxUCuJwUACaAcQijpxhA
        oly/8SNCjSzJAuIk7dKxFJvMqmjvbzum7sWcvAfT0xXoabpPvkooZKmVWGtofOlfZAR7xE4S+fBaW
        6FqyRpdqlC/ik6x7z5oI+icDWqtyZrrdCv3Hm6fMxLZY7pmUcU9WM4PFAvtOKIIx8gYkjVhPawB6s
        jcK6Vfbl9bJO5oYrDC3rISd/wNNaU1tRI2quNbbVxcn7z2mU26AH6hwVne/G/8FspPHyESmf1X2Xo
        wKiegod2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hafZu-0004Le-2U; Tue, 11 Jun 2019 12:08:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 061F32022711C; Tue, 11 Jun 2019 14:08:35 +0200 (CEST)
Date:   Tue, 11 Jun 2019 14:08:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190611120834.GG3463@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
 <20190611080307.GN3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611080307.GN3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:03:07AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 07, 2019 at 11:10:19AM -0700, Andy Lutomirski wrote:

> > I am surely missing some kprobe context, but is it really safe to use
> > this mechanism to replace more than one instruction?
> 
> I'm not entirely up-to-scratch here, so Masami, please correct me if I'm
> wrong.
> 
> So what happens is that arch_prepare_optimized_kprobe() <-
> copy_optimized_instructions() copies however much of the instruction
> stream is required such that we can overwrite the instruction at @addr
> with a 5 byte jump.
> 
> arch_optimize_kprobe() then does the text_poke_bp() that replaces the
> instruction @addr with int3, copies the rel jump address and overwrites
> the int3 with jmp.
> 
> And I'm thinking the problem is with something like:
> 
> @addr: nop nop nop nop nop
> 
> We copy out the nops into the trampoline, overwrite the first nop with
> an INT3, overwrite the remaining nops with the rel addr, but oops,
> another CPU can still be executing one of those NOPs, right?
> 
> I'm thinking we could fix this by first writing INT3 into all relevant
> instructions, which is going to be messy, given the current code base.

Maybe not that bad; how's something like this?

(completely untested)

---
 arch/x86/kernel/alternative.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0d57015114e7..8f643dabea72 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -24,6 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
+#include <asm/insn.h>
 
 int __read_mostly alternatives_patched;
 
@@ -849,6 +850,7 @@ static void do_sync_core(void *info)
 
 static bool bp_patching_in_progress;
 static void *bp_int3_handler, *bp_int3_addr;
+static unsigned int bp_int3_length;
 
 int poke_int3_handler(struct pt_regs *regs)
 {
@@ -867,7 +869,11 @@ int poke_int3_handler(struct pt_regs *regs)
 	if (likely(!bp_patching_in_progress))
 		return 0;
 
-	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
+	if (user_mode(regs))
+		return 0;
+
+	if (regs->ip < (unsigned long)bp_int3_addr ||
+	    regs->ip >= (unsigned long)bp_int3_addr + bp_int3_length)
 		return 0;
 
 	/* set up the specified breakpoint handler */
@@ -900,9 +906,12 @@ NOKPROBE_SYMBOL(poke_int3_handler);
 void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 {
 	unsigned char int3 = 0xcc;
+	void *kaddr = addr;
+	struct insn insn;
 
 	bp_int3_handler = handler;
 	bp_int3_addr = (u8 *)addr + sizeof(int3);
+	bp_int3_length = len - sizeof(int3);
 	bp_patching_in_progress = true;
 
 	lockdep_assert_held(&text_mutex);
@@ -913,7 +922,14 @@ void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 	 */
 	smp_wmb();
 
-	text_poke(addr, &int3, sizeof(int3));
+	do {
+		kernel_insn_init(&insn, kaddr, MAX_INSN_SIZE);
+		insn_get_length(&insn);
+
+		text_poke(kaddr, &int3, sizeof(int3));
+
+		kaddr += insn.length;
+	} while (kaddr < addr + len);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
