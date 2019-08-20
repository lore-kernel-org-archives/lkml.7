Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09846C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB1C206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfHTPz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:43990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfHTPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:55:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA0BD28;
        Tue, 20 Aug 2019 08:55:26 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B187E3F246;
        Tue, 20 Aug 2019 08:55:25 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] arm64: cpufeature: Add feature to detect
 heterogeneous systems
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, raph.gault+kdev@gmail.com
References: <20190816125934.18509-1-raphael.gault@arm.com>
 <20190816125934.18509-3-raphael.gault@arm.com>
 <20190820152316.GA38082@lakrids.cambridge.arm.com>
 <20190820154955.GB43412@lakrids.cambridge.arm.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <8cf12008-cc86-3872-7358-2e837cf2498a@arm.com>
Date:   Tue, 20 Aug 2019 16:55:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820154955.GB43412@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for your comments.

On 8/20/19 4:49 PM, Mark Rutland wrote:
> On Tue, Aug 20, 2019 at 04:23:17PM +0100, Mark Rutland wrote:
>> Hi Raphael,
>>
>> On Fri, Aug 16, 2019 at 01:59:31PM +0100, Raphael Gault wrote:
>>> This feature is required in order to enable PMU counters direct
>>> access from userspace only when the system is homogeneous.
>>> This feature checks the model of each CPU brought online and compares it
>>> to the boot CPU. If it differs then it is heterogeneous.
>>
>> It would be worth noting that this patch prevents heterogeneous CPUs
>> being brought online late if the system was uniform at boot time.
> 
> Looking again, I think I'd misunderstood how
> ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU was dealt with, but we do have a
> problem in this area.
> 
> [...]
> 
>>
>>> +		.capability = ARM64_HAS_HETEROGENEOUS_PMU,
>>> +		.type = ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU,
>>> +		.matches = has_heterogeneous_pmu,
>>> +	},
> 
> I had a quick chat with Will, and we concluded that we must permit late
> onlining of heterogeneous CPUs here as people are likely to rely on
> late CPU onlining on some heterogeneous systems.
> 
> I think the above permits that, but that also means that we need some
> support code to fail gracefully in that case (e.g. without sending
> a SIGILL to unaware userspace code).

I understand, however, I understood that 
ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU did not allow later CPU to be 
heterogeneous if the capability wasn't already enabled. Thus if as you 
say we need to allow the system to switch from homogeneous to 
heterogeneous, then I should change the type of this capability.

> That means that we'll need the counter emulation code that you had in
> previous versions of this patch (e.g. to handle potential UNDEFs when a
> new CPU has fewer counters than the previously online CPUs).
> 
> Further, I think the context switch (and event index) code needs to take
> this cap into account, and disable direct access once the system becomes
> heterogeneous.

That is a good point indeed.

Thanks,

-- 
Raphael Gault
