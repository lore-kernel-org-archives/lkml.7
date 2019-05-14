Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0C1C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1BD20873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENTkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:40:20 -0400
Received: from foss.arm.com ([217.140.101.70]:60658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENTkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:40:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02321341;
        Tue, 14 May 2019 12:40:19 -0700 (PDT)
Received: from [192.168.3.111] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D8F83F575;
        Tue, 14 May 2019 12:40:16 -0700 (PDT)
Subject: Re: [PATCH v7 10/13] selftests/resctrl: Add vendor detection
 mechanism
To:     James Morse <james.morse@arm.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <1549767042-95827-11-git-send-email-fenghua.yu@intel.com>
 <20190510183909.65732a67@donnerap.cambridge.arm.com>
 <5cc3b562-6e48-f64c-06dd-b1ee1059e33e@arm.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <676ca766-fcd0-6b47-2961-92ef21ecf32e@arm.com>
Date:   Tue, 14 May 2019 20:40:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5cc3b562-6e48-f64c-06dd-b1ee1059e33e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2019 18:20, James Morse wrote:

Hi James,

> (thanks for digging into this!)
> 
> On 10/05/2019 18:39, Andre Przywara wrote:
>> On Sat,  9 Feb 2019 18:50:39 -0800
>> Fenghua Yu <fenghua.yu@intel.com> wrote:
>>> From: Babu Moger <babu.moger@amd.com>
>>>
>>> RESCTRL feature is supported both on Intel and AMD now. Some features
>>> are implemented differently. Add vendor detection mechanism. Use the vendor
>>> check where there are differences.
>>
>> I don't think vendor detection is the right approach. The Linux userland
>> interface should be even architecture agnostic, not to speak of different
>> vendors.
>>
>> But even if we need this for some reason ...
> 
>>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> index 3959b2b0671a..1d9adcfbdb4c 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>>> @@ -14,6 +14,66 @@
>>>  #define BENCHMARK_ARGS		64
>>>  #define BENCHMARK_ARG_SIZE	64
>>>  
>>> +/**
>>> + * This variables provides information about the vendor
>>> + */
>>> +int genuine_intel;
>>> +int authentic_amd;
>>> +
>>> +void lcpuid(const unsigned int leaf, const unsigned int subleaf,
>>> +	    struct cpuid_out *out)
>>
>> There is a much easier way to detect the vendor, without resorting to
>> (unchecked) inline assembly in userland:
> 
>> I changed this to scan /proc/cpuinfo for a line starting with vendor_id,
>> then use the information there. This should work everywhere.
> 
> Everywhere x86. /proc/cpuinfo is unfortunately arch specific, arm64 spells that field 'CPU
> implementer'. Short of invoking lscpu, I don't know a portable way of finding this string.

Well, what I meant is: It works everywhere to tell whether this box has
an x86 AMD CPU. Yes, it probably won't match anything on other
architectures, but that's fine, as at least it will compile and won't crash.

> What do we need it for? Surely it indicates something is wrong with the kernel interface
> if you need to know which flavour of CPU this is.

As you mentioned, we should not need it. I just couldn't find a better
way (yet) to differentiate between L3 cache ID and physical package ID
(see patch 11/13). So this is a kludge for now to not break this
particular code.

Out of curiosity: Is there any userland tool meant to control the
resources? I guess poking around in sysfs is not how admins are expected
to use this?
This tool would surely run into the same problems, which somewhat tell
me that the interface is not really right.

Cheers,
Andre.

> The only differences I've spotted are the 'MAX_MBA_BW' on Intel is a percentage, on AMD
> its a number between 1 and 2K. If user-space needs to know we could add another file with
> the 'max_bandwidth'. (I haven't spotted how the MBA default_ctrl gets exposed).
> 
> The other one is the non-contiguous CBM values, where user-space is expected to try it and
> see [0]. If user-space needs to know, we could expose some 'sparse_bitmaps=[0 1]', unaware
> user-space keeps working.
> 
> 
> Thanks,
> 
> James
> 
> [0] https://lore.kernel.org/patchwork/patch/991236/#1179944
> 

