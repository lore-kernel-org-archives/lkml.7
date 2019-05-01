Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE34C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0397420835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEARA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:00:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34088 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfEARA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:00:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9102C80D;
        Wed,  1 May 2019 10:00:57 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C2023F719;
        Wed,  1 May 2019 10:00:56 -0700 (PDT)
Date:   Wed, 1 May 2019 18:00:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zong@andestech.com" <zong@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
Message-ID: <20190501170053.GG11740@lakrids.cambridge.arm.com>
References: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
 <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:42:40PM -0700, Atish Patra wrote:
> On 4/29/19 4:40 PM, Palmer Dabbelt wrote:
> > On Tue, 23 Apr 2019 16:25:06 PDT (-0700), atish.patra@wdc.com wrote:
> > > Currently, last stage boot loaders such as U-Boot can accept only
> > > uImage which is an unnecessary additional step in automating boot flows.
> > > 
> > > Add a simple image header that boot loaders can parse and directly
> > > load kernel flat Image. The existing booting methods will continue to
> > > work as it is.
> > > 
> > > Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
> > > 
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >   arch/riscv/include/asm/image.h | 32 ++++++++++++++++++++++++++++++++
> > >   arch/riscv/kernel/head.S       | 28 ++++++++++++++++++++++++++++
> > >   2 files changed, 60 insertions(+)
> > >   create mode 100644 arch/riscv/include/asm/image.h
> > > 
> > > diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> > > new file mode 100644
> > > index 000000000000..76a7e0d4068a
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/image.h
> > > @@ -0,0 +1,32 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __ASM_IMAGE_H
> > > +#define __ASM_IMAGE_H
> > > +
> > > +#define RISCV_IMAGE_MAGIC	"RISCV"
> > > +
> > > +#ifndef __ASSEMBLY__
> > > +/*
> > > + * struct riscv_image_header - riscv kernel image header
> > > + *
> > > + * @code0:		Executable code
> > > + * @code1:		Executable code
> > > + * @text_offset:	Image load offset
> > > + * @image_size:		Effective Image size
> > > + * @reserved:		reserved
> > > + * @magic:		Magic number
> > > + * @reserved:		reserved
> > > + */
> > > +
> > > +struct riscv_image_header {
> > > +	u32 code0;
> > > +	u32 code1;
> > > +	u64 text_offset;
> > > +	u64 image_size;
> > > +	u64 res1;
> > > +	u64 magic;
> > > +	u32 res2;
> > > +	u32 res3;
> > > +};
> > 
> > I don't want to invent our own file format.  Is there a reason we can't just
> > use something standard?  Off the top of my head I can think of ELF files and
> > multiboot.
> 
> Additional header is required to accommodate PE header format. Currently,
> this is only used for booti command but it will be reused for EFI headers as
> well. Linux kernel Image can pretend as an EFI application if PE/COFF header
> is present. This removes the need of an explicit EFI boot loader and EFI
> firmware can directly load Linux (obviously after EFI stub implementation
> for RISC-V).

Adding the EFI stub on arm64 required very careful consideration of our
Image header and the EFI spec, along with the PE/COFF spec.

For example, to be a compliant PE/COFF header, the first two bytes of
your kernel image need to be "MZ" in ASCII. On arm64 we happened to find
a valid instruction that we could rely upon that met this requirement...

> > >   __INIT
> > >   ENTRY(_start)
> > > +	/*
> > > +	 * Image header expected by Linux boot-loaders. The image header data
> > > +	 * structure is described in asm/image.h.
> > > +	 * Do not modify it without modifying the structure and all bootloaders
> > > +	 * that expects this header format!!
> > > +	 */
> > > +	/* jump to start kernel */
> > > +	j _start_kernel

... but it's not clear to me if this instruction meets that requriement.

I would strongly encourage you to consider what you actually need for a
compliant EFI header before you set the rest of this ABI in stone.

On arm64 we also had issues with endianness, and I would strongly
recommend that you define how big/little endian will work ahead of time.
e.g. whether fields are always in a fixed endianness.

Thanks,
Mark.
