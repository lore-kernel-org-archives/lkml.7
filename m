Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C1C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270FC20663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFZSuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:50:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38708 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:50:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7CBC5261179
Message-ID: <29e4c3538a5f19bdc663aa671ecb917d6160011e.camel@collabora.com>
Subject: Re: [PATCH v2 2/3] drm/rockchip: Add optional support for CRTC
 gamma LUT
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 26 Jun 2019 15:49:59 -0300
In-Reply-To: <20190625080526.osfzjb32pt6f5pxu@uno.localdomain>
References: <20190621211346.1324-1-ezequiel@collabora.com>
         <20190621211346.1324-3-ezequiel@collabora.com>
         <20190625080526.osfzjb32pt6f5pxu@uno.localdomain>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 10:05 +0200, Jacopo Mondi wrote:
> Hi Ezequiel,
> 
> On Fri, Jun 21, 2019 at 06:13:45PM -0300, Ezequiel Garcia wrote:
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
> > ---
> > Changes from v1:
> > * drop explicit linear LUT after finding a proper
> >   way to disable gamma correction.
> > * avoid setting gamma is the CRTC is not active.
> > * s/int/unsigned int as suggested by Jacopo.
> > * only enable color management and set gamma size
> >   if gamma LUT is supported, suggested by Doug.
> > * drop the reg-names usage, and instead just use indexed reg
> >   specifiers, suggested by Doug.
> > 
> > Changes from RFC:
> > * Request (an optional) address resource for the LUT.
> > * Drop support for RK3399, which doesn't seem to work
> >   out of the box and needs more research.
> > * Support pass-thru setting when GAMMA_LUT is NULL.
> > * Add a check for the gamma size, as suggested by Ilia.
> > * Move gamma setting to atomic_commit_tail, as pointed
> >   out by Jacopo/Laurent, is the correct way.
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   3 +
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 114 ++++++++++++++++++++
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   7 ++
> >  drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
> >  4 files changed, 126 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > index 1c69066b6894..bf9ad6240971 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > @@ -16,6 +16,7 @@
> >  #include "rockchip_drm_fb.h"
> >  #include "rockchip_drm_gem.h"
> >  #include "rockchip_drm_psr.h"
> > +#include "rockchip_drm_vop.h"
> > 
> >  static int rockchip_drm_fb_dirty(struct drm_framebuffer *fb,
> >  				 struct drm_file *file,
> > @@ -128,6 +129,8 @@ rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
> > 
> >  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> > 
> > +	rockchip_drm_vop_gamma_set(old_state);
> > +
> >  	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> > 
> >  	drm_atomic_helper_commit_planes(dev, old_state,
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index 12ed5265a90b..cfa70773a9bc 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -137,6 +137,7 @@ struct vop {
> > 
> >  	uint32_t *regsbak;
> >  	void __iomem *regs;
> > +	void __iomem *lut_regs;
> > 
> >  	/* physical map length of vop register */
> >  	uint32_t len;
> > @@ -1153,6 +1154,102 @@ static void vop_wait_for_irq_handler(struct vop *vop)
> >  	synchronize_irq(vop->irq);
> >  }
> > 
> > +static bool vop_dsp_lut_is_enable(struct vop *vop)
> > +{
> > +	return vop_read_reg(vop, 0, &vop->data->common->dsp_lut_en);
> > +}
> > +
> > +static void vop_crtc_write_gamma_lut(struct vop *vop, struct drm_crtc *crtc)
> > +{
> > +	struct drm_color_lut *lut = crtc->state->gamma_lut->data;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < crtc->gamma_size; i++) {
> > +		u32 word;
> > +
> > +		word = (drm_color_lut_extract(lut[i].red, 10) << 20) |
> > +		       (drm_color_lut_extract(lut[i].green, 10) << 10) |
> > +			drm_color_lut_extract(lut[i].blue, 10);
> > +		writel(word, vop->lut_regs + i * 4);
> > +	}
> > +}
> > +
> > +static void vop_crtc_gamma_set(struct vop *vop, struct drm_crtc *crtc,
> > +			       struct drm_crtc_state *old_state)
> > +{
> > +	unsigned int idle;
> > +	int ret;
> > +
> > +	/*
> > +	 * In order to write the LUT to the internal RAM memory,
> > +	 * we need to first make sure the dsp_lut_en bit is cleared.
> > +	 */

[1] 

> > +	spin_lock(&vop->reg_lock);
> > +	VOP_REG_SET(vop, common, dsp_lut_en, 0);
> > +	vop_cfg_done(vop);
> > +	spin_unlock(&vop->reg_lock);
> > +
> > +	/*
> > +	 * If the CRTC is not active, dsp_lut_en will not get cleared.
> 
> Did you mean "dsp_lut_en will not get enabled" ?
> 
> Beacuse I see dsp_lut_en being set to 0, and not activated if
> !crtc->state->active. Am I confused?
> 

This bit should be 0 when the CPU updates the LUT,
that's why the driver is clears it and then actually
waits on it to be cleared.

Maybe the comment [1] above are not clear enough?

> Apart from that:
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 

Thanks for reviewing!
Ezequiel

