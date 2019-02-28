Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03028C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD10220863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfCABta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:49:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:31757 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfCABt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 20:49:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 17:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="118657832"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2019 17:49:27 -0800
Date:   Thu, 28 Feb 2019 16:44:04 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>,
        weijiang.yang@intel.com
Subject: Re: [PATCH v3 7/8] KVM:X86: Add XSS bit 11 and 12 support for CET
 xsaves/xrstors.
Message-ID: <20190228084404.GD12006@local-michael-cet-test.sh.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-8-weijiang.yang@intel.com>
 <20190228162512.GG6166@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228162512.GG6166@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 08:25:12AM -0800, Sean Christopherson wrote:
> On Mon, Feb 25, 2019 at 09:27:15PM +0800, Yang Weijiang wrote:
> > For Guest XSS, right now, only bit 11(user states) and bit 12
> > (supervisor states) are supported, if other bits are being set,
> > need to modify KVM_SUPPORTED_XSS macro to have support.
> 
> The changelog should describe what the change does directly.  Referencing
> specific bits implies that the code is explicitly checking for said bits,
> which it does not.  And there's no need to advise readers on how to add
> more bits in the future, e.g. the KVM_SUPPORTED_XSS macro may not exist
> the next time new bits are added.  Just cover what the patch does and why.
> 
> Something like:
> 
> KVM: x86: Allow the guest to set supported bits in XSS
> 
> ...now that KVM supports setting CET related bits.  Previously, KVM did
> not support setting any bits in XSS and so hardcoded its check to inject
> a #GP if the guest attempted to write a non-zero value to IA32_XSS.
>
good point! Will change these description.
> > 
> > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > ---
> >  arch/x86/kvm/vmx.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index d32cee9ee079..68908ed7b151 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -47,6 +47,7 @@
> >  #include <asm/virtext.h>
> >  #include <asm/mce.h>
> >  #include <asm/fpu/internal.h>
> > +#include <asm/fpu/types.h>
> >  #include <asm/perf_event.h>
> >  #include <asm/debugreg.h>
> >  #include <asm/kexec.h>
> > @@ -4336,12 +4337,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  	case MSR_IA32_XSS:
> >  		if (!vmx_xsaves_supported())
> >  			return 1;
> > +
> >  		/*
> > -		 * The only supported bit as of Skylake is bit 8, but
> > -		 * it is not supported on KVM.
> > +		 * Check bits being set are supported in KVM.
> 
> I'd drop the comment altogether, it's pretty obvious from the code that
> were checking which bits are supported.
you won't see these redundancies in next version ;)
> >  		 */
> > -		if (data != 0)
> > +		if (data & ~kvm_supported_xss())
> >  			return 1;
> > +
> >  		vcpu->arch.ia32_xss = data;
> >  		if (vcpu->arch.ia32_xss != host_xss)
> >  			add_atomic_switch_msr(vmx, MSR_IA32_XSS,
> > -- 
> > 2.17.1
> > 
