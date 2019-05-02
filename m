Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F573C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A32E2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEBMCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:02:09 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52503 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfEBMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:02:09 -0400
Received: from aptenodytes (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 88FBD10000E;
        Thu,  2 May 2019 12:02:06 +0000 (UTC)
Message-ID: <5d8dadb34c9f845e21349253ff21c036c417f37a.camel@bootlin.com>
Subject: Re: [PATCH v7 4/4] drm/vc4: Allocate binner bo when starting to use
 the V3D
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>
Date:   Thu, 02 May 2019 14:02:05 +0200
In-Reply-To: <87tvemj80z.fsf@anholt.net>
References: <20190425122917.26536-1-paul.kocialkowski@bootlin.com>
         <20190425122917.26536-5-paul.kocialkowski@bootlin.com>
         <87tvemj80z.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-04-25 at 10:42 -0700, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > The binner BO is not required until the V3D is in use, so avoid
> > allocating it at probe and do it on the first non-dumb BO allocation.
> > 
> > Keep track of which clients are using the V3D and liberate the buffer
> > when there is none left, using a kref. Protect the logic with a
> > mutex to avoid race conditions.
> > 
> > The binner BO is created at the time of the first render ioctl and is
> > destroyed when there is no client and no exec job using it left.
> > 
> > The Out-Of-Memory (OOM) interrupt also gets some tweaking, to avoid
> > enabling it before having allocated a binner bo.
> > 
> > We also want to keep the BO alive during runtime suspend/resume to avoid
> > failing to allocate it at resume. This happens when the CMA pool is
> > full at that point and results in a hard crash.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_bo.c  | 33 +++++++++++++++++++-
> >  drivers/gpu/drm/vc4/vc4_drv.c |  6 ++++
> >  drivers/gpu/drm/vc4/vc4_drv.h | 14 +++++++++
> >  drivers/gpu/drm/vc4/vc4_gem.c | 13 ++++++++
> >  drivers/gpu/drm/vc4/vc4_irq.c | 21 +++++++++----
> >  drivers/gpu/drm/vc4/vc4_v3d.c | 58 +++++++++++++++++++++++++++--------
> >  6 files changed, 125 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> > index 88ebd681d7eb..2b3ec5926fe2 100644
> > --- a/drivers/gpu/drm/vc4/vc4_bo.c
> > +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> > @@ -799,13 +799,38 @@ vc4_prime_import_sg_table(struct drm_device *dev,
> >  	return obj;
> >  }
> >  
> > +static int vc4_grab_bin_bo(struct vc4_dev *vc4, struct vc4_file *vc4file)
> > +{
> > +	int ret;
> > +
> > +	if (!vc4->v3d)
> > +		return -ENODEV;
> > +
> > +	if (vc4file->bin_bo_used)
> > +		return 0;
> > +
> > +	ret = vc4_v3d_bin_bo_get(vc4);
> > +	if (ret)
> > +		return ret;
> > +
> > +	vc4file->bin_bo_used = true;
> 
> I think I found one last race.  Multiple threads could be in an ioctl
> trying to grab the bin BO at the same time (while this is only during
> app startup, since the fd only needs to get the ref once, it's
> particularly plausible given that allocating the bin BO is slow).  I
> think if you replace this line with:
> 
> 	mutex_lock(&vc4->bin_bo_lock);
>         if (vc4file->bin_bo_used) {
>         	mutex_unlock(&vc4->bin_bo_lock);
>                 vc4_v3d_bin_bo_put(vc4);
>         } else {
>         	vc4file->bin_bo_used = true;
>         	mutex_unlock(&vc4->bin_bo_lock);
>         }

Huh, very good catch once again, thanks! It took me some time to grasp
this one, but as far as I understand, the risk is that we could ref our
bin bo twice (although it would only be allocated once) since
bin_bo_used is not protected.

I'd like to suggest another solution, which would avoid re-locking and
doing an extra put if we got an extra ref: adding a "bool *used"
argument to vc4_v3d_bin_bo_get and, which only gets dereferenced with
the bin_bo lock held. Then we can skip obtaining a new reference if
(used && *used) in vc4_v3d_bin_bo_get.

So we could pass a pointer to vc4file->bin_bo_used for vc4_grab_bin_bo
and exec->bin_bo_used for the exec case (where there is no such issue
since we'll only ever try to _get the bin bo once there anyway).

What do you think?

Cheers,

Paul

> that will be the last change we need.  If you agree with this, feel free
> to squash it in and apply the series with:
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>
> 
> > +
> > +	return 0;
> > +}
> > +
> >  int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
> >  			struct drm_file *file_priv)
> >  {
> >  	struct drm_vc4_create_bo *args = data;
> > +	struct vc4_file *vc4file = file_priv->driver_priv;
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> >  	struct vc4_bo *bo = NULL;
> >  	int ret;
> >  
> > +	ret = vc4_grab_bin_bo(vc4, vc4file);
> > +	if (ret)
> > +		return ret;
> > +
> >  	/*
> >  	 * We can't allocate from the BO cache, because the BOs don't
> >  	 * get zeroed, and that might leak data between users.
> > @@ -846,6 +871,8 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
> >  			   struct drm_file *file_priv)
> >  {
> >  	struct drm_vc4_create_shader_bo *args = data;
> > +	struct vc4_file *vc4file = file_priv->driver_priv;
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> >  	struct vc4_bo *bo = NULL;
> >  	int ret;
> >  
> > @@ -865,6 +892,10 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
> >  		return -EINVAL;
> >  	}
> >  
> > +	ret = vc4_grab_bin_bo(vc4, vc4file);
> > +	if (ret)
> > +		return ret;
> > +
> >  	bo = vc4_bo_create(dev, args->size, true, VC4_BO_TYPE_V3D_SHADER);
> >  	if (IS_ERR(bo))
> >  		return PTR_ERR(bo);
> > @@ -894,7 +925,7 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
> >  	 */
> >  	ret = drm_gem_handle_create(file_priv, &bo->base.base, &args->handle);
> >  
> > - fail:
> > +fail:
> >  	drm_gem_object_put_unlocked(&bo->base.base);
> >  
> >  	return ret;
> 
> Extraneous whitespace change?
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

