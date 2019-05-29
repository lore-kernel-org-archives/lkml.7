Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCBDC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E947320673
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfE2NFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:05:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45626 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfE2NF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:05:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4389080D;
        Wed, 29 May 2019 06:05:29 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F863F59C;
        Wed, 29 May 2019 06:05:26 -0700 (PDT)
Date:   Wed, 29 May 2019 14:05:21 +0100
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
Message-ID: <20190529130521.GA11023@fuggles.cambridge.arm.com>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529125557.GU2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:55:57PM +0200, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 11:20:22AM +0100, Will Deacon wrote:
> > Anyway, you can add my ack to your patch, but I bet we can remove that mm
> > check :D
> 
> I've ended up with the below. Ravi, can you test if that does indeed
> obsolete your PPC patch?
> 
> ---
> Subject: perf: Fix perf_sample_regs_user()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed May 29 14:37:24 CEST 2019
> 
> perf_sample_regs_user() uses 'current->mm' to test for the presence of
> userspace, but this is insufficient, consider use_mm().
> 
> A better test is: '!(current->flags & PF_KTHREAD)', exec() clears
> PF_KTHREAD after it sets the new ->mm but before it drops to userspace
> for the first time.
> 
> Possibly obsoletes: bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs user process")
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Reported-by: Young Xiao <92siuyang@gmail.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Fixes: 4018994f3d87 ("perf: Add ability to attach user level registers dump to sample")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5923,7 +5923,7 @@ static void perf_sample_regs_user(struct
>  	if (user_mode(regs)) {

Hmm, so it just occurred to me that Mark's observation is that the regs
can be junk in some cases. In which case, should we be checking for
kthreads first?

Will
