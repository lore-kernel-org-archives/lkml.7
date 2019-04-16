Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF6521741
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VtjKXsGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfDPQkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:40:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38353 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPQkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:40:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so28033458wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTkm9hdXQx0BUJR+E4RDHc49oiGfv+XHkhUNKOh1amI=;
        b=VtjKXsGdQg9bHRUwI7Txp+N0frNfnE+6tX6tqJciF7909X3jQkwh+yWvKOssMT6dLs
         SnyFzNdMC49DcBwk5bnSgOSOv6TTEhj5cuGu3M8Ka+drYcn23/QqEwDsO9ub/NXePuTy
         rlZmGrc53ywdDzsJRUSTB/6V2UacGfpASPv5clLpEBfmN2uf+Ocezmxo79MzzS3ZVzH1
         rerjSN8XGB71dmZ2IGI8QFeWRG5Au6xvf9OJ2+kVCX9N/hZKTB7ZJNFU1TyjOtHUKIrv
         aEot3zvpjJmpBghRvYP929p9fcRu2Tor22+AavwH27saL6ZCav/HOQE5EXiBCsNLWi70
         W3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTkm9hdXQx0BUJR+E4RDHc49oiGfv+XHkhUNKOh1amI=;
        b=OKmCCYP3bLCd5aK9DnKRw5vw/hC7RH7cBm3EP99LKeQw2CLLqImdNS6PjbMAk3eM/a
         FMgrkpgFnaXlySaVgQoOUUdqS9p9KGzpNK/ncIOh1NwSRuyHWqTQOWsGiCb0z4KWbMwU
         J6C4h11v3I2+0Uc3X1LFWelmGKv5pzmEJUqWxgSYIX6RYEE+rqM4jARIzc2j/3sDrsEf
         RcVPWt7f6z4/TLoWLEfDC0Ml2p1a0xMvykrjpLLixhq5tPEIE46Xllr5peuMH4DZlceF
         9eDnIo25SiZgmAGOCRpWX7L/1bxFqlDLZmIOoEllXhZMmGOf5Oeox3ZYeh1Nl2Sv8q38
         vZiA==
X-Gm-Message-State: APjAAAUbnpiJD85dIHkodb1fris3ste3T/UMNZKD/9UywWxFEfHyRca5
        PcF7U4Yk/s2WiybvwK8PNGgIc0VuiTPiuKNIP1LtNw==
X-Google-Smtp-Source: APXvYqwumrSY/0JQyPs9Trtefa8INHuB5INkGyfypAMYVYHcRmPVj9kojn4+3AAUSKH8JhWnaIjdxHopPSMY2smzg9g=
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr17259388wrw.22.1555432829105;
 Tue, 16 Apr 2019 09:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190411184741.27540-1-tmurphy@arista.com> <20190411184741.27540-3-tmurphy@arista.com>
 <82ce70dc-b370-3bb0-bce8-2d32db4d6a0d@arm.com>
In-Reply-To: <82ce70dc-b370-3bb0-bce8-2d32db4d6a0d@arm.com>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Tue, 16 Apr 2019 17:40:17 +0100
Message-ID: <CAPL0++7czbNnJAnn40GtkK2ojrWHMu60DfzVEn_EfYK_WCdYWw@mail.gmail.com>
Subject: Re: [PATCH 2/9] iommu/dma-iommu: Add function to flush any cached not
 present IOTLB entries
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, Dmitry Safonov <dima@arista.com>,
        James Sewart <jamessewart@arista.com>,
        Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>That said, I've now gone and looked and AFAICS both the Intel...
Ah, I missed that, you're right.

