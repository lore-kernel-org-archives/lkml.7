Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9528BC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6894B218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfDXB7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:59:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:51063 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfDXB7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:59:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 18:59:53 -0700
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; 
   d="scan'208";a="136840568"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.111]) ([10.239.196.111])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 23 Apr 2019 18:59:51 -0700
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
 <20190422183553.GH1236@linux.intel.com>
 <bccc075c-68ce-6324-6f73-4d4e9a1d9683@linux.intel.com>
 <20190423174407.GC10720@linux.intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <37c014d8-7562-92e6-d577-ddbe3565ea8e@linux.intel.com>
Date:   Wed, 24 Apr 2019 09:59:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423174407.GC10720@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/24 1:44, Sean Christopherson wrote:
> On Tue, Apr 23, 2019 at 11:23:59AM +0800, Like Xu wrote:
>> On 2019/4/23 2:35, Sean Christopherson wrote:
>>>>   #define F(x) bit(X86_FEATURE_##x)
>>>>   int kvm_update_cpuid(struct kvm_vcpu *vcpu)
>>>> @@ -426,6 +436,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>>>>   	switch (function) {
>>>>   	case 0:
>>>>   		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
>>>> +		entry->eax = kvm_supported_intel_mcp() ? 0x1f : entry->eax;
>>>
>>> This all seems unnecessary.  And by 'all', I mean the existing Intel PT
>>> and XSAVE leaf checks, as well as the new mcp check.  entry->eax comes
>>> directly from hardware, and unless I missed something, PT and XSAVE are
>>> only exposed to the guest when they're supported in hardware.  In other
>>> words, KVM will never need to adjust entry->eax to expose PT or XSAVE.
>>
>> We call this function for both case KVM_GET_SUPPORTED_CPUID and
>> KVM_GET_EMULATED_CPUID although kvm user could reconfig them via
>> KVM_SET_CPUID* path.
> 
> Not that it matters, but __do_cpuid_ent() is only used for the non-emulated
> case, KVM_GET_EMULATED_CPUID goes to __do_cpuid_ent_emulated().

It's true and I have to mention we have two scenarios to get vCPUID:

1. For kvm_dev, we have KVM_GET_EMULATED_CPUID for 
kvm_dev_ioctl_get_cpuid; (we're talking about this)

2. For kvm_vcpu,we have KVM_GET_CPUID2 for kvm_vcpu_ioctl_get_cpuid2;

>   
>>> The original min() check was added by commit 0771671749b5 ("KVM: Enhance
>>> guest cpuid management"), which doesn't provide any explicit information
>>> on why KVM does min() in the first place.
>>
>> Exposing cpuid.0.eax in a blind way (with host hardware support)
>> is not a good practice for guest migration and improves compatibility
>> requirements.
> 
> Right, but isn't the f_intel_pt check for example completely irrelevant?
> f_intel_pt is true if and only if hardware supports PT, i.e. CPUID.0.EAX
> and thus entry->eax will already be >=0x14.

The f_intel_pt check is not only about hardware supports check but also 
module_param (pt_mode) supports check.

So the case is the host does have PT support which means (host 
CPUID.0.EAX already be >=0x14 for Intel CPUs) but kvm doesn't want 
advertise it and thus the min() operation is needed.

> 
> I don't fully understand whether or not KVM needs to raise the minimum to
> 0xb regardless of h/w XSAVE support, but it's likely irrelevant in the end.
> 
> Anyways, back to 0x1f, kvm_supported_intel_mcp() returns true if and only
> if hardware's CPUID.0.EAX >= 0x1f, 

According to latest SDM, the max hardware CPUID.0.EAX is 0x1f and BIOS 
would expose 0x1f only for multi-chip packaging CPUs (at least for now).

> i.e. adjusting entry->eax is always a
> nop.  So if KVM wants to advertise leaf 0x1f only when it's supported in
> hardware then adjusting entry->eax is unnecessary, and if KVM wants to
> unconditionally advertise 0x1f then adjusting entry->eax should also be
> done unconditionally.

It we have no check on kvm_supported_intel_mcp() in legacy code,
CPUID.0.EAX would be min() and thus less than 0x1f which means the 
cpuid.1f info is not exposed.

I know your point is to avoid min() totally (I thought so at the time) 
and I have pointed out it's necessary for kvm features setting.

If KVM wants to unconditionally advertise 0x1f (in EMULATED way),
kvm needs cover other side effects and this patch only advertises 0x1f
when hardware has it.

It's very common that guest wants to set 0x1f regardless of h/w support
and this is another story.

> 
>>> Given that the original code
>>> was "entry->eax = min(entry->eax, (u32)0xb);", my *guess* is that the
>>> idea was to always report "Extended Topology Enumeration Leaf" as
>>> supported so that userspace can enumerate the VM's topology to the guest
>>> even when hardware itself doesn't do so.
>>
>> If the host cpu mode is too antiquated to support 0xb, it wouldn't report
>> 0xb for sure. The host cpuid.0.eax has been over 0xb for a long time and
>> reached 0x1f in the latest SDM.
>>
>> AFAICT, the original code keeps minimum cpuid.0.eax out of features guest
>> just used or at least it claimed to use.
>>
>>>
>>> Assuming we want to allow userspace to use "V2 Extended Topology
>>> Enumeration Leaf" regardless of hardware support, then this can simply be:
>>>
>>>    entry->eax = min(entry->eax, (u32)0x1f);
>>>
>>> Or am I completely missing something?
> 

