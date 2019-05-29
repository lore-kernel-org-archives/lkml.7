Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894FCC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C1B23DE8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfE2QjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:39:00 -0400
Received: from foss.arm.com ([217.140.101.70]:49276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfE2QjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:39:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B84DE341;
        Wed, 29 May 2019 09:38:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64703F5AF;
        Wed, 29 May 2019 09:38:56 -0700 (PDT)
Date:   Wed, 29 May 2019 17:38:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        mpe@ellerman.id.au, acme@redhat.com, eranian@google.com,
        fweisbec@gmail.com, jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529163854.GN31777@lakrids.cambridge.arm.com>
References: <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <20190529130521.GA11023@fuggles.cambridge.arm.com>
 <20190529132515.GW2623@hirez.programming.kicks-ass.net>
 <20190529143510.GA11154@fuggles.cambridge.arm.com>
 <20190529161955.GZ2623@hirez.programming.kicks-ass.net>
 <20190529162435.GM31777@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529162435.GM31777@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 05:24:36PM +0100, Mark Rutland wrote:
> On Wed, May 29, 2019 at 06:19:55PM +0200, Peter Zijlstra wrote:
> > On Wed, May 29, 2019 at 03:35:10PM +0100, Will Deacon wrote:
> > > On Wed, May 29, 2019 at 03:25:15PM +0200, Peter Zijlstra wrote:
> > > > On Wed, May 29, 2019 at 02:05:21PM +0100, Will Deacon wrote:
> > > > > On Wed, May 29, 2019 at 02:55:57PM +0200, Peter Zijlstra wrote:
> > > > 
> > > > > >  	if (user_mode(regs)) {
> > > > > 
> > > > > Hmm, so it just occurred to me that Mark's observation is that the regs
> > > > > can be junk in some cases. In which case, should we be checking for
> > > > > kthreads first?
> > > > 
> > > > task_pt_regs() can return garbage, but @regs is the exception (or
> > > > perf_arch_fetch_caller_regs()) regs, and for those user_mode() had
> > > > better be correct.
> > > 
> > > So what should we report for the idle task?
> > 
> > If an interrupt hits the idle task, @regs would be !user_mode(regs),
> > we'll find current->flags & PF_KTHREAD (idle not having passed through
> > exec()) and therefore we'll take ABI_NONE for the user regs.
> > 
> > Or am I not getting it?
> 
> If the contents of task_pt_regs(current) is garbage, then the result of
> user_mode(task_pt_regs(current)) is also garbage, no?

Ugh; I was being thick here and assuming regs was the result of
task_pt_regs() when it's actually the interrupted regs.

Sorry for the noise.

Generally speaking though, if we ever task task_pt_regs() of an idle
task we'll get junk, and user_mode() could be true.

Thanks,
Mark.
