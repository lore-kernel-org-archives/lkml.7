Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618DAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED10218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfDOSja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:39:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:42840 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfDOSja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:39:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 11:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="337830884"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2019 11:39:29 -0700
Date:   Mon, 15 Apr 2019 11:39:29 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: vmx: print more APICv fields in dump_vmcs
Message-ID: <20190415183929.GI24010@linux.intel.com>
References: <1555335333-23636-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555335333-23636-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:35:32PM +0200, Paolo Bonzini wrote:
> The SVI, RVI, virtual-APIC page address and APIC-access page address fields
> were left out of dump_vmcs.  Add them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ab432a930ae8..f8054dc1de65 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5723,8 +5723,17 @@ static void dump_vmcs(void)
>  	if (secondary_exec_control & SECONDARY_EXEC_TSC_SCALING)
>  		pr_err("TSC Multiplier = 0x%016llx\n",
>  		       vmcs_read64(TSC_MULTIPLIER));
> -	if (cpu_based_exec_ctrl & CPU_BASED_TPR_SHADOW)
> -		pr_err("TPR Threshold = 0x%02x\n", vmcs_read32(TPR_THRESHOLD));
> +	if (cpu_based_exec_ctrl & CPU_BASED_TPR_SHADOW) {
> +		if (secondary_exec_control & SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY) {
> +			u16 status = vmcs_read16(GUEST_INTR_STATUS);
> +			pr_err("SVI|RVI = %02x|%02x ", status >> 8, status & 0xff);
> +		}
> +		pr_err(KERN_CONT "TPR Threshold = 0x%02x\n", vmcs_read32(TPR_THRESHOLD));

Might be worth adding a blurb in the changelog stating it's ok to use
KERN_CONT even though it's technically not SMP safe, as the whole
dump_vmcs() flow isn't exactly SMP safe.

> +		if (secondary_exec_control & (SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
> +		    			      SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE))

Do we really want to dump the APIC access page address for x2APIC?  I
assume your intent is to show the value that *could* be used if the guest
were to disable x2APIC, but that might be misleading since APIC_ACCESS_ADDR
is checked if and only if VIRTUALIZE_APIC_ACCESSES=1, e.g. someone might
think a VM-Enter failed because APIC_ACCESS_ADDR has a "bad" value even
though it's ignored.

> +			pr_err("APIC-access addr = 0x%016llx ", vmcs_read64(APIC_ACCESS_ADDR));
> +		pr_err(KERN_CONT "virt-APIC addr=0x%016llx\n", vmcs_read64(VIRTUAL_APIC_PAGE_ADDR));
> +	}
>  	if (pin_based_exec_ctrl & PIN_BASED_POSTED_INTR)
>  		pr_err("PostedIntrVec = 0x%02x\n", vmcs_read16(POSTED_INTR_NV));
>  	if ((secondary_exec_control & SECONDARY_EXEC_ENABLE_EPT))
> -- 
> 1.8.3.1
> 
