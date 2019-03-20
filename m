Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F84C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7BA213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfCTN3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:29:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:11690 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbfCTN3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:29:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 06:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="215839474"
Received: from lxy-dell.sh.intel.com ([10.239.159.145])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2019 06:29:48 -0700
Message-ID: <fd83f71c48b0d9445a82957568386ae4b2563382.camel@linux.intel.com>
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
Date:   Wed, 20 Mar 2019 21:26:20 +0800
In-Reply-To: <20190320000942.GN25575@linux.intel.com>
References: <20190318114324.14198-1-xiaoyao.li@linux.intel.com>
         <20190318114324.14198-3-xiaoyao.li@linux.intel.com>
         <20190318163832.GB13528@linux.intel.com>
         <085cc389df4d734ee173bb4c199776591d197a21.camel@linux.intel.com>
         <20190319142849.GB25575@linux.intel.com>
         <73fefa02cafb0e94de0c2928185560e092fe137e.camel@linux.intel.com>
         <20190320000942.GN25575@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 17:09 -0700, Sean Christopherson wrote:
> On Wed, Mar 20, 2019 at 01:51:28AM +0800, Xiaoyao Li wrote:
> > On Tue, 2019-03-19 at 07:28 -0700, Sean Christopherson wrote:
> > > On Tue, Mar 19, 2019 at 12:37:23PM +0800, Xiaoyao Li wrote:
> > > > On Mon, 2019-03-18 at 09:38 -0700, Sean Christopherson wrote:
> > > > > On Mon, Mar 18, 2019 at 07:43:24PM +0800, Xiaoyao Li wrote:
> > > > > > Current cpuid faulting of guest is purely emulated in kvm, which
> > > > > > exploits
> > > > > > CPUID vm exit to inject #GP to guest. However, if host hardware cpu
> > > > > > has
> > > > > > X86_FEATURE_CPUID_FAULT, we can just use the hardware cpuid faulting
> > > > > > for
> > > > > > guest to avoid the vm exit overhead.
> > > > > 
> > > > > Heh, I obviously didn't look at this patch before responding to patch
> > > > > 1/2.
> > > > > 
> > > > > > Note: cpuid faulting takes higher priority over CPUID instruction vm
> > > > > > exit (Intel SDM vol3.25.1.1).
> > > > > > 
> > > > > > Since cpuid faulting only exists on some Intel's cpu, just apply
> > > > > > this
> > > > > > optimization to vmx.
> > > > > > 
> > > > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > > > > > ---
> > > > > >  arch/x86/include/asm/kvm_host.h |  2 ++
> > > > > >  arch/x86/kvm/vmx/vmx.c          | 19 +++++++++++++++----
> > > > > >  arch/x86/kvm/x86.c              | 15 ++++++++++++---
> > > > > >  3 files changed, 29 insertions(+), 7 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/x86/include/asm/kvm_host.h
> > > > > > b/arch/x86/include/asm/kvm_host.h
> > > > > > index ce79d7bfe1fd..14cad587b804 100644
> > > > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > > > @@ -1339,6 +1339,8 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned
> > > > > > long
> > > > > > msw);
> > > > > >  void kvm_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
> > > > > >  int kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
> > > > > >  
> > > > > > +int kvm_supported_msr_misc_features_enables(struct kvm_vcpu *vcpu,
> > > > > > u64
> > > > > > data);
> > > > > > +
> > > > > >  int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data
> > > > > > *msr);
> > > > > >  int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data
> > > > > > *msr);
> > > > > >  
> > > > > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > > > > index 2c59e0209e36..6b413e471dca 100644
> > > > > > --- a/arch/x86/kvm/vmx/vmx.c
> > > > > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > > > > @@ -1037,7 +1037,7 @@ static void pt_guest_exit(struct vcpu_vmx
> > > > > > *vmx)
> > > > > >  
> > > > > >  static void vmx_save_host_cpuid_fault(struct vcpu_vmx *vmx)
> > > > > >  {
> > > > > > -	u64 host_val;
> > > > > > +	u64 host_val, guest_val;
> > > > > >  
> > > > > >  	if (!boot_cpu_has(X86_FEATURE_CPUID_FAULT))
> > > > > >  		return;
> > > > > > @@ -1045,10 +1045,12 @@ static void vmx_save_host_cpuid_fault(struct
> > > > > > vcpu_vmx *vmx)
> > > > > >  	rdmsrl(MSR_MISC_FEATURES_ENABLES, host_val);
> > > > > >  	vmx->host_msr_misc_features_enables = host_val;
> > > > > >  
> > > > > > -	/* clear cpuid fault bit to avoid it leak to guest */
> > > > > > -	if (host_val & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) {
> > > > > > +	guest_val = vmx->vcpu.arch.msr_misc_features_enables;
> > > > > > +
> > > > > > +	/* we can use the hardware cpuid faulting to avoid emulation
> > > > > > overhead */
> > > > > > +	if ((host_val ^ guest_val) &
> > > > > > MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) {
> > > > > >  		wrmsrl(MSR_MISC_FEATURES_ENABLES,
> > > > > > -		       host_val &
> > > > > > ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT);
> > > > > > +		       host_val ^
> > > > > > MSR_MISC_FEATURES_ENABLES_CPUID_FAULT);
> > > > > >  	}
> > > > > >  }
> > > > > >  
> > > > > > @@ -2057,6 +2059,15 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu,
> > > > > > struct
> > > > > > msr_data *msr_info)
> > > > > >  		else
> > > > > >  			vmx->pt_desc.guest.addr_a[index / 2] = data;
> > > > > >  		break;
> > > > > > +	case MSR_MISC_FEATURES_ENABLES:
> > > > > > +		if (!kvm_supported_msr_misc_features_enables(vcpu,
> > > > > > data))
> > > > > > +			return 1;
> > > > > > +		if (boot_cpu_has(X86_FEATURE_CPUID_FAULT)) {
> > > > > > +			if (vmx->loaded_cpu_state)
> > > > > 
> > > > > No need for two separate if statements.  And assuming we're checking
> > > > > the
> > > > > existing shadow value when loading guest/host state, the WRMSR should
> > > > > only be done if the host's value is non-zero.
> > > > 
> > > > I'll combine these two if statements into one.
> > > > 
> > > > I cannot understand why the WRMSR should only be done if the host's
> > > > value is
> > > > non-zero. I think there is no depedency with host's value, if using the
> > > > hardware
> > > > cpuid faulting. We just need to set the value to real hardware MSR.
> > > 
> > > What I was trying to say in patch 1/2 regarding save/restore, is that I
> > > don't think it is worthwhile to voluntarily switch hardware's value.  In
> > > other words, do the WRMSR if and only if it's absolutely necessary.  And
> > > that means only installing the guest's value if the host's value is
> > > non-zero and host_val != guest_val.  If the host's value is zero, then
> > > the guest's value is irrelevant as CPUID faulting behavior will naturally
> > > be taken care of when intercepting CPUID.  And for obvious reasons the
> > > WRMSR can be skipped if host and guest want the same value.
> > 
> > The purpose of this patch is always using hardware cpuid fault if hardware
> > cpu
> > has this feature. Because emuated cpuid faulting needs entire vmexit
> > process,
> > but using hardware cpuid faulting just adds two WRMSR in save/restore cycle
> > only
> > when host_val != guest_val.
> > 
> > Also I conclude the handling ou said as below:
> > When host's value is zero, we do nothing to this MSR, and let guest ues
> > emulated
> > cpuid faulting through CPUID intercepting.
> > When host's value is non-zero, we load the guest'value into hardware MSR,
> > which
> > means we use hardware cpuid faulting.
> > 
> > So the difference is when host value is zero, you choose to use emulated
> > cpuid
> > faulting. What's meaning of chooseing emualtion or hardware feature based on
> > host's value?
> 
> To save cycles by avoiding WRMSR whenever possible.  WRMSR is expensive, even
> if it's limited to vcpu_{load,put}(), e.g. a workload that triggers a lot of
> exits to userspace isn't going to be thrilled about the extra 250-300 cycles
> added to each round trip.
> 
> On the other hand, emulating CPUID faulting only adds a VM-Exit to userspace
> CPUID instructions that will fault anyways, and faults aren't exactly fast
> paths.  Most uses of CPUID in userspace are in application startup, e.g. a
> hanful of CPUIDs to determine what features can be used.  So even if the ~1000
> cycles added by the VM-Exit is somehow meaningful to the fault path, its
> impact is limited to a tiny number of instructions executed in the guest,
> whereas doing WRMSR affects every vcpu_{load,put}.

Understand, it makes sense.
So the real optimization is to avoid WRMSR as far as possible.
Thanks for your patience and explanation, Sean. I'll adjust the patches
following your comments in the next version.

