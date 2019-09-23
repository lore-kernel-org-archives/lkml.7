Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25369C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1E920665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbfIWTFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfIWTFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C7A51DBA;
        Mon, 23 Sep 2019 19:05:17 +0000 (UTC)
Received: from mail (ovpn-120-159.rdu2.redhat.com [10.10.120.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F7260852;
        Mon, 23 Sep 2019 19:05:14 +0000 (UTC)
Date:   Mon, 23 Sep 2019 15:05:14 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
Message-ID: <20190923190514.GB19996@redhat.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-16-aarcange@redhat.com>
 <87o8zb8ik1.fsf@vitty.brq.redhat.com>
 <7329012d-0b3b-ce86-f58d-3d2d5dc5a790@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7329012d-0b3b-ce86-f58d-3d2d5dc5a790@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 23 Sep 2019 19:05:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:57:57AM +0200, Paolo Bonzini wrote:
> On 23/09/19 11:31, Vitaly Kuznetsov wrote:
> > +#ifdef CONFIG_RETPOLINE
> > +		if (exit_reason == EXIT_REASON_MSR_WRITE)
> > +			return handle_wrmsr(vcpu);
> > +		else if (exit_reason == EXIT_REASON_PREEMPTION_TIMER)
> > +			return handle_preemption_timer(vcpu);
> > +		else if (exit_reason == EXIT_REASON_PENDING_INTERRUPT)
> > +			return handle_interrupt_window(vcpu);
> > +		else if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
> > +			return handle_external_interrupt(vcpu);
> > +		else if (exit_reason == EXIT_REASON_HLT)
> > +			return handle_halt(vcpu);
> > +		else if (exit_reason == EXIT_REASON_PAUSE_INSTRUCTION)
> > +			return handle_pause(vcpu);
> > +		else if (exit_reason == EXIT_REASON_MSR_READ)
> > +			return handle_rdmsr(vcpu);
> > +		else if (exit_reason == EXIT_REASON_CPUID)
> > +			return handle_cpuid(vcpu);
> > +		else if (exit_reason == EXIT_REASON_EPT_MISCONFIG)
> > +			return handle_ept_misconfig(vcpu);
> > +#endif
> >  		return kvm_vmx_exit_handlers[exit_reason](vcpu);
> 
> Most of these, while frequent, are already part of slow paths.
> 
> I would keep only EXIT_REASON_MSR_WRITE, EXIT_REASON_PREEMPTION_TIMER,
> EXIT_REASON_EPT_MISCONFIG and add EXIT_REASON_IO_INSTRUCTION.

Intuition doesn't work great when it comes to CPU speculative
execution runtime. I can however run additional benchmarks to verify
your theory that keeping around frequent retpolines will still perform
ok.

> If you make kvm_vmx_exit_handlers const, can the compiler substitute for
> instance kvm_vmx_exit_handlers[EXIT_REASON_MSR_WRITE] with handle_wrmsr?
>  Just thinking out loud, not sure if it's an improvement code-wise.

gcc gets right if you make it const, it calls kvm_emulate_wrmsr in
fact. However I don't think const will fly
with_vmx_hardware_setup()... in fact at runtime testing nested I just
got:

BUG: unable to handle page fault for address: ffffffffa00751e0
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD 2424067 P4D 2424067 PUD 2425063 PMD 7cc09067 PTE 80000000741cb161
Oops: 0003 [#1] SMP NOPTI
CPU: 1 PID: 4458 Comm: insmod Not tainted 5.3.0+ #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.or4
RIP: 0010:nested_vmx_hardware_setup+0x29a/0x37a [kvm_intel]
Code: 41 ff c5 66 89 2c 85 20 92 0b a0 66 44 89 34 85 22 92 0b a0 49 ff c7 e9 e6 fe ff ff 44 89 2d 28 24 fc ff 48
RSP: 0018:ffffc90000257c18 EFLAGS: 00010246
RAX: ffffffffa001e0b0 RBX: ffffffffa0075140 RCX: 0000000000000000
RDX: ffff888078f60000 RSI: 0000000000002401 RDI: 0000000000000018
RBP: 0000000000006c08 R08: 0000000000001000 R09: 000000000007ffdc
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000006c08
R13: 0000000000000017 R14: 0000000000000268 R15: 0000000000000018
FS:  00007f7fb7ef0b80(0000) GS:ffff88807da40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa00751e0 CR3: 0000000079620001 CR4: 0000000000160ee0
Call Trace:
 hardware_setup+0x4df/0x5b2 [kvm_intel]
 kvm_arch_hardware_setup+0x2f/0x27b [kvm_intel]
 kvm_init+0x5d/0x26d [kvm_intel]
