Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F6C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63B4215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XRHsgO2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfI3Nex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:34:53 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42272 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbfI3Nex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:34:53 -0400
Received: by mail-vs1-f68.google.com with SMTP id m22so6745575vsl.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMvf0aJLSBw670rdzFO9x6SzJk02/YpUBF290pMe194=;
        b=XRHsgO2ll4Out3o1wWqMo9/abYElPhYcstVnCjrAX4aJrgfwN3SSOi/aFXRHfmoHHQ
         KieWKrU3/AlNLArqYMjHIkhyQsWX1bKkMj3Cy05J0In/IglcbWMeOzdgPfEQ0JGXeEoY
         Ly8MkBlzdNqEkscNPaJWQMwsgNSQlneFvr9c8uj4bdNHLyBOD/RBlbMtEuOazxlROCZB
         zyRh9eBTf+T5h7F0DsfDbwugnqO2BG3TTeTK3V4q3V4OIwNA9nqI0gB3HUkg38F+hxDJ
         teov5TcNbR1trLL4uRTSp93QzxHScrbmgI4+kb4NNWtFM76u7MkDK4dHz6hgdWR4Tbys
         xqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMvf0aJLSBw670rdzFO9x6SzJk02/YpUBF290pMe194=;
        b=OORcb/xdD8/lpXuyb5UYs/KZ0hHDn3ZPCuKvcFTUTiutpbElvDXLLBXOg7IF2rFb74
         Igg2kCWCo3ogviYjuY1MqepbwSnzyQ/8EHjnr6hNvcmtHvMATMmeQvxWknuoxd1bg2qc
         E1AA6k86JhRQflXgjtGEs9exkDT5F4miXE3ufBspf1TDa29Xb3rGbAKsbwuScUagEF/s
         p47/ERFmtaoE7N64a46Y0MXN1IC8G8e4d95zNmp2qF8w3DhUPT7foLlgOolHNLQQmp0D
         OmPI2WGU/39Q/3gRiGLBmFqJ42JM5AfPqBCE03MRr2tBNVfXVNmiJuwhOUkhAOkNNoH7
         v85g==
X-Gm-Message-State: APjAAAXqpjBT2I+jNnXQmapr76fuqpqKIzXOLVnjzOmGHSxuauzEUPel
        grK9xSh10qrRAIR/BFfDQ44HQA+Bo76dNSVPUVvfPw==
X-Google-Smtp-Source: APXvYqwFoFBboIPgwzdCmxDRfbxS1fhkFS38SreFnzfJ31NLXbmDoVntXc3bbJ78f872NGqPaK/9xydoPhVnoDLPfKk=
X-Received: by 2002:a67:f0dd:: with SMTP id j29mr4889144vsl.92.1569850491648;
 Mon, 30 Sep 2019 06:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <1568822505-19297-1-git-send-email-sagar.kadam@sifive.com>
In-Reply-To: <1568822505-19297-1-git-send-email-sagar.kadam@sifive.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 30 Sep 2019 19:04:40 +0530
Message-ID: <CAARK3HkOwyvg=xr7fw1SrP_=B+Gj+waQmtZvgiK4AUpQrbM41Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] mtd: spi-nor: add support for is25wp256 spi-nor flash
To:     Marek Vasut <marek.vasut@gmail.com>, tudor.ambarus@microchip.com,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 18, 2019 at 9:32 PM Sagar Shrikant Kadam
<sagar.kadam@sifive.com> wrote:
>
> The patch series adds basic support for 32MiB spi-nor is25wp256 present on HiFive
> Unleashed A00 board. The flash device gets BFPT_DWORD1_ADDRESS_BYTES_3_ONLY
> from BFPT table for address width, whereas the flash can support 4 byte
> address width, so the address width is configured by using the post bfpt
> fixup hook as done for is25lp256 device in
> commit cf580a924005 ("mtd: spi-nor: fix nor->addr_width when its value
> configured from SFDP does not match the actual width")
>
> Patches are based on original work done by Wesley Terpstra and/or
> Palmer Dabbelt:
> https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
>
> Erase/Read/Write operations are verified on HiFive Unleashed board using  mtd and
> flash utils (v1.5.2):
> 1. mtd_debug    : Options available are : erase/read/write.
> 2. flashcp      : Single utility that erases flash, writes a file to flash and verifies the data back.
>
> The changes are available under branch dev/sagark/spi-nor-v9 at
> https://github.com/sagsifive/riscv-linux-hifive
>
> Revision history:
> V8<->V9:
> -Rebased this series to mainline v5.3-rc8
> -Corrected number of sectors in the spi nor id table for is25wp256 device as suggested in the review.
> -The lock/unlock scheme in the V8 version of this series needs to have a more generic approach.
>  These protection scheme patches are not included in this series, will submit those separately.
>

A gentle reminder!!
Any comments on this series?

Thanks & BR,
Sagar Kadam

> V7<->V8:
> -Rebased this series on mainline v5.3-rc4.
> -Removed remaining func_reg reference from issi_lock as updating OTP region was dropped as part of V6.
> -Updated Reviewed-By tags to 1st and 2nd patch.
>
> V6<->V7:
> -Incorporated review comments from Vignesh.
> -Used post bfpt fixup hook as suggested by Vignesh.
> -Introduce SPI_NOR_HAS_BP3 to identify whether the flash has 4th bit protect bit.
> -Prefix generic flash access functions with spi_nor_xxxx.
>
> V5<->V6:
> -Incorporated review comments from Vignesh.
> -Set addr width based on device size and if SPI_NOR_4B_OPCODES is set.
> -Added 4th block protect identifier (SPI_NOR_HAS_BP3) to flash_info structure
> -Changed flash_info: flag from u16 to u32 to accommodate SPI_NOR_HAS_BP3
> -Prefix newly added function with spi_nor_xxx.
> -Dropped write_fr function, as updating OTP bit's present in function register doesn't seem to be a good idea.
> -Set lock/unlock schemes based on whether the ISSI device has locking support and  BP3 bit present.
>
> V4<->V5:
> -Rebased to linux version v5.2-rc1.
> -Updated heading of this cover letter with sub-system, instead of just plain "add support for is25wp256..."
>
> V3<->V4:
> -Extracted comman code and renamed few stm functions so that it can be reused for issi lock implementation.
> -Added function's to read and write FR register, for selecting Top/Bottom area.
>
> V2<->V3:
> -Rebased patch to mainline v5.1 from earlier v5.1-rc5.
> -Updated commit messages, and cover letter with reference to git URL and author information.
> -Deferred flash_lock mechanism and can go as separate patch.
>
> V1<-> V2:
> -Incorporated changes suggested by reviewers regarding patch/cover letter versioning, references of patch.
> -Updated cover letter with description for flash operations verified with these changes.
> -Add support for unlocking is25xxxxxx device.
> -Add support for locking is25xxxxxx device.
>
> v1:
> -Add support for is25wp256 device.
>
> Sagar Shrikant Kadam (2):
>   mtd: spi-nor: add support for is25wp256
>   mtd: spi-nor: fix nor->addr_width for is25wp256
>
>  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++++-
>  include/linux/mtd/spi-nor.h   | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> --
> 1.9.1
>
