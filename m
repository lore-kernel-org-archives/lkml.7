Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E02BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C4022BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfGYWLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:11:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47820 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfGYWL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:11:29 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqlxL-0005rz-KS; Fri, 26 Jul 2019 00:11:24 +0200
Date:   Fri, 26 Jul 2019 00:11:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/hw_breakpoint: Prevent data breakpoints on
 cpu_entry_area
In-Reply-To: <20190725172854.GL31381@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907260005190.1791@nanos.tec.linutronix.de>
References: <cf0ca526e3bc946766ab70bada2686c82e7da1ce.1564072590.git.luto@kernel.org> <20190725172854.GL31381@hirez.programming.kicks-ass.net>
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

On Thu, 25 Jul 2019, Peter Zijlstra wrote:

> On Thu, Jul 25, 2019 at 09:37:15AM -0700, Andy Lutomirski wrote:
> > A data breakpoint near the top of an IST stack will cause unresoverable

unresoverable?

> > recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.
> > Prevent either of these from happening.
> > 
> > Co-developed-by: Peter Zijlstra <peterz@infradead.org>

Co-developed-by want's a Signed-off-by of the co-developer

> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > index 218c8917118e..dc4581fe4b4e 100644
> > --- a/arch/x86/kernel/hw_breakpoint.c
> > +++ b/arch/x86/kernel/hw_breakpoint.c
> > @@ -231,6 +231,23 @@ static int arch_build_bp_info(struct perf_event *bp,
> >  			      const struct perf_event_attr *attr,
> >  			      struct arch_hw_breakpoint *hw)
> >  {
> > +	unsigned long bp_end;
> > +
> > +	/* Ensure that bp_end does not oveflow. */

oveflow?

> > +	if (attr->bp_len >= ULONG_MAX - attr->bp_addr)
> > +		return -EINVAL;
> > +
> > +	bp_end = attr->bp_addr + attr->bp_len - 1;
> 
> The alternative (and possibly more conventional) overflow test would be:
> 
> 	if (bp_end < attr->bp_addr)
> 		return -EINVAL;

Yes please.

> > +
> > +	/*
> > +	 * Prevent any breakpoint of any type that overlaps the
> > +	 * cpu_entry_area.  This protects the IST stacks and also
> > +	 * reduces the chance that we ever find out what happens if

I surely hope that the chance is reduced to 0 ...

I know this is all an annoyance brought to us by hardware and I surely
enjoy the hidden sarcasm but please make this information as technically
accurate as possible. Put the rant into an extra line of the comment :)

> > +	 * there's a data breakpoint on the GDT, IDT, or TSS.
> > +	 */
> > +	if (within_cpu_entry_area(attr->bp_addr, bp_end))
> > +		return -EINVAL;

Thanks,

	tglx
