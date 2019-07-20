Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB3BC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 11:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476A12084D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 11:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8LG49vr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGTLU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 07:20:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55616 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfGTLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 07:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VPxvWfzidbdufHwjHsLIFDhjZhE7VbFOLoJl9Ptv77M=; b=e8LG49vrxiW/CUiccLMNo2oo0
        6FM7kyVLsvyZGKhOT6sQYLLa2ST6gJftGn0Cj0sGVUsXfPW7KZsKlvgAQIj7TT2xdv5fVn7axzrAp
        jzTUuRF5scF+w8GQIq2FZbwt95R76pfZ13KRvJZKCjtHcNTb1h+G6nUVUIP/KeF3gqSZ1HaR8sjgn
        XIRuTSpGYXPV0+sBnq8mefXLrw5vZ9AI/vJoY0FQJfBKZ/Six7svf4KtId42jKIVUlaKQVF56ZIsK
        MJ7NtMzaH/5FHYHhmdR4+r9yGUVtqYKBeGeh0l1TmZBf/HijexwvGZ8ZmvA3zkKjvYDIHk+KBGDy4
        lU37zNYHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1honPW-0001JR-1I; Sat, 20 Jul 2019 11:20:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9758F20BAF36D; Sat, 20 Jul 2019 13:20:14 +0200 (CEST)
Date:   Sat, 20 Jul 2019 13:20:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/entry/64: Prevent clobbering of saved CR2 value
Message-ID: <20190720112014.GR3402@hirez.programming.kicks-ass.net>
References: <20190702053151.26922-1-devel@etsukata.com>
 <20190702072821.GX3419@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de>
 <20190702113355.5be9ebfe@gandalf.local.home>
 <20190702133905.1482b87e@gandalf.local.home>
 <20190719202836.GB13680@linux.intel.com>
 <alpine.DEB.2.21.1907200018050.1782@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907201020540.1782@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907201020540.1782@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 10:56:41AM +0200, Thomas Gleixner wrote:
> The recent fix for CR2 corruption introduced a new way to reliably corrupt
> the saved CR2 value.
> 
> CR2 is saved early in the entry code in RDX, which is the third argument to
> the fault handling functions. But it missed that between saving and
> invoking the fault handler enter_from_user_mode() can be called. RDX is a
> caller saved register so the invoked function can freely clobber it with
> the obvious consequences.
> 
> The TRACE_IRQS_OFF call is safe as it calls through the thunk which
> preserves RDX.
> 
> Store CR2 in R12 instead which is a callee saved register and move R12 to
> RDX just before calling the fault handler.
> 
> Fixes: a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption")
> Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

D'0h :-( Sorry about that.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/entry/entry_64.S |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -875,7 +875,12 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
>  	UNWIND_HINT_REGS
>  
>  	.if \read_cr2
> -	GET_CR2_INTO(%rdx);			/* can clobber %rax */
> +	/*
> +	 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
> +	 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
> +	 * GET_CR2_INTO can clobber RAX.
> +	 */
> +	GET_CR2_INTO(%r12);
>  	.endif
>  
>  	.if \shift_ist != -1
> @@ -904,6 +909,10 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
>  	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
>  	.endif
>  
> +	.if \read_cr2
> +	movq	%r12, %rdx			/* Move CR2 into 3rd argument */
> +	.endif
> +
>  	call	\do_sym
>  
>  	.if \shift_ist != -1
