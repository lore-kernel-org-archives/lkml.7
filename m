Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56708C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DC320673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbCpvr69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfGCBn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:43:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55816 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCBnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Upd1K9b6gYlAnA97u9qb4P9fFZj9SCrhC9d0+nLfQPA=; b=MbCpvr69N4Ov9IP8oVzALxdjn
        EI3CdYNQMTfWzhePtTYmwR+7J+FDmHKJdrbv+wVK8Zb+rP/e4hHE6h4zVTaf+fwR8zrdSdq12os+o
        HIxlqbYzR4jBuZdiqcGN7L7yNjnFzQwF5jhGr4BJnXOJGI3QFwLgMdft7+8lYlBUxZPEWl2qBhJa4
        2opG9GsTH2+kCUMZUoVmVbOWPQWoM7jw6ddY0UjDYiK1Irr6o7o0PW45EKo9WSThHyPwj6jt18NRe
        YNPJ1kUlOrEIIb+4PSx/2F27ugyY2rCbcqxcwCdIrVGKC3ZzctIVpD2E5vcdcIYMW3zo9UaIFWwkO
        Q6SdsZxcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiPEU-0000vQ-EL; Tue, 02 Jul 2019 20:18:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD9C5207B53F0; Tue,  2 Jul 2019 22:18:27 +0200 (CEST)
Date:   Tue, 2 Jul 2019 22:18:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
Message-ID: <20190702201827.GF3402@hirez.programming.kicks-ass.net>
References: <20190702053151.26922-1-devel@etsukata.com>
 <20190702072821.GX3419@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de>
 <20190702113355.5be9ebfe@gandalf.local.home>
 <20190702133905.1482b87e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702133905.1482b87e@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 01:39:05PM -0400, Steven Rostedt wrote:
> On Tue, 2 Jul 2019 11:33:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 2 Jul 2019 16:14:05 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > On Tue, 2 Jul 2019, Peter Zijlstra wrote:
> > >   
> > > > On Tue, Jul 02, 2019 at 02:31:51PM +0900, Eiichi Tsukata wrote:    
> > > > > Put the boundary check before it accesses user space to prevent unnecessary
> > > > > access which might crash the machine.
> > > > > 
> > > > > Especially, ftrace preemptirq/irq_disable event with user stack trace
> > > > > option can trigger SEGV in pid 1 which leads to panic.    
> > 
> > Note, I'm only able to trigger this crash with the irq_disable event.
> > The irq_enable and preempt_disable/enable events work just fine. This
> > leads me to believe that the TRACE_IRQS_OFF macro (which uses a thunk
> > trampoline) may have some issues and is probably the place to look at.
> 
> I figured it out.
> 
> It's another "corruption of the cr2" register issue. The following

Arrggghhh..

> patch makes the issue go away. I'm not suggesting that we use this
> patch, but it shows where the bug lies.
> 
> IIRC, there was patches posted before that fixed this issue. I'll go
> look to see if I can dig them up. Was it Joel that sent them?

https://lkml.kernel.org/r/20190320221534.165ab87b@oasis.local.home

I think; lemme re-read that thread.
