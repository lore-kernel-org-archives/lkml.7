Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2182EECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C5E20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfJODSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:18:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:38579 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfJODSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:18:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 20:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,297,1566889200"; 
   d="scan'208";a="225283908"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2019 20:18:29 -0700
Date:   Mon, 14 Oct 2019 20:18:28 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 01/14] KVM: monolithic: x86: remove kvm.ko
Message-ID: <20191015031828.GE24895@linux.intel.com>
References: <20190928172323.14663-1-aarcange@redhat.com>
 <20190928172323.14663-2-aarcange@redhat.com>
 <20191015013144.GC24895@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015013144.GC24895@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 06:31:44PM -0700, Sean Christopherson wrote:
> On Sat, Sep 28, 2019 at 01:23:10PM -0400, Andrea Arcangeli wrote:
> > This is the first commit of a patch series that aims to replace the
> > modular kvm.ko kernel module with a monolithic kvm-intel/kvm-amd
> > model. This change has the only possible cons of wasting some disk
> > space in /lib/modules/. The pros are that it saves CPUS and some minor
> > RAM which are more scarse resources than disk space.
> > 
> > The pointer to function virtual template model cannot provide any
> > runtime benefit because kvm-intel and kvm-amd can't be loaded at the
> > same time.
> > 
> > This removes kvm.ko and it links and duplicates all kvm.ko objects to
> > both kvm-amd and kvm-intel.
> 
> The KVM config option should be changed to a bool and its help text
> updated.  Maybe something similar to the help for VIRTUALIZATION to make
> it clear that enabling KVM on its own does nothing.

Making KVM a bool doesn't work well, keeping it a tristate and keying off
KVM=y to force Intel or AMD (as done in the next patch) looks like the
cleanest implementation.

The help text should still be updated though.

> > 
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > ---
> >  arch/x86/kvm/Makefile | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> > index 31ecf7a76d5a..68b81f381369 100644
> > --- a/arch/x86/kvm/Makefile
> > +++ b/arch/x86/kvm/Makefile
> > @@ -12,9 +12,8 @@ kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
> >  			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
> >  			   hyperv.o page_track.o debugfs.o
> >  
> > -kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o vmx/evmcs.o vmx/nested.o
> > -kvm-amd-y		+= svm.o pmu_amd.o
> > +kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o vmx/evmcs.o vmx/nested.o $(kvm-y)
> > +kvm-amd-y		+= svm.o pmu_amd.o $(kvm-y)
> >  
> > -obj-$(CONFIG_KVM)	+= kvm.o
> >  obj-$(CONFIG_KVM_INTEL)	+= kvm-intel.o
> >  obj-$(CONFIG_KVM_AMD)	+= kvm-amd.o
