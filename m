Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9FFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196F121473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfFMPV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:21:56 -0400
Received: from foss.arm.com ([217.140.110.172]:39324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731990AbfFMMod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:44:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E163EF;
        Thu, 13 Jun 2019 05:44:32 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F5113F694;
        Thu, 13 Jun 2019 05:44:29 -0700 (PDT)
Subject: Re: [PATCH 2/4] arm64: kdump: support reserving crashkernel above 4G
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        rppt@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, ebiederm@xmission.com, horms@verge.net.au,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <20190507035058.63992-3-chenzhou10@huawei.com>
 <df2b659d-7406-fbfd-597d-be3a3f69abcb@arm.com>
 <d15f334c-90cd-7c09-5e54-6501e822e7f1@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <b04f5578-4422-319c-da1f-62f7b465c9f6@arm.com>
Date:   Thu, 13 Jun 2019 13:44:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d15f334c-90cd-7c09-5e54-6501e822e7f1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Zhou,

On 13/06/2019 12:27, Chen Zhou wrote:
> On 2019/6/6 0:29, James Morse wrote:
>> On 07/05/2019 04:50, Chen Zhou wrote:
>>> When crashkernel is reserved above 4G in memory, kernel should
>>> reserve some amount of low memory for swiotlb and some DMA buffers.
>>
>>> Meanwhile, support crashkernel=X,[high,low] in arm64. When use
>>> crashkernel=X parameter, try low memory first and fall back to high
>>> memory unless "crashkernel=X,high" is specified.
>>
>> What is the 'unless crashkernel=...,high' for? I think it would be simpler to relax the
>> ARCH_LOW_ADDRESS_LIMIT if reserve_crashkernel_low() allocated something.
>>
>> This way "crashkernel=1G" tries to allocate 1G below 4G, but fails if there isn't enough
>> memory. "crashkernel=1G crashkernel=16M,low" allocates 16M below 4G, which is more likely
>> to succeed, if it does it can then place the 1G block anywhere.
>>
> Yeah, this is much simpler.

>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>> index 413d566..82cd9a0 100644
>>> --- a/arch/arm64/kernel/setup.c
>>> +++ b/arch/arm64/kernel/setup.c
>>> @@ -243,6 +243,9 @@ static void __init request_standard_resources(void)
>>>  			request_resource(res, &kernel_data);
>>>  #ifdef CONFIG_KEXEC_CORE
>>>  		/* Userspace will find "Crash kernel" region in /proc/iomem. */
>>> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
>>> +		    crashk_low_res.end <= res->end)
>>> +			request_resource(res, &crashk_low_res);
>>>  		if (crashk_res.end && crashk_res.start >= res->start &&
>>>  		    crashk_res.end <= res->end)
>>>  			request_resource(res, &crashk_res);
>>
>> With both crashk_low_res and crashk_res, we end up with two entries in /proc/iomem called
>> "Crash kernel". Because its sorted by address, and kexec-tools stops searching when it
>> find "Crash kernel", you are always going to get the kernel placed in the lower portion.
>>
>> I suspect this isn't what you want, can we rename crashk_low_res for arm64 so that
>> existing kexec-tools doesn't use it?

> In my patchset, in addition to the kernel patches, i also modify the kexec-tools.
>   arm64: support more than one crash kernel regions(http://lists.infradead.org/pipermail/kexec/2019-April/022792.html).
> In kexec-tools patch, we read all the "Crash kernel" entry and load crash kernel high.

But we can't rely on people updating user-space when they update the kernel!

[...]


>> I'm afraid you've missed the ugly bit of the crashkernel reservation...
>>
>> arch/arm64/mm/mmu.c::map_mem() marks the crashkernel as 'nomap' during the first pass of
>> page-table generation. This means it isn't mapped in the linear map. It then maps it with
>> page-size mappings, and removes the nomap flag.
>>
>> This is done so that arch_kexec_protect_crashkres() and
>> arch_kexec_unprotect_crashkres() can remove the valid bits of the crashkernel mapping.
>> This way the old-kernel can't accidentally overwrite the crashkernel. It also saves us if
>> the old-kernel and the crashkernel use different memory attributes for the mapping.
>>
>> As your low-memory reservation is intended to be used for devices, having it mapped by the
>> old-kernel as cacheable memory is going to cause problems if those CPUs aren't taken
>> offline and go corrupting this memory. (we did crash for a reason after all)
>>
>>
>> I think the simplest thing to do is mark the low region as 'nomap' in
>> reserve_crashkernel() and always leave it unmapped. We can then describe it via a
>> different string in /proc/iomem, something like "Crash kernel (low)". Older kexec-tools
>> shouldn't use it, (I assume its not using strncmp() in a way that would do this by
>> accident), and newer kexec-tools can know to describe it in the DT, but it can't write to it.

> I did miss the bit of the crashkernel reservation.
> I will fix this in next version.

I think all that is needed is to make the low-region nmap, and describe it via /proc/iomem
with a name where nothing will try and use it by accident.


Thanks,

James
