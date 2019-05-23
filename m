Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B308C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265CD20862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c/OxFDCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfEWSh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:37:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54861 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbfEWSh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558636648; x=1590172648;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8QIT+0aut7Wn82lQsQ2WjYKeDiRhZt+FqjfsMWNxN5Y=;
  b=c/OxFDCVhYs4kqp50oHsWHZ5OEXWqwXW5umGRyTrkzq9vJSA2fqFQ/BC
   55XqU50gzllANZH+c7lYzc2IK2/uPbfNTxSdlxVF+hrYLvZV5tT9Fkxeg
   zJkkL5smhC+xMuTCX81pbI0U0j7C5ZpyZ3/03ODmjevFJW54CK5Y1ght9
   sU/P730Ke0CIqdFPEaLNBiKilzzDx/Z4bX+62MKffOcqTdcy+5Bi4MfmI
   JQo7fQwg4lu9J3ozD9BGh5F6PFBzxB550+mLdfz58NYPuv5BwuolFxCnL
   ouuERvDnlOdoNU4Wx/YelC1WJNFRhh6taIssd7Ydd0G++zT/IYj5mmpzx
   A==;
X-IronPort-AV: E=Sophos;i="5.60,504,1549900800"; 
   d="scan'208";a="215158254"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2019 02:37:28 +0800
IronPort-SDR: uGlon4knx3kkjIMFxFJR3vbHtzmsKbXddVk0qsEsRWE9NMNLsPzG0fmOG3VOwEcr6H/7/oqYLQ
 wVxGhS9cbhVH+EZhF9JGPs5LiIPP6UtcHbOdRRCfywqRPe8bsphnLKQ8Aw66PC/qKaKBSv2Sne
 o3Q5qwEvVmPZzJ0TPIknrR94h3lAA0SAsFSntjE2YMYTbPeHiKupVwL3lIIeRK2/vsUssZClDu
 O38nM1j+W1KZ4qpfN6vnHjja+41PXSV1Kt4DM9C2cRgiIX1gexG8L5Nar6qXd3QRmslxfKufHA
 ONPJ6oIW0J0ZLf5/EkdKAHA3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 May 2019 11:15:10 -0700
IronPort-SDR: ajAzHRDa3jUJcUe5cu+C+1Nzl8QYEVIiIgfvZAwvBO049k6tdw0TlqstrIfn7GT+2sanocP4jV
 adoMnK1YJeS8Qek3B1hsPcMxp7rA+zXiV2RPjj3qoT/vJYPKr40RUlf9vJiz2eM1wnCmAJNOib
 iSiBrJTyQ7Oz/ueOfZ+90aVsnv85jAGNrTpetNoZqWVn399qXJ/ew9kT591E9DVb2HfmeVvxep
 pyyoPDJwSddBWcRyeYrmuBMfbIQz9Oz4kekHPXLj62q/q9k8AST+VLpYHgSFXYMszouJbFqDtJ
 /ZE=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 May 2019 11:37:28 -0700
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "trini@konsulko.com" <trini@konsulko.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "merker@debian.org" <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190501195607.32553-1-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1905131522370.21198@viisi.sifive.com>
 <a498967c-cdc8-637a-340b-202d216c5360@wdc.com>
 <alpine.DEB.2.21.9999.1905131704371.21198@viisi.sifive.com>
 <a3eb8e32-5344-801e-03ef-98107ed13130@wdc.com>
 <alpine.DEB.2.21.9999.1905131735450.21198@viisi.sifive.com>
 <bb7f36bd-d614-b235-7100-3d965f92afc8@wdc.com>
 <alpine.DEB.2.21.9999.1905160833030.9104@viisi.sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <d7ef1d58-2c3f-ef58-b6aa-bb7ccfe162f6@wdc.com>
