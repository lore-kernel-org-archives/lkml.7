Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E071C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007FD2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDBU1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:27:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:20485 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDBU1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:27:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 13:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,302,1549958400"; 
   d="scan'208";a="147479615"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2019 13:27:33 -0700
Date:   Tue, 2 Apr 2019 13:27:33 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [RFC PATCH v4 4/8] KVM:VMX: Pass through host CET related MSRs
 to Guest.
Message-ID: <20190402202733.GI31303@linux.intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
 <20190318150351.15550-5-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318150351.15550-5-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:03:47PM +0800, Yang Weijiang wrote:
> The CET runtime settings, i.e., CET state control bits(IA32_U_CET/
> IA32_S_CET), CET SSP(IA32_PL3_SSP/IA32_PL0_SSP) and SSP table address
> (IA32_INTERRUPT_SSP_TABLE_ADDR) are task/thread specific, therefore,
> OS needs to save/restore the states properly during context switch,
> e.g., task/thread switching, interrupt/exception handling, it uses
> xsaves/xrstors to achieve that.
> 
> The difference between VMCS CET area fields and xsave CET area, is that
> the former is for state retention during Guest/Host context
> switch while the latter is for state retention during OS execution.
> 
> Linux currently doesn't support CPL1 and CPL2, so SSPs for these level
> are skipped here.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 53cef5a3db96..28b8ac027bd7 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11774,6 +11774,7 @@ static void nested_vmx_entry_exit_ctls_update(struct kvm_vcpu *vcpu)
>  static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	unsigned long *msr_bitmap;
>  
>  	if (cpu_has_secondary_exec_ctrls()) {
>  		vmx_compute_secondary_exec_control(vmx);
> @@ -11791,6 +11792,18 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
>  		nested_vmx_cr_fixed1_bits_update(vcpu);
>  		nested_vmx_entry_exit_ctls_update(vcpu);
>  	}
> +
> +	msr_bitmap = vmx->vmcs01.msr_bitmap;
> +
> +	if (guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) ||
> +	    guest_cpuid_has(vcpu, X86_FEATURE_IBT)) {
> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_U_CET, MSR_TYPE_RW);
> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_S_CET, MSR_TYPE_RW);
> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL0_SSP, MSR_TYPE_RW);

I thought we had agreed to pass-through PL1 and PL2, or am I misremembering?

> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL3_SSP, MSR_TYPE_RW);
> +	}
> +
>  }
>  
>  static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
> -- 
> 2.17.1
> 
