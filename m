Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CD3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E2020828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="B4CHip1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfH0HqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:46:00 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:60303 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfH0HqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:46:00 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x7R7jut7021960;
        Tue, 27 Aug 2019 16:45:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x7R7jut7021960
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566891957;
        bh=CCtCL19DmuvrV2VqAgkqWIfPFYfgDfnJCKU/CL8uRio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B4CHip1JP3uIn3+++ULwsuJ2uOqnGULQVL3hM/BRafp9nqobnzzIyBKunrsvygn8D
         a247ywbY3uF03eT4OwDgrLwC7BTZXyGhLOlM/qGvJBsnMTxKI3/Qc8MuUB56hs+WtR
         rzCU1oTxcbXijyWHC5/v/QL4C0a0IuM/gpxNhJmbc9NjtpaK4z9VHYw3bKuG7kLtru
         /AYcsWLuxD34/uMMZYPulTlnNTvhWX3n6KPwBfFjjjotXcSIGng0eZWWYO4SV3Zz00
         nqs1HM7Gcsysky1nipVLwEzdMxDrfT6bV+D5qtslbXSy1HPK2t+LindprwHN2kJSuV
         0qhGuaKokTqug==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id y62so12815581vsb.6;
        Tue, 27 Aug 2019 00:45:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWzmKUYBVdL+tFu0J0FcZJTuDpOxxNVg2TP5M4BBMfBfWfXRmic
        7rgkeatPn4O7oQYio7oaxx9sKaXcgJyE6Bzk3P4=
X-Google-Smtp-Source: APXvYqw3kFkP7AW1Myq4vwC0HTeWHl7qNE1Xu8mQsAgOMCEnoA+VGlGvJAQBc5iBngpOl9rP3s1Rs35DhGciNkmYfkU=
X-Received: by 2002:a67:fe12:: with SMTP id l18mr12861854vsr.54.1566891956209;
 Tue, 27 Aug 2019 00:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
 <20190825011025.GA23410@lst.de> <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
 <20190826073320.GA11712@lst.de>
In-Reply-To: <20190826073320.GA11712@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Aug 2019 16:45:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
Message-ID: <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
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

On Mon, Aug 26, 2019 at 4:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Aug 26, 2019 at 11:05:00AM +0900, Masahiro Yamada wrote:
> > This is included in v5.3-rc6
> > so I tested it.
>
> So there is no allocation failure, but you get I/O errors later?

Right.

>
> Does the device use a device-private CMA area?

Not sure.
My driver is drivers/mmc/host/sdhci-cadence.c
It reuses routines in drivers/mmc/host/sdhci.c



>  Does it work with Linux
> 5.2 if CONFIG_DMA_CMA is disabled?

No.
5.2 + disable CONFIG_DMA_CMA
failed in the same way.




-- 
Best Regards
Masahiro Yamada
