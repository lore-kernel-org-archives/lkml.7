Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B26C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB2E2184B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NPoQA7t5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfGASXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:23:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfGASXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2+u+Cc7eowehJoJEy3M8QpwEakJMHDd3AEighBeayWY=; b=NPoQA7t5AwxU+LhTLu2gWOG+9
        6/iAbCCWhaBJp83HLnSZrB6YVFr+/gHxsiFe0Zl+vUuyrj9VXYKOEiszM7ojN8e0DtWa43CEdaw4X
        JZPaZAM6xO/fjuZGaGrZyGPFRaNjrNAf0/HGEEz3QWliceTYj3LEhtPlVmaOZaX0G9zRgQswGpLLg
        KWL7hKvXZOTeFln1iJ5oBkuVuAelhFJvqA3IRQC7qVHipPMbBcmX8KvmlnxVOtBWqeMhnhi74k1xc
        d+0oqYSUxukHcM77RJP8oA2zGGAjRZzn2ftQ4EFulTW0JSMIlzGoXHXXwNRXMBdv69TBszWhwcQZ1
        dhgDTng1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi0xN-0000Tu-BP; Mon, 01 Jul 2019 18:23:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3472E20A31C67; Mon,  1 Jul 2019 20:23:11 +0200 (CEST)
Date:   Mon, 1 Jul 2019 20:23:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch V2 2/6] genirq: Fix misleading synchronize_irq()
 documentation
Message-ID: <20190701182311.GV3419@hirez.programming.kicks-ass.net>
References: <20190628111148.828731433@linutronix.de>
 <20190628111440.189241552@linutronix.de>
 <20190701145340.GB3402@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907011959410.1802@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907011959410.1802@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:01:24PM +0200, Thomas Gleixner wrote:
> On Mon, 1 Jul 2019, Peter Zijlstra wrote:
> 
> > On Fri, Jun 28, 2019 at 01:11:50PM +0200, Thomas Gleixner wrote:
> > > The function might sleep, so it cannot be called from interrupt
> > > context. Not even with care.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > ---
> > >  kernel/irq/manage.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > --- a/kernel/irq/manage.c
> > > +++ b/kernel/irq/manage.c
> > > @@ -96,7 +96,8 @@ EXPORT_SYMBOL(synchronize_hardirq);
> > >   *	to complete before returning. If you use this function while
> > >   *	holding a resource the IRQ handler may need you will deadlock.
> > >   *
> > > - *	This function may be called - with care - from IRQ context.
> > > + *	Can only be called from preemptible code as it might sleep when
> > > + *	an interrupt thread is associated to @irq.
> > >   */
> > >  void synchronize_irq(unsigned int irq)
> > >  {
> > 
> > +	might_sleep();
> > 
> > ?
> 
>   ....
> 
> 	wait_event()
> 	  might_sleep() ...
> 

That's conditional on desc, but sure, that should work in most sane
cases.
