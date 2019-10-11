Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5147EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1362084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfJKKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:31:43 -0400
Received: from foss.arm.com ([217.140.110.172]:55828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfJKKbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:31:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA01528;
        Fri, 11 Oct 2019 03:31:41 -0700 (PDT)
Received: from [10.1.199.68] (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9C773F703;
        Fri, 11 Oct 2019 03:31:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] arm64: add support for the AMU extension v1
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, maz@kernel.org, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20190917134228.5369-1-ionela.voinescu@arm.com>
 <20190917134228.5369-2-ionela.voinescu@arm.com>
 <20191010172058.GD40923@arrakis.emea.arm.com>
From:   Ionela Voinescu <ionela.voinescu@arm.com>
Message-ID: <4e82e891-1d47-7a4f-abc9-e6bf2cce7f91@arm.com>
Date:   Fri, 11 Oct 2019 11:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010172058.GD40923@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 10/10/2019 18:20, Catalin Marinas wrote:
> Hi Ionela,
> 
> On Tue, Sep 17, 2019 at 02:42:25PM +0100, Ionela Voinescu wrote:
>> +#ifdef CONFIG_ARM64_AMU_EXTN
>> +
>> +/*
>> + * This per cpu variable only signals that the CPU implementation supports the
>> + * AMU but does not provide information regarding all the events that it
>> + * supports.
>> + * When this amu_feat per CPU variable is true, the user of this feature can
>> + * only rely on the presence of the 4 fixed counters. But this does not
>> + * guarantee that the counters are enabled or access to these counters is
>> + * provided by code executed at higher exception levels.
>> + */
>> +DEFINE_PER_CPU(bool, amu_feat) = false;
>> +
>> +static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
>> +{
>> +	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
>> +		pr_info("detected CPU%d: Activity Monitors extension\n",
>> +			smp_processor_id());
>> +		this_cpu_write(amu_feat, true);
>> +	}
>> +}
> 
> Sorry if I missed anything as I just skimmed through this series. I
> can't see the amu_feat used anywhere in these patches, so on its own it
> doesn't make much sense.
> 

No worries, you are correct, at the moment the per-cpu amu_feat is not
yet used anywhere. But the intention is to use it to discover the
feature at CPU level as some CPUs might implement AMU and some might
not.

I'll soon submit some patches using the counters for the scheduler's
frequency invariance - to discover the frequency the CPUs are actually
running at in case there is power or thermal mitigation happening
outside of the OS.

> I also can't see the advantage of allowing mismatched CPU
> implementations for this feature. What's the intended use-case?
> 

Just to clarify things, the intention is to allow a mix of CPUs where
some of them implement AMU (v8.4 - V1) and some don't. The current
implementation does not currently support a mix of CPUs with different
implementations of AMU. Although that would be easy to add when we have
a new version of AMU.

The reason to allow a mix of CPUs with and without support for activity
monitor counters is due to the fact that these counters are intended to
reflect activity on a CPU, independent of other CPUs. Some of the
counters might show common information to all CPUs (for example the
constant counter that ticks at the frequency of the system timer),
some of information might be common to a subset of CPUs (cycle counter
will tick at the same rate for CPUs in the same frequency domain -
except when WFI), and some will be fully specific to the CPU
(instructions retired and memory stalls). This per-cpu information is
useful whether or not all CPUs can provide this information.

More practically, it's possible that we'll see big.LITTLE platforms
where the big CPUs only will implement activity monitors and for those
CPUs it will be useful to get more accurate information on the current
frequency, for example, as power and thermal mitigation is more
probable to happen in the power domain of the big CPUs.

For this usecase and for others, it will be good for generic support to
allow detection of the feature at a per-cpu level (this is where the
usefulness of the per-cpu amu_feat comes in) while further checks and
aggregation will be done when the counters are used, depending on the
usecase.

Thanks,
Ionela.

> Thanks.
> 
