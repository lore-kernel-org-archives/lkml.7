Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E50ECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 05:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6376B21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 05:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HY4Kgjra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfJBFTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 01:19:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37584 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfJBFTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 01:19:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4so14030004edy.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 22:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ht5W39F73OZwYjr1QLPkqRTtjn0zYK8mGDiJXCTjAlQ=;
        b=HY4Kgjra1y5r/BLGDdRwRt0LVOQfQN7mE0ZX1xPteQgWm23AJKW4lSMw9UxCI+29nE
         j1ycltij3ElQkF+De830aSaDo7u3QjbXKewfYdC1Ve+r4WYDXl0GLloAmdbaD9I7Lg30
         h/0zQ7jqZPIu1FwyNoGFeSkQyprdtRdWK2m4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ht5W39F73OZwYjr1QLPkqRTtjn0zYK8mGDiJXCTjAlQ=;
        b=U9FBTPlnHI3G8SPt2W6s0JDcqmXwOeStQAB2GkaWppfBtfbkFhCY63M/gy+Yw3Ks6V
         oMM1uOrO4sc12p6y7QlR0DWE0T2LxyrBgbjX5+X5JpPwlwNe0iZzdnEJHa7h7PYuZ5cZ
         MHbmpqxFoeemKxP8e6Z+Cd7bfyTumO9+Df62kPpm/Y7oH7XlHjkfsKrUXQsDKFCdaO69
         Z9HLvHMBy6W2OZBW2Py6heBDgtIhrz+d9dGK1lAV1k0iCv7zP5XvfSWsSy2Drke5yCL/
         Bl8qkb8WyMNlCWUVMZe6sux1xcp5nv6H2aN8Xi7jxTFDBjs+8p5AqiBusgzUpy4o7ZQi
         L6qQ==
X-Gm-Message-State: APjAAAViHcG1cn3gcrHfSS7qpudKlrkf2MfKc4GEkaVhvpgIYvRQv8cu
        17DjmUB6BWokhA+EQRkOwKVBMsPqchLFdQ==
X-Google-Smtp-Source: APXvYqwXxOgl4JveAXhsMLCZBbGDLFXkb5mQh7fo8Z5TeDEoB4ZnaRiu/tkxBgye1isGRwvw2Sv9eA==
X-Received: by 2002:a50:fd10:: with SMTP id i16mr1885825eds.239.1569993541743;
        Tue, 01 Oct 2019 22:19:01 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id p4sm3650119edc.38.2019.10.01.22.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 22:18:59 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id y21so5454260wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 22:18:58 -0700 (PDT)
X-Received: by 2002:a1c:a516:: with SMTP id o22mr1287949wme.116.1569993537804;
 Tue, 01 Oct 2019 22:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 2 Oct 2019 14:18:46 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
Message-ID: <CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
Subject: Re: [PATCH] iommu/mediatek: Move the tlb_sync into tlb_flush
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, cui.zhang@mediatek.com,
        chao.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

On Mon, Sep 30, 2019 at 2:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> lacked the dom->pgtlock, then it will cause the variable
> "tlb_flush_active" may be changed unexpectedly, we could see this warning
> log randomly:
>

Thanks for the patch! Please see my comments inline.

> mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> full flush
>
> To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
> And when checking this issue, we find that __arm_v7s_unmap call
> io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
> this also is potential unsafe for us. There is no tlb flush queue in the
> MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
> If v7s don't always gurarantee the sequence, Thus, In this patch I move
> the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
> and we don't care if it is leaf, rearrange the callback functions. Also,
> the tlb flush/sync was already finished in v7s, then iotlb_sync and
> iotlb_sync_all is unnecessary.

Performance-wise, we could do much better. Instead of synchronously
syncing at the end of mtk_iommu_tlb_add_flush(), we could sync at the
beginning, if there was any previous flush still pending. We would
also have to keep the .iotlb_sync() callback, to take care of waiting
for the last flush. That would allow better pipelining with CPU in
cases like this:

for (all pages in range) {
   change page table();
   flush();
}

"change page table()" could execute while the IOMMU is flushing the
previous change.

>
> Besides, there are two minor changes:
> a) Use writel for the register F_MMU_INV_RANGE which is for triggering the
> HW work. We expect all the setting(iova_start/iova_end...) have already
> been finished before F_MMU_INV_RANGE.
> b) Reduce the tlb timeout value from 100000us to 1000us. the original value
> is so long that affect the multimedia performance.

By definition, timeout is something that should not normally happen.
Too long timeout affecting multimedia performance would suggest that
the timeout was actually happening, which is the core problem, not the
length of the timeout. Could you provide more details on this?

