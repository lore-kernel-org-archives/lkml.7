Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E670ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB8520673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfJKObR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:31:17 -0400
Received: from foss.arm.com ([217.140.110.172]:34216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfJKObR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:31:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32979142F;
        Fri, 11 Oct 2019 07:31:16 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDA823F68E;
        Fri, 11 Oct 2019 07:31:14 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:31:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     will@kernel.org, maz@kernel.org, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] arm64: add support for the AMU extension v1
Message-ID: <20191011143112.GB3607@arrakis.emea.arm.com>
References: <20190917134228.5369-1-ionela.voinescu@arm.com>
 <20190917134228.5369-2-ionela.voinescu@arm.com>
 <20191010172058.GD40923@arrakis.emea.arm.com>
 <4e82e891-1d47-7a4f-abc9-e6bf2cce7f91@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e82e891-1d47-7a4f-abc9-e6bf2cce7f91@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:31:40AM +0100, Ionela Voinescu wrote:
> On 10/10/2019 18:20, Catalin Marinas wrote:
> > On Tue, Sep 17, 2019 at 02:42:25PM +0100, Ionela Voinescu wrote:
> >> +#ifdef CONFIG_ARM64_AMU_EXTN
> >> +
> >> +/*
> >> + * This per cpu variable only signals that the CPU implementation supports the
> >> + * AMU but does not provide information regarding all the events that it
> >> + * supports.
> >> + * When this amu_feat per CPU variable is true, the user of this feature can
> >> + * only rely on the presence of the 4 fixed counters. But this does not
> >> + * guarantee that the counters are enabled or access to these counters is
> >> + * provided by code executed at higher exception levels.
> >> + */
> >> +DEFINE_PER_CPU(bool, amu_feat) = false;
> >> +
> >> +static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
> >> +{
> >> +	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
> >> +		pr_info("detected CPU%d: Activity Monitors extension\n",
> >> +			smp_processor_id());
> >> +		this_cpu_write(amu_feat, true);
> >> +	}
> >> +}
> > 
> > Sorry if I missed anything as I just skimmed through this series. I
> > can't see the amu_feat used anywhere in these patches, so on its own it
> > doesn't make much sense.
> 
> No worries, you are correct, at the moment the per-cpu amu_feat is not
> yet used anywhere. But the intention is to use it to discover the
> feature at CPU level as some CPUs might implement AMU and some might
> not.
> 
> I'll soon submit some patches using the counters for the scheduler's
> frequency invariance - to discover the frequency the CPUs are actually
> running at in case there is power or thermal mitigation happening
> outside of the OS.

Thanks for the explanation. I guess I'll wait for the other patches to
see how all fits together. In general I'm not keen on per-CPU variables
exposed to the rest of the kernel. For example, is it always read in a
non-preemptible context? I'd rather have an accessor function with the
corresponding WARN_ON_ONCE(preemptible()). This may come with the rest
of the patches.

> More practically, it's possible that we'll see big.LITTLE platforms
> where the big CPUs only will implement activity monitors and for those
> CPUs it will be useful to get more accurate information on the current
> frequency, for example, as power and thermal mitigation is more
> probable to happen in the power domain of the big CPUs.

As long as that's a realistic possibility (not just a theoretical one)
and the in-kernel code can handle such asymmetry, it's fine by me. This
could be another reason to never expose the AMU counters to user-space
or guests. You can control preemption in the kernel but can't run
user-space in a non-preemptible context.

-- 
Catalin
