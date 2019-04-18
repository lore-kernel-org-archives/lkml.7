Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B59C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3402221479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbfDROit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:38:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:40294 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388277AbfDROis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:38:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 07:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="143965973"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2019 07:38:47 -0700
Date:   Thu, 18 Apr 2019 07:38:47 -0700
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
Subject: Re: [PATCH -v5.1] x86/kvm: Implement HWCR support
Message-ID: <20190418143847.GC17218@linux.intel.com>
References: <20190408090946.GA2315@zn.tnic>
 <20190408144115.GA25880@linux.intel.com>
 <20190408145716.GG15689@zn.tnic>
 <20190418122842.GF27160@zn.tnic>
 <20190418135606.GA17218@linux.intel.com>
 <20190418141949.GK27160@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418141949.GK27160@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 04:19:49PM +0200, Borislav Petkov wrote:
> On Thu, Apr 18, 2019 at 06:56:06AM -0700, Sean Christopherson wrote:
> > This doesn't allow writing '0' regardless of msr_hwcr.BIT(18), which was
> > previously supported.
> 
> Restored the old conditional:
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 10f6acc6494c..f74f1280745b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2318,7 +2318,8 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  				return -1;
>  
>  			/* MCi_STATUS */
> -			if ((offset & 0x3) == 1 && !msr_info->host_initiated) {
> +			if (!msr_info->host_initiated &&
> +			    (offset & 0x3) == 1 && data != 0) {
>  				if (!can_set_mci_status(vcpu))
>  					return -1;
>  			}
> 
> > And there's no need for multiple if statements.
> 
> It is a bit more readable this way.
> 
> Actually, I'd break that if above into smaller if-statements with
> flipped logic to make it even more readable:
> 
> 	if (msr_info->host_initiated)
> 		goto set_msr;
> 
> 	if (!(offset & 0x3))
> 		goto set_msr;
> 
> 	if (!data)
> 		goto set_msr;
> 
> 	if (!can_set_mci_status(vcpu))
> 		return -1;

At that point it probably makes sense to rework the whole block as there
are existing issues in both the CTL and STATUS flows:

  - Fault cases should return '1', not '-1'.

  - host_initiated should be checked for the CTL case


My personal preference would be to combine the host_initiated and !data
checks for brevity, so something like:

	if (msr_info->host_initiated || !data)
		goto set_msr;

	offset = msr - MSR_IA32_MC0_CTL;
	if ((offset & 0x3) == 0 && (data | (1 << 10)) != ~(u64)0)
		return 1;
	if ((offset & 0x3) == 1 && !can_set_mci_status(vcpu))
		return 1;

set_msr:

> 
> set_msr:
> 	...
> 
> 
> Anything else? Can I send v5.2 now?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
