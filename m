Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79672C41514
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1A821773
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="iuaKaoZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfHQHUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:20:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46596 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHQHUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 03:20:07 -0400
Received: by mail-io1-f65.google.com with SMTP id x4so10749182iog.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gnS0PBpeFma+nR0/93xLJSxk0RZjywB6TYlsGP6x54=;
        b=iuaKaoZkqD3jS65GkFRQXUesr+iHDQw7qZXVp3ez2fmCt49N//RMqfebteueaUoH+p
         97zi714OqDL373xaRAuH3dX8FyF/Ggim5AtCytyMJbs8OW1HRJxUvrBWziOojWSjQyyv
         N8V4gNN86Fa2SkaukvBfzPcjbRwF05BDdxAP0vXBWYtOD0SIpiwB1xkPByOxsAsX+9h1
         04BQeNXJdFWKxBekEW+jFClh2sgwRA/Wjk7i3VyRYr7XND2lelrmJe56TnoW4qN1h7sB
         KsNL/98KtTPtlpVSTykKF2Hed4ptAKREhBRKgytLAlnBDShNx9anmljZsQvOgXkrjk/s
         f08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gnS0PBpeFma+nR0/93xLJSxk0RZjywB6TYlsGP6x54=;
        b=Im2ZfjqtT+gEsw88u5JkK/EL9ZYK9ypTSHysqADOhKZqngV5HIFwhLDAvlwVCHdk8u
         a//w2EYKNBlOc4zPgYSYuy2J5ydVvnwm/0yQ73G+sDZrZEGR0rsV34i/k7BwW4W3MsMn
         xFFd+0Q/mWNnKK5vN3LHHYL91VzHIS5YYEadZitTI5axeX9WqzjKu1XBFmcA3/3sdj8G
         VkaK7j0PLgt7FS885a/RQ0rXbanq/tNkLrHAcaVI6H8zdaUV2QNxOzB56Rn6faMhCEzA
         WLd9edghcWuh49+vkKD/cqAiE2ULrXmxjhpS8AlRoMWdZ0x2X6bc9x/EKKuevcGEyvog
         QtIw==
X-Gm-Message-State: APjAAAUH0Zn2Tf0tsHjdXy120b/g1TjgxROUD8Y5t+IBqcZCw4ErQWWR
        cXjivPrY/MDW95vp+xOWRfRkION/TwrKOTaLK4i7Cg==
X-Google-Smtp-Source: APXvYqzi3uE7FL/BNaGBwf9NcctQEJa1uqSCgIDdI7X8T4a271+rNn6qVr2H/9WkS8ckRMiROhEplUC0qpc0vOhpjPg=
X-Received: by 2002:a02:a18e:: with SMTP id n14mr15977616jah.84.1566026405753;
 Sat, 17 Aug 2019 00:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190815110944.3579-1-murphyt7@tcd.ie> <20190817033914.4812-1-hdanton@sina.com>
In-Reply-To: <20190817033914.4812-1-hdanton@sina.com>
From:   Tom Murphy <murphyt7@tcd.ie>
Date:   Sat, 17 Aug 2019 08:19:33 +0100
Message-ID: <CALQxJut_0bjojiFza9bZF26n0+9Vjq8QFqsxgd5Rxag+Qx609Q@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] iommu/dma-iommu: Handle deferred devices
To:     Hillf Danton <hdanton@sina.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2019 at 04:39, Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Thu, 15 Aug 2019 12:09:41 +0100 Tom Murphy wrote:
> >
> > Handle devices which defer their attach to the iommu in the dma-iommu api
> >
> > Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> > ---
> >  drivers/iommu/dma-iommu.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 2712fbc68b28..906b7fa14d3c 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/crash_dump.h>
> >
> >  struct iommu_dma_msi_page {
> >       struct list_head        list;
> > @@ -351,6 +352,21 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> >       return iova_reserve_iommu_regions(dev, domain);
> >  }
> >
> > +static int handle_deferred_device(struct device *dev,
> > +     struct iommu_domain *domain)
> > +{
> > +     const struct iommu_ops *ops = domain->ops;
> > +
> > +     if (!is_kdump_kernel())
> > +             return 0;
> > +
> > +     if (unlikely(ops->is_attach_deferred &&
> > +             ops->is_attach_deferred(domain, dev)))
> > +             return iommu_attach_device(domain, dev);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
> >   *                    page flags.
> > @@ -463,6 +479,9 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> >       size_t iova_off = iova_offset(iovad, phys);
> >       dma_addr_t iova;
> >
> > +     if (unlikely(handle_deferred_device(dev, domain)))
> > +             return DMA_MAPPING_ERROR;
> > +
> >       size = iova_align(iovad, size + iova_off);
> >
> >       iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
>
> iommu_map_atomic() is applied to __iommu_dma_map() in 2/5.
> Is it an atomic context currently given the mutex_lock() in
> iommu_attach_device()?

I don't see your point here. __iommu_dma_map isn't called from
iommu_attach_device, why would we care about a mutex in
iommu_attach_device?

__iommu_dma_map can be called from an atomic context (it isn't always
but it does happen). __iommu_dma_map is called by iommu_dma_alloc
which implements the iommu_dma_ops::alloc function which by design
needs to be callable from an atomic context. Does that answer your
question?

>
