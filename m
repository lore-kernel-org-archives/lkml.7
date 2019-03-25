Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36891C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D52720700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfCYSVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:21:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:20771 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfCYSVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:21:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 11:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="155664899"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2019 11:21:33 -0700
Date:   Mon, 25 Mar 2019 11:21:33 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kvm/x86: Move MSR_K7_HWCR to svm.c
Message-ID: <20190325182133.GG31069@linux.intel.com>
References: <20190325171649.7311-1-bp@alien8.de>
 <20190325171649.7311-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325171649.7311-2-bp@alien8.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 06:16:48PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> This is an AMD-specific MSR. Put it where it belongs.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kvm/svm.c | 14 ++++++++++++++
>  arch/x86/kvm/x86.c | 12 ------------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index b5b128a0a051..00eb44a2a377 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4201,6 +4201,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_F10H_DECFG:
>  		msr_info->data = svm->msr_decfg;
>  		break;
> +	case MSR_K7_HWCR:
> +		msr_info->data = 0;
> +		break;
>  	default:
>  		return kvm_get_msr_common(vcpu, msr_info);
>  	}
> @@ -4405,6 +4408,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		svm->msr_decfg = data;
>  		break;
>  	}
> +	case MSR_K7_HWCR:
> +		data &= ~(u64)0x40;	/* ignore flush filter disable */
> +		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
> +		data &= ~(u64)0x8;	/* ignore TLB cache disable */
> +		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
> +		if (data != 0) {
> +			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
> +				    data);
> +			return 1;
> +		}
> +		break;
>  	case MSR_IA32_APICBASE:
>  		if (kvm_vcpu_apicv_active(vcpu))
>  			avic_update_vapic_bar(to_svm(vcpu), data);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 65e4559eef2f..e53d13cfceba 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2445,17 +2445,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		break;
>  	case MSR_EFER:
>  		return set_efer(vcpu, data);
> -	case MSR_K7_HWCR:
> -		data &= ~(u64)0x40;	/* ignore flush filter disable */
> -		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
> -		data &= ~(u64)0x8;	/* ignore TLB cache disable */
> -		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
> -		if (data != 0) {
> -			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
> -				    data);
> -			return 1;
> -		}
> -		break;
>  	case MSR_FAM10H_MMIO_CONF_BASE:
>  		if (data != 0) {
>  			vcpu_unimpl(vcpu, "unimplemented MMIO_CONF_BASE wrmsr: "
> @@ -2724,7 +2713,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_K8_SYSCFG:
>  	case MSR_K8_TSEG_ADDR:
>  	case MSR_K8_TSEG_MASK:
> -	case MSR_K7_HWCR:

Won't this prevent emulating an AMD guest on Intel hardware, e.g. due to
injecting #GPs during boot?  Keeping support in kvm_{get,set}_msr_common
doesn't preclude svm_{get,set}_msr() from having SVM-specific handling for
the MSR.

>  	case MSR_VM_HSAVE_PA:
>  	case MSR_K8_INT_PENDING_MSG:
>  	case MSR_AMD64_NB_CFG:
> -- 
> 2.21.0
> 