Date:   Thu, 23 May 2019 11:35:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1905160833030.9104@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/19 9:20 AM, Paul Walmsley wrote:
> + ARM64 maintainers, Tom, Marek
> 
> Hi Atish,
> 
> On Mon, 13 May 2019, Atish Patra wrote:
> 
>> On 5/13/19 5:40 PM, Paul Walmsley wrote:
>>> On Mon, 13 May 2019, Atish Patra wrote:
>>>> On 5/13/19 5:09 PM, Paul Walmsley wrote:
>>>>
>>>>> What are the semantics of those reserved fields?
>>>>
>>>> +struct riscv_image_header {
>>>> +	u32 code0;
>>>> +	u32 code1;
>>>> +	u64 text_offset;
>>>> +	u64 image_size;
>>>> +	u64 res1;
>>>> +	u64 res2;
>>>> +	u64 res3;
>>>> +	u64 magic;
>>>> +	u32 res4; ---> We can use this for versioning when required
>>>> +	u32 res5; ---> This is reserved for PE/COFF header
>>>> +};
>>>
>>> I saw that in your patch.  The problem is that this doesn't describe what
>>> other software might expect in those fields.  Can anything at all be
>>> placed in those reserved fields?
>>
>> Yes. The reserved fields can be used for anything that boot loaders and Linux
>> kernel can agree with each other. If you look at the ARM64, they have
>> "Informative flags" in place of res1.
>>
>>>>>> Do we need to add it now or add it later when we actually need a
>>>>>> version
>>>>>> number. My preference is to add it later based on requirement.
>>>>>
>>>>> If it isn't added now, how would bootloaders know whether it was there
>>>>> or
>>>>> not?
>>>>>
>>>>>
>>>> Here is the corresponding U-Boot Patch
>>>> https://patchwork.ozlabs.org/patch/1096087/
>>>>
>>>> Currently, boot loader doesn't care about versioning. Since we are
>>>> updating a
>>>> reserved field, offsets will not change. If a boot loader want to use the
>>>> versioning, it should be patched along with the kernel patch.
>>>>
>>>> Any other boot loader that doesn't care about the version, it can continue
>>>> to
>>>> do so without any change.
>>>>
>>>> My idea is to enable the minimum required fields in this patch and keep
>>>> everything else as reserved so that it can be amended in future as
>>>> required.
>>>
>>> If those fields really are reserved for implementors to do whatever they
>>> want with them, then that might be a reasonable approach.  That seems
>>> unlikely, however, since specification authors usually reserve the right
>>> to use reserved fields for their own purposes in later versions.
>>>
>> Technically, we are just implementing the "DOS" header part of PE/COFF format
>> for now. It only mandates a magic string "MZ" at the top and a 32bit value at
>> offset 0x3c tells us offset of PE/COFF header in image.
>> Anything in between is implementation specific.
>>
>> For example, it will be updated to support EFI stub as described in the commit
>> text,
>> "In order to support EFI stub, code0 should be replaced with "MZ" magic string
>> and res5(at offset 0x3c) should point to the rest of the PE/COFF header (which
>> will be added during EFI support)."
> 
> OK.  I think we should try to share this header format with other
> architectures.  This one after all is copied from ARM64, and some of the
> core fields will be the same across multiple architectures.  That way we
> can try to avoid proliferating different boot header formats for each
> architecture, which should be better for both the kernel and the
> bootloaders.  ARM64 folks, would you be interested in working together on
> this?
> 
> Meanwhile, to unblock RISC-V, and to make this header durable for future
> extensions and to match the existing ARM64 usage, I think we should make
> the following technical changes to what you proposed:
> 
> 1. Reserve all of the existing ARM64 fields in the same way ARM64 does
>     now.  This keeps open the possibility that we can merge this format
>     with the one used with ARM64, and reuse the same bootloader code.
>     Based on our discussions, it sounds like the primary difference between
>     what you're proposing and the ARM64 format involves the flags/res1
>     field.  Let's keep that as a flag field, reuse ARM64's endianness bit
>     as architecture-independent, then define the rest of the flags in that
>     field as architecture-defined.
> 
> 2. Allocate another set of reserved bits for a format version number.
>     Probably 16 bits is sufficient.  This tells bootloaders how to
>     interpret the header fields in future extensions.  The goal is to
>     preserve compatibility across newer and older versions of the header.
>     The existing ARM64 header would be version 0.  This format that
>     incorporates these changes would be version 1.  The thought here is to
>     preserve all of the semantics of existing fields in newer versions
>     (except for any remaining reserved fields), since many people often do
>     not replace their bootloaders.
> 
> 3. Define a way to point to additional fields outside this existing
>     header.  Another 32 bits of previously reserved data can be defined as
>     a file offset to additional fields (defined as 32-bit words from the
>     beginning of the header).  This should make it technically simple to
>     add additional fields in the future.  For example, RISC-V, and probably
>     other architectures, will want to add some way to indicate which ISA
>     extensions are necessary to run the kernel image.  Right now there
>     won't be any fields defined, so we can leave the format undefined for
>     the moment also.  Let's stipulate for version 1 that this field
>     should be fixed at 0, indicating no additional fields.
> 
> 4. Document all of this, in this patch, in a file such as
>     Documentation/riscv/boot-image-header.txt.  If
>     we're able to reach agreement with other maintainers, then we
>     can move this file out into a common, non-architecture-specific
>     documentation location.
> 

I have sent out a v3 incorporating most of your suggestions. If ARM 
maintainers agree, we can move both the headers to a common place.

Just FYI: Marek also suggested to add unified support Image.gz for both 
U-Boot & RISC-V in U-Boot. I am working on that as well.

> 
> thanks
> 
> - Paul
> 


-- 
Regards,
Atish
