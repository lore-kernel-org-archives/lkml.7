Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74FBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BFA2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDCIxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:53:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDCIxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:53:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1536D307D91F;
        Wed,  3 Apr 2019 08:53:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B70075D6B3;
        Wed,  3 Apr 2019 08:53:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C19B416E2C; Wed,  3 Apr 2019 10:53:41 +0200 (CEST)
Date:   Wed, 3 Apr 2019 10:53:41 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Message-ID: <20190403085341.2cxdgxqrjlwecx3n@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
 <CAKMK7uGWh02L9n4etQC3V-RX3aWovJLpadNFe08LdWXRNz2yuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGWh02L9n4etQC3V-RX3aWovJLpadNFe08LdWXRNz2yuw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 03 Apr 2019 08:53:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +struct cirrus_device {
> > +       struct drm_device              *dev;
> 
> Why not embed drm_device? It's the latest rage :-)

Sure, can do that.

> > +void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
> > +                       struct drm_plane_state *old_state)
> > +{
> > +       struct drm_plane_state *state = pipe->plane.state;
> > +       struct drm_crtc *crtc = &pipe->crtc;
> > +       struct drm_rect rect;
> > +
> > +       if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> > +               cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
> > +
> > +       if (crtc->state->event) {
> > +               spin_lock_irq(&crtc->dev->event_lock);
> > +               drm_crtc_send_vblank_event(crtc, crtc->state->event);
> > +               spin_unlock_irq(&crtc->dev->event_lock);
> > +               crtc->state->event = NULL;
> > +       }
> > +}

> > +static int cirrus_fb_dirty(struct drm_framebuffer *fb,
> > +                          struct drm_file *file_priv,
> > +                          unsigned int flags, unsigned int color,
> > +                          struct drm_clip_rect *clips,
> > +                          unsigned int num_clips)
> > +{
> > +       struct cirrus_device *cirrus = fb->dev->dev_private;
> > +
> > +       if (cirrus->pipe.plane.state->fb != fb)
> > +               return 0;
> > +
> > +       if (num_clips)
> > +               cirrus_fb_blit_clips(fb, clips, num_clips);
> > +       else
> > +               cirrus_fb_blit_fullscreen(fb);
> > +       return 0;
> > +}
> 
> Why not use the dirty helpers and implement dirty rect support in your
> main plane update function?

Dirty rect support is already there, see above.

So I can just remove cirrus_fb_dirty() and hook up
drm_atomic_helper_dirtyfb() instead.  Easy ;)

cheers,
  Gerd

