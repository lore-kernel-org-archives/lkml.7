Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD66206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfDWMzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:55:53 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49291 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWMzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:55:53 -0400
X-Originating-IP: 90.88.147.33
Received: from aptenodytes (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 449A22000A;
        Tue, 23 Apr 2019 12:55:48 +0000 (UTC)
Message-ID: <e4c684bd2fc752cd74f96771f198ace42988c81b.camel@bootlin.com>
Subject: Re: [PATCH v5 4/4] drm/vc4: Allocate binner bo when starting to use
 the V3D
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>
Date:   Tue, 23 Apr 2019 14:55:48 +0200
In-Reply-To: <87tvez802s.fsf@anholt.net>
References: <20190415123908.28986-1-paul.kocialkowski@bootlin.com>
         <20190415123908.28986-5-paul.kocialkowski@bootlin.com>
         <87tvez802s.fsf@anholt.net>
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

On Mon, 2019-04-15 at 13:50 -0700, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > The binner bo is not required until the V3D is in use, so avoid
> > allocating it at probe and do it on the first non-dumb BO allocation.
> > Keep track of which clients are using the V3D and liberate the buffer
> > when there is none left (through a kref) and protect it with a mutex to
> > avoid race conditions.
> > 
> > The Out-Of-Memory (OOM) interrupt also gets some tweaking, to avoid
> > enabling it before having allocated a binner bo.
> 
> I love your solution to this!
> 
> > We also want to keep the BO alive during runtime suspend/resume to avoid
> > failing to allocate it at resume. This happens when the CMA pool is
> > full at that point and results in a hard crash.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_bo.c  | 30 ++++++++++++++++++++++
> >  drivers/gpu/drm/vc4/vc4_drv.c | 17 +++++++++++++
> >  drivers/gpu/drm/vc4/vc4_drv.h |  9 +++++++
> >  drivers/gpu/drm/vc4/vc4_irq.c |  6 +++--
> >  drivers/gpu/drm/vc4/vc4_v3d.c | 47 +++++++++++++++++++++++++----------
> >  5 files changed, 94 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> > index 88ebd681d7eb..5a5276cce9a2 100644
> > --- a/drivers/gpu/drm/vc4/vc4_bo.c
> > +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> > @@ -799,6 +799,28 @@ vc4_prime_import_sg_table(struct drm_device *dev,
> >  	return obj;
> >  }
> >  
> > +static int vc4_grab_bin_bo(struct drm_device *dev,
> > +			   struct drm_file *file_priv)
> > +{
> > +	struct vc4_file *vc4file = file_priv->driver_priv;
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> > +
> > +	if (!vc4->v3d)
> > +		return -ENODEV;
> > +
> > +	if (vc4file->bin_bo_kref)
> > +		return 0;
> > +
> > +	mutex_lock(&vc4->bin_bo_lock);
> > +	vc4file->bin_bo_kref = vc4_v3d_bin_bo_get(vc4);
> > +	mutex_unlock(&vc4->bin_bo_lock);
> 
> Interesting.  I think I would have stored a bool for whether he had the
> kref, instead of a pointer to vc4->bin_bo_kref.  Either way is fine with
> me, though.

Heh, I've changed it to a bool for v6 anyway, it makes the code look
more symetrical.

> > +
> > +	if (!vc4file->bin_bo_kref)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> > index d840b52b9805..b09f771384be 100644
> > --- a/drivers/gpu/drm/vc4/vc4_drv.c
> > +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> > @@ -126,10 +126,25 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
> >  	return 0;
> >  }
> >  
> > +static void vc4_close_bin_bo_release(struct kref *ref)
> > +{
> > +	struct vc4_dev *vc4 = container_of(ref, struct vc4_dev, bin_bo_kref);
> > +
> > +	return vc4_v3d_bin_bo_free(vc4);
> > +}
> 
> Could we have this be the function that vc4_v3d.c publishes instead of
> _free, and then we don't need two separate functions for the free path?

I've made get/put helpers for v6 that shall address this as well.

> >  static void vc4_close(struct drm_device *dev, struct drm_file *file)
> >  {
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> >  	struct vc4_file *vc4file = file->driver_priv;
> >  
> > +	mutex_lock(&vc4->bin_bo_lock);
> > +
> > +	if (vc4file->bin_bo_kref)
> > +		kref_put(vc4file->bin_bo_kref, vc4_close_bin_bo_release);
> > +
> > +	mutex_unlock(&vc4->bin_bo_lock);
> > +
> >  	vc4_perfmon_close_file(vc4file);
> >  	kfree(vc4file);
> >  }
> > @@ -313,6 +338,15 @@ int vc4_v3d_bin_bo_alloc(struct vc4_dev *vc4)
> >  	return ret;
> >  }
> >  
> > +void vc4_v3d_bin_bo_free(struct vc4_dev *vc4)
> > +{
> > +	if (!vc4->bin_bo)
> > +		return;
> > +
> > +	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
> > +	vc4->bin_bo = NULL;
> 
> Hmm.  I'm thinking:
> 
> We free the bin BO from the DRM fd close operation, but we could have
> jobs still being executed after the close if userspace didn't happen to
> wait on them before finishing (closing doesn't wait for execution to
> complete, and we couldn't reliably wait during close even if we wanted
> to).  I think to resolve that we need the vc4_exec_info to keep a ref on
> the bin BO as well (at least, if they had a binning component to their
> job).

Oh good catch! So since we assign binner slots to exec jobs when
getting a tile_binning_mode_config_packet, we need to make sure that's
kept alive as well.

Here is something more I noticed when reworking the code: there are
subsequent calls in the ioctl handlers that may fall after we got a
reference to the binner BO. So we need to make sure to put in the
failure path since the matching legit put won't happen if the ioctl
errored out.

Cheers,

Paul

> >  #ifdef CONFIG_PM
> >  static int vc4_v3d_runtime_suspend(struct device *dev)
> >  {
> > @@ -321,9 +355,6 @@ static int vc4_v3d_runtime_suspend(struct device *dev)
> >  
> >  	vc4_irq_uninstall(vc4->dev);
> >  
> > -	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
> > -	vc4->bin_bo = NULL;
> > -
> >  	clk_disable_unprepare(v3d->clk);
> >  
> >  	return 0;
> > @@ -335,10 +366,6 @@ static int vc4_v3d_runtime_resume(struct device *dev)
> >  	struct vc4_dev *vc4 = v3d->vc4;
> >  	int ret;
> >  
> > -	ret = vc4_v3d_bin_bo_alloc(vc4);
> > -	if (ret)
> > -		return ret;
> > -
> >  	ret = clk_prepare_enable(v3d->clk);
> >  	if (ret != 0)
> >  		return ret;
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

