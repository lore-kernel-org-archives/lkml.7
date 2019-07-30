Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B55C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9639B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="QyvteSpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfG3Mvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:51:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37130 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfG3Mvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:51:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so56521320wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlyMVEJE1Dy/QWFW2G9NXycH3WhR1tYzSwV5Ut1wIIw=;
        b=QyvteSpZvYEwd3gV2EtvARV1NGAzZRk5lzI2uo4SdM8QoQ36QBtPMGTg3JDRwhcFtR
         RpXL7DNOrvr1lP7GhriG0Fa+aGdcjHMS+hpGS/kuo+pyYMKQGSE/4of7VqDGY+vov/H5
         r7TNVf6EaAi7cC0DnOnJ8wtNZBkHk4vNlcrh1ex5A3pQBSfBT+j2zbjCJPGbIMeZu/pq
         QhcWAsS+vVjtTKy53+LSoBPyGfeqqHaHvqqYScc3s0Jm+WXk5so/EBMKcqspHr9pmK1W
         vBxsbxpgKH/VGIvvIDaorODcrwTeuSmfNl9AykChCaUJi0k828CGXOd2XLSlKY4SXwCU
         Todg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlyMVEJE1Dy/QWFW2G9NXycH3WhR1tYzSwV5Ut1wIIw=;
        b=ngpjAfntDxKNUbI+9DU2RnvRA0eT9rWRbfrFB/X19jdt9d2r79zBN4/76Gybp630YA
         jkFWgCL8CxNzJIAIyZXJpvfF/jYFmGDC6XfxYoRdb+GAnGNPzk/4D7vKiIHwvf76FNFE
         1G2OXZAeu4uirpiOtR0Q5amxZpNDFnDYZuIgT5hmUFDtHqhVxbUUuaDFGAc4EeaO2mLs
         N2fN36EucSX3WPjPS8QhCo1fgAY0PF53G4jNik9ZAcNplcFn7fsu9ZR8OmQEkDkq8VjV
         xXXtOTjFBk72OOnwM3y6DuDw3kXsP8PnLte+RD4ZIktjgAgvSfRGHHAzxWUXHz/fBk25
         COqw==
X-Gm-Message-State: APjAAAVEs9xOUKvDZndk8ixXSBIqFTZn/mxeTnyKF7msqEsevxebynOr
        l1NnefLJyH1gry/wbZARxx3aWxezA+Uou0X69WI=
X-Google-Smtp-Source: APXvYqxuguKU0X+siFrvn9HOub5fk0XoQDRv8R/r/X/5oWCQQU/kraAMUh75sFlJTua5yk0lVONdEWCEt0D0+4rQl0o=
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr100750011wmg.177.1564491096568;
 Tue, 30 Jul 2019 05:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <20190729115544.17895-8-anup.patel@wdc.com>
 <cbb1b995-be2f-96a5-9890-63e1941e7f3c@redhat.com>
In-Reply-To: <cbb1b995-be2f-96a5-9890-63e1941e7f3c@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 18:21:24 +0530
Message-ID: <CAAhSdy2KbiEq35NSyKHNjrxbJOeh0U02mmf=bueDuXCEZCyXpg@mail.gmail.com>
Subject: Re: [RFC PATCH 07/16] RISC-V: KVM: Implement VCPU world-switch
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

On Tue, Jul 30, 2019 at 3:04 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/07/19 13:57, Anup Patel wrote:
> >  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> >  {
> > -     /* TODO: */
> > +     struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
> > +
> > +     csr_write(CSR_HIDELEG, csr->hideleg);
> > +     csr_write(CSR_HEDELEG, csr->hedeleg);
>
> Writing HIDELEG and HEDELEG here seems either wrong or inefficient to me.
>
> I don't remember the spec well enough, but there are two cases:
>
> 1) either they only matter while the guest runs and then you can set
> them in kvm_arch_hardware_enable.  KVM common code takes care of doing
> this on all CPUs for you.

This is a good suggestion. I will use kvm_arch_hardware_enable() for
programming HIDELEG and HEDELEG CSRs.

>
> 2) or they also matter while the host runs and then you need to set them
> in vcpu_switch.S.

They don't matter in HS-mode so we don't need to access them in
vcpu_switch.S

Regards,
Anup
