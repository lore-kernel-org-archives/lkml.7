Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C532FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD12208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDZQCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:02:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:27034 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfDZQCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:02:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 09:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,398,1549958400"; 
   d="scan'208";a="134655047"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2019 09:02:45 -0700
Date:   Fri, 26 Apr 2019 09:02:45 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Message-ID: <20190426160244.GA5224@linux.intel.com>
References: <1556293486-8888-1-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556293486-8888-1-git-send-email-like.xu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:44:46PM +0800, Like Xu wrote:
> Add support to expose Intel V2 Extended Topology Enumeration Leaf for
> some new systems with multiple software-visible die within each package.
> 
> When CPUID executes with EAX set to 1FH, the processor returns information
> about extended topology enumeration data. Software must detect the presence
> of CPUID leaf 1FH by verifying (a) the highest leaf index supported by
> CPUID is >= 1FH, and (b) CPUID.1FH:EBX[15:0] reports a non-zero value.

Nit: When quoting the SDM, it's helpful to explicitly say so, otherwise
readers may assume you're just stating your take on things.

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

> 
> Co-developed-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
> 
> ==changelog==
> v3:
> - Redefine commit message and comment
> 
> v2:
> - Apply cpuid.1f check rule on Intel SDM page 3-222 Vol.2A
> - Add comment to handle 0x1f anf 0xb in common code
> - Reduce check time in a descending-break style
> 
> v1: https://lkml.org/lkml/2019/4/22/28
> 
>  arch/x86/kvm/cpuid.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index fd39516..176a67a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -425,6 +425,11 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  
>  	switch (function) {
>  	case 0:
> +		/* Check if the cpuid leaf 0x1f is actually implemented */
> +		if (entry->eax >= 0x1f && (cpuid_ebx(0x1f) & 0x0000ffff)) {
> +			entry->eax = 0x1f;
> +			break;
> +		}
>  		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
>  		break;
>  	case 1:
> @@ -544,7 +549,11 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		entry->edx = edx.full;
>  		break;
>  	}
> -	/* function 0xb has additional index. */
> +	/*
> +	 * Per Intel's SDM, 0x1f is a superset of 0xb, thus they can be handled
> +	 * by common code.
> +	 */
> +	case 0x1f:
>  	case 0xb: {
>  		int i, level_type;
>  
> -- 
> 1.8.3.1
> 
