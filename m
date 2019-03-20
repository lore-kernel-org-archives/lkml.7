Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C3320857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kNKfEAMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCTFjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:39:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35906 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfCTFjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:39:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id y36so1190720qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEjJ6etV+w60g+RQ+q8C242i8vp5K0OvlqD6WlyL/y0=;
        b=kNKfEAMv8ABrEKO4mNvJhWJHkmy23olQPW1F8poL0wlRQWaDsf9sww1wiu5oRgGWU0
         B1s6QZ6h8QGtz6w0hHXEqqC0ubPJORsG/H142+spghboBZCs30SuNCg9A0aaEXjhaLma
         6rBRksa7TRdbkIDujC7P6cbSJdoID9TRjkfpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEjJ6etV+w60g+RQ+q8C242i8vp5K0OvlqD6WlyL/y0=;
        b=bBoHsxKof0AoJJQu62X2hdBfuPYcQ7eLWWbSlmKXW+rPud0Nm0P4BCcTA8IdJ4JIPS
         uev9JHIuyl0NQhv3TtituhnRJhMnD3N4xPtERu8bWaIDuO7ja87SV+5Z8EbNda2sC08M
         L7JkCRoyNFbCRBf07oInUp7qW+MI5jGNI+8WK8i2MkWG3BQwAdJ+KzGcey/cgn3xUhVV
         z9493g7pAZ9mMrKrnIuMCneh7PgCylN6akWeQaDeeImqBwyl/l9W/ftzjoDSuiOLJhUb
         dzTe2Ws4ijoyPcvKSE8cc6ay4A2K1Ha+ElNRk60mpxIWyH2X9AUeVLZK/QfXqMQwqqvW
         RC5w==
X-Gm-Message-State: APjAAAV/gD6YYLHqy6mlCZaNOsVdhnyq5PNs56sWHRUg2+DJC4UjY0zf
        AeZywR3a5gjxtSn19SDpmMYoutqWyLtTofSfuo3DMA==
X-Google-Smtp-Source: APXvYqwNF8npuEOANcnBF3zfqs6fvis5pRJkPCwgmJPUFQANG7NjyBGn44+y5S3/SNkPmj/3nbbGGf7KbMvnXyv8zYg=
X-Received: by 2002:a0c:92e7:: with SMTP id c36mr5139523qvc.80.1553060376269;
 Tue, 19 Mar 2019 22:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190318040915.101218-1-hsinyi@chromium.org> <1553051356.20221.23.camel@mtksdaap41>
In-Reply-To: <1553051356.20221.23.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 20 Mar 2019 13:39:25 +0800
Message-ID: <CAJMQK-gSWiqu-cdBpsz54U_427bB7w3vZ01u6n2L0Ghd9vG6Dw@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm: mediatek: call mtk_dsi_stop() after mtk_drm_crtc_atomic_disable()
To:     CK Hu <ck.hu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:09 AM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Hsin-yi:
>
> On Mon, 2019-03-18 at 12:09 +0800, Hsin-Yi Wang wrote:
> > mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(), which needs
> > ovl irq for drm_crtc_wait_one_vblank(), since after mtk_dsi_stop() is called,
> > ovl irq will be disabled. If drm_crtc_wait_one_vblank() is called after last
> > irq, it will timeout with this message: "vblank wait timed out on crtc 0". This
> > happens sometimes when turning off the screen.
> >
> > In drm_atomic_helper.c#disable_outputs(),
> > the calling sequence when turning off the screen is:
> >
> > 1. mtk_dsi_encoder_disable()
> >      --> mtk_output_dsi_disable()
> >        --> mtk_dsi_stop();  // sometimes make vblank timeout in atomic_disable
> >          --> mtk_dsi_poweroff();
> > 2. mtk_drm_crtc_atomic_disable()
> >      --> drm_crtc_wait_one_vblank();
> >      ...
> >        --> mtk_dsi_ddp_stop()
> >          --> mtk_dsi_poweroff();
> >
>
> Thanks for your inference, but I wonder this patch meet all
> consideration. In MT8173 with a bridge chip, the timing to disable dsi
> signal output would influence bridge chip output garbage or not. It's
> better that you could test this on MT8173, or let this patch go for
> weeks and wait for someone to test. If no one care about MT8173, I could
> accept this patch.
We care about MT8173, but it's not easy to test since we have to bring
the whole kernel to >= 4.19 to be able to test latest dsi driver.
The patch (0707632b5bac) that added mtk_dsi_stop() was after MT8173
(on 3.18), for panel without bridge, so I think without mtk_dsi_stop()
was also working fine for MT8173.

>
> > Change to make mtk_dsi_stop() called in mtk_dsi_ddp_stop() instead of
> > mtk_output_dsi_disable().
>
> mtk_dsi_poweroff() has reference count, why not just move mtk_dsi_stop()
> into mtk_dsi_poweroff()?
Yes, we can also call mtk_dsi_stop() in mtk_dsi_poweroff() when
refcount is 0. I can send v2 if you think this way is better.

Thanks
>
> Regards,
> CK
>
> >
> > Fixes: 0707632b5bac ("drm/mediatek: update DSI sub driver flow for sending commands to panel")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index b00eb2d2e086..cdd9637dd517 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -696,7 +696,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
> >               }
> >       }
> >
> > -     mtk_dsi_stop(dsi);
> >       mtk_dsi_poweroff(dsi);
> >
> >       dsi->enabled = false;
> > @@ -857,6 +856,7 @@ static void mtk_dsi_ddp_stop(struct mtk_ddp_comp *comp)
> >  {
> >       struct mtk_dsi *dsi = container_of(comp, struct mtk_dsi, ddp_comp);
> >
> > +     mtk_dsi_stop(dsi);
> >       mtk_dsi_poweroff(dsi);
> >  }
> >
> > @@ -1178,6 +1178,8 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> >       struct mtk_dsi *dsi = platform_get_drvdata(pdev);
> >
> >       mtk_output_dsi_disable(dsi);
> > +     mtk_dsi_stop(dsi);
> > +     mtk_dsi_poweroff(dsi);
> >       component_del(&pdev->dev, &mtk_dsi_component_ops);
> >
> >       return 0;
>
>
