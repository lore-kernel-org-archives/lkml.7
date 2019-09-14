Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704F3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3FF20693
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 12:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfINMSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 08:18:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43196 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbfINMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 08:18:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so715363pfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 05:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=eG246burL7Epz04lN/Agoxuxu8FKEZNpqBGb+bGHtZM=;
        b=Q9VH0IZi+TupEPl2+tmSbQMuECM/zQcJ9oxrtGfk3q6u1IwJbUrPMfbrhpAi/9zivz
         pUt6Hr2H4QB66GEgquG4PjEaWsDJGb0gXOE001uvwOlr5oBx/pn8PnYm061QcUZCX3z7
         D442MQp9XYEOGRt2A2OaR9eL5l3RnweaUVWOyqBQ0ItfW9zKisbwT00HhJcy5OD4YQ58
         am0ljv9NfDdYDsOVBkokGhQB4a0DHHutrfFU06H6RUvvjHB6dqIjnXo1MzeRLXjsKYET
         41dABkw/PEdku5gDRBACiSD03NTSNm9mBU8lCx58T4uaSRe+wHqJ1/ZFvGscG6/hYfxZ
         dC+A==
X-Gm-Message-State: APjAAAX5zpe+AATqEHY0rmgLYzEghdoZzarECYFu2WXmE2ezonTB+msf
        HNe/XEQZpClKuxv7paSMAD5rLQ==
X-Google-Smtp-Source: APXvYqzVgQrhKkG6g0lvhiBLe+qqPUOeknf2nbS5nMorxrOX2tNnSXyV1t7CeZmF/cqojo4WNJoebg==
X-Received: by 2002:a63:355:: with SMTP id 82mr16568722pgd.81.1568463512195;
        Sat, 14 Sep 2019 05:18:32 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id m12sm2344408pff.66.2019.09.14.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 05:18:30 -0700 (PDT)
