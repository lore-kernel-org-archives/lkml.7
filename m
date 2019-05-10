Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C06C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FB3217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfEJRtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:49:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:25129 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfEJRtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:49:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 10:49:00 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2019 10:49:00 -0700
Date:   Fri, 10 May 2019 10:49:00 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     wang.yi59@zte.com.cn
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] [next] KVM: lapic: allow set apic debug dynamically
Message-ID: <20190510174900.GB16852@linux.intel.com>
References: <20190509201959.GA12810@linux.intel.com>
 <201905101254211413423@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905101254211413423@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 12:54:21PM +0800, wang.yi59@zte.com.cn wrote:
> I grep "debug" in arch/x86/kvm, and find these *_debug:
> ioapic_debug
> apic_debug
> 
> and dbg in mmu.c, which is better to be renamed to mmu_debug as you said.
> 
> and vcpu_debug, which uses kvm_debug macro.
> 
> kvm_debug macro uses pr_debug which can be dynamically set during running
> time, so, how about change all *_debug in kvm to pr_debug like vcpu_debug?

It's still the same end result, we're bloating and slowing KVM with code
and conditionals that aren't useful in normal operation.  grep vcpu_debug
a bit further and you'll see that the only uses in x86 are when the guest
has crashed, is being reset, or is accessing an unhandled MSR and KVM is
injecting a #GP in response.  In other words, the existing uses are only
in code that isn't remotely performance critical.

  hyperv.c: vcpu_debug(vcpu, "hv crash (0x%llx 0x%llx 0x%llx 0x%llx 0x%llx)\n",
  hyperv.c: vcpu_debug(vcpu, "hyper-v reset requested\n");
  x86.c:    vcpu_debug_ratelimited(vcpu, "unhandled wrmsr: 0x%x data 0x%llx\n",
  x86.c:    vcpu_debug_ratelimited(vcpu, "unhandled rdmsr: 0x%x\n",

pr_debug does have more direct uses, notably in nested VMX and KVM TSC
handling.  Similar to the above vcpu_debug case, the nVMX uses are all
failing paths and not performance critical.  The TSC code does have one
path that may affect performance (get_kvmclock_ns()->kvm_get_time_scale()),
but I don't think that should be considered as setting the precedent.  In
fact, it may make sense to convert the TSC pr_debugs to be gated by
CONFIG_DEBUG_KVM as well.

Paolo, do you have any thoughts?
