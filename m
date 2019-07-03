Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F60C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC165218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KrEzq7yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfGCWGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:06:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42502 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGCWGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ycz23bS+Ty7b4itKG6Ov4WzbLqJ/+noHY6F+mh11CDg=; b=KrEzq7yWP9zUh5tQVChZPqEtP
        cgxInZT3Qn1dUZS8vFJXW6zy8wDB0U78iU0v5dFJ/1LV4rbaKjCjRoSt75htGcYRJHBNNvGksI5vD
        AoeRxyXSwVGFjGE5MZiArKAOo2CzP5x4ZWIZYiBjaM233l/l35ruMCHV+/Phy2eXAVMWs3vYfB+h9
        F5bLBsodD1jI563A+jBhDmCoocIeoP9P3Vwf/cAoLPEpYwj07qM6nmGXXsjvp+kHvdydsodKov3xf
        gguisfB398MGWeiPafKPraFdLfeE4v3fZJW+djSJUIiQ4FxC2uARQmQxSue9F7+an1taS7UIhEF/G
        tn0uIlAAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hinNU-0003qN-Or; Wed, 03 Jul 2019 22:05:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E90920213044; Thu,  4 Jul 2019 00:05:22 +0200 (CEST)
Date:   Thu, 4 Jul 2019 00:05:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190703220522.GK3402@hirez.programming.kicks-ass.net>
References: <20190703102731.236024951@infradead.org>
 <20190703102807.588906400@infradead.org>
 <CALCETrVR2_5-=FcJdB3OaKjif9EEzoq+YDhNfPjahVM3JUUrUQ@mail.gmail.com>
 <20190703164701.54ef979a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703164701.54ef979a@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 04:47:01PM -0400, Steven Rostedt wrote:
> On Wed, 3 Jul 2019 13:27:09 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
> 
> 
> > > @@ -1180,10 +1189,10 @@ idtentry xenint3                do_int3                 has_error_co
> > >  #endif
> > >
> > >  idtentry general_protection    do_general_protection   has_error_code=1
> > > -idtentry page_fault            do_page_fault           has_error_code=1
> > > +idtentry page_fault            do_page_fault           has_error_code=1        read_cr2=1
> > >
> > >  #ifdef CONFIG_KVM_GUEST
> > > -idtentry async_page_fault      do_async_page_fault     has_error_code=1
> > > +idtentry async_page_fault      do_async_page_fault     has_error_code=1        read_cr2=1
> > >  #endif
> > >
> > >  #ifdef CONFIG_X86_MCE
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
> Yeah, looks like we might be missing a TRACE_IRQS_OFF from the
> from_usermode_stack_switch path.

Oh bugger, there's a second error_entry call.
