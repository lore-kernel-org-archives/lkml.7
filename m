Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E3C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59E220880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="yz+iCyAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfHELBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:01:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35145 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHELBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:01:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so72514043wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZ16p44zX6BsUqQEiRSnvBzZIECW5PSakjHNftFjOBk=;
        b=yz+iCyAl+dnC1lNGF63iT4hG6Snr1vZTr+21dxkBq/PP6APi3K9ouNdtZ1gyZxa4dV
         H1KiJ/jritMN7/OHeoQ5hKT/N+jrGbpfAOX+pVNrv5yecM2mBSqTArJ6sIYozs/Akket
         rmqCmNOGSuytfOnn9yuRBFGJXNloFqwFsV5ELGI2nkPxPKxRxYQxHm+KPNqgO2BCzUNk
         Xr+GepU09j8ms0i+FufpiANUi7tWiggOmd6vt0ehfCKOfTJtymOn0SoXJdlKGE2ppc12
         b7SNr/tDm1k0UEaaJDDvBCz8ALxO1ytLpVPInguGASB6+nn7i20aXC82Gegxol8ow1JA
         MBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZ16p44zX6BsUqQEiRSnvBzZIECW5PSakjHNftFjOBk=;
        b=ub05tp8kB0WwTWXUU2lAq8Fds6l2frh6NJnhjXFL2ki+wjPV0bmPaZtC1J17QMetq8
         rDo4VvaOoMsS9o/C/0z5RcKKCXg4AMIco232+BLh+dpuCCZMp9S5rW2L99i2AubRJVF8
         EA+wNtvgCUTNFgefTtRLCbKthKtOIBoyxtRUW4gkTS/rO4QvKg7B6UzN4Xm6BrnnijCb
         M3PKMUs7v1iQePYdmAKd8xjOuZsCtT+jSj/jfala6k2v6gkEaU6Ua7JrxjLhR5irxyok
         dBIhwf2eBVPhAjPCs9dbKRa2ZgX6gblb57KYIJiyW4m0bAoQ9RadA/y4cnddlEbx6rqJ
         wC0g==
X-Gm-Message-State: APjAAAXs85OFYywaQ3aaD2sUimdUm98f029BFFgZOUDqBdAmZ+yCMAbL
        ElMV0r/85LcT0GaGXg3SA3SRuJPDPp06OSwsTif4Aw==
X-Google-Smtp-Source: APXvYqz34Q/xVI4eQb/2CKtKth4SKfYxoFgUBbvnqYoT+yhEvkuS12fehfgsIK53Wqdh20YSj8xbldgiXF9f88P5xgs=
X-Received: by 2002:a1c:cfc5:: with SMTP id f188mr16866948wmg.24.1565002858876;
 Mon, 05 Aug 2019 04:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190802074620.115029-1-anup.patel@wdc.com> <20190802074620.115029-8-anup.patel@wdc.com>
 <03f60f3a-bb50-9210-8352-da16cca322b9@redhat.com> <CAAhSdy3hdWfUCUEK-idoTzgB2hKeAd3FzsHEH1DK_BTC_KGdJw@mail.gmail.com>
 <eb964565-10e1-bd44-c37c-774bf2f58049@redhat.com>
In-Reply-To: <eb964565-10e1-bd44-c37c-774bf2f58049@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 5 Aug 2019 16:30:47 +0530
Message-ID: <CAAhSdy1Voxuq=70Qkf__57MwE+DWEVayxLwu09Evnko=2kcweQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/19] RISC-V: KVM: Implement KVM_GET_ONE_REG/KVM_SET_ONE_REG
 ioctls
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 12:40 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/08/19 08:55, Anup Patel wrote:
> > On Fri, Aug 2, 2019 at 2:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 02/08/19 09:47, Anup Patel wrote:
> >>> +     if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
> >>> +             kvm_riscv_vcpu_flush_interrupts(vcpu, false);
> >>
> >> Not updating the vsip CSR here can cause an interrupt to be lost, if the
> >> next call to kvm_riscv_vcpu_flush_interrupts finds a zero mask.
> >
> > Thanks for catching this issue. I will address it in v3.
> >
> > If we think more on similar lines then we also need to handle the case
> > where Guest VCPU had pending interrupts and we suddenly stopped it
> > for Guest migration. In this case, we would eventually use SET_ONE_REG
> > ioctl on destination Host which should set vsip_shadow instead of vsip so
> > that we force update HW after resuming Guest VCPU on destination host.
>
> I think it's simpler than that.
>
> vcpu->vsip_shadow is just the current value of CSR_VSIP so that you do
> not need to update it unconditionally on every vmentry.  That is,
> kvm_vcpu_arch_load should do
>
>         csr_write(CSR_VSIP, vcpu->arch.guest_csr.vsip);
>         vcpu->vsip_shadow = vcpu->arch.guest_csr.vsip;
>
> while every other write can go through kvm_riscv_update_vsip.  But
> vsip_shadow is completely disconnected from SET_ONE_REG; SET_ONE_REG can
> just write vcpu->arch.guest_csr.vsip and clear irqs_pending_mask, the
> next entry will write CSR_VSIP and vsip_shadow if needed.
>
> In fact, instead of placing it in kvm_vcpu, vsip_shadow could be a
> percpu variable; on hardware_enable you write 0 to both vsip_shadow and
> CSR_VSIP, and then kvm_arch_vcpu_load does not have to touch CSR_VSIP at
> all (only kvm_riscv_vcpu_flush_interrupts).  I think this makes the
> purpose of vsip_shadow even clearer, so I highly suggest doing that.

Yes, having vsip_shadow as percpu variable makes sense. I will update
accordingly.

>
> >> You could add a new field vcpu->vsip_shadow that is updated every time
> >> CSR_VSIP is written (including kvm_arch_vcpu_load) with a function like
> >>
> >> void kvm_riscv_update_vsip(struct kvm_vcpu *vcpu)
> >> {
> >>         if (vcpu->vsip_shadow != vcpu->arch.guest_csr.vsip) {
> >>                 csr_write(CSR_VSIP, vcpu->arch.guest_csr.vsip);
> >>                 vcpu->vsip_shadow = vcpu->arch.guest_csr.vsip;
> >>         }
> >> }
> >>
> >> And just call this unconditionally from kvm_vcpu_ioctl_run.  The cost is
> >> just a memory load per VS-mode entry, it should hardly be measurable.
> >
> > I think we can do this at start of kvm_riscv_vcpu_flush_interrupts() as well.
>
> Did you mean at the end?  (That is, after modifying
> vcpu->arch.guest_csr.vsip based on mask and val).  With the above switch
> to percpu, the only write of CSR_VSIP and vsip_shadow should be in
> kvm_riscv_vcpu_flush_interrupts, which in turn is only called from
> kvm_vcpu_ioctl_run.

Yes, I meant at the end of kvm_riscv_vcpu_flush_interrupts() but I am
fine having separate kvm_riscv_update_vsip() function as well.

Regards,
Anup
