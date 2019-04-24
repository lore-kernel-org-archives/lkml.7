Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA1BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6CE2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfDXOcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:32:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:15660 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfDXOcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:32:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 07:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="167504859"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2019 07:32:38 -0700
Date:   Wed, 24 Apr 2019 07:32:38 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Message-ID: <20190424143238.GB18442@linux.intel.com>
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

Now that I understand how min() works...

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

This is broken because of how CPUID works for unsupported input leafs:

  If a value entered for CPUID.EAX is higher than the maximum input value
  for basic or extended function for that processor then the data for the
  highest basic information leaf is returned. 

For example, my system with a max basic leaf of 0x16 returns 0x00000e74
for CPUID.1F.EAX.

> +
> +	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && (eax != 0);

Checking 'eax != 0' is broken as it will be '0' when SMT is disabled.  ecx
is the obvious choice since bits 15:8 are guaranteed to be non-zero when
the leaf is valid.

I think we can skip the vendor check.  AFAIK, CPUID.1F isn't used by AMD,
and since AMD and Intel try to maintain a semblance of CPUID compatibility
it seems more likely that AMD/Hygon would implement CPUID.1F as-is rather
than repurpose it to mean something else entirely.

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

If we put everything together, I think the code can be reduced to:

		/* comment about multi-chip leaf... */
		if (entry->eax >= 0x1f && cpuid_ecx(0x1f))
			entry->eax = 0x1f;
		else
			entry->eax = min(entry->eax,
					 (u32)(f_intel_pt ? 0x14 : 0xd));
>  		break;
>  	case 1:
>  		entry->edx &= kvm_cpuid_1_edx_x86_features;
> @@ -544,6 +555,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		entry->edx = edx.full;
>  		break;
>  	}
> +	/* function 0x1f has additional index. */
> +	case 0x1f:
>  	/* function 0xb has additional index. */
>  	case 0xb: {
>  		int i, level_type;
> -- 
> 1.8.3.1
> 