>...and AMD
It doesn't look like it. On AMD the cache is flushed during
iommu_ops::map only if the there are page table pages to free (if
we're allocating a large page and freeing the sub pages), right?
I guess this is a bug in the AMD iommu driver, as you said, it should
be handled in iommu_map(). I'll submit another patch to flush the np
cache on a call to amd iommu_ops::map if amd_iommu_np_cache is set.

>What might be
>worthwhile, though, is seeing if there's scope to refactor those drivers
>to push some of it into an iommu_ops::iotlb_sync_map callback to
>optimise the flushing for multi-page mappings.
I am working on a different patch series to improve the flushing and
page table page freeing for both amd and intel

On Tue, Apr 16, 2019 at 3:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 11/04/2019 19:47, Tom Murphy wrote:
> > Both the AMD and Intel drivers can cache not present IOTLB entries. To
> > convert these drivers to the dma-iommu api we need a generic way to
> > flush the NP cache. IOMMU drivers which have a NP cache can implement
> > the .flush_np_cache function in the iommu ops struct. I will implement
> > .flush_np_cache for both the Intel and AMD drivers in later patches.
> >
> > The Intel np-cache is described here:
> > https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf#G7.66452
> >
> > And the AMD np-cache is described here:
> > https://developer.amd.com/wordpress/media/2012/10/34434-IOMMU-Rev_1.26_2-11-09.pdf#page=63
>
> Callers expect that once iommu_map() returns successfully, the mapping
> exists and is ready to use - if these drivers aren't handling this
> flushing internally, how are they not already broken for e.g. VFIO?
>
> > Signed-off-by: Tom Murphy <tmurphy@arista.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 10 ++++++++++
> >   include/linux/iommu.h     |  3 +++
> >   2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 1a4bff3f8427..cc5da30d6e58 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -594,6 +594,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >                       < size)
> >               goto out_free_sg;
> >
> > +     if (domain->ops->flush_np_cache)
> > +             domain->ops->flush_np_cache(domain, iova, size);
> > +
>
> This doesn't scale. At the very least, it should be internal to
> iommu_map() and exposed to be the responsibility of every external
> caller now and forever after.
>
> That said, I've now gone and looked and AFAICS both the Intel and AMD
> drivers *do* appear to handle this in their iommu_ops::map callbacks
> already, so the whole patch does indeed seem bogus. What might be
> worthwhile, though, is seeing if there's scope to refactor those drivers
> to push some of it into an iommu_ops::iotlb_sync_map callback to
> optimise the flushing for multi-page mappings.
>
> Robin.
>
> >       *handle = iova;
> >       sg_free_table(&sgt);
> >       return pages;
> > @@ -652,6 +655,10 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> >               iommu_dma_free_iova(cookie, iova, size);
> >               return DMA_MAPPING_ERROR;
> >       }
> > +
> > +     if (domain->ops->flush_np_cache)
> > +             domain->ops->flush_np_cache(domain, iova, size);
> > +
> >       return iova + iova_off;
> >   }
> >
> > @@ -812,6 +819,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >       if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
> >               goto out_free_iova;
> >
> > +     if (domain->ops->flush_np_cache)
> > +             domain->ops->flush_np_cache(domain, iova, iova_len);
> > +
> >       return __finalise_sg(dev, sg, nents, iova);
> >
> >   out_free_iova:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 75559918d9bd..47ff8d731d6a 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -173,6 +173,7 @@ struct iommu_resv_region {
> >    * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
> >    * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
> >    *            queue
> > + * @flush_np_cache: Flush the non present entry cache
> >    * @iova_to_phys: translate iova to physical address
> >    * @add_device: add device to iommu grouping
> >    * @remove_device: remove device from iommu grouping
> > @@ -209,6 +210,8 @@ struct iommu_ops {
> >                               unsigned long iova, size_t size);
> >       void (*iotlb_sync_map)(struct iommu_domain *domain);
> >       void (*iotlb_sync)(struct iommu_domain *domain);
> > +     void (*flush_np_cache)(struct iommu_domain *domain,
> > +                             unsigned long iova, size_t size);
> >       phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
> >       int (*add_device)(struct device *dev);
> >       void (*remove_device)(struct device *dev);
> >
