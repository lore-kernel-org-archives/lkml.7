Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E8BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B7920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfE1Pc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:32:29 -0400
Received: from foss.arm.com ([217.140.101.70]:59478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfE1Pc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:32:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07479341;
        Tue, 28 May 2019 08:32:29 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3AE53F59C;
        Tue, 28 May 2019 08:32:26 -0700 (PDT)
Date:   Tue, 28 May 2019 16:32:24 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190528153224.GE20758@fuggles.cambridge.arm.com>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528140103.GT2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:01:03PM +0200, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 08:31:29PM +0800, Young Xiao wrote:
> > When a kthread calls call_usermodehelper() the steps are:
> >   1. allocate current->mm
> >   2. load_elf_binary()
> >   3. populate current->thread.regs
> > 
> > While doing this, interrupts are not disabled. If there is a perf
> > interrupt in the middle of this process (i.e. step 1 has completed
> > but not yet reached to step 3) and if perf tries to read userspace
> > regs, kernel oops.

This seems to be because pt_regs(current) gives NULL for kthreads on Power.

> > Fix it by setting abi to PERF_SAMPLE_REGS_ABI_NONE when userspace
> > pt_regs are not set.
> > 
> > See commit bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs
> > user process") for details.
> 
> Why the hell do we set current->mm before it is complete? Note that
> normally exec() builds the new mm before attaching it, see exec_mmap()
> in flush_old_exec().

From the initial report [1], it doesn't look like the mm isn't initialised,
but rather than we're dereferencing a NULL pt_regs pointer somehow for the
current task (see previous comment). I don't see how that can happen on
arm64, given that we put the pt_regs on the kernel stack which is allocated
during fork.

Will

[1] https://git.kernel.org/linus/bf05fc25f268
