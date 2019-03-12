Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985A3206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UBN60xhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCLLE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:04:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33618 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfCLLE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:04:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id d12so1926859edp.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DO+BpYD1HiVHvDw8PFyEy3WyNntjkNlUp9cufIP9CE8=;
        b=UBN60xheZLGXdcEwKYd7AfH1LPNA4cXSgiEdcc/YEW5Aa4WQXCFsuaSFOBxEqOh24h
         xNCzDwux9UdLr9cLp6uVjkajkMRZbxKXqY5yNq17QXH0ILrB/npQpji2v54CWsfcO9ao
         omvxLWiPy6WJJ2TzR49ykqmGn5zn3JLDRE5Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DO+BpYD1HiVHvDw8PFyEy3WyNntjkNlUp9cufIP9CE8=;
        b=YM8McNIOMfb1gWolz5qAFkxO8uqNdGzwKSMxFvka/Z0jFgoVKxPXvORQcndjBrn6lu
         NxzcWHGVzKfMcVjNm504OUMQAT6lkCD13VGdcKCx3DjsbocsexYZT/kqH9zEpcPZxQ8t
         fZMB/2Lomi6UdkVx0ubvUHmIQEaoClCS6U01VX7IBiQalhGO2TT/NgoWl3+CC5HAHL8h
         zYC+ugOLiCwM54TU664GQmvtnQOoYIYXJVb5VthoSi+L+fCUJTdOjON8d1gnmuHUhP5M
         KFRLDOdSVt5U1x+FwdY1Xpgn7aFk0jSWHSZHKyfhe4rEvWGY4/kSr+BpDd5mLLMWwMLu
         O3Iw==
X-Gm-Message-State: APjAAAVfl0W7+y3IHTtEtTVzr3OB6KEv1jJuP+LBDREWQwAgJahsCgZX
        I3TbHjdImai9vwx12/t1iGoprg==
X-Google-Smtp-Source: APXvYqy+pzte6vBAu5XHlWTNNy4WrR29lu+XoZ7GRxem0CgH3XtdQniMzMmA4Wd9gCKFGkNPJGdDcA==
X-Received: by 2002:aa7:d987:: with SMTP id u7mr2885409eds.194.1552388696744;
        Tue, 12 Mar 2019 04:04:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 31sm5367324edr.7.2019.03.12.04.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:04:55 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:04:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com,
        andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 1/5] drm/rockchip: fix fb references in async update
Message-ID: <20190312110453.GB2665@phenom.ffwll.local>
Mail-Followup-To: Boris Brezillon <boris.brezillon@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com,
        andrey.grodzovsky@amd.com, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190312022204.2775-1-helen.koike@collabora.com>
 <20190312022204.2775-2-helen.koike@collabora.com>
 <20190312073438.05ad8173@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312073438.05ad8173@collabora.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 07:34:38AM +0100, Boris Brezillon wrote:
