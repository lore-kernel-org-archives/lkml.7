Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1661CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98C220675
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbfCAOxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:53:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:56043 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbfCAOxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:53:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 06:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,427,1544515200"; 
   d="scan'208";a="120134354"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga006.jf.intel.com with ESMTP; 01 Mar 2019 06:53:23 -0800
Date:   Fri, 1 Mar 2019 06:53:23 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v3 3/8] KVM:CPUID: Add CPUID support for Guest CET
Message-ID: <20190301145323.GB22584@linux.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-4-weijiang.yang@intel.com>
 <20190228155939.GD6166@linux.intel.com>
 <20190228082831.GB12006@local-michael-cet-test.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228082831.GB12006@local-michael-cet-test.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:28:32PM +0800, Yang Weijiang wrote:
> On Thu, Feb 28, 2019 at 07:59:40AM -0800, Sean Christopherson wrote:
> > On Mon, Feb 25, 2019 at 09:27:11PM +0800, Yang Weijiang wrote:
> > > Guest CET SHSTK and IBT capability are reported via
> > > CPUID.(EAX=7, ECX=0):ECX[bit 7] and EDX[bit 20] respectively.
> > > Guest user mode and supervisor mode xsaves component size
> > > is reported via CPUID.(EAX=0xD, ECX=1):ECX[bit 11] and ECX[bit 12]
> > > respectively.
> > > 
> > > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >  arch/x86/kvm/cpuid.c | 60 +++++++++++++++++++++++++++++++++-----------
> > >  arch/x86/kvm/x86.h   |  4 +++
> > >  2 files changed, 50 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index cb1aece25b17..5e05756cc6db 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -65,6 +65,16 @@ u64 kvm_supported_xcr0(void)
> > >  	return xcr0;
> > >  }
> > >  
> > > +u64 kvm_supported_xss(void)
> > > +{
> > > +	u64 xss;
> > > +
> > > +	rdmsrl(MSR_IA32_XSS, xss);
> > > +	xss &= KVM_SUPPORTED_XSS;
> > > +	return xss;
> > > +}
> > > +EXPORT_SYMBOL(kvm_supported_xss);
> > > +
> > >  #define F(x) bit(X86_FEATURE_##x)
> > >  
> > >  /* For scattered features from cpufeatures.h; we currently expose none */
> > > @@ -323,6 +333,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> > >  				 u32 index, int *nent, int maxnent)
> > >  {
> > >  	int r;
> > > +	u32 eax, ebx, ecx, edx;
> > >  	unsigned f_nx = is_efer_nx() ? F(NX) : 0;
> > >  #ifdef CONFIG_X86_64
> > >  	unsigned f_gbpages = (kvm_x86_ops->get_lpage_level() == PT_PDPE_LEVEL)
> > > @@ -503,6 +514,20 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> > >  			 * if the host doesn't support it.
> > >  			 */
> > >  			entry->edx |= F(ARCH_CAPABILITIES);
> > > +
> > > +			/*
> > > +			 * Guest OS CET enabling is designed independent to
> > > +			 * host enabling, it only has dependency on Host HW
> > > +			 * capability, if it has, report CET support to
> > > +			 * Guest.
> > > +			 */
> > > +			cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
> > > +			if (ecx & F(SHSTK))
> > > +				entry->ecx |= F(SHSTK);
> > > +
> > > +			if (edx & F(IBT))
> > > +				entry->edx |= F(IBT);
> > 
> > There's no need to manually add these flags.  They will be automatically
> > kept if supported in hardware because your previous patch, 02/08, added
> > them to the mask of features that can be exposed to the guest,
> > i.e. set them in kvm_cpuid_7_0_e{c,d}x_x86_features.
> > 
> I shared the same thought as you before, but after I took a closer look at the
> kernel code, actually, when host CET feature is disabled by user via
> cmdline options(no_cet_shstk and no_cet_ibt), it'll mask out CET feature bits in
> boot_cpu_data.x86_capbility[] array, and cpuid_mask() will make the bits
> in previous definition lost, so these lines actually add them back when
> host CET is disabled.

'entry' is filled by do_cpuid_1_ent(), which does cpuid_count(), same as
your code, i.e. it's not affected by whether or not the host kernel is
using each feature.
 
> please check CET kernel patch here:
> https://lkml.org/lkml/2018/11/20/204
> 
> > > +
> > >  		} else {
> > >  			entry->ebx = 0;
> > >  			entry->ecx = 0;
> > > @@ -564,14 +589,17 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> > >  	}
> > >  	case 0xd: {
> > >  		int idx, i;
> > > -		u64 supported = kvm_supported_xcr0();
> > > +		u64 u_supported = kvm_supported_xcr0();
> > > +		u64 s_supported = kvm_supported_xss();
> > > +		u64 supported;
> > > +		int compacted;
> > >  
> > > -		entry->eax &= supported;
> > > -		entry->ebx = xstate_required_size(supported, false);
> > > +		entry->eax &= u_supported;
> > > +		entry->ebx = xstate_required_size(u_supported, false);
> > >  		entry->ecx = entry->ebx;
> > > -		entry->edx &= supported >> 32;
> > > +		entry->edx &= u_supported >> 32;
> > >  		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > > -		if (!supported)
> > > +		if (!u_supported && !s_supported)
> > >  			break;
> > >  
> > >  		for (idx = 1, i = 1; idx < 64; ++idx) {
> > > @@ -583,19 +611,23 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> > >  			if (idx == 1) {
> > >  				entry[i].eax &= kvm_cpuid_D_1_eax_x86_features;
> > >  				cpuid_mask(&entry[i].eax, CPUID_D_1_EAX);
> > > -				entry[i].ebx = 0;
> > > -				if (entry[i].eax & (F(XSAVES)|F(XSAVEC)))
> > > -					entry[i].ebx =
> > > -						xstate_required_size(supported,
> > > -								     true);
> > > +				supported = u_supported | s_supported;
> > > +				compacted = entry[i].eax &
> > > +					(F(XSAVES) | F(XSAVEC));
> > > +				entry[i].ebx = xstate_required_size(supported,
> > > +								    compacted);
> > > +				entry[i].ecx &= s_supported;
> > > +				entry[i].edx = 0;
> > >  			} else {
> > > +				supported = (entry[i].ecx & 1) ? s_supported :
> > > +								 u_supported;
> > >  				if (entry[i].eax == 0 || !(supported & mask))
> > >  					continue;
> > > -				if (WARN_ON_ONCE(entry[i].ecx & 1))
> > > -					continue;
> > > +				entry[i].ecx &= 1;
> > > +				entry[i].edx = 0;
> > > +				if (entry[i].ecx)
> > > +					entry[i].ebx = 0;
> > >  			}
> > > -			entry[i].ecx = 0;
> > > -			entry[i].edx = 0;
> > >  			entry[i].flags |=
> > >  			       KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> > >  			++*nent;
> > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > index 224cd0a47568..c61da41c3c5c 100644
> > > --- a/arch/x86/kvm/x86.h
> > > +++ b/arch/x86/kvm/x86.h
> > > @@ -283,6 +283,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, unsigned long cr2,
> > >  				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
> > >  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
> > >  				| XFEATURE_MASK_PKRU)
> > > +
> > > +#define KVM_SUPPORTED_XSS	(XFEATURE_MASK_SHSTK_USER \
> > > +				| XFEATURE_MASK_SHSTK_KERNEL)
> > > +
> > >  extern u64 host_xcr0;
> > >  
> > >  extern u64 kvm_supported_xcr0(void);
> > > -- 
> > > 2.17.1
> > > 
