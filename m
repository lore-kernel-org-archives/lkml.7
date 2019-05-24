Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ED3C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA69217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ntHSjLfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbfEXAS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:18:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58755 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387613AbfEXAS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558657137; x=1590193137;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ImIkpNHYF0Ct8KzO+o8Rh3uJJvhTTU8y01lvKWVjfUQ=;
  b=ntHSjLfm7nJ5BLrAwP8e4LBHHNF+xvsetmGLJ3q0mZ9vxS6Kury/4KOn
   haSmgYfl6NV8R7D2qMcXuQ8Hxk8TX92X4aV0L6kTrzSVCuk3avoiGJDLC
   R+nY8OD8TH2AkZyGbW9HHRNL5ycC5yMObJiKA835VhaNvK94XrnXi5BQJ
   GmeK5xTvH+PkmxN0lbvy42YMswWMJDsnYyT0JRpFOtR5y/F3FIEC4GNY2
   ZQFFPdpoAKA7AoopJD8kEg1lbu+YcamRSMKBFjJNDJtxySiBshMPx5oiu
   H7oJ/lcjWTm2CBlAt0oQscbkMyQJBAU2aRLUVZ6GH9jPQk40wXcJVctPR
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,505,1549900800"; 
   d="scan'208";a="215178908"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2019 08:18:56 +0800
IronPort-SDR: jyn18bmUhLx8X2ccilAOYjqyyNNa9eKHwJgD0WjNJmQ+QZFuP+kDvpaLS/xBt/YT57Y6Nqy+pT
 +8/jtXUonQDg6PzYV5jaDn0m743Vfvhc95qAtofPNoW/hRFnsT/LnC++QAVYO9wqyFQT2sERng
 HtBboW3KXPsVV159nC9ZVk1I6pUNSTzbM6UaifKdg/gDkpb6b9cyc1SLhVohw4piHXLXs9q3F7
 ZZhAX4qL3XXQgsdIz5pW/O3H1e9uTuRncKw6ECk9cD+cTwjFXk+ZAgotXy4g6Mq2ns0sk693BE
 F+KRxlfZxTpsDtM0ql2tmWVI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 May 2019 16:56:38 -0700
IronPort-SDR: dC4C+3IRY1AbcFS0UI5Dh85SSrRXqNj1vbn83BlLK75czoZ6Sc8YEOjlBI/5DhXv1jVz4sMMpg
 iDpyFXFmV2P40WpixvL5yyKQuRNdb0tsa00GLsyzsSqoldnUYSELR0taRHjdDQvhvslSnG7L6Y
 ri11Bhq0QESS81qmPpkqmhMK+uQGXlrQOfQ/15l/Nu2oWR9lCKm+3Rb+lbSnuUu8B6QF2Mi8Ac
 /2RNzueRmuBDaWqQBdstNpm9hkhmiZp3YqPknC/CsGwsP8M5+YQSr8sTOdgvdl+VWQxF+ndVp/
 Guo=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 May 2019 17:18:56 -0700
Subject: Re: [v3 PATCH] RISC-V: Add a PE/COFF compliant Image header.
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Will Deacon <will.deacon@arm.com>,
        Zong Li <zong@andestech.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Tom Rini <trini@konsulko.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190523183516.583-1-atish.patra@wdc.com>
 <CAKv+Gu9VnjtgdkqfJJ1qQQ0W=z+uYN9Y-1n3Md3tV+d6a63wZA@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <439bf2f0-785b-ac52-8116-63e2e82bc179@wdc.com>
Date:   Thu, 23 May 2019 17:16:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9VnjtgdkqfJJ1qQQ0W=z+uYN9Y-1n3Md3tV+d6a63wZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 2:09 PM, Ard Biesheuvel wrote:
> On Thu, 23 May 2019 at 19:35, Atish Patra <atish.patra@wdc.com> wrote:
>>
>> Currently, last stage boot loaders such as U-Boot can accept only
>> uImage which is an unnecessary additional step in automating boot flows.
>>
>> Add a PE/COFF compliant image header that boot loaders can parse and
>> directly load kernel flat Image. The existing booting methods will continue
>> to work as it is.
>>
> 
> This statement does not make sense. This patch does not implement a
> single one of the various elements that make up a valid PE/COFF
> header.
> 

Probably "compliant" is not the correct word. I meant to say that
PE/COFF header can be implemented in future with this header.


