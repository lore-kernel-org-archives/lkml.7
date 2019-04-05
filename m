Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FEAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB98C21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfDERSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731087AbfDERSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:18:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE81A753D1;
        Fri,  5 Apr 2019 17:18:46 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A70292636D;
        Fri,  5 Apr 2019 17:18:45 +0000 (UTC)
Date:   Fri, 5 Apr 2019 12:18:43 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch V2 03/29] x86/irq/64: Remove a hardcoded irq_stack_union
 access
Message-ID: <20190405171843.52uijxyxbeiuczcl@treble>
References: <20190405150658.237064784@linutronix.de>
 <20190405150928.684985548@linutronix.de>
 <20190405163727.GB19359@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405163727.GB19359@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 05 Apr 2019 17:18:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:37:27AM -0700, Sean Christopherson wrote:
> On Fri, Apr 05, 2019 at 05:07:01PM +0200, Thomas Gleixner wrote:
> > From: Andy Lutomirski <luto@kernel.org>
> > 
> > stack_overflow_check() is using both irq_stack_ptr and irq_stack_union to
> > find the IRQ stack. That's going to break when vmapped irq stacks are
> > introduced.
> > 
> > Change it to just use irq_stack_ptr.
> > 
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > ---
> >  arch/x86/kernel/irq_64.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > --- a/arch/x86/kernel/irq_64.c
> > +++ b/arch/x86/kernel/irq_64.c
> > @@ -55,9 +55,8 @@ static inline void stack_overflow_check(
> >  	    regs->sp <= curbase + THREAD_SIZE)
> >  		return;
> >  
> > -	irq_stack_top = (u64)this_cpu_ptr(irq_stack_union.irq_stack) +
> > -			STACK_TOP_MARGIN;
> >  	irq_stack_bottom = (u64)__this_cpu_read(irq_stack_ptr);
> > +	irq_stack_top = irq_stack_bottom - IRQ_STACK_SIZE + STACK_TOP_MARGIN;
> 
> Not introduced in this patch, but the names for top and bottom are flipped,
> both for irq_stack and estack.  STACK_TOP_MARGIN should also be
> STACK_BOTTOM_MARGIN.  The actual checks are functionally correct, but holy
> hell does it make reading the code confusing, and the WARN prints backwards
> information.

I agree, but... one man's top is another man's bottom.  Especially when
stacks grow physically down (as defined by Intel) but conceptually up
(as defined by every CS algorithms class ever).

-- 
Josh
