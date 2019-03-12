Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7142147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCLJw2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:52:28 -0400
Received: from foss.arm.com ([217.140.101.70]:39628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfCLJw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20B1CA78;
        Tue, 12 Mar 2019 02:52:27 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98C883F59C;
        Tue, 12 Mar 2019 02:52:25 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:52:22 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Gong John <johngong0791@gmail.com>
Cc:     christoffer.dall@arm.com, Shengmin Gong <shengmin.gong@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Jia He <hejianet@gmail.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: fix potential bug
Message-ID: <20190312095222.45227d05@donnerap.cambridge.arm.com>
In-Reply-To: <CAEg8mkxRj2jQSqnuqY239yDH3a4mkvabg+_6Q8+9Nd=mk+U2pw@mail.gmail.com>
References: <20190312003243.6712-1-johngong0791@gmail.com>
        <2405014d-9370-c0d5-7a44-7ec336098c45@arm.com>
        <CAEg8mkxRj2jQSqnuqY239yDH3a4mkvabg+_6Q8+9Nd=mk+U2pw@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 11:15:14 +0800
Gong John <johngong0791@gmail.com> wrote:

Hi,

> On Tue, Mar 12, 2019 at 9:44 AM André Przywara <andre.przywara@arm.com> wrote:
> >
> > On 12/03/2019 00:32, John Gong wrote:
> > Hi,
> >  
> > > Since intid always >= VGIC_NR_PRIVATE_IRQS,  
> >
> > How so? The PMU and the arch timer emulation use PPIs, so intid is
> > definitely < VGIC_NR_PRIVATE_IRQS there.
> >  
> > > so then even vcpu == NULL, it never return -EINVAL.  
> >
> > I am not sure I follow.
> > To uniquely identify an SPI interrupt, we just need the interrupt ID
> > (which is always >= 32). For PPIs and SGIs, we additionally need the
> > vCPU ID this private interrupt belongs to, as there are multiple
> > interrupts with the same INTID (one per VCPU).
> > The VCPU ID passed in for SPIs is just a dummy value (because we use the
> > same function to inject private and shared interrupts), so we don't need
> > to check for its validity.
> >
> > Cheers,
> > Andre.
> >  
> Thanks for your explanation. It's my fault to not consider the PPIs
> and SGIs injection.

Don't worry, we are glad when people actually look at the code. And we rather have a false positive report than a bug slipping through.

Cheers,
Andre.
 
> Sorry for polluting the mail list.
> 
> Cheers,
> John Gong
> > >
> > > Signed-off-by: Shengmin Gong <shengmin.gong@gmail.com>
> > > Signed-off-by: John Gong <johngong0791@gmail.com>
> > > ---
> > >  virt/kvm/arm/vgic/vgic.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > > index abd9c7352677..d3cb1ce880e2 100644
> > > --- a/virt/kvm/arm/vgic/vgic.c
> > > +++ b/virt/kvm/arm/vgic/vgic.c
> > > @@ -424,7 +424,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
> > >               return ret;
> > >
> > >       vcpu = kvm_get_vcpu(kvm, cpuid);
> > > -     if (!vcpu && intid < VGIC_NR_PRIVATE_IRQS)
> > > +     if (!vcpu)
> > >               return -EINVAL;
> > >
> > >       irq = vgic_get_irq(kvm, vcpu, intid);
> > >  
> >  

