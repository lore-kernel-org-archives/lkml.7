Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9157DC28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705CA20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfE2KU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:20:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfE2KU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:20:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31E86341;
        Wed, 29 May 2019 03:20:27 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5933F59C;
        Wed, 29 May 2019 03:20:24 -0700 (PDT)
Date:   Wed, 29 May 2019 11:20:22 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529102022.GC4485@fuggles.cambridge.arm.com>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529101042.GN2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:10:42PM +0200, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 10:17:33AM +0100, Will Deacon wrote:
> > On Tue, May 28, 2019 at 07:32:28PM +0200, Peter Zijlstra wrote:
> 
> > > 'funny' thing that, perf_sample_regs_user() seems to assume that
> > > anything with current->mm is in fact a user task, and that assumption is
> > > just plain wrong, consider use_mm().
> > 
> > Right, I suppose that was attempting to handle interrupt skid from the PMU
> > overflow?
> 
> Nah, just a broken test to determine if there is userspace at all. It is
> mostly right, just not completely :-)
> 
> > > So I'm thinking the right thing to do here is something like the below;
> > > umh should get PF_KTHREAD cleared when it passes exec(). And this should
> > > also fix the power splat I'm thinking.
> > > 
> > > ---
> > > 
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index abbd4b3b96c2..9929404b6eb9 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -5923,7 +5923,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
> > >  	if (user_mode(regs)) {
> > >  		regs_user->abi = perf_reg_abi(current);
> > >  		regs_user->regs = regs;
> > > -	} else if (current->mm) {
> > > +	} else if (!(current->flags & PF_KTHREAD) && current->mm) {
> > >  		perf_get_regs_user(regs_user, regs, regs_user_copy);
> > 
> > Makes sense, but under which circumstances would we have a NULL mm here?
> 
> Dunno; I'm paranoid, and also:
> 
>   mm/memcontrol.c:        if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))

So this one I also don't understand...

>   mm/vmacache.c:  return current->mm == mm && !(current->flags & PF_KTHREAD);

... but this one is just about an mm mismatch, rather than a NULL mm.

Anyway, you can add my ack to your patch, but I bet we can remove that mm
check :D

Will
