Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C7CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19386205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="h0Qs3cb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEFPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:32:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43844 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEFPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:32:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so2527247wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoUlLUoustH5Kyyuv8cjzxtarKz9Yt28dcTG37LlDQc=;
        b=h0Qs3cb1N9VZYPv8SKIXGev/EpRRT057Mw/+lwEKRU0wLYa49RxNQR0uhiGXWaVaSx
         dkKmTbNYMXhRNk4HA7BIPXCKtbIX/jm4GDAJoXsD/R2kcPitxoAt+t5L4rQQEIHvi5Ua
         ANUWozNt8ZLo/qmWjlyIjWRwN1SwZ1Z1ESS5zGv8tyt1mng2cpH2XbxcUoA6N4reddWS
         P0unyNYp8+08m1j2eV09L82wnCZqSQBxhNmQztthHtmUCuc/rwkM2vL0hhXAlXvKcULu
         4u2vKXoEtfk2F/KOq3aZnG3XTlEpboZi7drQ7BN/ngoo0ojPwBsqhn9oIdr+oJF2CWUd
         86MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoUlLUoustH5Kyyuv8cjzxtarKz9Yt28dcTG37LlDQc=;
        b=mOFNKzf0zurs2InBp9JnTyWIqrnHa6jh0eUVqEhDg1kCpfXiePUQ1pj+7r4U6cM81m
         V8dwPHnyXy7DCozUusjW07jpFXYWXTjOuKzYgerXRoj985VdaAGyIkTAg+P/nS0fcU5F
         rxSs0+1pXHYhcDnoJB2sBxoktil3N3o+i2KNreLNYIppk2mjfBf+WB9Zosu0BkAujv2t
         9xszfJazh5OHoQmHmGQOhsSmbTn2o7GVL2cSOtj8G64eHhLQ9DmFSq5kIlBwO2bzR0UF
         w38TpUtfPaPbsreqEvg/5l3Mvi3tEnw3RzNYt5/nnziRYcE413iZUj76uejiz6D3Le5a
         gaTg==
X-Gm-Message-State: APjAAAVm3tIyXBoo25gsSilUpjYipOeoQT6d2OKu1/QT5HumDPQB7yPL
        waZmTTGauHpPk9vtmvF/1hyRvwVWFM+xjLjw6356QA==
X-Google-Smtp-Source: APXvYqytW0qHXUrR+10+PwAXQ3sa1dgLOTzgAB8CEL88CNxDnMKajzkJZIFB1K5SBaebS6V4BbioAAjynh76NIYsJSs=
X-Received: by 2002:a5d:5551:: with SMTP id g17mr20101431wrw.50.1557156746670;
 Mon, 06 May 2019 08:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190429020925.18136-1-baolu.lu@linux.intel.com> <20190429020925.18136-2-baolu.lu@linux.intel.com>
In-Reply-To: <20190429020925.18136-2-baolu.lu@linux.intel.com>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Mon, 6 May 2019 16:32:15 +0100
Message-ID: <CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iommu: Add ops entry for supported default domain type
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>, jacob.jun.pan@intel.com,
        "Tian, Kevin" <kevin.tian@intel.com>,
        James Sewart <jamessewart@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD driver already solves this problem and uses the generic
iommu_request_dm_for_dev function. It seems like both drivers have the
same problem and could use the same solution. Is there any reason we
can't have use the same solution for the intel and amd driver?

Could we just  copy the implementation of the AMD driver? It would be
nice to have the same behavior across both drivers especially as we
move to make both drivers use more generic code.

On Mon, Apr 29, 2019 at 3:16 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> This adds an optional ops entry to query the default domain
> types supported by the iommu driver for  a specific device.
> This is necessary in cases where the iommu driver can only
> support a specific type of default domain for a device. In
> normal cases, this ops will return IOMMU_DOMAIN_ANY which
> indicates that the iommu driver supports both IOMMU_DOMAIN_DMA
> and IOMMU_DOMAIN_IDENTITY, hence the static default domain
> type will be used.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 13 ++++++++++---
>  include/linux/iommu.h | 11 +++++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index acd6830e6e9b..1ad9a1f2e078 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1097,15 +1097,22 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>          * IOMMU driver.
>          */
>         if (!group->default_domain) {
> +               unsigned int domain_type = IOMMU_DOMAIN_ANY;
>                 struct iommu_domain *dom;
>
> -               dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
> -               if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
> +               if (ops->def_domain_type)
> +                       domain_type = ops->def_domain_type(dev);
> +
> +               if (domain_type == IOMMU_DOMAIN_ANY)
> +                       domain_type = iommu_def_domain_type;
> +
> +               dom = __iommu_domain_alloc(dev->bus, domain_type);
> +               if (!dom && domain_type != IOMMU_DOMAIN_DMA) {
>                         dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
>                         if (dom) {
>                                 dev_warn(dev,
>                                          "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
> -                                        iommu_def_domain_type);
> +                                        domain_type);
>                         }
>                 }
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 8239ece9fdfc..ba9a5b996a63 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -79,12 +79,16 @@ struct iommu_domain_geometry {
>   *     IOMMU_DOMAIN_DMA        - Internally used for DMA-API implementations.
>   *                               This flag allows IOMMU drivers to implement
>   *                               certain optimizations for these domains
> + *     IOMMU_DOMAIN_ANY        - All domain types defined here
>   */
>  #define IOMMU_DOMAIN_BLOCKED   (0U)
>  #define IOMMU_DOMAIN_IDENTITY  (__IOMMU_DOMAIN_PT)
>  #define IOMMU_DOMAIN_UNMANAGED (__IOMMU_DOMAIN_PAGING)
>  #define IOMMU_DOMAIN_DMA       (__IOMMU_DOMAIN_PAGING |        \
>                                  __IOMMU_DOMAIN_DMA_API)
> +#define IOMMU_DOMAIN_ANY       (IOMMU_DOMAIN_IDENTITY |        \
> +                                IOMMU_DOMAIN_UNMANAGED |       \
> +                                IOMMU_DOMAIN_DMA)
>
>  struct iommu_domain {
>         unsigned type;
> @@ -196,6 +200,11 @@ enum iommu_dev_features {
>   * @dev_feat_enabled: check enabled feature
>   * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
>   * @aux_get_pasid: get the pasid given an aux-domain
> + * @def_domain_type: get per-device default domain type that the IOMMU
> + *             driver is able to support. Valid returns values:
> + *             - IOMMU_DOMAIN_DMA: only suports non-identity domain
> + *             - IOMMU_DOMAIN_IDENTITY: only supports identity domain
> + *             - IOMMU_DOMAIN_ANY: supports all
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>   */
>  struct iommu_ops {
> @@ -251,6 +260,8 @@ struct iommu_ops {
>         void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
>         int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
>
> +       int (*def_domain_type)(struct device *dev);
> +
>         unsigned long pgsize_bitmap;
>  };
>
> --
> 2.17.1
>
