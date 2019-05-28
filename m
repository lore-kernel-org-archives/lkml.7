Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83879C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5901621721
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfE1QNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:13:00 -0400
Received: from foss.arm.com ([217.140.101.70]:60330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfE1QNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:13:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63936341;
        Tue, 28 May 2019 09:12:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B63A3F59C;
        Tue, 28 May 2019 09:12:57 -0700 (PDT)
Date:   Tue, 28 May 2019 17:12:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190528161254.GA28492@lakrids.cambridge.arm.com>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528153224.GE20758@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:32:24PM +0100, Will Deacon wrote:
> On Tue, May 28, 2019 at 04:01:03PM +0200, Peter Zijlstra wrote:
> > On Tue, May 28, 2019 at 08:31:29PM +0800, Young Xiao wrote:
> > > When a kthread calls call_usermodehelper() the steps are:
> > >   1. allocate current->mm
> > >   2. load_elf_binary()
> > >   3. populate current->thread.regs
> > > 
> > > While doing this, interrupts are not disabled. If there is a perf
> > > interrupt in the middle of this process (i.e. step 1 has completed
> > > but not yet reached to step 3) and if perf tries to read userspace
> > > regs, kernel oops.
> 
> This seems to be because pt_regs(current) gives NULL for kthreads on Power.

I think you mean task_pt_regs(current) here.

> > > Fix it by setting abi to PERF_SAMPLE_REGS_ABI_NONE when userspace
> > > pt_regs are not set.
> > > 
> > > See commit bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs
> > > user process") for details.
> > 
> > Why the hell do we set current->mm before it is complete? Note that
> > normally exec() builds the new mm before attaching it, see exec_mmap()
> > in flush_old_exec().
> 
> From the initial report [1], it doesn't look like the mm isn't initialised,
> but rather than we're dereferencing a NULL pt_regs pointer somehow for the
> current task (see previous comment). I don't see how that can happen on
> arm64, given that we put the pt_regs on the kernel stack which is allocated
> during fork.
> 
> Will
> 
> [1] https://git.kernel.org/linus/bf05fc25f268

One caveat is that for the idle threads, the initial SP overlaps the
task_pt_regs() area:

* __primary_switched starts SP at init_thread_union + THREAD_SIZE.

* __cpu_up() starts SP at task_stack_page(idle) + THREAD_SIZE.

... and in either case, sampling that would be bad.

For both arm, I believe similar holds true. AFAICT x86 seems to reserve
the regs area in its head_{64,32}.S, but I can't see what it does for
other threads.

Regardless, for arm, arm64, and x86, task_pt_regs(current) cannot be
NULL.

Thanks,
Mark.
