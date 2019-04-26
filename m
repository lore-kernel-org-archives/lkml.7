Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05DBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B70A206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfDZBad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:30:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:36502 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfDZBad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 21:30:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 18:30:32 -0700
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; 
   d="scan'208";a="137552610"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.118]) ([10.239.196.118])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 25 Apr 2019 18:30:30 -0700
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
 <20190424143238.GB18442@linux.intel.com>
 <bcc3a8ea-1fd0-124c-c472-7c096e0f8014@linux.intel.com>
 <c5d7dd8a51c606f38314ef4c7bb0702caeecbe7e.camel@intel.com>
 <30857e40-05b6-0f4c-d07c-919de08c90ac@linux.intel.com>
 <be509b34ba01a22845363aeb0b0f053f25c2d9c1.camel@intel.com>
 <7568a794-2e91-c84c-5b64-d33e394f0e2b@linux.intel.com>
 <20190425141944.GA31197@linux.intel.com>
 <5203b6ee-4a14-64b7-0237-dae2a977054d@linux.intel.com>
 <6df520272ae8874fbc06d60664f17b518d9b8c5e.camel@intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <300e920b-03b6-2874-df6a-02e596f6cf96@linux.intel.com>
Date:   Fri, 26 Apr 2019 09:30:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6df520272ae8874fbc06d60664f17b518d9b8c5e.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/26 0:28, Xiaoyao Li wrote:
> On Thu, 2019-04-25 at 23:33 +0800, Like Xu wrote:
>> On 2019/4/25 22:19, Sean Christopherson wrote:
>>> On Thu, Apr 25, 2019 at 03:07:35PM +0800, Like Xu wrote:
>>>> On 2019/4/25 14:30, Xiaoyao Li wrote:
>>>>>>> Besides, the problem of simply using cpuid_exc(0x1f) in Sean's codes
>>>>>>> is
>>>>>>> that we cannot assmue the reserved bits 31:16 of ECX is always 0 for
>>>>>>> the
>>>>>>> future generation.
>>>
>>> It doesn't matter if future CPUs use 31:16 for other things since this
>>> code only cares about whether or not CPUID.1F exists.  The check
>>> entry->eax >= 0x1f ensures that CPUID.1F will return zeros if the leaf
>>> does *NOT* exist, ergo the check against CPUID.1F.ECX only needs to
>>> look for a non-zero value.  CPUID.1F.ECX is the logical choice for
>>> detecting support because it is guaranteed to be non-zero if the leaf
>>> actually exists (because bits 15:8 will be non-zero).  Whether or not
>>> bits 31:16 are non-zero is irrelevant.
>>
>> Here is a case:
>>
>> one future CPU may have "cpuid.0.eax > 0x1f" but not use multi-chip
>> packaging technology thus its CPUID.1F leaf **could** not exist to
>> expose multi-die info and it still use cpuid.0B leaf.
>>
>> So the entry->eax >= 0x1f check is true and cpuid_ecx(0x1f) check is
>> true as well due to default return value. (one of my machines for
>> cpuid.1f.ecx would return 0x00000064 without cpuid.1f support).
> 
> You mean entry->eax >= 0x1f, and CPUID.1F leaf doesn't exist.
> In this case, cpuid_ecx(0x1f) must be zero.
> 
> You should the descripton of CPUID instruction in SDM. It says:
> 
>     If a value entered for CPUID.EAX is less than or equal to the maximum input
>     value and the leaf is not supported on that processor then 0 is returned in
>     all the registers.

It's true.

> 
> I can tell you why the cpuid.1f.exc return 0x00000064 in your machines.
> That's the value of leaf 0x16, you can check the output of cpuid.0x0_eax, it
> should be 0x00000016.

I have to mention in this case, the cpuid.1f.ecx[31:8] is 0 as well.

> 
>> When we only cares about whether or not CPUID.1F exists,
>> we may need (cpuid_ecx(0x1f) & 0x0000ff00) != 0 or just follow what host
>> check_extended_topology_leaf() does.
>>>
>>>>>>
>>>>>> It's true cause the statement in public spec is not "Reserved = 0" but
>>>>>> "Bits 31 - 16: Reserved".
>>>>>>
>>>>>>>
>>>>>>> In my opinion, Sean's codes is OK and much simple and clear.
>>>>>>
>>>>>> If the host cpuid.0.eax is greater than 0x1f but actually it doesn't
>>>>>> have multi-chip packaging technology and we may want to expose
>>>>>> entry->eax to some value smaller than 0x1f but greater than 0x14, much
>>>>>> effort needs to apply on Sean's code.
>>>>>>
>>>>>> My improvement is good to overwrite cpuid.0.eax in future usage
>>>>>> from the perspective of kvm feature setting not just from value check.
>>>>>
>>>>> Alright, there is something wrong in your code that you haven't
>>>>> realised.
>>>>>
>>>>> When you do
>>>>> 	entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
>>>>>
>>>>> it changes the entry->eax if entry->eax > 0x14. So you cannot directly
>>>>> use
>>>>> cpuid_ecx(0x1f). At least, you need to cache the value of entry->eax,
>>>>> like:
>>>>> 	
>>>>> 	u32 max_leaf = entry->eax;
>>>>> 	entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
>>>>> 	
>>>>> 	//...leaf between 0x14 and 0x1f
>>>>> 	
>>>>> 	if (max_leaf >= 0x1f && (cpuid_ecx(0x1f) & 0x0000ff00))
>>>>>    		entry->eax = 0x1f;
>>>>
>>>> The cache value make no sense on this.
>>>
>>> Xiaoyao is pointing out that by limiting entry->eax to 0x14 (or 0xd), then
>>> it can't be used to detect support for CPUID.1F since KVM will have lost
>>> the required information.
>>
>> The point is that its existence does not really depend on cpuid.0.eax> =
>> 0x1f. My test machine (CLX-AP, two die in one package) has cpuid.0.eax =
>> 0x16 but does have CPUID.1F support (a bit strange on BIOS).
> 
> I think it must be something wrong with your CLX-AP.
> I tested on my CLX-AP machine too, the cpuid.0x0_eax is 0x000000001f.

