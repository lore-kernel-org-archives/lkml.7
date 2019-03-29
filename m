Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F91C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9912F206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSnF650g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfC2VTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:19:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46916 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbfC2VTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:19:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id x188so2775110oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4pQ7tDekHozc1girhjFRBmExj8JbTOaw9anomtPC8ws=;
        b=RSnF650gigpL0fFv5eOwHHEhqEg13rRKKandV5oHd1WrzR9XPBGcqwkoLWo8i2/Gak
         vaUjx0t4RBEbbHXNNxg9speMyZb+CLbtkG1lX7uJtMJJedLd2IfQUxYTQeSRqtkj4u/O
         TWx85r1XviQ+y/zvlrZwyePUxcHjZ23dTtwGP3jPNkgfCDJ6a5xe4meSXM10BQO6WdzQ
         uqvQ5wOC6FIKj+iDVm/ZS6Q7Ztx4h5lwHFEV7fQhNi3dFFc4RL3Hp7sRw3+yg7ctrSX6
         b68bE91lzwVIeU8QdGf5/V7knwU0FHDDCfnAAOX/jn+OlKzZv+/yGvQ8oRbZo1Fbt21v
         4F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4pQ7tDekHozc1girhjFRBmExj8JbTOaw9anomtPC8ws=;
        b=GPCIscCciyjyR4YhYdCoeBpe/PkzqtydicfETolVrochCWpqU8VImaXn/G9YfUVZdO
         B2QTN4iXZioMC+NhPYh31WMnqsmIpymZMOcRafSfPPSBTXGLPeXCqfp1UCOsrR2OWD/P
         2pIpX/bHLilZ0cTkasGaFGh7qlg5Mq/FtF1U9p+QP1aTOygHQIkKilA9BIlxTUWEf/S/
         BYz9MEkHkSN17Lfph4Pg9UplVSd9bs4zZ0YlstyQDTK77/nPKjq/e402Q2XOunIwAT1s
         GjATECtUEZStAVPjNWS0FoR+AXDdQ87xeO3k5r9ImP2RsPsyzSA3Tdj75e7AU8rMHu1S
         yoNQ==
X-Gm-Message-State: APjAAAXPiqXv/nZZxrIiNoa+rA5UXqJnv4Exdx+VMBK4wkrVzvfbd59o
        jih+DXEZLv+GRVOxs6JFLpMsaVOWuIwi18UpW+NqiA==
X-Google-Smtp-Source: APXvYqxf8CphgH5tsJUZS2x4bqTumScr5dwTZ/gOpPgGCemNahtMjEZ19qkarnkTuTV1Ix+D/ZhWJ5CDmZCuNrvpQks=
X-Received: by 2002:aca:360a:: with SMTP id d10mr5210537oia.68.1553894369516;
 Fri, 29 Mar 2019 14:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190328225925.241998-1-jannh@google.com> <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
 <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com>
In-Reply-To: <CAG48ez3UE6cnA0TZQ-7DUnB_QWPFV04bJsv9oKXfgBtu=ugBLw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 22:19:03 +0100
Message-ID: <CAG48ez13xg1oUiO_pyDHVbJkWRQdW4CoX7uGzoujyf4L6VB-dw@mail.gmail.com>
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

+Logan Gunthorpe and Horia Geant=C4=83, since they've written a bunch of th=
is code

On Fri, Mar 29, 2019 at 5:48 PM Jann Horn <jannh@google.com> wrote:
> On Fri, Mar 29, 2019 at 9:19 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
> > On 3/29/2019 4:29 AM, Jann Horn wrote:
> > > The sparse checker attempts to ensure that all conversions between
> > > fixed-endianness numbers and numbers with native endianness are expli=
cit.
> > > However, the calgary code reads and writes big-endian numbers from/to=
 IO
> > > memory using {read,write}{l,q}(), which return native-endian numbers.
> > >
> > > This could be addressed by putting __force casts all over the place, =
but
> > > that would kind of defeat the point of the warning. Instead, create n=
ew
> > > helpers {read,write}{l,q}_be() for big-endian IO that convert from/to
> > > native endianness.
> > >
> > > Most of this patch is a straightforward conversion; the following par=
ts
> > > aren't just mechanical replacement:
> > >
> > >   - ->tar_val is now a native-endian number instead of big-endian
> > >   - calioc2_handle_quirks() did `cpu_to_be32(readl(target))` when it
> > >     intended to do `be32_to_cpu(readl(target))` (but that has no actu=
al
> > >     effects outside of type warnings)
> > >
> > > This gets rid of 108 lines of sparse warnings.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > compile-tested only
> > >
> > >   arch/x86/kernel/pci-calgary_64.c | 108 ++++++++++++++++++----------=
---
> > >   1 file changed, 64 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-c=
algary_64.c
> > > index c70720f61a34..36cd66d940fb 100644
> > > --- a/arch/x86/kernel/pci-calgary_64.c
> > > +++ b/arch/x86/kernel/pci-calgary_64.c
> > > @@ -534,6 +534,26 @@ static inline int is_cal_pci_dev(unsigned short =
device)
> > >       return (is_calgary(device) || is_calioc2(device));
> > >   }
> >
> >
> > Can the existing api's not be used here like iowrite64be/ioread64be/ or
> > similar variant in "include/asm-generic/io.h"
>
> Oooh! I didn't realize that those exist. I'll change that and send a v2.

Actually, that doesn't work at the moment on x86-64:

include/asm-generic/io.h only defines these things if
CONFIG_GENERIC_IOMAP isn't defined; and X86 unconditionally defines
it. With CONFIG_GENERIC_IOMAP set, these functions are provided by
include/asm-generic/iomap.h.

include/asm-generic/iomap.h has extern definitions of them:

extern unsigned int ioread8(void __iomem *);
extern unsigned int ioread16(void __iomem *);
extern unsigned int ioread16be(void __iomem *);
extern unsigned int ioread32(void __iomem *);
extern unsigned int ioread32be(void __iomem *);
#ifdef CONFIG_64BIT
extern u64 ioread64(void __iomem *);
extern u64 ioread64be(void __iomem *);
#endif
[...]
extern void iowrite8(u8, void __iomem *);
extern void iowrite16(u16, void __iomem *);
extern void iowrite16be(u16, void __iomem *);
extern void iowrite32(u32, void __iomem *);
extern void iowrite32be(u32, void __iomem *);
#ifdef CONFIG_64BIT
extern void iowrite64(u64, void __iomem *);
extern void iowrite64be(u64, void __iomem *);
#endif

The definitions for these are in lib/iomap.c, except that there are no
definitions for ioread64be() and iowrite64be(); if you try to use
them, you get linker errors.

I guess maybe the fix for that would be to, in iomap.c, just implement
iowrite64{,be} the same way as iowrite32{,be}, just under a "#ifdef
CONFIG_64BIT"?
