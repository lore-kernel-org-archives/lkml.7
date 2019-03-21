Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87EE21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0XcSb+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfCUUun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:50:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfCUUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3zQEDiroBD1Uyyspu/Nh7nuSqoagrwiuIlZymGnV+t8=; b=X0XcSb+kaz7FXsz7yLtqVoqOi
        XHIeo22OVbL7adnc46A3FKl6zsCyNUutrLoL8vSU3nrPp+thL4CMFJX1Kc53oPCrkaPWaMAkMleAU
        rmBAXaXpB+J6h8QxocA68A2A5b0DH0FfgqEGN7Kxgu2ONB/Dk0+UapOe17FI5Y76IdONdYlHdgs0l
        8f2/ra+P8CWLfSe3VZXWc4JYoHAnjdz29WeWtryIl8xD2/w8xZ6fJfr03ov86QXPtWil87uGuaWC7
        kmy+r9joC3RdXNMuKvGvsjtwKTHx9oV4+4To+/YlKIV98Xhgp5naONpneUDxbwiaueB2TOWX8c9Bp
        9zgBWb7XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h74di-0002OU-LA; Thu, 21 Mar 2019 20:50:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D40C2984EEA; Thu, 21 Mar 2019 21:50:11 +0100 (CET)
Date:   Thu, 21 Mar 2019 21:50:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321205011.GE2490@worktop.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
 <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net>
 <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home>
 <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <20190321141020.641e313f@gandalf.local.home>
 <CALCETrV1YRo8C6=VtFfrSDFAjQBs=Z6+uw-5hbus4frqAbUqGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV1YRo8C6=VtFfrSDFAjQBs=Z6+uw-5hbus4frqAbUqGQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:27:00AM -0700, Andy Lutomirski wrote:
> Well, here's pass zero at this.  Untested, because it obviously
> doesn't work.  Here are just a few things that are almost certainly
> wrong with it

Aah, you're proposing to simply not do TRACE_IRQS_OFF and
CALL_enter_from_user_mode and let \do_sym deal with it all.

Yes, that looks like it could almost work; esp. if you start by only
doing this for the idtentry stuff.

>  - The IRQ tracing needs to be re-added.
> 
>  - Some real semantics need to be defined for precisely what code is
> responsible for tracing.

So we get passed \do_sym, how about we do:

	call	__\do_sym

And then use some CPP magic to generate the those functions such that we
have a consistent part of C glue between our asm and our 'real' C
handler.

This glue can then do the tracing in a consistent manner.

#define IDT_HANDLER(do_sym)						\
asmlinkage __visible notrace void __do_sym(struct pt_regs *regs)	\
{									\
	trace_hardirqs_off();						\
	if (user_mode(regs))						\
		enter_from_user_mode();					\
	do_sym(regs);							\
}

Except more complicated I'm afraid, we need to handle more args etc..

>  - We need some asm-callable assertions to check the following
> conditions as appropriate:
> 
>  (a) that IRQ flags are currently traced as off.

What do you need this for? When returning from do_sym ?

>  (b) that IRQ flags are currently traced to match the IRET frame.

idem. Can't we have our C glue do that?

>  (c) that our context tracking is currently in good shape.  I'm not
> 100% sure how to define this.

So looking at this more; I used the %ebx games employed by
paranoid_entry to convey the state, but I didn't have to do that, the
actual condition seems to be:

	regs->cs & 3

aka. user_mode(regs). In this case our C glue would need to do the
context tracking user exit.

In fact, I can change my patch to use that and reduce the ebx ugly.

>  - We need to do some serious don't-instrument-me stuff to all the C
> entries, since we're now in an awful context when calling them.

Yah, but that's not new. do_page_fault(), sync_regs() at the very least
have this, so we can easily have our C glue have this too.
