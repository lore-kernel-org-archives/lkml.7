Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD6B2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZYyigqqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfGOKpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:45:43 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33731 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfGOKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:45:42 -0400
Received: by mail-vs1-f67.google.com with SMTP id m8so11063432vsj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m69Q++mc12a2NdGKc1ehjmZg7I2gwJhoO4eDVouumsY=;
        b=ZYyigqqfTJL1M1v1PbJny8OLbsPkDjGGDBR3VfZY/RXWLHKEl/KQK4jlw/2hFoYUKJ
         BAP7IlQ/rIebx9O3QXfuOYQN9KRgO1XiV0DM0I2Bx9ikTXL/ZBHnq6buUTFkqSYJO+QM
         ft1o2d3BU8wCUYObg0hqi8NMhO0JQg7UV0gvYWRwi5PyBZ8Gu6U9xNg21yqzjkn5kTbF
         Qlu1lat0RJHOrtbuqmUcKEaALrFCygdwVlOMfGPSXgYU/2JZvkwPpsA5eNn0jce3B/1p
         Q26PJ8z4nPqekv7aJdmpDaH4dMquwbydPLnX+VH32cUhVqZMk9jzNkSstcvxlq6wcpZ9
         +c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m69Q++mc12a2NdGKc1ehjmZg7I2gwJhoO4eDVouumsY=;
        b=hL0YeyOpgnTEthlPOU+zf8/812C9QXi6vC0YaM1wS6QmFwbVqz9mFEl4eGxEXB57IN
         o//ee3YO4ap+c+gPmyi1aeWfPMfsspVFIcfwkLcGN2cW9NUcH5SPIUu6+afOh5nAFN+r
         aLFWaoD7tYgozjFZiDPGxYzLejEvAzA0VyzP82S1mZvODcyaWSvqq20Hyh6bP0i0HOV3
         y5PEsz074HwPc8JV5j6t+qdwzUY7QQBPeq5yQmiRVASWdfOMuVO1oqPq6qIMt44t+O8/
         qmomFdqE5R6rEZTCw90jnsV4/URRO/yCriV5s5yPCrljelLfLfAtYfjVYHsa7ifyAryM
         //mA==
X-Gm-Message-State: APjAAAVXtsGGr1EYoIrhYaRWqZs8hOTeZDAhN4p8IOAbdpXS2vV4QtVl
        0j9tbNJaDzEq3OPJPLCk1nG2/9LLe/dOkUw2q2ZDRA==
X-Google-Smtp-Source: APXvYqzUK7SwMuPo4ZL3JjgvyDVZtw0Ap9WNDsf6lO/m0M9uas49McrkrvqykfTKIOeehCC4Vj9JKrLUnWGRNxkLDYA=
X-Received: by 2002:a67:7c92:: with SMTP id x140mr16783284vsc.229.1563187541125;
 Mon, 15 Jul 2019 03:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
In-Reply-To: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 15 Jul 2019 16:15:29 +0530
Message-ID: <CAARK3HkMz3AdcVyrteGmqczCaMDTYS1h9uALspm75RFE9c6jFQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] mtd: spi-nor: add support for is25wp256 spi-nor flash
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:10 AM Sagar Shrikant Kadam
<sagar.kadam@sifive.com> wrote:
>
> The patch series adds support for 32MiB spi-nor is25wp256 present on HiFive
> Unleashed A00 board. The flash device gets BFPT_DWORD1_ADDRESS_BYTES_3_ONLY
> from BFPT table for address width, whereas the flash can support 4 byte
> address width, so the address width is configured by using the post bfpt
> fixup hook as done for is25lp256 device in
> commit cf580a924005 ("mtd: spi-nor: fix nor->addr_width when its value
> configured from SFDP does not match the actual width") queued in
> spi-nor/next branch [1].
>
> Patches 1 and 3 are based on original work done by Wesley Terpstra and/or
> Palmer Dabbelt:
> https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
>
> Erase/Read/Write operations are verified on HiFive Unleashed board using  mtd and
> flash utils (v1.5.2):
> 1. mtd_debug    : Options available are : erase/read/write.
> 2. flashcp      : Single utility that erases flash, writes a file to flash and verifies the data back.
> 3. flash_unlock : Unlock flash memory blocks. Arguments: are offset and number of blocks.
> 3. flash_lock   : Lock flash memory blocks. Arguments: are offset and number of blocks.
>
> The Unlock scheme clears the protection bits of all blocks in the Status register.
>
> Lock scheme:
> A basic implementation based on the stm_lock scheme and is validated for a different
> number of blocks passed to flash_lock. ISSI devices have top/bottom area selection
> in function register which is OTP memory. so we are not updating the OTP section
> of function register.
>
> The changes along are available under branch v5.2-rc1-mtd-spi-nor/next at:
> https://github.com/sagsifive/riscv-linux-hifive
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=spi-nor/next
>
> Revision history:
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
> Sagar Shrikant Kadam (4):
>   mtd: spi-nor: add support for is25wp256
>   mtd: spi-nor: fix nor->addr_width for is25wp256
>   mtd: spi-nor: add support to unlock the flash device
>   mtd: spi-nor: add locking support for is25wp256 device
>
>  drivers/mtd/spi-nor/spi-nor.c | 343 +++++++++++++++++++++++++++++++++++-------
>  include/linux/mtd/spi-nor.h   |   8 +
>  2 files changed, 300 insertions(+), 51 deletions(-)
>
> --
> 1.9.1
>

Hi All,

Any comments on this series?

BR,
Sagar Kadam
