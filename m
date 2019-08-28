Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541B4208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bK8fRPnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfH1Kyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:54:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:54855 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfH1Kyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:54:35 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x7SAsGhE023826;
        Wed, 28 Aug 2019 19:54:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x7SAsGhE023826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566989657;
        bh=0aEfdaeY7mGkEAyGyJedaS36AmSkDHSHLjJWK6eJ8jU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bK8fRPnWch65cU6pgIoRy9PQBFZXFjZyaECj8O/kkx24MPqoedK98ZKATllbYFpCx
         nEN73VKu9eY89bVTdzDU6v4j6xAD+ZPhYcHLtZI6J986KSm9T4v1ZXa30nNgd9iOa/
         iVw5CoXOPXoV094mtj5rUSD9l+L2GUG738uJ6VpcqCkpDHUAcP3LkIVQIws/5MjHln
         27ZJtFOqGh9EQlFwGFso/6v6/xwkQB1BIZU4X8d6Pn6jEASzJyVsxrQ2Y6pr9vLyvd
         uLiEGSm67Nu/LHo2aqPZixxJR3pcME8nfDSwsPSDZMUPb5R6wnwVYSj8cjFpsa3ikc
         GNot1GcyfydYA==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id 62so1542350vsl.5;
        Wed, 28 Aug 2019 03:54:17 -0700 (PDT)
X-Gm-Message-State: APjAAAW/LPwpkfIYhZafs1steV7l8eGJz4VnFtLJuatM7SBP+1HcpcvA
        5sFn7inf54Dgw8vg1BS4eNpY70BJ6SleeGMat+0=
X-Google-Smtp-Source: APXvYqyTOMfJYEouCiB1bEN4976TgQu4HqralgHD2818HsBCGBXAYnYZsbiCyyA54/vVKIRU/ogvfy3faarlq+XW0VM=
X-Received: by 2002:a67:8a83:: with SMTP id m125mr1914365vsd.181.1566989656023;
 Wed, 28 Aug 2019 03:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
 <20190825011025.GA23410@lst.de> <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
 <20190826073320.GA11712@lst.de> <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
 <20190827075021.GA953@lst.de> <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
 <20190827115541.GB5921@lst.de>
In-Reply-To: <20190827115541.GB5921@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 28 Aug 2019 19:53:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
Message-ID: <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
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

Hi Christoph,

On Tue, Aug 27, 2019 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 27, 2019 at 06:03:14PM +0900, Masahiro Yamada wrote:
> > Yes, this makes my driver working again
> > when CONFIG_DMA_CMA=y.
> >
> >
> > If I apply the following, my driver gets back working
> > irrespective of CONFIG_DMA_CMA.
>
> That sounds a lot like the device simply isn't 64-bit DMA capable, and
> previously always got CMA allocations under the limit it actually
> supported.  I suggest that you submit this quirk to the mmc maintainers.


I tested v5.2 and my MMC host controller works with
dma_address that exceeds 32-bit physical address.

So, I believe my MMC device is 64-bit DMA capable.

I am still looking into the code
to find out what was changed.




--
Best Regards
Masahiro Yamada
