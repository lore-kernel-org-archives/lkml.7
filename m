Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4158DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E672133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ogVzvixb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfJIE6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 00:58:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51656 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfJIE6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 00:58:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so788678wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 21:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Th+89a5V8k+uKydsUbUW6spU9f1K+uJVHbWR12xq0U=;
        b=ogVzvixbP+uJxJej5W5+DjT4uNHQ/WOSKO6djitiFeatVfHpjeRJOfCr7eAGKGZLih
         f1ZdfUfrSQ1c756p6jtcplyJHvxxEgHFS2tdRFsLXt4G3jtWMIqYA0cUfNczPLWloYTe
         IP3mjojpp33DwQYBxRsOPicILJ42abyhaVPWyd1bArsRie+/mUJq9h/zg6PKml4rQVEd
         Yz27x153PzyOsLC0DvlKh4AJUKYfs2Nt1Xs4MWGkGJIzglF8dUkW23sxA8JVfwIL8vqH
         KUD+WZ5WXHPRvcM55FqU5yTVGB5w704q1swulrnc5/z6xEvws7fKe+s3ISr1kZ9A3HnR
         FAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Th+89a5V8k+uKydsUbUW6spU9f1K+uJVHbWR12xq0U=;
        b=EdvLTcJZgtP81cXZk5Fa+3f6GevTYEnKEkrovXGuwkioVjxhye49xhURkEuo76t36t
         anpgj7ISK0ertmSUoxm5lHwbtjEyCvFdQ94cWYXoFxlcQMWnfVMQRQJb1Tn8scFTgh5H
         r7t2X3vLcqWnR2xWjQ/TgKpipFUNajVcDN2/kyI3OfCrZyGScFgAoU9BylxuHwMiFjFq
         TmXNV0cv2KSTtKMukVo02pQzhbbo4Q3P9gS53P1DTmeDmPq5M6WWFKWHujNGxqo2Tci7
         Asf+bYv/8zf9VYlwhPooAiWFXR1XdL9TfMGwF1QR7dOxIQX9V2lQJTg/3ZHzYukv8I8L
         VDtg==
X-Gm-Message-State: APjAAAUwHyITcByqXUhWSX85r3qcIkswec9Xy0qogVbK15sCWyJ7f6dJ
        4evKZvHj4DM2ZxakIcUEPTyUI6J8CUXn3IGc1Ohr9w==
X-Google-Smtp-Source: APXvYqy5u6kq+4SJdMVdXnURdzYZT62+C9HNe8iqMeSCC4izfqlpzEOSHo7J+ufOxKrh7drq+MegcTV2iXdufEbb01c=
X-Received: by 2002:a7b:c775:: with SMTP id x21mr1012389wmk.52.1570597119427;
 Tue, 08 Oct 2019 21:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <8c44ac8a-3fdc-b9dd-1815-06e86cb73047@redhat.com> <mhng-610a5897-96ce-44fc-aa0f-82653808dd86@palmer-si-x1e>
