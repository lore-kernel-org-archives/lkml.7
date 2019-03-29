Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B85C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F98A2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhmyzT4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfC2VZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:25:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45976 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2VZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:25:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id y84so2780532oia.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SrxeZI0xNm9dzWvmFFvMwHqAH/sUZ2XFgxd5gGb/NsA=;
        b=LhmyzT4zWeJlaOW591zu+6ntI6jBc/ZheRj/nkGiZ0uVMCV/K+24rq7TY9U4J+HjQA
         yPNiGgSpeFQyx1dU6OWJZxcTkFB2pVASLbvAFx+yVs1Nm8fIeV+tgKA1ue5PTt3zvjtr
         o+oY7p8+LVoeflep5UKqtSzV3whP7kXKhy/GulRL3ISURMqehv21kmS3UyuBW3XX4QZh
         BuB/DiDgBUksH37KDj20mbh49qQvfmhKLa2Fl7Nil96V45NYz7prHNUyyWT25DDdYQaH
         DOpfuwAdcX3GMClWJla8V95SW2bYu3Q5o9BkQvgvK1z1UoZo3LG0TbhEoJMhaW5nEBHA
         bY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SrxeZI0xNm9dzWvmFFvMwHqAH/sUZ2XFgxd5gGb/NsA=;
        b=pznJP1RuyUaokQRRNqL7rp+94AD3ZIGg6156eCg6MwCgCB77ti+1E588/GmYtVIMCi
         zeBiLsCxvbp+/cnKS6AVq4E4UyDp03eEHhvAFUpDcekNaBlTXKDXGsD5EwfZxWSmOnNC
         g3L4aChqAp3B+A+MaoZN16Ko43Qj7myAg653pA9t4Yxpz2fxC+m3DUca9Avo4m+wDmU6
         YsmCaXDlemAsxVB8xz8WXhvGaTwwvcG0nTaJ3RIiS9BXHjz4g4x/5fFMPC6Uh/s8cAQc
         idH/FcFAZaRlJ2rS08se5X8IOB0IYggDUKxC8f+0WSIuyJLdcY5KFj1X2VtU4us/fC9w
         RAPA==
X-Gm-Message-State: APjAAAUnpBHYwgrOvZdjVAkE+wkQ5ehOuKQW/LrLTtqAq8HERsn+8E9e
        yzvrdUuNnmSoWUJBE0FhXWsThS9m8AJZo5UUss7cQw==
X-Google-Smtp-Source: APXvYqxH0XFRVTnzUJWmbJk21g6OS6KWjlmf/jQgbsskptFW+T9YlZ56fvnPYKWPhcuKuyH9HurV6/Syaz/vvPCQVjA=
X-Received: by 2002:aca:e4cc:: with SMTP id b195mr5260368oih.39.1553894741377;
 Fri, 29 Mar 2019 14:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190328225925.241998-1-jannh@google.com> <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
 <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com> <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com>
In-Reply-To: <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 22:25:15 +0100
Message-ID: <CAG48ez0qtiy-Bss32A5KdvtJfJOyt_M1w67X7=05gPBtkywi2g@mail.gmail.com>
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
To:     Mukesh Ojha <mojha@codeaurora.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        iommu@lists.linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:19 PM Jann Horn <jannh@google.com> wrote:
>
> +Logan Gunthorpe and Horia Geant=C4=83, since they've written a bunch of =
this code
>
> On Fri, Mar 29, 2019 at 5:48 PM Jann Horn <jannh@google.com> wrote:
> > On Fri, Mar 29, 2019 at 9:19 AM Mukesh Ojha <mojha@codeaurora.org> wrot=
e:
> > > On 3/29/2019 4:29 AM, Jann Horn wrote:
> > > > The sparse checker attempts to ensure that all conversions between
> > > > fixed-endianness numbers and numbers with native endianness are exp=
licit.
> > > > However, the calgary code reads and writes big-endian numbers from/=
to IO
> > > > memory using {read,write}{l,q}(), which return native-endian number=
s.
> > > >
> > > > This could be addressed by putting __force casts all over the place=
, but
> > > > that would kind of defeat the point of the warning. Instead, create=
 new
> > > > helpers {read,write}{l,q}_be() for big-endian IO that convert from/=
to
> > > > native endianness.
> > > >
> > > > Most of this patch is a straightforward conversion; the following p=
arts
> > > > aren't just mechanical replacement:
> > > >
> > > >   - ->tar_val is now a native-endian number instead of big-endian
> > > >   - calioc2_handle_quirks() did `cpu_to_be32(readl(target))` when i=
t
> > > >     intended to do `be32_to_cpu(readl(target))` (but that has no ac=
tual
> > > >     effects outside of type warnings)
> > > >
> > > > This gets rid of 108 lines of sparse warnings.
> > > >
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > ---
> > > > compile-tested only
> > > >
> > > >   arch/x86/kernel/pci-calgary_64.c | 108 ++++++++++++++++++--------=
-----
> > > >   1 file changed, 64 insertions(+), 44 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci=
-calgary_64.c
> > > > index c70720f61a34..36cd66d940fb 100644
> > > > --- a/arch/x86/kernel/pci-calgary_64.c
> > > > +++ b/arch/x86/kernel/pci-calgary_64.c
> > > > @@ -534,6 +534,26 @@ static inline int is_cal_pci_dev(unsigned shor=
t device)
> > > >       return (is_calgary(device) || is_calioc2(device));
> > > >   }
> > >
> > >
> > > Can the existing api's not be used here like iowrite64be/ioread64be/ =
or
> > > similar variant in "include/asm-generic/io.h"
> >
> > Oooh! I didn't realize that those exist. I'll change that and send a v2=
.
>
> Actually, that doesn't work at the moment on x86-64:
>
> include/asm-generic/io.h only defines these things if
> CONFIG_GENERIC_IOMAP isn't defined; and X86 unconditionally defines
> it. With CONFIG_GENERIC_IOMAP set, these functions are provided by
> include/asm-generic/iomap.h.
>
> include/asm-generic/iomap.h has extern definitions of them:
>
> extern unsigned int ioread8(void __iomem *);
> extern unsigned int ioread16(void __iomem *);
> extern unsigned int ioread16be(void __iomem *);
> extern unsigned int ioread32(void __iomem *);
> extern unsigned int ioread32be(void __iomem *);
> #ifdef CONFIG_64BIT
> extern u64 ioread64(void __iomem *);
> extern u64 ioread64be(void __iomem *);
> #endif
> [...]
> extern void iowrite8(u8, void __iomem *);
> extern void iowrite16(u16, void __iomem *);
> extern void iowrite16be(u16, void __iomem *);
> extern void iowrite32(u32, void __iomem *);
> extern void iowrite32be(u32, void __iomem *);
> #ifdef CONFIG_64BIT
> extern void iowrite64(u64, void __iomem *);
> extern void iowrite64be(u64, void __iomem *);
> #endif
>
> The definitions for these are in lib/iomap.c, except that there are no
> definitions for ioread64be() and iowrite64be(); if you try to use
> them, you get linker errors.
>
> I guess maybe the fix for that would be to, in iomap.c, just implement
> iowrite64{,be} the same way as iowrite32{,be}, just under a "#ifdef
> CONFIG_64BIT"?

... nope, I don't think I can figure out the proper fix here. There is
no inq(), because 64-bit port I/O apparently isn't a thing. So it'd
have to use pio_read64_lo_hi() for ports, but readq() for MMIO? Which
is what ioread64_lo_hi() already does? I'm confused.
