Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAD1C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E4F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IcVEz3ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfD2Xkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:40:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39853 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbfD2Xki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:40:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id z26so2223863pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WbKrrsvoTA0yKVJgoX6tm1Cp8PXAIZFIWSxGDVql0/k=;
        b=IcVEz3ZBuqVVXRuB1VTTzJUwdoZkcZbe2vgds0gq461z777UMhALm315dO8UEBsw88
         NPCM7xr6we9IVxcyUb+y/gdVzWGfWx3r/BtdPxrnYJ7jvtKHIwfiPQ6IsEfhdxM03xDp
         FGXFuTC1iO/0vI0104oBkULk6XeGhC6luD5lkhUNpXa5GjO/80anvMp3w9ZQruqTR8h3
         T4GpFzwPGFu3589QeT06w1TXczVXDWId0UAj7xoN8tWvxSqpN+DHwbQ4izKFL+cntueV
         cj8sLRtx/2qnGkhs/bQk+aq9bgm3hsQKkUFgSyB0eiDRKW7+Sw0vQswJxco7lB0wec0q
         Jxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WbKrrsvoTA0yKVJgoX6tm1Cp8PXAIZFIWSxGDVql0/k=;
        b=o6zG0Tg1Rym37Z+lQJQOfiaIck679a/9XkFN8gJcbTwTggnlN18truSXadXjmPS0ny
         Nvp19nWdIpUc1QRB4O3ykeIEa3zclQcA6eGh5yAT4biZtG/V08rHFHmPTXmw+lBF/qcU
         Bn3qMElUYBkZ99fljSrKXi4ipAd0spALx2H7WWsDTQavDoSiy0NbvnaGf2t15HHbT6t5
         +KdsxfZoi38MYXhETxrgLtSw9D3HWlf9BmY34VH8zNXkES5EoN6DzGxcBR9ZSyirjNjR
         LVUEfIzLc5lzREQERj/cpZDB60gFCdZ33RweezB3eYGWPIW6kkNakX56HqohknFSH9FU
         Z0/Q==
X-Gm-Message-State: APjAAAX3j23vYVyeiN69IY9gqPZsDXBZQZEk+ctYR94i4rQVS+GzOSPL
        M2euiI4MML5n0BQRb/cjgKZOVO+ue4Zqog==
X-Google-Smtp-Source: APXvYqwJ2o7aI3WJI0mNsgywGAyWJqyyJsL9XlrQpgbm6c23Yv7PpZMUGjcwrLIcqq1ucR38+U7EBA==
X-Received: by 2002:a62:a515:: with SMTP id v21mr67869459pfm.41.1556581237031;
        Mon, 29 Apr 2019 16:40:37 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c1sm39186765pgk.44.2019.04.29.16.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 16:40:36 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:40:36 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 16:40:22 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
In-Reply-To: <20190423232506.857-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-riscv@lists.infradead.org, zong@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 16:25:06 PDT (-0700), atish.patra@wdc.com wrote:
> Currently, last stage boot loaders such as U-Boot can accept only
> uImage which is an unnecessary additional step in automating boot flows.
>
> Add a simple image header that boot loaders can parse and directly
> load kernel flat Image. The existing booting methods will continue to
> work as it is.
>
> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/image.h | 32 ++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.S       | 28 ++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 arch/riscv/include/asm/image.h
>
> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> new file mode 100644
> index 000000000000..76a7e0d4068a
> --- /dev/null
> +++ b/arch/riscv/include/asm/image.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_IMAGE_H
> +#define __ASM_IMAGE_H
> +
> +#define RISCV_IMAGE_MAGIC	"RISCV"
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * struct riscv_image_header - riscv kernel image header
> + *
> + * @code0:		Executable code
> + * @code1:		Executable code
> + * @text_offset:	Image load offset
> + * @image_size:		Effective Image size
> + * @reserved:		reserved
> + * @magic:		Magic number
> + * @reserved:		reserved
> + */
> +
> +struct riscv_image_header {
> +	u32 code0;
> +	u32 code1;
> +	u64 text_offset;
> +	u64 image_size;
> +	u64 res1;
> +	u64 magic;
> +	u32 res2;
> +	u32 res3;
> +};

I don't want to invent our own file format.  Is there a reason we can't just
use something standard?  Off the top of my head I can think of ELF files and
multiboot.

> +#endif /* __ASSEMBLY__ */
> +#endif /* __ASM_IMAGE_H */
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index fe884cd69abd..154647395601 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -19,9 +19,37 @@
>  #include <asm/thread_info.h>
>  #include <asm/page.h>
>  #include <asm/csr.h>
> +#include <asm/image.h>
>
>  __INIT
>  ENTRY(_start)
> +	/*
> +	 * Image header expected by Linux boot-loaders. The image header data
> +	 * structure is described in asm/image.h.
> +	 * Do not modify it without modifying the structure and all bootloaders
> +	 * that expects this header format!!
> +	 */
> +	/* jump to start kernel */
> +	j _start_kernel
> +	/* reserved */
> +	.word 0
> +	.balign 8
> +#if __riscv_xlen == 64
> +	/* Image load offset(2MB) from start of RAM */
> +	.dword 0x200000
> +#else
> +	/* Image load offset(4MB) from start of RAM */
> +	.dword 0x400000
> +#endif
> +	/* Effective size of kernel image */
> +	.dword _end - _start
> +	.dword 0
> +	.asciz RISCV_IMAGE_MAGIC
> +	.word 0
> +	.word 0
> +
> +.global _start_kernel
> +_start_kernel:
>  	/* Mask all interrupts */
>  	csrw sie, zero
