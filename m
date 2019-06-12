Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB304C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7C9215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408748AbfFLPWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfFLPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:22:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50B5C11549;
        Wed, 12 Jun 2019 15:22:35 +0000 (UTC)
Received: from flask (unknown [10.40.205.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32E4A377B;
        Wed, 12 Jun 2019 15:22:31 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 12 Jun 2019 17:22:31 +0200
Date:   Wed, 12 Jun 2019 17:22:31 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/4] KVM: LAPIC: lapic timer interrupt is injected by
 posted interrupt
Message-ID: <20190612152231.GA22785@flask>
References: <1560255429-7105-1-git-send-email-wanpengli@tencent.com>
 <1560255429-7105-3-git-send-email-wanpengli@tencent.com>
 <20190611201849.GA7520@amt.cnet>
 <CANRm+CwrbMQpQ1d_KMp-EBMd-pXFVePQ8GV4Y4X0oy8-zGZCBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CwrbMQpQ1d_KMp-EBMd-pXFVePQ8GV4Y4X0oy8-zGZCBQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 15:22:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-06-12 09:48+0800, Wanpeng Li:
> On Wed, 12 Jun 2019 at 04:39, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > On Tue, Jun 11, 2019 at 08:17:07PM +0800, Wanpeng Li wrote:
> > > From: Wanpeng Li <wanpengli@tencent.com>
> > > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > > @@ -133,6 +133,12 @@ inline bool posted_interrupt_inject_timer_enabled(struct kvm_vcpu *vcpu)
> > >  }
> > >  EXPORT_SYMBOL_GPL(posted_interrupt_inject_timer_enabled);
> > >
> > > +static inline bool can_posted_interrupt_inject_timer(struct kvm_vcpu *vcpu)
> > > +{
> > > +     return posted_interrupt_inject_timer_enabled(vcpu) &&
> > > +             kvm_hlt_in_guest(vcpu->kvm);
> > > +}
> >
> > Hi Li,
> 
> Hi Marcelo,
> 
> >
> > Don't think its necessary to depend on kvm_hlt_in_guest: Can also use
> > exitless injection if the guest is running (think DPDK style workloads
> > that busy-spin on network card).

I agree.

> There are some discussions here.
> 
> https://lkml.org/lkml/2019/6/11/424
> https://lkml.org/lkml/2019/6/5/436

Paolo wants to disable the APF synthetic halt first, which I think is
unrelated to the timer implementation.
The synthetic halt happens when the VCPU cannot progress because the
host swapped out its memory and any asynchronous event should unhalt it,
because we assume that the interrupt path wasn't swapped out.

The posted interrupt does a swake_up_one (part of vcpu kick), which is
everything what the non-posted path does after setting a KVM request --
it's a bug if we later handle the PIR differently from the KVM request,
so the guest is going to be woken up on any halt blocking in KVM (even
synthetic APF halt).

Paolo, have I missed the point?

Thanks.
