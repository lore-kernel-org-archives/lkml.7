Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BBC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1950721882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrMP5I/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfGDJOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:14:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfGDJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PNxLXAuGU1eH4up6MZ98aiqxao/y1lyE++wArXWtFiw=; b=hrMP5I/I1PV79CgTgLIBc/Svb
        IYc4l4gOMIrAyykwAdV13WjbliAIP4zCHpk58u6Pcm81nEM59+DxJR4Amrsrg5E+yCXQTZkML7LO5
        BVqfHEl785IGtuKU69PBqpXC9SJs4X3JOukHyOMTb2G5lVin53mveV0vi1RfwpFQOsVNiTOLlUoqL
        6yZtdZ3DLDiwH2m/jMZ+CW2xjbvousrvn4cPYnSj/y/QSzO5+Aeeu12UwNN6AT4iFcsHw3jnpAf1g
        3I+kPK9fuoxHv5KaQ2YOlU3Deq+aapW/QguHQxpC2p1BYYpdX1WUKdE3RgAClFTa6U+BQTaDLKIqa
        iZKB1/tIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hixoQ-0003Dx-6d; Thu, 04 Jul 2019 09:13:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF87320ADD322; Thu,  4 Jul 2019 11:13:51 +0200 (CEST)
Date:   Thu, 4 Jul 2019 11:13:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190704091351.GH3463@hirez.programming.kicks-ass.net>
References: <20190703102731.236024951@infradead.org>
 <20190703102807.588906400@infradead.org>
 <CALCETrVR2_5-=FcJdB3OaKjif9EEzoq+YDhNfPjahVM3JUUrUQ@mail.gmail.com>
 <20190703220057.GJ3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703220057.GJ3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:00:57AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 03, 2019 at 01:27:09PM -0700, Andy Lutomirski wrote:
> > On Wed, Jul 3, 2019 at 3:28 AM root <peterz@infradead.org> wrote:
> 
> > > @@ -1338,18 +1347,9 @@ ENTRY(error_entry)
> > >         movq    %rax, %rsp                      /* switch stack */
> > >         ENCODE_FRAME_POINTER
> > >         pushq   %r12
> > > -
> > > -       /*
> > > -        * We need to tell lockdep that IRQs are off.  We can't do this until
> > > -        * we fix gsbase, and we should do it before enter_from_user_mode
> > > -        * (which can take locks).
> > > -        */
> > > -       TRACE_IRQS_OFF
> > 
> > This hunk looks wrong.  Am I missing some other place that handles the
> > case where we enter from kernel mode and IRQs were on?
> 
> > > -	CALL_enter_from_user_mode
> > >  	ret
> > >  
> > >  .Lerror_entry_done:
> > > -	TRACE_IRQS_OFF
> > >  	ret
> > >  
> > >  	/*
> 
> Did you perchance mean to complain about the .Lerror_entry_done one?
> 
> Because I'm not seeing how the one before CALL_enter_from_user_mode can
> ever be from-kernel.
> 
> But yes, that .Lerror_entry_done one looks fishy.

That works because idtentry will now do an unconditional TRACE_IRQS_OFF,
note how the patch removes the .if \paranoid around that.

