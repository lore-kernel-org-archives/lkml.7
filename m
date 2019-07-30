Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74167C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFA5206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="y2smEzLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfG3F0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:26:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50560 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfG3F0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:26:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so55815829wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47K6Qgo5QbrZVacaid1WG9JiEbdXdWfBJ5xwgMh492Q=;
        b=y2smEzLUhjWfJzia8TXdaSlDHyftOWzuH910O0PkAhV1T6cHiL6c6wLlk8CxkgNnU0
         CNwqtZsdVpRwMEbeXWYMlwX4m1NfMzmFn6GBQHJ6CzUFo3C69Tr5JOS0xCvt8Ze3HNGC
         TckHauXiV7jipXhyCxjA3RPxJCMB+MZz3nGc67U/l8hmsOQAUtl9Tcq+7tjBDWIYOuF+
         EYWGQLwgoYd32dqpj0MjQitNehY3lKlRWC3tQiCmiH5hSrEvYb/kHkhXoaBR7KbnB8Qv
         4aImkrmH/Oa0pcwxkJpzyoxP0n/5MHwqp1lrlT0U46nf+oHTCHpu0YTYMS6ii62EJGZP
         fX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47K6Qgo5QbrZVacaid1WG9JiEbdXdWfBJ5xwgMh492Q=;
        b=KyNl2AZ8sxT6TnYDc8DjPXBlC41kcQzjFl89u24rDnAzRDT+YraEOD7owER+GkDzqa
         54aZWszx+A/m0k5oa0u1nICQ1fQiEtzIrkJ9VuWxd69saab9Lo17hfao8bwJgY41wkjM
         VE5+F6UUIRK1VrawarSF2s0juzWaPa8EjFFytB3t4i/7OlTkCYAita8CZ3KfJUXSymu0
         kwNAT5miB5v1wrqvcaQSG+xXaAfUtdIn9eNotS6t4EPe3vtpVph2BFedZEMPBZ+il5oj
         RiRQvf4qSBmoWfHDe1bUm6M0oLmhOeMeNNv4CRQ6clzBTnV6hUZCkSTlSb++8UUQ6XWi
         kg6g==
X-Gm-Message-State: APjAAAVWCUEWju2ldbkS2OjjKwb1emyYgWLCnX4mcsAHCIOHfYsQpXUo
        ILwf2h0O9c/AgxE+20GIUl70YUl14UpesrAspZI=
X-Google-Smtp-Source: APXvYqy9JqFCYGeBYIGRwK0STC3uyqMmE3umCULOglzUZYV5R/oHxsaevcpDD0VVoIXgi5fdeCDD/6ktHdvpucpNCOA=
X-Received: by 2002:a1c:cfc5:: with SMTP id f188mr94263067wmg.24.1564464405064;
 Mon, 29 Jul 2019 22:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <72e9f668-f496-3fca-a1a8-a3c3122a3fd9@redhat.com>
In-Reply-To: <72e9f668-f496-3fca-a1a8-a3c3122a3fd9@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Jul 2019 10:56:33 +0530
Message-ID: <CAAhSdy3Z6d2phRGo20eNWfa4onFwFtsOUPM+OCD465y0tvQ5wg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] KVM RISC-V Support
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

On Tue, Jul 30, 2019 at 3:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/07/19 13:56, Anup Patel wrote:
> > This series adds initial KVM RISC-V support. Currently, we are able to boot
> > RISC-V 64bit Linux Guests with multiple VCPUs.
> >
> > Few key aspects of KVM RISC-V added by this series are:
> > 1. Minimal possible KVM world-switch which touches only GPRs and few CSRs.
> > 2. Full Guest/VM switch is done via vcpu_get/vcpu_put infrastructure.
> > 3. KVM ONE_REG interface for VCPU register access from user-space.
> > 4. PLIC emulation is done in user-space. In-kernel PLIC emulation, will
> >    be added in future.
> > 5. Timer and IPI emuation is done in-kernel.
> > 6. MMU notifiers supported.
> > 7. FP lazy save/restore supported.
> > 8. SBI v0.1 emulation for KVM Guest available.
> >
> > More feature additions and enhancments will follow after this series and
> > eventually KVM RISC-V will be at-par with other architectures.
>
> This looks clean and it shouldn't take long to have it merged.  Please
> sort out the MAINTAINERS additions.  It would also be nice if
> tools/testing/selftests/kvm/ worked with RISC-V from the beginning;
> there have been recent ARM and s390 ports that you can take some
> inspiration from.

Thanks Paolo.

We will certainly include a patch in v2 series for MAINTAINERS entry.

We referred existing implementation of KVM ARM/ARM64, KVM powerpc
and KVM mips when we started KVM RISC-V port.

Here's a brief TODO list which we want to immediately work upon after this
series:
1. Handle trap from unpriv access in SBI v0.1 emulation
2. In-kernel PLIC emulation
3. SBI v0.2 emulation in-kernel
4. SBI v0.2 hart hotplug emulation in-kernel
5. ..... and so on .....

We will include above TODO list in v2 series cover letter as well.

Apart from above, we also have a more exhaustive TODO list based on study
of other KVM ports which we want to discuss at upcoming LPC 2019.

We were thinking to keep KVM RISC-V disabled by default (i.e. keep it
experimental) until we have validated it on some FPGA or real HW. For now,
users can explicitly enable it and play-around on QEMU emulation. I hope
this is fine with most people ?

Regards,
Anup
