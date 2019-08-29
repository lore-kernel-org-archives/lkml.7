Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD4CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C8D2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FR2lZSyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfH2LqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:46:09 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:43802 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfH2LqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:46:09 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x7TBk4T6015443;
        Thu, 29 Aug 2019 20:46:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7TBk4T6015443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567079165;
        bh=jJHAKRHFRUzF/5jWYYKHoeNpyJFG8X4zd/Hk645vV1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FR2lZSyoTN0KEKnwc4pXOJULo6oFfgZ4oMDCJPqQws/UAF4tOiv/G9gNRRlylUM70
         /HDF76gpmnV29LClsim6CYan+gHWKmIA8zouhAArtdeWnHkYTEMTO3z57gkZ3RE3Op
         H7XCYN867bK/c/Y5yxEzevUmbQQZl/KsaJVUX5btY2kuTwUsSnkq8pe8glDLnzmBUX
         wGy7fvvpxBxmpu+H8gSnB/sVHwtepY0c/dM7R9TYoiuVHjMI+oPn1gmhIYcNEolY/O
         2SgUdaZ+jrxcE/PuE8ualfGbOt9kOfSxoKrDoWDRaPTeFu7b+bN7zstzTpQLPM8W5w
         5j6MuK6hAKafQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id 62so2182884vsl.5;
        Thu, 29 Aug 2019 04:46:05 -0700 (PDT)
X-Gm-Message-State: APjAAAW+TJpJ1K3UPd88XF79Q2VXCxvffeoCRouuduckjz1pAxihV84K
        JDixXzYmbY3Zkm9AdenxlZaTEWaIO/r0DXUM4gI=
X-Google-Smtp-Source: APXvYqySzvmeE9kiWjvNGM1iaAxnZ+QgH8m0ESiSIlhk3/0sUZoqbPgAj7pYaewNuKSsBX5H2zvSqil85IeqcrkN9II=
X-Received: by 2002:a67:fe12:: with SMTP id l18mr5139562vsr.54.1567079164044;
 Thu, 29 Aug 2019 04:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
 <20190825011025.GA23410@lst.de> <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
 <20190826073320.GA11712@lst.de> <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
 <20190827075021.GA953@lst.de> <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
 <20190827115541.GB5921@lst.de> <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
 <CAK7LNATvz=TTe+3OyLrtUqDuTUTn1dg9Sk-t3BD_OFZfViCPMw@mail.gmail.com>
In-Reply-To: <CAK7LNATvz=TTe+3OyLrtUqDuTUTn1dg9Sk-t3BD_OFZfViCPMw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 29 Aug 2019 20:45:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASs2qkpGY_BkL--hvmKm3FJ9sEK4+v5VVYc1_CrowAB4w@mail.gmail.com>
Message-ID: <CAK7LNASs2qkpGY_BkL--hvmKm3FJ9sEK4+v5VVYc1_CrowAB4w@mail.gmail.com>
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

On Wed, Aug 28, 2019 at 9:23 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Aug 28, 2019 at 7:53 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Christoph,
> >
> > On Tue, Aug 27, 2019 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Tue, Aug 27, 2019 at 06:03:14PM +0900, Masahiro Yamada wrote:
> > > > Yes, this makes my driver working again
> > > > when CONFIG_DMA_CMA=y.
> > > >
> > > >
> > > > If I apply the following, my driver gets back working
> > > > irrespective of CONFIG_DMA_CMA.
> > >
> > > That sounds a lot like the device simply isn't 64-bit DMA capable, and
> > > previously always got CMA allocations under the limit it actually
> > > supported.  I suggest that you submit this quirk to the mmc maintainers.
> >
> >
> > I tested v5.2 and my MMC host controller works with
> > dma_address that exceeds 32-bit physical address.
> >
> > So, I believe my MMC device is 64-bit DMA capable.
> >
> > I am still looking into the code
> > to find out what was changed.
>
>
> I retract this comment.
>
> Prior to bd2e75633c8012fc8a7431c82fda66237133bf7e,
> the descriptor table for ADMA is placed within the
> 32-bit phys address range, not exceeds the 32-bit limit.
>
> Probably, my device is not 64-bit capable.
>
> I will talk to the hardware engineer,
> and check the hardware spec just in case.
>


After looking more into my hardware,
I found out how to fix my driver:
https://lore.kernel.org/patchwork/patch/1121600/



-- 
Best Regards
Masahiro Yamada
