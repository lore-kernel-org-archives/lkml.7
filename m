Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E289EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45A02339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uqNGtZWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfH1MYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:24:47 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:61706 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfH1MYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:24:47 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x7SCOKYn007536;
        Wed, 28 Aug 2019 21:24:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x7SCOKYn007536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566995061;
        bh=QGwpmYKpkBfkJkR52bVEAkpX4zw0mwzUiEGIdCDkwxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uqNGtZWnszkj+EI17b6cYBIkgLT1pNqqjZ5vvXHhv3nOtkGhMLE3vL239iHJx8xOz
         TSdYOHpkebqzZFAStQTcerRGirstT0XYJoVthR/5RvSg8EwIXbfT0K4YHHjnM2D9df
         JXXCqO9Sr2ZFEdHKD7gxA7eX9ABdy7xMFqUuoAjc4LZbh1oHbeSw+NQJ4Ce2UY37OL
         1txXvkAUycDvn0IT3BeWg+7kqZstKdDcVVmHGUVKjLtz+pcmN6rubDhCpA5S2OJHzV
         Tbrl68C67rXttDBFRWfYe+B8o+XbJ2QlQQ11l4eNvd1Y5ZXbdFZLM/YI9cfIW6ibm1
         bz9Dqz+XAfrPw==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id k7so752114uao.6;
        Wed, 28 Aug 2019 05:24:21 -0700 (PDT)
X-Gm-Message-State: APjAAAW009682rJRH8tQEgv1Esk44krWyPnCSSItIdEAEpNfL4gr+Dv4
        stBJkAS+9IfqSqP8HOJvw3ng6jijQ1SL4k4NYfA=
X-Google-Smtp-Source: APXvYqzOQYU2Q+Xq/DN7mTcKzBb0P1kiiE+ggL4N1BaGeuzN90KCZ6nzT8nGJkbkDhur/ilmD52mrtpqBPxR1Kulykg=
X-Received: by 2002:ab0:442:: with SMTP id 60mr1554937uav.109.1566995060173;
 Wed, 28 Aug 2019 05:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com>
 <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com>
 <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com>
 <20190825011025.GA23410@lst.de> <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com>
 <20190826073320.GA11712@lst.de> <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
 <20190827075021.GA953@lst.de> <CAK7LNAQZ+bueZZzSoMADmgLjWNvijHRV=wLQzN_kvLG3b5Uu+w@mail.gmail.com>
 <20190827115541.GB5921@lst.de> <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
In-Reply-To: <CAK7LNAQ_nQcBt=xH1-h+=co85mTxFgbe+_46Gu4LaNsDSm+kYA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 28 Aug 2019 21:23:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvz=TTe+3OyLrtUqDuTUTn1dg9Sk-t3BD_OFZfViCPMw@mail.gmail.com>
Message-ID: <CAK7LNATvz=TTe+3OyLrtUqDuTUTn1dg9Sk-t3BD_OFZfViCPMw@mail.gmail.com>
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

On Wed, Aug 28, 2019 at 7:53 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Christoph,
>
> On Tue, Aug 27, 2019 at 8:55 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Aug 27, 2019 at 06:03:14PM +0900, Masahiro Yamada wrote:
> > > Yes, this makes my driver working again
> > > when CONFIG_DMA_CMA=y.
> > >
> > >
> > > If I apply the following, my driver gets back working
> > > irrespective of CONFIG_DMA_CMA.
> >
> > That sounds a lot like the device simply isn't 64-bit DMA capable, and
> > previously always got CMA allocations under the limit it actually
> > supported.  I suggest that you submit this quirk to the mmc maintainers.
>
>
> I tested v5.2 and my MMC host controller works with
> dma_address that exceeds 32-bit physical address.
>
> So, I believe my MMC device is 64-bit DMA capable.
>
> I am still looking into the code
> to find out what was changed.


I retract this comment.

Prior to bd2e75633c8012fc8a7431c82fda66237133bf7e,
the descriptor table for ADMA is placed within the
32-bit phys address range, not exceeds the 32-bit limit.

Probably, my device is not 64-bit capable.

I will talk to the hardware engineer,
and check the hardware spec just in case.

Thanks.

-- 
Best Regards
Masahiro Yamada
