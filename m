Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256A6C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97CB2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbfIMTEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:04:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44982 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730539AbfIMTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:04:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so15689024pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 12:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=C/c0+7xyLwhydfuw618MebO86BFitwO7L2tz4CMTLik=;
        b=ET+q9tcOGimsNy2jGABBEVNqZVGztIZbCbI4aycql8y2sxhOGOvuVkd4XVIwBAT5IE
         ASdvt3D4cFl3eFzjF2nKD/K7+9P488ldEGX3ZBLwAjt1vfiOQIq61vwxG0X3D5Y0sVmT
         mtUpFEY7BX3xP7zAs/nnwiLYq7bbZ6SbIMwjY+We1ZPjk3lWpd/Z1Iur7S5PZR2NApwB
         ygNYPXFuv7Aa+3fRAzi5j8ZlhRhMrtzSJW5+WZguBs5IOCRfZZ/Sa6h5r3Dc8SJajpgz
         g5TaVd6O/G5MFjA8nmQRsMGkfPYSWUZQWjnv41yPi9O63KXhFyRpZVKkADQ0bLLr/u7w
         kqYw==
X-Gm-Message-State: APjAAAV3siZ70e8mtc+HrX3h/8F/LqilXZ0LYX6HcSoYkkA5AjhITzG6
        ZG2dN0lK2Y/9gGfk4Tn/UQuBDg==
X-Google-Smtp-Source: APXvYqyugeg/BVpNWGFudHrlJq34wUPoBeO3WSYi1kLXW2ENq/Y6GgQ2N+W+xNPEZpjXk99ZMDejzg==
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr7008605pja.73.1568401483479;
        Fri, 13 Sep 2019 12:04:43 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id g3sm2600297pjx.32.2019.09.13.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 12:04:42 -0700 (PDT)
Date:   Fri, 13 Sep 2019 12:04:42 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 12:04:09 PDT (-0700)
Subject:     Re: [PATCH] riscv: save space on the magic number field of image header
In-Reply-To: <CAAhSdy0Z_wa12xFN23UK4XuweCPytMrXU-+Yr5ePVGwO+JkSzg@mail.gmail.com>
CC:     clin@suse.com, rick@andestech.com, merker@debian.org,
        aou@eecs.berkeley.edu, marek.vasut@gmail.com, tglx@linutronix.de,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-487a5dd2-279b-45ec-9ba2-24e5f4a54b40@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Sep 2019 03:19:27 PDT (-0700), anup@brainfault.org wrote:
