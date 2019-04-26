Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A9AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE81206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfDZPEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:04:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:37695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfDZPEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:04:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 08:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="146097940"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2019 08:04:36 -0700
Date:   Fri, 26 Apr 2019 08:04:36 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc:     Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Message-ID: <20190426150436.GD4140@linux.intel.com>
References: <1556248672-6469-1-git-send-email-like.xu@linux.intel.com>
 <20190426141346.GA4140@linux.intel.com>
 <d5e3fea7e1bb58ae24ba92056ff61ada52c28b65.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e3fea7e1bb58ae24ba92056ff61ada52c28b65.camel@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:54:19PM +0800, Xiaoyao Li wrote:
> On Fri, 2019-04-26 at 07:13 -0700, Sean Christopherson wrote:
> > On Fri, Apr 26, 2019 at 11:17:52AM +0800, Like Xu wrote:
> > > Some new systems have multiple software-visible die within each package.
> > > Add support to expose Intel V2 Extended Topology Enumeration Leaf CPUID.1F.
> > > 
> > > Co-developed-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> > > ---
> > > 
> > > ==changelog==
> > > v2:
> > > - Apply cpuid.1f check rule on Intel SDM page 3-222 Vol.2A
> > > - Add comment to handle 0x1f anf 0xb in common code
> > > - Reduce check time in a descending-break style
> > > 
> > > v1: https://lkml.org/lkml/2019/4/22/28
> > > 
> > >  arch/x86/kvm/cpuid.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index fd39516..f9b529e 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -425,6 +425,11 @@ static inline int __do_cpuid_ent(struct
> > > kvm_cpuid_entry2 *entry, u32 function,
> > >  
> > >  	switch (function) {
> > >  	case 0:
> > > +		/* Check if the cpuid leaf 0x1f is actually implemented */
> > > +		if (entry->eax >= 0x1f && (cpuid_ebx(0x1f) & 0x0000ffff)) {
> > 
> > Restricting the check to bits 15:0 is unnecessary, the SDM explicitly
> > states that EBX will be zero for invalid sub-leaves:
> > 
> >   For sub-leaves that return an invalid level-type of 0 in ECX[15:8];
> >   EAX and EBX will return 0.
> > 
> > This code is merely checking for the existence of CPUID.1F, nothing will
> > break if future CPUs provide additional information, i.e. checking for a
> > valid sub-leaf is sufficient.
> > 
> > That being said, if you insist on restricting the check to non-reserved
> > bits then I think the earlier suggestion of "cpuid_ecx(0x1f) & 0x0000ff00"
> > makes more sense since the SDM clearly intends ECX to be used to detect
> > valid vs. invalid levels.
> 
> Here we use CPUID.1F_0:EBX[15:0] to check the existence, not the output of
> ECX[15:8], which is following the Intel SDM.
> 
> Specifically, in page 3-222 Vol.2A of latest SDM publish on January 2019, there
> is such description of Input EAX = 1FH:
> 
>    When CPUID executes with EAX set to 1FH, the processor returns information
>    about extended topology enumeration data. Software must detect the presence
>    of CPUID leaf 1FH by verifying (a) the highest leaf index supported by CPUID
>    is >= 1FH, and (b) CPUID.1FH:EBX[15:0] reports a non-zero value.

Ah, perfect.  Please put exactly that in the changelog.

> 
> And also, I look up the existing codes about initialising topology using leaf
> 0xb in kernel. In function detect_extended_topology_early(), it use following
> 
>    if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
> 
> to verify whether leaf 0xb is invalid. I think any of them is strong enough to
> verify the leaf 0xb is invalid, so I don't know why it uses both of them.
> 
> > > +			entry->eax = 0x1f;
> > > +			break;
> > 
> > I find if/else easier to follow than the separate break, but either option
> > works for me.
> > 		
> > > +		}
> > >  		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
> > >  		break;
> > >  	case 1:
> > > @@ -544,7 +549,12 @@ static inline int __do_cpuid_ent(struct
> > > kvm_cpuid_entry2 *entry, u32 function,
> > >  		entry->edx = edx.full;
> > >  		break;
> > >  	}
> > > -	/* function 0xb has additional index. */
> > > +	/*
> > > +	 * Intel documentation states that 0x1f and 0xb have
> > > +	 * identical formats and thus can be handled by common code.
> > > +	 * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
> > > +	 */
> > 
> > It's probably safe to assume anyone reading reading this code is already
> > all too aware of Intel's propensity for dumping CPUID enumeration into the
> > CPUID entry in the ISR.  Maybe shorten this to something like:
> > 
> > 	/*
> > 	 * Per Intel's SDM, 0x1f is a superset of 0xb, thus they can be handled
> > 	 * by common code.
> > 	 */
> > 
> > > +	case 0x1f:
> > >  	case 0xb: {
> > >  		int i, level_type;
> > >  
> > > -- 
> > > 1.8.3.1
> > > 
> 
