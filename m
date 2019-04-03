Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC39C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C30E20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZA4eBlzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfDCIC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:02:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfDCIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W4sm/eXh6xPYghIEJK6s5BwcuH5zyEoSDxJLYaprRPo=; b=ZA4eBlzFLtzPGBrcJlkRbUNjz
        dZJz/R2oIa428kNyZw3Fn/SVRKhPKljEXpE5nqtBW0Pm5mfTv5nv/Z/UHwbiJ7Lnm/bFgubR3EQee
        0mJeCZhcI672wYzyXAzw+poPdiXVEW4TRdrreJKM0L0j7oZwTCHLqg9jvaU0xqfHvYWqwAT6n9WQG
        tCjcHQpaE0tQeWFLLBNwe5JVbvTI8Aw+cVUAZUbmFpBstFAOGnFj4blLCaGuGP0s8Vq9o1l/U/g13
        Z4w5QkkLQD7CRTJBAbr7bfxHWo6pYMO+C9s0vSgr2HJDKQuM2bGSsPa8J+ya9PLxH0sJIFvpqumWY
        ugNm40FlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBaqo-0008RK-RS; Wed, 03 Apr 2019 08:02:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59557203C722D; Wed,  3 Apr 2019 10:02:25 +0200 (CEST)
Date:   Wed, 3 Apr 2019 10:02:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
Message-ID: <20190403080225.GM12232@hirez.programming.kicks-ass.net>
References: <20190331214020.836098943@linutronix.de>
 <20190331215136.039902969@linutronix.de>
 <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de>
 <20190402154329.scp7i7uqevubgwrz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402154329.scp7i7uqevubgwrz@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:43:29AM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 02, 2019 at 12:19:46PM +0200, Thomas Gleixner wrote:
> >  static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
> >  {
> > -	unsigned long estacks, begin, end, stk = (unsigned long)stack;
> > +	unsigned long begin, end, stk = (unsigned long)stack;
> > +	const struct estack_pages *ep;
> >  	struct pt_regs *regs;
> >  	unsigned int k;
> >  
> >  	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
> >  
> > -	estacks = (unsigned long)__this_cpu_read(cea_exception_stacks);
> > -
> > -	for (k = 0; k < N_EXCEPTION_STACKS; k++) {
> > -		begin = estacks + layout[k].begin;
> > -		end   = estacks + layout[k].end;
> > -		regs  = (struct pt_regs *)end - 1;
> > -
> > -		if (stk <= begin || stk >= end)
> > -			continue;
> > -
> > -		info->type	= STACK_TYPE_EXCEPTION + k;
> > -		info->begin	= (unsigned long *)begin;
> > -		info->end	= (unsigned long *)end;
> > -		info->next_sp	= (unsigned long *)regs->sp;
> > -
> > -		return true;
> > -	}
> > -
> > -	return false;
> > +	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
> > +	end = begin + sizeof(struct cea_exception_stacks);
> > +	/* Bail if @stack is outside the exception stack area. */
> > +	if (stk <= begin || stk >= end)
> > +		return false;
> 
> This check is the most important piece.  Exception stack dumps are quite
> rare, so this ensures an early exit in most cases regardless of whether
> there's a loop below.
> 
> > +
> > +	/* Calc page offset from start of exception stacks */
> > +	k = (stk - begin) >> PAGE_SHIFT;
> > +	/* Lookup the page descriptor */
> > +	ep = &estack_pages[k];
> > +	/* Guard page? */
> > +	if (unlikely(!ep->size))
> > +		return false;
> > +
> > +	begin += (unsigned long)ep->offs;
> > +	end = begin + (unsigned long)ep->size;
> > +	regs = (struct pt_regs *)end - 1;
> > +
> > +	info->type	= ep->type;
> > +	info->begin	= (unsigned long *)begin;
> > +	info->end	= (unsigned long *)end;
> > +	info->next_sp	= (unsigned long *)regs->sp;
> > +	return true;
> 
> With the above "(stk <= begin || stk >= end)" check, removing the loop
> becomes not all that important since exception stack dumps are quite
> rare and not performance sensitive.  With all the macros this code
> becomes a little more obtuse, so I'm not sure whether removal of the
> loop is a net positive.

Are you sure; perf does a lot of stack dumps from NMI context.
