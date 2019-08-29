Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE40C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FC423403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7Y/+uHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfH2Ner (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:34:47 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40590 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfH2Nep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:34:45 -0400
Received: by mail-vs1-f68.google.com with SMTP id i128so2406379vsc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LwGddfzeX4mOzZ5JoPgRwznEXqsWR+GA5wz76u8ncg=;
        b=R7Y/+uHZ9h7ZpNJZej4KVWDiSM2Jsx86a+2rjv3viGQT70JryZyZZt4cNvtB0oX2/w
         DvmTYK1CIdpNQooHQdGj+3W1x7TabAOJNngFN2DFwYGMoo360fE+iEzbn+HyTS9wPfp4
         sKItf31dCS+KDtU9DnekStb2wihbWiJs680hvwuko6xU2ss+NvsOSzwDaOaIADiKvbx8
         ihe9RzO8uf4gfY62Gym89Uv0jHKVdUp91Opy5WWQv3hWUqstfoKVgRgqvOlPkkDorwkB
         7PvnkYTHuk1GDba4J/RB0LmaA7sRNLMUmrA0dso5gqvCJFchEc+fhv8yKi0eaCzxLEZq
         HP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LwGddfzeX4mOzZ5JoPgRwznEXqsWR+GA5wz76u8ncg=;
        b=mfrFiI28AVtXeGPSQykNNBRgtmoZMBdiKeae60AvVEPmMSToeX8Dn2t5GMktRiefmM
         8PkF7pkACkAaDdumdu9Ge7mRNGp3phkdvMGwavuvdQZSvLUsqnzuCnEBcFiOZXEfcvBI
         HQkqZBDufioS4/dcaLgNQ00ouSVZ6pYOP64IMf3sK8Sc2bL9XBSnZMP3drMsvo9XK1YY
         BMJ+iHclU7UZsMsGY4mggcM/GXxhS53AxZDuQ/TuYL9sxbdZxdvwTJEI1DSKTotRVseQ
         i2YUPPupG0+H8rE+aCrydXmjPYIFeoWx24ljs+NEcR907PbZHoo24cJJR/ZGM9zOCD63
         qakQ==
X-Gm-Message-State: APjAAAXot88fyCIUZicButtoUzDmbqlWVNiBXKV7Opqtn2Qr6Zk+KKej
        +PGLPla7LXb7Yxxg3T5or32/QxdwOSJnK1mdUXewYKck
X-Google-Smtp-Source: APXvYqxirmJH4cL7eOUn3SpAsT/GI4gJKeANjViJ2y2P3ZBRhl2NHvAa8yLs3iWPeSiRlqzxQFoA7JJgfGfBFLCetWo=
X-Received: by 2002:a67:61c7:: with SMTP id v190mr5467601vsb.165.1567085684495;
 Thu, 29 Aug 2019 06:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190829112206.22213-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190829112206.22213-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 15:34:08 +0200
Message-ID: <CAPDyKFqrQF8nBfLOHNyqM_LfPx7XjRCHT_PVzDKb98qxVjdSGQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: use lower/upper_32_bits() macros for DMA addresses
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 at 13:22, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, the DMA addresses are casted to (u64) for the upper 32bits
> to avoid "right shift count >= width of type" warning.
>
> <linux/kernel.h> provides macros to address this, and I like the macro
> names are self-documenting.
>
> I introduced a new helper, sdhci_set_adma_addr() to avoid the code
> duplication.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2:
>   - Another way to reduce linu wrapping
>
>  drivers/mmc/host/sdhci.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 08cc0792c174..66c2cf89ee22 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -668,10 +668,10 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>         /* 32-bit and 64-bit descriptors have these members in same position */
>         dma_desc->cmd = cpu_to_le16(cmd);
>         dma_desc->len = cpu_to_le16(len);
> -       dma_desc->addr_lo = cpu_to_le32((u32)addr);
> +       dma_desc->addr_lo = cpu_to_le32(lower_32_bits(addr));
>
>         if (host->flags & SDHCI_USE_64_BIT_DMA)
> -               dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
> +               dma_desc->addr_hi = cpu_to_le32(upper_32_bits(addr));
>
>         *desc += host->desc_sz;
>  }
> @@ -816,6 +816,13 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>         }
>  }
>
> +static void sdhci_set_adma_addr(struct sdhci_host *host, dma_addr_t addr)
> +{
> +       sdhci_writel(host, lower_32_bits(addr), SDHCI_ADMA_ADDRESS);
> +       if (host->flags & SDHCI_USE_64_BIT_DMA)
> +               sdhci_writel(host, upper_32_bits(addr), SDHCI_ADMA_ADDRESS_HI);
> +}
> +
>  static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  {
>         if (host->bounce_buffer)
> @@ -826,13 +833,10 @@ static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>
>  static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
>  {
> -       if (host->v4_mode) {
> -               sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
> -               if (host->flags & SDHCI_USE_64_BIT_DMA)
> -                       sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
> -       } else {
> +       if (host->v4_mode)
> +               sdhci_set_adma_addr(host, addr);
> +       else
>                 sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
> -       }
>  }
>
>  static unsigned int sdhci_target_timeout(struct sdhci_host *host,
> @@ -1095,12 +1099,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>                         host->flags &= ~SDHCI_REQ_USE_DMA;
>                 } else if (host->flags & SDHCI_USE_ADMA) {
>                         sdhci_adma_table_pre(host, data, sg_cnt);
> -
> -                       sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
> -                       if (host->flags & SDHCI_USE_64_BIT_DMA)
> -                               sdhci_writel(host,
> -                                            (u64)host->adma_addr >> 32,
> -                                            SDHCI_ADMA_ADDRESS_HI);
> +                       sdhci_set_adma_addr(host, host->adma_addr);
>                 } else {
>                         WARN_ON(sg_cnt != 1);
>                         sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
> --
> 2.17.1
>
