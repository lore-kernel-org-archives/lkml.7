Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60791C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249EC20645
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="H4LAJTY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEARMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:12:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44408 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfEARMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:12:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so25269613wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1MdDGHJ3v97Gewzs4mi2SgVk5SjqgGKkN3GGzAhTMHk=;
        b=H4LAJTY1Xw2haEQfz90FjZBT6ELgPfL9OYWEXT/aRGZ06VxQzckTDK4HK4tNM+UuAt
         obiUo20BRZEtrd3rY8FxHC8ZzXNhardxP7bgwgVn7u5VPFap9ogbgXNHe034cDz1iHi2
         7Hf96XEYRcg9XbiGhmnx4HevojSwQpL3KIKSuJAQYA04GsmXSNMT0jv5drMAUKdCi3uJ
         0C+zfT+f/Xr6nVup8E7LFqbF1XnL9/w0L3l7AdpyLvqx2HorEZDYBy6TSNwa43A9LBOB
         XTLuB7OZpOZuTb5KZ1QP7PARf8F/FhERT2NKDMOPnJjZuH0VyYsnBiaDbfZZpfd3MzSJ
         LGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MdDGHJ3v97Gewzs4mi2SgVk5SjqgGKkN3GGzAhTMHk=;
        b=HjnXoC88tGuyjvKtAwy5wipvKKiSVP4YSmQj2Wz1OijKHCAoPvDf+5W+4uUkZPS8Fk
         QeTvkQXEi2jDZnksYuIhSUiErlOg9lXMZ36nFxQdTg65/c8FeiQRis8pmB5ksyx0CsoA
         mbDsWAIha938ZKL9bxhfFoNvRAo3i/6WybgJVcvHNdxeSmkuou8aPrkf8ZqPEcFPl1Ry
         GbOQhAyvD+FPCmuVyJF7IX2Gtxlz01iSD0bc0BnkzKKzzRwDblMQtzpuzUz9j3pzgNIK
         lrAlBviI4EirZKkPiFW/gQD/ODVC4LdlWQv+DS0vwZV+jW567aKsU5xaec4mTrDhn/Y8
         FP9w==
X-Gm-Message-State: APjAAAWgoJW53NyfxG3UQY/fsROTQd0VaYshXZUclktq1lXTUAzFzsr+
        hWhSebUKrHqZ0qLw3YkFSN8Bkeofl4sfYA2943uYrg==
X-Google-Smtp-Source: APXvYqz7GWnHLq9+RE6M3Yb6xG2DPvzlRUPlkD/3MWd/z79DglFDFnxHpuM0kxtcdoGfNWGVRZBY33sQnd5M8zYqUB0=
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr2418315wrm.128.1556730722955;
 Wed, 01 May 2019 10:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
 <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com> <20190501170053.GG11740@lakrids.cambridge.arm.com>
In-Reply-To: <20190501170053.GG11740@lakrids.cambridge.arm.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 1 May 2019 22:41:52 +0530
Message-ID: <CAAhSdy2OuCb6wBrs-O=fTWo0D_CgwTztfV-kMDi=tPmSJhM7og@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zong@andestech.com" <zong@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 10:30 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Apr 29, 2019 at 10:42:40PM -0700, Atish Patra wrote:
> > On 4/29/19 4:40 PM, Palmer Dabbelt wrote:
> > > On Tue, 23 Apr 2019 16:25:06 PDT (-0700), atish.patra@wdc.com wrote:
> > > > Currently, last stage boot loaders such as U-Boot can accept only
> > > > uImage which is an unnecessary additional step in automating boot flows.
> > > >
> > > > Add a simple image header that boot loaders can parse and directly
> > > > load kernel flat Image. The existing booting methods will continue to
> > > > work as it is.
> > > >
> > > > Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
> > > >
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >   arch/riscv/include/asm/image.h | 32 ++++++++++++++++++++++++++++++++
> > > >   arch/riscv/kernel/head.S       | 28 ++++++++++++++++++++++++++++
> > > >   2 files changed, 60 insertions(+)
> > > >   create mode 100644 arch/riscv/include/asm/image.h
> > > >
> > > > diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> > > > new file mode 100644
> > > > index 000000000000..76a7e0d4068a
> > > > --- /dev/null
> > > > +++ b/arch/riscv/include/asm/image.h
> > > > @@ -0,0 +1,32 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +#ifndef __ASM_IMAGE_H
> > > > +#define __ASM_IMAGE_H
> > > > +
> > > > +#define RISCV_IMAGE_MAGIC        "RISCV"
> > > > +
> > > > +#ifndef __ASSEMBLY__
> > > > +/*
> > > > + * struct riscv_image_header - riscv kernel image header
> > > > + *
> > > > + * @code0:               Executable code
> > > > + * @code1:               Executable code
> > > > + * @text_offset: Image load offset
> > > > + * @image_size:          Effective Image size
> > > > + * @reserved:            reserved
> > > > + * @magic:               Magic number
> > > > + * @reserved:            reserved
> > > > + */
> > > > +
> > > > +struct riscv_image_header {
> > > > + u32 code0;
> > > > + u32 code1;
> > > > + u64 text_offset;
> > > > + u64 image_size;
> > > > + u64 res1;
> > > > + u64 magic;
> > > > + u32 res2;
> > > > + u32 res3;
> > > > +};
> > >
> > > I don't want to invent our own file format.  Is there a reason we can't just
> > > use something standard?  Off the top of my head I can think of ELF files and
> > > multiboot.
> >
> > Additional header is required to accommodate PE header format. Currently,
> > this is only used for booti command but it will be reused for EFI headers as
> > well. Linux kernel Image can pretend as an EFI application if PE/COFF header
> > is present. This removes the need of an explicit EFI boot loader and EFI
> > firmware can directly load Linux (obviously after EFI stub implementation
> > for RISC-V).
>
> Adding the EFI stub on arm64 required very careful consideration of our
> Image header and the EFI spec, along with the PE/COFF spec.
>
> For example, to be a compliant PE/COFF header, the first two bytes of
> your kernel image need to be "MZ" in ASCII. On arm64 we happened to find
> a valid instruction that we could rely upon that met this requirement...

The "MZ" ASCII (i.e. 0x5a4d) is "li s4,-13" instruction in RISC-V so this
modifies "s4" register which is pretty harmless from Linux RISC-V booting
perspective.

Of course, we should only add "MZ" ASCII in Linux RISC-V image header
when CONFIG_EFI is enabled (just like Linux ARM64).

>
> > > >   __INIT
> > > >   ENTRY(_start)
> > > > + /*
> > > > +  * Image header expected by Linux boot-loaders. The image header data
> > > > +  * structure is described in asm/image.h.
> > > > +  * Do not modify it without modifying the structure and all bootloaders
> > > > +  * that expects this header format!!
> > > > +  */
> > > > + /* jump to start kernel */
> > > > + j _start_kernel
>
> ... but it's not clear to me if this instruction meets that requriement.
>
> I would strongly encourage you to consider what you actually need for a
> compliant EFI header before you set the rest of this ABI in stone.
>
> On arm64 we also had issues with endianness, and I would strongly
> recommend that you define how big/little endian will work ahead of time.
> e.g. whether fields are always in a fixed endianness.

As of now RISC-V is little-endian but if big-endian show-up in-future
then we should consider endianness issue.

Regards,
Anup
