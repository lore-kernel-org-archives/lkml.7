Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ADCECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BE0206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="iscNzzWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfJJAqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:46:07 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45792 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbfJJAqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:46:06 -0400
Received: by mail-vs1-f67.google.com with SMTP id d204so2746313vsc.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jd6zv/jgUFv6Uo+8CynzJPGldhXHqgBv+Ky1v1k+Nuk=;
        b=iscNzzWLWcx0oCVq1jhdfQtsoDvqWFROyVb3ddID00ajMaSJM0Zy1lVPyfOO2TRGhU
         KLMncCT2yWC8FBys7/HgUv++l0GbRIAaSK0/gpNiFDWrcEyIz2N20E4LETCqJxFmjPn9
         g3ToYb+fEXGn1OUznhDaoTDSDZPmasSagoHCYHJoit7KuaiEYCwaYT/GYYVQZOFboT7U
         t95ukRhgcbt9VKjrrzQIAdIb92yS7W1Wlmq+4UIYcBc27Z4biow8ODlLc1BMw5rRWwka
         ahAt9hZoSKvavOjpNaYlfE5orR49QfNrLA9aQK7oLCrKK2rd/xB6H4HJ42U8pSifyIzT
         4wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd6zv/jgUFv6Uo+8CynzJPGldhXHqgBv+Ky1v1k+Nuk=;
        b=n33O91K9mH9FCaFmvGV09kEwzH9vryUIdrYwShYfpTHzstI14sNFHbTTl0+ayzxl3L
         pb9c9S+KQlO4d1oXC/6LE7cC8NGlzC+1FWtUXh2Cm/Eq4hztLG9HRCWIDdZuyGSdxeap
         aiX9E3wJ407aPDI39ORfTayugFj0hG04vJqzxpe3bIXMHpH5ZgAPtzqe1oxEggLnK1m/
         WWuam5wTQflEbHhaY6OEDXMLBcv5pHbicCUXPbQULi+FFdMcjrr1obFcCHZLv4m9HM0L
         XSbtt43+Eh83haVC/RQYwXVIyxjdSbV/VBoQDoW0WY4MMS4/9HXsE9vnURy9jvzXjZmf
         HHNA==
X-Gm-Message-State: APjAAAX9tdcksbY7TKiJwvBg7AoIOG/tP0CnirhgJDkEqTxff1ZZLluG
        W2KCGnwpH2Milmygm2Haj1itF5z12KRua8Dx/8dhKw==
X-Google-Smtp-Source: APXvYqy0hr+gzGjZPMkosJiHcRGhgxWhmhs8dGdGo9Ng0LSLTb9Rzsa72w7qjVcDpCLRLk6Q2CTmValXnPQLm0zjvv4=
X-Received: by 2002:a05:6102:115c:: with SMTP id j28mr3730813vsg.105.1570668365198;
 Wed, 09 Oct 2019 17:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191008230038.24037-1-ezequiel@collabora.com>
 <20191008230038.24037-3-ezequiel@collabora.com> <20191009180136.GE85762@art_vandelay>
In-Reply-To: <20191009180136.GE85762@art_vandelay>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 9 Oct 2019 21:45:54 -0300
Message-ID: <CAAEAJfDP0PsGAoRfGyDyWj7DxgP6nwwwA1_gwLQuVy-fRDa-UA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/rockchip: Add optional support for CRTC gamma LUT
To:     Sean Paul <sean@poorly.run>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sean,

Thanks for the thourough review.

