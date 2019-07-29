Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A3AC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA382070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmXswO1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfG2Fei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:34:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34665 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfG2Fei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:34:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so61382435otk.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 22:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaGp3kgEFZq5TRVhS/gSVCfAQk/B2Vhh2rMW5DZxtGU=;
        b=WmXswO1gqiSorGC4ip/zmQ4EJYLWz1GfFiJ7rsQn0fda4gOodSPR13eNYXLeVP8gI6
         TiItkjpeVAYZ9jPzIra+ug8Zd6QizwTno1TIvdOMHE5FM0LIJ6lw7a/Msw5J6QFW18FT
         4MVE2zcS/4P7OVuELVoX5VlLzqKO/4Uu7FD3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaGp3kgEFZq5TRVhS/gSVCfAQk/B2Vhh2rMW5DZxtGU=;
        b=PcGOC27vZlf/qP+7Sne2u4CkKOk6I10faEGgbOJ0N2/FD4I42p3W/Vnuzsp4Bt3ryg
         SvA4BC59Ni47jwyt580vKUxLQZ+hdONtQId2ZW5Wvvsikwiyb+9W05gYDR7LMZqYAkXy
         iHDZQLZ6b1MkA/cNRUQGeH8eyHkXYMAXL+/gzSIHKPRCsZKiIlbzH4zDSXbgKDQhUJvd
         KlsGuAtTbXl/0wWljSxyXZZZHutXbMQt1OJHV9UXL7SH2ZnKZi+tsF8y3fVLcpMYSJwp
         vHseZ42b3ONIPYmZu5N3TalHvDQBLs1/fBDOx32lgEMMcVzYu39w2ah/fMMrTlssEec2
         Xkog==
X-Gm-Message-State: APjAAAX10bjaK1Ecdg01mz+EfmEE78aCJIOUxZe0oa1BY25WFPy4u0Bm
        4qKD3FiPLrlUKxWTfsCKHjkEz14Sp3g=
X-Google-Smtp-Source: APXvYqwORMd3U80HV/WJA1CRbjAjhoo6S6+Db2DagVGu+yKwht6DqTkbrJMwJSJeZGv35vUjH8yqBw==
X-Received: by 2002:a9d:5f02:: with SMTP id f2mr80433122oti.148.1564378476585;
        Sun, 28 Jul 2019 22:34:36 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id o23sm19024155oie.20.2019.07.28.22.34.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 22:34:35 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id b7so11158382otl.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 22:34:35 -0700 (PDT)
X-Received: by 2002:a9d:30c3:: with SMTP id r3mr77017546otg.141.1564378474946;
 Sun, 28 Jul 2019 22:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190723053421.179679-1-acourbot@chromium.org> <1563947367.1070.7.camel@mtksdaap41>
In-Reply-To: <1563947367.1070.7.camel@mtksdaap41>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 29 Jul 2019 14:34:22 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV1_7PfvxhGFHQsTSh24gLTHyZWVG4ZXKsLCEqWDQb8-A@mail.gmail.com>
Message-ID: <CAPBb6MV1_7PfvxhGFHQsTSh24gLTHyZWVG4ZXKsLCEqWDQb8-A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: make imported PRIME buffers contiguous
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 2:49 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Alexandre:
>
> On Tue, 2019-07-23 at 14:34 +0900, Alexandre Courbot wrote:
> > This driver requires imported PRIME buffers to appear contiguously in
> > its IO address space. Make sure this is the case by setting the maximum
> > DMA segment size to a better value than the default 64K on the DMA
> > device, and use said DMA device when importing PRIME buffers.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 47 ++++++++++++++++++++++++--
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
> >  2 files changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index 95fdbd0fbcac..4ad4770fab13 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -213,6 +213,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >       struct mtk_drm_private *private = drm->dev_private;
> >       struct platform_device *pdev;
> >       struct device_node *np;
> > +     struct device *dma_dev;
> >       int ret;
> >
> >       if (!iommu_present(&platform_bus_type))
> > @@ -275,7 +276,27 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >               goto err_component_unbind;
> >       }
> >
> > -     private->dma_dev = &pdev->dev;
> > +     dma_dev = &pdev->dev;
> > +     private->dma_dev = dma_dev;
> > +
> > +     /*
> > +      * Configure the DMA segment size to make sure we get contiguous IOVA
> > +      * when importing PRIME buffers.
> > +      */
> > +     if (!dma_dev->dma_parms) {
> > +             private->dma_parms_allocated = true;
> > +             dma_dev->dma_parms =
> > +                     devm_kzalloc(drm->dev, sizeof(*dma_dev->dma_parms),
> > +                                  GFP_KERNEL);
> > +     }
> > +     if (!dma_dev->dma_parms)
> > +             goto err_component_unbind;
>
> return with ret = 0?

Oops, indeed.

>
> > +
> > +     ret = dma_set_max_seg_size(dma_dev, (unsigned int)DMA_BIT_MASK(32));
> > +     if (ret) {
> > +             dev_err(dma_dev, "Failed to set DMA segment size\n");
> > +             goto err_unset_dma_parms;
> > +     }
> >
> >       /*
> >        * We don't use the drm_irq_install() helpers provided by the DRM
> > @@ -285,13 +306,16 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >       drm->irq_enabled = true;
> >       ret = drm_vblank_init(drm, MAX_CRTC);
> >       if (ret < 0)
> > -             goto err_component_unbind;
> > +             goto err_unset_dma_parms;
> >
> >       drm_kms_helper_poll_init(drm);
> >       drm_mode_config_reset(drm);
> >
> >       return 0;
> >
> > +err_unset_dma_parms:
> > +     if (private->dma_parms_allocated)
> > +             dma_dev->dma_parms = NULL;
> >  err_component_unbind:
> >       component_unbind_all(drm->dev, drm);
> >  err_config_cleanup:
> > @@ -302,9 +326,14 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >
> >  static void mtk_drm_kms_deinit(struct drm_device *drm)
> >  {
> > +     struct mtk_drm_private *private = drm->dev_private;
> > +
> >       drm_kms_helper_poll_fini(drm);
> >       drm_atomic_helper_shutdown(drm);
> >
> > +     if (private->dma_parms_allocated)
> > +             private->dma_dev->dma_parms = NULL;
> > +
> >       component_unbind_all(drm->dev, drm);
> >       drm_mode_config_cleanup(drm);
> >  }
> > @@ -320,6 +349,18 @@ static const struct file_operations mtk_drm_fops = {
> >       .compat_ioctl = drm_compat_ioctl,
> >  };
> >
> > +/*
> > + * We need to override this because the device used to import the memory is
> > + * not dev->dev, as drm_gem_prime_import() expects.
> > + */
> > +struct drm_gem_object *mtk_drm_gem_prime_import(struct drm_device *dev,
> > +                                             struct dma_buf *dma_buf)
> > +{
> > +     struct mtk_drm_private *private = dev->dev_private;
> > +
> > +     return drm_gem_prime_import_dev(dev, dma_buf, private->dma_dev);
> > +}
> > +
>
> I think this part should be an independent patch which fixup
> 119f5173628aa ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")

I have split this patch and sent a v2.

Thanks,
Alex.
