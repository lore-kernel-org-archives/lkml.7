Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A86E2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfC2PHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:07:35 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50915 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfC2PHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:07:35 -0400
Received: from aptenodytes (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 15266240006;
        Fri, 29 Mar 2019 15:07:29 +0000 (UTC)
Message-ID: <fad474b817c822e7e716fddf53e8c8d467d85912.camel@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 29 Mar 2019 16:07:29 +0100
In-Reply-To: <20190328185307.GZ2665@phenom.ffwll.local>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
         <20190320154809.14823-2-paul.kocialkowski@bootlin.com>
         <87zhpph4c2.fsf@anholt.net>
         <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
         <20190328185307.GZ2665@phenom.ffwll.local>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 28 mars 2019 à 19:53 +0100, Daniel Vetter a écrit :
> On Thu, Mar 21, 2019 at 04:27:06PM +0100, Paul Kocialkowski wrote:
> > Hi,
> > 
> > Le mercredi 20 mars 2019 à 09:56 -0700, Eric Anholt a écrit :
> > > Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> > > 
> > > > The firstopen DRM driver hook was initially used to perform hardware
> > > > initialization, which is now considered legacy. Only a single user of
> > > > firstopen remains at this point (savage).
> > > > 
> > > > In some specific cases, non-legacy drivers may also need to implement
> > > > these hooks. For instance on VC4, we need to allocate a 16 MiB buffer
> > > > for the GPU. Because it's not required for fbcon, it's a waste to
> > > > allocate it before userspace starts using the DRM device.
> > > > 
> > > > Using firstopen and lastclose for this allocation seems like the best
> > > > fit, so re-habilitate the hook to allow it to be called for non-legacy
> > > > drivers.
> > > > 
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_file.c | 3 +--
> > > >  include/drm/drm_drv.h      | 2 +-
> > > >  2 files changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > > > index b1838a41ad43..c011b5cbfb6b 100644
> > > > --- a/drivers/gpu/drm/drm_file.c
> > > > +++ b/drivers/gpu/drm/drm_file.c
> > > > @@ -266,8 +266,7 @@ static int drm_setup(struct drm_device * dev)
> > > >  {
> > > >  	int ret;
> > > >  
> > > > -	if (dev->driver->firstopen &&
> > > > -	    drm_core_check_feature(dev, DRIVER_LEGACY)) {
> > > > +	if (dev->driver->firstopen) {
> > > >  		ret = dev->driver->firstopen(dev);
> > > >  		if (ret != 0)
> > > >  			return ret;
> > > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > > > index ca46a45a9cce..aa14607e54d4 100644
> > > > --- a/include/drm/drm_drv.h
> > > > +++ b/include/drm/drm_drv.h
> > > > @@ -236,7 +236,7 @@ struct drm_driver {
> > > >  	 * to set/unset the VT into raw mode.
> > > >  	 *
> > > >  	 * Legacy drivers initialize the hardware in the @firstopen callback,
> > > > -	 * which isn't even called for modern drivers.
> > > > +	 * modern drivers can use it for other purposes only.
> > > >  	 */
> > > >  	void (*lastclose) (struct drm_device *);
> > > 
> > > Our usage in vc4 is not very different from what we called "hardware
> > > initialization" in other devices.  I would rather just delete this
> > > sentence entirely.
> > 
> > Sounds good to me!
> > 
> > > The only alternative I can think of to using a firstopen/lastclose-style
> > > allocation for this would be to allocate the bin bo on the first
> > > (non-dumb?) V3D BO allocation and refcount those to free the binner.
> > 
> > I don't see other options either, and using firstclose/lastopen feels
> > overall more readable in the driver code.
> > 
> > I'm not sure there is such a big overhead associated with allocating
> > the binner BO (it seems that the current implementation tries to alloc
> > until the specific memory constraints for the buffer are met, so
> > perhaps that can take time). But if there is, I suppose it's best to
> > have that when starting up rather than delaying the first render
> > operation.
> 
> I'm not entirely buying the "we don't need this for fbcon only" argument -
> there's plenty of dumb kms clients too (boot splash and whatever else
> there might be). If you don't want to keep this around I think allocating
> on first non-dumb bo allocation and dropping it when the last such fd
> closes sounds like a much better idea. Needs a bit more state, you need to
> track per drm_file whether you've already allocated a non-dumb bo, and a
> drm_device refcount, but that's not much. Firstopen feels like the wrong
> thing.

This is quite a valid point, but we decided to go for a middle-ground
between always allocating and allocating at the first GPU op, so that
the operation is not significantly delayed by allocating the buffer.

> Another option would be first_renderopen or something like that, except
> you can also render on the legacy node and I'm not sure how much there's a
> demand for this in other drivers. In the end you have open/close
> callbacks, you can do all the driver specific things you want to do in
> there.

Yes I've initially tried playing with that and reached the same
conclusion: there can be render ops on the legacy node too so this is
just not reliable for what we're trying to do.

> Aside: I kinda also want to ditch lastclose usage. There's fbdev (we have a
> better solution with Noralf's drm_client for those) and runtime pm (which
> frankly is just a cheap hack, I want my gpu to susepend also when it's not
> in use when all the screens are off, not only when I killed X and
> everything).

I understand that, yes. I don't see any issue with a implementation
tracking the state in open if we really want firstopen/lastclose to
disappear.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

