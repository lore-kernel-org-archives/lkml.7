Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12463C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F432173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MGo76k6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436643AbfHBOJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:09:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36281 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436610AbfHBOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:09:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so72523319edq.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhuCYjOAgunkYjz+QlONFENP4HYNbDmyCVNLWObuIlI=;
        b=MGo76k6gKSmW1ADZbTtUMDQr5VwmTyo/MH72jvlFhkQWgqxWroyu/ApKeVsTnbocrn
         yt0QLimX9M1h8KHElBL+G0gfyZR8TqTpXIQ8HO8CzEGoRbWBGIiEcR/bkrD0rbYnfGdT
         rjHWiyrCyttLuPVQrU8vj52s/9RwGzR9JIyrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xhuCYjOAgunkYjz+QlONFENP4HYNbDmyCVNLWObuIlI=;
        b=dPiphQzzCt+KJvGZ5Q28NT20ObnnjFGK/J0kR7B+/IHBU0uF1UBqFWPhVaWmLSlfBg
         sAHCiucD31s46v7d8+AaXzLlCpxGywjskvW5NEaVV9US3Wbrl1/exI/L2jzsDGS9ZIrw
         EWcsxjsGiuP3GR3S7IN+SXorRXUIBJeCg8bUOn7Sme4dyiwPcPfXp8cHiPcSmo82Xkd6
         WrX3NgoPIiHisg6//jjdjldpEDqZri9UNXNbsdl/maPm+k588tq+d8RSFDSxif2/w0ZQ
         fcbIcBJIl5HrfvpM/MZYauIHgpJlprMxQ/IwGWCdUOYgHl0It6XRue25GPSLEHuUAzGd
         1Gjg==
X-Gm-Message-State: APjAAAXoEStTJaxuu7Lz/V5A5fOVZf960/50vmBY9axVL7enGsOn1TzU
        Lp6+5AX4/2VZNOXinkJkMVo=
X-Google-Smtp-Source: APXvYqzaolmvMese/Nu4+FfdS0NaNgzFgrv/cB9pE/Xf9NoQ28479+wgA7MPoU+3voB4/2PJto65Gw==
X-Received: by 2002:aa7:c753:: with SMTP id c19mr119683899eds.81.1564754952824;
        Fri, 02 Aug 2019 07:09:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a1sm17537648edq.29.2019.08.02.07.09.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 07:09:12 -0700 (PDT)
Date:   Fri, 2 Aug 2019 16:09:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: drm/komeda: Add support for generation of CRC data per frame.
Message-ID: <20190802140910.GN7444@phenom.ffwll.local>
Mail-Followup-To: Brian Starkey <Brian.Starkey@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
References: <20190801104231.23938-1-Liviu.Dudau@arm.com>
 <20190802093908.7tt4navdtdnfvksf@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uF83+jbqqog9skkyqefAjzG0FbWtKQLKhBP0PqHj=aasg@mail.gmail.com>
 <20190802101303.s6vod63363nnbjgv@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802101303.s6vod63363nnbjgv@DESKTOP-E1NTVVP.localdomain>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:13:03AM +0000, Brian Starkey wrote:
