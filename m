Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A56D2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfHLX46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:56:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:57192 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbfHLX46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:56:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 16:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,379,1559545200"; 
   d="scan'208";a="187598790"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2019 16:56:32 -0700
Date:   Mon, 12 Aug 2019 16:56:32 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com,
        jmattson@google.com
Subject: Re: [PATCH v6 5/8] KVM: VMX: Load Guest CET via VMCS when CET is
 enabled in Guest
Message-ID: <20190812235632.GH4996@linux.intel.com>
References: <20190725031246.8296-1-weijiang.yang@intel.com>
 <20190725031246.8296-6-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725031246.8296-6-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:12:43AM +0800, Yang Weijiang wrote:
> "Load Guest CET state" bit controls whether Guest CET states
> will be loaded at Guest entry. Before doing that, KVM needs
> to check if CPU CET feature is enabled on host and available
> to Guest.
> 
> Note: SHSTK and IBT features share one control MSR:
> MSR_IA32_{U,S}_CET, which means it's difficult to hide
> one feature from another in the case of SHSTK != IBT,
> after discussed in community, it's agreed to allow Guest
> control two features independently as it won't introduce
> security hole.
> 
> Co-developed-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ce5d1e45b7a5..fbf9c335cf7b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -44,6 +44,7 @@
>  #include <asm/spec-ctrl.h>
>  #include <asm/virtext.h>
>  #include <asm/vmx.h>
> +#include <asm/cet.h>
>  
>  #include "capabilities.h"
>  #include "cpuid.h"
> @@ -2923,6 +2924,18 @@ int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  		if (!nested_vmx_allowed(vcpu) || is_smm(vcpu))
>  			return 1;
>  	}
> +	if (cpu_x86_cet_enabled() &&

It'd probably be better to check a KVM function here, e.g. a wrapper of
kvm_supported_xss().  I don't think it will ever matter, but it'd be nice
to have a single kill switch given the variety of different enable bits
for CET.

> +	    (guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) ||
> +	    guest_cpuid_has(vcpu, X86_FEATURE_IBT))) {
> +		if (cr4 & X86_CR4_CET)
> +			vmcs_set_bits(VM_ENTRY_CONTROLS,
> +				      VM_ENTRY_LOAD_GUEST_CET_STATE);
> +		else
> +			vmcs_clear_bits(VM_ENTRY_CONTROLS,
> +					VM_ENTRY_LOAD_GUEST_CET_STATE);
> +	} else if (cr4 & X86_CR4_CET) {
> +		return 1;
> +	}
>  
>  	if (to_vmx(vcpu)->nested.vmxon && !nested_cr4_valid(vcpu, cr4))
>  		return 1;
> -- 
> 2.17.2
> 
