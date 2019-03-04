Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2419FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F109E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfCDKrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:47:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:25185 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCDKrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:47:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 02:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="scan'208";a="304205693"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2019 02:47:16 -0800
Message-ID: <f5053983dc12550edabc418b0493c6ec8deb1412.camel@linux.intel.com>
Subject: Re: [PATCH v4 15/17] kvm: x86: Report CORE_CAPABILITY on
 GET_SUPPORTED_CPUID
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
Date:   Mon, 04 Mar 2019 18:47:19 +0800
In-Reply-To: <697ee0bd-a5f6-7712-017e-455eed5bc185@redhat.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
         <1551494711-213533-16-git-send-email-fenghua.yu@intel.com>
         <697ee0bd-a5f6-7712-017e-455eed5bc185@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 09:38 +0100, Paolo Bonzini wrote:
> On 02/03/19 03:45, Fenghua Yu wrote:
> > From: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > 
> > In the latest Intel SDM, CPUID.(EAX=7H,ECX=0):EDX[30] will enumerate
> > the presence of the IA32_CORE_CAPABILITY MSR.
> > 
> > Update GET_SUPPORTED_CPUID to expose this feature bit to user space, so
> > that user space know this bit can be enabled in CPUID.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > ---
> >  arch/x86/kvm/cpuid.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index c07958b59f50..e0e17b9c65da 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -410,7 +410,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2
> > *entry, u32 function,
> >  	/* cpuid 7.0.edx*/
> >  	const u32 kvm_cpuid_7_0_edx_x86_features =
> >  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
> > -		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP);
> > +		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(CORE_CAPABILITY) |
> > +		F(INTEL_STIBP);
> 
> This should be enabled always if boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT),
> since the MSR is emulated.  This way, guests can always rely on
> IA32_CORE_CAPABILITY_MSR and it won't have to rely on the FMS
> (which means nothing inside a guest).
> 
> Paolo

Hi, Paolo
Do you mean that we don't need this here, but to add the handling below?

static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 * entry, u32 function,
...
	switch (function) {
	...
	case 7: {
		...
		if (index ==0) {
			...
			if(boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
				entry->edx |= F(CORE_CAPABILITY);
		}
		...
	...
	}
...
}

> >  	/* all calls to cpuid_count() should be made on the same cpu */
> >  	get_cpu();
> > 
> 
> 

