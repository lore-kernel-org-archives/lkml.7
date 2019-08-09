Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E87C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905FB208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CY0rWQRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406788AbfHIOX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:23:58 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43069 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:23:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id n12so2624716vsr.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7R0g53oVtt0hxxPewtlUubukC0ZyQYO8NJIzmT0oCc=;
        b=CY0rWQRdZgm3Ad62s5QrVWqWafZ2c4deK+wY2x9OydvIryPzFGXumM3IxKlB1H0pUY
         uKqxFClA0jt3i9qT3hyv3Vqd7MJ8YS+AxXll30XRDO7b4emBw3tyAnSGATWwko9X+htn
         C32Z8FBOcLKTgKp5ypcuGXxV43Uhm9TjyQrbB++wr4dtXfWVnUk47P2Du1/IGOjj/UH9
         KVXRdeS473BuCucIRIFrGiWV4O04/U19xCUkb9zsd4nlevhIXNcwEHEMhZtwxculYkU1
         a1rIqeiQ456hygBSV3CBkLVci5EqUiJ46r/SQ0idsmLEKV6Q0+BP9Y2ME9uYnFP/KPkT
         UKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7R0g53oVtt0hxxPewtlUubukC0ZyQYO8NJIzmT0oCc=;
        b=qnHRaTyJpvu9lUZ9rmD/JMhEQHZfFxcWkXzxd/RFaYg1qg8o4juhhgNFs8y7CWp0h1
         qa9/GX7YeInBXRzFQbUSbe/8WW6Z/8W4Wrp6iyU4jTquSJNr7kVQZmxzM3D3QXSvrODJ
         rEKLGeOBv4iWkzaeWWyFTQo+Tp4RL0ViRHamcxdz2yTvFJ0K7KSuWavLMi6H/HMxkQ16
         UIUEA/i3qs4Lb/F6iJCuX69iWCRzFrngNTVrLu4eqXbd0mOXb/yBvA5+Wn38EvStVg2d
         LYpHqYuuBY3pDstJeDvWfNri+sHwiUdV0RUxKHKZoEz7FAm2NmJXvsN8cLZeKIzZOXwP
         VGHQ==
X-Gm-Message-State: APjAAAW8ivGnuFWFrFIJnTnxgMmVjt2tOtvP+CHb0uzRdU3wNAQ85LFH
        gmp91RsMTFTqz9SI76oZh3RKqiEfSm6csrmhR/mRVg==
X-Google-Smtp-Source: APXvYqzZs94CLTPNtEOYUE3fPG/Fo1fnQN3kFLmROvw+v8aNS7cQMk9CTW2FiPWDlpzolz9aC8Su/VC/9T/aUP4Giyk=
X-Received: by 2002:a67:2d08:: with SMTP id t8mr3880063vst.178.1565360636286;
 Fri, 09 Aug 2019 07:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
 <1562092745-11541-5-git-send-email-sagar.kadam@sifive.com> <f3a1617e-0478-63ea-ab76-feaab7ac1e9b@ti.com>
In-Reply-To: <f3a1617e-0478-63ea-ab76-feaab7ac1e9b@ti.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Fri, 9 Aug 2019 19:53:45 +0530
Message-ID: <CAARK3HkRgchmPZRpHfHj69OMUn=K7Zp-az5YYtBOW_jdASgYyw@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] mtd: spi-nor: add locking support for is25wp256 device
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Palmer Dabbelt <palmer@sifive.com>,
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

Hello Vignesh,

