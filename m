Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2261FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B9D20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfDWDYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:24:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:14834 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbfDWDYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:24:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 20:24:02 -0700
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; 
   d="scan'208";a="136515140"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.121]) ([10.239.196.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 22 Apr 2019 20:24:01 -0700
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
 <20190422183553.GH1236@linux.intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <bccc075c-68ce-6324-6f73-4d4e9a1d9683@linux.intel.com>
Date:   Tue, 23 Apr 2019 11:23:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422183553.GH1236@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/23 2:35, Sean Christopherson wrote:
> On Mon, Apr 22, 2019 at 02:40:34PM +0800, Like Xu wrote:
>> Expose Intel V2 Extended Topology Enumeration Leaf to guest only when
>> host system has multiple software-visible die within each package.
>>
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index fd39516..9fc14f2 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -65,6 +65,16 @@ u64 kvm_supported_xcr0(void)
>>   	return xcr0;
>>   }
>>   
>> +/* We need to check if the host cpu has multi-chip packaging technology. */
>> +static bool kvm_supported_intel_mcp(void)
>> +{
>> +	u32 eax, ignored;
>> +
>> +	cpuid_count(0x1f, 0, &eax, &ignored, &ignored, &ignored);
>> +
>> +	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && (eax != 0);
>> +}
>> +
>>   #define F(x) bit(X86_FEATURE_##x)
>>   
>>   int kvm_update_cpuid(struct kvm_vcpu *vcpu)
>> @@ -426,6 +436,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>>   	switch (function) {
>>   	case 0:
>>   		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
>> +		entry->eax = kvm_supported_intel_mcp() ? 0x1f : entry->eax;
> 
> This all seems unnecessary.  And by 'all', I mean the existing Intel PT
> and XSAVE leaf checks, as well as the new mcp check.  entry->eax comes
> directly from hardware, and unless I missed something, PT and XSAVE are
> only exposed to the guest when they're supported in hardware.  In other
> words, KVM will never need to adjust entry->eax to expose PT or XSAVE.

We call this function for both case KVM_GET_SUPPORTED_CPUID and 
KVM_GET_EMULATED_CPUID although kvm user could reconfig them via 
KVM_SET_CPUID* path.

> 
> The original min() check was added by commit 0771671749b5 ("KVM: Enhance
> guest cpuid management"), which doesn't provide any explicit information
> on why KVM does min() in the first place.  

Exposing cpuid.0.eax in a blind way (with host hardware support)
is not a good practice for guest migration and improves compatibility 
requirements.

> Given that the original code
> was "entry->eax = min(entry->eax, (u32)0xb);", my *guess* is that the
> idea was to always report "Extended Topology Enumeration Leaf" as
> supported so that userspace can enumerate the VM's topology to the guest
> even when hardware itself doesn't do so.

If the host cpu mode is too antiquated to support 0xb, it wouldn't 
report 0xb for sure. The host cpuid.0.eax has been over 0xb for a long 
time and reached 0x1f in the latest SDM.

AFAICT, the original code keeps minimum cpuid.0.eax out of features 
guest just used or at least it claimed to use.

> 
> Assuming we want to allow userspace to use "V2 Extended Topology
> Enumeration Leaf" regardless of hardware support, then this can simply be:
> 
>    entry->eax = min(entry->eax, (u32)0x1f);
> 
> Or am I completely missing something?
> 
>>   		break;
>>   	case 1:
>>   		entry->edx &= kvm_cpuid_1_edx_x86_features;
>> @@ -544,6 +555,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>>   		entry->edx = edx.full;
>>   		break;
>>   	}
>> +	/* function 0x1f has additional index. */
> 
> The original comment is rather useless, it's obvious from the code that
> it has additional indices.  No need to repeat its sins.  A more useful
> comment would be to explain that 0x1f and 0xb have identical formats and
> thus can be handled by common code.

I agree and let me fix it in next version.

> 
> Which begs the question, why does leaf 0x1f exist?  AFAICT the only
> difference is that 0x1f supports additional "level types", but 0x1f's
> types are backwards compatibile.  Any idea why leaf 0xb wasn't simply
> extended for the new types?

It's not just about backwards compatibility on numerical parsing.

So many software (whatever OS and applications) are using 0x1b
to get CPU topology. In most cases, they (legacy code) would assume that 
the next level of CORE is package (at lease for Intel) not die and it's 
a semantic conflict if we reuse 0xb.

As said in SDM, Intel recommends first checking for the existence of 
Leaf 1FH and using this if available.

> 
>> +	case 0x1f:
>>   	/* function 0xb has additional index. */
>>   	case 0xb: {
>>   		int i, level_type;
>> -- 
>> 1.8.3.1
>>
> 

