Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7667BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCB525534
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfE3H3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:29:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60002 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfE3H3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:29:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1D4BA78;
        Thu, 30 May 2019 00:29:05 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00F53F690;
        Thu, 30 May 2019 00:29:01 -0700 (PDT)
Date:   Thu, 30 May 2019 08:28:58 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
        acme@redhat.com, eranian@google.com, fweisbec@gmail.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190530072858.GB9955@brain-police>
References: <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <20190529130521.GA11023@fuggles.cambridge.arm.com>
 <20190529132515.GW2623@hirez.programming.kicks-ass.net>
 <20190529143510.GA11154@fuggles.cambridge.arm.com>
 <20190529161955.GZ2623@hirez.programming.kicks-ass.net>
 <20190529162528.GB12420@fuggles.cambridge.arm.com>
 <20190529164407.GA2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529164407.GA2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 06:44:07PM +0200, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 05:25:28PM +0100, Will Deacon wrote:
> 
> > > > > On Wed, May 29, 2019 at 02:05:21PM +0100, Will Deacon wrote:
> > > > > > On Wed, May 29, 2019 at 02:55:57PM +0200, Peter Zijlstra wrote:
> > > > > 
> > > > > > >  	if (user_mode(regs)) {
> > > > > > 
> > > > > > Hmm, so it just occurred to me that Mark's observation is that the regs
> > > > > > can be junk in some cases. In which case, should we be checking for
> > > > > > kthreads first?
> 
> > Sorry, I'm not trying to catch you out! Just trying to understand what the
> > semantics are supposed to be.
> > 
> > I do find the concept of user_mode(regs) bizarre for the idle task. By the
> > above, we definitely have a bug on arm64 (user_mode(regs) tends to be
> > true for the idle task), and I couldn't figure out how you avoided it on
> > x86. I guess it happens to work because the stack is zero-initialised or
> > something?
> 
> So lets take the whole thing:
> 
> static void perf_sample_regs_user(struct perf_regs *regs_user,
> 				  struct pt_regs *regs,
> 				  struct pt_regs *regs_user_copy)
> {
> 	if (user_mode(regs)) {
> 		regs_user->abi = perf_reg_abi(current);
> 		regs_user->regs = regs;
> 	} else if (!(current->flags & PF_KTHREAD)) {
> 		perf_get_regs_user(regs_user, regs, regs_user_copy);
> 	} else {
> 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
> 		regs_user->regs = NULL;
> 	}
> }
> 
> This is called from the perf-generate-a-sample path, which is typically
> an exception (IRQ/NMI/whatever) or a software/tracepoint thing.

Yes, sorry, fell into the same trap as Mark here and misunderstood your
assertion about user_mode(regs) always needing to be valid. Then I went down
a stupid rabbit hole and dragged you with me. I can't ack a patch twice, so
I'll just go do something else for a bit...

Thanks for your patience!

Will
