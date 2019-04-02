Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77599C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365392075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDBUaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:30:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:34142 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfDBUaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:30:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 13:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,302,1549958400"; 
   d="scan'208";a="333164073"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2019 13:30:15 -0700
Date:   Tue, 2 Apr 2019 13:30:15 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [RFC PATCH v4 5/8] KVM:VMX: Load Guest CET via VMCS when CET is
 enabled in Guest
Message-ID: <20190402203014.GJ31303@linux.intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
 <20190318150351.15550-6-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318150351.15550-6-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:03:48PM +0800, Yang Weijiang wrote:
> "Load Guest CET state" bit controls whether guest CET states
> will be loaded at Guest entry. Before doing that, KVM needs
> to check if CPU CET feature is available.

Use the changelog to describe *why* the patch does what it does, for
something this simple it's obvious *what* the patch adds.  Specifically,
there was a decent amount of discussion regarding the virtualization
hole that gets introduced when SHSTK!=IBT, and that need to be captured
in the changelog.

> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 28b8ac027bd7..246467c12930 100644
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
> @@ -5414,6 +5415,23 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  			return 1;
>  	}
>  
> +	/*
> +	 * To enable Guest CET, check whether CPU CET feature is
> +	 * available, if it's there, set Guest CET state loading bit
> +	 * per CR4.CET status, otherwise, return a fault to Guest.
> +	 */

No need for the comment, the code is straightforward.

> +	if (guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) ||
> +	    guest_cpuid_has(vcpu, X86_FEATURE_IBT)) {
> +		if (cr4 & X86_CR4_CET)
> +			vmcs_set_bits(VM_ENTRY_CONTROLS,
> +				      VM_ENTRY_LOAD_GUEST_CET_STATE);
> +		else
> +			vmcs_clear_bits(VM_ENTRY_CONTROLS,
> +					VM_ENTRY_LOAD_GUEST_CET_STATE);
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