On Wed, 9 Oct 2019 at 15:01, Sean Paul <sean@poorly.run> wrote:
>
> On Tue, Oct 08, 2019 at 08:00:37PM -0300, Ezequiel Garcia wrote:
> > Add an optional CRTC gamma LUT support, and enable it on RK3288.
> > This is currently enabled via a separate address resource,
> > which needs to be specified in the devicetree.
> >
> > The address resource is required because on some SoCs, such as
> > RK3288, the LUT address is after the MMU address, and the latter
> > is supported by a different driver. This prevents the DRM driver
> > from requesting an entire register space.
> >
> > The current implementation works for RGB 10-bit tables, as that
> > is what seems to work on RK3288.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>
> Hey Ezequiel,
> Just a few comments on the actual content of the patch as opposed to my higher
> level comments yesterday. I think we're almost there, thanks for sticking this
> out!
>
> > ---
> > Changes from v3:
> > * Move to atomic_enable and atomic_begin,
> >   as discussed with Sean Paul.
> > * Dropped the Reviewed-bys.
> > Changes from v2:
> > * None.
> > Changes from v1:
> > * drop explicit linear LUT after finding a proper
> >   way to disable gamma correction.
> > * avoid setting gamma is the CRTC is not active.
> > * s/int/unsigned int as suggested by Jacopo.
> > * only enable color management and set gamma size
> >   if gamma LUT is supported, suggested by Doug.
> > * drop the reg-names usage, and instead just use indexed reg
> >   specifiers, suggested by Doug.
> > Changes from RFC:
> > * Request (an optional) address resource for the LUT.
> > * Drop support for RK3399, which doesn't seem to work
> >   out of the box and needs more research.
> > * Support pass-thru setting when GAMMA_LUT is NULL.
> > * Add a check for the gamma size, as suggested by Ilia.
> > * Move gamma setting to atomic_commit_tail, as pointed
> >   out by Jacopo/Laurent, is the correct way.
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   1 +
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 125 ++++++++++++++++++++
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   5 +
> >  drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
> >  4 files changed, 133 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > index ca01234c037c..697ee04b85cf 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > @@ -17,6 +17,7 @@
> >  #include "rockchip_drm_drv.h"
> >  #include "rockchip_drm_fb.h"
> >  #include "rockchip_drm_gem.h"
> > +#include "rockchip_drm_vop.h"
>
> Leftover from the previous version?
>

Yup.

