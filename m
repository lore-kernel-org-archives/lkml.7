Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B86C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A718206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BX4nZWab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEBJuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:50:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37128 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfEBJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:50:23 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so1000126vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keAes192gnrFcSFqXV1m3IUSUAMiPAOK4rQjZDjH5pI=;
        b=BX4nZWabL1FBUgQQIP5xUtBD0Ydn1/qRre827GC5X0v65wAictFYc2/JYEV1utJ2R/
         8ovvH6UcxqPuFoKh70cJGDwl30VleX42wVx3XPO3SjKfCQR2TiiDK8GHPCc8SfjAzMv0
         JAX6VElspWsKr7ZY/OkmPgh1Kw+7lAoPFTcLVgkRulhmQmXYN38TCXqdx0osl3j5Wkxn
         hmpSUSHvgtkOoq5C0zDP0nBKjqozOXKVuVsna4xb90+qznOzIS/fcHe1LF4ggVdhPJNZ
         unTHUdxSjrhDgjuQYQOyrtRVRVn7Xd4gBViun011N4h6aGP0IRfcw2JXd7FmICRUppKn
         DyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keAes192gnrFcSFqXV1m3IUSUAMiPAOK4rQjZDjH5pI=;
        b=LU9yPeAaQpnkGmOO/uUAkLbUVOZVYSOaPU3jdCNCVWZDVxKW3uR2Rl7VB0dOevTiiR
         3ADMAEtQTuYplnom0qy+St2nlnYQjCLybqzJwRMhgFlh2m9nyaZ/kqGYgxigZ+ccqo1Z
         flInyD1mN4q6BlSu+FCKarAdJU86q9ER9wdZhByaVnC+eoZq14/TbdG3OAoPaa6RWcHb
         Cd+iJ/W/SpmmNpy/uhQOa1B95eR3TkxqwE9cq89sy8GBc23dLHWSrgb8vScu5n4erOli
         N1EVnXd2TEcYIBpA8GVy04WTgQqEzIUbrj7s6A9q21CJFU3I4w8CDUEol7RJRztQVEef
         4niw==
X-Gm-Message-State: APjAAAXfaK/+dCuDS7s6LJP3MXUCsYsu0SYA01+e/Xexscl5eNBfUpFy
        ez1cdLxknOMQSLmzKd7yKBdV60uHWEQqpGhv5N+WoQ==
X-Google-Smtp-Source: APXvYqxx/FX3/IKosWRbFNCh1CRrGqLdhXbBkxySTU2eoGaeDFJ6o+ccMLi1ZJecmMwPjn5xTCeXYWtfZMqlG3yh9LQ=
X-Received: by 2002:a67:ea45:: with SMTP id r5mr1312876vso.92.1556790621948;
 Thu, 02 May 2019 02:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
 <1556474956-27786-2-git-send-email-sagar.kadam@sifive.com> <alpine.DEB.2.21.9999.1904301002170.7063@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1904301002170.7063@viisi.sifive.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Thu, 2 May 2019 15:20:11 +0530
Message-ID: <CAARK3HmQvACXvySfwTWSss_DKqwX_oUF3gwxQuu5am0DoLh+jA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: add support for is25wp256
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Paul, for your review comments.

On Tue, Apr 30, 2019 at 10:33 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Sun, 28 Apr 2019, Sagar Shrikant Kadam wrote:
>
> > Update spi_nor_id tablet for is25wp256 (32MB)device from ISSI,
> > present on HiFive Unleashed dev board (Rev: A00).
> >
> > Set method to enable quad mode for ISSI device in flash parameters
> > table.
>
> This patch was based on one originally written by Wes and/or Palmer:
> https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
>
> The right thing to do is to note this in the commit message.
>
Yes true, this is important as well.
I had mentioned this in the covering letter, but I missed to add the
details into the commit message,
I will submit V3 for this.


> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 10 +++++++++-
> >  include/linux/mtd/spi-nor.h   |  1 +
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index fae1474..c5408ed 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1834,6 +1834,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >       { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +     { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
> > +                     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > +                     SPI_NOR_4B_OPCODES)
> > +     },
> >
> >       /* Macronix */
> >       { "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> > @@ -3650,6 +3654,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
> >               case SNOR_MFR_MACRONIX:
> >                       params->quad_enable = macronix_quad_enable;
> >                       break;
> > +             case SNOR_MFR_ISSI:
> > +                     params->quad_enable = macronix_quad_enable;
> > +                     break;
> > +
> >
> >               case SNOR_MFR_ST:
> >               case SNOR_MFR_MICRON:
> > @@ -4127,7 +4135,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >       if (ret)
> >               return ret;
> >
> > -     if (nor->addr_width) {
> > +     if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
> >               /* already configured from SFDP */
> >       } else if (info->addr_width) {
> >               nor->addr_width = info->addr_width;
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index b3d360b..ff13297 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -19,6 +19,7 @@
> >  #define SNOR_MFR_ATMEL               CFI_MFR_ATMEL
> >  #define SNOR_MFR_GIGADEVICE  0xc8
> >  #define SNOR_MFR_INTEL               CFI_MFR_INTEL
> > +#define SNOR_MFR_ISSI                0x9d            /* ISSI */
> >  #define SNOR_MFR_ST          CFI_MFR_ST      /* ST Micro */
> >  #define SNOR_MFR_MICRON              CFI_MFR_MICRON  /* Micron */
> >  #define SNOR_MFR_MACRONIX    CFI_MFR_MACRONIX
> > --
> > 1.9.1
> >
> >