> Hi Daniel,
> 
> On Fri, Aug 02, 2019 at 11:52:11AM +0200, Daniel Vetter wrote:
> > On Fri, Aug 2, 2019 at 11:39 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
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
> > > > Cc: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
> > > > Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> > > > ---
> > > >  .../arm/display/komeda/d71/d71_component.c    |  2 +-
> > > >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 29 ++++++++-
> > > >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 61 ++++++++++++++++++-
> > > >  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  2 +
> > > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
> > > >  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
> > > >  6 files changed, 94 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > index 55a8cc94808a1..3c45468848ee4 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > @@ -1061,7 +1061,7 @@ static void d71_timing_ctrlr_update(struct komeda_component *c,
> > > >       malidp_write32(reg, BS_PREFETCH_LINE, D71_DEFAULT_PREPRETCH_LINE);
> > > >
> > > >       /* configure bs control register */
> > > > -     value = BS_CTRL_EN | BS_CTRL_VM;
> > > > +     value = BS_CTRL_EN | BS_CTRL_VM | BS_CTRL_CRC;
> > > >       if (c->pipeline->dual_link) {
> > > >               malidp_write32(reg, BS_DRIFT_TO, hfront_porch + 16);
> > > >               value |= BS_CTRL_DL;
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > index d567ab7ed314e..05bfd9891c540 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > @@ -115,6 +115,8 @@ static u64 get_dou_event(struct d71_pipeline *d71_pipeline)
> > > >       raw_status = malidp_read32(reg, BLK_IRQ_RAW_STATUS);
> > > >       if (raw_status & DOU_IRQ_PL0)
> > > >               evts |= KOMEDA_EVENT_VSYNC;
> > > > +     if (raw_status & DOU_IRQ_PL1)
> > > > +             evts |= KOMEDA_EVENT_CRCDONE;
> > > >       if (raw_status & DOU_IRQ_UND)
> > > >               evts |= KOMEDA_EVENT_URUN;
> > > >
> > > > @@ -149,7 +151,7 @@ static u64 get_dou_event(struct d71_pipeline *d71_pipeline)
> > > >
> > > >  static u64 get_pipeline_event(struct d71_pipeline *d71_pipeline, u32 gcu_status)
> > > >  {
> > > > -     u32 evts = 0ULL;
> > > > +     u64 evts = 0ULL;
> > > >
> > > >       if (gcu_status & (GLB_IRQ_STATUS_LPU0 | GLB_IRQ_STATUS_LPU1))
> > > >               evts |= get_lpu_event(d71_pipeline);
> > > > @@ -163,6 +165,26 @@ static u64 get_pipeline_event(struct d71_pipeline *d71_pipeline, u32 gcu_status)
> > > >       return evts;
> > > >  }
> > > >
> > > > +static void get_frame_crcs(struct d71_pipeline *d71_pipeline, u32 pipe,
> > > > +                        struct komeda_events *evts)
> > > > +{
> > > > +     if (evts->pipes[pipe] & KOMEDA_EVENT_CRCDONE) {
> > > > +             struct komeda_component *c;
> > > > +
> > > > +             c = komeda_pipeline_get_component(&d71_pipeline->base,
> > > > +                                               KOMEDA_COMPONENT_TIMING_CTRLR);
> > > > +             if (!c)
> > > > +                     return;
> > > > +
> > > > +             evts->crcs[pipe][0] = malidp_read32(c->reg, BS_CRC0_LOW);
> > > > +             evts->crcs[pipe][1] = malidp_read32(c->reg, BS_CRC0_HIGH);
> > > > +             if (d71_pipeline->base.dual_link) {
> > > > +                     evts->crcs[pipe][2] = malidp_read32(c->reg, BS_CRC1_LOW);
> > > > +                     evts->crcs[pipe][3] = malidp_read32(c->reg, BS_CRC1_HIGH);
> > > > +             }
> > > > +     }
> > > > +}
> > > > +
> > > >  static irqreturn_t
> > > >  d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
> > > >  {
> > > > @@ -195,6 +217,9 @@ d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
> > > >       if (gcu_status & GLB_IRQ_STATUS_PIPE1)
> > > >               evts->pipes[1] |= get_pipeline_event(d71->pipes[1], gcu_status);
> > > >
> > > > +     get_frame_crcs(d71->pipes[0], 0, evts);
> > > > +     get_frame_crcs(d71->pipes[1], 1, evts);
> > > > +
> > > >       return gcu_status ? IRQ_HANDLED : IRQ_NONE;
> > > >  }
> > > >
> > > > @@ -202,7 +227,7 @@ d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
> > > >                                GCU_IRQ_MODE | GCU_IRQ_ERR)
> > > >  #define ENABLED_LPU_IRQS     (LPU_IRQ_IBSY | LPU_IRQ_ERR | LPU_IRQ_EOW)
> > > >  #define ENABLED_CU_IRQS              (CU_IRQ_OVR | CU_IRQ_ERR)
> > > > -#define ENABLED_DOU_IRQS     (DOU_IRQ_UND | DOU_IRQ_ERR)
> > > > +#define ENABLED_DOU_IRQS     (DOU_IRQ_UND | DOU_IRQ_ERR | DOU_IRQ_PL1)
> > > >
> > > >  static int d71_enable_irq(struct komeda_dev *mdev)
> > > >  {
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > index fa9a4593bb375..4b9f5d33e999d 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > @@ -207,10 +207,13 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
> > > >                       drm_crtc_send_vblank_event(crtc, event);
> > > >               } else {
> > > >                       DRM_WARN("CRTC[%d]: FLIP happen but no pending commit.\n",
> > > > -                              drm_crtc_index(&kcrtc->base));
> > > > +                              drm_crtc_index(crtc));
> > > >               }
> > > >               spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> > > >       }
> > > > +
> > > > +     if ((kcrtc->crc_enabled) && (events & KOMEDA_EVENT_CRCDONE))
> > > > +             drm_crtc_add_crc_entry(crtc, false, 0, evts->crcs[kcrtc->master->id]);
> > > >  }
> > > >
> > > >  static void
> > > > @@ -487,6 +490,59 @@ static void komeda_crtc_vblank_disable(struct drm_crtc *crtc)
> > > >       mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, false);
> > > >  }
> > > >
> > > > +static const char * const komeda_pipe_crc_sources[] = {"auto"};
> > > > +
> > > > +static const char *const *komeda_crtc_get_crc_sources(struct drm_crtc *crtc,
> > > > +                                                   size_t *count)
> > > > +{
> > > > +     *count = ARRAY_SIZE(komeda_pipe_crc_sources);
> > > > +     return komeda_pipe_crc_sources;
> > > > +}
> > > > +
> > > > +static int komeda_crtc_parse_crc_source(const char *source)
> > > > +{
> > > > +     if (!source)
> > > > +             return 0;
> > > > +     if (strcmp(source, "auto") == 0)
> > > > +             return 1;
> > > > +
> > > > +     return -EINVAL;
> > > > +}
> > > > +
> > > > +static int komeda_crtc_verify_crc_source(struct drm_crtc *crtc,
> > > > +                                      const char *source_name,
> > > > +                                      size_t *values_count)
> > > > +{
> > > > +     struct komeda_crtc *kcrtc = to_kcrtc(crtc);
> > > > +     int source = komeda_crtc_parse_crc_source(source_name);
> > > > +
> > > > +     if (source < 0) {
> > > > +             DRM_DEBUG_DRIVER("Unknown or invalid CRC source for CRTC%d\n",
> > > > +                              drm_crtc_index(crtc));
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     *values_count = kcrtc->master->dual_link ? 4 : 2;
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
> OK good, glad we're not alone. Do we need to do anything specific to
> stop/reconfigure generation over modeset, or we just rely on userspace
> to reconfigure?

Expectation is:
- userspace configures mode
- userspace selects crc source and enables it (this might internally do a
  full modeset to get the pipeline back into a shape were we can capture
  crcs - some of the low power modes in i915 bypass the crc block ...
  yay).

So nothing to do for you. I think the rough rule is that crc generation
should continue working as long as you don't do anything which requires an
ALLOW_MODESET commit.

Care to type a kerneldoc patch to clarify this, since I think current docs
are lacking?
-Daniel

> 
> Thanks,
> -Brian
> 
> > -Daniel
> > >
> > > Cheers,
> > > -Brian
> > >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