You are suggesting that we should give up exposing cpuid.1f on this 
strange machine and it's not **practical**.

One of my CLX-AP machines is normal, but there is such another machine 
with a bad BIOS configuration. We are supposed to take advantage of the 
real hardware support instead of ignoring it just because of the 
cpuid.0.eax limit.

> 
>>>
>>>>> However, handling in increasing order in totally wrong. Since it's to
>>>>> report the
>>>>> max the leaf supported, we should handle in descending order, which is
>>>>> what Sean
>>>>> does.
>>>>
>>>> There is no need to check "entry->eax >= 0x1f" before "setting entry->eax
>>>> =
>>>> 0x1f" if and only if cpuid_ecx(0x1f) meets requirements.
>>>
>>> entry->eax absolutely needs to be checked, otherwise you have no idea what
>>> CPUID leaf is actually being consumed.  For example, a CPU with a maximum
>>> basic CPUID leaf of 0xB will report information that is indistinguishable
>>> from the actual CPUID.1F, i.e. KVM will incorrectly think the CPU supports
>>> CPUID.1F regardless of what heuristic is used to detect a "valid" CPUID.1F
>>> if it only looks at the result of CPUID.1F.
>>
>> Based on what I mentioned, just reconsider this proposal:
>>
>> case 0:
>>       entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
>>       if ((cpuid_ecx(0x1f) & 0x0000ff00)) != 0)
>>           entry->eax = 0x1f;
>>
>> It increases the cpuid.0.ecx value along with the minimized feature
>> requirement in a natural and readable way. Why don't we design a little
>> bit future ahead of time?
> 
> There are two things I want to state:
> 
> 1. using cpuid_ecx(0x1f) to check the existence of leaf 1f is absolutely wrong.
> 
> Using the return value of E{A,B,C,D}X of cpuid leaf *N* to check the existence
> of leaf *N* is totally wrong. We need first to ensure that cpuid.0_eax >= *N*,
> that's the reason why we need cpuid.0_eax.
> 
> Specifically, about cpuid leaf 1f, in page 3-222 Vol.2A of latest SDM publish on
> January 2019, the description of Input EAX = 1FH is:
> 
>     When CPUID executes with EAX set to 1FH, the processor returns information
>     about extended topology enumeration data. Software must detect the presence
>     of CPUID leaf 1FH by verifying (a) the highest leaf index supported by CPUID
>     is >= 1FH, and (b) CPUID.1FH:EBX[15:0] reports a non-zero value.

It's true and it's the official right way to check EBX rather than ECX. 
Nice move, thanks xiaoyao.

However we could do better considering all possible output of 
cpuid.0.eax and cpuid.1f and my proposal for whether or not CPUID.1F 
exists is to check cpuid.1f.ecx[31:8] practically as host check does.

I don't insist on it and what do you think, Sean?

> 
> 2. Checking in descending manner is better that increasing manner.
> 
> In increasing manner, we have to check from the smallest one by one, there will
> be some useless check for the smaller one.

You see the uselessness and I see the necessity.
The number of checks time is not critical.

>     
> However, in descending manner, once it finds the supported maxmium one, there is
> no need to check the smaller leaf.

It's not supposed to finds the maxmium one but the minimum value
just recall the purpose of why we apply min().

The descending if_else flow would be broken if kvm does not want to 
expose 0x1f but a expected value smaller than 0x1f but larger than 0x14.

We may add this kind of module parameter like f_intel_pt to apply min() 
again and if so, an increasing manner helps a lot.

The descending flat flow couldn't reduce the number of checks time
and a temp value for original eax is introduced unavoidably.

> 
>>>
>>>> An increasing manner helps to overwrite this value on demand in a flat
>>>> code
>>>> flow (easy to understand and maintain) not an if-else_if-else flow.
>>>
>>> Maybe in the future the code will need to be refactored as more cases are
>>> added, but for now an if-else is quite readable.  Worry about the future
>>> when it happens. :-)
>>>
>>
>>
> 
> 

