Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F10EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E145D2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hCtwqh8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395012AbfHBO6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:58:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34448 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfHBO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:58:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so78494993otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VqhdFygE3Uzn8xPEkK74YFWisk+UdK32x0eqtCq0s5w=;
        b=hCtwqh8jNZsVPM4TvuflRpcw3YA1o+0V1VDv2yH7tLilK6D/unuA4Yku1Rx2XtRc66
         fe66xDIpyuAII7P0bvP6p/tzJedBoQ2+iFZtM+0I3tXAF4Pc4PfeKHbQP0Gox7390+Yv
         6Y1W4hA0JgZ6YxPJGiB+em4gypcEGaoxJL/e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VqhdFygE3Uzn8xPEkK74YFWisk+UdK32x0eqtCq0s5w=;
        b=tvshlKKSMmbyzp5GsgQps5h6V9xs8ViBv6ptRGswTd/tcqFI6EycQ6zArcxfV7sKVO
         1nd0WS+Srmm4b5aWnZhmF2FftgMfGyhTDOVmSj/DW4q/eKg8dTuMEkyIRpFqHyUNSfCj
         R5WCaaYo/MYpFrOvKoiKkNAqq9Zkzv4rLeLRO+avD30dFBymo8B0aCrjJoi1XlLO7RxD
         fyAQJ6yYHM70osoVIUaaik82qmrvj4rf+ZRIdUii6DtnQvUoKiLLE9dzMLbJme6mmHNc
         p5w9Xr9IfYsNerbLs0Rx3n/g0IghBnW26ZwL7nvRpn9Wx6fZd1b3wDiHQDGx+ycvxk3B
         4kBA==
X-Gm-Message-State: APjAAAW21dAU3fX6xmKeNzNppeUTIRlDKpX21iBQL+Uba2bsD5abBPdy
        RDAweqhWzm8LSH+ntmqfxThBfSr+HL35r0j8VVM=
X-Google-Smtp-Source: APXvYqydiWDNBDPaCC8JP0mPYTvqcfDRw32SHdUehN4j4J0xo9QUavCwFJWi8deJ8SvCpAiNSdyqWhcFpZco8emI9WI=
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr51212983otr.303.1564757922452;
 Fri, 02 Aug 2019 07:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190801104231.23938-1-Liviu.Dudau@arm.com> <20190802093908.7tt4navdtdnfvksf@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uF83+jbqqog9skkyqefAjzG0FbWtKQLKhBP0PqHj=aasg@mail.gmail.com> <20190802145047.wzaqhrlztxprizat@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190802145047.wzaqhrlztxprizat@e110455-lin.cambridge.arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 2 Aug 2019 16:58:30 +0200