> The arm64 Image header has been designed in a way so that it can
> co-exist with a PE/COFF header in the same image, and this is what

Correct. "co-exist" is much better than "compliant"

Sorry for the choosing ambiguous words. I will update the commit text in 
next version.

> this patch duplicates. The arm64 Image header has nothing to do with
> PE/COFF.
> 
> A PE/COFF executable header consists of
> - the letters MZ at offset 0x0 (the MS-DOS header)
> - the offset to the PE header at offset 0x3c
> - the characters PE\0\0 at the offset mentioned above, followed by the
> standard COFF header fields
> - a PE32 or PE32+ (depending on the bitness) optional* header,
> followed by a set of section headers.
> 
> 
> 
> 
>> Another goal of this header is to support EFI stub for RISC-V in future.
>> EFI specification needs PE/COFF image header in the beginning of the kernel
>> image in order to load it as an EFI application. In order to support
>> EFI stub, code0 should be replaced with "MZ" magic string and res5(at
>> offset 0x3c) should point to the rest of the PE/COFF header (which will
>> be added during EFI support).
>>
>> This patch is based on ARM64 boot image header and provides an opprtunity
>> to combine both ARM64 & RISC-V image headers.
>>
>> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>
>> ---
>> I have not sent out corresponding U-Boot patch as all the changes are
>> compatible with current u-boot support. Once, the kernel header format
>> is agreed upon, I will update the U-Boot patch.
>>
>> Changes from v2->v3
>> 1. Modified reserved fields to define a header version.
>> 2. Added header documentation.
>>
>> Changes from v1-v2:
>> 1. Added additional reserved elements to make it fully PE compatible.
>> ---
>>   Documentation/riscv/boot-image-header.txt | 50 ++++++++++++++++++
>>   arch/riscv/include/asm/image.h            | 64 +++++++++++++++++++++++
>>   arch/riscv/kernel/head.S                  | 32 ++++++++++++
>>   3 files changed, 146 insertions(+)
>>   create mode 100644 Documentation/riscv/boot-image-header.txt
>>   create mode 100644 arch/riscv/include/asm/image.h
>>
>> diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.txt
>> new file mode 100644
>> index 000000000000..68abc2353cec
>> --- /dev/null
>> +++ b/Documentation/riscv/boot-image-header.txt
>> @@ -0,0 +1,50 @@
>> +                               Boot image header in RISC-V Linux
>> +                       =============================================
>> +
>> +Author: Atish Patra <atish.patra@wdc.com>
>> +Date  : 20 May 2019
>> +
>> +This document only describes the boot image header details for RISC-V Linux.
>> +The complete booting guide will be available at Documentation/riscv/booting.txt.
>> +
>> +The following 64-byte header is present in decompressed Linux kernel image.
>> +
>> +       u32 code0;                /* Executable code */
>> +       u32 code1;                /* Executable code */
>> +       u64 text_offset;          /* Image load offset, little endian */
>> +       u64 image_size;           /* Effective Image size, little endian */
>> +       u64 flags;                /* kernel flags, little endian */
>> +       u32 version;              /* Version of this header */
>> +       u32 res1  = 0;            /* Reserved */
>> +       u64 res2  = 0;            /* Reserved */
>> +       u64 magic = 0x5643534952; /* Magic number, little endian, "RISCV" */
>> +       u32 res3;                 /* Reserved for additional RISC-V specific header */
>> +       u32 res4;                 /* Reserved for PE COFF offset */
>> +
>> +This header format is compliant with PE/COFF header and largely inspired from
>> +ARM64 header. Thus, both ARM64 & RISC-V header can be combined into one common
>> +header in future.
>> +
>> +Notes:
>> +- This header can also be reused to support EFI stub for RISC-V in future. EFI
>> +  specification needs PE/COFF image header in the beginning of the kernel image
>> +  in order to load it as an EFI application. In order to support EFI stub,
>> +  code0 should be replaced with "MZ" magic string and res5(at offset 0x3c) should
>> +  point to the rest of the PE/COFF header.
>> +
>> +- version field indicate header version number.
>> +       Bits 0:15  - Minor version
>> +       Bits 16:31 - Major version
>> +
>> +  This preserves compatibility across newer and older version of the header.
>> +  The current version is defined as 0.1.
>> +
>> +- res3 is reserved for offset to any other additional fields. This makes the
>> +  header extendible in future. One example would be to accommodate ISA
>> +  extension for RISC-V in future. For current version, it is set to be zero.
>> +
>> +- In current header, the flag field has only one field.
>> +       Bit 0: Kernel endianness. 1 if BE, 0 if LE.
>> +
>> +- Image size is mandatory for boot loader to load kernel image. Booting will
>> +  fail otherwise.
>> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
>> new file mode 100644
>> index 000000000000..61c9f20d2f19
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/image.h
>> @@ -0,0 +1,64 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __ASM_IMAGE_H
>> +#define __ASM_IMAGE_H
>> +
>> +#define RISCV_IMAGE_MAGIC      "RISCV"
>> +
>> +
>> +#define RISCV_IMAGE_FLAG_BE_SHIFT      0
>> +#define RISCV_IMAGE_FLAG_BE_MASK       0x1
>> +
>> +#define RISCV_IMAGE_FLAG_LE            0
>> +#define RISCV_IMAGE_FLAG_BE            1
>> +
>> +
>> +#ifdef CONFIG_CPU_BIG_ENDIAN
>> +#define __HEAD_FLAG_BE         RISCV_IMAGE_FLAG_BE
>> +#else
>> +#define __HEAD_FLAG_BE         RISCV_IMAGE_FLAG_LE
>> +#endif
>> +
>> +#define __HEAD_FLAG(field)     (__HEAD_FLAG_##field << \
>> +                               RISCV_IMAGE_FLAG_##field##_SHIFT)
>> +
>> +#define __HEAD_FLAGS           (__HEAD_FLAG(BE))
>> +
>> +#define RISCV_HEADER_VERSION_MAJOR 0
>> +#define RISCV_HEADER_VERSION_MINOR 1
>> +
>> +#define RISCV_HEADER_VERSION (RISCV_HEADER_VERSION_MAJOR << 16 | \
>> +                             RISCV_HEADER_VERSION_MINOR)
>> +
>> +#ifndef __ASSEMBLY__
>> +/*
>> + * struct riscv_image_header - riscv kernel image header
>> + *
>> + * @code0:             Executable code
>> + * @code1:             Executable code
>> + * @text_offset:       Image load offset
>> + * @image_size:                Effective Image size
>> + * @flags:             kernel flags
>> + * @version:           version
>> + * @reserved:          reserved
>> + * @reserved:          reserved
>> + * @magic:             Magic number
>> + * @reserved:          reserved (will be used for additional RISC-V specific header)
>> + * @reserved:          reserved (will be used for PE COFF offset)
>> + */
>> +
>> +struct riscv_image_header {
>> +       u32 code0;
>> +       u32 code1;
>> +       u64 text_offset;
>> +       u64 image_size;
>> +       u64 flags;
>> +       u32 version;
>> +       u32 res1;
>> +       u64 res2;
>> +       u64 magic;
>> +       u32 res3;
>> +       u32 res4;
>> +};
>> +#endif /* __ASSEMBLY__ */
>> +#endif /* __ASM_IMAGE_H */
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index 370c66ce187a..577893bb150d 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -19,9 +19,41 @@
>>   #include <asm/thread_info.h>
>>   #include <asm/page.h>
>>   #include <asm/csr.h>
>> +#include <asm/image.h>
>>
>>   __INIT
>>   ENTRY(_start)
>> +       /*
>> +        * Image header expected by Linux boot-loaders. The image header data
>> +        * structure is described in asm/image.h.
>> +        * Do not modify it without modifying the structure and all bootloaders
>> +        * that expects this header format!!
>> +        */
>> +       /* jump to start kernel */
>> +       j _start_kernel
>> +       /* reserved */
>> +       .word 0
>> +       .balign 8
>> +#if __riscv_xlen == 64
>> +       /* Image load offset(2MB) from start of RAM */
>> +       .dword 0x200000
>> +#else
>> +       /* Image load offset(4MB) from start of RAM */
>> +       .dword 0x400000
>> +#endif
>> +       /* Effective size of kernel image */
>> +       .dword _end - _start
>> +       .dword __HEAD_FLAGS
>> +       .word RISCV_HEADER_VERSION
>> +       .word 0
>> +       .dword 0
>> +       .asciz RISCV_IMAGE_MAGIC
>> +       .word 0
>> +       .balign 4
>> +       .word 0
>> +
>> +.global _start_kernel
>> +_start_kernel:
>>          /* Mask all interrupts */
>>          csrw CSR_SIE, zero
>>          csrw CSR_SIP, zero
>> --
>> 2.21.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Regards,
Atish
