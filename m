Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977BFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B19217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDYEWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 00:22:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:18333 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfDYEWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 00:22:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 21:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="145650632"
Received: from lxy-dell.sh.intel.com ([10.239.159.145])
  by fmsmga007.fm.intel.com with ESMTP; 24 Apr 2019 21:22:06 -0700
Message-ID: <c5d7dd8a51c606f38314ef4c7bb0702caeecbe7e.camel@intel.com>
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Like Xu <like.xu@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 25 Apr 2019 12:18:50 +0800
In-Reply-To: <bcc3a8ea-1fd0-124c-c472-7c096e0f8014@linux.intel.com>
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
         <20190424143238.GB18442@linux.intel.com>
         <bcc3a8ea-1fd0-124c-c472-7c096e0f8014@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-25 at 10:58 +0800, Like Xu wrote:
> On 2019/4/24 22:32, Sean Christopherson wrote:
> > Now that I understand how min() works...
> > 
> > On Mon, Apr 22, 2019 at 02:40:34PM +0800, Like Xu wrote:
> > > Expose Intel V2 Extended Topology Enumeration Leaf to guest only when
> > > host system has multiple software-visible die within each package.
> > > 
> > > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> > > ---
> > >   arch/x86/kvm/cpuid.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index fd39516..9fc14f2 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -65,6 +65,16 @@ u64 kvm_supported_xcr0(void)
> > >   	return xcr0;
> > >   }
> > >   
> > > +/* We need to check if the host cpu has multi-chip packaging technology.
> > > */
> > > +static bool kvm_supported_intel_mcp(void)
> > > +{
> > > +	u32 eax, ignored;
> > > +
> > > +	cpuid_count(0x1f, 0, &eax, &ignored, &ignored, &ignored);
> > 
> > This is broken because of how CPUID works for unsupported input leafs:
> > 
> >    If a value entered for CPUID.EAX is higher than the maximum input value
> >    for basic or extended function for that processor then the data for the
> >    highest basic information leaf is returned.
> > 
> > For example, my system with a max basic leaf of 0x16 returns 0x00000e74
> > for CPUID.1F.EAX.
> 
> You're right and the cpuid.1f.eax check is unreliable after I checked a 
> few machines.
> 
> > 
> > > +
> > > +	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && (eax != 0);
> > 
> > Checking 'eax != 0' is broken as it will be '0' when SMT is disabled.  ecx
> > is the obvious choice since bits 15:8 are guaranteed to be non-zero when
> > the leaf is valid.
> 
> I agree with this and ecx[15:8] makes sense.
> 
> > 
> > I think we can skip the vendor check.  AFAIK, CPUID.1F isn't used by AMD,
> > and since AMD and Intel try to maintain a semblance of CPUID compatibility
> > it seems more likely that AMD/Hygon would implement CPUID.1F as-is rather
> > than repurpose it to mean something else entirely.
> 
> If it's true, let's skip the vendor check.
> 
> // I have to mention that AMD already has MCP CPUs.
> 
> > 
> > > +}
> > > +
> > >   #define F(x) bit(X86_FEATURE_##x)
> > >   
> > >   int kvm_update_cpuid(struct kvm_vcpu *vcpu)
> > > @@ -426,6 +436,7 @@ static inline int __do_cpuid_ent(struct
> > > kvm_cpuid_entry2 *entry, u32 function,
> > >   	switch (function) {
> > >   	case 0:
> > >   		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 :
> > > 0xd));
> > > +		entry->eax = kvm_supported_intel_mcp() ? 0x1f : entry->eax;
> > 
> > If we put everything together, I think the code can be reduced to:
> > 
> > 		/* comment about multi-chip leaf... */
> > 		if (entry->eax >= 0x1f && cpuid_ecx(0x1f))
> > 			entry->eax = 0x1f;
> > 		else
> > 			entry->eax = min(entry->eax,
> > 					 (u32)(f_intel_pt ? 0x14 : 0xd));
> 
> Based on:
> 
> 	ECX Bits 07 - 00: Level number. Same value in ECX input.
> 	Bits 15 - 08: Level type.
> 	Bits 31 - 16: Reserved.
> 
> how about using an increasing order:
> 
> 	entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
> 
> 	// ... more checks when eax is between 0x14 and 0x1f if any
> 
> 	/* Check if the host cpu has multi-chip packaging technology.*/
> 	if (((cpuid_ecx(0x1f) >> 8) & 0xff) != 0)
> 		entry->eax = 0x1f;

As Sean pointed out, you cannot rely on the output of cpuid.1f to indicate the
existence of leaf 1f. If maximum basic leaf supported is smaller than 1f, the
data returned by cpuid_ecx(0x1f) is the actual highest basic information leaf of
the hardware.
So using "entry->eax >= 0x1f" from cpuid.0H is and only is the right way to
check the existence of leaf 1f.

We can simply use (cpuid_ecx(0x1f) & 0x0000ff00) to avoid the unnecessory
shifting operation.
Besides, the problem of simply using cpuid_exc(0x1f) in Sean's codes is that we
cannot assmue the reserved bits 31:16 of ECX is always 0 for the future
generation.

In my opinion, Sean's codes is OK and much simple and clear.
All need to do is using (cpuid_ecx(0x1f) & 0x0000ff00) to verify the leaf.1f is
valid.

Thanks,
-Xiaoyao
> 	// ... more checks when eax greater than 0x1f if any
> 
> are we OK with it?
> 
> > >   		break;
> > >   	case 1:
> > >   		entry->edx &= kvm_cpuid_1_edx_x86_features;
> > > @@ -544,6 +555,8 @@ static inline int __do_cpuid_ent(struct
> > > kvm_cpuid_entry2 *entry, u32 function,
> > >   		entry->edx = edx.full;
> > >   		break;
> > >   	}
> > > +	/* function 0x1f has additional index. */
> > > +	case 0x1f:
> > >   	/* function 0xb has additional index. */
> > >   	case 0xb: {
> > >   		int i, level_type;
> > > -- 
> > > 1.8.3.1
> > > 
> 
> 

