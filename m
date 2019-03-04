Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E12720684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfCEFWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:22:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:62273 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfCEFWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 00:22:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 21:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,442,1544515200"; 
   d="scan'208";a="122684599"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga008.jf.intel.com with ESMTP; 04 Mar 2019 21:22:34 -0800
Date:   Mon, 4 Mar 2019 20:17:05 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v3 3/8] KVM:CPUID: Add CPUID support for Guest CET
Message-ID: <20190304121705.GA4185@local-michael-cet-test.sh.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-4-weijiang.yang@intel.com>
 <20190228155939.GD6166@linux.intel.com>
 <20190228082831.GB12006@local-michael-cet-test.sh.intel.com>
 <20190301145323.GB22584@linux.intel.com>
 <20190303093645.GB31538@local-michael-cet-test.sh.intel.com>
 <20190304182836.GB17120@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304182836.GB17120@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:28:36AM -0800, Sean Christopherson wrote:
> On Sun, Mar 03, 2019 at 05:36:45PM +0800, Yang Weijiang wrote:
> > On Fri, Mar 01, 2019 at 06:53:23AM -0800, Sean Christopherson wrote:
> > > On Thu, Feb 28, 2019 at 04:28:32PM +0800, Yang Weijiang wrote:
> > > > On Thu, Feb 28, 2019 at 07:59:40AM -0800, Sean Christopherson wrote:
> > > > > On Mon, Feb 25, 2019 at 09:27:11PM +0800, Yang Weijiang wrote:
> > > > > > Guest CET SHSTK and IBT capability are reported via
> > > > > > CPUID.(EAX=7, ECX=0):ECX[bit 7] and EDX[bit 20] respectively.
> > > > > > Guest user mode and supervisor mode xsaves component size
> > > > > > is reported via CPUID.(EAX=0xD, ECX=1):ECX[bit 11] and ECX[bit 12]
> > > > > > respectively.
> > > > > > 
> > > > > > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > > > > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > > > > ---
> > > > > >  arch/x86/kvm/cpuid.c | 60 +++++++++++++++++++++++++++++++++-----------
> > > > > >  arch/x86/kvm/x86.h   |  4 +++
> > > > > >  2 files changed, 50 insertions(+), 14 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > > > > index cb1aece25b17..5e05756cc6db 100644
> > > > > > --- a/arch/x86/kvm/cpuid.c
> > > > > > +++ b/arch/x86/kvm/cpuid.c
> > > > > > @@ -65,6 +65,16 @@ u64 kvm_supported_xcr0(void)
> > > > > >  	return xcr0;
> > > > > >  }
> > > > > >  
> > > > > > +u64 kvm_supported_xss(void)
> > > > > > +{
> > > > > > +	u64 xss;
> > > > > > +
> > > > > > +	rdmsrl(MSR_IA32_XSS, xss);
> > > > > > +	xss &= KVM_SUPPORTED_XSS;
> > > > > > +	return xss;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(kvm_supported_xss);
> > > > > > +
> > > > > >  #define F(x) bit(X86_FEATURE_##x)
> > > > > >  
> > > > > >  /* For scattered features from cpufeatures.h; we currently expose none */
> > > > > > @@ -323,6 +333,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> > > > > >  				 u32 index, int *nent, int maxnent)
> > > > > >  {
> > > > > >  	int r;
> > > > > > +	u32 eax, ebx, ecx, edx;
> > > > > >  	unsigned f_nx = is_efer_nx() ? F(NX) : 0;
> > > > > >  #ifdef CONFIG_X86_64
> > > > > >  	unsigned f_gbpages = (kvm_x86_ops->get_lpage_level() == PT_PDPE_LEVEL)
> > > > > > @@ -503,6 +514,20 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> > > > > >  			 * if the host doesn't support it.
> > > > > >  			 */
> > > > > >  			entry->edx |= F(ARCH_CAPABILITIES);
> > > > > > +
> > > > > > +			/*
> > > > > > +			 * Guest OS CET enabling is designed independent to
> > > > > > +			 * host enabling, it only has dependency on Host HW
> > > > > > +			 * capability, if it has, report CET support to
> > > > > > +			 * Guest.
> > > > > > +			 */
> > > > > > +			cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
> > > > > > +			if (ecx & F(SHSTK))
> > > > > > +				entry->ecx |= F(SHSTK);
> > > > > > +
> > > > > > +			if (edx & F(IBT))
> > > > > > +				entry->edx |= F(IBT);
> > > > > 
> > > > > There's no need to manually add these flags.  They will be automatically
> > > > > kept if supported in hardware because your previous patch, 02/08, added
> > > > > them to the mask of features that can be exposed to the guest,
> > > > > i.e. set them in kvm_cpuid_7_0_e{c,d}x_x86_features.
> > > > > 
> > > > I shared the same thought as you before, but after I took a closer look at the
> > > > kernel code, actually, when host CET feature is disabled by user via
> > > > cmdline options(no_cet_shstk and no_cet_ibt), it'll mask out CET feature bits in
> > > > boot_cpu_data.x86_capbility[] array, and cpuid_mask() will make the bits
> > > > in previous definition lost, so these lines actually add them back when
> > > > host CET is disabled.
> > > 
> > > 'entry' is filled by do_cpuid_1_ent(), which does cpuid_count(), same as
> > > your code, i.e. it's not affected by whether or not the host kernel is
> > > using each feature.
> > >
> > I checked CET kernel patch:
> > #ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> > static __init int setup_disable_shstk(char *s) {
> > 	/* require an exact match without trailing characters */
> > 	if (s[0] != '\0')
> > 		return 0;
> > 
> > 	if (!boot_cpu_has(X86_FEATURE_SHSTK))
> > 		return 1;
> > 
> > 	setup_clear_cpu_cap(X86_FEATURE_SHSTK);
> > 	pr_info("x86: 'no_cet_shstk' specified, disabling Shadow Stack\n");
> > 	return 1;
> > }
> > __setup("no_cet_shstk", setup_disable_shstk); #endif
> > 
> > setup_disable_shstk()->setup_clear_cpu_cap(X86_FEATURE_SHSTK)->do_clear_cpu_cap(NULL,
> > feature)->clear_feature(c, feature)->clear_cpu_cap(&boot_cpu_data, feature);
> > 
> > this path will clear boot_cpu_data.x86_capability[X86_FEATURE_SHSTK] if "no_cet_shstk" is set.
> > but in cpuid_mask(), it will "AND" the bit with SHSTK bit set 
> > in kvm_cpuid_7_0_ecx_x86_features, so the bit in ecx is cleared, 
> > need to add the bit back according to host cpuid_count(). 
> > the CET kernel patch can be seen in below patch link.
> 
> Ah, I see.  In this case we need to honor boot_cpu_data.  The idea is
> that a feature should not be exposed to the guest, i.e. actually used,
> if it has been explicitly disabled by the user, e.g. to workaround a
> hardware or firmware issue.  The cases where a feature is exposed to
> the guest even when disabled in host is when said feature is emulated
> by KVM in software.
>
Make sense, I'll change related checks in the patch set.
Thanks!

> > 
> > > > please check CET kernel patch here:
> > > > https://lkml.org/lkml/2018/11/20/204
