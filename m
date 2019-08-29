Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDE4C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929B922CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bUPMhAOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfH2L0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:26:37 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:59859 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfH2L0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:26:36 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x7TBQUJE027328;
        Thu, 29 Aug 2019 20:26:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x7TBQUJE027328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567077991;
        bh=+gWnDwatzEtFz3pSmoSNRZi/E0ncjcCGbNklL4Q7bw8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bUPMhAOjOMVOD5ong/7cFnJXL2QxN6br8RZcHq99lCblfPJIZXzhdWljEhbapf/kk
         EGWujXPerOHEua9kKCJXFFvgxv0avmBYCDygjAIl4IaMRyPFHvJkYeprKkjgFH7jUb
         j/ylys8yRTCKyjx9Kl0XxzmIbnKTbrpOwxBKzXzJ5W/iBwaknBM0yh8hnmP+rp4Gm8
         7jcBy4SIkkVIvlu0CSdwwEl+FcH1fJNceB9nsjui9A6/fBnP2vhz3SfbEE/CskDVTr
         iS0N6O4Qt28JWSDP4rHv14ecmVh/6mOmcrYdseXLUd/8mnmNUY4VlO7aesZ5ZJlbER
         2E4UM088s3iKA==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id p5so702557vkm.5;
        Thu, 29 Aug 2019 04:26:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXiCyIN/PwQELTjiDH8Ez6d8YTVCe3V3rKuy0OtTfA6/fgBTJGI
        KcdwYTUhqmLdf6dQlKfuEYFlPI/6RGhzAXreXZE=
X-Google-Smtp-Source: APXvYqwVeMqrq1GjjeYPqj7sSg5OSlp6s6+m/Clv/TsHkJUb4kLYE6kE0BOseWjuUbLcYwRQG9Qi73X7q0c+7UciOD0=
X-Received: by 2002:a1f:ee81:: with SMTP id m123mr4716816vkh.74.1567077989345;
 Thu, 29 Aug 2019 04:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190828111453.4023-1-yamada.masahiro@socionext.com> <0d5da294-61f8-4b9f-1a6e-7212da40f572@intel.com>
In-Reply-To: <0d5da294-61f8-4b9f-1a6e-7212da40f572@intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 29 Aug 2019 20:25:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATsw8=jc7tJpj3w120R0op6ZwquEmoB8UNg6giW4V_6Nw@mail.gmail.com>
Message-ID: <CAK7LNATsw8=jc7tJpj3w120R0op6ZwquEmoB8UNg6giW4V_6Nw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: use lower/upper_32_bits() macros for DMA addresses
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, Aug 28, 2019 at 10:02 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/08/19 2:14 PM, Masahiro Yamada wrote:
> > Currently, the DMA addresses are casted to (u64) for the upper 32bits
> > to avoid "right shift count >= width of type" warning.
> >
> > <linux/kernel.h> provides macros to address this, and the macro names
> > are self-documenting.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  drivers/mmc/host/sdhci.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index a5dc5aae973e..07144a195a9f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -668,10 +668,10 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> >       /* 32-bit and 64-bit descriptors have these members in same position */
> >       dma_desc->cmd = cpu_to_le16(cmd);
> >       dma_desc->len = cpu_to_le16(len);
> > -     dma_desc->addr_lo = cpu_to_le32((u32)addr);
> > +     dma_desc->addr_lo = cpu_to_le32(lower_32_bits(addr));
> >
> >       if (host->flags & SDHCI_USE_64_BIT_DMA)
> > -             dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
> > +             dma_desc->addr_hi = cpu_to_le32(upper_32_bits(addr));
> >
> >       *desc += host->desc_sz;
> >  }
> > @@ -827,9 +827,10 @@ static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
> >  static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
> >  {
> >       if (host->v4_mode) {
>
> To reduce line wrapping, how about using:
>
>                 u32 lo = lower_32_bits(addr);
>                 u32 hi = upper_32_bits(addr);
>
> > -             sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
> > +             sdhci_writel(host, lower_32_bits(addr), SDHCI_ADMA_ADDRESS);
> >               if (host->flags & SDHCI_USE_64_BIT_DMA)
> > -                     sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
> > +                     sdhci_writel(host, upper_32_bits(addr),
> > +                                  SDHCI_ADMA_ADDRESS_HI);
> >       } else {
> >               sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
> >       }
> > @@ -1096,10 +1097,11 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> >               } else if (host->flags & SDHCI_USE_ADMA) {
>
> To reduce line wrapping, how about using:
>
>                         u32 lo = lower_32_bits(host->adma_addr);
>                         u32 hi = upper_32_bits(host->adma_addr);
>
> >                       sdhci_adma_table_pre(host, data, sg_cnt);
> >
> > -                     sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
> > +                     sdhci_writel(host, lower_32_bits(host->adma_addr),
> > +                                  SDHCI_ADMA_ADDRESS);
> >                       if (host->flags & SDHCI_USE_64_BIT_DMA)
> >                               sdhci_writel(host,
> > -                                          (u64)host->adma_addr >> 32,
> > +                                          upper_32_bits(host->adma_addr),
> >                                            SDHCI_ADMA_ADDRESS_HI);
> >               } else {
> >                       WARN_ON(sg_cnt != 1);
> >
>


I used another way to reduce the line wrapping in v2.
I factored out the duplicated code into a new helper,
sdhci_set_adma_addr().

If you do not like it, I will adopt your suggestion,
but anyway take a look at v2.

-- 
Best Regards
Masahiro Yamada
