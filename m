Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A30C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70466205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="C/d9PWiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfEFP1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:27:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33060 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfEFP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:27:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so4749442wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuMSdmXl0z53dDi0xhlaU7BU2n/bLw/DBUWaPvlO+dc=;
        b=C/d9PWiZ7kbJC0oH7zo5Ibhtjb0LJxg5WGRhk2z22dgXTR0ahak265kLVZyGYOhfje
         aEtSmh42RRvz8bCCBZRBFOn7uv5XCF0ECqKL0Hb338d0yPodqMwGb1L0gvRyJgITkaxQ
         Ki1y61sbdbPypKRjDCxUR8MH0zfn/bbro9LPpFVyLBByJZzEOqelQf5tS81MK2FkUIP3
         sLhve+NsmP0dlDX03w14Qjs93JrqJwcC/r4yHUZhJhCv/72E7VCM80drfYcNtln/9ipb
         cKIyK6t7ROv023pVx/00hbtubgQCmfBlIjzs3E6R48gtIILod1LUINjWV6UVWZ8tSjxH
         BBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuMSdmXl0z53dDi0xhlaU7BU2n/bLw/DBUWaPvlO+dc=;
        b=EHCW6r3TWJJpu5Vgjm6M3rFrOjgvD+G6ZhUBuK96n1cfuSJCjWoRNkdkj96TW6fHut
         5Yu2bJpVUHPaqxQEHJt3jmmnUZbZWBhG3+zOGtzYAWmQcZNi/tW95zbZTBeFp5EfCpgF
         eGEso6HHwSNPD5K+NLuNA5vAeuyRwnwdgBt+NeIu4QpIzdF5pbYgPmSPH+rT9tV4ttoe
         xvtGvGdKSbc0Aqw7Xa3ExN0WpsXHGla1isJqhtAHTtve/itgZGb6Ko/bXmZsue/fCE6n
         qkvhtRZ6Eyk6rH0OFbFzCS5ZQLc+0q87SzqlULUXN5hQzHNvQPdksUPxGSgQyzpcB5kT
         g4sA==
X-Gm-Message-State: APjAAAUDUfN83sATh5NmIdfSH5BzAsjV1adRAniH23MM268CnWnno9hD
        rq1BTFASn4fGtv7+7hx2J8wUxEx0PukCQb9/9SBY9A==
X-Google-Smtp-Source: APXvYqzdYjq2KzNwXSYRUYk147h4YL+JNa0zWfymURRoAL7aXQogilrHn37rwl9PoIS46ayzMGu+Ikwm2tOs7SUKN4Y=
X-Received: by 2002:a5d:5551:: with SMTP id g17mr20082024wrw.50.1557156440752;
 Mon, 06 May 2019 08:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190504132327.27041-1-tmurphy@arista.com> <20190504132327.27041-2-tmurphy@arista.com>
 <8fef18f5-773c-e1c9-2537-c9dff5bfd35e@linux.intel.com>
In-Reply-To: <8fef18f5-773c-e1c9-2537-c9dff5bfd35e@linux.intel.com>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Mon, 6 May 2019 16:27:09 +0100
Message-ID: <CAPL0++4_Qa+dxzQ2k6BJi_o+VSSrHEtomYgVmRqjtjsOfHbGew@mail.gmail.com>
Subject: Re: [RFC 1/7] iommu/vt-d: Set the dma_ops per device so we can remove
 the iommu_no_mapping code
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 2:48 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi,
>
> On 5/4/19 9:23 PM, Tom Murphy wrote:
> > Set the dma_ops per device so we can remove the iommu_no_mapping code.
> >
> > Signed-off-by: Tom Murphy<tmurphy@arista.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 85 +++----------------------------------
> >   1 file changed, 6 insertions(+), 79 deletions(-)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index eace915602f0..2db1dc47e7e4 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -2622,17 +2622,6 @@ static int __init si_domain_init(int hw)
> >       return 0;
> >   }
> >
> > -static int identity_mapping(struct device *dev)
> > -{
> > -     struct device_domain_info *info;
> > -
> > -     info = dev->archdata.iommu;
> > -     if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
> > -             return (info->domain == si_domain);
> > -
> > -     return 0;
> > -}
> > -
> >   static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
> >   {
> >       struct dmar_domain *ndomain;
> > @@ -3270,43 +3259,6 @@ static unsigned long intel_alloc_iova(struct device *dev,
> >       return iova_pfn;
> >   }
> >
> > -/* Check if the dev needs to go through non-identity map and unmap process.*/
> > -static int iommu_no_mapping(struct device *dev)
> > -{
> > -     int found;
> > -
> > -     if (iommu_dummy(dev))
> > -             return 1;
> > -
> > -     found = identity_mapping(dev);
> > -     if (found) {
> > -             /*
> > -              * If the device's dma_mask is less than the system's memory
> > -              * size then this is not a candidate for identity mapping.
> > -              */
> > -             u64 dma_mask = *dev->dma_mask;
> > -
> > -             if (dev->coherent_dma_mask &&
> > -                 dev->coherent_dma_mask < dma_mask)
> > -                     dma_mask = dev->coherent_dma_mask;
> > -
> > -             if (dma_mask < dma_get_required_mask(dev)) {
> > -                     /*
> > -                      * 32 bit DMA is removed from si_domain and fall back
> > -                      * to non-identity mapping.
> > -                      */
> > -                     dmar_remove_one_dev_info(dev);
> > -                     dev_warn(dev, "32bit DMA uses non-identity mapping\n");
> > -
> > -                     return 0;
> > -             }
>
> The iommu_no_mapping() also checks whether any 32bit DMA device uses
> identity mapping. The device might not work if the system memory space
> is bigger than 4G.

It looks like their is actually a bug in the v3 of the "iommu/vt-d:
Delegate DMA domain to generic iommu" patch set. I will leave a
message in that email thread. Fixing that bug should also fix this
issue.


>
> Will you add this to other place, or it's unnecessary?
>
> Best regards,
> Lu Baolu
