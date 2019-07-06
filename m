Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CA1C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 22:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E52C20843
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 22:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfGFW1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 18:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfGFW1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 18:27:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E760220838;
        Sat,  6 Jul 2019 22:27:29 +0000 (UTC)
Date:   Sat, 6 Jul 2019 18:27:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190706182728.435a89ed@gandalf.local.home>
In-Reply-To: <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com>
References: <20190704195555.580363209@infradead.org>
        <20190704200050.534802824@infradead.org>
        <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
        <20190705134916.GU3402@hirez.programming.kicks-ass.net>
        <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2019 14:41:22 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Jul 5, 2019 at 6:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Also; all previous attempts at fixing this have been about pushing the
> > read_cr2() earlier; notably:
> >
> >   0ac09f9f8cd1 ("x86, trace: Fix CR2 corruption when tracing page faults")
> >   d4078e232267 ("x86, trace: Further robustify CR2 handling vs tracing")  
> 
> I think both of those are because people - again - felt like tracing
> can validly corrupt CPU state, and then they fix up the symptoms
> rather than the cause.
> 
> Which I disagree with.
> 
> > And I'm thinking that with exception of this patch, the rest are
> > worthwhile cleanups regardless.  
> 
> I don't have any issues with the patches themselves, I agree that they
> are probably good on their own.
> 
> I *do* have issues with the "tracing can change CPU state so we need
> to deal with it" model, though. I think that mode of thinking is
> wrong. I don't believe tracing should ever change core CPU state and
> that be considered ok.
> 
> > Also; while looking at this, if we do continue with the C wrappers from
> > the very last patch, we can do horrible things like this on top and move
> > the read_cr2() back into C code.  
> 
> Again, I don't think that is the problem. I think it's a much more
> fundamental problem in thinking that core code should be changed
> because tracing is broken garbage and didn't do things right.
> 
> I see Eiichi's patch, and it makes me go "that looks better" - simply
> because it fixes the fundamental issue, rather than working around the
> symptoms.
>

We also have to deal with reading vmalloc'd data as that can fault too.
The perf ring buffer IIUC is vmalloc, so if perf records in one of
these locations, then the reading of the vmalloc area has a potential
to fault corrupting the CR2 register as well. Or have we changed
vmalloc to no longer fault?

-- Steve
