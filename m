Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAECC2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDAJ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:26:07 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34879 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDAJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:26:06 -0400
Received: by mail-ua1-f67.google.com with SMTP id f88so2818305uaf.2;
        Mon, 01 Apr 2019 02:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/zrkTRHXZhK33NRMz6bOEjVF2oOULEfSZzLKWRdAtU=;
        b=fcqSzgW/N8N7RiJaGw1lkxjYv3siRBXyY9VYc7Kf/rnR8wp8v+tF0nmu9aQCoQbF3p
         eEZ6Umh87lqips0U2XaGQvhRIHXzYS10uBjux05mEMzZdTUQ+BrhJSRIAcOquwM1hHhl
         Q48vfm9y/cWiyjJ0YP6mEhZqVFi6oIeIWffHqvs+cu/GBTKFj9jcHGruuMDZuN0Uvhop
         PlCaF0n+YeaQWOZZcbS0Xk1Z7xOfvYeHAyl9g9eMMmO9vc8Q+eBLXyhAqW3cQga2qfDW
         mjN0QeV8/Yh3IIYPmVhYhx2aQVtbsnx3A6DVBSPQPG2w2BKN0zp1BnzAsToSjn01ODgQ
         YjTQ==
X-Gm-Message-State: APjAAAVoC8RD8WnoOkTFI7vm/nCPFDkPYKjgxkbBrOOUzvbozaQwGwbh
        oGpWqfGFdUygzoGNTrgfgvkYLo95wp2gEfN1GiU=
X-Google-Smtp-Source: APXvYqyhPUcsgP0qm6qss9qbiWENl7RatHZMLZNNo1ni55c3ZwgdUjGmXlZmRmeaojRqlnPKboctCDUj4+UwOFwpsUI=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr31251001uao.86.1554110764857;
 Mon, 01 Apr 2019 02:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190330141637.22632-1-boris.brezillon@collabora.com>
In-Reply-To: <20190330141637.22632-1-boris.brezillon@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Apr 2019 11:25:53 +0200
Message-ID: <CAMuHMdUEyBFLu0XRDHKoZgUHdA09FHNK5xCpS+PaBO5eWYo2iw@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at25: Convert the driver to the spi-mem interface
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Sat, Mar 30, 2019 at 3:16 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> The AT25 protocol fits pretty well in the spi-mem model. Convert the
> at25 spi driver to a spi-mem driver and use the dirmap API instead of
> forging SPI messages manually.
> This makes the driver compatible with spi-mem-only controllers
> (controllers implementing only the spi_mem ops).

Thanks for your patch!

> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c

