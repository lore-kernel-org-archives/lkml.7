Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA71C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1716F217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j4LwZHZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfENAe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:34:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28044 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENAe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557794069; x=1589330069;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hcwoqPysi4qOOtoOdHq/C9QLVupOGpA2wAtr9OvfuXM=;
  b=j4LwZHZTBpEGA0d9F+UREc+79rcRWqSElLhIay5ihVRHdbCVmloux/g0
   sepe85CAkcdJfAFSR+7ptzujoiiTBJDvdphMU+IeV0NJcac/Bs7EhcEVz
   +u6tHX/gm+RYyFV6+aFAoxvhmf4iSNOsfttupZEEqRmvnRvd2jh6GNahL
   W86V8d3EC4tgM8Uhyj7ztO22XyMqcMv5JK+futaOkOIXIBEqwjmjDdbfq
   37ubGF1KQMylPI6JNNqQOy3Ds+7me96oqB+v+N7p5jSbLY0js5RfFSqhO
   1vheYiGH4uEXuSF9eHeOZ8KiZpwVZwoYWX+O+PHtoXXe6PZSML998vsr2
   g==;
X-IronPort-AV: E=Sophos;i="5.60,466,1549900800"; 
   d="scan'208";a="109894483"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2019 08:34:28 +0800
IronPort-SDR: lpOjThPpKxW/k35pRGty7Tl0sofV2Z1IRIW0I0YPnONlsR1JEsrWdfyCBd60FuNTHZqJ3h+md9
 9seY66HFWnUUXEO2a1IGe02X4mzmTmMn3OkQDkYUJdTXIDyGgNiDcfSxz/aqr76AFNFjlT8ptC
 QzAl+1LlAz1KoZGy8cIGgHnaIfhK6FPu/yunXXJDm+NNI1POhez5uBSn1Sk5NxupSAPBBSCGQN
 kzhKT20NRgqOkf0UlRgs+GeIKFCkDi2tzrTsVejGdGL7ZYLzVvixxUvzoblziZsn2d7RDIOVK6
 c1GZdPe7Uqn+NTGbcVxKqxhq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 May 2019 17:12:29 -0700
IronPort-SDR: bOLMMhaA1pkyxX2AH6+QTnZdf5SR/QsaycF28yjHsRYBGL3gLc73gEXm8qIHbrVVKKfJxUB8i3
 T3YUSTs3kjRb5Zva8q2MgzAOyjMpXKgnTsYe8tww8VZexrZndUdBuu+A/Udj8R1U9RP0GX9Rb7
 X2uK7E5n89tEwHXZW784M0WVAUmC2M9YyZEMvydqp5HUNg8r1RG20Nc4XD/xjMdEt8hQbA++Me
 p+0ZQyc2z7o0kPoZ7OCMCyEhM/6ra+LF3vUznZBbfoDV4TW1wxTprQZ/kY3+1VZ1oNTEi1ZcXH
 uMw=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 May 2019 17:34:28 -0700
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
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <a3eb8e32-5344-801e-03ef-98107ed13130@wdc.com>
Date:   Mon, 13 May 2019 17:34:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1905131704371.21198@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/19 5:09 PM, Paul Walmsley wrote:
> On Mon, 13 May 2019, Atish Patra wrote:
> 
>> On 5/13/19 3:31 PM, Paul Walmsley wrote:
>>> On Wed, 1 May 2019, Atish Patra wrote:
>>>
>>>> Currently, last stage boot loaders such as U-Boot can accept only
>>>> uImage which is an unnecessary additional step in automating boot flows.
>>>>
>>>> Add a PE/COFF compliant image header that boot loaders can parse and
>>>> directly load kernel flat Image. The existing booting methods will
>>>> continue
>>>> to work as it is.
>>>>
>>>> Another goal of this header is to support EFI stub for RISC-V in future.
>>>> EFI specification needs PE/COFF image header in the beginning of the
>>>> kernel
>>>> image in order to load it as an EFI application. In order to support
>>>> EFI stub, code0 should be replaced with "MZ" magic string and res5(at
>>>> offset 0x3c) should point to the rest of the PE/COFF header (which will
>>>> be added during EFI support).
>>>>
>>>> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
>>>>
>>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>>
>>> Seems like we're stuck with this basic format for EFI, etc.  Even though
>>> we may be stuck with it, I think we should take the opportunity to add the
>>> possibility to extending this header format by adding fields after the
>>> basic PE/COFF header ends.
>>>
>>> In particular, at the very least, I'd suggest adding a u32 after the
>>> PE/COFF header ends, to represent a "RISC-V header format version number".
>>> Then if we add more fields that follow the PE/COFF header -- for example,
>>> to represent the RISC-V instruction set extensions that are required to
>>> run this binary -- we can just bump that RISC-V-specific version number
>>> field to indicate to bootloaders that there's more there.
>>>
>> That would be inventing our RISC-V specific header format.  However, we
>> can always use the one of the reserved fields in proposed header (res4)
>> for this purpose.
> 
> What are the semantics of those reserved fields?
> 

+struct riscv_image_header {
+	u32 code0;
+	u32 code1;
+	u64 text_offset;
+	u64 image_size;
+	u64 res1;
+	u64 res2;
+	u64 res3;
+	u64 magic;
+	u32 res4; ---> We can use this for versioning when required
+	u32 res5; ---> This is reserved for PE/COFF header
+};

>> Do we need to add it now or add it later when we actually need a version
>> number. My preference is to add it later based on requirement.
> 
> If it isn't added now, how would bootloaders know whether it was there or
> not?
> 
> 
Here is the corresponding U-Boot Patch
https://patchwork.ozlabs.org/patch/1096087/

Currently, boot loader doesn't care about versioning. Since we are 
updating a reserved field, offsets will not change. If a boot loader 
want to use the versioning, it should be patched along with the kernel 
patch.

Any other boot loader that doesn't care about the version, it can 
continue to do so without any change.

My idea is to enable the minimum required fields in this patch and keep 
everything else as reserved so that it can be amended in future as required.

Regards,
Atish

> - Paul
> 

