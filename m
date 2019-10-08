Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C362206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="UBp5dI6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfJHUDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:03:41 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38953 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbfJHUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:03:41 -0400
Received: by mail-yw1-f66.google.com with SMTP id n11so6895877ywn.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4CE1BxrYmt8bIJQ4ee/mv7sHVSkIz9neBXcllQM3bao=;
        b=UBp5dI6/eg+7xME26slfmNl99bWpkkf6SBDDeSqgT2/f7har5/CI1SF6tqgtOrxW/t
         IfvCN+hBCTQpIZF9DJh97Rlw5ZdpCQYiK+XnRcq8i1tn1sU0XyS+FlUlIdNMdN59t0Ky
         ZOCA7LcugGMWfPlYJ0INKOVVaRHSYD9+FCnzHxJP3NYVDQU8TR4qGjPeNp8prA1VN1Lf
         9cMpkppFnDHSlEo6kJE1tox3bRFQ+SG3GhAzOXZTgqr+7zO4TrIftJc1wYsqcCFER43Z
         z6nvtZlJUwgYuFtC1Y6PDxHHJIPgb8qVdFLmjISYRBvmHX67DlZv7S01ESzvXnkAccEo
         Qoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4CE1BxrYmt8bIJQ4ee/mv7sHVSkIz9neBXcllQM3bao=;
        b=OjVcAuIYpQ0jNJibC3HmBZDgdUtfFfGIhS6KXn3yWTNIVzYVkrdoi8NWXNWmwirfb4
         ik0eA00HGPkZ0L20a7rRA8njdUATrFeO/b9mOlnd+WXkOShZWCNU6NHTRi11Y6CFM3qe
         yPtcvktTYJRt9dq9nlhtVYHi7wgTtyrUzCquDTQatyLg9rfVnaXvsqfpfjqY83yNab31
         UFKMgDPNi+XL1Ub5GUF4+NqKNgR1h67cv/w65F7e4P43b1K39ki2lob08PCnWfE6oE7R
         V6AzMAp3rIMvvZ3cWY3eXBH4X65aU8a2NWgLMBcaCeUDFiuO+cmv0muOraA/xscBcJry
         +3bQ==
X-Gm-Message-State: APjAAAUuO1B8NrTkYgsbZoLHHJtn/v7E893dRZtH/wYYg7VhOXVVjvhd
        3L+Jf0g6iAu02qP2i0CWLWMJaA==
X-Google-Smtp-Source: APXvYqx7YYibEGvaoohfIoxEc2sHRClCB8jQgphg6W4QPuB8xNYmRba4UMcQGm26BNKAAtz04sl2sA==
X-Received: by 2002:a81:4f0b:: with SMTP id d11mr71977ywb.109.1570565020219;
        Tue, 08 Oct 2019 13:03:40 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id u67sm7785ywf.44.2019.10.08.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 13:03:39 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:03:39 -0400
From:   Sean Paul <sean@poorly.run>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v3 3/5] drm/rockchip: Add optional support for CRTC gamma
 LUT
Message-ID: <20191008200339.GD85762@art_vandelay>
References: <20190930222802.32088-1-ezequiel@collabora.com>
 <20190930222802.32088-4-ezequiel@collabora.com>
 <20191007185432.GG126146@art_vandelay>
 <dad6ee9aa3699af0f794f467224a8a01798d86b2.camel@collabora.com>
 <9cdd23c20ed91d4c4654aaae27d8c3addfd9af3f.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdd23c20ed91d4c4654aaae27d8c3addfd9af3f.camel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:33:35PM -0300, Ezequiel Garcia wrote:
