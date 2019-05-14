Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100BEC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB5C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UtGNfic0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfENBNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 21:13:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52210 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfENBNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 21:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557796425; x=1589332425;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9juYBFVf8mf5TEwXUaUtYjhsarFThNrJb5xpCA/IsEg=;
  b=UtGNfic0LmwzjPqecXiFSt7YRRCq0f9l+0frpaOWS7AvbEIPFOcjqBZa
   s+MOhgwOdAX4xI68dZZyN4HSno/0YTilhUqdWgj8j2+/9Hcjkc0hoa2HZ
   jUCQPoMGEdIp3cRpCzVa/bmXFC07fmoFT4ShNkt8pOnivZjdLKnoMpKsB
   py5l7u9+HApdCaYMU3UwU/fwkBpmgHvTs+GfNxB/A7Lolvvzkv5kzrbsP
   3Taf6cOxbFIQstP91AWcqPQnfYzL4KyGX/+hY6LxLAX78OtBr8dsM+2Ex
   +jkTnaXsR0uWGx/63cke99wsl2oUhv+rsPOmxcb1uXWbVZk+1Py6c+gHW
   g==;
X-IronPort-AV: E=Sophos;i="5.60,466,1549900800"; 
   d="scan'208";a="109896839"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2019 09:13:45 +0800
IronPort-SDR: LZhlKZIA2nsZmbR8razyowA5bu1ucesgd8MDs7rKvFpZ03ykrx/K3U/YHBrJ/XEpRTbbeAPldw
 Sa68UbK7ZFSXks11yxYvuPciA99bNIOy9O2wPche1rWEAjw3L+3b31E24iJEwuL7Ij4jAE7jPq
 V9UwQo/Mr6s/Jc+gteCrPUp1NsGBXV0Y+nfLpMgDXS/Joa66KgjviqDjiITR4pzrYa+k9hG+gV
 EIMSQNzdqRCTy2hpOLSErs8xOSmIRnDySxigV/xDia2fKa68ouxLqFXU5d5Qg2TssMUq3Xx49/
 pOhT8ls/xT6ly1vmGz+UsKY8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 13 May 2019 17:49:33 -0700
IronPort-SDR: HcXY/XiTpNoPEGl3/L36Kj61w+k9Fsmhxa7gOB3KR/MKq82AZS48PbNFH1aTLLXk6+6OujlaRl
 K2vruz1Z49Bk6paXXUzN+n6iKiwnSchwxSNheFJIgET9CQpQbtyshbUJ/OeY9cvu+Tqd4NhJCr
 HiWA3SWEtSPYGjMARX6BP3nGAKSquZeUcKVX0Bztix+1KTAb2Di7ZvgE1wUkFX6RxTMaURMygQ
 pEj6cX+RwVOPZ1PhQU+LB/ZWvOM2pmvPvpQTiyaKPKbvvuP3AYwbsRcoOrXi9gubV3HcHJWWZR
 mA8=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 May 2019 18:13:44 -0700
From:   Atish Patra <atish.patra@wdc.com>
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "merker@debian.org" <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190501195607.32553-1-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1905131522370.21198@viisi.sifive.com>
 <a498967c-cdc8-637a-340b-202d216c5360@wdc.com>
 <alpine.DEB.2.21.9999.1905131704371.21198@viisi.sifive.com>
 <a3eb8e32-5344-801e-03ef-98107ed13130@wdc.com>
 <alpine.DEB.2.21.9999.1905131735450.21198@viisi.sifive.com>
Message-ID: <bb7f36bd-d614-b235-7100-3d965f92afc8@wdc.com>
Date:   Mon, 13 May 2019 18:13:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1905131735450.21198@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/19 5:40 PM, Paul Walmsley wrote:
> On Mon, 13 May 2019, Atish Patra wrote:
> 
>> On 5/13/19 5:09 PM, Paul Walmsley wrote:
>>
>>> What are the semantics of those reserved fields?
>>
>> +struct riscv_image_header {
>> +	u32 code0;
>> +	u32 code1;
>> +	u64 text_offset;
>> +	u64 image_size;
>> +	u64 res1;
>> +	u64 res2;
>> +	u64 res3;
>> +	u64 magic;
>> +	u32 res4; ---> We can use this for versioning when required
>> +	u32 res5; ---> This is reserved for PE/COFF header
>> +};
> 
> I saw that in your patch.  The problem is that this doesn't describe what
> other software might expect in those fields.  Can anything at all be
> placed in those reserved fields?
> 

Yes. The reserved fields can be used for anything that boot loaders and 
Linux kernel can agree with each other. If you look at the ARM64, they 
have "Informative flags" in place of res1.

>>>> Do we need to add it now or add it later when we actually need a version
>>>> number. My preference is to add it later based on requirement.
>>>
>>> If it isn't added now, how would bootloaders know whether it was there or
>>> not?
>>>
>>>
>> Here is the corresponding U-Boot Patch
>> https://patchwork.ozlabs.org/patch/1096087/
>>
>> Currently, boot loader doesn't care about versioning. Since we are updating a
>> reserved field, offsets will not change. If a boot loader want to use the
>> versioning, it should be patched along with the kernel patch.
>>
>> Any other boot loader that doesn't care about the version, it can continue to
>> do so without any change.
>>
>> My idea is to enable the minimum required fields in this patch and keep
>> everything else as reserved so that it can be amended in future as required.
> 
> If those fields really are reserved for implementors to do whatever they
> want with them, then that might be a reasonable approach.  That seems
> unlikely, however, since specification authors usually reserve the right
> to use reserved fields for their own purposes in later versions.
> 
Technically, we are just implementing the "DOS" header part of PE/COFF 
format for now. It only mandates a magic string "MZ" at the top and a 
32bit value at offset 0x3c tells us offset of PE/COFF header in image.
Anything in between is implementation specific.

For example, it will be updated to support EFI stub as described in the 
commit text,
"In order to support EFI stub, code0 should be replaced with "MZ" magic 
string and res5(at offset 0x3c) should point to the rest of the PE/COFF 
header (which will be added during EFI support)."

Regards,
Atish
> 
> - Paul
> 


