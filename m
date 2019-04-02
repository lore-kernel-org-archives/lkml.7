Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB939C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F2C2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDBUjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:39:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:45048 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfDBUjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:39:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 13:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,302,1549958400"; 
   d="scan'208";a="288137044"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2019 13:39:50 -0700
Date:   Tue, 2 Apr 2019 13:39:50 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com
Subject: Re: [RFC PATCH v4 7/8] KVM:x86: load guest fpu state when accessing
 MSRs managed by XSAVES
Message-ID: <20190402203950.GL31303@linux.intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
 <20190318150351.15550-8-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318150351.15550-8-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:03:50PM +0800, Yang Weijiang wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> A handful of CET MSRs are not context switched through "traditional"
> methods, e.g. VMCS or manual switching, but rather are passed through
> to the guest and are saved and restored by XSAVES/XRSTORS, i.e. the
> guest's FPU state.
> 
> Load the guest's FPU state if userspace is accessing MSRs whose values
> are managed by XSAVES so that the MSR helper, e.g. vmx_{get,set}_msr(),
> can simply do {RD,WR}MSR to access the guest's value.
> 
> Note that guest_cpuid_has() is not queried as host userspace is allowed
> to access MSRs that have not been exposed to the guest, e.g. it might do
> KVM_SET_MSRS prior to KVM_SET_CPUID2.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>

Needs Co-developed-by: since you made modifications to the patch I sent.

> ---
>  arch/x86/kvm/x86.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a0f8b71b2132..ed747dfbff69 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -104,6 +104,8 @@ static void enter_smm(struct kvm_vcpu *vcpu);
>  static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
>  static void store_regs(struct kvm_vcpu *vcpu);
>  static int sync_regs(struct kvm_vcpu *vcpu);
> +static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> +static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
>  
>  struct kvm_x86_ops *kvm_x86_ops __read_mostly;
>  EXPORT_SYMBOL_GPL(kvm_x86_ops);
> @@ -2889,6 +2891,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  }
>  EXPORT_SYMBOL_GPL(kvm_get_msr_common);
>  
> +static bool is_xsaves_msr(u32 index)
> +{
> +	return index == MSR_IA32_U_CET ||
> +	       (index >= MSR_IA32_PL0_SSP && index <= MSR_IA32_PL3_SSP);
> +}
> +
>  /*
>   * Read or write a bunch of msrs. All parameters are kernel addresses.
>   *
> @@ -2899,11 +2907,33 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
>  		    int (*do_msr)(struct kvm_vcpu *vcpu,
>  				  unsigned index, u64 *data))
>  {
> +	bool fpu_loaded = false;
> +	bool xss_loaded = false;
>  	int i;
> +	u64 cet_bits = XFEATURE_MASK_SHSTK_USER | XFEATURE_MASK_SHSTK_KERNEL;
> +	u64 host_xss = 0;
> +
> +	for (i = 0; i < msrs->nmsrs; ++i) {
> +		if (!fpu_loaded && is_xsaves_msr(entries[i].index)) {
> +			if (!kvm_x86_ops->xsaves_supported())
> +				continue;
> +
> +			if (!xss_loaded) {
> +				rdmsrl(MSR_IA32_XSS, host_xss);

Rather than do rdmsr(), we can query host_xss via kvm_x86_ops, e.g.:

			if (!kvm_x86_ops->xsaves_supported() ||
			    !kvm_x86_ops->supported_xss())
				continue;

> +				xss_loaded = true;
> +			}
> +
> +			if ((host_xss & cet_bits) != cet_bits)
> +				continue;
>  
> -	for (i = 0; i < msrs->nmsrs; ++i)
> +			kvm_load_guest_fpu(vcpu);
> +			fpu_loaded = true;
> +		}
>  		if (do_msr(vcpu, entries[i].index, &entries[i].data))
>  			break;
> +	}
> +	if (fpu_loaded)
> +		kvm_put_guest_fpu(vcpu);
>  
>  	return i;
>  }
> -- 
> 2.17.1
> 