> @@ -63,17 +68,89 @@ struct at25_data {
>
>  #define        io_limit        PAGE_SIZE       /* bytes */
>
> +static int at25_create_dirmaps(struct at25_data *at25)
> +{
> +       struct spi_mem_dirmap_info info = {
> +               .op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(AT25_READ, 1),
> +                                     SPI_MEM_OP_ADDR(at25->addrlen, 0, 1),
> +                                     SPI_MEM_OP_NO_DUMMY,
> +                                     SPI_MEM_OP_DATA_IN(0, NULL, 1)),
> +               .offset = 0,
> +               .length = at25->chip.byte_len,
> +       };
> +       struct device *dev = &at25->spimem->spi->dev;
> +
> +       if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
> +               info.length = 256;

Note that by hardcoding 256 you do loose the ability to support chips
where EE_INSTR_BIT3_IS_ADDR is set, _and_ more than one address byte is
used (i.e. extra bit is A16 or A24).
While the code parsing "address-width" doesn't handle that, the comment
for EE_INSTR_BIT3_IS_ADDR suggests such chips do exist (I doubt it,
though, but you may know better), and the flag can be enabled through
the "at25,addr-mode" property, or through platform_data.

> @@ -82,38 +159,14 @@ static int at25_ee_read(void *priv, unsigned int offset,
>         if (unlikely(!count))
>                 return -EINVAL;
>
> -       cp = command;
> -
> -       instr = AT25_READ;
> -       if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
> -               if (offset >= (1U << (at25->addrlen * 8)))
> -                       instr |= AT25_INSTR_BIT3;
> -       *cp++ = instr;
> -
> -       /* 8/16/24-bit address is written MSB first */
> -       switch (at25->addrlen) {
> -       default:        /* case 3 */
> -               *cp++ = offset >> 16;
> -               /* fall through */
> -       case 2:
> -               *cp++ = offset >> 8;
> -               /* fall through */
> -       case 1:
> -       case 0: /* can't happen: for better codegen */
> -               *cp++ = offset >> 0;
> +       if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR && offset > 255) {

Loss of support for address bit A16/A24.

> +               desc = at25->dirmap.rdesc[1];
> +               dirmap_offset = offset - 256;
> +       } else {
> +               desc = at25->dirmap.rdesc[0];
> +               dirmap_offset = offset;
>         }

> @@ -158,48 +211,37 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>          */
>         mutex_lock(&at25->lock);
>         do {
> +               struct spi_mem_dirmap_desc *desc;
>                 unsigned long   timeout, retries;
>                 unsigned        segment;
> -               unsigned        offset = (unsigned) off;
> -               u8              *cp = bounce;
> +               unsigned int    dirmap_offset;
>                 int             sr;
> -               u8              instr;
>
> -               *cp = AT25_WREN;
> -               status = spi_write(at25->spi, cp, 1);
> +               status = at25_wren(at25);
>                 if (status < 0) {
> -                       dev_dbg(&at25->spi->dev, "WREN --> %d\n", status);
> +                       dev_dbg(&at25->spimem->spi->dev, "WREN --> %d\n",
> +                               status);
>                         break;
>                 }
>
> -               instr = AT25_WRITE;
> -               if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
> -                       if (offset >= (1U << (at25->addrlen * 8)))
> -                               instr |= AT25_INSTR_BIT3;
> -               *cp++ = instr;
> -
> -               /* 8/16/24-bit address is written MSB first */
> -               switch (at25->addrlen) {
> -               default:        /* case 3 */
> -                       *cp++ = offset >> 16;
> -                       /* fall through */
> -               case 2:
> -                       *cp++ = offset >> 8;
> -                       /* fall through */
> -               case 1:
> -               case 0: /* can't happen: for better codegen */
> -                       *cp++ = offset >> 0;
> +               if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR && off > 255) {

Loss of support for address bit A16/A24.

> +                       desc = at25->dirmap.wdesc[1];
> +                       dirmap_offset = off -  256;

Two spaces after minus sign.

> +               } else {
> +                       desc = at25->dirmap.wdesc[0];
> +                       dirmap_offset = off;
>                 }

> @@ -211,10 +253,9 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>                 timeout = jiffies + msecs_to_jiffies(EE_TIMEOUT);
>                 retries = 0;
>                 do {
> -
> -                       sr = spi_w8r8(at25->spi, AT25_RDSR);
> +                       sr = at25_rdsr(at25);
>                         if (sr < 0 || (sr & AT25_SR_nRDY)) {
> -                               dev_dbg(&at25->spi->dev,
> +                               dev_dbg(&at25->spimem->spi->dev,
>                                         "rdsr --> %d (%02x)\n", sr, sr);

You might want to move the debug print inside the new function
at25_rdsr(), as there's another call plus debug print in at25_probe().

> @@ -328,37 +369,49 @@ static int at25_probe(struct spi_device *spi)
>         else if (chip.flags & EE_ADDR3)
>                 addrlen = 3;
>         else {
> -               dev_dbg(&spi->dev, "unsupported address type\n");
> +               dev_dbg(&spimem->spi->dev, "unsupported address type\n");
>                 return -EINVAL;
>         }
>
> -       /* Ping the chip ... the status register is pretty portable,
> -        * unlike probing manufacturer IDs.  We do expect that system
> -        * firmware didn't write it in the past few milliseconds!
> -        */
> -       sr = spi_w8r8(spi, AT25_RDSR);
> -       if (sr < 0 || sr & AT25_SR_nRDY) {
> -               dev_dbg(&spi->dev, "rdsr --> %d (%02x)\n", sr, sr);
> -               return -ENXIO;
> -       }
> -
> -       at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);
> +       at25 = devm_kzalloc(&spimem->spi->dev, sizeof(struct at25_data),
> +                           GFP_KERNEL);
>         if (!at25)
>                 return -ENOMEM;
>
>         mutex_init(&at25->lock);
>         at25->chip = chip;
> -       at25->spi = spi;
> -       spi_set_drvdata(spi, at25);
> +       at25->spimem = spimem;
> +       spi_mem_set_drvdata(spimem, at25);
>         at25->addrlen = addrlen;
>
> -       at25->nvmem_config.name = dev_name(&spi->dev);
> -       at25->nvmem_config.dev = &spi->dev;
> +       /*
> +        * Can't be allocated with devm_kmalloc() because we need a DMA-safe
> +        * buffer.
> +        */

That is no longer true as of commit a66d972465d15b1d ("devres: Align
data[] to ARCH_KMALLOC_MINALIGN") in v4.20-rc5, right?

> +       at25->scratchbuf = kmalloc(1, GFP_KERNEL);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
