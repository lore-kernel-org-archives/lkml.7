Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693B6C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EC1213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K+oUUGqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfFROXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:23:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45615 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFROXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:23:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so21970288edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fX3MfhN+akKdud7rTKeAfhE9NPiCnKEnOrlfRRG5bLU=;
        b=K+oUUGqY9nx/DClDvm9BJhPBn9lGzoNKYelLu7dy6gc19R7pMmooKs7+GHNFp1EfbG
         mMK0u/ITPRK4ugJPWAESn72Rt+tpT9GawQE39QCYHzgs2bj4/IWhfJY8vmDmvhmyPf9p
         e2gbTk9YlzkDOpNNV7eieonjZLrmk8wW8LWHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fX3MfhN+akKdud7rTKeAfhE9NPiCnKEnOrlfRRG5bLU=;
        b=cUCWVqxjCkA9yE6cor5/CDm/U7RJyLdBpS330fqzNbvQe6cESEmNb+MN5X7UveuOKl
         cEM4GQrZSmfyUNXI+w08eJHcClRqMnUeJy+WE1beCrVAwQ16tn6byZEyBi4ldRy3Lfa9
         IVmc65mqu3AIzTCfjWBDj4eZzfBRU6YuTJ88mT9D2zJLKM/xXNfltbec/mgmrGYZvtVr
         A425UJa1OTZBOut1FChxVpRLgGeolb9JmRMxpCFOhc5WvIRyR1FDlVJzzkrZSnUKVecG
         onuQJ/HUNtnk+tLQz+pnahnW4Ad1dIXbYIWbmOtyY3NxWJXciOMgQpL3nLCBiJqII4O6
         B93g==
X-Gm-Message-State: APjAAAXG/FNojVmOjXqrsaINliefATtnWnIiBkYNREK8I6wUZPTGeGoP
        eIlAQK1aEVU627aoUoUsGdmWyQ==
X-Google-Smtp-Source: APXvYqywX4L/MXBiZ6gvbs/ba2m6OFFGgNkS1QZb/dqTtCFDk5frIdc7t9AugsLvIRc6kFMRaTVcyw==
X-Received: by 2002:a05:6402:64a:: with SMTP id u10mr85306567edx.35.1560867825135;
        Tue, 18 Jun 2019 07:23:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id u9sm3383709edm.71.2019.06.18.07.23.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 07:23:44 -0700 (PDT)
Date:   Tue, 18 Jun 2019 16:23:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl
 fencing
Message-ID: <20190618142342.GD12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190618135821.8644-1-kraxel@redhat.com>
 <20190618135821.8644-8-kraxel@redhat.com>
 <20190618141604.GC12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618141604.GC12905@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 04:16:04PM +0200, Daniel Vetter wrote:
