Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B04C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0134B217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FEJO9C78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfH0JEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:04:11 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:63086 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0JEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:04:10 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x7R93pZ7014817;
        Tue, 27 Aug 2019 18:03:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x7R93pZ7014817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566896632;
        bh=9QFLgDLrDq6oYc9M2pjMIY7wPViunYCOH8ybzE+CYKY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FEJO9C78f6r58lBL+oGJOTJPxQoEb2F5p+8zzLKT0aTGj9HnOH4wJZVO7i4XZ0lrD
         JRaPKKWvcXsmkwHjPM/DC2pmwp6QBq7gDAmbILjLCjSDfTAmzpxI18l4qqL/9MM1QI
         OiW+casOVnjgaTJgg1MrMs/Zcc2ogoWZAiwnNaodtf06YkWFxWxTc4qTTqDJa1Xvat
         Rj4ih6nduKisiJwSs13yNxmV7fiRExk2+Nmcqx0BGve6cl7RqKiflQILfKi43Q6Cyn
         nCnpIRLy2Jlp05lHYh8OR+eckJYKfIMmJbAHTZeExVX6xDHePofUOhPK2vaX5e22WV
         IvohYpkXZw8zw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id 62so12936983vsl.5;
        Tue, 27 Aug 2019 02:03:52 -0700 (PDT)
X-Gm-Message-State: APjAAAW/Rwe792cSkCLetbjB5wNfFtpFXg88jCfIn7NG+XlBfaCR5/2y
        h8EYU/nbVjxCSEdivMZzFIYxsPNy4ElOql0htGk=
X-Google-Smtp-Source: APXvYqwricK86V/H4mlXnBje+CLjj05rUISZsABUzE/wYSQ2E+9R0KKypcnkK7mnt6KPt7U5OLwH2hsMH6JJJTu7VOI=
X-Received: by 2002:a67:fe12:: with SMTP id l18mr12998082vsr.54.1566896631370;
 Tue, 27 Aug 2019 02:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
 <20190825011025.GA23410@lst.de> <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
 <20190826073320.GA11712@lst.de> <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
 <20190827075021.GA953@lst.de>
In-Reply-To: <20190827075021.GA953@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Aug 2019 18:03:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
Message-ID: <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thierry Reding <treding@nvidia.com>,
        Kees Cook <keescook@chromium.org>, iamjoonsoo.kim@lge.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 4:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 27, 2019 at 04:45:20PM +0900, Masahiro Yamada wrote:
> > On Mon, Aug 26, 2019 at 4:33 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Mon, Aug 26, 2019 at 11:05:00AM +0900, Masahiro Yamada wrote:
> > > > This is included in v5.3-rc6
> > > > so I tested it.
> > >
> > > So there is no allocation failure, but you get I/O errors later?
> >
> > Right.
> >
> > >
> > > Does the device use a device-private CMA area?
> >
> > Not sure.
> > My driver is drivers/mmc/host/sdhci-cadence.c
> > It reuses routines in drivers/mmc/host/sdhci.c
> >
> >
> >
> > >  Does it work with Linux
> > > 5.2 if CONFIG_DMA_CMA is disabled?
> >
> > No.
> > 5.2 + disable CONFIG_DMA_CMA
> > failed in the same way.
>
> So it seems like the device wants CMA memory.   I guess the patch
> below will fix it, but that isn't the solution.  Can you try it
> to confirm?  In the end it probably assumes a dma mask it doesn't
> set that the CMA memory satisfies or something similar.


Thanks for the pointer.


> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 69cfb4345388..bd2f24aa7f19 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -236,7 +236,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>
>         if (dev && dev->cma_area)
>                 cma = dev->cma_area;
> -       else if (count > 1)
> +       else
>                 cma = dma_contiguous_default_area;
>
>         /* CMA can be used only in the context which permits sleeping */

Yes, this makes my driver working again
when CONFIG_DMA_CMA=y.


If I apply the following, my driver gets back working
irrespective of CONFIG_DMA_CMA.


diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 163d1cf4367e..504459395c39 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -237,6 +237,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {

 static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
        .ops = &sdhci_cdns_ops,
+       .quirks2 = SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
 };

 static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)







-- 
Best Regards
Masahiro Yamada
