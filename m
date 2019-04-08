Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343C5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5EF217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfDHOlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:41:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:46875 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbfDHOlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:41:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 07:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="289731163"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2019 07:41:15 -0700
Date:   Mon, 8 Apr 2019 07:41:15 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     KVM <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: Re: [PATCH -v5] x86/kvm: Implement HWCR support
Message-ID: <20190408144115.GA25880@linux.intel.com>
References: <20190408090946.GA2315@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408090946.GA2315@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:09:46AM +0200, Borislav Petkov wrote:
> Hi all,
> 
> here's v5 which keeps the HWCR functionality in kvm/x86.c so that
> emulation of AMD guests on Intel hw still can work.
> 
> --
> From: Borislav Petkov <bp@suse.de>
> 
> The AMD hardware configuration register has some useful bits which can
> be used by guests. Implement McStatusWrEn which can be used by guests
> when injecting MCEs with the in-kernel mce-inject module.
> 
> For that, we need to set bit 18 - McStatusWrEn - first, before writing
> the MCi_STATUS registers (otherwise we #GP).
> 
> Add the required machinery to do so.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: KVM <kvm@vger.kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/x86.c              | 45 ++++++++++++++++++++++++++++-----
>  2 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 159b5988292f..541c431df806 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -780,6 +780,9 @@ struct kvm_vcpu_arch {
>  
>  	/* Flush the L1 Data cache for L1TF mitigation on VMENTER */
>  	bool l1tf_flush_l1d;
> +
> +	/* AMD MSRC001_0015 Hardware Configuration */
> +	u64 msr_hwcr;
>  };
>  
>  struct kvm_lpage_info {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 099b851dabaf..e07f21c1d2d4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2273,6 +2273,30 @@ static void kvmclock_sync_fn(struct work_struct *work)
>  					KVMCLOCK_SYNC_PERIOD);
>  }
>  
> +/*
> + * On AMD, HWCR[McStatusWrEn] controls whether setting MCi_STATUS results in #GP.
> + */
> +static bool __set_mci_status(struct kvm_vcpu *vcpu, struct msr_data *msr_info)

The name and return value semantics are confusing since kvm_set_msr*()
returns '1' to signal fault, '0' to signal success.  Most MSR helpers have
"valid" somewhere in the function name to avoid confusion regarding the
return value.

> +{
> +	if (guest_cpuid_is_amd(vcpu)) {
> +		struct msr_data tmp;
> +
> +		tmp.index = MSR_K7_HWCR;
> +
> +		if (kvm_get_msr_common(vcpu, &tmp))

No need to get through kvm_get_msr_common(), vcpu->arch.msr_hwcr can be
queried directly.  Going that route would likely eliminate the need for a
helper func, i.e. avoid the naming confusion and the comment below.

> +			return false;
> +
> +		/* McStatusWrEn enabled? */
> +		if (tmp.data & BIT_ULL(18))
> +			return true;
> +	}
> +
> +	if (msr_info->data != 0)

Irrevelant if this helper gets dropped, but why not "return !msr_info->data;"?

> +		return false;
> +
> +	return true;
> +}
> +
>  static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
>  	u64 mcg_cap = vcpu->arch.mcg_cap;
> @@ -2304,9 +2328,13 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			if ((offset & 0x3) == 0 &&
>  			    data != 0 && (data | (1 << 10)) != ~(u64)0)
>  				return -1;
> -			if (!msr_info->host_initiated &&
> -				(offset & 0x3) == 1 && data != 0)
> -				return -1;
> +
> +			/* MCi_STATUS */
> +			if ((offset & 0x3) == 1 && !msr_info->host_initiated) {
> +				if (!__set_mci_status(vcpu, msr_info))
> +						return -1;
> +			}
> +
>  			vcpu->arch.mce_banks[offset] = data;
>  			break;
>  		}
> @@ -2455,8 +2483,11 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		data &= ~(u64)0x40;	/* ignore flush filter disable */
>  		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
>  		data &= ~(u64)0x8;	/* ignore TLB cache disable */
> -		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
> -		if (data != 0) {
> +
> +		/* Handle McStatusWrEn */
> +		if (data == BIT_ULL(18)) {
> +			vcpu->arch.msr_hwcr = data;
> +		} else if (data != 0) {
>  			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
>  				    data);
>  			return 1;
> @@ -2730,7 +2761,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_K8_SYSCFG:
>  	case MSR_K8_TSEG_ADDR:
>  	case MSR_K8_TSEG_MASK:
> -	case MSR_K7_HWCR:
>  	case MSR_VM_HSAVE_PA:
>  	case MSR_K8_INT_PENDING_MSG:
>  	case MSR_AMD64_NB_CFG:
> @@ -2894,6 +2924,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_MISC_FEATURES_ENABLES:
>  		msr_info->data = vcpu->arch.msr_misc_features_enables;
>  		break;
> +	case MSR_K7_HWCR:
> +		msr_info->data = vcpu->arch.msr_hwcr;
> +		break;
>  	default:
>  		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
>  			return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
> -- 
> 2.21.0
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
