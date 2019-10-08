Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0348C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701BF21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFqMTY83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfJHUVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:21:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42102 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJHUVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:21:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so67108qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lb2Je/FVvSIp4JAjesvlduQNxjeyTsmsHcBjn2d15pA=;
        b=gFqMTY83ri1G1Q3a3+d/vgKrQH13AeMQFKA5+3XCUQQ5VxAjg/DDRTj63/JC1oxUmL
         4uQDT9L5LDFglDW/XmySnTbZPbIenfUZeSuWuYPFrKbgXYrLTmz07yXpJ6M2WoS4+rN7
         Tatp7IOPVa/gpWTOfsUsNquL9GOvbj7Z4pLFsEfuR/aUPcOF5xcEdXxVAGn57QsmFgdF
         CFHDapQacOmH2FVH5aD+AK6HgMYYPu3YOBkTJhuf788UfGtQiDFqHrakFGXti/zvMHWu
         ld6WVH/Yp/I0qejzXbHbbVCXef4OY822Z6LC0wOuf0TFCwJ6HmucFyGJqFEfD/DrWzvC
         veMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lb2Je/FVvSIp4JAjesvlduQNxjeyTsmsHcBjn2d15pA=;
        b=MKTXt9CksPzhn9RH9T6RLdgyZp6CzrFa4mNGUveqxbZnT5zUjedM3XCEdYYwq1Nhz0
         Nn7oELsT1MqxYHIxYxcbL9M+YFOjHx1pSkH3C5PtlC9j5G3h1r+4ZICciL6w01+W3dYV
         wG7iTcin9KmvDDyxR6UvPmNIa21rRvJiceitOI5av04cEYHMvahBMh0DbqMOPCHzGTyr
         25P8eLBZg+2N0yTgLBui/KKKGd4qmGU1o93Rgva2zXMBRIQ9iNB10gxnLBjIqd2nZZRv
         Qjqagqfw03dgkn6OOJGucYxPEwSJWmslkcJa86XIalYkaDi4whMwjuBMtoRo+L3f/7ry
         VzAg==
X-Gm-Message-State: APjAAAWqTPixiyTzL6h69v+QMpMvGqUz1Xt6LeHDEyNeGc7AIo2+1aGt
        zbLFg65FgbDBGJEZGgfxHsW+v1DP2XfGsTCVI+KoMmWa
X-Google-Smtp-Source: APXvYqyCME5OyPZ4LEHQGOMvfISR2tdIQhh93r/3wK1dT60Ej4LS72zq2S8E42mYxfOZG12f0ilc0Gnlb3E73t9ysmc=
X-Received: by 2002:a05:620a:15d2:: with SMTP id o18mr19079989qkm.341.1570566109995;
 Tue, 08 Oct 2019 13:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191008135843.30640-1-enric.balletbo@collabora.com> <3132916.nyj3dfveGU@diego>
In-Reply-To: <3132916.nyj3dfveGU@diego>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 8 Oct 2019 22:21:39 +0200
Message-ID: <CAFqH_50xbB-+zEffHYPt+NPCVAikQpcWc_uxbkA0a6ppT5OJQA@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: Don't loop until failure to count interrupts
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Missatge de Heiko St=C3=BCbner <heiko@sntech.de> del dia dt., 8 d=E2=80=99o=
ct. 2019
a les 19:58:
>
> Hi Enric,
>
> Am Dienstag, 8. Oktober 2019, 15:58:43 CEST schrieb Enric Balletbo i Serr=
a:
> > As platform_get_irq() now prints an error when the interrupt does not
> > exist, counting interrupts by looping until failure causes the printing
> > of scary messages like:
> >
> >  rk_iommu ff924000.iommu: IRQ index 1 not found
> >  rk_iommu ff914000.iommu: IRQ index 1 not found
> >  rk_iommu ff903f00.iommu: IRQ index 1 not found
> >  rk_iommu ff8f3f00.iommu: IRQ index 1 not found
> >  rk_iommu ff650800.iommu: IRQ index 1 not found
> >
> > Fix this by using the platform_irq_count() helper to avoid touching
> > non-existent interrupts.
>
> It looks like we did the same fix ... see my patch from september 25:
> https://patchwork.kernel.org/patch/11161221/
>

How in the hell I didn't catch this patch! Anyway, forget about this
patch then, sorry for the noise.

Thanks,
 Enric

>
> > Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message t=
o platform_get_irq*()")
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  drivers/iommu/rockchip-iommu.c | 35 +++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-io=
mmu.c
> > index 26290f310f90..8c6318bd1b37 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> > @@ -1136,7 +1136,7 @@ static int rk_iommu_probe(struct platform_device =
*pdev)
> >       struct rk_iommu *iommu;
> >       struct resource *res;
> >       int num_res =3D pdev->num_resources;
> > -     int err, i, irq;
> > +     int err, i, irq, num_irqs;
> >
> >       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> >       if (!iommu)
> > @@ -1219,20 +1219,28 @@ static int rk_iommu_probe(struct platform_devic=
e *pdev)
> >
> >       pm_runtime_enable(dev);
> >
> > -     i =3D 0;
> > -     while ((irq =3D platform_get_irq(pdev, i++)) !=3D -ENXIO) {
> > -             if (irq < 0)
> > -                     return irq;
> > +     num_irqs =3D platform_irq_count(pdev);
> > +     if (num_irqs < 0) {
> > +             err =3D num_irqs;
> > +             goto err_disable_pm_runtime;
> > +     }
>
> By moving the basic irq count above the pm_runtime_enable
> you save some lines and the whole goto logic ... see my patch
> for reference :-D
>
> Heiko
>
> > +
> > +     for (i =3D 0; i < num_irqs; i++) {
> > +             irq =3D platform_get_irq(pdev, i);
> > +             if (irq < 0) {
> > +                     err =3D irq;
> > +                     goto err_disable_pm_runtime;
> > +             }
> >
> >               err =3D devm_request_irq(iommu->dev, irq, rk_iommu_irq,
> >                                      IRQF_SHARED, dev_name(dev), iommu)=
;
> > -             if (err) {
> > -                     pm_runtime_disable(dev);
> > -                     goto err_remove_sysfs;
> > -             }
> > +             if (err)
> > +                     goto err_disable_pm_runtime;
> >       }
> >
> >       return 0;
> > +err_disable_pm_runtime:
> > +     pm_runtime_disable(dev);
> >  err_remove_sysfs:
> >       iommu_device_sysfs_remove(&iommu->iommu);
> >  err_put_group:
> > @@ -1245,10 +1253,15 @@ static int rk_iommu_probe(struct platform_devic=
e *pdev)
> >  static void rk_iommu_shutdown(struct platform_device *pdev)
> >  {
> >       struct rk_iommu *iommu =3D platform_get_drvdata(pdev);
> > -     int i =3D 0, irq;
> > +     int i, irq, num_irqs;
> >
> > -     while ((irq =3D platform_get_irq(pdev, i++)) !=3D -ENXIO)
> > +     num_irqs =3D platform_irq_count(pdev);
> > +     for (i =3D 0; i < num_irqs; i++) {
> > +             irq =3D platform_get_irq(pdev, i);
> > +             if (irq < 0)
> > +                     continue;
> >               devm_free_irq(iommu->dev, irq, iommu);
> > +     }
> >
> >       pm_runtime_force_suspend(&pdev->dev);
> >  }
> >
>
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
