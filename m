Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548E8C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26823218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uYi5BifZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfGCVvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:51:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCVvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZbA9KwVcttCbnvX3vkkEhRhS2gc/db618QfIxsAyRR4=; b=uYi5BifZnsHyKM9VVXWgGtvI7
        Uj14MK76lhxLh952LvTu8srnvZVU01S8YB04BoNbV267huFN/uPr63ONtipgyM8htE6RZvAFBbrlo
        1lPsFEu2h8VBr+XedkdNV/Y3WJ19WdczYOlv43xq1Bc1yRPNEXm4XELUGWe4FRJHc2bGZ1p4QWsCU
        Yu7PXkUxC/gQZvYBiteSQMp9NCOAW2cP2BQkcXxOjHxQiTuYKtcceIZpbZRIApGvSlVSGuHnS1tyw
        qAzkEoVLaOfMsUHZHsZ025ftfQ5oMw0ii/hnMzfpvAJnthRPTscx7JDHwnKEd8KIOwvRgzNkYUmQL
        DI+2Khm9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hin9s-0000uj-TE; Wed, 03 Jul 2019 21:51:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7ACBD202173E0; Wed,  3 Jul 2019 23:51:18 +0200 (CEST)
Date:   Wed, 3 Jul 2019 23:51:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190703215118.GI3402@hirez.programming.kicks-ass.net>
References: <20190703102731.236024951@infradead.org>
 <20190703102807.588906400@infradead.org>
 <20190703202231.GI16275@worktop.programming.kicks-ass.net>
 <20190703162942.63c750a3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703162942.63c750a3@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 04:29:42PM -0400, Steven Rostedt wrote:
> On Wed, 3 Jul 2019 22:22:31 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Jul 03, 2019 at 12:27:34PM +0200, root wrote:
> > > Despire the current efforts to read CR2 before tracing happens there
> > > still exist a number of possible holes:
> > > 
> > >   idtentry page_fault             do_page_fault           has_error_code=1
> > >     call error_entry
> > >       TRACE_IRQS_OFF
> > >         call trace_hardirqs_off*
> > >           #PF // modifies CR2
> > > 
> > >       CALL_enter_from_user_mode
> > >         __context_tracking_exit()
> > >           trace_user_exit(0)
> > >             #PF // modifies CR2
> > > 
> > >     call do_page_fault
> > >       address = read_cr2(); /* whoopsie */
> > > 
> > > And similar for i386.
> > > 
> > > Fix it by pulling the CR2 read into the entry code, before any of that
> > > stuff gets a chance to run and ruin things.
> > > 
> > > Ideally we'll clean up the entry code by moving this tracing and
> > > context tracking nonsense into C some day, but let's not delay fixing
> > > this longer.
> > >   
> > 
> > > @@ -1180,10 +1189,10 @@ idtentry xenint3		do_int3			has_error_co
> > >  #endif
> > >  
> > >  idtentry general_protection	do_general_protection	has_error_code=1
> > > -idtentry page_fault		do_page_fault		has_error_code=1
> > > +idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
> > >  
> > >  #ifdef CONFIG_KVM_GUEST
> > > -idtentry async_page_fault	do_async_page_fault	has_error_code=1
> > > +idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
> > >  #endif  
> > 
> > While going over the various idt handlers, I found that we probably also
> > need read_cr2 on do_double_fault(), otherwise it is susceptible to the
> > same problem.
> > 
> 
> BTW, do you plan on making this for stable? Even though it's rather
> invasive. Or should we just apply the band-aids first, have them
> backported to stable, and then put this change on top of them for
> upstream?

So I don't particularly care about stable; and the band-aids
(trace_irqs_off_cr2) is known broken so I really don't see the point.

That said, these patches should apply to most recent kernels (post PTI)
without too much rejects.
