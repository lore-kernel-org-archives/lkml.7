Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150E6C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 05:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1A721479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 05:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfDTFfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 01:35:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:43741 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfDTFfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 01:35:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 22:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,372,1549958400"; 
   d="scan'208";a="144225083"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2019 22:35:16 -0700
Date:   Fri, 19 Apr 2019 22:35:16 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: allow tests to use bad virtual-APIC page
 address
Message-ID: <20190420053516.GA15539@linux.intel.com>
References: <1555335333-23636-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555335333-23636-2-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:35:33PM +0200, Paolo Bonzini wrote:
> As mentioned in the comment, there are some special cases where we can simply
> clear the TPR shadow bit from the CPU-based execution controls in the vmcs02.
> Handle them so that we can remove some XFAILs from vmx.flat.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 25 ++++++++++++++++---------
>  arch/x86/kvm/vmx/vmx.c    |  2 +-
>  arch/x86/kvm/vmx/vmx.h    |  2 ++
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 7ec9bb1dd723..a22af5a85540 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2873,20 +2873,27 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  		/*
>  		 * If translation failed, VM entry will fail because
>  		 * prepare_vmcs02 set VIRTUAL_APIC_PAGE_ADDR to -1ull.
> -		 * Failing the vm entry is _not_ what the processor
> -		 * does but it's basically the only possibility we
> -		 * have.  We could still enter the guest if CR8 load
> -		 * exits are enabled, CR8 store exits are enabled, and
> -		 * virtualize APIC access is disabled; in this case
> -		 * the processor would never use the TPR shadow and we
> -		 * could simply clear the bit from the execution
> -		 * control.  But such a configuration is useless, so
> -		 * let's keep the code simple.
>  		 */
>  		if (!is_error_page(page)) {
>  			vmx->nested.virtual_apic_page = page;
>  			hpa = page_to_phys(vmx->nested.virtual_apic_page);
>  			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
> +		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
> +		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
> +			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
> +			/*
> +			 * The processor will never use the TPR shadow, simply
> +			 * clear the bit from the execution control.  Such a
> +			 * configuration is useless, but it happens in tests.
> +			 * For any other configuration, failing the vm entry is
> +			 * _not_ what the processor does but it's basically the
> +			 * only possibility we have.
> +			 */
> +			vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
> +					CPU_BASED_TPR_SHADOW);
> +		} else {
> +			printk("bad virtual-APIC page address\n");
> +			dump_vmcs();

I don't think we should dump the VMCS here, or have any form of print
at all.  dump_vmcs() is especially bad as it allows userspace to spam
the kernel log at the error level.  I haven't actually checked, but I
assume the nested consistency check tracing patch would be a better
way to debug something of this nature in production.

>  		}
>  	}
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f8054dc1de65..14cacfd7ffd0 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5603,7 +5603,7 @@ static void vmx_dump_dtsel(char *name, uint32_t limit)
>  	       vmcs_readl(limit + GUEST_GDTR_BASE - GUEST_GDTR_LIMIT));
>  }
>  
> -static void dump_vmcs(void)
> +void dump_vmcs(void)
>  {
>  	u32 vmentry_ctl = vmcs_read32(VM_ENTRY_CONTROLS);
>  	u32 vmexit_ctl = vmcs_read32(VM_EXIT_CONTROLS);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index a1e00d0a2482..f879529906b4 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -517,4 +517,6 @@ static inline void decache_tsc_multiplier(struct vcpu_vmx *vmx)
>  	vmcs_write64(TSC_MULTIPLIER, vmx->current_tsc_ratio);
>  }
>  
> +void dump_vmcs(void);
> +
>  #endif /* __KVM_X86_VMX_H */
> -- 
> 1.8.3.1
> 