Date:   Sat, 14 Sep 2019 05:18:30 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 05:18:21 PDT (-0700)
Subject:     Re: [PATCH] riscv: modify the Image header to improve compatibility with the ARM64 header
In-Reply-To: <alpine.DEB.2.21.9999.1909132005200.24255@viisi.sifive.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, merker@debian.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-755b14c4-8f35-4079-a7ff-e421fd1b02bc@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 20:08:14 PDT (-0700), Paul Walmsley wrote:
>
> Part of the intention during the definition of the RISC-V kernel image
> header was to lay the groundwork for a future merge with the ARM64
> image header.  One error during my original review was not noticing
> that the RISC-V header's "magic" field was at a different size and
> position than the ARM64's "magic" field.  If the existing ARM64 Image
> header parsing code were to attempt to parse an existing RISC-V kernel
> image header format, it would see a magic number 0.  This is
> undesirable, since it's our intention to align as closely as possible
> with the ARM64 header format.  Another problem was that the original
> "res3" field was not being initialized correctly to zero.
>
> Address these issues by creating a 32-bit "magic2" field in the RISC-V
> header which matches the ARM64 "magic" field.  RISC-V binaries will
> store "RSC\x05" in this field.  The intention is that the use of the
> existing 64-bit "magic" field in the RISC-V header will be deprecated
> over time.  Increment the minor version number of the file format to
> indicate this change, and update the documentation accordingly.  Fix
> the assembler directives in head.S to ensure that reserved fields are
> properly zero-initialized.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Reported-by: Palmer Dabbelt <palmer@sifive.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Karsten Merker <merker@debian.org>
> ---
> Will try to get this merged before v5.3, to minimize the delta with the
> ARM64 header in the final release.
>
>  Documentation/riscv/boot-image-header.txt | 13 +++++++------
>  arch/riscv/include/asm/image.h            | 12 ++++++------
>  arch/riscv/kernel/head.S                  |  4 ++--
>  3 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.txt
> index 1b73fea23b39..14b1492f689b 100644
> --- a/Documentation/riscv/boot-image-header.txt
> +++ b/Documentation/riscv/boot-image-header.txt
> @@ -18,7 +18,7 @@ The following 64-byte header is present in decompressed Linux kernel image.
>  	u32 res1  = 0;		  /* Reserved */
>  	u64 res2  = 0;    	  /* Reserved */
>  	u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
> -	u32 res3;		  /* Reserved for additional RISC-V specific header */
> +	u32 magic2 = 0x56534905;  /* Magic number 2, little endian, "RSC\x05" */
>  	u32 res4;		  /* Reserved for PE COFF offset */
>
>  This header format is compliant with PE/COFF header and largely inspired from
> @@ -37,13 +37,14 @@ Notes:
>  	Bits 16:31 - Major version
>
>    This preserves compatibility across newer and older version of the header.
> -  The current version is defined as 0.1.
> +  The current version is defined as 0.2.
>
> -- res3 is reserved for offset to any other additional fields. This makes the
> -  header extendible in future. One example would be to accommodate ISA
> -  extension for RISC-V in future. For current version, it is set to be zero.
> +- The "magic" field is deprecated as of version 0.2.  In a future
> +  release, it may be removed.  This originally should have matched up
> +  with the ARM64 header "magic" field, but unfortunately does not.
> +  The "magic2" field replaces it, matching up with the ARM64 header.
>
> -- In current header, the flag field has only one field.
> +- In current header, the flags field has only one field.
>  	Bit 0: Kernel endianness. 1 if BE, 0 if LE.
>
>  - Image size is mandatory for boot loader to load kernel image. Booting will
> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> index ef28e106f247..344db5244547 100644
> --- a/arch/riscv/include/asm/image.h
> +++ b/arch/riscv/include/asm/image.h
> @@ -3,7 +3,8 @@
>  #ifndef __ASM_IMAGE_H
>  #define __ASM_IMAGE_H
>
> -#define RISCV_IMAGE_MAGIC	"RISCV"
> +#define RISCV_IMAGE_MAGIC	"RISCV\0\0\0"
> +#define RISCV_IMAGE_MAGIC2	"RSC\x05"
>
>  #define RISCV_IMAGE_FLAG_BE_SHIFT	0
>  #define RISCV_IMAGE_FLAG_BE_MASK	0x1
> @@ -23,7 +24,7 @@
>  #define __HEAD_FLAGS		(__HEAD_FLAG(BE))
>
>  #define RISCV_HEADER_VERSION_MAJOR 0
> -#define RISCV_HEADER_VERSION_MINOR 1
> +#define RISCV_HEADER_VERSION_MINOR 2
>
>  #define RISCV_HEADER_VERSION (RISCV_HEADER_VERSION_MAJOR << 16 | \
>  			      RISCV_HEADER_VERSION_MINOR)
> @@ -39,9 +40,8 @@
>   * @version:		version
>   * @res1:		reserved
>   * @res2:		reserved
> - * @magic:		Magic number
> - * @res3:		reserved (will be used for additional RISC-V specific
> - *			header)
> + * @magic:		Magic number (RISC-V specific; deprecated)
> + * @magic2:		Magic number 2 (to match the ARM64 'magic' field pos)
>   * @res4:		reserved (will be used for PE COFF offset)
>   *
>   * The intention is for this header format to be shared between multiple
> @@ -58,7 +58,7 @@ struct riscv_image_header {
>  	u32 res1;
>  	u64 res2;
>  	u64 magic;
> -	u32 res3;
> +	u32 magic2;
>  	u32 res4;
>  };
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 0f1ba17e476f..52eec0c1bf30 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -39,9 +39,9 @@ ENTRY(_start)
>  	.word RISCV_HEADER_VERSION
>  	.word 0
>  	.dword 0
> -	.asciz RISCV_IMAGE_MAGIC
> -	.word 0
> +	.ascii RISCV_IMAGE_MAGIC
>  	.balign 4
> +	.ascii RISCV_IMAGE_MAGIC2
>  	.word 0
>
>  .global _start_kernel

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
