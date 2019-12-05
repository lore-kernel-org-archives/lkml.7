Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53920C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2132320706
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJFmAAyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfLEXDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:03:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34677 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfLEXDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:03:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id h13so1871243plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=VcK5fYtZOQ1Up6kZW76qzY7nQB78Tgg1EbtbB/usWCw=;
        b=NJFmAAyKgTfnsH3F4E56Ct2k6Ayz/IExZcUrscTAyzl2wzHYCaE4ceIkYNQVL2xH8m
         dO3cx1VKLTd5K/s8qdB+ir0hP/CdYq+vkLRfEa6sMnJTiZUby6OOiowus4lnLgYrg3P8
         d++ECyd2kfABrIk+gPUFR6KJ58MylENemZtXcyRXVzDuOX0jztfAAUAfQE5r+E1ib5W5
         uXoG9NrN7/RItitpDrYg0AYtINHrQDrF1PyK33Gn4A3ADqt72s3RsOJlzaWnq+CKjdA2
         B9lrwnuRvzEP4MUyYr8+UoTscCHCjLwgl+cywwfMEfeeFw+Yp73pJFeof/junpWwrJwJ
         yAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=VcK5fYtZOQ1Up6kZW76qzY7nQB78Tgg1EbtbB/usWCw=;
        b=PFl+KzzBAZyYRazln2tajXYMLaw5ni60StsyjbOtGIz/2jDzAbncX2pBNmFOLTQ+A2
         NHfl8mwa1rgWCkl69egp4AfXxoiFXVv2L7ZItpqVI64TjgQZ4S1DQ9itLj6SZzWvgLu2
         xVKsq/WIyY3Ix1VYoN6KycveULnkr37Kh9njRhBpWRLf4eFciAW4vGsw1DTQJGkJX3oE
         8+14z8MDKqrmQpXLLXlyY6uGC6csrCyJuh/BbB+4xgGenMsUQ9uRP61602qLM6K9AZB7
         F7I3Xh/JAqlwP7SPxxq4rE2yLQx4g8UCSybwCmDjiE3wrvWaL7hJZvxmaXAg1ieY9CkB
         nfPQ==
X-Gm-Message-State: APjAAAVHbqP3wobiqBn7T0a0qWU8hV90+RCqKTz2HaI8pg3IqcV0EJHE
        IvFb0LP18IXepivvaahjdVRCdZLEDiA=
X-Google-Smtp-Source: APXvYqzkuo1UfAwnq27732Hsurn/l0iO74AhjbK8hskAeect2c0rRTxFhfEj90V6CNHiujMV9r8GTQ==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1mr11397941plo.289.1575586991609;
        Thu, 05 Dec 2019 15:03:11 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id n26sm12847040pgd.46.2019.12.05.15.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:03:10 -0800 (PST)
Date:   Thu, 05 Dec 2019 15:03:10 -0800 (PST)
X-Google-Original-Date: Thu, 05 Dec 2019 13:34:44 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH] RISC-V: Typo fixes in image header and documentation.
In-Reply-To: <4912c007ab6c19321c8c988ae2328efbfb3e582d.camel@wdc.com>
CC:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-riscv@lists.infradead.org, merker@debian.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
        palmer@sifive.com, mchehab+samsung@kernel.org
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-3a815562-1222-4737-a77c-6dab9948db79@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 14:02:20 PST (-0800), Atish Patra wrote:
> On Tue, 2019-10-08 at 18:06 -0700, Atish Patra wrote:
>> There are some typos in boot image header and riscv boot
>> documentation.
>> 
>> Fix the typos.
>> 
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>  Documentation/riscv/boot-image-header.rst | 4 ++--
>>  arch/riscv/include/asm/image.h            | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/riscv/boot-image-header.rst
>> b/Documentation/riscv/boot-image-header.rst
>> index 7b4d1d747585..8efb0596a33f 100644
>> --- a/Documentation/riscv/boot-image-header.rst
>> +++ b/Documentation/riscv/boot-image-header.rst
>> @@ -22,7 +22,7 @@ The following 64-byte header is present in
>> decompressed Linux kernel image::
>>  	u64 res2 = 0;		  /* Reserved */
>>  	u64 magic = 0x5643534952; /* Magic number, little endian,
>> "RISCV" */
>>  	u32 magic2 = 0x56534905;  /* Magic number 2, little endian,
>> "RSC\x05" */
>> -	u32 res4;		  /* Reserved for PE COFF offset */
>> +	u32 res3;		  /* Reserved for PE COFF offset */
>>  
>>  This header format is compliant with PE/COFF header and largely
>> inspired from
>>  ARM64 header. Thus, both ARM64 & RISC-V header can be combined into
>> one common
>> @@ -34,7 +34,7 @@ Notes
>>  - This header can also be reused to support EFI stub for RISC-V in
>> future. EFI
>>    specification needs PE/COFF image header in the beginning of the
>> kernel image
>>    in order to load it as an EFI application. In order to support EFI
>> stub,
>> -  code0 should be replaced with "MZ" magic string and res5(at offset
>> 0x3c) should
>> +  code0 should be replaced with "MZ" magic string and res3(at offset
>> 0x3c) should
>>    point to the rest of the PE/COFF header.
>>  
>>  - version field indicate header version number
>> diff --git a/arch/riscv/include/asm/image.h
>> b/arch/riscv/include/asm/image.h
>> index 344db5244547..4f8061a5ac4a 100644
>> --- a/arch/riscv/include/asm/image.h
>> +++ b/arch/riscv/include/asm/image.h
>> @@ -42,7 +42,7 @@
>>   * @res2:		reserved
>>   * @magic:		Magic number (RISC-V specific; deprecated)
>>   * @magic2:		Magic number 2 (to match the ARM64 'magic'
>> field pos)
>> - * @res4:		reserved (will be used for PE COFF offset)
>> + * @res3:		reserved (will be used for PE COFF offset)
>>   *
>>   * The intention is for this header format to be shared betweenres4
>> multiple
>>   * architectures to avoid a proliferation of image header formats.
>> @@ -59,7 +59,7 @@ struct riscv_image_header {
>>  	u64 res2;
>>  	u64 magic;
>>  	u32 magic2;
>> -	u32 res4;
>> +	u32 res3;
>>  };
>>  #endif /* __ASSEMBLY__ */
>>  #endif /* __ASM_IMAGE_H */
> 
> ping ?

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm assuming this is not going in through the RISC-V tree as it mostly touches
Documentation/.
