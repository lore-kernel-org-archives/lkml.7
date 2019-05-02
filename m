Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA49C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F592075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dwHn/Twm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEBJ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:56:55 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34074 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBJ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:56:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id b23so1018369vso.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTKXG2BvapVjfHjBieKgNIDpAb1iozjfKpPYlJpJCFY=;
        b=dwHn/TwmEZtLalAjTJaZ3KIcPdZ9rZYVCzoASmcBLCQ2HZz+JrS8iAHfSMi03PVOlX
         jhQJRblKhXQte3p8Dps8571Kx2Pm4z1iWhEdMaUSI3abVmfoUcnOZIU7f8HmmAorvpZT
         N4ReNlAJZyVfyPyNBN0iox/p+5gU8/icOBDPUqW0CCMcy8o6sSB1m8SQHRyRAXGn63YB
         0sQcy7iQrHetWP89TrhaBNg0n90VomGRDsDNsRjxtqAWyS8aFNdg9Gjck0mhE9McG1rN
         ah7Ik2b0DBjcwiGSizHzzAa4obeoj7CpVfh7L1vdlFvow8Id7IiUeDYh7ftUDN5RuvdO
         g89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTKXG2BvapVjfHjBieKgNIDpAb1iozjfKpPYlJpJCFY=;
        b=GYJz6Sy7gn2XEhHZ8C8BBHhhVHrCFfPZbvJIBOYNqkoEf/Vu9XTLw5OH+Rbp/ALNIo
         ey8VqcpgbB80Uc8avfBulleHjwFn5vWLqXh9BeUToesHcdADpGHfaZJLW/e9IcKsPCwl
         OzqxayKv7JPTLRCJweAUOhE2P/xBs7Ci2jvipY+YupORBiyOCYGIxVRbJsntWMoRFi59
         UNMeGmsvaX0bv1sGmAqO+g/vwqx+PzAkgcGlb4JRPWUwe8NyBaRvTY73cfRTt2fMQvOb
         rRCZ/ZEK+Cw+bjTuzpKtmgR6L78BnFv/QLBwygcpihhOFL8+VjuFrtM1lLQMfAzIUlJt
         wsjA==
X-Gm-Message-State: APjAAAVpQW7GyJLKgb4ACONOKvfOXC6Z1RzlTQG0OHX0PoRG6e/kkWHV
        NzY5vAhOorow/KOKJCxW4s8wO2nOWFbxIYo0XWc/sg==
X-Google-Smtp-Source: APXvYqzna4Ba9px66ruZmRjnBEj2xyZLRILQtXV8Oiu172P7DHpQmbk1B3YbTZWyFveVlgVkmqJjC9k4n8Us7sC2mlY=
X-Received: by 2002:a67:7286:: with SMTP id n128mr1437892vsc.116.1556791013544;
 Thu, 02 May 2019 02:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com>
 <1556474956-27786-3-git-send-email-sagar.kadam@sifive.com> <alpine.DEB.2.21.9999.1904301016400.7063@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1904301016400.7063@viisi.sifive.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Thu, 2 May 2019 15:26:42 +0530
Message-ID: <CAARK3HmzH8cNb1rTtWGwg3g8cOkGFx52v=eomZWcBkeLcx4+-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: add support to unlock flash device.
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

On Tue, Apr 30, 2019 at 10:49 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Sun, 28 Apr 2019, Sagar Shrikant Kadam wrote:
>
> > Nor device (is25wp256 mounted on HiFive unleashed Rev A00 board) from ISSI
> > have memory blocks guarded by block protection bits BP[0,1,2,3].
> >
> > Clearing block protection bits,unlocks the flash memory regions
> > The unlock scheme is registered during nor scans.
>
> This also looks like it's partially based on Wes or Palmer's patch from
>
> https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
>
> Please note that in the patch message.
Thank you Paul for pointing this out.
Yes,  I missed to add it to commit message and will submit a V3
version of the patch.

> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/mtd/spi-nor.h   |  1 +
> >  2 files changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index c5408ed..81c7b3e 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1461,6 +1461,46 @@ static int macronix_quad_enable(struct spi_nor *nor)
> >  }
> >
> >  /**
> > + * issi_unlock() - clear BP[0123] write-protection.
> > + * @nor: pointer to a 'struct spi_nor'
> > + * @ofs: offset from which to unlock memory
> > + * @len: number of bytes to unlock
> > + * Bits [2345] of the Status Register are BP[0123].
> > + * ISSI chips use a different block protection scheme than other chips.
> > + * Just disable the write-protect unilaterally.
> > + * Return: 0 on success, -errno otherwise.
>
> This is closer to kernel-doc format, but not quite.  Please update this to
> align to
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst#n57
>
This is a good pointer. I will align the function description
according to kernel-doc format.

>
> - Paul
>
> > + */
> > +static int issi_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
> > +{
> > +     int ret, val;
> > +     u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
> > +
> > +     val = read_sr(nor);
> > +     if (val < 0)
> > +             return val;
> > +     if (!(val & mask))
> > +             return 0;
> > +
> > +     write_enable(nor);
> > +
> > +     write_sr(nor, val & ~mask);
> > +
> > +     ret = spi_nor_wait_till_ready(nor);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = read_sr(nor);
> > +     if (ret > 0 && !(ret & mask)) {
> > +             dev_info(nor->dev,
> > +                     "ISSI Block Protection Bits cleared SR=0x%x", ret);
> > +             return 0;
> > +     } else {
> > +             dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +/**
> >   * spansion_quad_enable() - set QE bit in Configuraiton Register.
> >   * @nor:     pointer to a 'struct spi_nor'
> >   *
> > @@ -1836,7 +1876,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >       { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > -                     SPI_NOR_4B_OPCODES)
> > +                     SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK)
> >       },
> >
> >       /* Macronix */
> > @@ -4078,6 +4118,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >               nor->flash_is_locked = stm_is_locked;
> >       }
> >
> > +     /* NOR protection support for ISSI chips */
> > +     if (JEDEC_MFR(info) == SNOR_MFR_ISSI ||
> > +         info->flags & SPI_NOR_HAS_LOCK) {
> > +             nor->flash_unlock = issi_unlock;
> > +
> > +     }
> >       if (nor->flash_lock && nor->flash_unlock && nor->flash_is_locked) {
> >               mtd->_lock = spi_nor_lock;
> >               mtd->_unlock = spi_nor_unlock;
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index ff13297..9a7d719 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -127,6 +127,7 @@
> >  #define SR_BP0                       BIT(2)  /* Block protect 0 */
> >  #define SR_BP1                       BIT(3)  /* Block protect 1 */
> >  #define SR_BP2                       BIT(4)  /* Block protect 2 */
> > +#define SR_BP3                       BIT(5)  /* Block protect 3 for ISSI device*/
> >  #define SR_TB                        BIT(5)  /* Top/Bottom protect */
> >  #define SR_SRWD                      BIT(7)  /* SR write protect */
> >  /* Spansion/Cypress specific status bits */
> > --
> > 1.9.1
> >
> >
