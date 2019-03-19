Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60C220989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfCSEkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 00:40:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:2699 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbfCSEkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 00:40:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 21:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="126602726"
Received: from lxy-dell.sh.intel.com ([10.239.159.145])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 21:40:46 -0700
Message-ID: <085cc389df4d734ee173bb4c199776591d197a21.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] kvm/vmx: Using hardware cpuid faulting to avoid
 emulation overhead
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        chao.gao@intel.com
Date:   Tue, 19 Mar 2019 12:37:23 +0800
In-Reply-To: <20190318163832.GB13528@linux.intel.com>
References: <20190318114324.14198-1-xiaoyao.li@linux.intel.com>
         <20190318114324.14198-3-xiaoyao.li@linux.intel.com>
         <20190318163832.GB13528@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 09:38 -0700, Sean Christopherson wrote:
> On Mon, Mar 18, 2019 at 07:43:24PM +0800, Xiaoyao Li wrote:
> > Current cpuid faulting of guest is purely emulated in kvm, which exploits
> > CPUID vm exit to inject #GP to guest. However, if host hardware cpu has
> > X86_FEATURE_CPUID_FAULT, we can just use the hardware cpuid faulting for
> > guest to avoid the vm exit overhead.
> 
> Heh, I obviously didn't look at this patch before responding to patch 1/2.
> 
> > Note: cpuid faulting takes higher priority over CPUID instruction vm
> > exit (Intel SDM vol3.25.1.1).
> > 
> > Since cpuid faulting only exists on some Intel's cpu, just apply this
> > optimization to vmx.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  2 ++
> >  arch/x86/kvm/vmx/vmx.c          | 19 +++++++++++++++----
> >  arch/x86/kvm/x86.c              | 15 ++++++++++++---
> >  3 files changed, 29 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h
> > b/arch/x86/include/asm/kvm_host.h
> > index ce79d7bfe1fd..14cad587b804 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1339,6 +1339,8 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long
> > msw);
> >  void kvm_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
> >  int kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
> >  
> > +int kvm_supported_msr_misc_features_enables(struct kvm_vcpu *vcpu, u64
> > data);
> > +
> >  int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
> >  int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
> >  
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 2c59e0209e36..6b413e471dca 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -1037,7 +1037,7 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
> >  
> >  static void vmx_save_host_cpuid_fault(struct vcpu_vmx *vmx)
> >  {
> > -	u64 host_val;
> > +	u64 host_val, guest_val;
> >  
> >  	if (!boot_cpu_has(X86_FEATURE_CPUID_FAULT))
> >  		return;
> > @@ -1045,10 +1045,12 @@ static void vmx_save_host_cpuid_fault(struct
> > vcpu_vmx *vmx)
> >  	rdmsrl(MSR_MISC_FEATURES_ENABLES, host_val);
> >  	vmx->host_msr_misc_features_enables = host_val;
> >  
> > -	/* clear cpuid fault bit to avoid it leak to guest */
> > -	if (host_val & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) {
> > +	guest_val = vmx->vcpu.arch.msr_misc_features_enables;
> > +
> > +	/* we can use the hardware cpuid faulting to avoid emulation overhead */
> > +	if ((host_val ^ guest_val) & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) {
> >  		wrmsrl(MSR_MISC_FEATURES_ENABLES,
> > -		       host_val & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT);
> > +		       host_val ^ MSR_MISC_FEATURES_ENABLES_CPUID_FAULT);
> >  	}
> >  }
> >  
> > @@ -2057,6 +2059,15 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct
> > msr_data *msr_info)
> >  		else
> >  			vmx->pt_desc.guest.addr_a[index / 2] = data;
> >  		break;
> > +	case MSR_MISC_FEATURES_ENABLES:
> > +		if (!kvm_supported_msr_misc_features_enables(vcpu, data))
> > +			return 1;
> > +		if (boot_cpu_has(X86_FEATURE_CPUID_FAULT)) {
> > +			if (vmx->loaded_cpu_state)
> 
> No need for two separate if statements.  And assuming we're checking the
> existing shadow value when loading guest/host state, the WRMSR should
> only be done if the host's value is non-zero.

I'll combine these two if statements into one.

I cannot understand why the WRMSR should only be done if the host's value is
non-zero. I think there is no depedency with host's value, if using the hardware
cpuid faulting. We just need to set the value to real hardware MSR.

> > +				wrmsrl(MSR_MISC_FEATURES_ENABLES, data);
> > +		}
> > +		vcpu->arch.msr_misc_features_enables = data;
> > +		break;
> >  	case MSR_TSC_AUX:
> >  		if (!msr_info->host_initiated &&
> >  		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 434ec113cc79..33a8c95b2f2e 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -2449,6 +2449,17 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
> >  		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
> >  }
> >  
> > +int kvm_supported_msr_misc_features_enables(struct kvm_vcpu *vcpu, u64
> > data)
> > +{
> > +	if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
> > +	    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
> > +	     !supports_cpuid_fault(vcpu)))
> > +		return 0;
> > +	else
> > +		return 1;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_supported_msr_misc_features_enables);
> > +
> >  int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  {
> >  	bool pr = false;
> > @@ -2669,9 +2680,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct
> > msr_data *msr_info)
> >  		vcpu->arch.msr_platform_info = data;
> >  		break;
> >  	case MSR_MISC_FEATURES_ENABLES:
> > -		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
> > -		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
> > -		     !supports_cpuid_fault(vcpu)))
> > +		if (!kvm_supported_msr_misc_features_enables(vcpu, data))
> >  			return 1;
> >  		vcpu->arch.msr_misc_features_enables = data;
> >  		break;
> > -- 
> > 2.19.1
> > 

