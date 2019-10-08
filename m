Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68174C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A2820659
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJHPcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:32:05 -0400
Received: from foss.arm.com ([217.140.110.172]:39410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfJHPcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:32:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC121570;
        Tue,  8 Oct 2019 08:32:04 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0E883F68E;
        Tue,  8 Oct 2019 08:32:02 -0700 (PDT)
Subject: Re: [PATCH v10 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
To:     "Justin He (Arm Technology China)" <Justin.He@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        James Morse <James.Morse@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20190930015740.84362-1-justin.he@arm.com>
 <20190930015740.84362-2-justin.he@arm.com>
 <20191001125446.gknoofnm7az4wqf5@willie-the-truck>
 <20191001141848.762296bd@why>
 <DB7PR08MB30824EFD975EE9BACAC7FD52F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e4fc5be5-8594-121a-198b-17ca7486dd3a@arm.com>
Date:   Tue, 8 Oct 2019 16:32:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <DB7PR08MB30824EFD975EE9BACAC7FD52F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2019 02:12, Justin He (Arm Technology China) wrote:
> Hi Will and Marc
> Sorry for the late response, just came back from a vacation.
> 
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>
>> Sent: 2019Äê10ÔÂ1ÈÕ 21:19
>> To: Will Deacon <will@kernel.org>
>> Cc: Justin He (Arm Technology China) <Justin.He@arm.com>; Catalin
>> Marinas <Catalin.Marinas@arm.com>; Mark Rutland
>> <Mark.Rutland@arm.com>; James Morse <James.Morse@arm.com>;
>> Matthew Wilcox <willy@infradead.org>; Kirill A. Shutemov
>> <kirill.shutemov@linux.intel.com>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; linux-mm@kvack.org; Punit Agrawal
>> <punitagrawal@gmail.com>; Thomas Gleixner <tglx@linutronix.de>;
>> Andrew Morton <akpm@linux-foundation.org>; hejianet@gmail.com; Kaly
>> Xin (Arm Technology China) <Kaly.Xin@arm.com>
>> Subject: Re: [PATCH v10 1/3] arm64: cpufeature: introduce helper
>> cpu_has_hw_af()
>>
>> On Tue, 1 Oct 2019 13:54:47 +0100
>> Will Deacon <will@kernel.org> wrote:
>>
>>> On Mon, Sep 30, 2019 at 09:57:38AM +0800, Jia He wrote:
>>>> We unconditionally set the HW_AFDBM capability and only enable it on
>>>> CPUs which really have the feature. But sometimes we need to know
>>>> whether this cpu has the capability of HW AF. So decouple AF from
>>>> DBM by new helper cpu_has_hw_af().
>>>>
>>>> Signed-off-by: Jia He <justin.he@arm.com>
>>>> Suggested-by: Suzuki Poulose <Suzuki.Poulose@arm.com>
>>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>>> ---
>>>>   arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/cpufeature.h
>> b/arch/arm64/include/asm/cpufeature.h
>>>> index 9cde5d2e768f..949bc7c85030 100644
>>>> --- a/arch/arm64/include/asm/cpufeature.h
>>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>>> @@ -659,6 +659,16 @@ static inline u32
>> id_aa64mmfr0_parange_to_phys_shift(int parange)
>>>>    default: return CONFIG_ARM64_PA_BITS;
>>>>    }
>>>>   }
>>>> +
>>>> +/* Check whether hardware update of the Access flag is supported */
>>>> +static inline bool cpu_has_hw_af(void)
>>>> +{
>>>> + if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
>>>> +         return read_cpuid(ID_AA64MMFR1_EL1) & 0xf;
>>>
>>> 0xf? I think we should have a mask in sysreg.h for this constant.
>>
>> We don't have the mask, but we certainly have the shift.
>>
>> GENMASK(ID_AA64MMFR1_HADBS_SHIFT + 3,
>> ID_AA64MMFR1_HADBS_SHIFT) is a bit
>> of a mouthful though. Ideally, we'd have a helper for that.
>>
> Ok, I will implement the helper if there isn't so far.
> And then replace the 0xf with it.

Or could we simpl reuse existing cpuid_feature_extract_unsigned_field() ?

u64 mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);

return cpuid_feature_extract_unsigned_field(mmfr1, ID_AA64MMFR1_HADBS_SHIFT) ?

Cheers
Suzuki
