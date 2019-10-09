Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AF2ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2AF21920
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdi+f4aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfJIIWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:22:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43309 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJIIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:22:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so1373588qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vS6ftWv38t6sGsCONON8A/FlGoTEEeUhyw2u38Psys=;
        b=Cdi+f4aCoQax6/k08emQ2lJLcJma2WQWPj2sDWaUAIyNxc1z4FKB8BqfKmJ9Z5SarE
         DE3N/4o2O2mNISHES1onvLTvuRpQiyEXHitSlBua8rinA6JART4GoBf7vdEvu+n7rN9U
         XvCz6sm2vxFbnosUIiTDnUCTP07dZZ94GVayWBBS7bbGQdwhuhTe2jwZepH8sWdDtNgP
         G5SCwFbB+xNM+G2nK1s/aU9B2cvG+KpT0+/ggvOzIUE441IEmQK1CKPgRbnFUH/5+41b
         b45CSPFkm3mrlWBB2+nVpXXqESBNOTSmaanoB4L6eg4BXILbn5BcpREj3YdWgO9VnM0i
         6Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vS6ftWv38t6sGsCONON8A/FlGoTEEeUhyw2u38Psys=;
        b=mD+mPaO+Nlu52AObNstoCddwK3xzTNOIOIGYI49+W9F/ap38K9MQkxWtkrEAe7FEnC
         y1RfcZVulEMi0NUwVyPJttV7voaGe2GcMSjo43+49GvG0qPuMRDlxpoRpfWXWPv94k9Q
         fflpt4zfAXmARI9KkRF4Xm3+/OBH9K+fuV7Jl3vDnA78k2R/poW5HmlUr4JzBaDXh9UI
         iWncqTQvD/w0Pq2hulXZ9FTWC7wprTWSK1sfaUkQZMChY92xqxvxiumRDSFOq5YFmlZB
         jIbVX5+CCXlF86aKjkdFzOyW5DFdNksXhJovKUcGgrE1sgvoVdqv7/4Ok2MG7QVCxR62
         zkMg==
X-Gm-Message-State: APjAAAWM08q+96WxGJ328fdOe6nqcdmgE0hY7D5C1tVLS+9BJqhrIREk
        5NyLT63ErFm7mR38/CVykg2f7P9jtVPt/d5neKJ5Nkl2mhQ=
X-Google-Smtp-Source: APXvYqxsOXmemHID6heONiV8vI+KimCDKqoQrtNjmYG58JhuwE01IW+RdWPgGIjDI48XZ9ZREJZcjouZaIm3zI7sOfA=
X-Received: by 2002:a05:620a:a55:: with SMTP id j21mr2361419qka.402.1570609334042;
 Wed, 09 Oct 2019 01:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190925184346.14121-1-heiko@sntech.de>
In-Reply-To: <20190925184346.14121-1-heiko@sntech.de>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 9 Oct 2019 10:22:02 +0200
Message-ID: <CAFqH_53xE7fH-Mf0_qokamUCBNDedadSLQa=uxiP_v7TW7DPfw@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: don't use platform_get_irq to implicitly
 count irqs
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de Heiko Stuebner <heiko@sntech.de> del dia dc., 25 de set.
2019 a les 20:44:
>
> Till now the Rockchip iommu driver walked through the irq list via
> platform_get_irq() until it encountered an ENXIO error. With the
> recent change to add a central error message, this always results
> in such an error for each iommu on probe and shutdown.
>
> To not confuse people, switch to platform_count_irqs() to get the
> actual number of interrupts before walking through them.
>
> Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

This patch definitely removes the annoying messages on my Samsung
Chromebook Plus like:

 rk_iommu ff924000.iommu: IRQ index 1 not found
 rk_iommu ff914000.iommu: IRQ index 1 not found
 rk_iommu ff903f00.iommu: IRQ index 1 not found
 rk_iommu ff8f3f00.iommu: IRQ index 1 not found
 rk_iommu ff650800.iommu: IRQ index 1 not found

FWIW, I sent a similar patch [1] to fix this, but can be rejected in
favour of the Heiko's patch. So,

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

[1] https://lkml.org/lkml/2019/10/8/551

>  drivers/iommu/rockchip-iommu.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 26290f310f90..4dcbf68dfda4 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -100,6 +100,7 @@ struct rk_iommu {
>         struct device *dev;
>         void __iomem **bases;
>         int num_mmu;
> +       int num_irq;
>         struct clk_bulk_data *clocks;
>         int num_clocks;
>         bool reset_disabled;
> @@ -1136,7 +1137,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
>         struct rk_iommu *iommu;
>         struct resource *res;
>         int num_res = pdev->num_resources;
> -       int err, i, irq;
> +       int err, i;
>
>         iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>         if (!iommu)
> @@ -1163,6 +1164,10 @@ static int rk_iommu_probe(struct platform_device *pdev)
>         if (iommu->num_mmu == 0)
>                 return PTR_ERR(iommu->bases[0]);
>
> +       iommu->num_irq = platform_irq_count(pdev);
> +       if (iommu->num_irq < 0)
> +               return iommu->num_irq;
> +
>         iommu->reset_disabled = device_property_read_bool(dev,
>                                         "rockchip,disable-mmu-reset");
>
> @@ -1219,8 +1224,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
>
>         pm_runtime_enable(dev);
>
> -       i = 0;
> -       while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
> +       for (i = 0; i < iommu->num_irq; i++) {
> +               int irq = platform_get_irq(pdev, i);
> +
>                 if (irq < 0)
>                         return irq;
>
> @@ -1245,10 +1251,13 @@ static int rk_iommu_probe(struct platform_device *pdev)
>  static void rk_iommu_shutdown(struct platform_device *pdev)
>  {
>         struct rk_iommu *iommu = platform_get_drvdata(pdev);
> -       int i = 0, irq;
> +       int i;
> +
> +       for (i = 0; i < iommu->num_irq; i++) {
> +               int irq = platform_get_irq(pdev, i);
>
> -       while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
>                 devm_free_irq(iommu->dev, irq, iommu);
> +       }
>
>         pm_runtime_force_suspend(&pdev->dev);
>  }
> --
> 2.23.0
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