> On Tue, Jun 18, 2019 at 03:58:15PM +0200, Gerd Hoffmann wrote:
> > Use gem reservation helpers and direct reservation_object_* calls
> > instead of ttm.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 36 ++++++++++++--------------
> >  1 file changed, 17 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index 5cffd2e54c04..6db6a6e92dde 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -107,12 +107,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >  	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
> >  	struct drm_gem_object *gobj;
> >  	struct virtio_gpu_fence *out_fence;
> > -	struct virtio_gpu_object *qobj;
> >  	int ret;
> >  	uint32_t *bo_handles = NULL;
> >  	void __user *user_bo_handles = NULL;
> >  	struct list_head validate_list;
> > -	struct ttm_validate_buffer *buflist = NULL;
> > +	struct drm_gem_object **buflist = NULL;
> >  	int i;
> >  	struct ww_acquire_ctx ticket;
> >  	struct sync_file *sync_file;
> > @@ -157,12 +156,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >  
> >  	INIT_LIST_HEAD(&validate_list);
> >  	if (exbuf->num_bo_handles) {
> > -
> >  		bo_handles = kvmalloc_array(exbuf->num_bo_handles,
> > -					   sizeof(uint32_t), GFP_KERNEL);
> > +					    sizeof(uint32_t), GFP_KERNEL);
> >  		buflist = kvmalloc_array(exbuf->num_bo_handles,
> > -					   sizeof(struct ttm_validate_buffer),
> > -					   GFP_KERNEL | __GFP_ZERO);
> > +					 sizeof(struct drm_gem_object*),
> > +					 GFP_KERNEL | __GFP_ZERO);
> >  		if (!bo_handles || !buflist) {
> >  			ret = -ENOMEM;
> >  			goto out_unused_fd;
> > @@ -181,19 +179,15 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >  				ret = -ENOENT;
> >  				goto out_unused_fd;
> >  			}
> > -
> > -			qobj = gem_to_virtio_gpu_obj(gobj);
> > -			buflist[i].bo = &qobj->tbo;
> > -
> > -			list_add(&buflist[i].head, &validate_list);
> > +			buflist[i] = gobj;
> 
> I didn't bother looking, but I guess there's some room for a
> array-of-gem-id to gem_bo-pointers helper function? Would only make sense
> if we can share it with panfrost/v3d maybe.
> 
> >  		}
> >  		kvfree(bo_handles);
> >  		bo_handles = NULL;
> >  	}
> >  
> > -	ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> > +	ret = drm_gem_lock_reservations(buflist, exbuf->num_bo_handles, &ticket);
> >  	if (ret)
> > -		goto out_free;
> > +		goto out_unused_fd;
> >  
> >  	buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
> >  	if (IS_ERR(buf)) {
> > @@ -222,21 +216,25 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >  	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
> >  			      vfpriv->ctx_id, out_fence);
> >  
> > -	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
> > +	for (i = 0; i < exbuf->num_bo_handles; i++)
> > +		reservation_object_add_excl_fence(buflist[i]->resv, &out_fence->f);
> 
> Helper to unref an array of gem bo? Probably also needed by other drivers.
> 
> 
> > +	drm_gem_unlock_reservations(buflist, exbuf->num_bo_handles, &ticket);
> >  
> > -	/* fence the command bo */
> > -	virtio_gpu_unref_list(&validate_list);
> > +	for (i = 0; i < exbuf->num_bo_handles; i++)
> > +		if (buflist[i])
> > +			drm_gem_object_put_unlocked(buflist[i]);
> 
> I am left wondering who's holding references onto these buffers now? How
> do you make sure they don't disappear untimely?
> 
> I think atm it's ttm making sure of that, but if you drop that completely
> there needs to be something else.
> 
> >  	kvfree(buflist);
> >  	return 0;
> >  
> >  out_memdup:
> >  	kfree(buf);
> >  out_unresv:
> > -	ttm_eu_backoff_reservation(&ticket, &validate_list);
> > -out_free:
> > -	virtio_gpu_unref_list(&validate_list);
> > +	drm_gem_unlock_reservations(buflist, exbuf->num_bo_handles, &ticket);
> >  out_unused_fd:
> >  	kvfree(bo_handles);
> > +	for (i = 0; i < exbuf->num_bo_handles; i++)
> > +		if (buflist && buflist[i])
> > +			drm_gem_object_put_unlocked(buflist[i]);
> >  	kvfree(buflist);
> >  
> >  	if (out_fence_fd >= 0)
> 
> Patch itself looks correct, just put down my thoughts while reviewing it.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

r-b retracted after reviewing the next patch. You remove ttm_bo_fence
here, which also moves/adds the bo to the lru, which is the think grabbing
a reference, which has been preventing the oopses here thus far.

With that gone you blow up.

The callchain is:

ttm_eu_fence_buffer_objects -> ttm_bo_add_to_lru -> ttm_bo_add_mem_to_lru
-> kref_get.

I honestly never looked too closely at that part of ttm, but it's a lot
different from what at least i915 does. Design principles we use there:
- lru lists only hold a weak reference, i.e. it's a pointer, but it
  doesn't prevent the final kput from freeing the object. In the actual
  object free callback we remove those references while grabbing the right
  locks (which might need to be offloaded to a worker in some cases to
  avoid recursions).

- we only hold a kref while the object is under active use by the gpu.

I very much prefer this weak reference model for lookup tables, caches,
lrus and all that since imo it leads to clearer code. And you can always
upgrade to a full reference using kref_get_unless_zero. ttm seems to be
using a completely different design here, not sure how old memory gets
released when a client dies.

I guess this is a gap we'd need to first fix in gem helpers, maybe even
needs some kind of notion of an lru and some memory region an object sits
in ...

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