>
> Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync")
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> This patch looks break the logic for tlb_flush and tlb_sync. I'm not
> sure if it
> is reasonable. If someone has concern, I could change:
> a) Add dom->pgtlock in the mtk_iommu_iotlb_sync
> b) Add a io_pgtable_tlb_sync in [1].
>
> [1]
> https://elixir.bootlin.com/linux/v5.3-rc1/source/drivers/iommu/io-pgtable-arm-v7s.c#L655
>
> This patch rebase on Joerg's mediatek-smmu-merge branch which has mt8183
> and Will's "Rework IOMMU API to allow for batching of invalidation".
> ---
>  drivers/iommu/mtk_iommu.c | 74 ++++++++++++-----------------------------------
>  drivers/iommu/mtk_iommu.h |  1 -
>  2 files changed, 19 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6066272..e13cc56 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -173,11 +173,12 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
>         }
>  }
>
> -static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
> -                                          size_t granule, bool leaf,
> -                                          void *cookie)
> +static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> +                                   size_t granule, void *cookie)
>  {
>         struct mtk_iommu_data *data = cookie;
> +       int ret;
> +       u32 tmp;
>
>         for_each_m4u(data) {
>                 writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> @@ -186,25 +187,15 @@ static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
>                 writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
>                 writel_relaxed(iova + size - 1,
>                                data->base + REG_MMU_INVLD_END_A);
> -               writel_relaxed(F_MMU_INV_RANGE,
> -                              data->base + REG_MMU_INVALIDATE);
> -               data->tlb_flush_active = true;
> -       }
> -}
> -
> -static void mtk_iommu_tlb_sync(void *cookie)
> -{
> -       struct mtk_iommu_data *data = cookie;
> -       int ret;
> -       u32 tmp;
> -
> -       for_each_m4u(data) {
> -               /* Avoid timing out if there's nothing to wait for */
> -               if (!data->tlb_flush_active)
> -                       return;
> +               writel(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
>
> +               /*
> +                * There is no tlb flush queue in the HW, the HW always expect
> +                * tlb_flush and tlb_sync one by one. Here tlb_sync always
> +                * follows tlb_flush to avoid break the sequence.
> +                */
>                 ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
> -                                               tmp, tmp != 0, 10, 100000);
> +                                               tmp, tmp != 0, 10, 1000);
>                 if (ret) {
>                         dev_warn(data->dev,
>                                  "Partial TLB flush timed out, falling back to full flush\n");
> @@ -212,36 +203,21 @@ static void mtk_iommu_tlb_sync(void *cookie)
>                 }
>                 /* Clear the CPE status */
>                 writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
> -               data->tlb_flush_active = false;
>         }
>  }
>
> -static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
> -                                    size_t granule, void *cookie)
> +static void mtk_iommu_tlb_flush_page(struct iommu_iotlb_gather *gather,
> +                                    unsigned long iova, size_t granule,
> +                                    void *cookie)
>  {
> -       mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
> -       mtk_iommu_tlb_sync(cookie);
> -}
> -
> -static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
> -                                    size_t granule, void *cookie)
> -{
> -       mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
> -       mtk_iommu_tlb_sync(cookie);
> -}
> -
> -static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
> -                                           unsigned long iova, size_t granule,
> -                                           void *cookie)
> -{
> -       mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
> +       mtk_iommu_tlb_add_flush(iova, granule, granule, cookie);
>  }
>
>  static const struct iommu_flush_ops mtk_iommu_flush_ops = {
>         .tlb_flush_all = mtk_iommu_tlb_flush_all,
> -       .tlb_flush_walk = mtk_iommu_tlb_flush_walk,
> -       .tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
> -       .tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
> +       .tlb_flush_walk = mtk_iommu_tlb_add_flush,
> +       .tlb_flush_leaf = mtk_iommu_tlb_add_flush,
> +       .tlb_add_page = mtk_iommu_tlb_flush_page,
>  };
>
>  static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> @@ -445,17 +421,6 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>         return unmapsz;
>  }
>
> -static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
> -{
> -       mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
> -}
> -
> -static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> -                                struct iommu_iotlb_gather *gather)
> -{
> -       mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
> -}
> -
>  static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>                                           dma_addr_t iova)
>  {
> @@ -574,8 +539,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>         .detach_dev     = mtk_iommu_detach_device,
>         .map            = mtk_iommu_map,
>         .unmap          = mtk_iommu_unmap,
> -       .flush_iotlb_all = mtk_iommu_flush_iotlb_all,

Don't we still want .flush_iotlb_all()? I think it should be more
efficient in some cases than doing a big number of single flushes.
(That said, the previous implementation didn't do any flush at all. It
just waited for previously queued flushes to happen. Was that
expected?)

Best regards,
Tomasz
