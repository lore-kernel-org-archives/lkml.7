Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27CDC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0A020835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="LUHd8Vyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfEARCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:02:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33732 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEARCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:02:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id e28so2214552wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+7UN/TvPGOY1J7TOpoWrixPjZV5XzV6c6DylKQU1Cg=;
        b=LUHd8VydBhmf7vhYTUKvS6O4NXb+ua7oBI/PzRnYWGn6GIN1Sg3NfFmQ3Rw5nuMnEx
         r6nuE2m6mntrxXnQ1NQb/j//9ulTW8sFj+mE4fppjkOKtpkDAHW96TCuKX9NQUMKmats
         Vc2l1T/ZRi2FU+0qXSAhEh2CfW1NV9YmiilUuO7lYxp+TchuFbgXQhIstqfCu/vJVlJH
         tDu09p5T2ff7n/nGGOQreLv2zX6ugsvcrEwuwwVOTE0MiMHKdb2zY1nK/PpeF+VBycVY
         JiHPv85Y5SpHDaCEC/jh5uGlP5JCJYaUQKXwzFnCPSbBHVTpFqeaO1RuSLG90Cl39v8W
         gpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+7UN/TvPGOY1J7TOpoWrixPjZV5XzV6c6DylKQU1Cg=;
        b=m3vly6WPznc5l1EQk2G5+oy1bEkKD8L+VGA7nGw6E4bxCqfulEYverGv4mN6kCH3Ja
         ZqdEJanCYhdqG6LI9apLQBHzNCTBX8tKezUdVPzckk5bYTfTogl6GkulhccCbKue61d4
         GuZw+7pwAXr1DJ48AvvCl7scmJG4BF7H1rCIuf6jngCs1y5LR+d/Ia4QUQ+vyS+m8j3q
         turklMEc0OqvE1EtePROXjoC0LxphF79HEe8gkzIUqyN2bHgbZt06eXygwgsU0NmuZp7
         SpFqR/+tWb+YXf5a8shSwVd4QjtcnqtCOtIwzJsCnotR/RoyOelRnqUndw+BW6hi2Kot
         UiVA==
X-Gm-Message-State: APjAAAXG3ieshJrbgpbW1noGtIpaJQIs/Z5ic2bNhCIyP6il0U4vVdUW
        1CqpJm6prrhwxvh9dPsBUdEqVpsh04JaE5PvpZI9CQ==
X-Google-Smtp-Source: APXvYqws5lEa+Yj446nSmR206A9Wct0CycB4RSuaA4Ezp6RqWz6ze9dLA7rKLlOXI1ea3VYrZpChweTo+2lF976AZgc=
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr10606348wrn.9.1556730161137;
 Wed, 01 May 2019 10:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
 <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com> <20190501164355.ce76wjmq6sszrf5g@excalibur.cnev.de>
In-Reply-To: <20190501164355.ce76wjmq6sszrf5g@excalibur.cnev.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 1 May 2019 22:32:30 +0530
Message-ID: <CAAhSdy3kjqDahp13gQa0g9GF4gKPQeVgSakZzuP0uYwkCrvdAg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
To:     Karsten Merker <merker@debian.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "zong@andestech.com" <zong@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 10:14 PM Karsten Merker <merker@debian.org> wrote:
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
> >
> > ARM64 follows the similar header format as well.
> > https://www.kernel.org/doc/Documentation/arm64/booting.txt
>
> Hello Atish,
>
> the arm64 header looks a bit different (quoted from the
> aforementioned URL):
>
>   u32 code0;                    /* Executable code */
>   u32 code1;                    /* Executable code */
>   u64 text_offset;              /* Image load offset, little endian */
>   u64 image_size;               /* Effective Image size, little endian */
>   u64 flags;                    /* kernel flags, little endian */
>   u64 res2      = 0;            /* reserved */
>   u64 res3      = 0;            /* reserved */
>   u64 res4      = 0;            /* reserved */
>   u32 magic     = 0x644d5241;   /* Magic number, little endian, "ARM\x64" */
>   u32 res5;                     /* reserved (used for PE COFF offset) */
>
> What I am unclear about is in which ways a RISC-V PE/COFF header
> differs from an arm64 one as the arm64 struct is longer than your
> RISC-V header and for arm64 the PE offset field is in the last
> field, i.e. outside of the area covered by your RISC-V structure
> definition.  Can you perhaps explain this part in a bit more
> detail or does anybody else have a pointer to a specification of
> the RISC-V PE/COFF header format (I have found a lot of documents
> about COFF in general, but nothing specific to RISC-V).

The only difference compared to ARM64 is the values of code0, code1
and res5 fields.

As-per PE/COFF, the 32bit value at offset 0x3c tells us offset of PE/COFF
header in image.

For more details refer,
https://en.wikipedia.org/wiki/Portable_Executable
https://en.wikipedia.org/wiki/Portable_Executable#/media/File:Portable_Executable_32_bit_Structure_in_SVG_fixed.svg

For both ARM64 header and RISC-V image header, is actually the
"DOS header" part of PE/COFF format.

This patch only adds "DOS header" part of PE/COFF format. Rest of
the PE/COFF header will be added when add EFI support to Linux
RISC-V kernel.

Regards,
Anup
