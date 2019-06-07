Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EE6C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1FF208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WacQlm3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfFGMs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:48:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38912 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfFGMs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:48:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so1128566qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dYAnPJ618ZNlHVYVCO5fYAE+fci+l9fnhn/c36/XLCw=;
        b=WacQlm3bQvBfM+EIlriRzhlehMTLBuyeNLsvmJ6snBuBT+LX5MF6nplisZwdZtEF7p
         rI5auG7ZYVYFKtZ3EqwsgZWjsrXBx1fHIMbHLvPpS5FXyTs1VCWPwqakhL326+9tzZfM
         tCqrAHPKlGDuclNDBWyMwdCnOq7bqltjGLZaSwhQVGZl5fXERNBRY0EhQPBs3E/HmH7B
         hzLYkO2OhrLcpjnG9FZ2mBcdm1LeQ1aGL5mzc3S3GI7mgIo1xFh1B3PV112Fz2eS5O4E
         TanAEJ/XFSBb2dSlrOxBQRWMmsDXuXiJ34JK2P/go/jFEBopvnshj0OTd0od1pW1u0aN
         tDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dYAnPJ618ZNlHVYVCO5fYAE+fci+l9fnhn/c36/XLCw=;
        b=AKIa5Otxwpz34hC+0nhgZPs/zAYqr0Qdv8jaFsmsrpevNhE8NfxCWrSZQ55hyMhUC+
         wymWlwwKihJZG2o4tFRehncjLVIRf7pG7V2oycBQiEKISlev4QP89MOpfxuNAu7FUxI6
         VagnTpVteJX4kv7/knjCXvSL1IpMnOcSwqVCvipu9TLXj6aqLa3fnoH0Zy5khpA9bpBK
         3ag+7u6HZuCPblIuuPhRUTDPc8POpzwE/rhXn9D6ONLgXN9/X9WRPegROvhsuFi2ANCc
         vHFvaUvz0R9OMxsnT+dku77ioOMZGFmD6ggkwF3FStqzC0JNK5l9fxlwTn4/IdDAWCqc
         +0gg==
X-Gm-Message-State: APjAAAXhroCFErcHFrHHl4KzYLSHdeJpMBY4LUNRq2SMVDJJPziagIxe
        SF/ZVbCQJQI4eXIwJ8e2NbSAfTWr4UIkhP0QYZUL5A==
X-Google-Smtp-Source: APXvYqwUU48WBatmv6D8pl//FuXWECj474GYcJuX2tDvxT5etPKeLvAMMepQ6NVfTDo8qsuh7E7LdEC4+0XhmJAR/Kk=
X-Received: by 2002:ae9:e40f:: with SMTP id q15mr14992240qkc.241.1559911735396;
 Fri, 07 Jun 2019 05:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <1559550722-14091-1-git-send-email-yannick.fertre@st.com> <abc976d8-9867-335c-1cb1-6f5c0dd1586c@st.com>
In-Reply-To: <abc976d8-9867-335c-1cb1-6f5c0dd1586c@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 7 Jun 2019 14:48:44 +0200
Message-ID: <CA+M3ks4ZJtHfDkJoGx7yyck+teRsmzhkBt_LonS9Z9awOnurzA@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: support runtime power management
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 7 juin 2019 =C3=A0 13:19, Philippe CORNU <philippe.cornu@st.com> a =
=C3=A9crit :
>
> Hi Yannick,
>
> Thank you for your patch
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next

