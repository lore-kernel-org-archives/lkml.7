Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94EC20674
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfH0Tta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:49:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:27796 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfH0Tta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:49:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 12:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="197377356"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2019 12:49:29 -0700
Date:   Tue, 27 Aug 2019 12:49:28 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] KVM: x86: Don't update RIP or do single-step on faulting
 emulation
Message-ID: <20190827194928.GH27459@linux.intel.com>
References: <20190823205544.24052-1-sean.j.christopherson@intel.com>
 <CALMp9eSwxTdigRkACRgr=avg8HZh+gPXgPnwd7+CaNEEuS2tQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eSwxTdigRkACRgr=avg8HZh+gPXgPnwd7+CaNEEuS2tQA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 12:12:51PM -0700, Jim Mattson wrote:
> On Fri, Aug 23, 2019 at 1:55 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -6611,12 +6611,13 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
> >                 unsigned long rflags = kvm_x86_ops->get_rflags(vcpu);
> >                 toggle_interruptibility(vcpu, ctxt->interruptibility);
> >                 vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
> > -               kvm_rip_write(vcpu, ctxt->eip);
> > -               if (r == EMULATE_DONE && ctxt->tf)
> > -                       kvm_vcpu_do_singlestep(vcpu, &r);
> >                 if (!ctxt->have_exception ||
> > -                   exception_type(ctxt->exception.vector) == EXCPT_TRAP)
> > +                   exception_type(ctxt->exception.vector) == EXCPT_TRAP) {
> 
> NYC, but...
> 
> I don't think this check for "exception_type" is quite right.  A
> general detect fault (which can be synthesized by check_dr_read) is
> mischaracterized by exception_type() as a trap. Or maybe I'm missing
> something? (I often am.)

Pretty sure you're not missing anything.

And while we're poking holes in #DB emulation, int1/icebp isn't emulated
correctly as it should be reinjected with INTR_TYPE_PRIV_SW_EXCEPTION, not
as a INTR_TYPE_HARD_EXCEPTION.  The CPU automically clears DR7.GD on #DB,
unless the #DB is due to int1...
