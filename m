Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C304EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DFB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov4DmxlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfHZJt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:49:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36509 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbfHZJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:49:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so14664152wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRJggX7YIR4Be7LdvQ6FETMjFuA1o4T1Bifqrd91O8w=;
        b=Ov4DmxlBukVF49VNclkW4aC22NS730ye9Gw42K0t0pO1pjDRc/khSQoDy5QnfTOdl8
         iI4NE/0Qi8tV1a1eKvj9YCPW976qk/a3ANHh4l/JQmqW7yzp83yQcM/XlGz7F3UeHjQn
         PKAy41MGB2eD8c7ypk2gevobgKIeZjE4JjkE8A6DUn2Saxo+96+Cf9DmEJGe88/i1G3+
         5AitmlfO36eb+lKmNxhmfkMKSza61HD63veVI6bygNNbm3H++f/poHu+hl2Zm05XeKAK
         WRnUEsgzgwzIEazTHZWFXV5m1C5oGncvj1j20IQ5pADEgohoAgFgA1jsIjmC0dchsLKz
         j6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRJggX7YIR4Be7LdvQ6FETMjFuA1o4T1Bifqrd91O8w=;
        b=VEQAQVGsHZEsCR8ROB88Ptn5rnUcuOeLIuTVzgMFwr5IQfZN7S0AkcUONm7QgCKOv+
         XLg0BaKx2QwE5ed2zEtBgTrzxJT8lsYqOOBKUzzsTMjJaKVGeSi+GDyIhE0opx1+D3L7
         q7R89ld4GhaipquX8TENVO5LTj4iEg+hwosm7MlbX3WloaVW7a9vnoeqOFmCZdK5ReFk
         wNw0E4yQArNMydMS6FNQuh/5CfAdmc7bmisT+ef9SLbyffB05VtiX1p1vE+OTYqiMqhi
         GGWnfczXjqFX1p6lyk2+qcLAMcIYLAacbWEY1jw+W4XdK6ahVCljQC0WRHoF6TCAUqD+
         QdgA==
X-Gm-Message-State: APjAAAX6KTz8SuW0bqa787Bn25S7WqTyFkjawv2Y4eecJEyhksxso8tD
        kOPNuNZNVrCsNJsZtSY8w442beJHME6MSt5ScXc=
X-Google-Smtp-Source: APXvYqyP94sNCqmjuVfA73Ep3VyTRiU2sKL2YtThnnM2sGDiG0z+2syRZB4fLuTD+atX0WlgXOTl5YFu2TfY5IifZgE=
X-Received: by 2002:adf:a2cd:: with SMTP id t13mr20003170wra.251.1566812993586;
 Mon, 26 Aug 2019 02:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com> <1565699895-4770-2-git-send-email-sagar.kadam@sifive.com>
In-Reply-To: <1565699895-4770-2-git-send-email-sagar.kadam@sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 26 Aug 2019 17:49:42 +0800
Message-ID: <CAEUhbmU6xHjUWK3iM_RqURHGuqgmSxQw6RtWthT4+2aL1xLDcA@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] mtd: spi-nor: add support for is25wp256
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
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

On Tue, Aug 13, 2019 at 8:40 PM Sagar Shrikant Kadam
<sagar.kadam@sifive.com> wrote:
>
> Update spi_nor_id table for is25wp256 (32MB) device from ISSI,
> present on HiFive Unleashed dev board (Rev: A00).
>
> Set method to enable quad mode for ISSI device in flash parameters
> table.
>
> Based on code originally written by Wesley Terpstra <wesley@sifive.com>
> and/or Palmer Dabbelt <palmer@sifive.com>
> https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
>
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++++-
>  include/linux/mtd/spi-nor.h   | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 03cc788..6635127 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1946,7 +1946,10 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
>                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
>                         SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -
> +       { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,

The sector number should be 512, not 1024.

> +                       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                       SPI_NOR_4B_OPCODES)
> +       },
>         /* Macronix */
>         { "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
>         { "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
> @@ -3776,6 +3779,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
>                 case SNOR_MFR_ST:
>                 case SNOR_MFR_MICRON:
>                         break;
> +               case SNOR_MFR_ISSI:
> +                       params->quad_enable = macronix_quad_enable;
> +                       break;
> +
>
>                 default:
>                         /* Kept only for backward compatibility purpose. */
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 9f57cdf..5d6583e 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -21,6 +21,7 @@
>  #define SNOR_MFR_INTEL         CFI_MFR_INTEL
>  #define SNOR_MFR_ST            CFI_MFR_ST      /* ST Micro */
>  #define SNOR_MFR_MICRON                CFI_MFR_MICRON  /* Micron */
> +#define SNOR_MFR_ISSI          0x9d            /* ISSI */
>  #define SNOR_MFR_MACRONIX      CFI_MFR_MACRONIX
>  #define SNOR_MFR_SPANSION      CFI_MFR_AMD
>  #define SNOR_MFR_SST           CFI_MFR_SST

Regards,
Bin