Thanks,
Benjamin
>
> Philippe :-)
>
> On 6/3/19 10:32 AM, Yannick Fertr=C3=A9 wrote:
> > This patch enables runtime power management (runtime PM) support for
> > the display controller. pm_runtime_enable() and pm_runtime_disable()
> > are added during ltdc load and unload respectively.
> > pm_runtime_get_sync() and pm_runtime_put_sync() are added for ltdc
> > register access.
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/drv.c  | 43 +++++++++++++++++++++++------
> >   drivers/gpu/drm/stm/ltdc.c | 67 +++++++++++++++++++++++++++++++++++--=
---------
> >   2 files changed, 86 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> > index 5834ef5..5659572 100644
> > --- a/drivers/gpu/drm/stm/drv.c
> > +++ b/drivers/gpu/drm/stm/drv.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/dma-mapping.h>
> >   #include <linux/module.h>
> >   #include <linux/of_platform.h>
> > +#include <linux/pm_runtime.h>
> >
> >   #include <drm/drm_atomic.h>
> >   #include <drm/drm_atomic_helper.h>
> > @@ -135,14 +136,15 @@ static __maybe_unused int drv_suspend(struct devi=
ce *dev)
> >       struct ltdc_device *ldev =3D ddev->dev_private;
> >       struct drm_atomic_state *state;
> >
> > -     drm_kms_helper_poll_disable(ddev);
> > +     if (WARN_ON(!ldev->suspend_state))
> > +             return -ENOENT;
> > +
> >       state =3D drm_atomic_helper_suspend(ddev);
> > -     if (IS_ERR(state)) {
> > -             drm_kms_helper_poll_enable(ddev);
> > +     if (IS_ERR(state))
> >               return PTR_ERR(state);
> > -     }
> > +
> >       ldev->suspend_state =3D state;
> > -     ltdc_suspend(ddev);
> > +     pm_runtime_force_suspend(dev);
> >
> >       return 0;
> >   }
> > @@ -151,16 +153,41 @@ static __maybe_unused int drv_resume(struct devic=
e *dev)
> >   {
> >       struct drm_device *ddev =3D dev_get_drvdata(dev);
> >       struct ltdc_device *ldev =3D ddev->dev_private;
> > +     int ret;
> >
> > -     ltdc_resume(ddev);
> > -     drm_atomic_helper_resume(ddev, ldev->suspend_state);
> > -     drm_kms_helper_poll_enable(ddev);
> > +     pm_runtime_force_resume(dev);
> > +     ret =3D drm_atomic_helper_resume(ddev, ldev->suspend_state);
> > +     if (ret) {
> > +             pm_runtime_force_suspend(dev);
> > +             ldev->suspend_state =3D NULL;
> > +             return ret;
> > +     }
> >
> >       return 0;
> >   }
> >
> > +static __maybe_unused int drv_runtime_suspend(struct device *dev)
> > +{
> > +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +     ltdc_suspend(ddev);
> > +
> > +     return 0;
> > +}
> > +
> > +static __maybe_unused int drv_runtime_resume(struct device *dev)
> > +{
> > +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +
> > +     DRM_DEBUG_DRIVER("\n");
> > +     return ltdc_resume(ddev);
> > +}
> > +
> >   static const struct dev_pm_ops drv_pm_ops =3D {
> >       SET_SYSTEM_SLEEP_PM_OPS(drv_suspend, drv_resume)
> > +     SET_RUNTIME_PM_OPS(drv_runtime_suspend,
> > +                        drv_runtime_resume, NULL)
> >   };
> >
> >   static int stm_drm_platform_probe(struct platform_device *pdev)
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index ac29890..a40870b 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/of_address.h>
> >   #include <linux/of_graph.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/reset.h>
> >
> >   #include <drm/drm_atomic.h>
> > @@ -444,6 +445,7 @@ static void ltdc_crtc_atomic_disable(struct drm_crt=
c *crtc,
> >                                    struct drm_crtc_state *old_state)
> >   {
> >       struct ltdc_device *ldev =3D crtc_to_ltdc(crtc);
> > +     struct drm_device *ddev =3D crtc->dev;
> >
> >       DRM_DEBUG_DRIVER("\n");
> >
> > @@ -457,6 +459,8 @@ static void ltdc_crtc_atomic_disable(struct drm_crt=
c *crtc,
> >
> >       /* immediately commit disable of layers before switching off LTDC=
 */
> >       reg_set(ldev->regs, LTDC_SRCR, SRCR_IMR);
> > +
> > +     pm_runtime_put_sync(ddev->dev);
> >   }
> >
> >   #define CLK_TOLERANCE_HZ 50
> > @@ -505,17 +509,31 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc =
*crtc,
> >                                struct drm_display_mode *adjusted_mode)
> >   {
> >       struct ltdc_device *ldev =3D crtc_to_ltdc(crtc);
> > +     struct drm_device *ddev =3D crtc->dev;
> >       int rate =3D mode->clock * 1000;
> > +     bool runtime_active;
> > +     int ret;
> > +
> > +     runtime_active =3D pm_runtime_active(ddev->dev);
> > +
> > +     if (runtime_active)
> > +             pm_runtime_put_sync(ddev->dev);
> >
> > -     clk_disable(ldev->pixel_clk);
> >       if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
> >               DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate)=
;
> >               return false;
> >       }
> > -     clk_enable(ldev->pixel_clk);
> >
> >       adjusted_mode->clock =3D clk_get_rate(ldev->pixel_clk) / 1000;
> >
> > +     if (runtime_active) {
> > +             ret =3D pm_runtime_get_sync(ddev->dev);
> > +             if (ret) {
> > +                     DRM_ERROR("Failed to fixup mode, cannot get sync\=
n");
> > +                     return false;
> > +             }
> > +     }
> > +
> >       DRM_DEBUG_DRIVER("requested clock %dkHz, adjusted clock %dkHz\n",
> >                        mode->clock, adjusted_mode->clock);
> >
> > @@ -525,11 +543,21 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc =
*crtc,
> >   static void ltdc_crtc_mode_set_nofb(struct drm_crtc *crtc)
> >   {
> >       struct ltdc_device *ldev =3D crtc_to_ltdc(crtc);
> > +     struct drm_device *ddev =3D crtc->dev;
> >       struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
> >       struct videomode vm;
> >       u32 hsync, vsync, accum_hbp, accum_vbp, accum_act_w, accum_act_h;
> >       u32 total_width, total_height;
> >       u32 val;
> > +     int ret;
> > +
> > +     if (!pm_runtime_active(ddev->dev)) {
> > +             ret =3D pm_runtime_get_sync(ddev->dev);
> > +             if (ret) {
> > +                     DRM_ERROR("Failed to set mode, cannot get sync\n"=
);
> > +                     return;
> > +             }
> > +     }
> >
> >       drm_display_mode_to_videomode(mode, &vm);
> >
> > @@ -590,6 +618,7 @@ static void ltdc_crtc_atomic_flush(struct drm_crtc =
*crtc,
> >                                  struct drm_crtc_state *old_crtc_state)
> >   {
> >       struct ltdc_device *ldev =3D crtc_to_ltdc(crtc);
> > +     struct drm_device *ddev =3D crtc->dev;
> >       struct drm_pending_vblank_event *event =3D crtc->state->event;
> >
> >       DRM_DEBUG_ATOMIC("\n");
> > @@ -602,12 +631,12 @@ static void ltdc_crtc_atomic_flush(struct drm_crt=
c *crtc,
> >       if (event) {
> >               crtc->state->event =3D NULL;
> >
> > -             spin_lock_irq(&crtc->dev->event_lock);
> > +             spin_lock_irq(&ddev->event_lock);
> >               if (drm_crtc_vblank_get(crtc) =3D=3D 0)
> >                       drm_crtc_arm_vblank_event(crtc, event);
> >               else
> >                       drm_crtc_send_vblank_event(crtc, event);
> > -             spin_unlock_irq(&crtc->dev->event_lock);
> > +             spin_unlock_irq(&ddev->event_lock);
> >       }
> >   }
> >
> > @@ -663,15 +692,19 @@ bool ltdc_crtc_scanoutpos(struct drm_device *ddev=
, unsigned int pipe,
> >        * Computation for the two first cases are identical so we can
> >        * simplify the code and only test if line > vactive_end
> >        */
> > -     line =3D reg_read(ldev->regs, LTDC_CPSR) & CPSR_CYPOS;
> > -     vactive_start =3D reg_read(ldev->regs, LTDC_BPCR) & BPCR_AVBP;
> > -     vactive_end =3D reg_read(ldev->regs, LTDC_AWCR) & AWCR_AAH;
> > -     vtotal =3D reg_read(ldev->regs, LTDC_TWCR) & TWCR_TOTALH;
> > -
> > -     if (line > vactive_end)
> > -             *vpos =3D line - vtotal - vactive_start;
> > -     else
> > -             *vpos =3D line - vactive_start;
> > +     if (pm_runtime_active(ddev->dev)) {
> > +             line =3D reg_read(ldev->regs, LTDC_CPSR) & CPSR_CYPOS;
> > +             vactive_start =3D reg_read(ldev->regs, LTDC_BPCR) & BPCR_=
AVBP;
> > +             vactive_end =3D reg_read(ldev->regs, LTDC_AWCR) & AWCR_AA=
H;
> > +             vtotal =3D reg_read(ldev->regs, LTDC_TWCR) & TWCR_TOTALH;
> > +
> > +             if (line > vactive_end)
> > +                     *vpos =3D line - vtotal - vactive_start;
> > +             else
> > +                     *vpos =3D line - vactive_start;
> > +     } else {
> > +             *vpos =3D 0;
> > +     }
> >
> >       *hpos =3D 0;
> >
> > @@ -1243,8 +1276,11 @@ int ltdc_load(struct drm_device *ddev)
> >       /* Allow usage of vblank without having to call drm_irq_install *=
/
> >       ddev->irq_enabled =3D 1;
> >
> > -     return 0;
> > +     clk_disable_unprepare(ldev->pixel_clk);
> > +
> > +     pm_runtime_enable(ddev->dev);
> >
> > +     return 0;
> >   err:
> >       for (i =3D 0; i < MAX_ENDPOINTS; i++)
> >               drm_panel_bridge_remove(bridge[i]);
> > @@ -1256,7 +1292,6 @@ int ltdc_load(struct drm_device *ddev)
> >
> >   void ltdc_unload(struct drm_device *ddev)
> >   {
> > -     struct ltdc_device *ldev =3D ddev->dev_private;
> >       int i;
> >
> >       DRM_DEBUG_DRIVER("\n");
> > @@ -1264,7 +1299,7 @@ void ltdc_unload(struct drm_device *ddev)
> >       for (i =3D 0; i < MAX_ENDPOINTS; i++)
> >               drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
> >
> > -     clk_disable_unprepare(ldev->pixel_clk);
> > +     pm_runtime_disable(ddev->dev);
> >   }
> >
> >   MODULE_AUTHOR("Philippe Cornu <philippe.cornu@st.com>");
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
