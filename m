Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7116EC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE7320866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qSPBSbQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEARcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:32:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45959 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556731969; x=1588267969;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yZk+fPlM+300B5dQPeSnp2Y+5IZKCQeLUZItpCF7QKs=;
  b=qSPBSbQCTVesGBTErvl5jqUuw/sJP4NctlL3x0B3e3dpVJDXGrtfwKpb
   /LSP04PorydUtkOIqF1BPGf2/zZD9pUr+lBSKoZ3SKJoICcl+AfGAQjdY
   0flwWbdSlzzT/Au+o9eL6oHvbFii+FFXTjfMzjaKEz685efI02vnsarcB
   GyYVoUbCTMX/6gvWkbud+Sh/AOOvksMP07uYIVst7Ea8H+nhJpV6H9Vv8
   CloBQazrPWYwsFDiVLoxaM+d4XT/O0XTdRq8k8/6Yer5z/wd45975iz0z
   5pl4cdLSH3+kFCnOy85iy0etRMRng3TwVqTORNWRKk4QZr4H9UW3AZwr/
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,418,1549900800"; 
   d="scan'208";a="213198125"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2019 01:32:49 +0800
IronPort-SDR: bcBsqJ6TPAvmAq8mQCZ+WXf2tQ+lo3H8IJTwZ/Y3LUQqGQaYT5V2i/rdY0bZaR5I3aLHs/ZiCF
 z5BRn4traw92oxVtaKqIBJIF2MlNYfZ8PDnvDJSsVbmw6503vF/tEjPJZUAxXbNkTjFDLb9VEC
 PLUfWQ2QFvDhVzW+q4CgjwiXCqqgLvflulJPmEBd24kpGDPQSwodbvjOqUlKL9JFHAjbHusZYG
 sxiOahlxiWM5R5n4I844sed5Hy934I2B6adN40729omog+IouVaPZ2b454BSVgtR1FeTd5fZZo
 Md+VNJiFPpjkXLnHj5DYaFY5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 01 May 2019 10:11:17 -0700
IronPort-SDR: TxMvhl+cFQ4TxMP+d9Z7AnTy0se99146r4IxgWjHgpK+CIrayOFf2TbciER+Qlg8BZF9NdRRLB
 1MVJQBTPBXrM76Aceux1LCjr43m1XIZjTYQBU/jTvSF/YrryRNlh5k2zJgj8erGkJiJr7turG0
 okgZ36FcRDC56y+X8YVIS8vEsmgqT1PZdWjFkh0T40JonlbOkKHjrDXN7N0tID0dpxpAjv5utw
 dGgVWv/8LoU+6XeVzGf9uYQmYoogjzm8gtF5uh2aMnSdMBqzY9dvwSgkmGpQEFOSAS0MkJnPxN
 ksg=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 May 2019 10:32:48 -0700
Subject: Re: [PATCH] RISC-V: Add an Image header that boot loader can parse.
To:     Anup Patel <anup@brainfault.org>,
        Karsten Merker <merker@debian.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        "zong@andestech.com" <zong@andestech.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <mhng-cab2c6b9-f623-4286-99a4-61e4b3a58761@palmer-si-x1e>
 <e801ca8b-c8e2-d8b1-d55a-744414db77e3@wdc.com>
 <20190501164355.ce76wjmq6sszrf5g@excalibur.cnev.de>
 <CAAhSdy3kjqDahp13gQa0g9GF4gKPQeVgSakZzuP0uYwkCrvdAg@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <eca0de61-885c-0ca1-d07b-870ad0c83327@wdc.com>
