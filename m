Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37490C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE0B2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392221AbfISTF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:05:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:55358 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392208AbfISTFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:05:55 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x8JJ5Qie013352;
        Thu, 19 Sep 2019 14:05:26 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x8JJ5OTA013351;
        Thu, 19 Sep 2019 14:05:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 19 Sep 2019 14:05:24 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
Message-ID: <20190919190524.GK9749@gate.crashing.org>
References: <d0b002c96cfc069a1bc7bafcac28defe5d7d3643.1568821668.git.christophe.leroy@c-s.fr> <5fb4aedadbd28b9849cf2fabe13392fb3b5cd3ed.1568821668.git.christophe.leroy@c-s.fr> <20190918163919.GH9749@gate.crashing.org> <a7a46d1b-873c-1267-b8ca-615a7fabfd6b@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7a46d1b-873c-1267-b8ca-615a7fabfd6b@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 07:23:18AM +0200, Christophe Leroy wrote:
> Le 18/09/2019 à 18:39, Segher Boessenkool a écrit :
> >I realise the original code had this...  Loading the old stack pointer
> >value back from the stack creates a bottleneck (via the store->load
> >forwarding it requires).  It could just use
> >   addi 1,1,-(%2)
> >here, which can also be written as
> >   addi 1,1,%n2
> >(that is portable to all architectures btw).
> 
> No, we switched stack before the bl call, we replaced r1 by r3 after 
> saving r1 into r3 stack. Now we have to restore the original r1.

Yeah wow, I missed that once again.  Whoops.

Add a comment for this?  Just before the asm maybe, "we temporarily switch
r1 to a different stack" or something.

> >What about r2?  Various ABIs handle that differently.  This might make
> >it impossible to share implementation between 32-bit and 64-bit for this.
> >But we could add it to the clobber list worst case, that will always work.
> 
> Isn't r2 non-volatile on all ABIs ?

It is not.  On ELFv2 it is (or will be) optionally volatile, but like on
ELFv1 it already has special rules as well: the linker is responsible for
restoring it if it is non-volatile, and for that there needs to be a nop
after the bl, etc.

But the existing code was in a similar situation and we survived that, I
think we should be fine this way too.  And it won't be too hard to change
again if needed.

> >So anyway, it looks to me like it will work.  Nice cleanup.  Would be
> >better if you could do the call to __do_irq from C code, but maybe we
> >cannot have everything ;-)
> 
> sparc do it the following way, is there no risk that GCC adds unwanted 
> code inbetween that is not aware there the stack pointer has changed ?
> 
> void do_softirq_own_stack(void)
> {
> 	void *orig_sp, *sp = softirq_stack[smp_processor_id()];
> 
> 	sp += THREAD_SIZE - 192 - STACK_BIAS;
> 
> 	__asm__ __volatile__("mov %%sp, %0\n\t"
> 			     "mov %1, %%sp"
> 			     : "=&r" (orig_sp)
> 			     : "r" (sp));
> 	__do_softirq();
> 	__asm__ __volatile__("mov %0, %%sp"
> 			     : : "r" (orig_sp));
> }
> 
> If the above is no risk, then can we do the same on powerpc ?

No, that is a quite bad idea: it depends on the stack pointer not being
used in any way between the two asms.  Which this code does not guarantee
(what if it is inlined, for example).

Doing the stack juggling and the actual call in a single asm is much more
safe and correct.  It's just that you then need asm for the actual call
that works for all ABIs you support, etc. :-)


Segher
