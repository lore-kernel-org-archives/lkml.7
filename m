Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C07C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31BA20665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFUPxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:53:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57358 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFUPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:53:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id DBBF1270B16
Message-ID: <33068f355edfaabb1c60d5e16a219a058a489531.camel@collabora.com>
Subject: Re: [PATCH 2/3] drm/rockchip: Add optional support for CRTC gamma
 LUT
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Jun 2019 12:52:51 -0300
In-Reply-To: <CAD=FV=XoKNA4aW2LT7g8K2t+ABwgt=QJGAyiet1-Gyz3CgWmvg@mail.gmail.com>
References: <20190618213406.7667-1-ezequiel@collabora.com>
         <20190618213406.7667-3-ezequiel@collabora.com>
         <CAD=FV=XoKNA4aW2LT7g8K2t+ABwgt=QJGAyiet1-Gyz3CgWmvg@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 10:25 -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 18, 2019 at 2:43 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > +static void vop_crtc_gamma_set(struct vop *vop, struct drm_crtc *crtc,
> > +                              struct drm_crtc_state *old_state)
> > +{
> > +       int idle, ret, i;
> > +
> > +       spin_lock(&vop->reg_lock);
> > +       VOP_REG_SET(vop, common, dsp_lut_en, 0);
> > +       vop_cfg_done(vop);
> > +       spin_unlock(&vop->reg_lock);
> > +
> > +       ret = readx_poll_timeout(vop_dsp_lut_is_enable, vop,
> > +                          idle, !idle, 5, 30 * 1000);
> > +       if (ret)
> 
> Worth an error message?
> 

Sure.

> 
> > @@ -1205,6 +1294,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
> > 
> >  static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
> >         .mode_fixup = vop_crtc_mode_fixup,
> > +       .atomic_check = vop_crtc_atomic_check,
> 
> At first I was worried that there was a bug here since in the context
> of dw_hdmi (an encoder) adding ".atomic_check" caused ".mode_fixup" to
> stop getting called as per mode_fixup() in
> "drivers/gpu/drm/drm_atomic_helper.c".
> 
> ...but it seems like it's OK for CRTCs, so I think we're fine.
> 
> 
> > @@ -1323,6 +1413,7 @@ static const struct drm_crtc_funcs vop_crtc_funcs = {
> >         .disable_vblank = vop_crtc_disable_vblank,
> >         .set_crc_source = vop_crtc_set_crc_source,
> >         .verify_crc_source = vop_crtc_verify_crc_source,
> > +       .gamma_set = drm_atomic_helper_legacy_gamma_set,
> 
> Are there any issues in adding this ".gamma_set" property even though
> we may or may not actually have the ability to set the gamma
> (depending on whether or not the LUT register range was provided in
> the device tree)?  I am a DRM noob but
> drm_atomic_helper_legacy_gamma_set() is not a trivial little function
> and now we'll be running it in some cases where we don't actually have
> gamma.
> 
> I also notice that there's at least one bit of code that seems to
> check if ".gamma_set" is NULL.  ...and if it is, it'll return -ENOSYS
> right away.  Do we still properly return -ENOSYS on devices that don't
> have the register range?
> 
> It seems like the absolute safest would be to have two copies of this
> struct: one used for VOPs that have the range and one for VOPs that
> don't.
> 
> ...but possibly I'm just paranoid and as I've said I'm a clueless
> noob.  If someone says it's fine to always provide the .gamma_set
> property that's fine too.
> 

Provided we do the suggestion below (setting gamma_size and enabling
color management) when lut_regs is set, then I think we are fine.

Before this change:

* GAMMA_LUT property doesn't exist, and so can't be set.
* DRM_IOCTL_MODE_SETGAMMA (legacy) return ENOSYS.

After this change, on platforms that doesn't support this:

* GAMMA_LUT property doesn't exist, and so can't be set.
* DRM_IOCTL_MODE_SETGAMMA (legacy) return EINVAL.

The only difference is the ENOSYS/EINVAL errno, which I doubt
will regress anything.

I don't think this difference deserves assigning (the legacy)
.gamma_set hook conditionally, which would make the
implementation too ugly.

> 
> >  static void vop_fb_unref_worker(struct drm_flip_work *work, void *val)
> > @@ -1480,6 +1571,10 @@ static int vop_create_crtc(struct vop *vop)
> >                 goto err_cleanup_planes;
> > 
> >         drm_crtc_helper_add(crtc, &vop_crtc_helper_funcs);
> > +       if (vop_data->lut_size) {
> > +               drm_mode_crtc_set_gamma_size(crtc, vop_data->lut_size);
> > +               drm_crtc_enable_color_mgmt(crtc, 0, false, vop_data->lut_size);
> 
> Should we only do the above calls if we successfully mapped the resources?
> 

Yes, totally. See above.

> 
> > @@ -1776,6 +1871,17 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
> >         if (IS_ERR(vop->regs))
> >                 return PTR_ERR(vop->regs);
> > 
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lut");
> 
> As per comments in the bindings, shouldn't use the name "lut" but
> should just pick resource #1.

Yes.

Thanks a lot for the review,
Ezequiel

