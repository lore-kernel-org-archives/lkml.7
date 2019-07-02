Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD0C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F27A206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGCBXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCBXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:23:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12B5B21897;
        Tue,  2 Jul 2019 20:33:57 +0000 (UTC)
Date:   Tue, 2 Jul 2019 16:33:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
Message-ID: <20190702163356.205bbe14@gandalf.local.home>
In-Reply-To: <20190702201827.GF3402@hirez.programming.kicks-ass.net>
References: <20190702053151.26922-1-devel@etsukata.com>
        <20190702072821.GX3419@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de>
        <20190702113355.5be9ebfe@gandalf.local.home>
        <20190702133905.1482b87e@gandalf.local.home>
        <20190702201827.GF3402@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 22:18:27 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jul 02, 2019 at 01:39:05PM -0400, Steven Rostedt wrote:
> > On Tue, 2 Jul 2019 11:33:55 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > On Tue, 2 Jul 2019 16:14:05 +0200 (CEST)
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > >   
> > > > On Tue, 2 Jul 2019, Peter Zijlstra wrote:
> > > >     
> > > > > On Tue, Jul 02, 2019 at 02:31:51PM +0900, Eiichi Tsukata wrote:      
> > > > > > Put the boundary check before it accesses user space to prevent unnecessary
> > > > > > access which might crash the machine.
> > > > > > 
> > > > > > Especially, ftrace preemptirq/irq_disable event with user stack trace
> > > > > > option can trigger SEGV in pid 1 which leads to panic.      
> > > 
> > > Note, I'm only able to trigger this crash with the irq_disable event.
> > > The irq_enable and preempt_disable/enable events work just fine. This
> > > leads me to believe that the TRACE_IRQS_OFF macro (which uses a thunk
> > > trampoline) may have some issues and is probably the place to look at.  
> > 
> > I figured it out.
> > 
> > It's another "corruption of the cr2" register issue. The following  
> 
> Arrggghhh..
> 
> > patch makes the issue go away. I'm not suggesting that we use this
> > patch, but it shows where the bug lies.
> > 
> > IIRC, there was patches posted before that fixed this issue. I'll go
> > look to see if I can dig them up. Was it Joel that sent them?  
> 
> https://lkml.kernel.org/r/20190320221534.165ab87b@oasis.local.home

Oh, I wrote the patches. No wonder I couldn't find them in my local
"patchwork". It doesn't include patches I write. But still, I
completely forgot. Better send me to the nursing home :-p

> 
> I think; lemme re-read that thread.

I'll need to do that too.

-- Steve
