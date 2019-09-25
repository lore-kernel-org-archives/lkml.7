Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2A3C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3B721D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LHn/dys4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404394AbfIYLMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:12:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36736 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfIYLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:12:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so4523596oih.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nK4+x6lokMutnpcniLtp2w1s9sxjgIUbmeSBDjckPgQ=;
        b=LHn/dys4PfNl9wue6fYnxHYPwoRCurdRU9BwevjKhDB38q+FV1zLeuS5e5mMu2sFDA
         JVhUWUlZp/PtXuttke2u+ahvT9u+215JBP5fJ/elvb3E6+csp08rad5w4WQSAgc9wmiO
         VXHE0rquCe8KQcpTdAIpjPQvQyqkfy7ahYVfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nK4+x6lokMutnpcniLtp2w1s9sxjgIUbmeSBDjckPgQ=;
        b=k/d2I2rCXuxJOPqVJl0Gk86OAqgJXMpO4aQvaMWHxtamSBgIVNa+YGn/yypEGWZNvB
         +ewvn/K0WxgQdrgYtpdqftOzfgzPBWZvO/FghazelEvdJrwn3FW18sWu9V4Cl6J0Vwp3
         b6Whak0lCatMcrPzkXZotLipdTsuN4ufykgJYEC3CwsnEL/UJLlSn8AAtml2JRJhm59R
         Yp91M11/wWCVOnnvdUD9cOhH1kwBojla6hoOXBe65xpT8O0yYq4+ZdHoBGO/T3YLu6Vr
         JjI6Z6bRVxUViL7d/cDnXhSrc5e19o0h5E4QZ/gOg20hegpauqQf5qnqgLzyWXT+p+BS
         mxdw==
X-Gm-Message-State: APjAAAU2Px0KLh1rAW+iOeRaI8QoSUa07BG7kjdhUxtUN3x64Z0GH+SO
        4l7S+Ji/6i2DbRI76PKMDw69YpAx+p16EAeDmT6fMg==
X-Google-Smtp-Source: APXvYqwoG+SKCDFOo/04Y90Wn3zpm3anGFBDWIOL3ZiA+Cyrnc6PHY5jDvKjYzLX0StOUtOmXEx1WslEWAhPcYhQcK8=
X-Received: by 2002:aca:5c45:: with SMTP id q66mr3924785oib.132.1569409937811;
 Wed, 25 Sep 2019 04:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190923122014.18229-1-andrzej.p@collabora.com> <20190925093500.GB21018@arm.com>