> On Fri, Sep 6, 2019 at 2:46 PM Chester Lin <clin@suse.com> wrote:
>>
>> Hi Anup,
>>
>> On Fri, Sep 06, 2019 at 01:50:37PM +0530, Anup Patel wrote:
>> > On Fri, Sep 6, 2019 at 12:50 PM Chester Lin <clin@suse.com> wrote:
>> > >
>> > > Change the symbol from "RISCV" to "RSCV" so the magic number can be 32-bit
>> > > long, which is consistent with other architectures.
>> > >
>> > > Signed-off-by: Chester Lin <clin@suse.com>
>> > > ---
>> > >  arch/riscv/include/asm/image.h | 9 +++++----
>> > >  arch/riscv/kernel/head.S       | 5 ++---
>> > >  2 files changed, 7 insertions(+), 7 deletions(-)
>> > >
>> > > diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
>> > > index ef28e106f247..ec8bbfe86dde 100644
>> > > --- a/arch/riscv/include/asm/image.h
>> > > +++ b/arch/riscv/include/asm/image.h
>> > > @@ -3,7 +3,8 @@
>> > >  #ifndef __ASM_IMAGE_H
>> > >  #define __ASM_IMAGE_H
>> > >
>> > > -#define RISCV_IMAGE_MAGIC      "RISCV"
>> > > +#define RISCV_IMAGE_MAGIC      "RSCV"
>> > > +
>> > >
>> > >  #define RISCV_IMAGE_FLAG_BE_SHIFT      0
>> > >  #define RISCV_IMAGE_FLAG_BE_MASK       0x1
>> > > @@ -39,9 +40,9 @@
>> > >   * @version:           version
>> > >   * @res1:              reserved
>> > >   * @res2:              reserved
>> > > - * @magic:             Magic number
>> > >   * @res3:              reserved (will be used for additional RISC-V specific
>> > >   *                     header)
>> > > + * @magic:             Magic number
>> > >   * @res4:              reserved (will be used for PE COFF offset)
>> > >   *
>> > >   * The intention is for this header format to be shared between multiple
>> > > @@ -57,8 +58,8 @@ struct riscv_image_header {
>> > >         u32 version;
>> > >         u32 res1;
>> > >         u64 res2;
>> > > -       u64 magic;
>> > > -       u32 res3;
>> > > +       u64 res3;
>> > > +       u32 magic;
>> > >         u32 res4;
>> > >  };
>> > >  #endif /* __ASSEMBLY__ */
>> > > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> > > index 0f1ba17e476f..1f8fffbecf68 100644
>> > > --- a/arch/riscv/kernel/head.S
>> > > +++ b/arch/riscv/kernel/head.S
>> > > @@ -39,9 +39,8 @@ ENTRY(_start)
>> > >         .word RISCV_HEADER_VERSION
>> > >         .word 0
>> > >         .dword 0
>> > > -       .asciz RISCV_IMAGE_MAGIC
>> > > -       .word 0
>> > > -       .balign 4
>> > > +       .dword 0
>> > > +       .ascii RISCV_IMAGE_MAGIC
>> > >         .word 0
>> > >
>> > >  .global _start_kernel
>> > > --
>> > > 2.22.0
>> > >
>> >
>> > This change is not at all backward compatible with
>> > existing booti implementation in U-Boot.
>> >
>> > It changes:
>> > 1. Magic offset
>> > 2. Magic value itself
>> >
>>
>> Thank you for the reminder. I have submitted a patch to U-Boot as well. Since
>> my email post to the uboot mailing list is still under review by the list
>> moderator, here I just list my code change of uboot:
>
> I think you missed my point.
>
> First of all, the space saving in image header is not of much use
> because most of the required fields are already in-place. Only
> res4 will become PE COFF offset when we add PE header.
>
> To ensure that image header changes are backward compatible,
> we cannot change magic location and value. Also, all changes
> to image header should accompany with corresponding version
> value change.
>
> The Linux-5.3 merge window is already over. Now we will have
> Linux-5.3 release with a image header different than proposed by
> this patch. Let's say your patch is merged in Linux-5.4 then it will
> not work with U-Boot-2019.07.
>
> Further, if your U-Boot patch is merged in next release then
> U-Boot-2019.10 onwards booti will fail for Linux-5.3.
>
> After a long time, Linux-5.3 will be first golden release having all
> required changes for SiFive Unleashed and it works perfectly
> fine with U-Boot-2019.10 (or higher). Going forward we would
> like to see that any Linux-5.3 (or higher) kernel always boots
> with U-Boot-2019.10 (or higher) on SiFive Unleashed.
>
> I don't approve this patch and your U-Boot patch as well.

Ya, it looks like we screwed this one up.  There's a bunch of differences 
between our image header format and the ARM64 one, and while we could evolve 
them in a compatible direction we would need to:

* Start setting our res3 to a RISC-V magic number, which would make it match 
  the magic number location for arm64.  We'd have to leave the 64-bit magic 
  number in for the previous two u-boot releases, but could in theory later 
  remove it when the Unleashed is defunct.
* Remove our version number, which u-boot isn't checking anyway but is 
  nominally reserved and set to 0 on ARM64.

If we do this now, we do at least get the option of making these compatible in 
the future.  I'm not sure it's worth the headache, as there's very little code 
here, but it's just embarrassing that we're incompatible for really no reason.

> Regards,
> Anup
>
>>
>> diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
>> index d063beb7df..e8a8cb7190 100644
>> --- a/arch/riscv/lib/image.c
>> +++ b/arch/riscv/lib/image.c
>> @@ -14,8 +14,8 @@
>>
>>  DECLARE_GLOBAL_DATA_PTR;
>>
>> -/* ASCII version of "RISCV" defined in Linux kernel */
>> -#define LINUX_RISCV_IMAGE_MAGIC 0x5643534952
>> +/* ASCII version of "RSCV" defined in Linux kernel */
>> +#define LINUX_RISCV_IMAGE_MAGIC 0x56435352
>>
>>  struct linux_image_h {
>>         uint32_t        code0;          /* Executable code */
>> @@ -25,8 +25,8 @@ struct linux_image_h {
>>         uint64_t        res1;           /* reserved */
>>         uint64_t        res2;           /* reserved */
>>         uint64_t        res3;           /* reserved */
>> -       uint64_t        magic;          /* Magic number */
>> -       uint32_t        res4;           /* reserved */
>> +       uint64_t        res4;           /* reserved */
>> +       uint32_t        magic;          /* Magic number */
>>         uint32_t        res5;           /* reserved */
>>  };
>>
>>
>> > We don't see this header changing much apart from
>> > res1/res2 becoming flags in-future. The PE COFF header
>> > will be append to this header in-future and it will have lot
>> > more information.
>> >
>>
>> I think a smaller magic field will let res4 have more room [32bit->64bit], which
>> could offer more options for RISC-V's boot-flow development in the future. This
>> change also synchronizes with arm64's image header.
>>
>> > Regards,
>> > Anup
>> >
