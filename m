Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D425EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF265208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406459AbfHILbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:31:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfHILbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:31:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CDB15AB;
        Fri,  9 Aug 2019 04:31:20 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39A283F575;
        Fri,  9 Aug 2019 04:31:18 -0700 (PDT)
Subject: Re: Explicitly marking initializer overrides (was "Re: [PATCH]
 arm64/cache: silence -Woverride-init warnings")
To:     Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Qian Cai <cai@lca.pw>,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190808032916.879-1-cai@lca.pw>
 <20190808103808.GC46901@lakrids.cambridge.arm.com>
 <20190808170916.GA32668@archlinux-threadripper>
 <20190809083251.GA48423@lakrids.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8f0b6055-2e57-729e-af46-21c3bbe24ebb@arm.com>
Date:   Fri, 9 Aug 2019 12:31:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190809083251.GA48423@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 09:32, Mark Rutland wrote:
> On Thu, Aug 08, 2019 at 10:09:16AM -0700, Nathan Chancellor wrote:
>> On Thu, Aug 08, 2019 at 11:38:08AM +0100, Mark Rutland wrote:
>>> On Wed, Aug 07, 2019 at 11:29:16PM -0400, Qian Cai wrote:
>>>> The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
>>>> VIVT I-caches") introduced some compiation warnings from GCC (and
>>>> Clang) with -Winitializer-overrides),
>>>>
>>>> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
>>>> overwritten [-Woverride-init]
>>>> [ICACHE_POLICY_VIPT]  = "VIPT",
>>>>                          ^~~~~~
>>>> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
>>>> 'icache_policy_str[2]')
>>>> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
>>>> overwritten [-Woverride-init]
>>>> [ICACHE_POLICY_PIPT]  = "PIPT",
>>>>                          ^~~~~~
>>>> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
>>>> 'icache_policy_str[3]')
>>>> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
>>>> overwritten [-Woverride-init]
>>>> [ICACHE_POLICY_VPIPT]  = "VPIPT",
>>>>                           ^~~~~~~
>>>> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
>>>> 'icache_policy_str[0]')
>>>>
>>>> because it initializes icache_policy_str[0 ... 3] twice. Since
>>>> arm64 developers are keen to keep the style of initializing a static
>>>> array with a non-zero pattern first, just disable those warnings for
>>>> both GCC and Clang of this file.
>>>>
>>>> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
>>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>>
>>> This is _not_ a fix, and should not require backporting to stable trees.
>>>
>>> What about all the other instances that we have in mainline?
>>>
>>> I really don't think that we need to go down this road; we're just going
>>> to end up adding this to every file that happens to include a header
>>> using this scheme...
>>>
>>> Please just turn this off by default for clang.
>>>
>>> If we want to enable this, we need a mechanism to permit overridable
>>> assignments as we use range initializers for.
>>>
>>> Thanks,
>>> Mark.
>>>
>>
>> For what it's worth, this is disabled by default for clang in the
>> kernel:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.extrawarn?h=v5.3-rc3#n69
>>
>> It only becomes visible with clang at W=1 because that section doesn't
>> get applied. It becomes visible with GCC at W=1 because of -Wextra.
> 
> Thanks for clarifying that!
> 
> Do you know if there's any existing mechanism that we can use to silence
> the warning on a per-assignment basis? Either to say that an assignment
> can be overridden, or that the assignment is expected to override an
> existing assignment?
> 
> If not, who would be able to look at adding a mechanism to clang for
> this?
> 
> If we could have some attribute or intrinsic that we could wrap like:
> 
> struct foo f = {
> 	.bar __defaultval = <default>,
> 	.bar = <newval>,		// no warning
> 	.bar = <anotherval>,		// warning
> };
> 
> ... or:
> 
> struct foo f = {
> 	.bar = <default>,
> 	.bar __override = <newval>,	// no warning
> 	.bar = <anotherval>,		// warning
> };
> 
> ... or:
> 	
> 	.bar = OVERRIDE(<newval>),	// no warning
> 
> ... or:
> 	OVERRIDE(.bar) = <newval>,	// no warning
> 
> ... then I think it would be possible to make use of the warning
> effectively, as we could distinguish intentional overrides from
> unintentional ones, and annotating assignments in this way doesn't seem
> onerous to me.

Tangentially, there might also be value in some kind of "must be 
explicitly initialised" attribute that would warn if any element was not 
covered by (at least one) initialiser. For cases like our 
icache_policy_str one, where using the "default + overrides" pattern for 
the sake of one reserved entry is more about robustness against the 
array growing in future than simpler code today, that could arguably be 
a more appropriate option.

Robin.
