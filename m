Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F166C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46625218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfDXNxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:53:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:61928 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfDXNxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:53:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 06:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="294158042"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2019 06:53:16 -0700
Date:   Wed, 24 Apr 2019 06:53:16 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Add Intel CPUID.1F cpuid emulation support
Message-ID: <20190424135316.GA18442@linux.intel.com>
References: <1555915234-2536-1-git-send-email-like.xu@linux.intel.com>
 <20190422183553.GH1236@linux.intel.com>
 <bccc075c-68ce-6324-6f73-4d4e9a1d9683@linux.intel.com>
 <20190423174407.GC10720@linux.intel.com>
 <37c014d8-7562-92e6-d577-ddbe3565ea8e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c014d8-7562-92e6-d577-ddbe3565ea8e@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:59:50AM +0800, Like Xu wrote:
> On 2019/4/24 1:44, Sean Christopherson wrote:
> >Right, but isn't the f_intel_pt check for example completely irrelevant?
> >f_intel_pt is true if and only if hardware supports PT, i.e. CPUID.0.EAX
> >and thus entry->eax will already be >=0x14.
> 
> The f_intel_pt check is not only about hardware supports check but also
> module_param (pt_mode) supports check.
> 
> So the case is the host does have PT support which means (host CPUID.0.EAX
> already be >=0x14 for Intel CPUs) but kvm doesn't want advertise it and thus
> the min() operation is needed.
> 
> >
> >I don't fully understand whether or not KVM needs to raise the minimum to
> >0xb regardless of h/w XSAVE support, but it's likely irrelevant in the end.
> >
> >Anyways, back to 0x1f, kvm_supported_intel_mcp() returns true if and only
> >if hardware's CPUID.0.EAX >= 0x1f,
> 
> According to latest SDM, the max hardware CPUID.0.EAX is 0x1f and BIOS would
> expose 0x1f only for multi-chip packaging CPUs (at least for now).
> 
> >i.e. adjusting entry->eax is always a
> >nop.  So if KVM wants to advertise leaf 0x1f only when it's supported in
> >hardware then adjusting entry->eax is unnecessary, and if KVM wants to
> >unconditionally advertise 0x1f then adjusting entry->eax should also be
> >done unconditionally.
> 
> It we have no check on kvm_supported_intel_mcp() in legacy code,
> CPUID.0.EAX would be min() and thus less than 0x1f which means the cpuid.1f
> info is not exposed.

Ah crud, I'm an idiot.  I just spent two days conflating min() and max().
So yeah, everything makes total sense now.  My apologies for wasting your
time, I'll re-review the patch. 

> 
> I know your point is to avoid min() totally (I thought so at the time) and I
> have pointed out it's necessary for kvm features setting.
> 
> If KVM wants to unconditionally advertise 0x1f (in EMULATED way),
> kvm needs cover other side effects and this patch only advertises 0x1f
> when hardware has it.
> 
> It's very common that guest wants to set 0x1f regardless of h/w support
> and this is another story.
> 
> >
> >>>Given that the original code
> >>>was "entry->eax = min(entry->eax, (u32)0xb);", my *guess* is that the
> >>>idea was to always report "Extended Topology Enumeration Leaf" as
> >>>supported so that userspace can enumerate the VM's topology to the guest
> >>>even when hardware itself doesn't do so.
> >>
> >>If the host cpu mode is too antiquated to support 0xb, it wouldn't report
> >>0xb for sure. The host cpuid.0.eax has been over 0xb for a long time and
> >>reached 0x1f in the latest SDM.
> >>
> >>AFAICT, the original code keeps minimum cpuid.0.eax out of features guest
> >>just used or at least it claimed to use.
> >>
> >>>
> >>>Assuming we want to allow userspace to use "V2 Extended Topology
> >>>Enumeration Leaf" regardless of hardware support, then this can simply be:
> >>>
> >>>   entry->eax = min(entry->eax, (u32)0x1f);
> >>>
> >>>Or am I completely missing something?
> >
> 
