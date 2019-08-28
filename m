Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5204EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5482053B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T/GkjUuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfH1SJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:09:05 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41669 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1SJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:09:05 -0400
Received: by mail-vs1-f67.google.com with SMTP id m62so594298vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FH2NOkI7wNtasjU18y8L32Bmo2nfckBhtCBctsbMnr8=;
        b=T/GkjUuK2wuAJPAqyAxjsz1/mFpPPfWw/Xet/c7ibPqMgsoeq542KzUk+EBhER4BVg
         bkUHNvJ0grvtNI7Eo28Z0qAfQGpsk4IDbys6o5r3BxAQ0kEP8L73kQ39Cpr5ep67UPH6
         uPXzlohMnXIRz6lGViCgJCyVL89cqF/rI7odee9MU3MwmqXfeR+eCCNrhxbyWkFQA/XF
         /S+VAztP+ge/ZlnbyIKUJ9ta37ijdoVQ9q6wxSHzqpM14b40T2BoDHgFiaMQPQ7RJ056
         0VOQPrd/ckrptmi8vcn7lIxH57fUo9x0LDZsk+wjw9LSoVyUESJMhuyvg09mRWASzrTp
         QA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FH2NOkI7wNtasjU18y8L32Bmo2nfckBhtCBctsbMnr8=;
        b=pX4/Kl9xTMLurRz3JiEQagHre8PzIioq5woWHVhaNYIEr2ZbirhM2LcySdH9x4yDpt
         SsBc3DIEMhryO7rKm8NIsOL6p5bhq4LeWBHMpHwy961Dtr82hbP6yDjLJfem1+Ktft/1
         JeoO0gyIpXs9yLZCZRzGJhaFwjP3odeNkm4Fp5ssW6kgjH4x4C+p66sPcTGoUplMXaV2
         ilpJ05VxJ9nz2Ni1XMIj91vMVEuCobkJ0IPJFN7Z4G2/A5yweGTxrMflFZKHEBPAWfw1
         lRb+hFfILX8LiMx9dWe6Q9X0uMSA28foRysMb/fUOHvGAWtvzuQvthZjJqfU8ZbqYy6z
         t5fw==
X-Gm-Message-State: APjAAAWG5IKxF9EVRHp0kxh66FNbdtCI226cZzoHgGgepEc4d1WyeZmG
        wMD1Oz5tzt+KnbYnD3txiVS7RcF0IJ8TdZTORPH/+A==
X-Google-Smtp-Source: APXvYqyURo7rnH5WL7d4rlsbKyu3inzGzxxABHgNQwJFaoudu7gS//knOa/s/zMfx2shYgTXGc5/sEZ5pfMhx5xHJb8=
X-Received: by 2002:a67:2d08:: with SMTP id t8mr3371760vst.178.1567015744349;
 Wed, 28 Aug 2019 11:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com>
 <1565699895-4770-2-git-send-email-sagar.kadam@sifive.com> <CAEUhbmU6xHjUWK3iM_RqURHGuqgmSxQw6RtWthT4+2aL1xLDcA@mail.gmail.com>
In-Reply-To: <CAEUhbmU6xHjUWK3iM_RqURHGuqgmSxQw6RtWthT4+2aL1xLDcA@mail.gmail.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Wed, 28 Aug 2019 11:08:53 -0700
Message-ID: <CAARK3H=gNy7o0NL6KCkcBQANoutwhMHE_-nfbfB2NVUATRgemA@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] mtd: spi-nor: add support for is25wp256
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, tudor.ambarus@microchip.com,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Mon, Aug 26, 2019 at 2:49 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Tue, Aug 13, 2019 at 8:40 PM Sagar Shrikant Kadam
> <sagar.kadam@sifive.com> wrote:
> >
> > Update spi_nor_id table for is25wp256 (32MB) device from ISSI,
> > present on HiFive Unleashed dev board (Rev: A00).
> >
> > Set method to enable quad mode for ISSI device in flash parameters
> > table.
> >
> > Based on code originally written by Wesley Terpstra <wesley@sifive.com>
> > and/or Palmer Dabbelt <palmer@sifive.com>
> > https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
> >
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++++-
> >  include/linux/mtd/spi-nor.h   | 1 +
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index 03cc788..6635127 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1946,7 +1946,10 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
> >                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
> >                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > -
> > +       { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
>
> The sector number should be 512, not 1024.

Thanks for pointing this out.
I had rectified it in recent U-boot patchset here
  https://patchwork.ozlabs.org/patch/1146522/
but I missed the change in the linux one as it was sent earlier.
I will include this change in the next version of the patch

Thanks & BR,
Sagar
>
> > +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > +                       SPI_NOR_4B_OPCODES)
> > +       },
> >         /* Macronix */
> >         { "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> >         { "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
> > @@ -3776,6 +3779,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
> >                 case SNOR_MFR_ST:
> >                 case SNOR_MFR_MICRON:
> >                         break;
> > +               case SNOR_MFR_ISSI:
> > +                       params->quad_enable = macronix_quad_enable;
> > +                       break;
> > +
> >
> >                 default:
> >                         /* Kept only for backward compatibility purpose. */
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index 9f57cdf..5d6583e 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -21,6 +21,7 @@
> >  #define SNOR_MFR_INTEL         CFI_MFR_INTEL
> >  #define SNOR_MFR_ST            CFI_MFR_ST      /* ST Micro */
> >  #define SNOR_MFR_MICRON                CFI_MFR_MICRON  /* Micron */
> > +#define SNOR_MFR_ISSI          0x9d            /* ISSI */
> >  #define SNOR_MFR_MACRONIX      CFI_MFR_MACRONIX
> >  #define SNOR_MFR_SPANSION      CFI_MFR_AMD
> >  #define SNOR_MFR_SST           CFI_MFR_SST
>
> Regards,
> Bin
