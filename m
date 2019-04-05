Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB633C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C48217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfDEIf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:35:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47324 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbfDEIf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:35:57 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCKKD-0006g9-6X; Fri, 05 Apr 2019 10:35:49 +0200
Date:   Fri, 5 Apr 2019 10:35:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base
 as GSBASE at the paranoid_entry
In-Reply-To: <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904050007050.1802@nanos.tec.linutronix.de>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com> <1552680405-5265-9-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Thomas Gleixner wrote:
> On Fri, 15 Mar 2019, Chang S. Bae wrote:
> >  ENTRY(paranoid_exit)
> >  	UNWIND_HINT_REGS
> >  	DISABLE_INTERRUPTS(CLBR_ANY)
> >  	TRACE_IRQS_OFF_DEBUG
> > +	ALTERNATIVE "jmp .Lparanoid_exit_no_fsgsbase",	"nop",\
> > +		X86_FEATURE_FSGSBASE
> > +	wrgsbase	%rbx
> > +	jmp	.Lparanoid_exit_no_swapgs;
> 
> Again. A few newlines would make it more readable.
> 
> This modifies the semantics of paranoid_entry and paranoid_exit. Looking at
> the usage sites there is the following code in the nmi maze:
> 
> 	/*
> 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
> 	 * as we should not be calling schedule in NMI context.
> 	 * Even with normal interrupts enabled. An NMI should not be
> 	 * setting NEED_RESCHED or anything that normal interrupts and
> 	 * exceptions might do.
> 	 */
> 	call	paranoid_entry
> 	UNWIND_HINT_REGS
> 
> 	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
> 	movq	%rsp, %rdi
> 	movq	$-1, %rsi
> 	call	do_nmi
> 
> 	/* Always restore stashed CR3 value (see paranoid_entry) */
> 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
> 
> 	testl	%ebx, %ebx			/* swapgs needed? */
> 	jnz	nmi_restore
> nmi_swapgs:
> 	SWAPGS_UNSAFE_STACK
> nmi_restore:
> 	POP_REGS
> 
> I might be missing something, but how is that supposed to work when
> paranoid_entry uses FSGSBASE? I think it's broken, but if it's not then
> there is a big fat comment missing explaining why.

So this _is_ broken.

   On entry:

      rbx = rdgsbase()
      wrgsbase(KERNEL_GS)

   On exit:

      if (ebx == 0)
      	 swapgs

The resulting matrix:

   |  ENTRY GS	| RBX		| EXIT		| GS on IRET	| RESULT
   |		|		|		|		|
 1 |  KERNEL_GS	| KERNEL_GS	| EBX == 0	| USER_GS	| FAIL
   |		|		|		|		|
 2 |  KERNEL_GS	| KERNEL_GS	| EBX != 0	| KERNEL_GS	| ok
   |		|		|		|		|
 3 |  USER_GS	| USER_GS	| EBX == 0	| USER_GS	| ok
   |		|		|		|		|
 4 |  USER_GS	| USER_GS	| EBX != 0	| KERNEL_GS	| FAIL


#1 Just works by chance because it's unlikely that the lower 32bits of a
   per CPU kernel GS are all 0.

   But it's just a question of probability that this turns into a
   non-debuggable once per year crash (think KASLR).

#4 This can happen when the NMI hits the kernel in some other entry code
   _BEFORE_ or _AFTER_ swapgs.

   User space using GS addressing with GS[31:0] != 0 will crash and burn.

   IIRC FSGSBASE is about fast user space GS switching with (almost) no
   limits on the value ...

Oh well.

	tglx
