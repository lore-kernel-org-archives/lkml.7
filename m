Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0FAC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDF3207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NFSeelGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfL2MOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 07:14:09 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35571 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2MOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 07:14:08 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so11467535qvi.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 04:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3NS0YuGMiOiXrvIw4OA/SAcuSinUcRqRdHd2DvYzoZU=;
        b=NFSeelGFUGbKCnY4MqSk5IrHuOJpyf1wo+pWVTHkHUds2ORXCZQ9ZdmXN9EihMp0G5
         lHRNAdHN6dIOmbMgTi4yyntauiOE27BDDXpJKSUPL2oU5yT979aRlmrQE0dZZniw3jiJ
         pSPph8NB+DQM24IoCts8J/eQ75Dsg0nBWkwQ+LdHJE2UDadceeR6HyFyJ5eEm/8uUVoZ
         m9ebwScQ2dmn7eZkiD72WzW2SY0LgiDseNBOgNc3498eMD5CXqkFc0N9fgkZlC8KrXlX
         c9PB701VLPkZaRHo2CNIXoSRKwJB/SoveGPMHsShioMhaty7FQFVOQh319uxfaLWLbTg
         CAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3NS0YuGMiOiXrvIw4OA/SAcuSinUcRqRdHd2DvYzoZU=;
        b=Yd83D7JYpBXhmQMRk4MyfDdePjN+AkWw5Qrd9rAGQQJmBNFoFimclMHwJXWqHwGsA3
         QSPyVqy1MNUKfgZyzUFnuZhAKzZcE0iXII7NwKdBu3d0RMb02YZI1EGRwYjUBqj1lUhe
         uDrCEO4mvYTwC/rJbsiHihAIx64sH8hGlpurSy9uh1JWGTg9+IAczPYLOenPsOyH31xh
         sgy9iCbF3uL44MM60JRSzIqCqyVNgQbLk1LIHM+ZtnfmUTiy6BdwKi1PSfREZv7qHcn9
         zmCYyGMHtNJ/cayVkyxvfRgk5EiklM4hrIZaHUIHUr0rZOTgv4/L+B3rr//RcylWxUa8
         lufw==
X-Gm-Message-State: APjAAAVEssHRZ59tzZsRSW1dT2PysRlaJGeszdC4rT4AExau5KYydP5t
        8KUK8hqS950RRw1pgUnIdIrOTIvnkbZSl5Vo+yH04w==
X-Google-Smtp-Source: APXvYqzVMlGsS4IKEu6R5VeMGANUaqglI5oQ/UGu2nc8eNJ1v9AswUjiKA/FTrq6aO/sNZpWNbxd8BhAN0oCAaC6LsY=
X-Received: by 2002:ad4:55e8:: with SMTP id bu8mr48113914qvb.61.1577621647544;
 Sun, 29 Dec 2019 04:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20191210203149.7115-1-tiny.windzz@gmail.com> <CAEExFWvd1Md-guT=wgZ1-G69r71KBn64k2yGh0Vqjh_-D8yGuQ@mail.gmail.com>
In-Reply-To: <CAEExFWvd1Md-guT=wgZ1-G69r71KBn64k2yGh0Vqjh_-D8yGuQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 29 Dec 2019 13:13:56 +0100
Message-ID: <CAMpxmJUQjyCeNvczx_UKNL6PMnNWAPsY5ptCdz24YLXH_63nRg@mail.gmail.com>
Subject: Re: [PATCH] drivers: add devm_platform_ioremap_resource_byname() helper
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 28 gru 2019 o 18:39 Frank Lee <tiny.windzz@gmail.com> napisa=C5=82(a)=
:
>
> ping...
>
> On Wed, Dec 11, 2019 at 4:31 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > There are currently 300+ instances of using platform_get_resource_bynam=
e()
> > and devm_ioremap_resource() together in the kernel tree.
> >
> > This patch wraps these two calls in a single helper.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/base/platform.c         | 22 +++++++++++++++++++++-
> >  include/linux/platform_device.h |  3 +++
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index b6c6c7d97d5b..9c4f5e229600 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -60,6 +60,7 @@ struct resource *platform_get_resource(struct platfor=
m_device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_resource);
> >
> > +#ifdef CONFIG_HAS_IOMEM
> >  /**
> >   * devm_platform_ioremap_resource - call devm_ioremap_resource() for a=
 platform
> >   *                                 device
> > @@ -68,7 +69,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
> >   *        resource management
> >   * @index: resource index
> >   */
> > -#ifdef CONFIG_HAS_IOMEM
> > +
> >  void __iomem *devm_platform_ioremap_resource(struct platform_device *p=
dev,
> >                                              unsigned int index)
> >  {
> > @@ -78,6 +79,25 @@ void __iomem *devm_platform_ioremap_resource(struct =
platform_device *pdev,
> >         return devm_ioremap_resource(&pdev->dev, res);
> >  }
> >  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > +
> > +/**
> > + * devm_platform_ioremap_resource_byname - call devm_ioremap_resource(=
) for
> > + *                                        a platform device
> > + *
> > + * @pdev: platform device to use both for memory resource lookup as we=
ll as
> > + *        resource managemend
> > + * @name: resource name
> > + */
> > +void __iomem *
> > +devm_platform_ioremap_resource_byname(struct platform_device *pdev,
> > +                                     const char *name)
> > +{
> > +       struct resource *res;
> > +
> > +       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, name=
);
> > +       return devm_ioremap_resource(&pdev->dev, res);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
> >  #endif /* CONFIG_HAS_IOMEM */
> >
> >  static int __platform_get_irq(struct platform_device *dev, unsigned in=
t num)
> > diff --git a/include/linux/platform_device.h b/include/linux/platform_d=
evice.h
> > index 1b5cec067533..24ff5da9c532 100644
> > --- a/include/linux/platform_device.h
> > +++ b/include/linux/platform_device.h
> > @@ -63,6 +63,9 @@ extern int platform_irq_count(struct platform_device =
*);
> >  extern struct resource *platform_get_resource_byname(struct platform_d=
evice *,
> >                                                      unsigned int,
> >                                                      const char *);
> > +extern void __iomem *
> > +devm_platform_ioremap_resource_byname(struct platform_device *pdev,
> > +                                     const char *name);
> >  extern int platform_get_irq_byname(struct platform_device *, const cha=
r *);
> >  extern int platform_add_devices(struct platform_device **, int);
> >
> > --
> > 2.17.1
> >

This exact routine has existed upstream since commit c9c8641d3ebd
("drivers: provide devm_platform_ioremap_resource_byname()"). What
version are you working on?

Bart
