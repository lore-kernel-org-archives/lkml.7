Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464B8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227BE208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfDWRoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:44:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:61565 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfDWRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:44:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 10:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="133725056"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2019 10:44:07 -0700
Date:   Tue, 23 Apr 2019 10:44:07 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Message-ID: <20190423174407.GC10720@linux.intel.com>
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
 <20190422183553.GH1236@linux.intel.com>
 <bccc075c-68ce-6324-6f73-4d4e9a1d9683@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccc075c-68ce-6324-6f73-4d4e9a1d9683@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:23:59AM +0800, Like Xu wrote:
> On 2019/4/23 2:35, Sean Christopherson wrote:
> >>  #define F(x) bit(X86_FEATURE_##x)
> >>  int kvm_update_cpuid(struct kvm_vcpu *vcpu)
> >>@@ -426,6 +436,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
> >>  	switch (function) {
> >>  	case 0:
> >>  		entry->eax = min(entry->eax, (u32)(f_intel_pt ? 0x14 : 0xd));
> >>+		entry->eax = kvm_supported_intel_mcp() ? 0x1f : entry->eax;
> >
> >This all seems unnecessary.  And by 'all', I mean the existing Intel PT
> >and XSAVE leaf checks, as well as the new mcp check.  entry->eax comes
> >directly from hardware, and unless I missed something, PT and XSAVE are
> >only exposed to the guest when they're supported in hardware.  In other
> >words, KVM will never need to adjust entry->eax to expose PT or XSAVE.
> 
> We call this function for both case KVM_GET_SUPPORTED_CPUID and
> KVM_GET_EMULATED_CPUID although kvm user could reconfig them via
> KVM_SET_CPUID* path.

Not that it matters, but __do_cpuid_ent() is only used for the non-emulated
case, KVM_GET_EMULATED_CPUID goes to __do_cpuid_ent_emulated().
 
> >The original min() check was added by commit 0771671749b5 ("KVM: Enhance
> >guest cpuid management"), which doesn't provide any explicit information
> >on why KVM does min() in the first place.
> 
> Exposing cpuid.0.eax in a blind way (with host hardware support)
> is not a good practice for guest migration and improves compatibility
> requirements.

Right, but isn't the f_intel_pt check for example completely irrelevant?
f_intel_pt is true if and only if hardware supports PT, i.e. CPUID.0.EAX
and thus entry->eax will already be >=0x14.

I don't fully understand whether or not KVM needs to raise the minimum to
0xb regardless of h/w XSAVE support, but it's likely irrelevant in the end.

Anyways, back to 0x1f, kvm_supported_intel_mcp() returns true if and only
if hardware's CPUID.0.EAX >= 0x1f, i.e. adjusting entry->eax is always a
nop.  So if KVM wants to advertise leaf 0x1f only when it's supported in
hardware then adjusting entry->eax is unnecessary, and if KVM wants to
unconditionally advertise 0x1f then adjusting entry->eax should also be
done unconditionally.

> >Given that the original code
> >was "entry->eax = min(entry->eax, (u32)0xb);", my *guess* is that the
> >idea was to always report "Extended Topology Enumeration Leaf" as
> >supported so that userspace can enumerate the VM's topology to the guest
> >even when hardware itself doesn't do so.
> 
> If the host cpu mode is too antiquated to support 0xb, it wouldn't report
> 0xb for sure. The host cpuid.0.eax has been over 0xb for a long time and
> reached 0x1f in the latest SDM.
> 
> AFAICT, the original code keeps minimum cpuid.0.eax out of features guest
> just used or at least it claimed to use.
> 
> >
> >Assuming we want to allow userspace to use "V2 Extended Topology
> >Enumeration Leaf" regardless of hardware support, then this can simply be:
> >
> >   entry->eax = min(entry->eax, (u32)0x1f);
> >
> >Or am I completely missing something?
