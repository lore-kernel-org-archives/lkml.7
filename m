Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9362C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F6721537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfFNOOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:14:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:13630 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfFNOOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:14:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 07:14:24 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2019 07:14:24 -0700
Date:   Fri, 14 Jun 2019 07:14:24 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614141424.GA12191@linux.intel.com>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
 <20190614134123.GF2586@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614134123.GF2586@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:41:23PM +0200, Borislav Petkov wrote:
> + Radim and Paolo. See upthread for context.
> 
> On Fri, Jun 14, 2019 at 06:17:02AM -0700, Fenghua Yu wrote:
> > > Alternatively - and what I think is the better solution - would be to
> > > remove those BUILD_BUG_ONs in x86_feature_cpuid and filter out the
> > > Linux-defined leafs dynamically. This way the array won't have holes in
> > > it.
> > 
> > Maybe adding a dummy slot in cpuid_leafs in patch 0002 to avoid the
> > compilation errors?
> 
> Maybe you didn't read what you're replying to: "This way the array
> won't have holes in it". Ontop of yours:
> 
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index d78a61408243..03d6f3f7b27c 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -47,6 +47,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
>  	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
>  	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
>  	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
> +	[CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
>  	[CPUID_8000_0008_EBX] = {0x80000008, 0, CPUID_EBX},
>  	[CPUID_6_EAX]         = {         6, 0, CPUID_EAX},
>  	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
> @@ -59,8 +60,9 @@ static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
>  {
>  	unsigned x86_leaf = x86_feature / 32;
>  
> -	BUILD_BUG_ON(x86_leaf >= ARRAY_SIZE(reverse_cpuid));
> -	BUILD_BUG_ON(reverse_cpuid[x86_leaf].function == 0);
> +	if (x86_leaf == CPUID_LNX_1 ||
> +	    x86_leaf == CPUID_LNX_4)
> +		return NULL;
>  
>  	return reverse_cpuid[x86_leaf];
>  }
> 
> That's what I mean with filter out dynamically.

This is wrong.  KVM isn't complaining about shuffling the order of feature
words, it's complaining that code is trying to do a reverse CPUID lookup
to a feature that isn't in the reverse_cpuid table.   Filtering out
checks dynamically is just hiding bugs.

>In function ‘x86_feature_cpuid’,
>     inlined from ‘guest_cpuid_get_register’ at arch/x86/kvm/cpuid.h:71:33,
>     inlined from ‘guest_cpuid_has’ at arch/x86/kvm/cpuid.h:100:8,
>     inlined from ‘kvm_get_msr_common’ at arch/x86/kvm/x86.c:2804:8:

This corresponds to "guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES)",
i.e. KVM is trying to query X86_FEATURE_ARCH_CAPABILITIES and is yelling
that there is no reverse_cpuid entry for CPUID_7_EDX.

The problem is that 'enum cpuid_leafs' no longer matches up with the
word numbers defined in cpufeatures.h, e.g. CPUID_7_EDX == 17 or so, but
the entries in cpufeatures.h defined CPUID_7_EDX flags using word 18.

This patch also needs to modify NCAPINTS.
