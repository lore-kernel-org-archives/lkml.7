Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FDE2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S4sVEQDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfC1SxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:53:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41574 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfC1SxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:53:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so18161512edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=thiDluXpspKuWjKbj4Wh+5FxWB3SDv5Mx7vLlgy57Y0=;
        b=S4sVEQDcSH6WKV0xaPfCYNXl95N62789XRdi9MN1ikH3KWwZQgWD8Q6PXX/ku10/0Q
         qm3DxPHIqreFdI26xdmobCeBZ4tyg8x7tdOvLQ0xCfi6Ee8sZLqDfxybzIOoJIitvsf7
         r7kePQZcN11lueRog476AMMWiWWw7nb3gjG40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=thiDluXpspKuWjKbj4Wh+5FxWB3SDv5Mx7vLlgy57Y0=;
        b=aSjwDFj4qkkmRhbho43NZi1HCECFyiPLbKAPfnPWWsH2gfXocZTUwdCthPE61Q38GW
         R6uyJBtRcwt+Sl3WzggbirRlGPxkkn2rAwEyvz1KwtTmN+wgfZF2qNJIy2fgg2JsCiI8
         XiiC0oroJnMNZUuGrrmCGD1aXwA6hUZY7lrtR9SA2Uy8iOyOsDXMV7FZi5g1P2ohOTu4
         2Z8WPLOCQm/tKdrEHfsqnFUpmeuupokyWdecVeoBhd/+aw506tUP5k22CLw8MxZXjp+g
         kXGoydwTAvmTTMeOjlC+iUdPWQdB29xfLmUB4gsy9QVpjek0Qk5r1eQ1PuTkbKjGOEXU
         Q6CQ==
X-Gm-Message-State: APjAAAUVu7HauMrmm+B7TDrMNUXqxJ96jxO/Lwh2MzFs4ADpCHTVGnEQ
        ek/UJ4HDfZTGBcUGQpRkk4GxsQ==
X-Google-Smtp-Source: APXvYqxhxfwLmIjrZ3hWh7qz55eBujrNb/RU6ozOcW8wqXYxe+lC9Q2woo1uk1P1MVshad6qy/odFA==
X-Received: by 2002:a50:aa31:: with SMTP id o46mr7123848edc.6.1553799190925;
        Thu, 28 Mar 2019 11:53:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k58sm8427837eda.56.2019.03.28.11.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:53:09 -0700 (PDT)
Date:   Thu, 28 Mar 2019 19:53:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
Message-ID: <20190328185307.GZ2665@phenom.ffwll.local>
Mail-Followup-To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
 <20190320154809.14823-2-paul.kocialkowski@bootlin.com>
 <87zhpph4c2.fsf@anholt.net>
 <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:27:06PM +0100, Paul Kocialkowski wrote:
> Hi,
> 
> Le mercredi 20 mars 2019 à 09:56 -0700, Eric Anholt a écrit :
> > Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> > 
> > > The firstopen DRM driver hook was initially used to perform hardware
> > > initialization, which is now considered legacy. Only a single user of
> > > firstopen remains at this point (savage).
> > > 
> > > In some specific cases, non-legacy drivers may also need to implement
> > > these hooks. For instance on VC4, we need to allocate a 16 MiB buffer
> > > for the GPU. Because it's not required for fbcon, it's a waste to
> > > allocate it before userspace starts using the DRM device.
> > > 
> > > Using firstopen and lastclose for this allocation seems like the best
> > > fit, so re-habilitate the hook to allow it to be called for non-legacy
> > > drivers.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/drm_file.c | 3 +--
> > >  include/drm/drm_drv.h      | 2 +-
> > >  2 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > > index b1838a41ad43..c011b5cbfb6b 100644
> > > --- a/drivers/gpu/drm/drm_file.c
> > > +++ b/drivers/gpu/drm/drm_file.c
> > > @@ -266,8 +266,7 @@ static int drm_setup(struct drm_device * dev)
> > >  {
> > >  	int ret;
> > >  
> > > -	if (dev->driver->firstopen &&
> > > -	    drm_core_check_feature(dev, DRIVER_LEGACY)) {
> > > +	if (dev->driver->firstopen) {
> > >  		ret = dev->driver->firstopen(dev);
> > >  		if (ret != 0)
> > >  			return ret;
> > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > > index ca46a45a9cce..aa14607e54d4 100644
> > > --- a/include/drm/drm_drv.h
> > > +++ b/include/drm/drm_drv.h
> > > @@ -236,7 +236,7 @@ struct drm_driver {
> > >  	 * to set/unset the VT into raw mode.
> > >  	 *
> > >  	 * Legacy drivers initialize the hardware in the @firstopen callback,
> > > -	 * which isn't even called for modern drivers.
> > > +	 * modern drivers can use it for other purposes only.
> > >  	 */
> > >  	void (*lastclose) (struct drm_device *);
> > 
> > Our usage in vc4 is not very different from what we called "hardware
> > initialization" in other devices.  I would rather just delete this
> > sentence entirely.
> 
> Sounds good to me!
> 
> > The only alternative I can think of to using a firstopen/lastclose-style
> > allocation for this would be to allocate the bin bo on the first
> > (non-dumb?) V3D BO allocation and refcount those to free the binner.
> 
> I don't see other options either, and using firstclose/lastopen feels
> overall more readable in the driver code.
> 
> I'm not sure there is such a big overhead associated with allocating
> the binner BO (it seems that the current implementation tries to alloc
> until the specific memory constraints for the buffer are met, so
> perhaps that can take time). But if there is, I suppose it's best to
> have that when starting up rather than delaying the first render
> operation.

I'm not entirely buying the "we don't need this for fbcon only" argument -
there's plenty of dumb kms clients too (boot splash and whatever else
there might be). If you don't want to keep this around I think allocating
on first non-dumb bo allocation and dropping it when the last such fd
closes sounds like a much better idea. Needs a bit more state, you need to
track per drm_file whether you've already allocated a non-dumb bo, and a
drm_device refcount, but that's not much. Firstopen feels like the wrong
thing.

Another option would be first_renderopen or something like that, except
you can also render on the legacy node and I'm not sure how much there's a
demand for this in other drivers. In the end you have open/close
callbacks, you can do all the driver specific things you want to do in
there.

Aside: I kinda also want to ditch lastclose usage. There's fbdev (we have a
better solution with Noralf's drm_client for those) and runtime pm (which
frankly is just a cheap hack, I want my gpu to susepend also when it's not
in use when all the screens are off, not only when I killed X and
everything).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
