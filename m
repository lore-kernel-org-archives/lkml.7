Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3837C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA57C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iNjxUkk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfFQPkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:40:16 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40547 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:40:15 -0400
Received: by mail-ua1-f68.google.com with SMTP id s4so3653908uad.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xHCh/5/rajrFwBWcxrYmQ2rJ/d9uDBLferqy5gsc5o=;
        b=iNjxUkk6tKL7h6GWxxpTadhgfrjy1TgdbpkEPYvg7MY3UCHkHrHKVVBONZzW2DJsEl
         PJeI7wx8pSQBvfDtvV4HFTfxw4CWQaDaOrLLrDFGbJdSMV5KFzpqtYE/B+X30PUMXxC8
         D2ZAkv11pMF7tFbT8OyYfRdc1HnL51qEfe+k/LE37uxWrWFoO6zluyjaOjmarrwb4Lr0
         M0zwGvulTwtpjlCdgF0cmoOiX26RFl1h/FgeDm985WZoQCKIIxAdqXhBmSWY+B5wu7t3
         c+BCjr8pBnq9sHU41D96E/3t2YKceWbrK163rl59O/mU6PSzISc384X2FidLxQ8DprF1
         +eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xHCh/5/rajrFwBWcxrYmQ2rJ/d9uDBLferqy5gsc5o=;
        b=B5uCBYUv1hPuAEgViCyCkDxj7owE0/rlfzD+3SAk0d49h/CY6Hmee0bCwTXBVqGF3z
         qWb7mbuJ6lMHR0DT4itSSLLrqZiDNmEFwBZEkowfp5atOnGr1iJQE9I+S8uaJUJIINoX
         SqWtsTs2sl+xe+qUEuyVQKAEPe6mopuL3QU17ocuYAC1HLXIPRJ2b7MwwnqV86gbPBdj
         CWzhbr6P2kVUanPjaAQtCLO2bl1y6GYZfr0jNvEerqxpeqrgcGbMSsz4KLDO8gt5D8dV
         HyR+8D0ih31ySPrlnDLqGg58YfFed4RBGZ9Kp5D8iIRmZQCm8JSIIXj8viPGZeQYTKH9
         azqg==
X-Gm-Message-State: APjAAAUATZ4u+dP1Frowq2pyDG2QEJ/r6+cqyrM73PdnmFsICFmZaXHx
        YYnxDb+Bw9cslaP7MIaYaJ+urHOxeqeDPc6Jfnunig==
X-Google-Smtp-Source: APXvYqwcs6MIyZsucbjzRDDsDgKyPNBaK5l7jkhpkBXUGYaRrgzJjV8YqNDp7nbsnUgIo3NsZ+/PB4mrET6IlwpvVeI=
X-Received: by 2002:ab0:30c7:: with SMTP id c7mr7769825uam.143.1560786014401;
 Mon, 17 Jun 2019 08:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
 <1560336476-31763-3-git-send-email-sagar.kadam@sifive.com> <70732c8e-111f-7c46-9e93-11894d944a1d@ti.com>
In-Reply-To: <70732c8e-111f-7c46-9e93-11894d944a1d@ti.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Mon, 17 Jun 2019 21:10:02 +0530
Message-ID: <CAARK3HmFg=v+cMGAykPPpwxDGaSKk5k+Gz4fSHQPQmg-rCjPhQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: add support to unlock flash device
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vignesh,

On Sun, Jun 16, 2019 at 6:35 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
>
>
> On 12-Jun-19 4:17 PM, Sagar Shrikant Kadam wrote:
> > Nor device (is25wp256 mounted on HiFive unleashed Rev A00 board) from ISSI
> > have memory blocks guarded by block protection bits BP[0,1,2,3].
> >
> > Clearing block protection bits,unlocks the flash memory regions
> > The unlock scheme is registered during nor scans.
> >
> > Based on code developed by Wesley Terpstra <wesley@sifive.com>
> > and/or Palmer Dabbelt <palmer@sifive.com>.
> > https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
> >
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/mtd/spi-nor.h   |  1 +
> >  2 files changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index 2d5a925..b7c6261 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1461,6 +1461,49 @@ static int macronix_quad_enable(struct spi_nor *nor)
> >  }
> >
> >  /**
> > + * issi_unlock() - clear BP[0123] write-protection.
> > + * @nor: pointer to a 'struct spi_nor'.
> > + * @ofs: offset from which to unlock memory.
> > + * @len: number of bytes to unlock.
> > + *
> > + * Bits [2345] of the Status Register are BP[0123].
> > + * ISSI chips use a different block protection scheme than other chips.
> > + * Just disable the write-protect unilaterally.
> > + *
> > + * Return: 0 on success, -errno otherwise.
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
> > +             ret = 0;
> > +     } else {
> > +             dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
> > +             ret = -EINVAL;
> > +     }
> > +     return ret;
> > +}
> > +
> > +/**
> >   * spansion_quad_enable() - set QE bit in Configuraiton Register.
> >   * @nor:     pointer to a 'struct spi_nor'
> >   *
> > @@ -1836,7 +1879,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >       { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
> >                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > -                     SPI_NOR_4B_OPCODES)
> > +                     SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK)
> >       },
> >
> >       /* Macronix */
> > @@ -4080,6 +4123,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >               nor->flash_is_locked = stm_is_locked;
> >       }
> >
> > +     /* NOR protection support for ISSI chips */
> > +     if (JEDEC_MFR(info) == SNOR_MFR_ISSI ||
> > +         info->flags & SPI_NOR_HAS_LOCK) {
>
> This should be:
>
>         if (JEDEC_MFR(info) == SNOR_MFR_ISSI &&
>             info->flags & SPI_NOR_HAS_LOCK) {
>
> Otherwise you would end up overriding nor->flash_unlock function for
> other vendors too, right?
>
Yes, right. I will submit a v6 for this.

> > +             nor->flash_unlock = issi_unlock;
> > +
>
> No need for blank line here.
> Please run ./scripts/checkpatch.pl --strict on all patches and address
> all the issues reported by it.
>
>
Ok. The plain checkpatch.pl run didn't catch this.
I will fix this and provide a v6 for this.
>
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
>
> No need to mention ISSI here. I am sure there are devices from other
> vendors with BP3
>
Ok, I will drop this in V6 and submit.

> >  #define SR_TB                        BIT(5)  /* Top/Bottom protect */
> >  #define SR_SRWD                      BIT(7)  /* SR write protect */
> >  /* Spansion/Cypress specific status bits */
> >
>
> Regards
> Vignesh

Thanks & BR,
Sagar Kadam
