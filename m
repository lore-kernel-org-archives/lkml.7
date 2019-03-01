Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2936920850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfCAO6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:58:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:32203 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732668AbfCAO6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:58:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 06:58:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,427,1544515200"; 
   d="scan'208";a="128242057"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2019 06:58:19 -0800
Date:   Fri, 1 Mar 2019 06:58:19 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v3 6/8] KVM:VMX: Load Guest CET via VMCS when CET is
 enabled in Guest
Message-ID: <20190301145819.GC22584@linux.intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
 <20190225132716.6982-7-weijiang.yang@intel.com>
 <20190228161715.GF6166@linux.intel.com>
 <20190228083844.GC12006@local-michael-cet-test.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228083844.GC12006@local-michael-cet-test.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:38:44PM +0800, Yang Weijiang wrote:
> On Thu, Feb 28, 2019 at 08:17:15AM -0800, Sean Christopherson wrote:
> > On Mon, Feb 25, 2019 at 09:27:14PM +0800, Yang Weijiang wrote:
> > > "Load Guest CET state" bit controls whether guest CET states
> > > will be loaded at Guest entry. Before doing that, KVM needs
> > > to check if CPU CET feature is available.
> > > 
> > > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >  arch/x86/kvm/vmx.c | 32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > > index 89ee086e1729..d32cee9ee079 100644
> > > --- a/arch/x86/kvm/vmx.c
> > > +++ b/arch/x86/kvm/vmx.c
> > > @@ -55,6 +55,7 @@
> > >  #include <asm/mmu_context.h>
> > >  #include <asm/spec-ctrl.h>
> > >  #include <asm/mshyperv.h>
> > > +#include <asm/cet.h>
> > >  
> > >  #include "trace.h"
> > >  #include "pmu.h"
> > > @@ -4065,6 +4066,20 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
> > >  	return !(val & ~valid_bits);
> > >  }
> > >  
> > > +static int vmx_guest_cet_cap(struct kvm_vcpu *vcpu)
> > > +{
> > > +	u32 eax, ebx, ecx, edx;
> > > +
> > > +	/*
> > > +	 * Guest CET can work as long as HW supports the feature, independent
> > > +	 * to Host SW enabling status.
> > > +	 */
> > > +	cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
> > > +
> > > +	return ((ecx & bit(X86_FEATURE_SHSTK)) |
> > > +		(edx & bit(X86_FEATURE_IBT))) ? 1 : 0;
> > 
> > Given the holes in the (current) architecture/spec, I think KVM has to
> > require both features to be supported in the guest to allow CR4.CET to
> > be enabled.
> The reason why I use a "OR" here is to keep CET enabling control the
> same as that on host, right now on host, users can select to enable  SHSTK or IBT
> feature by disabling the unexpected one. It's free to select SHSTK & IBT
> or SHSTK | IBT.

Which is not the same as SHSTK != IBT in *hardware*, which is effectively
what this is allowing for the guest.  The problem is that the architecture
doesn't cleanly separate the two features, i.e. we'd have a virtualization
hole where the guest could touch state for a disabled feature.

Regardless, the guest would still be able to selectively enable each CET
feature, it would just never see a model where SHSTK != IBT.
