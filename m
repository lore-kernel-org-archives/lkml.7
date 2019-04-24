Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD7FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF672089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfDXNoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:44:08 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57799 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfDXNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:44:07 -0400
X-Originating-IP: 90.88.147.33
Received: from aptenodytes (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AE536240017;
        Wed, 24 Apr 2019 13:44:02 +0000 (UTC)
Message-ID: <9aba66fdd46daa78f0557c1d2019e30c05be706a.camel@bootlin.com>
Subject: Re: [PATCH v6 4/4] drm/vc4: Allocate binner bo when starting to use
 the V3D
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Wed, 24 Apr 2019 15:44:02 +0200
In-Reply-To: <87pnpcpr5r.fsf@anholt.net>
References: <20190423144028.30036-1-paul.kocialkowski@bootlin.com>
         <20190423144028.30036-5-paul.kocialkowski@bootlin.com>
         <87pnpcpr5r.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, 2019-04-23 at 10:28 -0700, Eric Anholt wrote:
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
> >  drivers/gpu/drm/vc4/vc4_bo.c  | 45 +++++++++++++++++++++++++--
> >  drivers/gpu/drm/vc4/vc4_drv.c |  6 ++++
> >  drivers/gpu/drm/vc4/vc4_drv.h | 14 +++++++++
> >  drivers/gpu/drm/vc4/vc4_gem.c | 13 ++++++++
> >  drivers/gpu/drm/vc4/vc4_irq.c | 21 +++++++++----
> >  drivers/gpu/drm/vc4/vc4_v3d.c | 58 +++++++++++++++++++++++++++--------
> >  6 files changed, 135 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> > index 88ebd681d7eb..03a26de620de 100644
> > --- a/drivers/gpu/drm/vc4/vc4_bo.c
> > +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> > @@ -799,20 +799,47 @@ vc4_prime_import_sg_table(struct drm_device *dev,
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
> 
> Interesting note -- we'll now throw -ENODEV from this ioctl when v3d
> isn't present.  I think that's actually totally fine and maybe I should
> have done that for the !v3d patches originally.

By the way, if you'd like me to try and improve the return codes around
our ioctl handlers specifically, I'm definitely up for that.

> >  	/*
> >  	 * We can't allocate from the BO cache, because the BOs don't
> >  	 * get zeroed, and that might leak data between users.
> >  	 */
> >  	bo = vc4_bo_create(dev, args->size, false, VC4_BO_TYPE_V3D);
> > -	if (IS_ERR(bo))
> > +	if (IS_ERR(bo)) {
> > +		vc4_v3d_bin_bo_put(vc4);
> >  		return PTR_ERR(bo);
> > +	}
> 
> I actually don't think you want the bin_bo_put()s in the error paths
> here -- vc4_grab_bin_bo has put a flag in vc4file that we need a
> bin_bo_put() when the file is closed, and if we take these error paths
> there will be a refcount underflow once the file gets closed.

Oh yes you're right, I lost sight of the fact that we only ref once for
the whole file in the ioctl handlers. That's not the case with the exec
job though, but the calls are already balanced there for the error
paths as far as I could see.

> >  	bo->madv = VC4_MADV_WILLNEED;
> >  
> > @@ -846,6 +873,8 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
> >  			   struct drm_file *file_priv)
> >  {
> >  	struct drm_vc4_create_shader_bo *args = data;
> > +	struct vc4_file *vc4file = file_priv->driver_priv;
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> >  	struct vc4_bo *bo = NULL;
> >  	int ret;
> >  
> > @@ -865,9 +894,15 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
> >  		return -EINVAL;
> >  	}
> >  
> > +	ret = vc4_grab_bin_bo(vc4, vc4file);
> > +	if (ret)
> > +		return ret;
> > +
> >  	bo = vc4_bo_create(dev, args->size, true, VC4_BO_TYPE_V3D_SHADER);
> > -	if (IS_ERR(bo))
> > +	if (IS_ERR(bo)) {
> > +		vc4_v3d_bin_bo_put(vc4);
> >  		return PTR_ERR(bo);
> > +	}
> >  
> >  	bo->madv = VC4_MADV_WILLNEED;
> >  
> > @@ -893,8 +928,12 @@ vc4_create_shader_bo_ioctl(struct drm_device *dev, void *data,
> >  	 * races for users to do doing things like mmap the shader BO.
> >  	 */
> >  	ret = drm_gem_handle_create(file_priv, &bo->base.base, &args->handle);
> > +	goto complete;
> > +
> > +fail:
> > +	vc4_v3d_bin_bo_put(vc4);
> >  
> > - fail:
> > +complete:
> >  	drm_gem_object_put_unlocked(&bo->base.base);
> >  
> >  	return ret;
> > diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> > index 6d9be20a32be..0f99ad03614e 100644
> > --- a/drivers/gpu/drm/vc4/vc4_drv.c
> > +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> > @@ -128,8 +128,12 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
> >  
> >  static void vc4_close(struct drm_device *dev, struct drm_file *file)
> >  {
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> >  	struct vc4_file *vc4file = file->driver_priv;
> >  
> > +	if (vc4file->bin_bo_used)
> > +		vc4_v3d_bin_bo_put(vc4);
> > +
> >  	vc4_perfmon_close_file(vc4file);
> >  	kfree(vc4file);
> >  }
> > @@ -274,6 +278,8 @@ static int vc4_drm_bind(struct device *dev)
> >  	drm->dev_private = vc4;
> >  	INIT_LIST_HEAD(&vc4->debugfs_list);
> >  
> > +	mutex_init(&vc4->bin_bo_lock);
> > +
> >  	ret = vc4_bo_cache_init(drm);
> >  	if (ret)
> >  		goto dev_put;
> > diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> > index 4f13f6262491..5bfca83deb8e 100644
> > --- a/drivers/gpu/drm/vc4/vc4_drv.h
> > +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> > @@ -216,6 +216,11 @@ struct vc4_dev {
> >  	 * the minor is available (after drm_dev_register()).
> >  	 */
> >  	struct list_head debugfs_list;
> > +
> > +	/* Mutex for binner bo allocation. */
> > +	struct mutex bin_bo_lock;
> > +	/* Reference count for our binner bo. */
> > +	struct kref bin_bo_kref;
> >  };
> >  
> >  static inline struct vc4_dev *
> > @@ -584,6 +589,11 @@ struct vc4_exec_info {
> >  	 * NULL otherwise.
> >  	 */
> >  	struct vc4_perfmon *perfmon;
> > +
> > +	/* Whether the exec has taken a reference to the binner BO, which should
> > +	 * happen with a VC4_PACKET_TILE_BINNING_MODE_CONFIG packet.
> > +	 */
> > +	bool bin_bo_used;
> >  };
> >  
> >  /* Per-open file private data. Any driver-specific resource that has to be
> > @@ -594,6 +604,8 @@ struct vc4_file {
> >  		struct idr idr;
> >  		struct mutex lock;
> >  	} perfmon;
> > +
> > +	bool bin_bo_used;
> >  };
> > diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> > index 723dc86b4511..e226c24e543f 100644
> > --- a/drivers/gpu/drm/vc4/vc4_irq.c
> > +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> > @@ -59,18 +59,22 @@ vc4_overflow_mem_work(struct work_struct *work)
> >  {
> >  	struct vc4_dev *vc4 =
> >  		container_of(work, struct vc4_dev, overflow_mem_work);
> > -	struct vc4_bo *bo = vc4->bin_bo;
> > +	struct vc4_bo *bo;
> >  	int bin_bo_slot;
> >  	struct vc4_exec_info *exec;
> >  	unsigned long irqflags;
> >  
> > -	if (!bo)
> > -		return;
> > +	mutex_lock(&vc4->bin_bo_lock);
> > +
> > +	if (!vc4->bin_bo)
> > +		goto complete;
> > +
> > +	bo = vc4->bin_bo;
> >  
> >  	bin_bo_slot = vc4_v3d_get_bin_slot(vc4);
> >  	if (bin_bo_slot < 0) {
> >  		DRM_ERROR("Couldn't allocate binner overflow mem\n");
> > -		return;
> > +		goto complete;
> >  	}
> >  
> >  	spin_lock_irqsave(&vc4->job_lock, irqflags);
> > @@ -101,6 +105,9 @@ vc4_overflow_mem_work(struct work_struct *work)
> >  	V3D_WRITE(V3D_INTCTL, V3D_INT_OUTOMEM);
> >  	V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
> >  	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> > +
> > +complete:
> > +	mutex_unlock(&vc4->bin_bo_lock);
> >  }
> >  
> >  static void
> > @@ -252,8 +259,10 @@ vc4_irq_postinstall(struct drm_device *dev)
> >  	if (!vc4->v3d)
> >  		return 0;
> >  
> > -	/* Enable both the render done and out of memory interrupts. */
> > -	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
> > +	/* Enable the render done interrupts. The out-of-memory interrupt is
> > +	 * enabled as soon as we have a binner BO allocated.
> > +	 */
> > +	V3D_WRITE(V3D_INTENA, V3D_INT_FLDONE | V3D_INT_FRDONE);
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> > index c16db4665af6..55abaae71856 100644
> > --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> > +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> > @@ -294,6 +294,14 @@ static int bin_bo_alloc(struct vc4_dev *vc4)
> >  			WARN_ON_ONCE(sizeof(vc4->bin_alloc_used) * 8 !=
> >  				     bo->base.base.size / vc4->bin_alloc_size);
> >  
> > +			kref_init(&vc4->bin_bo_kref);
> > +
> > +			/* Enable the out-of-memory interrupt to set our
> > +			 * newly-allocated binner BO, potentially from an
> > +			 * already-pending-but-masked interupt.
> > +			 */
> > +			V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
> > +
> >  			break;
> >  		}
> >  
> > @@ -313,6 +321,43 @@ static int bin_bo_alloc(struct vc4_dev *vc4)
> >  	return ret;
> >  }
> >  
> > +int vc4_v3d_bin_bo_get(struct vc4_dev *vc4)
> > +{
> > +	int ret = 0;
> > +
> > +	mutex_lock(&vc4->bin_bo_lock);
> > +
> > +	if (vc4->bin_bo) {
> > +		kref_get(&vc4->bin_bo_kref);
> > +		goto complete;
> > +	}
> > +
> > +	ret = bin_bo_alloc(vc4);
> > +
> > +complete:
> > +	mutex_unlock(&vc4->bin_bo_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static void bin_bo_release(struct kref *ref)
> > +{
> > +	struct vc4_dev *vc4 = container_of(ref, struct vc4_dev, bin_bo_kref);
> > +
> > +	if (!vc4->bin_bo)
> > +		return;
> 
> Could we WARN_ON_ONCE instead of returning silenty?  If we're going from
> 1->0 refcount without a bin_bo allocated, something has gone terribly
> wrong and we want to know.

Yes that would definitely be good. Crafting v7 in that direction.

Cheers,

Paul

> > +	drm_gem_object_put_unlocked(&vc4->bin_bo->base.base);
> > +	vc4->bin_bo = NULL;
> > +}
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

