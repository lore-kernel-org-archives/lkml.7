Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B438BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEA520663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCDTGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:06:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:37323 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbfCDTGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:06:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 11:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,441,1544515200"; 
   d="scan'208";a="304310397"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2019 11:06:16 -0800
Date:   Mon, 4 Mar 2019 10:59:22 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 07/17] x86/split_lock: Enumerate #AC for split lock by
 MSR IA32_CORE_CAPABILITY
Message-ID: <20190304185922.GA231946@romley-ivt3.sc.intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-8-git-send-email-fenghua.yu@intel.com>
 <8b810f50-e4ed-7020-c0df-203cf98c3ce8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b810f50-e4ed-7020-c0df-203cf98c3ce8@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 04, 2019 at 10:58:01AM -0800, Dave Hansen wrote:
> >  	 * Clear/Set all flags overridden by options, after probe.
> > diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> > index 2c0bd38a44ab..5ba11ce99f92 100644
> > --- a/arch/x86/kernel/cpu/cpuid-deps.c
> > +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> > @@ -59,6 +59,7 @@ static const struct cpuid_dep cpuid_deps[] = {
> >  	{ X86_FEATURE_AVX512_4VNNIW,	X86_FEATURE_AVX512F   },
> >  	{ X86_FEATURE_AVX512_4FMAPS,	X86_FEATURE_AVX512F   },
> >  	{ X86_FEATURE_AVX512_VPOPCNTDQ, X86_FEATURE_AVX512F   },
> > +	{ X86_FEATURE_SPLIT_LOCK_DETECT, X86_FEATURE_CORE_CAPABILITY},
> >  	{}
> >  };
> 
> Please reindent the rest of the structure whenever you break the record
> for name length.

Ok. Will do it.

> 
> > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > index fc3c07fe7df5..0c44c49f6005 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -1029,3 +1029,24 @@ static const struct cpu_dev intel_cpu_dev = {
> >  
> >  cpu_dev_register(intel_cpu_dev);
> >  
> > +/**
> > + * init_core_capability - enumerate features supported in IA32_CORE_CAPABILITY
> > + * @c: pointer to cpuinfo_x86
> > + *
> > + * Return: void
> > + */
> > +void init_core_capability(struct cpuinfo_x86 *c)
> > +{
> > +	/*
> > +	 * If MSR_IA32_CORE_CAPABILITY exists, enumerate features that are
> > +	 * reported in the MSR.
> > +	 */
> > +	if (c == &boot_cpu_data && cpu_has(c, X86_FEATURE_CORE_CAPABILITY)) {
> 
> First of all, please endeavor to leave the main flow of the function at
> the first indent.
> 
> *If* you were to do this, it would look like:
> 
> 
> 	if (c != &boot_cpu_data)
> 		return;
> 	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITY))
> 		return;
> 
> 	rdmsrl(...);

Ok. Will do it.

> 
> But, it goes unmentioned why you do the boot-cpu-only restriction here.
>  It doesn't match the behavior of the two functions called before
> init_core_capability():
> 
>         init_scattered_cpuid_features(c);
>         init_speculation_control(c);
> 
> So why is this new function special?

The function sets the split_lock_detect feature which needs to be
applied before BSP calls apply_enforced_caps() in get_cpu_cap(). And I
want to enable split lock detection in earlier phase to detect split
lock earlier.

Thanks.

-Fenghua
