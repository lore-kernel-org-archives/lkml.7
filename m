Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B294C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02DA208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfE2KMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:12:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfE2KMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:12:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AAC4341;
        Wed, 29 May 2019 03:12:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 536243F59C;
        Wed, 29 May 2019 03:12:31 -0700 (PDT)
Date:   Wed, 29 May 2019 11:11:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529101135.GA31777@lakrids.cambridge.arm.com>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528173228.GW2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 07:32:28PM +0200, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 04:32:24PM +0100, Will Deacon wrote:
> > On Tue, May 28, 2019 at 04:01:03PM +0200, Peter Zijlstra wrote:
> > > On Tue, May 28, 2019 at 08:31:29PM +0800, Young Xiao wrote:
> > > > When a kthread calls call_usermodehelper() the steps are:
> > > >   1. allocate current->mm
> > > >   2. load_elf_binary()
> > > >   3. populate current->thread.regs
> > > > 
> > > > While doing this, interrupts are not disabled. If there is a perf
> > > > interrupt in the middle of this process (i.e. step 1 has completed
> > > > but not yet reached to step 3) and if perf tries to read userspace
> > > > regs, kernel oops.
> > 
> > This seems to be because pt_regs(current) gives NULL for kthreads on Power.
> 
> 'funny' thing that, perf_sample_regs_user() seems to assume that
> anything with current->mm is in fact a user task, and that assumption is
> just plain wrong, consider use_mm().

Tagnentially, it looks like that assumption is made elsewhere, and could
do with a more general cleanup. IIUC, the following are suspect:

* kmemleak's scan_should_stop()
* x86's __kernel_fpu_begin()
* arm64's arch_dup_task_struct()

It's probably worth an is_thread(task) helper so that those can be
written in an obviously correct way.

> So I'm thinking the right thing to do here is something like the below;
> umh should get PF_KTHREAD cleared when it passes exec(). And this should
> also fix the power splat I'm thinking.
> 
> ---
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abbd4b3b96c2..9929404b6eb9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5923,7 +5923,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
>  	if (user_mode(regs)) {
>  		regs_user->abi = perf_reg_abi(current);
>  		regs_user->regs = regs;
> -	} else if (current->mm) {
> +	} else if (!(current->flags & PF_KTHREAD) && current->mm) {

Wouldn't !PF_KTHREAD imply current->mm anyhow?

Thanks,
Mark.
