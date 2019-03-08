Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FCD20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCHB4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:56:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:27470 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfCHB4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:56:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 17:56:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,454,1544515200"; 
   d="scan'208";a="129808401"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by fmsmga008.fm.intel.com with ESMTP; 07 Mar 2019 17:56:29 -0800
Message-ID: <1622bef446a79151c78960f61674495b0857b716.camel@linux.intel.com>
Subject: Re: [PATCH] kvm/x86/vmx: Make the emulation of
 MSR_IA32_ARCH_CAPABILITIES only for vmx
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Mar 2019 09:53:14 +0800
In-Reply-To: <55caabc3-e075-3282-a000-88356ddb15c2@redhat.com>
References: <20190307093143.77182-1-xiaoyao.li@linux.intel.com>
         <20190307173744.GB4986@linux.intel.com>
         <55caabc3-e075-3282-a000-88356ddb15c2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 19:15 +0100, Paolo Bonzini wrote:
> On 07/03/19 18:37, Sean Christopherson wrote:
> > On Thu, Mar 07, 2019 at 05:31:43PM +0800, Xiaoyao Li wrote:
> > > At present, we report F(ARCH_CAPABILITIES) for x86 arch(both vmx and svm)
> > > unconditionally, but we only emulate this MSR in vmx. It will cause #GP
> > > while guest kernel rdmsr(MSR_IA32_ARCH_CAPABILITIES) in an AMD host.
> > > 
> > > Since MSR IA32_ARCH_CAPABILITIES is an intel-specific MSR, it makes no
> > > sense to emulate it in svm. Thus this patch chooses to only emulate it
> > > for vmx, and moves the related handling to vmx related files.
> > 
> > What about emulating the MSR on an AMD host for testing purpsoes?  It
> > might be a useful way for someone without Intel hardware to test spectre
> > related flows.
> > 
> > In other words, an alternative to restricting emulation of the MSR to
> > Intel CPUS would be to move MSR_IA32_ARCH_CAPABILITIES handling into
> > kvm_{get,set}_msr_common().  Guest access to MSR_IA32_ARCH_CAPABILITIES
> > is gated by X86_FEATURE_ARCH_CAPABILITIES in the guest's CPUID, e.g.
> > RDMSR will naturally #GP fault if userspace passes through the host's
> > CPUID on a non-Intel system.
> 
> This is also better because it wouldn't change the guest ABI for AMD
> processors.  Dropping CPUID flags is generally not a good idea.
> 
> Paolo

Hi, Paolo and Sean,

OK, as you think it's better to emulate MSR ARCH_CAPABILITIES on all x86 host,
so should I make the same to MSR CORE_CAPABILITY?

If so, I will make it for our v5 patches of split lock detection to emualte MSR
CORE_CAPABILITY in this way.

Thanks,
Xiaoyao