Date:   Wed, 1 May 2019 10:32:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy3kjqDahp13gQa0g9GF4gKPQeVgSakZzuP0uYwkCrvdAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/19 10:02 AM, Anup Patel wrote:
> On Wed, May 1, 2019 at 10:14 PM Karsten Merker <merker@debian.org> wrote:
>>
>> On Mon, Apr 29, 2019 at 10:42:40PM -0700, Atish Patra wrote:
>>> On 4/29/19 4:40 PM, Palmer Dabbelt wrote:
>>>> On Tue, 23 Apr 2019 16:25:06 PDT (-0700), atish.patra@wdc.com wrote:
>>>>> Currently, last stage boot loaders such as U-Boot can accept only
>>>>> uImage which is an unnecessary additional step in automating boot flows.
>>>>>
>>>>> Add a simple image header that boot loaders can parse and directly
>>>>> load kernel flat Image. The existing booting methods will continue to
>>>>> work as it is.
>>>>>
>>>>> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
>>>>>
>>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>>> ---
>>>>>    arch/riscv/include/asm/image.h | 32 ++++++++++++++++++++++++++++++++
>>>>>    arch/riscv/kernel/head.S       | 28 ++++++++++++++++++++++++++++
>>>>>    2 files changed, 60 insertions(+)
>>>>>    create mode 100644 arch/riscv/include/asm/image.h
>>>>>
>>>>> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
>>>>> new file mode 100644
>>>>> index 000000000000..76a7e0d4068a
>>>>> --- /dev/null
>>>>> +++ b/arch/riscv/include/asm/image.h
>>>>> @@ -0,0 +1,32 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +
>>>>> +#ifndef __ASM_IMAGE_H
>>>>> +#define __ASM_IMAGE_H
>>>>> +
>>>>> +#define RISCV_IMAGE_MAGIC        "RISCV"
>>>>> +
>>>>> +#ifndef __ASSEMBLY__
>>>>> +/*
>>>>> + * struct riscv_image_header - riscv kernel image header
>>>>> + *
>>>>> + * @code0:               Executable code
>>>>> + * @code1:               Executable code
>>>>> + * @text_offset: Image load offset
>>>>> + * @image_size:          Effective Image size
>>>>> + * @reserved:            reserved
>>>>> + * @magic:               Magic number
>>>>> + * @reserved:            reserved
>>>>> + */
>>>>> +
>>>>> +struct riscv_image_header {
>>>>> + u32 code0;
>>>>> + u32 code1;
>>>>> + u64 text_offset;
>>>>> + u64 image_size;
>>>>> + u64 res1;
>>>>> + u64 magic;
>>>>> + u32 res2;
>>>>> + u32 res3;
>>>>> +};
>>>>
>>>> I don't want to invent our own file format.  Is there a reason we can't just
>>>> use something standard?  Off the top of my head I can think of ELF files and
>>>> multiboot.
>>>
>>> Additional header is required to accommodate PE header format. Currently,
>>> this is only used for booti command but it will be reused for EFI headers as
>>> well. Linux kernel Image can pretend as an EFI application if PE/COFF header
>>> is present. This removes the need of an explicit EFI boot loader and EFI
>>> firmware can directly load Linux (obviously after EFI stub implementation
>>> for RISC-V).
>>>
>>> ARM64 follows the similar header format as well.
>>> https://www.kernel.org/doc/Documentation/arm64/booting.txt
>>
>> Hello Atish,
>>
>> the arm64 header looks a bit different (quoted from the
>> aforementioned URL):
>>
>>    u32 code0;                    /* Executable code */
>>    u32 code1;                    /* Executable code */
>>    u64 text_offset;              /* Image load offset, little endian */
>>    u64 image_size;               /* Effective Image size, little endian */
>>    u64 flags;                    /* kernel flags, little endian */
>>    u64 res2      = 0;            /* reserved */
>>    u64 res3      = 0;            /* reserved */
>>    u64 res4      = 0;            /* reserved */
>>    u32 magic     = 0x644d5241;   /* Magic number, little endian, "ARM\x64" */
>>    u32 res5;                     /* reserved (used for PE COFF offset) */
>>
>> What I am unclear about is in which ways a RISC-V PE/COFF header
>> differs from an arm64 one as the arm64 struct is longer than your
>> RISC-V header and for arm64 the PE offset field is in the last
>> field, i.e. outside of the area covered by your RISC-V structure
>> definition.  Can you perhaps explain this part in a bit more
>> detail or does anybody else have a pointer to a specification of
>> the RISC-V PE/COFF header format (I have found a lot of documents
>> about COFF in general, but nothing specific to RISC-V).
> 

Karsten,

> The only difference compared to ARM64 is the values of code0, code1
> and res5 fields.
> 
> As-per PE/COFF, the 32bit value at offset 0x3c tells us offset of PE/COFF
> header in image.
> 
> For more details refer,
> https://en.wikipedia.org/wiki/Portable_Executable
> https://en.wikipedia.org/wiki/Portable_Executable#/media/File:Portable_Executable_32_bit_Structure_in_SVG_fixed.svg
> 
> For both ARM64 header and RISC-V image header, is actually the
> "DOS header" part of PE/COFF format.
> 
> This patch only adds "DOS header" part of PE/COFF format. Rest of
> the PE/COFF header will be added when add EFI support to Linux
> RISC-V kernel.
> I think Anup answered your question. The original plan was to add EFI 
specific stuff in EFI support patch. That includes adjusting the PE/COFF 
offset at 0x3c and adding the "MZ" value for code0 if EFI is enabled.

In hindsight, I think it created more confusion. I will update the 
"riscv_image_header" structure to put PE/COFF offset(0x3c) at right 
place in v2 patch to avoid further confusion.

"MZ" value part should be added once EFI is enabled.

I will update the comments on riscv/include/asm/image.h as well to 
clarify more.

Regards,
Atish
> Regards,
> Anup
> 

