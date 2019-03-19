Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD34C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173FB213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCSOSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:18:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:44885 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCSOSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:18:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 07:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="135582333"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga007.fm.intel.com with ESMTP; 19 Mar 2019 07:18:35 -0700
Date:   Tue, 19 Mar 2019 07:18:36 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        chao.gao@intel.com
Subject: Re: [PATCH v2 1/2] kvm/vmx: avoid CPUID faulting leaking to guest
Message-ID: <20190319141836.GA25575@linux.intel.com>
References: <20190318114324.14198-1-xiaoyao.li@linux.intel.com>
 <20190318114324.14198-2-xiaoyao.li@linux.intel.com>
 <20190318162336.GA13528@linux.intel.com>
 <676340c3796e588900658475dbbcb7d1c6e8ecfe.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676340c3796e588900658475dbbcb7d1c6e8ecfe.camel@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:26:55PM +0800, Xiaoyao Li wrote:
> Hi, Sean,
> 
> On Mon, 2019-03-18 at 09:23 -0700, Sean Christopherson wrote:
> > On Mon, Mar 18, 2019 at 07:43:23PM +0800, Xiaoyao Li wrote:
> > > cpuid faulting is a feature about CPUID instruction. When cpuif faulting
> > 
> >                                                             ^^^^^
> >                                                             cpuid
> > > is enabled, all execution of the CPUID instruction outside system-management
> > > mode (SMM) cause a general-protection (#GP) if the CPL > 0.
> > > 
> > > About this feature, detailed information can be found at
> > > 
> https://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf
> > > 
> > > Current KVM provides software emulation of this feature for guest.
> > > However, because cpuid faulting takes higher priority over CPUID vm exit
> > > (Intel
> > > SDM vol3.25.1.1), there is a risk of leaking cpuid faulting to guest when
> > > host
> > > enables it. If host enables cpuid faulting by setting the bit 0 of
> > > MSR_MISC_FEATURES_ENABLES, it will pass to guest since there is no handling
> > > of
> > > MSR_MISC_FEATURES_ENABLES yet. As a result, when guest calls CPUID
> > > instruction
> > > in CPL > 0, it will generate a #GP instead of CPUID vm eixt.
> > > 
> > > This issue will cause guest boot failure when guest uses *modprobe*
> > > to load modules. *modprobe* calls CPUID instruction, thus causing #GP in
> > > guest. Since there is no handling of cpuid faulting in #GP handler, guest
> > > fails boot.
> > > 
> > > To fix this issue, we should switch cpuid faulting bit between host and
> > > guest.
> > > Since MSR_MISC_FEATURES_ENABLES is intel-specific, this patch implement the
> > > switching only in vmx. It clears the cpuid faulting bit and save host's
> > > value before switching to guest, and restores the cpuid faulting settings of
> > > host before switching to host.
> > > 
> > > Because kvm provides the software emulation of cpuid faulting, we can
> > > just clear the cpuid faulting bit in hardware MSR when switching to
> > > guest.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > > ---
> > > Changes in v2:
> > > - move the save/restore of cpuid faulting bit to
> > > vmx_prepare_swich_to_guest/vmx_prepare_swich_to_host to avoid every
> > > vmentry RDMSR, based on Paolo's comment.
> > > 
> > > ---
> > >  arch/x86/kvm/vmx/vmx.c | 34 ++++++++++++++++++++++++++++++++++
> > >  arch/x86/kvm/vmx/vmx.h |  2 ++
> > >  2 files changed, 36 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 541d442edd4e..2c59e0209e36 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -1035,6 +1035,23 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
> > >  	wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
> > >  }
> > >  
> > > +static void vmx_save_host_cpuid_fault(struct vcpu_vmx *vmx)
> > 
> > Maybe vmx_load_guest_misc_features_enables()?  See below for reasoning.
> > Alternatively you can drop the helpers altogether.
> > 
> > > +{
> > > +	u64 host_val;
> > > +
> > > +	if (!boot_cpu_has(X86_FEATURE_CPUID_FAULT))
> > > +		return;
> > > +
> > > +	rdmsrl(MSR_MISC_FEATURES_ENABLES, host_val);
> > > +	vmx->host_msr_misc_features_enables = host_val;
> > 
> > There's no need to cache the host value in struct vcpu_vmx, just use the
> > kernel's shadow value.
> 
> you're right, thanks for pointing out this.
> 
> > > +
> > > +	/* clear cpuid fault bit to avoid it leak to guest */
> > 
> > Personally I find the comment unnecessary and somewhat misleading.
> > 
> > > +	if (host_val & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) {
> > > +		wrmsrl(MSR_MISC_FEATURES_ENABLES,
> > > +		       host_val & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT);
> > 
> > I think we can also skip WRMSR if CPUID faulting is also enabled in the
> 
> Right, the initial purpose of this patch is to clear hardware cpuid faulting bit
> for guest and just let guest use the kvm emulation of cpuid faulting.
> Using hardware cpuid faulting instead of kvm emulation is what the next patch
> doing.
> 
> It's Paolo's suggestion that splits it into 2 patches.

Agreed, two patches is better. 

> > guest.  It probably doesn't make sense to install the guest's value if
> > CPUID faulting is enabled in the guest and not host since intercepting
> > CPUID likely provides better overall performance than switching the MSR
> > on entry and exit.  And last but not least, since there are other bits
> 
> Actually, this MSR switching is not happening on every entry and exit, it clears
> host cpuid faulting only when vmx->loaded_cpu_state == NULL, and load host cpuid
> faulting only when vmx->loaded_cpu_state != NULL. Usually, in the vcpu_run loop,
> it switchs for once.

Whoops, yeah, every save/restore cycle.

> However, there indeed is a tradeoff between switching the MSR and intercepting
> CPUID. Using hardware cpuid faulting for guest, it needs to switch related MSR,
> which incurs wrmsr overhead. But using emulation, it has to suffer the overhead
> of vmexit with intercepting CPUID instruction.
> And I don't know which is better.
> 
> At this point, I think it makes sense to use 2 patches. One for fixing potential
> leaking issue that just clears cpuid faulting bit for guest, and the other
> writes guest cpuid faulting value to hardware bit to optimize performance (maybe
> it doesn't).   
> 
> > in the MSR that we don't want to expose to the guest, e.g. RING3MWAIT,
> > checking for a non-zero host value is probably better than checking for
> > individual feature bits.  Same reasoning for writing the guest's value
> > instead of clearing just the CPUID faulting bit.
> 
> About RING3MWAIT, I just let it go as without this patch.
> Since you pointed out *we* don't want to expose other bits in the MSR to the
> guest, I will clear the both bits in next version.

Clear all bits, i.e. write 0.  That way KVM doesn't need to be updated
if/when hardware introduces another bit.

> > 
> > So something like:
> > 
> > 	u64 msrval = this_cpu_read(msr_misc_features_shadow);
> > 
> > 	if (!msrval || msrval == vcpu->arch.msr_misc_features_enables)
> > 		return;
> > 
> > 	wrmsrl(MSR_MISC_FEATURES_ENABLES, vcpu->arch.msr_misc_features_enables);
> > 
> > 
> > or if you drop the helpers:
> > 
> > 	msrval = this_cpu_read(msr_misc_features_shadow);
> > 	if (msrval && msrval != vcpu->arch.msr_misc_features_enables)
> > 		wrmsrl(MSR_MISC_FEATURES_ENABLES,
> > 		       vcpu->arch.msr_misc_features_enables);
> > 
> > > +	}
> > > +}
> > > +
> > >  void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
> > >  {
> > >  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > > @@ -1068,6 +1085,8 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu
> > > *vcpu)
> > >  	vmx->loaded_cpu_state = vmx->loaded_vmcs;
> > >  	host_state = &vmx->loaded_cpu_state->host_state;
> > >  
> > > +	vmx_save_host_cpuid_fault(vmx);
> > > +
> > >  	/*
> > >  	 * Set host fs and gs selectors.  Unfortunately, 22.2.3 does not
> > >  	 * allow segment selectors with cpl > 0 or ti == 1.
> > > @@ -1124,6 +1143,19 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu
> > > *vcpu)
> > >  	}
> > >  }
> > >  
> > > +static void vmx_restore_host_cpuid_fault(struct vcpu_vmx *vmx)
> > 
> > If you keep the helpers, maybe vmx_load_host_misc_features_enables()
> > to pair with the new function name for loading guest state?
> > 
> > > +{
> > > +	u64 msrval;
> > > +
> > > +	if (!boot_cpu_has(X86_FEATURE_CPUID_FAULT))
> > > +		return;
> > > +
> > > +	rdmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
> > > +	msrval |= vmx->host_msr_misc_features_enables &
> > > +		MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
> > 
> > Again, there's no need for RDMSR, the host's value can be pulled from
> > msr_misc_features_shadow, and the WRMSR can be skipped if the host and
> > guest have the same value, i.e. we didn't install the guest's value.
> > 
> > 	u64 msrval = this_cpu_read(msr_misc_features_shadow);
> > 
> > 	if (!msrval || msrval == vcpu->arch.msr_misc_features_enables)
> > 		return;
> > 
> > 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
> > 	
> > > +	wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
> > > +}
> > > +
> > >  static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
> > >  {
> > >  	struct vmcs_host_state *host_state;
> > > @@ -1137,6 +1169,8 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx
> > > *vmx)
> > >  	++vmx->vcpu.stat.host_state_reload;
> > >  	vmx->loaded_cpu_state = NULL;
> > >  
> > > +	vmx_restore_host_cpuid_fault(vmx);
> > > +
> > >  #ifdef CONFIG_X86_64
> > >  	rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
> > >  #endif
> > > diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> > > index 5df73b36fa49..ba867bbc5676 100644
> > > --- a/arch/x86/kvm/vmx/vmx.h
> > > +++ b/arch/x86/kvm/vmx/vmx.h
> > > @@ -268,6 +268,8 @@ struct vcpu_vmx {
> > >  	u64 msr_ia32_feature_control_valid_bits;
> > >  	u64 ept_pointer;
> > >  
> > > +	u64 host_msr_misc_features_enables;
> > 
> > As mentioned above, this isn't needed.
> 
> Sure, I will remove this and use msr_misc_features_shadow.
> 
> > > +
> > >  	struct pt_desc pt_desc;
> > >  };
> > >  
> > > -- 
> > > 2.19.1
> > > 
> 
