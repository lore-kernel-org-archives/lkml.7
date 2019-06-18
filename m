Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05766C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C5921479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Mn/9T9RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfFROQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:16:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36883 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFROQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:16:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so22008378eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDyr/Hayw2IId/qNGbRLKP0mrDW1etMQA1PqQ01Gh10=;
        b=Mn/9T9RBbKXfNDMa8owY91k+MzyKmTXct/gRR9pkGC5sb28PLS5L9iEMP+FZmAFPw/
         nwcYkVIuVZ/ruRkYJiy/qr0IKuLKzkvmTQKUFFN64wRCq46JvEjab28ekRfZWFHW99BU
         s+ZJXt5+tn/X0ihJrtkCJrp54eaXZ/EFkx3GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wDyr/Hayw2IId/qNGbRLKP0mrDW1etMQA1PqQ01Gh10=;
        b=iaSKbEmF51N/xU3XM50M4oIy7CNhD+O3JbVuUZ8u/IpsFGTbe30E2RdfbYUwU+r6Hk
         0n44rnK8ONAI+QiXbbG0m2emEcvtch6BUljVJBt1G/XYjjOp7KLKLcy9L2P/Cy8ckqp7
         A1hedO66VzUfcefm0tFmEIxblYBH9UayaVIX8MUlSQS1iso+KsPyNn9RhyvJhG90uRzJ
         0fT+ULfK95V43wBp/01SfOR+t+g9LX9DiZGKPIFbMU9bw84PFTjSClcZR/ltBRHiKVAH
         BCQBLi63y314h8ND8dpPB38aPhLvbazPTjrWm8OmMojB3E4lQfV7Km1BJA2yIozuMo1L
         xUaA==
X-Gm-Message-State: APjAAAWkotfsvRAoqKC4PplOSYoHp1eo5lZXc0wqC2pCc4Kl2eJM04s0
        he0i9EckCT4xxwyj7A4S2Y76Gw==
X-Google-Smtp-Source: APXvYqzHXRYbcU+TSBG4oW3FDjsgiz3ekO87GItDZsVEAp5uoRHTuVJorSJpFrSxqXar92qtE0rl/g==
X-Received: by 2002:a17:906:670c:: with SMTP id a12mr54979446ejp.290.1560867366769;
        Tue, 18 Jun 2019 07:16:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i16sm2842945ejc.16.2019.06.18.07.16.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 07:16:06 -0700 (PDT)
Date:   Tue, 18 Jun 2019 16:16:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl
 fencing
Message-ID: <20190618141604.GC12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190618135821.8644-1-kraxel@redhat.com>
 <20190618135821.8644-8-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618135821.8644-8-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 03:58:15PM +0200, Gerd Hoffmann wrote:
> Use gem reservation helpers and direct reservation_object_* calls
> instead of ttm.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 36 ++++++++++++--------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 5cffd2e54c04..6db6a6e92dde 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -107,12 +107,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
>  	struct drm_gem_object *gobj;
>  	struct virtio_gpu_fence *out_fence;
> -	struct virtio_gpu_object *qobj;
>  	int ret;
>  	uint32_t *bo_handles = NULL;
>  	void __user *user_bo_handles = NULL;
>  	struct list_head validate_list;
> -	struct ttm_validate_buffer *buflist = NULL;
> +	struct drm_gem_object **buflist = NULL;
>  	int i;
>  	struct ww_acquire_ctx ticket;
>  	struct sync_file *sync_file;
> @@ -157,12 +156,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  
>  	INIT_LIST_HEAD(&validate_list);
>  	if (exbuf->num_bo_handles) {
> -
>  		bo_handles = kvmalloc_array(exbuf->num_bo_handles,
> -					   sizeof(uint32_t), GFP_KERNEL);
> +					    sizeof(uint32_t), GFP_KERNEL);
>  		buflist = kvmalloc_array(exbuf->num_bo_handles,
> -					   sizeof(struct ttm_validate_buffer),
> -					   GFP_KERNEL | __GFP_ZERO);
> +					 sizeof(struct drm_gem_object*),
> +					 GFP_KERNEL | __GFP_ZERO);
>  		if (!bo_handles || !buflist) {
>  			ret = -ENOMEM;
>  			goto out_unused_fd;
> @@ -181,19 +179,15 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  				ret = -ENOENT;
>  				goto out_unused_fd;
>  			}
> -
> -			qobj = gem_to_virtio_gpu_obj(gobj);
> -			buflist[i].bo = &qobj->tbo;
> -
> -			list_add(&buflist[i].head, &validate_list);
> +			buflist[i] = gobj;

I didn't bother looking, but I guess there's some room for a
array-of-gem-id to gem_bo-pointers helper function? Would only make sense
if we can share it with panfrost/v3d maybe.

>  		}
>  		kvfree(bo_handles);
>  		bo_handles = NULL;
>  	}
>  
> -	ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> +	ret = drm_gem_lock_reservations(buflist, exbuf->num_bo_handles, &ticket);
>  	if (ret)
> -		goto out_free;
> +		goto out_unused_fd;
>  
>  	buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
>  	if (IS_ERR(buf)) {
> @@ -222,21 +216,25 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
>  			      vfpriv->ctx_id, out_fence);
>  
> -	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
> +	for (i = 0; i < exbuf->num_bo_handles; i++)
> +		reservation_object_add_excl_fence(buflist[i]->resv, &out_fence->f);

Helper to unref an array of gem bo? Probably also needed by other drivers.


> +	drm_gem_unlock_reservations(buflist, exbuf->num_bo_handles, &ticket);
>  
> -	/* fence the command bo */
> -	virtio_gpu_unref_list(&validate_list);
> +	for (i = 0; i < exbuf->num_bo_handles; i++)
> +		if (buflist[i])
> +			drm_gem_object_put_unlocked(buflist[i]);

I am left wondering who's holding references onto these buffers now? How
do you make sure they don't disappear untimely?

I think atm it's ttm making sure of that, but if you drop that completely
there needs to be something else.

>  	kvfree(buflist);
>  	return 0;
>  
>  out_memdup:
>  	kfree(buf);
>  out_unresv:
> -	ttm_eu_backoff_reservation(&ticket, &validate_list);
> -out_free:
> -	virtio_gpu_unref_list(&validate_list);
> +	drm_gem_unlock_reservations(buflist, exbuf->num_bo_handles, &ticket);
>  out_unused_fd:
>  	kvfree(bo_handles);
> +	for (i = 0; i < exbuf->num_bo_handles; i++)
> +		if (buflist && buflist[i])
> +			drm_gem_object_put_unlocked(buflist[i]);
>  	kvfree(buflist);
>  
>  	if (out_fence_fd >= 0)

Patch itself looks correct, just put down my thoughts while reviewing it.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
