Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 03:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCC521872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 03:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="C9LwTpoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfJZDWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 23:22:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33057 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfJZDWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 23:22:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so4433726wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 20:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDkPt2vxGvwt3QPswZka6NmewYvhNdxaRnBgmjWNMNE=;
        b=C9LwTpoMiaGEtarmKKTOEugKrY4v8PqKTr/nwd8Q6hsQ0nXW13bIbP+NnYd8Zvv+Fu
         rZ+9G77bPVots2ydjdBiOh9zuet8WyKKEyOBGhEkknv5Me+seTlOfxgxy0GiRD4vxU3N
         dy9s9GpEj1dYi8+E9wftSWMDmtnsuw0o+zgvOHHvCkWvwK2WZf2E4TBaI8hdZC3H0uUA
         VFikOoun+D4A5NnI/tYjBEBX9r35NzIbkqSON1Sa/RT1x6hQjDlPwHiKOevFW9W9vKmq
         NkPp/8DD38VvRZ9FLUFWSqRpdnKG6jlP8HTBD4GXjW8h9s+MmJZeW42sEoeGFkkUfx/i
         VlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDkPt2vxGvwt3QPswZka6NmewYvhNdxaRnBgmjWNMNE=;
        b=mcCRbPWhUWd+aWu+A8tagQTjWR5QoYPguMlMVFnzcTJPqBKVSTXxA7FasCyrYjS8AS
         Ch1WlB+MNqIsmVcbghQRQYBUzMfcN3TRIkZnAW5+xaDqQAid8e7PTf97Npc21jfl9e9i
         EKaD6cn6Wpn3FOT0OR7Tr9dXPUkYiyhuKnAjDqqET2+q3N3vHKwdmDwo/GvZuCawZng8
         E/OgGXE9sfNI2BPAFuEXVn96QR+4qqfThGaUK98I0nNzOEqMuMFbFJPppAQg4xUfD11e
         59hrJ0/8YT+GbLVAHFlqEBXmYgAK270PipzlMxgveRID6Fqi2pjJTilhP8wnt+Q8avO/
         lv9w==
X-Gm-Message-State: APjAAAUBXtYn9AVEEWa40EpV/JzO4SwHDXpkp9lLo2BlJlxqeRU2xOeL
        7SpDHj08cllLB8VaWvAfM5Q+zY0kOHaE+lh9TaUvqg==
X-Google-Smtp-Source: APXvYqzGZAwZcrHBPmOgmCPHvyvMfVI74sgWBPVAhX27aA6UWJHfjZjS6tcIVVoOKyt4lXWyW/tRQWr+XDi0GMbCxqI=
X-Received: by 2002:a05:6000:351:: with SMTP id e17mr5324719wre.96.1572060147773;
 Fri, 25 Oct 2019 20:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191016160649.24622-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1910251609500.12828@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910251609500.12828@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 26 Oct 2019 08:52:16 +0530
Message-ID: <CAAhSdy1zfL2kPM-Le6TZSqS2TU1RkgC+zTbB4y31t8TXwVjhEg@mail.gmail.com>
Subject: Re: [PATCH v9 00/22] KVM RISC-V Support
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
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

On Sat, Oct 26, 2019 at 4:40 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hi Anup,
>
> On Wed, 16 Oct 2019, Anup Patel wrote:
>
> > This series adds initial KVM RISC-V support. Currently, we are able to boot
> > RISC-V 64bit Linux Guests with multiple VCPUs.
> >
> > Few key aspects of KVM RISC-V added by this series are:
> > 1. Minimal possible KVM world-switch which touches only GPRs and few CSRs.
> > 2. Full Guest/VM switch is done via vcpu_get/vcpu_put infrastructure.
> > 3. KVM ONE_REG interface for VCPU register access from user-space.
> > 4. PLIC emulation is done in user-space.
> > 5. Timer and IPI emuation is done in-kernel.
> > 6. MMU notifiers supported.
> > 7. FP lazy save/restore supported.
> > 8. SBI v0.1 emulation for KVM Guest available.
> > 9. Forward unhandled SBI calls to KVM userspace.
> > 10. Hugepage support for Guest/VM
>
> Several patches in this series cause 'checkpatch.pl --strict' to flag
> issues.  When you respin this series, could you fix those, please?

I generally run checkpatch.pl every time before sending patches.

I will try checkpatch.pl with --strict parameter as well in v10 series.

Regards,
Anup

>
>
> thanks,
>
> - Paul
