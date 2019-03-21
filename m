Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8034218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfCUP1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:27:11 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:35083 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:27:11 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7A66A1BF20D;
        Thu, 21 Mar 2019 15:27:07 +0000 (UTC)
Message-ID: <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 21 Mar 2019 16:27:06 +0100
In-Reply-To: <87zhpph4c2.fsf@anholt.net>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
         <20190320154809.14823-2-paul.kocialkowski@bootlin.com>
         <87zhpph4c2.fsf@anholt.net>
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

Le mercredi 20 mars 2019 à 09:56 -0700, Eric Anholt a écrit :
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > The firstopen DRM driver hook was initially used to perform hardware
> > initialization, which is now considered legacy. Only a single user of
> > firstopen remains at this point (savage).
> > 
> > In some specific cases, non-legacy drivers may also need to implement
> > these hooks. For instance on VC4, we need to allocate a 16 MiB buffer
> > for the GPU. Because it's not required for fbcon, it's a waste to
> > allocate it before userspace starts using the DRM device.
> > 
> > Using firstopen and lastclose for this allocation seems like the best
> > fit, so re-habilitate the hook to allow it to be called for non-legacy
> > drivers.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/drm_file.c | 3 +--
> >  include/drm/drm_drv.h      | 2 +-
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > index b1838a41ad43..c011b5cbfb6b 100644
> > --- a/drivers/gpu/drm/drm_file.c
> > +++ b/drivers/gpu/drm/drm_file.c
> > @@ -266,8 +266,7 @@ static int drm_setup(struct drm_device * dev)
> >  {
> >  	int ret;
> >  
> > -	if (dev->driver->firstopen &&
> > -	    drm_core_check_feature(dev, DRIVER_LEGACY)) {
> > +	if (dev->driver->firstopen) {
> >  		ret = dev->driver->firstopen(dev);
> >  		if (ret != 0)
> >  			return ret;
> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > index ca46a45a9cce..aa14607e54d4 100644
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -236,7 +236,7 @@ struct drm_driver {
> >  	 * to set/unset the VT into raw mode.
> >  	 *
> >  	 * Legacy drivers initialize the hardware in the @firstopen callback,
> > -	 * which isn't even called for modern drivers.
> > +	 * modern drivers can use it for other purposes only.
> >  	 */
> >  	void (*lastclose) (struct drm_device *);
> 
> Our usage in vc4 is not very different from what we called "hardware
> initialization" in other devices.  I would rather just delete this
> sentence entirely.

Sounds good to me!

> The only alternative I can think of to using a firstopen/lastclose-style
> allocation for this would be to allocate the bin bo on the first
> (non-dumb?) V3D BO allocation and refcount those to free the binner.

I don't see other options either, and using firstclose/lastopen feels
overall more readable in the driver code.

I'm not sure there is such a big overhead associated with allocating
the binner BO (it seems that the current implementation tries to alloc
until the specific memory constraints for the buffer are met, so
perhaps that can take time). But if there is, I suppose it's best to
have that when starting up rather than delaying the first render
operation.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