> >
> >  static const struct drm_framebuffer_funcs rockchip_drm_fb_funcs = {
> >       .destroy       = drm_gem_fb_destroy,
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index 613404f86668..85c1269a1218 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -139,6 +139,7 @@ struct vop {
> >
> >       uint32_t *regsbak;
> >       void __iomem *regs;
> > +     void __iomem *lut_regs;
> >
> >       /* physical map length of vop register */
> >       uint32_t len;
> > @@ -1048,6 +1049,84 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
> >       return true;
> >  }
> >
> > +static bool vop_dsp_lut_is_enable(struct vop *vop)
>
> *enabled
>

Good catch.

> > +{
> > +     return vop_read_reg(vop, 0, &vop->data->common->dsp_lut_en);
> > +}
> > +
> > +static void vop_crtc_write_gamma_lut(struct vop *vop, struct drm_crtc *crtc)
> > +{
> > +     struct drm_color_lut *lut = crtc->state->gamma_lut->data;
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < crtc->gamma_size; i++) {
> > +             u32 word;
> > +
> > +             word = (drm_color_lut_extract(lut[i].red, 10) << 20) |
> > +                    (drm_color_lut_extract(lut[i].green, 10) << 10) |
> > +                     drm_color_lut_extract(lut[i].blue, 10);
> > +             writel(word, vop->lut_regs + i * 4);
> > +     }
> > +}
> > +
> > +static void vop_crtc_gamma_set(struct vop *vop, struct drm_crtc *crtc,
> > +                            struct drm_crtc_state *old_crtc_state)
> > +{
> > +     unsigned int idle;
> > +     int ret;
> > +
>
> How about:
>
>         if (!vop->lut_regs)
>                 return;
>
> here and then you can remove that condition above the 2 callsites
>

Yes, sounds good.

> > +     /*
> > +      * In order to write the LUT to the internal memory,
> > +      * we need to first make sure the dsp_lut_en bit is cleared.
> > +      */
> > +     spin_lock(&vop->reg_lock);
> > +     VOP_REG_SET(vop, common, dsp_lut_en, 0);
> > +     vop_cfg_done(vop);
> > +     spin_unlock(&vop->reg_lock);
> > +
> > +     /*
> > +      * If the CRTC is not active, dsp_lut_en will not get cleared.
> > +      * Apparently we still need to do the above step to for
> > +      * gamma correction to be disabled.
> > +      */
> > +     if (!crtc->state->active)
> > +             return;
> > +

I have realized that the above might no longer be needed,
given we are now using atomic_enable and atomic_begin.

Not sure if the CRTC is supposed to clear its GAMMA
when disabled.

> > +     ret = readx_poll_timeout(vop_dsp_lut_is_enable, vop,
> > +                              idle, !idle, 5, 30 * 1000);
> > +     if (ret) {
> > +             DRM_DEV_ERROR(vop->dev, "display LUT RAM enable timeout!\n");
> > +             return;
> > +     }
> > +
> > +     if (crtc->state->gamma_lut &&
> > +        (!old_crtc_state->gamma_lut || (crtc->state->gamma_lut->base.id !=
> > +                                     old_crtc_state->gamma_lut->base.id))) {
>
> Silly question, but isn't the second part of this check redundant since you need
> color_mgmt_changed || active_changed to get into this function?
>
> So maybe invert the conditional here and exit early (to save a level of
> indentation in the block below):
>

I took this from malidp_atomic_commit_update_gamma. I _believe_
the rational for this is that color_mgmt_changed can be set by re-setting
the gamma property, to the same property. But I admit I haven't
tested it's the case.

OTOH, it won't really affect much to re-write the table, if the user
requested a change.

>         if (!crtc->state->gamma_lut)
>                 return;
>

In any case, inverting the condition makes sense.

>         spin_lock(&vop->reg_lock);
>
>         vop_crtc_write_gamma_lut(vop, crtc);
>         VOP_REG_SET(vop, common, dsp_lut_en, 1);
>         vop_cfg_done(vop);
>
>         spin_unlock(&vop->reg_lock);
>
> > +
> > +             spin_lock(&vop->reg_lock);
> > +
> > +             vop_crtc_write_gamma_lut(vop, crtc);
> > +             VOP_REG_SET(vop, common, dsp_lut_en, 1);
> > +             vop_cfg_done(vop);
> > +
> > +             spin_unlock(&vop->reg_lock);
> > +     }
> > +}
> > +
> > +static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
> > +                                struct drm_crtc_state *old_crtc_state)
> > +{
> > +     struct vop *vop = to_vop(crtc);
> > +
> > +     /*
> > +      * Only update GAMMA if the 'active' flag is not changed,
> > +      * otherwise it's updated by .atomic_enable.
> > +      */
> > +     if (vop->lut_regs && crtc->state->color_mgmt_changed &&
> > +         !crtc->state->active_changed)
> > +             vop_crtc_gamma_set(vop, crtc, old_crtc_state);
> > +}
> > +
> >  static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
> >                                  struct drm_crtc_state *old_state)
> >  {
> > @@ -1075,6 +1154,14 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
> >               return;
> >       }
> >
> > +     /*
> > +      * If we have a GAMMA LUT in the state, then let's make sure
> > +      * it's updated. We might be coming out of suspend,
> > +      * which means the LUT internal memory needs to be re-written.
> > +      */
> > +     if (vop->lut_regs && crtc->state->gamma_lut)
> > +             vop_crtc_gamma_set(vop, crtc, old_state);
> > +
> >       mutex_lock(&vop->vop_lock);
> >
> >       WARN_ON(vop->event);
> > @@ -1191,6 +1278,26 @@ static void vop_wait_for_irq_handler(struct vop *vop)
> >       synchronize_irq(vop->irq);
> >  }
> >
> > +static int vop_crtc_atomic_check(struct drm_crtc *crtc,
> > +                              struct drm_crtc_state *crtc_state)
> > +{
> > +     struct vop *vop = to_vop(crtc);
> > +
> > +     if (vop->lut_regs && crtc_state->color_mgmt_changed &&
> > +         crtc_state->gamma_lut) {
> > +             unsigned int len;
> > +
> > +             len = drm_color_lut_size(crtc_state->gamma_lut);
> > +             if (len != crtc->gamma_size) {
> > +                     DRM_DEBUG_KMS("Invalid LUT size; got %d, expected %d\n",
> > +                                   len, crtc->gamma_size);
> > +                     return -EINVAL;
> > +             }
>
> Overflow is avoided in drm_mode_gamma_set_ioctl(), so I don't think you need
> this function.
>

But that only applies to the legacy path. Isn't this needed to ensure
a gamma blob
has the right size?

Thanks,
Ezequiel
