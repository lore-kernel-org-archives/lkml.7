Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3276C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0E20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zIiaUuDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfIJHR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:17:27 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53921 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfIJHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:17:27 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x8A7HElL021816
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 16:17:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x8A7HElL021816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568099835;
        bh=hsCBtVZ6afRsYXrckjljItT6Prlzv9FqLtINzPuvIGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zIiaUuDvKWGTsx0stSbjODQ3HFdeOn1ktVTBIztypScoJiMV/5t14AwsThyfBMXf3
         89Gt1A1yLK4Z0bMFM2sb34wPOXlOUGpk6PFaMySmY0Milq3G+HBqvB+96hLXLq+RhO
         PsEc1zpy2ApgWVNmrDgrp71k+jr4ZEQoUg1vPbHIucJgYKknFeMls/z7DCf+qTrA3W
         Fdr8964ODe3HeLSlvYZwqs15UnfpiuueDlVFtJlVxhfV2NXBQt8pBLGSTRPPbSiSMg
         vQ7RoQG26Uu7w7UOQYtGMOhGYO1ameFi9Gnq+yboUmaphgFgYpiSktVJFJMB4yx3Nk
         N93UoqjcPSnFg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id g14so5031410vsp.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 00:17:14 -0700 (PDT)
X-Gm-Message-State: APjAAAWSN2BsvcQzih8i9VIDAWXVN/lDJCOrriTwrDcp/u+wlPZzv8sb
        hevk1s3ZPtZN/3EbTm7wnUyjf2udM8uh/iSQ5t0=
X-Google-Smtp-Source: APXvYqyN6uVF+F82+CTJpXbJfOL91LfGWA9OgKUDgrXKU6JYE9bFvSwTgizpogjH612WA1VJ9ZXyjS4gBrTfPdd0mwU=
X-Received: by 2002:a67:eb18:: with SMTP id a24mr15067230vso.155.1568099833884;
 Tue, 10 Sep 2019 00:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <5143724.5TqzkYX0oI@dabox>
In-Reply-To: <5143724.5TqzkYX0oI@dabox>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 10 Sep 2019 16:16:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8xtURiCoJC0eWLFw0q+78Eb_axoOzWH+JNugf-24Qig@mail.gmail.com>
Message-ID: <CAK7LNAR8xtURiCoJC0eWLFw0q+78Eb_axoOzWH+JNugf-24Qig@mail.gmail.com>
Subject: Re: mtd raw nand denali.c broken for Intel/Altera Cyclone V
To:     Tim Sander <tim@krieglstein.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 9:39 PM Tim Sander <tim@krieglstein.org> wrote:
>
> Hi
>
> I have noticed that there multiple breakages piling up for the denali nand
> driver on the Intel/Altera Cyclone V. Unfortunately i had no time to track the
> mainline kernel closely. So the breakage seems to pile up. I am a little
> disapointed that Intel is not on the lookout that the kernel works on the
> chips they are selling. I was really happy about the state of the platform
> before concerning mainline support.
>
> The failure starts with kernel 4.19 or stable kernel release 4.18.19. The
> commit is ba4a1b62a2d742df9e9c607ac53b3bf33496508f.


Just for clarification, this corresponds to
0d55c668b218a1db68b5044bce4de74e1bd0f0c8 upstream.



> The problem here is that
> our platform works with a zero in the SPARE_AREA_SKIP_BYTES register.

Please clarify the scope of "our platform".
(Only you, or your company, or every individual using this chip?)


First, SPARE_AREA_SKIP_BYTES is not the property of the hardware.
Rather, it is about the OOB layout, in other words, this parameter
is defined by software.

For example, U-Boot supports the Denali NAND driver.
The SPARE_AREA_SKIP_BYTES is a user-configurable parameter:
https://github.com/u-boot/u-boot/blob/v2019.10-rc3/drivers/mtd/nand/raw/Kconfig#L112


Your platform works with a zero in the SPARE_AREA_SKIP_BYTES register
because the NAND chip on the board was initialized with a zero
set to the SPARE_AREA_SKIP_BYTES register.

If the NAND chip had been initialized with 8
set to the SPARE_AREA_SKIP_BYTES register, it would have
been working with 8 to the SPARE_AREA_SKIP_BYTES.

The Boot ROM is the only (semi-)software that is unconfigurable by users,
so the value of SPARE_AREA_SKIP_BYTES should be aligned with
the boot ROM.
I recommend you to check the spec of the boot ROM.

(The maintainer of the platform, Dihn is CC'ed,
so I hope he will jump in)


Second, I doubt 0 is a good value for SPARE_AREA_SKIP_BYTES.

As explained in commit log, SPARE_AREA_SKIP_BYTES==0 means
the OOB is used for ECC without any offset.
So, the BBM marked in the factory will be destroyed.



> But in
> this case the patch assumes the default value 8 which is straight out  wrong
> on this variant. Without this patch reverted all blocks of the nand flash are
> beeing marked bad :-(.
>
> When reverting the patch ba4a1b62a2d742df9e9c607ac53b3bf33496508f  i can boot
> 4.19.10 again.
>
> With 5.0 the it goes further down the drain and i didn't manage to boot it
> even with the above patch reverted.
>
> I also tried 5.3-rc7 with the above patch reverted and the variable t_x dirty hacked to the
> value 0x1388 as i got the impression that the timing calculation is off too. I still get an
> interrupt error and boot failure:

git-bisect is a general solution to pin point the problem.

BTW, if you end up with hacking the clock frequency, something is already wrong.

denali->clk_rate, denali->clk_x_rate should be 50MHz, 200MHz, respectively.

If not, please check the clock driver and your DT.




> [    0.817588] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
> [    0.823946] nand: Micron MT29F2G08ABAEAWP
> [    0.827965] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> [    1.887052] denali-nand-dt ff900000.nand: timeout while waiting for irq 0x1000
> [    2.911056] denali-nand-dt ff900000.nand: timeout while waiting for irq 0x1000
>
> I have seen this https://lore.kernel.org/patchwork/patch/983055/ thread and
> this might fix at least the 4.19 boot problem.
>
> I would be really happy for hints how to get the Intel Cyclone V working again.
>
> Best regards
> Tim
>
>
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Best Regards
Masahiro Yamada
