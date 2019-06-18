Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C85CC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488892082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfFRWSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:18:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56562 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729982AbfFRWSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:18:15 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hdMQS-0003J3-UP; Wed, 19 Jun 2019 00:18:00 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] drm/rockchip: Add optional support for CRTC gamma LUT
Date:   Wed, 19 Jun 2019 00:18:00 +0200
Message-ID: <31857290.5uKucqQp3M@diego>
In-Reply-To: <20372cd5e56d67b8e896c2d94b3d0d136cc2886e.camel@collabora.com>
References: <20190618213406.7667-1-ezequiel@collabora.com> <CAKb7UvgvY0tJDV9A=4+8=iqraziyt8SGF-QrX=M8jz+R+5JC=A@mail.gmail.com> <20372cd5e56d67b8e896c2d94b3d0d136cc2886e.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 19. Juni 2019, 00:09:57 CEST schrieb Ezequiel Garcia:
> On Tue, 2019-06-18 at 17:47 -0400, Ilia Mirkin wrote:
> > On Tue, Jun 18, 2019 at 5:43 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > Add an optional CRTC gamma LUT support, and enable it on RK3288.
> > > This is currently enabled via a separate address resource,
> > > which needs to be specified in the devicetree.
> > > 
> > > The address resource is required because on some SoCs, such as
> > > RK3288, the LUT address is after the MMU address, and the latter
> > > is supported by a different driver. This prevents the DRM driver
> > > from requesting an entire register space.
> > > 
> > > The current implementation works for RGB 10-bit tables, as that
> > > is what seems to work on RK3288.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > ---
> > > Changes from RFC:
> > > * Request (an optional) address resource for the LUT.
> > > * Drop support for RK3399, which doesn't seem to work
> > >   out of the box and needs more research.
> > > * Support pass-thru setting when GAMMA_LUT is NULL.
> > > * Add a check for the gamma size, as suggested by Ilia.
> > > * Move gamma setting to atomic_commit_tail, as pointed
> > >   out by Jacopo/Laurent, is the correct way.
> > > ---
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > index 12ed5265a90b..5b6edbe2673f 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > +static void vop_crtc_gamma_set(struct vop *vop, struct drm_crtc *crtc,
> > > +                              struct drm_crtc_state *old_state)
> > > +{
> > > +       int idle, ret, i;
> > > +
> > > +       spin_lock(&vop->reg_lock);
> > > +       VOP_REG_SET(vop, common, dsp_lut_en, 0);
> > > +       vop_cfg_done(vop);
> > > +       spin_unlock(&vop->reg_lock);
> > > +
> > > +       ret = readx_poll_timeout(vop_dsp_lut_is_enable, vop,
> > > +                          idle, !idle, 5, 30 * 1000);
> > > +       if (ret)
> > > +               return;
> > > +
> > > +       spin_lock(&vop->reg_lock);
> > > +
> > > +       if (crtc->state->gamma_lut) {
> > > +               if (!old_state->gamma_lut || (crtc->state->gamma_lut->base.id !=
> > > +                                             old_state->gamma_lut->base.id))
> > > +                       vop_crtc_write_gamma_lut(vop, crtc);
> > > +       } else {
> > > +               for (i = 0; i < crtc->gamma_size; i++) {
> > > +                       u32 word;
> > > +
> > > +                       word = (i << 20) | (i << 10) | i;
> > > +                       writel(word, vop->lut_regs + i * 4);
> > > +               }
> > 
> > Note - I'm not in any way familiar with the hardware, so take with a
> > grain of salt --
> > 
> > Could you just leave dsp_lut_en turned off in this case?
> > 
> 
> That was the first thing I tried :-)
> 
> It seems dsp_lut_en is not to enable the CRTC gamma LUT stage,
> but to enable writing the gamma LUT to the internal RAM.

I guess that warants a code comment stating this, so we don't end
up with well-meant cleanup patches in the future :-) .


> 
> And the specs list no register to enable/disable the gamma LUT.
> 
> Thanks!
> Eze
> 
> 




