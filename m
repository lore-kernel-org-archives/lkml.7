Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F881C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE741218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfB1QRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:17:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:53979 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfB1QRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:17:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 08:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="137985056"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2019 08:17:15 -0800
Date:   Thu, 28 Feb 2019 08:17:15 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v3 6/8] KVM:VMX: Load Guest CET via VMCS when CET is
 enabled in Guest
Message-ID: <20190228161715.GF6166@linux.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-7-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225132716.6982-7-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 09:27:14PM +0800, Yang Weijiang wrote:
> "Load Guest CET state" bit controls whether guest CET states
> will be loaded at Guest entry. Before doing that, KVM needs
> to check if CPU CET feature is available.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 89ee086e1729..d32cee9ee079 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -55,6 +55,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/spec-ctrl.h>
>  #include <asm/mshyperv.h>
> +#include <asm/cet.h>
>  
>  #include "trace.h"
>  #include "pmu.h"
> @@ -4065,6 +4066,20 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
>  	return !(val & ~valid_bits);
>  }
>  
> +static int vmx_guest_cet_cap(struct kvm_vcpu *vcpu)
> +{
> +	u32 eax, ebx, ecx, edx;
> +
> +	/*
> +	 * Guest CET can work as long as HW supports the feature, independent
> +	 * to Host SW enabling status.
> +	 */
> +	cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
> +
> +	return ((ecx & bit(X86_FEATURE_SHSTK)) |
> +		(edx & bit(X86_FEATURE_IBT))) ? 1 : 0;

Given the holes in the (current) architecture/spec, I think KVM has to
require both features to be supported in the guest to allow CR4.CET to
be enabled.

Technically SHSTK and IBT can be enabled independently, but unless I'm
missing something, supporting that in KVM (or any VMM) would be nasty
and would likely degrade guest performance significantly.

MSRs IA32_U_CET and IA32_S_CET have enable bits for each CET feature.
Presumably the bits for each feature are reserved if the feature is not
supported, e.g. SH_STK_EN is reserved to zero if SHSTK isn't supported.
This wouldn't be a problem except that IA32_U_CET and the shadow stack
MSRs, e.g. IA32_PL*_SSP, can be saved/restored via XSAVES/XRSTORS.  The
behavior is restricted by IA32_XSS, but again it's all or nothing, e.g.
if any CET feature is supported then XSS_CET_{S,U} can be set.

For example, if a guest supported IBT and !SHSTK, and the guest enabled
XSS_CET_{S,I}, KVM would need to trap XSAVES/XRSTORS to enforce that the
SHSTK bits in XSS_CET_U aren't set.  And that doesn't even address the
fact that the architecture defines the effects on the size of the XSAVE
state area as being a bundled deal, e.g. IA32_XSS.CET_U=1 increases the
size by 16 bytes (for IA32_U_CET and IA32_PL3_SSP) regardless of whether
or not SHSTK is supported.  One would assume that IA32_PL3_SSP doesn't
exist if shadow stacks are not supported by the CPU.

TL;DR: the architecture enumerates SHSTK and IBT independently, but
the architecture effectively assumes they are bundled together.

> +}
> +
>  static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
>  {
>  	switch (msr->index) {
> @@ -5409,6 +5424,23 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  			return 1;
>  	}
>  
> +	/*
> +	 * To enable Guest CET, check whether CPU CET feature is
> +	 * available, if it's there, set Guest CET state loading bit
> +	 * per CR4.CET status, otherwise, return a fault to Guest.
> +	 */
> +	if (vmx_guest_cet_cap(vcpu)) {

This is wrong, it's checking the host capabilities.  Use guest_cpuid_has()
to query the guest capabilities.  E.g. CET can be supported in the host
but not exposed to guest, in which case the CPUID bits will not be "set"
for the guest.

> +		if (cr4 & X86_CR4_CET) {

No need for curly braces here, both the 'if' and 'else' contain a single
statement.

> +			vmcs_set_bits(VM_ENTRY_CONTROLS,
> +				      VM_ENTRY_LOAD_GUEST_CET_STATE);
> +		} else {
> +			vmcs_clear_bits(VM_ENTRY_CONTROLS,
> +					VM_ENTRY_LOAD_GUEST_CET_STATE);
> +		}
> +	} else if (cr4 & X86_CR4_CET) {
> +		return 1;
> +	}
> +
>  	if (to_vmx(vcpu)->nested.vmxon && !nested_cr4_valid(vcpu, cr4))
>  		return 1;
>  
> -- 
> 2.17.1
> 
