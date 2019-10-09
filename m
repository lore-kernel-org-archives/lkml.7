Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD65ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5672133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCAsZizJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfJIGaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:30:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33983 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfJIGaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:30:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so565918pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 23:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=w68/orlNscWNc/RUeRC/f2rPS8rnm+VfnzeAEKq1oho=;
        b=gCAsZizJ9a3a0D5hVnAfZkm/iL5uzpK6VAqTpzgEYwlxQ+3u652p3Y/VZBqO7FveWB
         Nq7EMGtdS4MC0QctnX0zHCHDvhnZYkGf941vE1ny/Ht9sX3Iq2kywSAR51MHKQWG1Ph4
         BUWNHY6OXqwubIpbWNafpxMIPZKcVg3f5OYwHMQ/rHHrjD0PmvvF6RHNsqXDzXzM65Jn
         XJP6RWKqNo0xUZDdqVVeGkLGlrfNu0pzbx68EYCiGEu6VKlp3PYFn4QdUAiBlwNFwiTM
         ULODzh/thFVYThjDakFi0rHFgulQUW7mX3lqdoGjCH98NZJdvXa/BVPCi7Cj+WAwQW3c
         6ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=w68/orlNscWNc/RUeRC/f2rPS8rnm+VfnzeAEKq1oho=;
        b=TLjBq6ICO/p8utG0rXT4t0KJulre6TyZ5/4158rKGhPc+vH+tbinv4vnrcTCL/s64P
         UBbCWJOuhCjasfLRNay/GrBqkEMUJAg6+ItZpFeVK9k2XrQSY24PGfzhVVHjYWanM4Qq
         3KT4z0YfWHhTfhjb1qp37EDsIN3ErkPqjo5OE7qeTlUB/eooL/CPp0gnG5IR8z6I6Zor
         oHPHGC6Qj0d8U6qNOfqpjLBsX3U/fMbSMXHwuED1IiBomXbznV35d7bp/DVUqi6hvd34
         gj5WBPhMCxKhJfDSUTFjG1G+g7aSys63CCGQd9YwkTnWu+hkwXjIBm5U9hctB/sL38ox
         IHmg==
X-Gm-Message-State: APjAAAUIVxvZrLabqyXKdfvpvc7+W+DM37kQnuDt2bYPuM956uiX531s
        SbNyt0xm8/IY1heXOetTw3c=
X-Google-Smtp-Source: APXvYqxkfVNDvqvamqZYmknXHRyR5WvVmjl5du1D4+hbKLSxzIltzJwTMLTMlINKS6fH0aPAUAiFVg==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr1528070plo.247.1570602602062;
        Tue, 08 Oct 2019 23:30:02 -0700 (PDT)
Received: from [0.0.0.0] (104.129.187.94.16clouds.com. [104.129.187.94])
        by smtp.gmail.com with ESMTPSA id f185sm1284523pfb.183.2019.10.08.23.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 23:30:00 -0700 (PDT)
Subject: Re: [PATCH v10 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Justin He (Arm Technology China)" <Justin.He@arm.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20190930015740.84362-1-justin.he@arm.com>
 <20190930015740.84362-2-justin.he@arm.com>
 <20191001125446.gknoofnm7az4wqf5@willie-the-truck>
 <20191001141848.762296bd@why>
 <DB7PR08MB30824EFD975EE9BACAC7FD52F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
 <e4fc5be5-8594-121a-198b-17ca7486dd3a@arm.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <1b28b20c-bc10-dbf6-aa78-afd985cf8920@gmail.com>
Date:   Wed, 9 Oct 2019 14:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e4fc5be5-8594-121a-198b-17ca7486dd3a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki

On 2019/10/8 23:32, Suzuki K Poulose wrote:
>
>
> On 08/10/2019 02:12, Justin He (Arm Technology China) wrote:
>> Hi Will and Marc
>> Sorry for the late response, just came back from a vacation.
>>
>>> -----Original Message-----
>>> From: Marc Zyngier <maz@kernel.org>
>>> Sent: 2019年10月1日 21:19
>>> To: Will Deacon <will@kernel.org>
>>> Cc: Justin He (Arm Technology China) <Justin.He@arm.com>; Catalin
>>> Marinas <Catalin.Marinas@arm.com>; Mark Rutland
>>> <Mark.Rutland@arm.com>; James Morse <James.Morse@arm.com>;
>>> Matthew Wilcox <willy@infradead.org>; Kirill A. Shutemov
>>> <kirill.shutemov@linux.intel.com>; linux-arm-kernel@lists.infradead.org;
>>> linux-kernel@vger.kernel.org; linux-mm@kvack.org; Punit Agrawal
>>> <punitagrawal@gmail.com>; Thomas Gleixner <tglx@linutronix.de>;
>>> Andrew Morton <akpm@linux-foundation.org>; hejianet@gmail.com; Kaly
>>> Xin (Arm Technology China) <Kaly.Xin@arm.com>
>>> Subject: Re: [PATCH v10 1/3] arm64: cpufeature: introduce helper
>>> cpu_has_hw_af()
>>>
>>> On Tue, 1 Oct 2019 13:54:47 +0100
>>> Will Deacon <will@kernel.org> wrote:
>>>
>>>> On Mon, Sep 30, 2019 at 09:57:38AM +0800, Jia He wrote:
>>>>> We unconditionally set the HW_AFDBM capability and only enable it on
>>>>> CPUs which really have the feature. But sometimes we need to know
>>>>> whether this cpu has the capability of HW AF. So decouple AF from
>>>>> DBM by new helper cpu_has_hw_af().
>>>>>
>>>>> Signed-off-by: Jia He <justin.he@arm.com>
>>>>> Suggested-by: Suzuki Poulose <Suzuki.Poulose@arm.com>
>>>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>> ---
>>>>>   arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
>>>>>   1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/cpufeature.h
>>> b/arch/arm64/include/asm/cpufeature.h
>>>>> index 9cde5d2e768f..949bc7c85030 100644
>>>>> --- a/arch/arm64/include/asm/cpufeature.h
>>>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>>>> @@ -659,6 +659,16 @@ static inline u32
>>> id_aa64mmfr0_parange_to_phys_shift(int parange)
>>>>>    default: return CONFIG_ARM64_PA_BITS;
>>>>>    }
>>>>>   }
>>>>> +
>>>>> +/* Check whether hardware update of the Access flag is supported */
>>>>> +static inline bool cpu_has_hw_af(void)
>>>>> +{
>>>>> + if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
>>>>> +         return read_cpuid(ID_AA64MMFR1_EL1) & 0xf;
>>>>
>>>> 0xf? I think we should have a mask in sysreg.h for this constant.
>>>
>>> We don't have the mask, but we certainly have the shift.
>>>
>>> GENMASK(ID_AA64MMFR1_HADBS_SHIFT + 3,
>>> ID_AA64MMFR1_HADBS_SHIFT) is a bit
>>> of a mouthful though. Ideally, we'd have a helper for that.
>>>
>> Ok, I will implement the helper if there isn't so far.
>> And then replace the 0xf with it.
>
> Or could we simpl reuse existing cpuid_feature_extract_unsigned_field() ?
>
> u64 mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
>
> return cpuid_feature_extract_unsigned_field(mmfr1, ID_AA64MMFR1_HADBS_SHIFT) ?
>
Yes, we can, I will send the new version

---
Cheers,
Justin (Jia He)