In-Reply-To: <mhng-610a5897-96ce-44fc-aa0f-82653808dd86@palmer-si-x1e>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 9 Oct 2019 10:28:28 +0530
Message-ID: <CAAhSdy3=Y7YjXJN5qJUQhpy2ZBaBSEJx7twafrVASi+5jBt33w@mail.gmail.com>
Subject: Re: [PATCH v7 10/21] RISC-V: KVM: Handle MMIO exits for VCPU
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        KVM General <kvm@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 4:14 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 23 Sep 2019 04:12:17 PDT (-0700), pbonzini@redhat.com wrote:
> > On 04/09/19 18:15, Anup Patel wrote:
> >> +    unsigned long guest_sstatus =
> >> +                    vcpu->arch.guest_context.sstatus | SR_MXR;
> >> +    unsigned long guest_hstatus =
> >> +                    vcpu->arch.guest_context.hstatus | HSTATUS_SPRV;
> >> +    unsigned long guest_vsstatus, old_stvec, tmp;
> >> +
> >> +    guest_sstatus = csr_swap(CSR_SSTATUS, guest_sstatus);
> >> +    old_stvec = csr_swap(CSR_STVEC, (ulong)&__kvm_riscv_unpriv_trap);
> >> +
> >> +    if (read_insn) {
> >> +            guest_vsstatus = csr_read_set(CSR_VSSTATUS, SR_MXR);
> >
> > Is this needed?  IIUC SSTATUS.MXR encompasses a wider set of permissions:
> >
> >   The HS-level MXR bit makes any executable page readable.  {\tt
> >   vsstatus}.MXR makes readable those pages marked executable at the VS
> >   translation level, but only if readable at the guest-physical
> >   translation level.
> >
> > So it should be enough to set SSTATUS.MXR=1 I think.  But you also
> > shouldn't set SSTATUS.MXR=1 in the !read_insn case.
> >
> > Also, you can drop the irq save/restore (which is already a save/restore
> > of SSTATUS) since you already write 0 to SSTATUS.SIE in your csr_swap.
> > Perhaps add a BUG_ON(guest_sstatus & SR_SIE) before the csr_swap?
> >
> >> +            asm volatile ("\n"
> >> +                    "csrrw %[hstatus], " STR(CSR_HSTATUS) ", %[hstatus]\n"
> >> +                    "li %[tilen], 4\n"
> >> +                    "li %[tscause], 0\n"
> >> +                    "lhu %[val], (%[addr])\n"
> >> +                    "andi %[tmp], %[val], 3\n"
> >> +                    "addi %[tmp], %[tmp], -3\n"
> >> +                    "bne %[tmp], zero, 2f\n"
> >> +                    "lhu %[tmp], 2(%[addr])\n"
> >> +                    "sll %[tmp], %[tmp], 16\n"
> >> +                    "add %[val], %[val], %[tmp]\n"
> >> +                    "2: csrw " STR(CSR_HSTATUS) ", %[hstatus]"
> >> +            : [hstatus] "+&r"(guest_hstatus), [val] "=&r" (val),
> >> +              [tmp] "=&r" (tmp), [tilen] "+&r" (tilen),
> >> +              [tscause] "+&r" (tscause)
> >> +            : [addr] "r" (addr));
> >> +            csr_write(CSR_VSSTATUS, guest_vsstatus);
> >
> >>
> >> +#ifndef CONFIG_RISCV_ISA_C
> >> +                    "li %[tilen], 4\n"
> >> +#else
> >> +                    "li %[tilen], 2\n"
> >> +#endif
> >
> > Can you use an assembler directive to force using a non-compressed
> > format for ld and lw?  This would get rid of tilen, which is costing 6
> > bytes (if I did the RVC math right) in order to save two. :)
> >
> > Paolo
> >
> >> +                    "li %[tscause], 0\n"
> >> +#ifdef CONFIG_64BIT
> >> +                    "ld %[val], (%[addr])\n"
> >> +#else
> >> +                    "lw %[val], (%[addr])\n"
> >> +#endif
> To:          anup@brainfault.org
> CC:          pbonzini@redhat.com
> CC:          Anup Patel <Anup.Patel@wdc.com>
> CC:          Paul Walmsley <paul.walmsley@sifive.com>
> CC:          rkrcmar@redhat.com
> CC:          daniel.lezcano@linaro.org
> CC:          tglx@linutronix.de
> CC:          graf@amazon.com
> CC:          Atish Patra <Atish.Patra@wdc.com>
> CC:          Alistair Francis <Alistair.Francis@wdc.com>
> CC:          Damien Le Moal <Damien.LeMoal@wdc.com>
> CC:          Christoph Hellwig <hch@infradead.org>
> CC:          kvm@vger.kernel.org
> CC:          linux-riscv@lists.infradead.org
> CC:          linux-kernel@vger.kernel.org
> Subject:     Re: [PATCH v7 10/21] RISC-V: KVM: Handle MMIO exits for VCPU
> In-Reply-To: <CAAhSdy1-1yxMnjzppmUBxtSOAuwWaPtNZwW+QH1O7LAnEVP8pg@mail.gmail.com>
>
> On Mon, 23 Sep 2019 06:09:43 PDT (-0700), anup@brainfault.org wrote:
> > On Mon, Sep 23, 2019 at 4:42 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 04/09/19 18:15, Anup Patel wrote:
> >> > +     unsigned long guest_sstatus =
> >> > +                     vcpu->arch.guest_context.sstatus | SR_MXR;
> >> > +     unsigned long guest_hstatus =
> >> > +                     vcpu->arch.guest_context.hstatus | HSTATUS_SPRV;
> >> > +     unsigned long guest_vsstatus, old_stvec, tmp;
> >> > +
> >> > +     guest_sstatus = csr_swap(CSR_SSTATUS, guest_sstatus);
> >> > +     old_stvec = csr_swap(CSR_STVEC, (ulong)&__kvm_riscv_unpriv_trap);
> >> > +
> >> > +     if (read_insn) {
> >> > +             guest_vsstatus = csr_read_set(CSR_VSSTATUS, SR_MXR);
> >>
> >> Is this needed?  IIUC SSTATUS.MXR encompasses a wider set of permissions:
> >>
> >>   The HS-level MXR bit makes any executable page readable.  {\tt
> >>   vsstatus}.MXR makes readable those pages marked executable at the VS
> >>   translation level, but only if readable at the guest-physical
> >>   translation level.
> >>
> >> So it should be enough to set SSTATUS.MXR=1 I think.  But you also
> >> shouldn't set SSTATUS.MXR=1 in the !read_insn case.
> >
> > I was being overly cautious here. Initially, I thought SSTATUS.MXR
> > applies only to Stage2 and VSSTATUS.MXR applies only to Stage1.
> >
> > I agree with you. The HS-mode should only need to set SSTATUS.MXR.
> >
> >>
> >> Also, you can drop the irq save/restore (which is already a save/restore
> >> of SSTATUS) since you already write 0 to SSTATUS.SIE in your csr_swap.
> >> Perhaps add a BUG_ON(guest_sstatus & SR_SIE) before the csr_swap?
> >
> > I had already dropped irq save/restore in v7 series and having BUG_ON()
> > on guest_sstatus here would be better.
> >
> >>
> >> > +             asm volatile ("\n"
> >> > +                     "csrrw %[hstatus], " STR(CSR_HSTATUS) ", %[hstatus]\n"
> >> > +                     "li %[tilen], 4\n"
> >> > +                     "li %[tscause], 0\n"
> >> > +                     "lhu %[val], (%[addr])\n"
> >> > +                     "andi %[tmp], %[val], 3\n"
> >> > +                     "addi %[tmp], %[tmp], -3\n"
> >> > +                     "bne %[tmp], zero, 2f\n"
> >> > +                     "lhu %[tmp], 2(%[addr])\n"
> >> > +                     "sll %[tmp], %[tmp], 16\n"
> >> > +                     "add %[val], %[val], %[tmp]\n"
> >> > +                     "2: csrw " STR(CSR_HSTATUS) ", %[hstatus]"
> >> > +             : [hstatus] "+&r"(guest_hstatus), [val] "=&r" (val),
> >> > +               [tmp] "=&r" (tmp), [tilen] "+&r" (tilen),
> >> > +               [tscause] "+&r" (tscause)
> >> > +             : [addr] "r" (addr));
> >> > +             csr_write(CSR_VSSTATUS, guest_vsstatus);
> >>
> >> >
> >> > +#ifndef CONFIG_RISCV_ISA_C
> >> > +                     "li %[tilen], 4\n"
> >> > +#else
> >> > +                     "li %[tilen], 2\n"
> >> > +#endif
> >>
> >> Can you use an assembler directive to force using a non-compressed
> >> format for ld and lw?  This would get rid of tilen, which is costing 6
> >> bytes (if I did the RVC math right) in order to save two. :)
> >
> > I tried looking for it but could not find any assembler directive
> > to selectively turn-off instruction compression.
> >
> >>
> >> Paolo
> >>
> >> > +                     "li %[tscause], 0\n"
> >> > +#ifdef CONFIG_64BIT
> >> > +                     "ld %[val], (%[addr])\n"
> >> > +#else
> >> > +                     "lw %[val], (%[addr])\n"
> >> > +#endif
> >
> > Regards,
> > Anup
> To:          pbonzini@redhat.com
> CC:          anup@brainfault.org
> CC:          Anup Patel <Anup.Patel@wdc.com>
> CC:          Paul Walmsley <paul.walmsley@sifive.com>
> CC:          rkrcmar@redhat.com
> CC:          daniel.lezcano@linaro.org
> CC:          tglx@linutronix.de
> CC:          graf@amazon.com
> CC:          Atish Patra <Atish.Patra@wdc.com>
> CC:          Alistair Francis <Alistair.Francis@wdc.com>
> CC:          Damien Le Moal <Damien.LeMoal@wdc.com>
> CC:          Christoph Hellwig <hch@infradead.org>
> CC:          kvm@vger.kernel.org
> CC:          linux-riscv@lists.infradead.org
> CC:          linux-kernel@vger.kernel.org
> Subject:     Re: [PATCH v7 10/21] RISC-V: KVM: Handle MMIO exits for VCPU
> In-Reply-To: <45fc3ee5-0f68-4e94-cfb3-0727ca52628f@redhat.com>
>
> On Mon, 23 Sep 2019 06:33:14 PDT (-0700), pbonzini@redhat.com wrote:
> > On 23/09/19 15:09, Anup Patel wrote:
> >>>> +#ifndef CONFIG_RISCV_ISA_C
> >>>> +                     "li %[tilen], 4\n"
> >>>> +#else
> >>>> +                     "li %[tilen], 2\n"
> >>>> +#endif
> >>>
> >>> Can you use an assembler directive to force using a non-compressed
> >>> format for ld and lw?  This would get rid of tilen, which is costing 6
> >>> bytes (if I did the RVC math right) in order to save two. :)
> >>
> >> I tried looking for it but could not find any assembler directive
> >> to selectively turn-off instruction compression.
> >
> > ".option norvc"?
> >
> > Paolo
> To:          anup@brainfault.org
> CC:          pbonzini@redhat.com
> CC:          Anup Patel <Anup.Patel@wdc.com>
> CC:          Paul Walmsley <paul.walmsley@sifive.com>
> CC:          rkrcmar@redhat.com
> CC:          daniel.lezcano@linaro.org
> CC:          tglx@linutronix.de
> CC:          graf@amazon.com
> CC:          Atish Patra <Atish.Patra@wdc.com>
> CC:          Alistair Francis <Alistair.Francis@wdc.com>
> CC:          Damien Le Moal <Damien.LeMoal@wdc.com>
> CC:          Christoph Hellwig <hch@infradead.org>
> CC:          kvm@vger.kernel.org
> CC:          linux-riscv@lists.infradead.org
> CC:          linux-kernel@vger.kernel.org
> Subject:     Re: [PATCH v7 10/21] RISC-V: KVM: Handle MMIO exits for VCPU
> In-Reply-To: <CAAhSdy29gi2d9c9tumtO68QbB=_+yUYp+ikN3dQ-wa2e-Lesfw@mail.gmail.com>
>
> On Mon, 23 Sep 2019 22:07:43 PDT (-0700), anup@brainfault.org wrote:
> > On Mon, Sep 23, 2019 at 7:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 23/09/19 15:09, Anup Patel wrote:
> >> >>> +#ifndef CONFIG_RISCV_ISA_C
> >> >>> +                     "li %[tilen], 4\n"
> >> >>> +#else
> >> >>> +                     "li %[tilen], 2\n"
> >> >>> +#endif
> >> >>
> >> >> Can you use an assembler directive to force using a non-compressed
> >> >> format for ld and lw?  This would get rid of tilen, which is costing 6
> >> >> bytes (if I did the RVC math right) in order to save two. :)
> >> >
> >> > I tried looking for it but could not find any assembler directive
> >> > to selectively turn-off instruction compression.
> >>
> >> ".option norvc"?
> >
> > Thanks for the hint. I will try ".option norvc"
>
> It should be something like
>
>     .option push
>     .option norvc
>     ld ...
>     .option pop
>
> which preserves C support for the rest of the file.

I have done exactly same thing in v8 patch series sent-out
last week.

Thanks,
Anup

>
> >
> > Regards,
> > Anup
> >
> >>
> >> Paolo