In-Reply-To: <20190925093500.GB21018@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 25 Sep 2019 13:12:06 +0200
Message-ID: <CAKMK7uEkr8YWLxBkd4TdO0m2BjLTZ1G+9rFe_aiY6Ek9Jbb-ng@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: Add AFBC support
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>, nd <nd@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Sean Paul <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:35 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
>
> On Mon, Sep 23, 2019 at 02:20:13PM +0200, Andrzej Pietrasiewicz wrote:
> > From: Ezequiel Garcia <ezequiel@collabora.com>
> >
> > AFBC is a proprietary lossless image compression protocol and format.
> > It helps reduce memory bandwidth of the graphics pipeline operations.
> > This, in turn, improves power efficiency.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > [locking improvements]
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > [squashing the above, commit message and Rockchip AFBC modifier]
> > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 27 ++++++
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 94 ++++++++++++++++++++-
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 12 +++
> >  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 18 ++++
> >  include/uapi/drm/drm_fourcc.h               |  3 +
> >  5 files changed, 151 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > index 64ca87cf6d50..5178939a9c29 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > @@ -24,6 +24,27 @@ static const struct drm_framebuffer_funcs rockchip_drm_fb_funcs = {
> >       .dirty         = drm_atomic_helper_dirtyfb,
> >  };
> >
> > +static int
> > +rockchip_verify_afbc_mod(struct drm_device *dev,
> > +                      const struct drm_mode_fb_cmd2 *mode_cmd)
> > +{
> > +     if (mode_cmd->modifier[0] &
> > +         ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_ROCKCHIP)) {
> > +             DRM_DEV_ERROR(dev->dev,
> > +                           "Unsupported format modifier 0x%llx\n",
> > +                           mode_cmd->modifier[0]);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (mode_cmd->width > 2560) {
> > +             DRM_DEV_ERROR(dev->dev,
> > +                           "Unsupported width %d\n", mode_cmd->width);
> > +             return -EINVAL;
> > +     }
> > +
> I think you are missing one additional check here.
> framebuffer width and height should be aligned to 16 pixels as you are
> using AFBC_FORMAT_MOD_BLOCK_SIZE_16x16.
> Please have a look at malidp_verify_afbc_framebuffer_caps()

Maybe time to extract that into a helper, so that there's only one
copy of the code that validates a buffer with afbc modifier set?
-Daniel

>
> > +     return 0;
> > +}
> > +
> >  static struct drm_framebuffer *
> >  rockchip_fb_alloc(struct drm_device *dev, const struct drm_mode_fb_cmd2 *mode_cmd,
> >                 struct drm_gem_object **obj, unsigned int num_planes)
> > @@ -32,6 +53,12 @@ rockchip_fb_alloc(struct drm_device *dev, const struct drm_mode_fb_cmd2 *mode_cm
> >       int ret;
> >       int i;
> >
> > +     if (mode_cmd->modifier[0]) {
> > +             ret = rockchip_verify_afbc_mod(dev, mode_cmd);
> > +             if (ret)
> > +                     return ERR_PTR(ret);
> > +     }
> > +
> >       fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> >       if (!fb)
> >               return ERR_PTR(-ENOMEM);
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index 21b68eea46cc..50bf214d21da 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -46,6 +46,13 @@
> >               vop_reg_set(vop, &win->phy->scl->ext->name, \
> >                           win->base, ~0, v, #name)
> >
> > +#define VOP_AFBC_SET(x, name, v) \
> > +     do { \
> > +             if (vop->data->afbc) \
> > +                     vop_reg_set(vop, &vop->data->afbc->name, \
> > +                             0, ~0, v, #name); \
> > +     } while (0)
> > +
> >  #define VOP_WIN_YUV2YUV_SET(vop, win_yuv2yuv, name, v) \
> >       do { \
> >               if (win_yuv2yuv && win_yuv2yuv->name.mask) \
> > @@ -123,6 +130,8 @@ struct vop {
> >       struct drm_device *drm_dev;
> >       bool is_enabled;
> >
> > +     struct vop_win *afbc_win;
> > +
> >       struct completion dsp_hold_completion;
> >
> >       /* protected by dev->event_lock */
> > @@ -245,6 +254,30 @@ static bool has_rb_swapped(uint32_t format)
> >       }
> >  }
> >
> > +#define AFBC_FMT_RGB565        0x0
> > +#define AFBC_FMT_U8U8U8U8      0x5
> > +#define AFBC_FMT_U8U8U8        0x4
> > +
> > +static int vop_convert_afbc_format(uint32_t format)
> > +{
> > +     switch (format) {
> > +     case DRM_FORMAT_XRGB8888:
> > +     case DRM_FORMAT_ARGB8888:
> > +     case DRM_FORMAT_XBGR8888:
> > +     case DRM_FORMAT_ABGR8888:
> > +             return AFBC_FMT_U8U8U8U8;
> > +     case DRM_FORMAT_RGB888:
> > +     case DRM_FORMAT_BGR888:
> > +             return AFBC_FMT_U8U8U8;
> > +     case DRM_FORMAT_RGB565:
> > +     case DRM_FORMAT_BGR565:
> > +             return AFBC_FMT_RGB565;
> > +     default:
> > +             DRM_ERROR("unsupported afbc format[%08x]\n", format);
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> >  static enum vop_data_format vop_convert_format(uint32_t format)
> >  {
> >       switch (format) {
> > @@ -587,10 +620,16 @@ static int vop_enable(struct drm_crtc *crtc)
> >
> >               vop_win_disable(vop, win);
> >       }
> > -     spin_unlock(&vop->reg_lock);
> > +
> > +     if (vop->data->afbc) {
> > +             VOP_AFBC_SET(vop, enable, 0);
> > +             vop->afbc_win = NULL;
> > +     }
> >
> >       vop_cfg_done(vop);
> >
> > +     spin_unlock(&vop->reg_lock);
> > +
> >       /*
> >        * At here, vop clock & iommu is enable, R/W vop regs would be safe.
> >        */
> > @@ -719,6 +758,32 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
> >               return -EINVAL;
> >       }
> >
> > +     if (fb->modifier & DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_ROCKCHIP)) {
> > +             struct vop *vop = to_vop(crtc);
> > +
> > +             if (!vop->data->afbc) {
> > +                     DRM_ERROR("VOP does not support AFBC\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             ret = vop_convert_afbc_format(fb->format->format);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             if (state->src.x1 || state->src.y1) {
> > +                     DRM_ERROR("AFBC does not support offset display\n");
> > +                     DRM_ERROR("xpos=%d, ypos=%d, offset=%d\n",
> > +                             state->src.x1, state->src.y1, fb->offsets[0]);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (state->rotation && state->rotation != DRM_MODE_ROTATE_0) {
> > +                     DRM_ERROR("AFBC does not support rotation\n");
> > +                     DRM_ERROR("rotation=%d\n", state->rotation);
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -732,6 +797,9 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
> >       if (!old_state->crtc)
> >               return;
> >
> > +     if (vop->afbc_win == vop_win)
> > +             vop->afbc_win = NULL;
> > +
> >       spin_lock(&vop->reg_lock);
> >
> >       vop_win_disable(vop, win);
> > @@ -774,6 +842,9 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
> >       if (WARN_ON(!vop->is_enabled))
> >               return;
> >
> > +     if (vop->afbc_win == vop_win)
> > +             vop->afbc_win = NULL;
> > +
> >       if (!state->visible) {
> >               vop_plane_atomic_disable(plane, old_state);
> >               return;
> > @@ -808,6 +879,20 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
> >
> >       spin_lock(&vop->reg_lock);
> >
> > +     if (fb->modifier & DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_ROCKCHIP)) {
> > +             int afbc_format = vop_convert_afbc_format(fb->format->format);
> > +
> > +             VOP_AFBC_SET(vop, format, afbc_format | 1 << 4);
> > +             VOP_AFBC_SET(vop, hreg_block_split, 0);
> > +             VOP_AFBC_SET(vop, win_sel, win_index);
> > +             VOP_AFBC_SET(vop, hdr_ptr, dma_addr);
> > +             VOP_AFBC_SET(vop, pic_size, act_info);
> > +
> > +             vop->afbc_win = vop_win;
> > +
> > +             pr_info("AFBC on plane %s\n", plane->name);
> > +     }
> > +
> >       VOP_WIN_SET(vop, win, format, format);
> >       VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
> >       VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
> > @@ -1163,6 +1248,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
> >
> >       spin_lock(&vop->reg_lock);
> >
> > +     VOP_AFBC_SET(vop, enable, vop->afbc_win ? 0x1 : 0);
> >       vop_cfg_done(vop);
> >
> >       spin_unlock(&vop->reg_lock);
> > @@ -1471,7 +1557,8 @@ static int vop_create_crtc(struct vop *vop)
> >                                              0, &vop_plane_funcs,
> >                                              win_data->phy->data_formats,
> >                                              win_data->phy->nformats,
> > -                                            NULL, win_data->type, NULL);
> > +                                            win_data->phy->format_modifiers,
> > +                                            win_data->type, NULL);
> >               if (ret) {
> >                       DRM_DEV_ERROR(vop->dev, "failed to init plane %d\n",
> >                                     ret);
> > @@ -1511,7 +1598,8 @@ static int vop_create_crtc(struct vop *vop)
> >                                              &vop_plane_funcs,
> >                                              win_data->phy->data_formats,
> >                                              win_data->phy->nformats,
> > -                                            NULL, win_data->type, NULL);
> > +                                            win_data->phy->format_modifiers,
> > +                                            win_data->type, NULL);
> >               if (ret) {
> >                       DRM_DEV_ERROR(vop->dev, "failed to init overlay %d\n",
> >                                     ret);
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> > index 2149a889c29d..dc8b12025269 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> > @@ -77,6 +77,16 @@ struct vop_misc {
> >       struct vop_reg global_regdone_en;
> >  };
> >
> > +struct vop_afbc {
> > +     struct vop_reg enable;
> > +     struct vop_reg win_sel;
> > +     struct vop_reg format;
> > +     struct vop_reg hreg_block_split;
> > +     struct vop_reg pic_size;
> > +     struct vop_reg hdr_ptr;
> > +     struct vop_reg rstn;
> > +};
> > +
> >  struct vop_intr {
> >       const int *intrs;
> >       uint32_t nintrs;
> > @@ -128,6 +138,7 @@ struct vop_win_phy {
> >       const struct vop_scl_regs *scl;
> >       const uint32_t *data_formats;
> >       uint32_t nformats;
> > +     const uint64_t *format_modifiers;
> >
> >       struct vop_reg enable;
> >       struct vop_reg gate;
> > @@ -169,6 +180,7 @@ struct vop_data {
> >       const struct vop_output *output;
> >       const struct vop_win_yuv2yuv_data *win_yuv2yuv;
> >       const struct vop_win_data *win;
> > +     const struct vop_afbc *afbc;
> >       unsigned int win_size;
> >
> >  #define VOP_FEATURE_OUTPUT_RGB10     BIT(0)
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> > index 7b9c74750f6d..e9ff0c43c396 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> > @@ -30,6 +30,12 @@
> >  #define VOP_REG_MASK_SYNC(off, _mask, _shift) \
> >               _VOP_REG(off, _mask, _shift, true, false)
> >
> > +static const uint64_t format_modifiers_afbc[] = {
> > +     DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_ROCKCHIP),
> > +     DRM_FORMAT_MOD_LINEAR,
> > +     DRM_FORMAT_MOD_INVALID
> > +};
> > +
> >  static const uint32_t formats_win_full[] = {
> >       DRM_FORMAT_XRGB8888,
> >       DRM_FORMAT_ARGB8888,
> > @@ -667,6 +673,7 @@ static const struct vop_win_phy rk3368_win01_data = {
> >       .scl = &rk3288_win_full_scl,
> >       .data_formats = formats_win_full,
> >       .nformats = ARRAY_SIZE(formats_win_full),
> > +     .format_modifiers = format_modifiers_afbc,
> >       .enable = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 0),
> >       .format = VOP_REG(RK3368_WIN0_CTRL0, 0x7, 1),
> >       .rb_swap = VOP_REG(RK3368_WIN0_CTRL0, 0x1, 12),
> > @@ -758,6 +765,16 @@ static const struct vop_data rk3366_vop = {
> >       .win_size = ARRAY_SIZE(rk3368_vop_win_data),
> >  };
> >
> > +static const struct vop_afbc rk3399_afbc = {
> > +     .rstn = VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 3),
> > +     .enable = VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 0),
> > +     .win_sel = VOP_REG(RK3399_AFBCD0_CTRL, 0x3, 1),
> > +     .format = VOP_REG(RK3399_AFBCD0_CTRL, 0x1f, 16),
> > +     .hreg_block_split = VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 21),
> > +     .hdr_ptr = VOP_REG(RK3399_AFBCD0_HDR_PTR, 0xffffffff, 0),
> > +     .pic_size = VOP_REG(RK3399_AFBCD0_PIC_SIZE, 0xffffffff, 0),
> > +};
> > +
> >  static const struct vop_output rk3399_output = {
> >       .dp_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 16),
> >       .rgb_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 16),
> > @@ -808,6 +825,7 @@ static const struct vop_data rk3399_vop_big = {
> >       .modeset = &rk3288_modeset,
> >       .output = &rk3399_output,
> >       .misc = &rk3368_misc,
> > +     .afbc = &rk3399_afbc,
> >       .win = rk3368_vop_win_data,
> >       .win_size = ARRAY_SIZE(rk3368_vop_win_data),
> >       .win_yuv2yuv = rk3399_vop_big_win_yuv2yuv_data,
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > index 3feeaa3f987a..ba6caf06c824 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -742,6 +742,9 @@ extern "C" {
> >   */
> >  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> >
> > +#define AFBC_FORMAT_MOD_ROCKCHIP \
> > +     (AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 | AFBC_FORMAT_MOD_SPARSE)
> > +
> >  /*
> >   * Allwinner tiled modifier
> >   *
> > --
> > 2.17.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