> On Tue, 2019-10-08 at 16:23 -0300, Ezequiel Garcia wrote:
> > Hello Sean,
> > 
> > On Mon, 2019-10-07 at 14:54 -0400, Sean Paul wrote:
> > > On Mon, Sep 30, 2019 at 07:28:00PM -0300, Ezequiel Garcia wrote:
> > > > Add an optional CRTC gamma LUT support, and enable it on RK3288.
> > > > This is currently enabled via a separate address resource,
> > > > which needs to be specified in the devicetree.
> > > > 
> > > > The address resource is required because on some SoCs, such as
> > > > RK3288, the LUT address is after the MMU address, and the latter
> > > > is supported by a different driver. This prevents the DRM driver
> > > > from requesting an entire register space.
> > > > 
> > > > The current implementation works for RGB 10-bit tables, as that
> > > > is what seems to work on RK3288.
> > > > 
> > > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > > Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > > > ---
> > > > Changes from v2:
> > > > * None.
> > > > 
> > > > Changes from v1:
> > > > * drop explicit linear LUT after finding a proper
> > > >   way to disable gamma correction.
> > > > * avoid setting gamma is the CRTC is not active.
> > > > * s/int/unsigned int as suggested by Jacopo.
> > > > * only enable color management and set gamma size
> > > >   if gamma LUT is supported, suggested by Doug.
> > > > * drop the reg-names usage, and instead just use indexed reg
> > > >   specifiers, suggested by Doug.
> > > > 
> > > > Changes from RFC:
> > > > * Request (an optional) address resource for the LUT.
> > > > * Drop support for RK3399, which doesn't seem to work
> > > >   out of the box and needs more research.
> > > > * Support pass-thru setting when GAMMA_LUT is NULL.
> > > > * Add a check for the gamma size, as suggested by Ilia.
> > > > * Move gamma setting to atomic_commit_tail, as pointed
> > > >   out by Jacopo/Laurent, is the correct way.
> > > > ---
> > > >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   3 +
> > > >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 114 ++++++++++++++++++++
> > > >  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   7 ++
> > > >  drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
> > > >  4 files changed, 126 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > > > index dba352ec0ee3..fd1d987698ab 100644
> > > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include "rockchip_drm_drv.h"
> > > >  #include "rockchip_drm_fb.h"
> > > >  #include "rockchip_drm_gem.h"
> > > > +#include "rockchip_drm_vop.h"
> > > >  
> > > >  static const struct drm_framebuffer_funcs rockchip_drm_fb_funcs = {
> > > >  	.destroy       = drm_gem_fb_destroy,
> > > > @@ -112,6 +113,8 @@ rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
> > > >  
> > > >  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> > > >  
> > > > +	rockchip_drm_vop_gamma_set(old_state);
> > > > +
> > > 
> > > Instead of duplicating the commit_tail helper, could you just implement
> > > .atomic_begin() and call this from there? I think the only hitch is if you
> > > need this to be completed before crtc->atomic_enable(), at which point you
> > > might need to call it from vop_crtc_atomic_enable() and then detect that in
> > > atomic_begin()
> > > 
> > 
> > I think moving this to .atomic_begin might be enough. Let me send a new
> > series and we can see how that goes.
> > 
> 
> Oh, before going forward, pleaste note that the first iteration
> of this patch (as noted in the changelog) was applying the gamma lut
> on .atomic_flush. However, Laurent and Jacopo pointed out that
> it might add some tearing to do so, and that's why it was moved
> to commit_tail.
> 
> I have to admit I'm not too sure about the difference between
> applying this gamma LUT on atomic_begin or atomic_flush,
> perhaps you can clarify that?

The only difference between what you have now and calling it in atomic_begin
is that as you have it now, it's set before crtc->atomic_enable() is called.
I think in order to address Ville's concerns on the other patch, you'll need
to set it the lut in .atomic_enable() anyways, so here's what I would suggest:

- Set the LUT in .atomic_enable() wherever it makes sense (you have it at the
  start now)
- Add an .atomic_begin() implementation and check state->color_mgmt_changed and
  state->active_changed. color_mgmt_changed && !active_changed, set the lut
- Remove patches 1 & 5

...I think :-)

Sean

> 
> Thanks!
> Ezequiel 
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