On Fri, Aug 9, 2019 at 4:57 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi Sagar,
>
> On 03/07/19 12:09 AM, Sagar Shrikant Kadam wrote:
> [...]> +static int issi_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
> > +{
> > +     int status_old, status_new, blk_prot;
> > +     u8 mask;
> > +     u8 shift;
> > +     u8 pow, ret, func_reg;
> > +     bool use_top;
> > +     loff_t lock_len;
> > +
> > +     if (nor->flags & SNOR_F_HAS_BP3)
> > +             mask = SR_BP3 | SR_BP2 | SR_BP1 | SR_BP0;
> > +     else
> > +             mask = SR_BP2 | SR_BP1 | SR_BP0;
> > +
> > +     shift = ffs(mask) - 1;
> > +
> > +     status_old = read_sr(nor);
> > +
> > +     /* if status reg is Write protected don't update bit protection */
> > +     if (status_old & SR_SRWD) {
> > +             dev_err(nor->dev,
> > +                     "SR is write protected, can't update BP bits...\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = spi_nor_select_zone(nor, ofs, len, status_old, &use_top, 1);
> > +     if (!ret)
> > +             /* Older protected blocks include the new requested block's */
> > +             return 0;
> > +     else if (ret < 0)
> > +             return ret;
> > +
> > +     func_reg = spi_nor_read_fr(nor);
>
Thank you for reviewing the patch.
> Sorry, I don't understand where func_reg is used? Since TBS OTP, how
> does issi_lock() code comprehend that TBS bit value in OTP register and
> use_top returned by spi_nor_select_zone() are matching before we go
> ahead and program status register.
>
In my earlier version of this patch, you had suggested an approach to skip
updating the TBS OTP bits as ones written that cannot be changed.
Actually, func_reg was used to update the OTP section, sorry I missed
removing the func_reg reference here as per your suggestion.
I will update a new version of this patch which will not modify the OTP
region and will return with an error when locking the requested region by
the user is not possible.

> We should reject locking request if top-bottom calculation does not
> match OTP bit. Where is that done?
>
> Regards
> Vignesh
>

Thanks & BR,
Sagar
> > +     /* lock_len: length of region that should end up locked */
> > +     if (use_top)
> > +             lock_len = nor->mtd.size - ofs;
> > +     else
> > +             lock_len = ofs + len;
> > +
> > +     pow = order_base_2(lock_len);
> > +     blk_prot = mask & (((pow + 1) & 0xf) << shift);
> > +     if (lock_len <= 0) {
> > +             dev_err(nor->dev, "invalid Length to protect");
> > +             return -EINVAL;
> > +     }
> > +
> > +     status_new = status_old | blk_prot;
> > +     if (status_old == status_new)
> > +             return 0;
> > +
> > +     return write_sr_and_check(nor, status_new, mask);
> > +}
> > +
> > +/**
> >   * issi_unlock() - clear BP[0123] write-protection.
> >   * @nor: pointer to a 'struct spi_nor'.
> >   * @ofs: offset from which to unlock memory.
> > @@ -4171,6 +4338,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >       if (JEDEC_MFR(info) == SNOR_MFR_ISSI &&
> >           info->flags & SPI_NOR_HAS_LOCK &&
> >           info->flags & SPI_NOR_HAS_BP3) {
> > +             nor->flash_lock = issi_lock;
> >               nor->flash_unlock = issi_unlock;
> >       }
> >
> > @@ -4194,6 +4362,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >               nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
> >       if (info->flags & USE_CLSR)
> >               nor->flags |= SNOR_F_USE_CLSR;
> > +     if (info->flags & SPI_NOR_HAS_BP3)
> > +             nor->flags |= SNOR_F_HAS_BP3;
> >
> >       if (info->flags & SPI_NOR_NO_ERASE)
> >               mtd->flags |= MTD_NO_ERASE;
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index f6fa70f..26dbf48 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -40,6 +40,8 @@
> >  #define SPINOR_OP_RDSR               0x05    /* Read status register */
> >  #define SPINOR_OP_WRSR               0x01    /* Write status register 1 byte */
> >  #define SPINOR_OP_RDSR2              0x3f    /* Read status register 2 */
> > +#define SPINOR_OP_RDFR               0x48    /* Read Function register */
> > +#define SPINOR_OP_WRFR               0x42    /* Write Function register 1 byte */
> >  #define SPINOR_OP_WRSR2              0x3e    /* Write status register 2 */
> >  #define SPINOR_OP_READ               0x03    /* Read data bytes (low frequency) */
> >  #define SPINOR_OP_READ_FAST  0x0b    /* Read data bytes (high frequency) */
> > @@ -139,6 +141,9 @@
> >  /* Enhanced Volatile Configuration Register bits */
> >  #define EVCR_QUAD_EN_MICRON  BIT(7)  /* Micron Quad I/O */
> >
> > +/*Function register bit */
> > +#define FR_TB                        BIT(1)  /*ISSI: Top/Bottom protect */
> > +
> >  /* Flag Status Register bits */
> >  #define FSR_READY            BIT(7)  /* Device status, 0 = Busy, 1 = Ready */
> >  #define FSR_E_ERR            BIT(5)  /* Erase operation status */
> >
>
> --
> Regards
> Vignesh
