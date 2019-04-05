Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC3CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A492175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfDEQBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:01:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52194 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDEQBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:01:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F39168F;
        Fri,  5 Apr 2019 09:01:36 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89743F68F;
        Fri,  5 Apr 2019 09:01:34 -0700 (PDT)
Subject: Re: [PATCH v6 09/10] arm64: add sysfs vulnerability show for
 speculative store bypass
To:     Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        marc.zyngier@arm.com, suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
References: <20190321230557.45107-1-jeremy.linton@arm.com>
 <20190321230557.45107-10-jeremy.linton@arm.com>
 <20190403165005.GA17500@fuggles.cambridge.arm.com>
 <20190405111022.6ef0b7bb@donnerap.cambridge.arm.com>
 <20190405144310.GA7662@fuggles.cambridge.arm.com>
 <20190405161810.33b2ce23@donnerap.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <f24a5882-137c-ea22-58b1-41e50758a212@arm.com>
Date:   Fri, 5 Apr 2019 11:01:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190405161810.33b2ce23@donnerap.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/5/19 10:18 AM, Andre Przywara wrote:
> On Fri, 5 Apr 2019 15:43:10 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> 
>> On Fri, Apr 05, 2019 at 11:10:22AM +0100, Andre Przywara wrote:
>>> On Wed, 3 Apr 2019 17:50:05 +0100
>>> Will Deacon <will.deacon@arm.com> wrote:
>>>    
>>>> Hi Jeremy,
>>>>
>>>> On Thu, Mar 21, 2019 at 06:05:56PM -0500, Jeremy Linton wrote:
>>>>> Return status based on ssbd_state and the arm64 SSBS feature. If
>>>>> the mitigation is disabled, or the firmware isn't responding then
>>>>> return the expected machine state based on a new blacklist of known
>>>>> vulnerable cores.
>>>>>
>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>>>>> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>>> ---
>>>>>   arch/arm64/kernel/cpu_errata.c | 44 ++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 44 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>>>>> index 6958dcdabf7d..172ffbabd597 100644
>>>>> --- a/arch/arm64/kernel/cpu_errata.c
>>>>> +++ b/arch/arm64/kernel/cpu_errata.c
>>>>> @@ -278,6 +278,7 @@ static int detect_harden_bp_fw(void)
>>>>>   DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>>>>>   
>>>>>   int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
>>>>> +static bool __ssb_safe = true;
>>>>>   
>>>>>   static const struct ssbd_options {
>>>>>   	const char	*str;
>>>>> @@ -386,6 +387,9 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>>>>>   
>>>>>   	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>>>>>   
>>>>> +	if (is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list))
>>>>> +		__ssb_safe = false;
>>>>> +
>>>>
>>>> Does this mean that we assume that CPUs not present in our table are not
>>>> affected by speculative store bypass?
>>>
>>> No, not affected are only those where we either have SSBS or the firmware
>>> explicitly returns SMCCC_RET_NOT_REQUIRED. This is governed by ssbd_state.
>>> So this doesn't affect correctness.
>>
>> I don't think that's true. My TX2, for example, says "Not affected" for
>> spec_store_bypass, but we don't actually know whether it's affected or
>> not and so it should report "Vulnerable" instead, like we do for spectre_v2
>> on the same machine.
> 
> Yeah, what I actually meant was that this list doesn't affect whether the workaround gets applied or not. But indeed the reporting is wrong.
> 
>>> __ssb_safe is an additional state just used for the sysfs output. But
>>> indeed it looks like this is wrong if the CPU is both not listed and the
>>> system doesn't provide the firmware interface: AFAICS we would report "Not
>>> affected" in this case.
>>
>> Yes, that's what I was getting at.
>>
>>>> I don't think that's a good
>>>> assumption, because we don't necessary have knowledge about partner or
>>>> future CPU implementations, so I think any CPU lists really have to be
>>>> whitelists like they are for the other vulnerabilities.
>>>
>>> I think the idea was to cover all those "legacy" systems which have
>>> older cores (no SSBS), but didn't get an firmware update. So your old Seattle
>>> would truthfully report "Vulnerable", but any random A53 device would
>>> report "Not affected", even with ancient firmware.
>>
>> The only manageable way to deal with this is to use a whitelist, just like
>> we do for the other vulnerabilities. We shouldn't have to update it for
>> long because newer cores should have SSBS.
> 
> Agreed. We should start with __ssb_safe = false, and work from there. Seems much safer.

I tended to view this with a more charitable view (aka vendors with 
vulnerable machines would have put the effort in to get their firmware 
working). But that does violate the "if you don't know, its vulnerable" 
statements made earlier. I guess the advantage of claiming machines are 
vulnerable which aren't is that it strongly encourages vendors which are 
not vulnerable to come out and say so.

I will invert this logic and repost in the next day or so.

Thanks,



