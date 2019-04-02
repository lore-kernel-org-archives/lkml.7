Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B82FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75912075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDBUfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:35:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:46496 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfDBUfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:35:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 13:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,302,1549958400"; 
   d="scan'208";a="219946566"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2019 13:35:45 -0700
Date:   Tue, 2 Apr 2019 13:35:45 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com
Subject: Re: [RFC PATCH v4 8/8] KVM:x86: Add user-space read/write interface
 for CET MSRs
Message-ID: <20190402203545.GK31303@linux.intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
 <20190318150351.15550-9-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318150351.15550-9-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:03:51PM +0800, Yang Weijiang wrote:
> When VMExit occurs, the Guest CET MSRs are stored in two different
> places, U_CET/PL0_SSP/PL1_SSP/PL2_SSP/PL3_SSP are stored in fpu
> xsave area, they are operated by XSAVES/XRSTORS, so before access
> these MSRs, kvm_load_guest_fpu is required to restore them to Host MSRs.
> After finish operation, need to restore Host MSRs by kvm_put_guest_fpu,
> these two functions are call in __msr_io(). S_CET and INTR_SSP_TABLE
> are stored in VMCS fields, so they can be access via vmcs_read/vmcs_write
> directly.

Hmm, the changelog reads like the kvm_load_guest_fpu() behavior is
introduced in this patch.  It should be reworded to make it more obvious
that a previous patch handled that behavior.  Alternatively, just fold
this into said previous patch.

> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h |  2 ++
>  arch/x86/kvm/vmx.c               | 42 ++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 298721ff00f4..cc94ab14a946 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -782,6 +782,8 @@
>  #define MSR_IA32_U_CET		0x6a0 /* user mode cet setting */
>  #define MSR_IA32_S_CET		0x6a2 /* kernel mode cet setting */
>  #define MSR_IA32_PL0_SSP	0x6a4 /* kernel shstk pointer */
> +#define MSR_IA32_PL1_SSP	0x6a5 /* ring 1 shstk pointer */
> +#define MSR_IA32_PL2_SSP	0x6a6 /* ring 2 shstk pointer */
>  #define MSR_IA32_PL3_SSP	0x6a7 /* user shstk pointer */
>  #define MSR_IA32_INT_SSP_TAB	0x6a8 /* exception shstk table */
>  
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 816e11a66557..5923b89fe120 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4153,6 +4153,27 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			return 1;
>  		msr_info->data = vcpu->arch.ia32_xss;
>  		break;
> +	case MSR_IA32_S_CET:
> +		msr_info->data = vmcs_readl(GUEST_S_CET);
> +		break;
> +	case MSR_IA32_U_CET:
> +		rdmsrl(MSR_IA32_U_CET, msr_info->data);
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		msr_info->data = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +		break;
> +	case MSR_IA32_PL0_SSP:
> +		rdmsrl(MSR_IA32_PL0_SSP, msr_info->data);
> +		break;
> +	case MSR_IA32_PL1_SSP:
> +		rdmsrl(MSR_IA32_PL1_SSP, msr_info->data);
> +		break;
> +	case MSR_IA32_PL2_SSP:
> +		rdmsrl(MSR_IA32_PL2_SSP, msr_info->data);
> +		break;
> +	case MSR_IA32_PL3_SSP:
> +		rdmsrl(MSR_IA32_PL3_SSP, msr_info->data);
> +		break;
>  	case MSR_TSC_AUX:
>  		if (!msr_info->host_initiated &&
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> @@ -4337,6 +4358,27 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		else
>  			clear_atomic_switch_msr(vmx, MSR_IA32_XSS);
>  		break;
> +	case MSR_IA32_S_CET:
> +		vmcs_writel(GUEST_S_CET, data);
> +		break;
> +	case MSR_IA32_U_CET:
> +		wrmsrl(MSR_IA32_U_CET, data);
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		vmcs_writel(GUEST_INTR_SSP_TABLE, data);
> +		break;
> +	case MSR_IA32_PL0_SSP:
> +		wrmsrl(MSR_IA32_PL0_SSP, data);
> +		break;
> +	case MSR_IA32_PL1_SSP:
> +		wrmsrl(MSR_IA32_PL1_SSP, data);
> +		break;
> +	case MSR_IA32_PL2_SSP:
> +		wrmsrl(MSR_IA32_PL2_SSP, data);
> +		break;
> +	case MSR_IA32_PL3_SSP:
> +		wrmsrl(MSR_IA32_PL3_SSP, data);
> +		break;
>  	case MSR_TSC_AUX:
>  		if (!msr_info->host_initiated &&
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> -- 
> 2.17.1
> 
