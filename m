Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0183C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A40F218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbfB1QEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:04:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:39233 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731142AbfB1QEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:04:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 08:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="127973776"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2019 08:04:22 -0800
Date:   Thu, 28 Feb 2019 08:04:22 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v3 2/8] KVM:CPUID: Define CET CPUID bits and CR4.CET
 master enable bit.
Message-ID: <20190228160422.GE6166@linux.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-3-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225132716.6982-3-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 09:27:10PM +0800, Yang Weijiang wrote:
> Guest queries CET SHSTK and IBT support by CPUID.(EAX=0x7,ECX=0),
> in return, ECX[bit 7] corresponds to SHSTK feature, and EDX[bit 20]
> corresponds to IBT feature.
> CR4.CET[bit 23] is CET master enable bit, it controls CET feature
> availability in guest OS.
> 
> Note: Although SHSTK or IBT can be enabled independently,
>       either of the features is controlled by CR4.CET.

This patch effectively allows the guest to set CR4, it should be the
last patch in the series to actually "enable" CET in the guest, i.e.
once KVM actually virtualizes CET.

> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 3 ++-
>  arch/x86/kvm/cpuid.c            | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 55e51ff7e421..df002936088f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -90,7 +90,8 @@
>  			  | X86_CR4_PGE | X86_CR4_PCE | X86_CR4_OSFXSR | X86_CR4_PCIDE \
>  			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
>  			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
> -			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP))
> +			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
> +			  | X86_CR4_CET))

This macro doesn't define CR4 bits, it defines which bits should be
treated as reserved when the guest writes CR4.

>  
>  #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
>  
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7bcfa61375c0..cb1aece25b17 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -406,12 +406,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
>  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
>  		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
> -		F(CLDEMOTE);
> +		F(CLDEMOTE) | F(SHSTK);
>  
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
> -		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
> +		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(IBT);

Again, these masks don't "define" the feature bits, rather they specify
which feature bits can be exposed to the guest.

>  
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
> -- 
> 2.17.1
> 
