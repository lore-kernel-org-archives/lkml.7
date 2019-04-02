Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04335C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D296B20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfDBPtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:49:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37328 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbfDBPtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:49:00 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBLei-0003QC-Oh; Tue, 02 Apr 2019 17:48:56 +0200
Date:   Tue, 2 Apr 2019 17:48:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
In-Reply-To: <20190402154329.scp7i7uqevubgwrz@treble>
Message-ID: <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
References: <20190331214020.836098943@linutronix.de> <20190331215136.039902969@linutronix.de> <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de> <20190402154329.scp7i7uqevubgwrz@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019, Josh Poimboeuf wrote:
> On Tue, Apr 02, 2019 at 12:19:46PM +0200, Thomas Gleixner wrote:
> > +/*
> > + * Array of exception stack page descriptors. If the stack is larger than
> > + * PAGE_SIZE, all pages covering a particular stack will have the same
> > + * info.
> > + */
> > +static const struct estack_pages estack_pages[ESTACK_PAGES] ____cacheline_aligned = {
> > +	[CONDRANGE(DF)]		= ESTACK_PAGE(DOUBLEFAULT_IST, DF),
> > +	[CONDRANGE(NMI)]	= ESTACK_PAGE(NMI_IST, NMI),
> > +	[PAGERANGE(DB)]		= ESTACK_PAGE(DEBUG_IST, DB),
> > +	[CONDRANGE(MCE)]	= ESTACK_PAGE(MCE_IST, MCE),
> 
> It would be nice if the *_IST macro naming aligned with the struct
> cea_exception_stacks field naming.  Then you could just do, e.g.
> ESTACKPAGE(DF).

Yes, lemme fix that up.

> Also it's a bit unfortunate that some of the stack size knowledge is
> hard-coded here, i.e #DB always being > 1 page and non-#DB being
> sometimes 1 page.

The problem is that there is no way to make this macro maze conditional on
sizeof(). But my macro foo is rusty.

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

What about perf? It's NMI context and probably starts from there. Peter?

Thanks,

	tglx