Message-ID: <CAKMK7uEop41YkKt7OLgVLhDJ5ub5n0iXSjG2sCJpRq3X3RzJVw@mail.gmail.com>
Subject: Re: drm/komeda: Add support for generation of CRC data per frame.
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 4:50 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> On Fri, Aug 02, 2019 at 11:52:11AM +0200, Daniel Vetter wrote:
> > On Fri, Aug 2, 2019 at 11:39 AM Brian Starkey <Brian.Starkey@arm.com> w=
rote:
> > >
> > > Hi Liviu,
> > >
> > > On Thu, Aug 01, 2019 at 11:42:31AM +0100, Liviu Dudau wrote:
> > > > Komeda has support to generate per-frame CRC values in the DOU
> > > > backend subsystem. Implement necessary hooks to expose the CRC
> > > > "control" and "data" file over debugfs and program the DOUx_BS
> > > > accordingly.
> > > >
> > > > This patch makes use of PL1 (programmable line 1) interrupt to
> > > > know when the CRC generation has finished.
> > > >
> > > > Patch is also dependent on the series that adds dual-link support
> > > > for komeda: https://patchwork.freedesktop.org/series/62280/
> > > >
> > > > Cc: "james qian wang (Arm Technology China)" <james.qian.wang@arm.c=
om>
> > > > Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> > > > ---
> > > >  .../arm/display/komeda/d71/d71_component.c    |  2 +-
> > > >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 29 ++++++++-
> > > >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 61 +++++++++++++++=
+++-
> > > >  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  2 +
> > > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
> > > >  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
> > > >  6 files changed, 94 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c=
 b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > index 55a8cc94808a1..3c45468848ee4 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > @@ -1061,7 +1061,7 @@ static void d71_timing_ctrlr_update(struct ko=
meda_component *c,
> > > >       malidp_write32(reg, BS_PREFETCH_LINE, D71_DEFAULT_PREPRETCH_L=
INE);
> > > >
> > > >       /* configure bs control register */
> > > > -     value =3D BS_CTRL_EN | BS_CTRL_VM;
> > > > +     value =3D BS_CTRL_EN | BS_CTRL_VM | BS_CTRL_CRC;
> > > >       if (c->pipeline->dual_link) {
> > > >               malidp_write32(reg, BS_DRIFT_TO, hfront_porch + 16);
> > > >               value |=3D BS_CTRL_DL;
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > index d567ab7ed314e..05bfd9891c540 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > @@ -115,6 +115,8 @@ static u64 get_dou_event(struct d71_pipeline *d=
71_pipeline)
> > > >       raw_status =3D malidp_read32(reg, BLK_IRQ_RAW_STATUS);
> > > >       if (raw_status & DOU_IRQ_PL0)
> > > >               evts |=3D KOMEDA_EVENT_VSYNC;
> > > > +     if (raw_status & DOU_IRQ_PL1)
> > > > +             evts |=3D KOMEDA_EVENT_CRCDONE;
> > > >       if (raw_status & DOU_IRQ_UND)
> > > >               evts |=3D KOMEDA_EVENT_URUN;
> > > >
> > > > @@ -149,7 +151,7 @@ static u64 get_dou_event(struct d71_pipeline *d=
71_pipeline)
> > > >
> > > >  static u64 get_pipeline_event(struct d71_pipeline *d71_pipeline, u=
32 gcu_status)
> > > >  {
> > > > -     u32 evts =3D 0ULL;
> > > > +     u64 evts =3D 0ULL;
> > > >
> > > >       if (gcu_status & (GLB_IRQ_STATUS_LPU0 | GLB_IRQ_STATUS_LPU1))
> > > >               evts |=3D get_lpu_event(d71_pipeline);
> > > > @@ -163,6 +165,26 @@ static u64 get_pipeline_event(struct d71_pipel=
ine *d71_pipeline, u32 gcu_status)
> > > >       return evts;
> > > >  }
> > > >
> > > > +static void get_frame_crcs(struct d71_pipeline *d71_pipeline, u32 =
pipe,
> > > > +                        struct komeda_events *evts)
> > > > +{
> > > > +     if (evts->pipes[pipe] & KOMEDA_EVENT_CRCDONE) {
> > > > +             struct komeda_component *c;
> > > > +
> > > > +             c =3D komeda_pipeline_get_component(&d71_pipeline->ba=
se,
> > > > +                                               KOMEDA_COMPONENT_TI=
MING_CTRLR);
> > > > +             if (!c)
> > > > +                     return;
> > > > +
> > > > +             evts->crcs[pipe][0] =3D malidp_read32(c->reg, BS_CRC0=
_LOW);
> > > > +             evts->crcs[pipe][1] =3D malidp_read32(c->reg, BS_CRC0=
_HIGH);
> > > > +             if (d71_pipeline->base.dual_link) {
> > > > +                     evts->crcs[pipe][2] =3D malidp_read32(c->reg,=
 BS_CRC1_LOW);
> > > > +                     evts->crcs[pipe][3] =3D malidp_read32(c->reg,=
 BS_CRC1_HIGH);
> > > > +             }
> > > > +     }
> > > > +}
> > > > +
> > > >  static irqreturn_t
> > > >  d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evt=
s)
> > > >  {
> > > > @@ -195,6 +217,9 @@ d71_irq_handler(struct komeda_dev *mdev, struct=
 komeda_events *evts)
> > > >       if (gcu_status & GLB_IRQ_STATUS_PIPE1)
> > > >               evts->pipes[1] |=3D get_pipeline_event(d71->pipes[1],=
 gcu_status);
> > > >
> > > > +     get_frame_crcs(d71->pipes[0], 0, evts);
> > > > +     get_frame_crcs(d71->pipes[1], 1, evts);
> > > > +
> > > >       return gcu_status ? IRQ_HANDLED : IRQ_NONE;
> > > >  }
> > > >
> > > > @@ -202,7 +227,7 @@ d71_irq_handler(struct komeda_dev *mdev, struct=
 komeda_events *evts)
> > > >                                GCU_IRQ_MODE | GCU_IRQ_ERR)
> > > >  #define ENABLED_LPU_IRQS     (LPU_IRQ_IBSY | LPU_IRQ_ERR | LPU_IRQ=
_EOW)
> > > >  #define ENABLED_CU_IRQS              (CU_IRQ_OVR | CU_IRQ_ERR)
> > > > -#define ENABLED_DOU_IRQS     (DOU_IRQ_UND | DOU_IRQ_ERR)
> > > > +#define ENABLED_DOU_IRQS     (DOU_IRQ_UND | DOU_IRQ_ERR | DOU_IRQ_=
PL1)
> > > >
> > > >  static int d71_enable_irq(struct komeda_dev *mdev)
> > > >  {
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > index fa9a4593bb375..4b9f5d33e999d 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > @@ -207,10 +207,13 @@ void komeda_crtc_handle_event(struct komeda_c=
rtc   *kcrtc,
> > > >                       drm_crtc_send_vblank_event(crtc, event);
> > > >               } else {
> > > >                       DRM_WARN("CRTC[%d]: FLIP happen but no pendin=
g commit.\n",
> > > > -                              drm_crtc_index(&kcrtc->base));
> > > > +                              drm_crtc_index(crtc));
> > > >               }
> > > >               spin_unlock_irqrestore(&crtc->dev->event_lock, flags)=
;
> > > >       }
> > > > +
> > > > +     if ((kcrtc->crc_enabled) && (events & KOMEDA_EVENT_CRCDONE))
> > > > +             drm_crtc_add_crc_entry(crtc, false, 0, evts->crcs[kcr=
tc->master->id]);
> > > >  }
> > > >
> > > >  static void
> > > > @@ -487,6 +490,59 @@ static void komeda_crtc_vblank_disable(struct =
drm_crtc *crtc)
> > > >       mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, false);
> > > >  }
> > > >
> > > > +static const char * const komeda_pipe_crc_sources[] =3D {"auto"};
> > > > +
> > > > +static const char *const *komeda_crtc_get_crc_sources(struct drm_c=
rtc *crtc,
> > > > +                                                   size_t *count)
> > > > +{
> > > > +     *count =3D ARRAY_SIZE(komeda_pipe_crc_sources);
> > > > +     return komeda_pipe_crc_sources;
> > > > +}
> > > > +
> > > > +static int komeda_crtc_parse_crc_source(const char *source)
> > > > +{
> > > > +     if (!source)
> > > > +             return 0;
> > > > +     if (strcmp(source, "auto") =3D=3D 0)
> > > > +             return 1;
> > > > +
> > > > +     return -EINVAL;
> > > > +}
> > > > +
> > > > +static int komeda_crtc_verify_crc_source(struct drm_crtc *crtc,
> > > > +                                      const char *source_name,
> > > > +                                      size_t *values_count)
> > > > +{
> > > > +     struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
> > > > +     int source =3D komeda_crtc_parse_crc_source(source_name);
> > > > +
> > > > +     if (source < 0) {
> > > > +             DRM_DEBUG_DRIVER("Unknown or invalid CRC source for C=
RTC%d\n",
> > > > +                              drm_crtc_index(crtc));
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     *values_count =3D kcrtc->master->dual_link ? 4 : 2;
> > >
> > > Can CRC generation continue across a modeset? If so I think we could
> > > end up with a case where dual_link changes while CRC is active. Maybe
> > > we should just always return 4 values, but set the third and fourth
> > > values to 0 in the event handler, if dual-link isn't active.
> >
> > Modeset is allowed to destry the crc setup. Maybe not the smartest
> > decision (it prevents us from making sure the first frame is perfect),
> > but pretty deeply in-grained into tests by now. If we want to move
> > this I think first step would be to add new basic testcases to igt to
> > validate crc generation against modesets (maybe start with dpms
> > off/on, then suspend/resume, then full modesets). Really not sure
> > there's a need, and I've seen too many cases like this where crc
> > generation changes depending upon modeset (bpp, routing, ...) to
> > assume we can just make it work.
> >
> > I'd not bother and leave things as-is.
>
> Daniel, should I take this also as a Reviewed-by you?

Maybe ack, I have no idea how you're hw works and I didn't really look
at the code.
-Daniel

>
> Best regards,
> Liviu
>
> > -Daniel
> > >
> > > Cheers,
> > > -Brian
> > >
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int komeda_crtc_set_crc_source(struct drm_crtc *crtc, const=
 char *source)
> > > > +{
> > > > +     struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
> > > > +     int src =3D komeda_crtc_parse_crc_source(source);
> > > > +
> > > > +     if (src < 0) {
> > > > +             DRM_DEBUG_DRIVER("Unknown or invalid CRC source for C=
RTC%d\n",
> > > > +                              drm_crtc_index(crtc));
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     kcrtc->crc_enabled =3D src & 1;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
> > > >       .gamma_set              =3D drm_atomic_helper_legacy_gamma_se=
t,
> > > >       .destroy                =3D drm_crtc_cleanup,
> > > > @@ -497,6 +553,9 @@ static const struct drm_crtc_funcs komeda_crtc_=
funcs =3D {
> > > >       .atomic_destroy_state   =3D komeda_crtc_atomic_destroy_state,
> > > >       .enable_vblank          =3D komeda_crtc_vblank_enable,
> > > >       .disable_vblank         =3D komeda_crtc_vblank_disable,
> > > > +     .set_crc_source         =3D komeda_crtc_set_crc_source,
> > > > +     .verify_crc_source      =3D komeda_crtc_verify_crc_source,
> > > > +     .get_crc_sources        =3D komeda_crtc_get_crc_sources,
> > > >  };
> > > >
> > > >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_dev.h
> > > > index d1c86b6174c80..244227b945f63 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > > > @@ -20,6 +20,7 @@
> > > >  #define KOMEDA_EVENT_OVR             BIT_ULL(4)
> > > >  #define KOMEDA_EVENT_EOW             BIT_ULL(5)
> > > >  #define KOMEDA_EVENT_MODE            BIT_ULL(6)
> > > > +#define KOMEDA_EVENT_CRCDONE         BIT_ULL(7)
> > > >
> > > >  #define KOMEDA_ERR_TETO                      BIT_ULL(14)
> > > >  #define KOMEDA_ERR_TEMR                      BIT_ULL(15)
> > > > @@ -69,6 +70,7 @@ struct komeda_dev;
> > > >  struct komeda_events {
> > > >       u64 global;
> > > >       u64 pipes[KOMEDA_MAX_PIPELINES];
> > > > +     u32 crcs[KOMEDA_MAX_PIPELINES][KOMEDA_MAX_CRCS];
> > > >  };
> > > >
> > > >  /**
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > index 45c498e15e7ae..de7c93b2d0a11 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > @@ -84,6 +84,9 @@ struct komeda_crtc {
> > > >
> > > >       /** @disable_done: this flip_done is for tracing the disable =
*/
> > > >       struct completion *disable_done;
> > > > +
> > > > +     /** @crc_enabled: true if per-frame generation of CRC is enab=
led */
> > > > +     bool crc_enabled;
> > > >  };
> > > >
> > > >  /**
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > index a7a84e66549d6..dfe2482c6274b 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > @@ -16,6 +16,7 @@
> > > >  #define KOMEDA_PIPELINE_MAX_LAYERS   4
> > > >  #define KOMEDA_PIPELINE_MAX_SCALERS  2
> > > >  #define KOMEDA_COMPONENT_N_INPUTS    5
> > > > +#define KOMEDA_MAX_CRCS                      4
> > > >
> > > >  /* pipeline component IDs */
> > > >  enum {
> > > > --
> > > > 2.22.0
> > > >
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
