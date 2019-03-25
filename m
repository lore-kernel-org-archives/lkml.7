Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30761C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0856820896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfCYPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:47:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:43920 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfCYPrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:47:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 08:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="128509561"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga008.jf.intel.com with ESMTP; 25 Mar 2019 08:47:05 -0700
Date:   Mon, 25 Mar 2019 08:47:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        chao.gao@intel.com
Subject: Re: [PATCH v3 2/2] x86/vmx: optimize MSR_MISC_FEATURES_ENABLES switch
Message-ID: <20190325154705.GD31069@linux.intel.com>
References: <20190325080650.19896-1-xiaoyao.li@linux.intel.com>
 <20190325080650.19896-3-xiaoyao.li@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325080650.19896-3-xiaoyao.li@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:06:50PM +0800, Xiaoyao Li wrote:
> KVM needs to switch MSR_MISC_FEATURES_ENABLES between host and guest in
> every pcpu/vcpu context switch. Since WRMSR is expensive, this patch tries
> to save cycles by avoiding WRMSR MSR_MISC_FEATURES_ENABLES whenever possible.
> 
> If host's value is zero, nothing needs to be done, since guest can use
> kvm emulated cpuid faulting.
> 
> If host's value is non-zero, it need not clear MSR_MISC_FEATURES_ENABLES
> unconditionally. We can use hardware cpuid faulting if guest's
> value is equal to host'value, thus avoid WRMSR
> MSR_MISC_FEATURES_ENABLES.
> 
> Since hardware cpuid faulting takes higher priority than CPUID vm exit,
> it should be updated to hardware while guest wrmsr and hardware cpuid
> faulting is used for guest.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/vmx/vmx.c          | 13 ++++++++++---
>  arch/x86/kvm/x86.c              | 15 ++++++++++++---
>  3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 2c53df4a5a2a..9bcb444b903d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1343,6 +1343,8 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
>  void kvm_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
>  int kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
>  
> +int kvm_supported_msr_misc_features_enables(struct kvm_vcpu *vcpu, u64 data);
> +
>  int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
>  int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 65aa947947ba..73bb11f74b36 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1035,10 +1035,10 @@ static void vmx_prepare_guest_misc_features_enables(struct vcpu_vmx *vmx)
>  {
>  	u64 msrval = this_cpu_read(msr_misc_features_shadow);
>  
> -	if (!msrval)
> +	if (!msrval || msrval == vmx->vcpu.arch.msr_misc_features_enables)
>  		return;
>  
> -	wrmsrl(MSR_MISC_FEATURES_ENABLES, 0ULL);
> +	wrmsrl(MSR_MISC_FEATURES_ENABLES, vmx->vcpu.arch.msr_misc_features_enables);
>  }
>  
>  void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
> @@ -1136,7 +1136,7 @@ static void vmx_load_host_misc_features_enables(struct vcpu_vmx *vmx)
>  {
>  	u64 msrval = this_cpu_read(msr_misc_features_shadow);
>  
> -	if (!msrval)
> +	if (!msrval || msrval == vmx->vcpu.arch.msr_misc_features_enables)
>  		return;
>  
>  	wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
> @@ -2043,6 +2043,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		else
>  			vmx->pt_desc.guest.addr_a[index / 2] = data;
>  		break;
> +	case MSR_MISC_FEATURES_ENABLES:
> +		if (!kvm_supported_msr_misc_features_enables(vcpu, data))
> +			return 1;
> +		if (this_cpu_read(msr_misc_features_shadow) && vmx->loaded_cpu_state)
> +			wrmsrl(MSR_MISC_FEATURES_ENABLES, data);
> +		vcpu->arch.msr_misc_features_enables = data;
> +		break;
>  	case MSR_TSC_AUX:
>  		if (!msr_info->host_initiated &&
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ad1df965574e..d2af90422a51 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2449,6 +2449,17 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
>  		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
>  }
>  
> +int kvm_supported_msr_misc_features_enables(struct kvm_vcpu *vcpu, u64 data)

The name kvm_supported_msr_misc_features_enables() is a bit confusing,
e.g. I expected it to return a bitmask of the supported features.  Maybe
kvm_misc_features_enables_msr_valid() to be consistent with
vmx_feature_control_msr_valid()?

> +{
> +	if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
> +	    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
> +	     !supports_cpuid_fault(vcpu)))
> +		return 0;
> +	else
> +		return 1;

No need for the if-else, you can simply do:

	return (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
	       (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
		!supports_cpuid_fault(vcpu));

You could even shorten it to:

        return (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
               (data && !supports_cpuid_fault(vcpu));

although that might be getting a bit too cute.

> +}
> +EXPORT_SYMBOL_GPL(kvm_supported_msr_misc_features_enables);
> +
>  int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
>  	bool pr = false;
> @@ -2669,9 +2680,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		vcpu->arch.msr_platform_info = data;
>  		break;
>  	case MSR_MISC_FEATURES_ENABLES:
> -		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
> -		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
> -		     !supports_cpuid_fault(vcpu)))
> +		if (!kvm_supported_msr_misc_features_enables(vcpu, data))
>  			return 1;
>  		vcpu->arch.msr_misc_features_enables = data;
>  		break;
> -- 
> 2.19.1
> 
