Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910DFC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ADF20727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574779027;
	bh=1GOQJQR55sXQeEjNnRz1avvc58d8sV4zCuT8LyQZ/Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q4XbZRuQmlo0Gkz2a1Y3Viw8VyHlmbzfX5Ap+e+HYNkvxohIbUvyzxywIs3mwB0sE
	 JxTfP8txx5E/lQpZZUlgpT7PECMr2IudI/n6CAcsmZgFGw9LP3cYNMEJ/Ud+fDsHxM
	 hfd+IlT0lF+fSKd0FNBGQ2QoNtvIR1GMrjcEUVrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKZOhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:37:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKZOhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:37:06 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1573020656;
        Tue, 26 Nov 2019 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574779024;
        bh=1GOQJQR55sXQeEjNnRz1avvc58d8sV4zCuT8LyQZ/Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0X3TsrBziLGJqhV/e3mEWvXCmApDyvMKfe4joOQs9BxecsQaTM8Tkmiqfdfr3ZnY
         u0byS9MAwd2qlsK5qXdW7mE9keBn7/dWIpog72IPhYiD1wH3oW/XzJYGJGHU8TuVvK
         RmnA0y9UHPicrhSSG2pETRoZBzXAH3dDrrJ2jnRs=
Date:   Tue, 26 Nov 2019 14:36:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "tokamoto@jp.fujitsu.com" <tokamoto@jp.fujitsu.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maeda.naoaki@fujitsu.com" <maeda.naoaki@fujitsu.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Message-ID: <20191126143657.GA9395@willie-the-truck>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <93009dbd-b31c-7364-86d2-21f0fac36676@jp.fujitsu.com>
 <20191101172851.GC3983@willie-the-truck>
 <adac2265-2e40-bc2f-a6e2-8d6013b9416c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adac2265-2e40-bc2f-a6e2-8d6013b9416c@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 03:26:48PM +0100, Matthias Brugger wrote:
> On 01/11/2019 18:28, Will Deacon wrote:
> > On Fri, Nov 01, 2019 at 09:56:05AM +0000, qi.fuli@fujitsu.com wrote:
> >> First of all thanks for the comments for the patch.
> >>
> >> I'm still struggling with this problem to find out the solution.
> >> As a result of an investigation on this problem, after all, I think it 
> >> is necessary to improve TLB flush mechanism of the kernel to fix this 
> >> problem completely.
> >>
> >> So, I'd like to restart a discussion. At first, I summarize this problem 
> >> to recall what was the problem and then I want to discuss how to fix it.
> >>
> >> Summary of the problem:
> >> A few months ago I proposed patches to solve a performance problem due 
> >> to TLB flush.[1]
> >>
> >> A problem is that TLB flush on a core affects all other cores even if 
> >> all other cores do not need actual flush, and it causes performance 
> >> degradation.
> >>
> >> In this thread, I explained that:
> >> * I found a performance problem which is caused by TLBI-is instruction.
> >> * The problem occurs like this:
> >>   1) On a core, OS tries to flush TLB using TLBI-is instruction
> >>   2) TLBI-is instruction causes a broadcast to all other cores, and
> >>   each core received hard-wired signal
> >>   3) Each core check if there are TLB entries which have the specified 
> >> ASID/VA
> > 
> > For those following along at home, my understanding is that this "check"
> > effectively stalls the pipeline as though it is being performed in software.
> > 
> > Some questions:
> > 
> > Does this mean a malicious virtual machine can effectively DoS the system?
> > What about a malicious application calling mprotect()?
> > 
> > Do all broadcast TLBI instructions cause this expensive check, or are
> > some significantly slower than others?
> > 
> >>   4) This check causes performance degradation
> >> * We ran FWQ[2] and detected OS jitter due to this problem, this noise
> >>   is serious for HPC usage.
> >>
> >> The noise means here a difference between maximum time and minimum time 
> >> which the same work takes.
> >>
> >> How to fix:
> >> I think the cause is TLB flush by TLBI-is because the instruction 
> >> affects cores that are not related to its flush.
> > 
> > Does broadcast I-cache maintenance cause the same problem?
> > 
> >> So the previous patch I posted is
> >> * Use mm_cpumask in mm_struct to find appropriate CPUs for TLB flush
> >> * Exec TLBI instead of TLBI-is only to CPUs specified by mm_cpumask
> >>   (This is the same behavior as arm32 and x86)
> >>
> >> And after the discussion about this patch, I got the following comments.
> >> 1) This patch switches the behavior (original flush by TLBI-is and new 
> >> flush by TLBI) by boot parameter, this implementation is not acceptable 
> >> due to bad maintainability.
> >> 2) Even if this patch fixes this problem, it may cause another 
> >> performance problem.
> >>
> >> I'd like to start over the implementation by considering these points.
> >> For the second comment above, I will run a benchmark test to analyze the 
> >> impact on performance.
> >> Please let me know if there are other points I should take into 
> >> consideration.
> > 
> > I think it's worth bearing in mind that I have little sympathy for the
> > problem that you are seeing. As far as I can tell, you've done the
> > following:
> > 
> >   1. You designed a CPU micro-architecture that stalls whenever it receives
> >      a TLB invalidation request.
> > 
> >   2. You integrated said CPU design into a system where broadcast TLB
> >      invalidation is not filtered and therefore stalls every CPU every
> >      time that /any/ TLB invalidation is broadcast.
> > 
> >   3. You deployed a mixture of Linux and jitter-sensitive software on
> >      this system, and now you're failing to meet your performance
> >      requirements.
> > 
> > Have I got that right?
> > 
> > If so, given that your CPU design isn't widely available, nobody else
> > appears to have made this mistake and jitter hasn't been reported as an
> > issue for any other systems, it's very unlikely that we're going to make
> > invasive upstream kernel changes to support you. I'm sorry, but all I can
> > suggest is that you check that your micro-architecture and performance
> > requirements are aligned with the design of Linux *before* building another
> > machine like this in future.
> > 
> 
> I just wanted to note that the cover letter states that they have also seen this
> on Thunderx1 and Thunderx2.
> 
> Not sure about other machines, like the Huawei TaiShan 200 series.
> 
> What I want to say, it seems not to be something that only affects Fujitsu but
> also other vendors. So maybe we should consider adding an erratum like the one
> for the repeated TLBI on Qualcomm SoCs.

Careful here -- we're talking about a reported performance issue, not a
correctness one. The "repeated TLBI" sequence is very much a workaround for
the latter.

In the case of TX1/TX2, I can imagine the "let's sit in a loop of mprotect()
calls" scaling poorly, which is what the cover letter is referring to, but
that's not really a workload that we need to optimise for. However, the case
that Fujitsu are reporting seems to go beyond that because of the design of
their CPU micro-architecture, where even just a single TLB invalidation
message stalls all of the other CPUs in the system. I don't have any reason
to believe that particular problem affects other CPU designs.

Thanks,

Will
