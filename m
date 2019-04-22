Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0C421738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfDVSkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:40:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:59587 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfDVSky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:40:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 11:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="339761584"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2019 11:35:53 -0700
Date:   Mon, 22 Apr 2019 11:35:53 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Message-ID: <20190422183553.GH1236@linux.intel.com>
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 02:40:34PM +0800, Like Xu wrote:
> Expose Intel V2 Extended Topology Enumeration Leaf to guest only when
> host system has multiple software-visible die within each package.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index fd39516..9fc14f2 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -65,6 +65,16 @@ u64 kvm_supported_xcr0(void)
>  	return xcr0;
>  }
>  
> +/* We need to check if the host cpu has multi-chip packaging technology. */
> +static bool kvm_supported_intel_mcp(void)
> +{
> +	u32 eax, ignored;
> +
> +	cpuid_count(0x1f, 0, &eax, &ignored, &ignored, &ignored);
> +
> +	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && (eax != 0);
> +}
> +
>  #define F(x) bit(X86_FEATURE_##x)
>  
>  int kvm_update_cpuid(struct kvm_vcpu *vcpu)
> @@ -426,6 +436,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  	switch (function) {
>  	case 0:
>  		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
> +		entry->eax = kvm_supported_intel_mcp() ? 0x1f : entry->eax;

This all seems unnecessary.  And by 'all', I mean the existing Intel PT
and XSAVE leaf checks, as well as the new mcp check.  entry->eax comes
directly from hardware, and unless I missed something, PT and XSAVE are
only exposed to the guest when they're supported in hardware.  In other
words, KVM will never need to adjust entry->eax to expose PT or XSAVE.

The original min() check was added by commit 0771671749b5 ("KVM: Enhance
guest cpuid management"), which doesn't provide any explicit information
on why KVM does min() in the first place.  Given that the original code
was "entry->eax = min(entry->eax, (u32)0xb);", my *guess* is that the
idea was to always report "Extended Topology Enumeration Leaf" as
supported so that userspace can enumerate the VM's topology to the guest
even when hardware itself doesn't do so.

Assuming we want to allow userspace to use "V2 Extended Topology
Enumeration Leaf" regardless of hardware support, then this can simply be:

  entry->eax = min(entry->eax, (u32)0xf);

Or am I completely missing something?

>  		break;
>  	case 1:
>  		entry->edx &= kvm_cpuid_1_edx_x86_features;
> @@ -544,6 +555,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		entry->edx = edx.full;
>  		break;
>  	}
> +	/* function 0x1f has additional index. */

The original comment is rather useless, it's obvious from the code that
it has additional indices.  No need to repeat its sins.  A more useful
comment would be to explain that 0x1f and 0xb have identical formats and
thus can be handled by common code.

Which begs the question, why does leaf 0x1f exist?  AFAICT the only
difference is that 0x1f supports additional "level types", but 0x1f's
types are backwards compatibile.  Any idea why leaf 0xb wasn't simply
extended for the new types?

> +	case 0x1f:
>  	/* function 0xb has additional index. */
>  	case 0xb: {
>  		int i, level_type;
> -- 
> 1.8.3.1
> 
