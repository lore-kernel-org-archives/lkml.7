Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11A0C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB74720651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfHMAGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 20:06:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:23189 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfHMAGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:06:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 17:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,379,1559545200"; 
   d="scan'208";a="194074953"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2019 17:06:04 -0700
Date:   Mon, 12 Aug 2019 17:06:04 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com,
        jmattson@google.com
Subject: Re: [PATCH v6 3/8] KVM: x86: Implement CET CPUID enumeration for
 Guest
Message-ID: <20190813000604.GI4996@linux.intel.com>
References: <20190725031246.8296-1-weijiang.yang@intel.com>
 <20190725031246.8296-4-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725031246.8296-4-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:12:41AM +0800, Yang Weijiang wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 652b3876ea5c..ce1d6fe21780 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1637,6 +1637,11 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
>  	return !(val & ~valid_bits);
>  }
>  
> +static inline u64 vmx_supported_xss(void)
> +{
> +	return host_xss;

Do you know if the kernel will ever enable CET_USER but not CET_KERNEL,
and vice versa?  I tried hunting down the logic in the main CET enabling
series but couldn't find the relevant code.

If the kernel does enable USER vs. KERNEL independently, are we sure that
KVM can correctly virtualize that state and that the guest OS won't die
due to expecting all CET features or no CET features?

In other words, do we want to return host_xss as is, or do we want to
make CET_USER and CET_KERNEL a bundle deal and avoid the headache, e.g.:

	if (!(host_xss & XFEATURE_MASK_CET_USER) ||
	    !(host_xss & XFEATURE_MASK_CET_KERNEL))
		return host_xss & ~(XFEATURE_MASK_CET_USER |
				    XFEATURE_MASK_CET_KERNEL);
	return host_xss; 

> +}
> +
>  static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
>  {
>  	switch (msr->index) {
> @@ -7724,6 +7729,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  	.get_vmcs12_pages = NULL,
>  	.nested_enable_evmcs = NULL,
>  	.need_emulation_on_page_fault = vmx_need_emulation_on_page_fault,
> +	.supported_xss = vmx_supported_xss,
>  };
>  
>  static void vmx_cleanup_l1d_flush(void)
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index a470ff0868c5..6a1870044752 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -288,6 +288,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, unsigned long cr2,
>  				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
>  				| XFEATURE_MASK_PKRU)
> +
> +#define KVM_SUPPORTED_XSS	(XFEATURE_MASK_CET_USER \
> +				| XFEATURE_MASK_CET_KERNEL)
> +
>  extern u64 host_xcr0;
>  
>  extern u64 kvm_supported_xcr0(void);
> -- 
> 2.17.2
> 
