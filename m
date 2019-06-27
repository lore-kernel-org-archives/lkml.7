Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A0CC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36205208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561631252;
	bh=dI0kBr+SLvATNvxr645YEW44/eVW59NGalSpB0Dn5ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JtrrwUn7sTVL5X18bSoBMj8ETLW4BRhfIzzMQc4d7dVdJJnltRfyhhX0rMiolAlA6
	 qa60gKPb0VXNLvvoVxDxtMGxDogioTnooHBehpt16D+qkwimVtDMzrx+F2fyYSPvqr
	 UMoKefuFHAsAMOZ8ktklYQn5cPy9gVOPtEw+0H6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfF0K1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfF0K1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:27:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B78B20828;
        Thu, 27 Jun 2019 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561631249;
        bh=dI0kBr+SLvATNvxr645YEW44/eVW59NGalSpB0Dn5ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1rqIUjononn+K4NHBL3fy90iZW1bSd5CokZzMxiIOQZKSlwIu+F4uBsCufiV8lLO3
         VW+HU66VkQ9zOzIWmhff5Muq/WyhDGo0C3fqsnMqO8aBXGob0ZfxWdn75U9A+KJQS+
         NHKy6D28h23yl9pRhyiwVgDBL9DoKJtXnEdoMTzo=
Date:   Thu, 27 Jun 2019 11:27:25 +0100
From:   Will Deacon <will@kernel.org>
To:     "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Message-ID: <20190627102724.vif6zh6zfqktpmjx@willie-the-truck>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <20190617170328.GJ30800@fuggles.cambridge.arm.com>
 <e8fe8faa-72ef-8185-1a9d-dc1bbe0ae15d@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fe8faa-72ef-8185-1a9d-dc1bbe0ae15d@jp.fujitsu.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:34:02AM +0000, qi.fuli@fujitsu.com wrote:
> On 6/18/19 2:03 AM, Will Deacon wrote:
> > On Mon, Jun 17, 2019 at 11:32:53PM +0900, Takao Indoh wrote:
> >> From: Takao Indoh <indou.takao@fujitsu.com>
> >>
> >> I found a performance issue related on the implementation of Linux's TLB
> >> flush for arm64.
> >>
> >> When I run a single-threaded test program on moderate environment, it
> >> usually takes 39ms to finish its work. However, when I put a small
> >> apprication, which just calls mprotest() continuously, on one of sibling
> >> cores and run it simultaneously, the test program slows down significantly.
> >> It becomes 49ms(125%) on ThunderX2. I also detected the same problem on
> >> ThunderX1 and Fujitsu A64FX.
> > This is a problem for any applications that share hardware resources with
> > each other, so I don't think it's something we should be too concerned about
> > addressing unless there is a practical DoS scenario, which there doesn't
> > appear to be in this case. It may be that the real answer is "don't call
> > mprotect() in a loop".
> I think there has been a misunderstanding, please let me explain.
> This application is just an example using for reproducing the 
> performance issue we found.
> Our original purpose is reducing OS jitter by this series.
> The OS jitter on massively parallel processing systems have been known 
> and studied for many years.
> The 2.5% OS jitter can result in over a factor of 20 slowdown for the 
> same application [1].

I think it's worth pointing out that the system in question was neither
ARM-based nor running Linux, so I'd be cautious in applying the conclusions
of that paper directly to our TLB invalidation code. Furthermore, the noise
being generated in their experiments uses a timer interrupt, which has a
/vastly/ different profile to a DVM message in terms of both system impact
and frequency.

> Though it may be an extreme example, reducing the OS jitter has been an 
> issue in HPC environment.
> 
> [1] Ferreira, Kurt B., Patrick Bridges, and Ron Brightwell. 
> "Characterizing application sensitivity to OS interference using 
> kernel-level noise injection." Proceedings of the 2008 ACM/IEEE 
> conference on Supercomputing. IEEE Press, 2008.
> 
> >> I suppose the root cause of this issue is the implementation of Linux's TLB
> >> flush for arm64, especially use of TLBI-is instruction which is a broadcast
> >> to all processor core on the system. In case of the above situation,
> >> TLBI-is is called by mprotect().
> > On the flip side, Linux is providing the hardware with enough information
> > not to broadcast to cores for which the remote TLBs don't have entries
> > allocated for the ASID being invalidated. I would say that the root cause
> > of the issue is that this filtering is not taking place.
> 
> Do you mean that the filter should be implemented in hardware?

Yes. If you're building a large system and you care about "jitter", then
you either need to partition it in such a way that sources of noise are
contained, or you need to introduce filters to limit their scope. Rewriting
the low-level memory-management parts of the operating system is a red
herring and imposes a needless burden on everybody else without solving
the real problem, which is that contended use of shared resources doesn't
scale.

Will
