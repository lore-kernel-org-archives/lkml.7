Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B750C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B6A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfCDMcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:32:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:31440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCDMcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:32:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 04:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="128857809"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2019 04:32:42 -0800
Message-ID: <801f811f52974ff7310c37812846ab93a8de6947.camel@linux.intel.com>
Subject: Re: [PATCH v4 16/17] kvm: x86: Add support IA32_CORE_CAPABILITY MSR
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        kvm@vger.kernel.org
Date:   Mon, 04 Mar 2019 20:32:44 +0800
In-Reply-To: <74630db9-2a83-cd72-73f6-8b9ef9b07313@redhat.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
         <1551494711-213533-17-git-send-email-fenghua.yu@intel.com>
         <74630db9-2a83-cd72-73f6-8b9ef9b07313@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 09:42 +0100, Paolo Bonzini wrote:
> On 02/03/19 03:45, Fenghua Yu wrote:
> > From: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > 
> > MSR IA32_CORE_CAPABILITY is a feature-enumerating MSR, bit 5 of which
> > reports the capability of enabling detection of split locks (will be
> > supported on future processors based on Tremont microarchitecture and
> > later).
> > 
> > Please check the latest Intel Architecture Instruction Set Extensions
> > and Future Features Programming Reference for more detailed information
> > on the MSR and the split lock bit.
> > 
> > 1. Expose it to user space as a feature-enumerating MSR, so that user
> > space can query it.
> > 
> > 2. Emualte MSR_IA32_CORE_CAPABILITY with vmx->core_capability. And add the
> > get and set handler of MSR_IA32_CORE_CAPABILITY.
> >    For uesrspace, it can set this MSR when customizing features of guest,
> > also it can read the value of this MSR of guest.
> >    For guest, as it's a feature-enumerating MSR, guest only can read it.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  1 +
> >  arch/x86/kvm/vmx/vmx.c          | 23 +++++++++++++++++++++++
> >  arch/x86/kvm/vmx/vmx.h          |  1 +
> >  arch/x86/kvm/x86.c              | 17 ++++++++++++++++-
> >  4 files changed, 41 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h
> > b/arch/x86/include/asm/kvm_host.h
> > index 180373360e34..208f15570d17 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1527,6 +1527,7 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long
> > ipi_bitmap_low,
> >  		    unsigned long icr, int op_64_bit);
> >  
> >  u64 kvm_get_arch_capabilities(void);
> > +u64 kvm_get_core_capability(void);
> >  void kvm_define_shared_msr(unsigned index, u32 msr);
> >  int kvm_set_shared_msr(unsigned index, u64 val, u64 mask);
> >  
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 30a6bcd735ec..3e03c6e1e558 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -1679,6 +1679,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct
> > msr_data *msr_info)
> >  
> >  		msr_info->data = to_vmx(vcpu)->spec_ctrl;
> >  		break;
> > +	case MSR_IA32_CORE_CAPABILITY:
> > +		if (!msr_info->host_initiated &&
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_CORE_CAPABILITY))
> > +			return 1;
> > +		msr_info->data = vmx->core_capability;
> > +		break;
> >  	case MSR_IA32_ARCH_CAPABILITIES:
> >  		if (!msr_info->host_initiated &&
> >  		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
> > @@ -1891,6 +1897,21 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct
> > msr_data *msr_info)
> >  		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap,
> > MSR_IA32_PRED_CMD,
> >  					      MSR_TYPE_W);
> >  		break;
> > +	case MSR_IA32_CORE_CAPABILITY:
> > +		if (!msr_info->host_initiated)
> > +			return 1;
> > +		if (data & ~CORE_CAP_SPLIT_LOCK_DETECT)
> > +			return 1;
> > +
> > +		/*
> > +		 * Since AC split lock is a hardware feature, and there is no
> > +		 * software emulation yet, we cannot enable it for guest if
> > +		 * host hardware doesn't support it.
> > +		 */
> > +		if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
> > +			data &= ~CORE_CAP_SPLIT_LOCK_DETECT;
> > +		vmx->core_capability = data;
> > +		break;
> >  	case MSR_IA32_ARCH_CAPABILITIES:
> >  		if (!msr_info->host_initiated)
> >  			return 1;
> > @@ -4083,6 +4104,8 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
> >  		++vmx->nmsrs;
> >  	}
> >  
> > +	vmx->core_capability = kvm_get_core_capability();
> > +
> >  	vmx->arch_capabilities = kvm_get_arch_capabilities();
> >  
> >  	vm_exit_controls_init(vmx, vmx_vmexit_ctrl());
> > diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> > index 0ac0a64c7790..cc22379991f3 100644
> > --- a/arch/x86/kvm/vmx/vmx.h
> > +++ b/arch/x86/kvm/vmx/vmx.h
> > @@ -191,6 +191,7 @@ struct vcpu_vmx {
> >  	u64		      msr_guest_kernel_gs_base;
> >  #endif
> >  
> > +	u64		      core_capability;
> >  	u64		      arch_capabilities;
> >  	u64		      spec_ctrl;
> >  
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 941f932373d0..c3c9e3f2d08a 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -1125,7 +1125,8 @@ static u32 msrs_to_save[] = {
> >  #endif
> >  	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
> >  	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
> > -	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES,
> > +	MSR_IA32_SPEC_CTRL, MSR_IA32_CORE_CAPABILITY,
> > +	MSR_IA32_ARCH_CAPABILITIES,
> >  	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
> >  	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
> >  	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
> > @@ -1197,11 +1198,22 @@ static u32 msr_based_features[] = {
> >  
> >  	MSR_F10H_DECFG,
> >  	MSR_IA32_UCODE_REV,
> > +	MSR_IA32_CORE_CAPABILITY,
> >  	MSR_IA32_ARCH_CAPABILITIES,
> >  };
> >  
> >  static unsigned int num_msr_based_features;
> >  
> > +u64 kvm_get_core_capability(void)
> > +{
> > +	u64 data;
> > +
> > +	rdmsrl_safe(MSR_IA32_CORE_CAPABILITY, &data);
> 
> This patch should be merged with the previous patch.  Also here you
> should add:
> 
> 	data &= CORE_CAP_SPLIT_LOCK_DETECT;
> 
> so that non-virtualizable features are hidden and
> 
> 	if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
> 		data |= CORE_CAP_SPLIT_LOCK_DETECT;
> 
> so that userspace gets "for free" the FMS list that will be added
> later to the kernel.
> 
> Thanks,
> 
> Paolo

You are right. I'll correct it in next version.

> > +
> > +	return data;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_get_core_capability);
> > +
> >  u64 kvm_get_arch_capabilities(void)
> >  {
> >  	u64 data;
> > @@ -1227,6 +1239,9 @@ EXPORT_SYMBOL_GPL(kvm_get_arch_capabilities);
> >  static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
> >  {
> >  	switch (msr->index) {
> > +	case MSR_IA32_CORE_CAPABILITY:
> > +		msr->data = kvm_get_core_capability();
> > +		break;
> >  	case MSR_IA32_ARCH_CAPABILITIES:
> >  		msr->data = kvm_get_arch_capabilities();
> >  		break;
> > 
> 
> 

