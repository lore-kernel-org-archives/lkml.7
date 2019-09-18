Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66875C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A98D218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfIRQjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:39:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:60564 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfIRQjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:39:47 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x8IGdKX3020595;
        Wed, 18 Sep 2019 11:39:20 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x8IGdJjs020591;
        Wed, 18 Sep 2019 11:39:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 18 Sep 2019 11:39:19 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
Message-ID: <20190918163919.GH9749@gate.crashing.org>
References: <d0b002c96cfc069a1bc7bafcac28defe5d7d3643.1568821668.git.christophe.leroy@c-s.fr> <5fb4aedadbd28b9849cf2fabe13392fb3b5cd3ed.1568821668.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fb4aedadbd28b9849cf2fabe13392fb3b5cd3ed.1568821668.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Wed, Sep 18, 2019 at 03:48:20PM +0000, Christophe Leroy wrote:
> call_do_irq() and call_do_softirq() are quite similar on PPC32 and
> PPC64 and are simple enough to be worth inlining.
> 
> Inlining them avoids an mflr/mtlr pair plus a save/reload on stack.

But you hardcode the calling sequence in inline asm, which for various
reasons is not a great idea.

> +static inline void call_do_irq(struct pt_regs *regs, void *sp)
> +{
> +	register unsigned long r3 asm("r3") = (unsigned long)regs;
> +
> +	asm volatile(
> +		"	"PPC_STLU"	1, %2(%1);\n"
> +		"	mr		1, %1;\n"
> +		"	bl		%3;\n"
> +		"	"PPC_LL"	1, 0(1);\n" : "+r"(r3) :
> +		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_irq) :
> +		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
> +		"r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
> +}

I realise the original code had this...  Loading the old stack pointer
value back from the stack creates a bottleneck (via the store->load
forwarding it requires).  It could just use
  addi 1,1,-(%2)
here, which can also be written as
  addi 1,1,%n2
(that is portable to all architectures btw).


Please write the  "+r"(r3)  on the next line?  Not on the same line as
the multi-line template.  This make things more readable.


I don't know if using functions as an "i" works properly...  It probably
does, it's just not something that you see often :-)


What about r2?  Various ABIs handle that differently.  This might make
it impossible to share implementation between 32-bit and 64-bit for this.
But we could add it to the clobber list worst case, that will always work.


So anyway, it looks to me like it will work.  Nice cleanup.  Would be
better if you could do the call to __do_irq from C code, but maybe we
cannot have everything ;-)

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
