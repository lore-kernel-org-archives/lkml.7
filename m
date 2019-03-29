Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940192082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfC2IiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:38:25 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41839 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfC2IiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:38:24 -0400
Received: from aptenodytes (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 32CA724000F;
        Fri, 29 Mar 2019 08:38:19 +0000 (UTC)
Message-ID: <95645eb463840faf32bae284c16af443cc62f8a8.camel@bootlin.com>
Subject: Re: [PATCH v3 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eric Anholt <eric@anholt.net>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 29 Mar 2019 09:38:19 +0100
In-Reply-To: <20190329083534.GC2665@phenom.ffwll.local>
References: <20190328161306.22757-1-paul.kocialkowski@bootlin.com>
         <20190328161306.22757-2-paul.kocialkowski@bootlin.com>
         <20190329083534.GC2665@phenom.ffwll.local>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, 2019-03-29 at 09:35 +0100, Daniel Vetter wrote:
> On Thu, Mar 28, 2019 at 05:13:05PM +0100, Paul Kocialkowski wrote:
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
> > Reviewed-by: Eric Anholt <eric@anholt.net>
> > ---
> >  drivers/gpu/drm/drm_file.c | 3 +--
> >  include/drm/drm_drv.h      | 3 ---
> >  2 files changed, 1 insertion(+), 5 deletions(-)
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
> 
> If you guys insist on this (still not a fan myself) pls pull it out of
> drm_setup - that's all just legacy hw setup in there. I still think
> tracking this a bit more accurately (if you want to bother with this)
> would be better.

I sent out this v3 right before receiving your comments on v2, so this
new iteration only takes Eric's comments into account.

I think the points you made on v2 are very legitimate and I'll be
working to prepare a new series that takes them into consideration :)

Cheers,

Paul

> -Daniel
> 
> >  		ret = dev->driver->firstopen(dev);
> >  		if (ret != 0)
> >  			return ret;
> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > index ca46a45a9cce..de5637494503 100644
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -234,9 +234,6 @@ struct drm_driver {
> >  	 * kernel driver does not really own the hardware. Instead ownershipe is
> >  	 * handled with the help of userspace through an inheritedly racy dance
> >  	 * to set/unset the VT into raw mode.
> > -	 *
> > -	 * Legacy drivers initialize the hardware in the @firstopen callback,
> > -	 * which isn't even called for modern drivers.
> >  	 */
> >  	void (*lastclose) (struct drm_device *);
> >  
> > -- 
> > 2.21.0
> > 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

