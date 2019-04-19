Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B36DC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3457520449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfDSSfS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD57421929;
        Fri, 19 Apr 2019 13:04:41 +0000 (UTC)
Date:   Fri, 19 Apr 2019 09:04:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Slavomir Kaslev <kaslevs@vmware.com>
Subject: Re: [PATCH] compiler.h, tracing: Remove CONFIG_PROFILE_ALL_BRANCHES
Message-ID: <20190419090440.640a46c2@gandalf.local.home>
In-Reply-To: <20190419100837.GA19406@gmail.com>
References: <20190307120317.GD32477@hirez.programming.kicks-ass.net>
        <20190307125526.GB32534@hirez.programming.kicks-ass.net>
        <20190307131312.GC32534@hirez.programming.kicks-ass.net>
        <20190307164705.qbu4ytdfdmsighas@treble>
        <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
        <20190307171709.dap5hfeof4yo3nsc@treble>
        <20190307173810.GI32477@hirez.programming.kicks-ass.net>
        <CAHk-=wi_vuD9fKk36=_DNG9=+S9rbTRu2FTFe9tECunC8oOtfg@mail.gmail.com>
        <20190307131841.3b5d9e00@oasis.local.home>
        <20190310131620.GL2482@worktop.programming.kicks-ass.net>
        <20190419100837.GA19406@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 12:08:37 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> > Can't you just have those same engineers look at perf data? This seems
> > like a very expensive and convoluted way of getting something.  

I haven't tried the perf data. How well does it work with running over
a 2 weeks to a month period? That's what I do yearly. Here's the
results of my last run:

  http://rostedt.homelinux.com/branches/gandalf-branches-2019/brach_all-2019-02-05

  http://rostedt.homelinux.com/branches/mammoth-branches-2019/branch_all-2019-01-02
  http://rostedt.homelinux.com/branches/mammoth-branches-2019/branch_all-2019-01-03
  http://rostedt.homelinux.com/branches/mammoth-branches-2019/branch_all-2019-01-17
  http://rostedt.homelinux.com/branches/mammoth-branches-2019/branch_all-2019-02-05

I have a cron job that runs nightly that copies the current state, and
if the machine reboots, it starts a new file (which is why there's
multiple files for mammoth - it rebooted).

> 
> So since no-one offered objections to using perf branch profiling instead 
> (which method allows so much more than CONFIG_PROFILE_ALL_BRANCHES: such 

I've never used it, so I have no idea if it is suitable or not.

> as profiling glibc and other user-space, or allowing to branch-profile 
> the kernel is an uninstrumented form not distorted by 
> CONFIG_PROFILE_ALL_BRANCHES code generation artifacts), lemme propose the 
> attached patch to remove if-tracing.
> 
> If the CONFIG_PROFILE_ALL_BRANCHES=y feature is required for anyone it 
> can still be reverted privately or maintained out of tree - no need to 
> burden the mainline kernel with this.

But is it a real burden? It's been in the kernel for over 10 years
with very little issue. Only when we do something drastic does it show
up, and it's usually a quick fix to get it working again.

I believe Josh even told me that it found a bug in the objtool code, so
it does still have benefit staying in the kernel even without people
using it for profiling.

Note, I'm in the middle of writing a LWN article about learning the
kernel from branch profiling and it would be a shame if it disappears
before I finish it.

-- Steve


> 
> I've build tested this and it Looks Perfect Here™.

