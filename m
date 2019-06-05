Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480DEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292C9206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfFEQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:26:37 -0400
Received: from foss.arm.com ([217.140.101.70]:34450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfFEQ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:26:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C75374;
        Wed,  5 Jun 2019 09:26:35 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 318D83F5AF;
        Wed,  5 Jun 2019 09:26:33 -0700 (PDT)
Date:   Wed, 5 Jun 2019 17:26:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        linux-arm-kernel@lists.infradead.org, marek.vasut@gmail.com,
        catalin.marinas@arm.com, will.deacon@arm.com, trini@konsulko.com,
        paul.walmsley@sifive.com
Subject: Re: [v3 PATCH] RISC-V: Add a PE/COFF compliant Image header.
Message-ID: <20190605162630.GE30925@lakrids.cambridge.arm.com>
References: <20190523183516.583-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523183516.583-1-atish.patra@wdc.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:35:16AM -0700, Atish Patra wrote:
> Currently, last stage boot loaders such as U-Boot can accept only
> uImage which is an unnecessary additional step in automating boot flows.
> 
> Add a PE/COFF compliant image header that boot loaders can parse and
> directly load kernel flat Image. The existing booting methods will continue
> to work as it is.
> 
> Another goal of this header is to support EFI stub for RISC-V in future.
> EFI specification needs PE/COFF image header in the beginning of the kernel
> image in order to load it as an EFI application. In order to support
> EFI stub, code0 should be replaced with "MZ" magic string and res5(at
> offset 0x3c) should point to the rest of the PE/COFF header (which will
> be added during EFI support).
> 
> This patch is based on ARM64 boot image header and provides an opprtunity
> to combine both ARM64 & RISC-V image headers.
> 
> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> ---
> I have not sent out corresponding U-Boot patch as all the changes are
> compatible with current u-boot support. Once, the kernel header format
> is agreed upon, I will update the U-Boot patch.
> 
> Changes from v2->v3
> 1. Modified reserved fields to define a header version.
> 2. Added header documentation.
> 
> Changes from v1-v2:
> 1. Added additional reserved elements to make it fully PE compatible.
> ---
>  Documentation/riscv/boot-image-header.txt | 50 ++++++++++++++++++
>  arch/riscv/include/asm/image.h            | 64 +++++++++++++++++++++++
>  arch/riscv/kernel/head.S                  | 32 ++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 Documentation/riscv/boot-image-header.txt
>  create mode 100644 arch/riscv/include/asm/image.h
> 
> diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.txt
> new file mode 100644
> index 000000000000..68abc2353cec
> --- /dev/null
> +++ b/Documentation/riscv/boot-image-header.txt
> @@ -0,0 +1,50 @@
> +				Boot image header in RISC-V Linux
> +			=============================================
> +
> +Author: Atish Patra <atish.patra@wdc.com>
> +Date  : 20 May 2019
> +
> +This document only describes the boot image header details for RISC-V Linux.
> +The complete booting guide will be available at Documentation/riscv/booting.txt.
> +
> +The following 64-byte header is present in decompressed Linux kernel image.
> +
> +	u32 code0;		  /* Executable code */
> +	u32 code1; 		  /* Executable code */
> +	u64 text_offset;	  /* Image load offset, little endian */
> +	u64 image_size;		  /* Effective Image size, little endian */
> +	u64 flags;		  /* kernel flags, little endian */
> +	u32 version;		  /* Version of this header */
> +	u32 res1  = 0;		  /* Reserved */
> +	u64 res2  = 0;    	  /* Reserved */
> +	u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
> +	u32 res3;		  /* Reserved for additional RISC-V specific header */
> +	u32 res4;		  /* Reserved for PE COFF offset */
> +
> +This header format is compliant with PE/COFF header and largely inspired from
> +ARM64 header. Thus, both ARM64 & RISC-V header can be combined into one common
> +header in future.
> +
> +Notes:
> +- This header can also be reused to support EFI stub for RISC-V in future. EFI
> +  specification needs PE/COFF image header in the beginning of the kernel image
> +  in order to load it as an EFI application. In order to support EFI stub,
> +  code0 should be replaced with "MZ" magic string and res5(at offset 0x3c) should
> +  point to the rest of the PE/COFF header.
> +
> +- version field indicate header version number.
> +  	Bits 0:15  - Minor version
> +	Bits 16:31 - Major version
> +
> +  This preserves compatibility across newer and older version of the header.
> +  The current version is defined as 0.1.
> +
> +- res3 is reserved for offset to any other additional fields. This makes the
> +  header extendible in future. One example would be to accommodate ISA
> +  extension for RISC-V in future. For current version, it is set to be zero.
> +
> +- In current header, the flag field has only one field.
> +	Bit 0: Kernel endianness. 1 if BE, 0 if LE.
> +
> +- Image size is mandatory for boot loader to load kernel image. Booting will
> +  fail otherwise.
> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> new file mode 100644
> index 000000000000..61c9f20d2f19
> --- /dev/null
> +++ b/arch/riscv/include/asm/image.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_IMAGE_H
> +#define __ASM_IMAGE_H
> +
> +#define RISCV_IMAGE_MAGIC	"RISCV"
> +
> +
> +#define RISCV_IMAGE_FLAG_BE_SHIFT	0
> +#define RISCV_IMAGE_FLAG_BE_MASK	0x1
> +
> +#define RISCV_IMAGE_FLAG_LE		0
> +#define RISCV_IMAGE_FLAG_BE		1
> +
> +
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define __HEAD_FLAG_BE		RISCV_IMAGE_FLAG_BE
> +#else
> +#define __HEAD_FLAG_BE		RISCV_IMAGE_FLAG_LE
> +#endif
> +
> +#define __HEAD_FLAG(field)	(__HEAD_FLAG_##field << \
> +				RISCV_IMAGE_FLAG_##field##_SHIFT)
> +
> +#define __HEAD_FLAGS		(__HEAD_FLAG(BE))

If you have a CONFIG_CPU_BIG_ENDIAN kernel, this will not be
little-endian, nor will other fields in your header (e.g. the image
size), so I would recommend dropping this for now.

To manage that for the image_size field you'll probably need to play the
same linker trick games we play on arm64.

It's probably worth having:

#ifdef CONFIG_CPU_BIG_ENDIAN
#error conversion of header fields to LE not yet implemented
#endif

... to catch that later.

Thanks,
Mark,
