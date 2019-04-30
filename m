Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B245BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B8220835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P6GBxCHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfD3Fmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:42:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28928 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3Fmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556602963; x=1588138963;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=icCQ5QcGcJ4fUqa/g5O0u92H78pigrgOEwz0dvW4e+Q=;
  b=P6GBxCHwxynXZ77vHyILRWJNUiHo/U8W4DcimvBL0RCQJ4dfTdjiGZxq
   QBKsOJJVE+T2TttcsWDB1Ef2iNrqHycyg5pIjCHfJiqMY+SHeO1Nkpp8d
   kpmOsEzKO2Vw48ZmEySFV9qXY+V3kfz6j/Sdan979xTigkaqOuSTo3lCz
   xFOG2zALYJNrAGc3bhhObi3FRe65bqlTby1Xk3LZNLuMLsOnrObA2/7xo
   nYv254hS2OycEj1U0AtFsD84TPyugXoPNr0mHVafc4hbXTWGU2FQwipHu
   4H0nKrMAFZ7uBIP2BTc2ataimukgEMPbHBDwCOf1EJOGuI0l4Cpa2giWD
   A==;
X-IronPort-AV: E=Sophos;i="5.60,412,1549900800"; 
   d="scan'208";a="108347304"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 13:42:43 +0800
IronPort-SDR: YzChcXQeOMBNwjy31CNYlgax80lBkSj3zE0euia3aO53bauJUmcqpArxqxL1pvh/ltGdnk4uGt
 p4CqwVfuRjRrOPB+diVSN8FkpBjqgK2GM9ZPMyK3F++g1KNv5zJA9Nqertew0mWzQ8SIDoqbi7
 uKDFxQl6y4pNSUhqSywUczQYpXhFypvXfO5+zgVqE60yuhxtDD34KsfltdfWowHgmyPyoZaNC1
 g8rU+84Cnsy3BhQWMpqZCXUEmtKjtmp+QpQiGeOg2CLAcSEWPrfUnnHmSyQmWeFAeSFuKFZ410
 77/GMOMGrPQ36oA/6lXjsepV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Apr 2019 22:21:12 -0700
IronPort-SDR: iwn4Qx9aN3SG3WBp4onocm0L4067aRcGNHeGzgX4BQpvywNVkWTTrKm4DEzRLJ6g0loN35eShf
 ubO+urfAyNApiRUftSz/0pasxtkStZQNHRuwBEzWQjgIjgEUCtpMCtG9m0V/SomM8hx61ShJXx
 7SMw+X2hsTP7GQ9u+l/2rST71lI5d2gXrDPKVSZLsGA6unsmsCsElqEAKC7+gYjpsTwR+OyFmm
 cHb+c59vUf5s2HZswwAWhLnnOy3+ed3HhJf5FdTJ1ztiDbYg4Vcp5yKaBIRoP/ztTp6Cgu4mCd
 qqg=
Received: from ind005306.ad.shared (HELO [10.86.55.35]) ([10.86.55.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Apr 2019 22:42:41 -0700
Subject: Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zong@andestech.com" <zong@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com>
Date:   Mon, 29 Apr 2019 22:42:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/19 4:40 PM, Palmer Dabbelt wrote:
> On Tue, 23 Apr 2019 16:25:06 PDT (-0700), atish.patra@wdc.com wrote:
>> Currently, last stage boot loaders such as U-Boot can accept only
>> uImage which is an unnecessary additional step in automating boot flows.
>>
>> Add a simple image header that boot loaders can parse and directly
>> load kernel flat Image. The existing booting methods will continue to
>> work as it is.
>>
>> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/include/asm/image.h | 32 ++++++++++++++++++++++++++++++++
>>   arch/riscv/kernel/head.S       | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 60 insertions(+)
>>   create mode 100644 arch/riscv/include/asm/image.h
>>
>> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
>> new file mode 100644
>> index 000000000000..76a7e0d4068a
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/image.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __ASM_IMAGE_H
>> +#define __ASM_IMAGE_H
>> +
>> +#define RISCV_IMAGE_MAGIC	"RISCV"
>> +
>> +#ifndef __ASSEMBLY__
>> +/*
>> + * struct riscv_image_header - riscv kernel image header
>> + *
>> + * @code0:		Executable code
>> + * @code1:		Executable code
>> + * @text_offset:	Image load offset
>> + * @image_size:		Effective Image size
>> + * @reserved:		reserved
>> + * @magic:		Magic number
>> + * @reserved:		reserved
>> + */
>> +
>> +struct riscv_image_header {
>> +	u32 code0;
>> +	u32 code1;
>> +	u64 text_offset;
>> +	u64 image_size;
>> +	u64 res1;
>> +	u64 magic;
>> +	u32 res2;
>> +	u32 res3;
>> +};
> 
> I don't want to invent our own file format.  Is there a reason we can't just
> use something standard?  Off the top of my head I can think of ELF files and
> multiboot.
> 

Additional header is required to accommodate PE header format. 
Currently, this is only used for booti command but it will be reused for 
EFI headers as well. Linux kernel Image can pretend as an EFI 
application if PE/COFF header is present. This removes the need of an 
explicit EFI boot loader and EFI firmware can directly load Linux 
(obviously after EFI stub implementation for RISC-V).

ARM64 follows the similar header format as well.
https://www.kernel.org/doc/Documentation/arm64/booting.txt

Regards,
Atish

>> +#endif /* __ASSEMBLY__ */
>> +#endif /* __ASM_IMAGE_H */
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index fe884cd69abd..154647395601 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -19,9 +19,37 @@
>>   #include <asm/thread_info.h>
>>   #include <asm/page.h>
>>   #include <asm/csr.h>
>> +#include <asm/image.h>
>>
>>   __INIT
>>   ENTRY(_start)
>> +	/*
>> +	 * Image header expected by Linux boot-loaders. The image header data
>> +	 * structure is described in asm/image.h.
>> +	 * Do not modify it without modifying the structure and all bootloaders
>> +	 * that expects this header format!!
>> +	 */
>> +	/* jump to start kernel */
>> +	j _start_kernel
>> +	/* reserved */
>> +	.word 0
>> +	.balign 8
>> +#if __riscv_xlen == 64
>> +	/* Image load offset(2MB) from start of RAM */
>> +	.dword 0x200000
>> +#else
>> +	/* Image load offset(4MB) from start of RAM */
>> +	.dword 0x400000
>> +#endif
>> +	/* Effective size of kernel image */
>> +	.dword _end - _start
>> +	.dword 0
>> +	.asciz RISCV_IMAGE_MAGIC
>> +	.word 0
>> +	.word 0
>> +
>> +.global _start_kernel
>> +_start_kernel:
>>   	/* Mask all interrupts */
>>   	csrw sie, zero
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

