Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F00C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCE920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfCGSSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:18:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGSSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:18:45 -0500
Received: from oasis.local.home (unknown [38.98.46.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8FA020675;
        Thu,  7 Mar 2019 18:18:43 +0000 (UTC)
Date:   Thu, 7 Mar 2019 13:18:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Slavomir Kaslev <kaslevs@vmware.com>
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190307131841.3b5d9e00@oasis.local.home>
In-Reply-To: <CAHk-=wi_vuD9fKk36=_DNG9=+S9rbTRu2FTFe9tECunC8oOtfg@mail.gmail.com>
References: <20190307114511.870090179@infradead.org>
        <20190307120317.GD32477@hirez.programming.kicks-ass.net>
        <20190307125526.GB32534@hirez.programming.kicks-ass.net>
        <20190307131312.GC32534@hirez.programming.kicks-ass.net>
        <20190307164705.qbu4ytdfdmsighas@treble>
        <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
        <20190307171709.dap5hfeof4yo3nsc@treble>
        <20190307173810.GI32477@hirez.programming.kicks-ass.net>
        <CAHk-=wi_vuD9fKk36=_DNG9=+S9rbTRu2FTFe9tECunC8oOtfg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 09:45:35 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Mar 7, 2019 at 9:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Also; it seems to me that something PT, or maybe even simply:
> >
> >   perf -e branches -e branch-misses
> >
> > would get you similar or sufficient information.  
> 
> Yeah, I'm not really seeing a lot of upside to PROFILE_ALL_BRANCHES.
> 
> Particularly since it doesn't actually profile all branches at all. It
> only basically profiles "if ()" statements, which obviously misses
> loops etc, but then also _does_ hit things where people turned loops
> into "if (unlikely()) loop()", which happens in (for example)
> low-level locking code etc that often has a fast-case "first try"
> thing followed by a slow-case "ok, let's loop for it" thing.
> 
> So I think PROFILE_ALL_BRANCHES tends to have very random coverage.
> I'd love to get rid of it, because it seems so random.
>

As Josh said, I run it once a year on two production (real use)
machines for 2 to 4 weeks and collect the data to see if there are
places that can be optimized better.

I currently have one of my engineers looking at the data and may be
sending patches soon. It's basically an entry level way to get into
kernel development. Note, no patch will be sent just because of the
data from the profiling. The task is to look at and understand the
code, and see if it can be optimized (with likely/unlikely or flow
changes). It's a way to get a better understanding of the kernel in
various locations. It is by no means "profiler said this, lets change
it." All changes must be rational, and make sense. The profiler is only
used to help find those places.

The data that was run at the end of January can be found here:

 http://rostedt.homelinux.com/branches/mammoth-branches-2019/
 http://rostedt.homelinux.com/branches/gandalf-branches-2019/

-- Steve