> On Mon, 11 Mar 2019 23:21:59 -0300
> Helen Koike <helen.koike@collabora.com> wrote:
> 
> > In the case of async update, modifications are done in place, i.e. in the
> > current plane state, so the new_state is prepared and the new_state is
> > cleanup up (instead of the old_state, diferrently on what happen in a
> 
>   ^ cleaned up				^ differently (but maybe
> "unlike what happens" is more appropriate here).
> 
> > normal sync update).
> > To cleanup the old_fb properly, it needs to be placed in the new_state
> > in the end of async_update, so cleanup call will unreference the old_fb
> > correctly.
> > 
> > Also, the previous code had a:
> > 
> > 	plane_state = plane->funcs->atomic_duplicate_state(plane);
> > 	...
> > 	swap(plane_state, plane->state);
> > 
> > 	if (plane->state->fb && plane->state->fb != new_state->fb) {
> > 	...
> > 	}
> > 
> > Which was wrong, as the fb were just assigned to be equal, so this if
> > statement nevers evaluates to true.
> > 
> > Another details is that the function drm_crtc_vblank_get() can only be
> > called when vop->is_enabled is true, otherwise it has no effect and
> > trows a WARN_ON().
> > 
> > Calling drm_atomic_set_fb_for_plane() (which get a referent of the new
> > fb and pus the old fb) is not required, as it is taken care by
> > drm_mode_cursor_universal() when calling
> > drm_atomic_helper_update_plane().
> > 
> > Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > 
> > ---
> > Hello,
> > 
> > I tested on the rockchip ficus v1.1 using igt plane_cursor_legacy and
> > kms_cursor_legacy and I didn't see any regressions.
> > 
> > Changes in v2: None
> > 
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 42 ++++++++++++---------
> >  1 file changed, 24 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index c7d4c6073ea5..a1ee8c156a7b 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -912,30 +912,31 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
> >  					  struct drm_plane_state *new_state)
> >  {
> >  	struct vop *vop = to_vop(plane->state->crtc);
> > -	struct drm_plane_state *plane_state;
> > +	struct drm_framebuffer *old_fb = plane->state->fb;
> >  
> > -	plane_state = plane->funcs->atomic_duplicate_state(plane);
> > -	plane_state->crtc_x = new_state->crtc_x;
> > -	plane_state->crtc_y = new_state->crtc_y;
> > -	plane_state->crtc_h = new_state->crtc_h;
> > -	plane_state->crtc_w = new_state->crtc_w;
> > -	plane_state->src_x = new_state->src_x;
> > -	plane_state->src_y = new_state->src_y;
> > -	plane_state->src_h = new_state->src_h;
> > -	plane_state->src_w = new_state->src_w;
> > -
> > -	if (plane_state->fb != new_state->fb)
> > -		drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
> > -
> > -	swap(plane_state, plane->state);
> > -
> > -	if (plane->state->fb && plane->state->fb != new_state->fb) {
> > +	/*
> > +	 * A scanout can still be occurring, so we can't drop the reference to
> > +	 * the old framebuffer. To solve this we get a reference to old_fb and
> > +	 * set a worker to release it later.
> 
> Hm, doesn't look like an async update to me if we have to wait for the
> next VBLANK to happen to get the new content on the screen. Maybe we
> should reject async updates when old_fb != new_fb in the rk
> ->async_check() hook. 

Scanning out garbage because the old buffer is unpinned too quickly is one
of the long-term "features" of async updates. At least for features.

It's another one of these things we need to fix. Which might become easier
if we switch to usual state switching, since then we can punt the
cleanup_plane phase to a worker.

Note that depending upon the gpu this might not just result in garbage but
hangs, usually when there's an iommu and the chip dies if it accesses an
unmapped page.

Probably something to fix later on in async framework.
-Daniel
> 
> > +	 */
> > +	if (vop->is_enabled &&
> > +	    plane->state->fb && plane->state->fb != new_state->fb) {
> >  		drm_framebuffer_get(plane->state->fb);
> >  		WARN_ON(drm_crtc_vblank_get(plane->state->crtc) != 0);
> >  		drm_flip_work_queue(&vop->fb_unref_work, plane->state->fb);
> >  		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
> >  	}
> 
> In any case, I think this should be called after
> vop_plane_atomic_update() to prevent the situation where the VBLANK
> event happens between this point and the following
> vop_plane_atomic_update() call.
> 
> >  
> > +	plane->state->crtc_x = new_state->crtc_x;
> > +	plane->state->crtc_y = new_state->crtc_y;
> > +	plane->state->crtc_h = new_state->crtc_h;
> > +	plane->state->crtc_w = new_state->crtc_w;
> > +	plane->state->src_x = new_state->src_x;
> > +	plane->state->src_y = new_state->src_y;
> > +	plane->state->src_h = new_state->src_h;
> > +	plane->state->src_w = new_state->src_w;
> > +	plane->state->fb = new_state->fb;
> 
> Any reason not to use swap() here and reference plane->state->fb
> instead of new_state->fb after this point?
> 
> > +
> >  	if (vop->is_enabled) {
> >  		rockchip_drm_psr_inhibit_get_state(new_state->state);
> >  		vop_plane_atomic_update(plane, plane->state);
> > @@ -945,7 +946,12 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
> >  		rockchip_drm_psr_inhibit_put_state(new_state->state);
> >  	}
> >  
> > -	plane->funcs->atomic_destroy_state(plane, plane_state);
> > +	/*
> > +	 * In async update we perform inplace modifications and release the
> > +	 * new_state. The following is required so we release the reference of
> > +	 * the old framebuffer.
> > +	 */
> > +	new_state->fb = old_fb;
> >  }
> >  
> >  static const struct drm_plane_helper_funcs plane_helper_funcs = {
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
