Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67653218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SayvGCoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfJVJG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:06:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44170 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfJVJG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:06:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so17091727wrl.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PyGCvO7yvNngDSlKne/jPIBQIOZ8tTLnmw0W5bAjlwU=;
        b=SayvGCoATdUpVcqC5Nwb/Sou7TjKYsh9ojvvGVV8K5ekqJw8hWQYFqk7ccV1PNxCQm
         7RFUnb4kYlZLQeKaquDcdN0QFyIwzCtEJnVox4MWShZG/G8g6OgjccKLMwZB3jasR0Sm
         Y5botJm/1SEJuXUrc8F6mqZOcBhUqth2/0Bqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PyGCvO7yvNngDSlKne/jPIBQIOZ8tTLnmw0W5bAjlwU=;
        b=RQwwTLhz5sQFXi4B8Vz+R2LqxlRkdHT9p+WWaymqbC0wQlboH0cL6hSL7EntH7rCGc
         aHDV8/NoMAnq+bstehX/ePV9m8P1R3fW10DkL79JQh0Y42ZXrhfIYamb2g53fs6W/u+Y
         gjAcZ9Z3FZS62X18hiau0l7gWcpf9glN+W+01E21GxqxRNb+LILquxvJGtb87/SuV/hR
         LQl3qljYA7u8UB/rfo+dGoRjySkpJaKA0EsJqiGguS4HUBsYlKaaGwwn6u3P7ghVHF6P
         WYjdYYFW+jO54T4/W30APnT3LHzfG032iV/Klgipphmn0TKY14HSyr0aMz2FkrPWdt4o
         Q+1g==
X-Gm-Message-State: APjAAAXIN5IkcjE6zroG8/ZMpvX9mo58UXcBU4aarJ6PVgMoucfxdBwv
        nUTdA3AMPKCHfOyQqmO4NVTYPQ==
X-Google-Smtp-Source: APXvYqy2fd1mENqTQBbR51G8er0W9sr/MDy2gD3lxGrfLEDYlBc17QL0TksiwYQJ7DnJdB6ruwOSZw==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr677053wrn.307.1571735184750;
        Tue, 22 Oct 2019 02:06:24 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id o4sm29085790wre.91.2019.10.22.02.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:06:23 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:06:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: move byteorder handling into
 virtio_gpu_cmd_transfer_to_host_2d function
Message-ID: <20191022090621.GC11828@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191018122352.17019-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018122352.17019-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 02:23:52PM +0200, Gerd Hoffmann wrote:
> Be consistent with the rest of the code base.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Assuming sparse is all still pleased:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++--
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 12 ++++++------
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 12 ++++++------
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 314e02f94d9c..0b56ba005e25 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -267,8 +267,8 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
>  				   uint32_t resource_id);
>  void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>  					uint64_t offset,
> -					__le32 width, __le32 height,
> -					__le32 x, __le32 y,
> +					uint32_t width, uint32_t height,
> +					uint32_t x, uint32_t y,
>  					struct virtio_gpu_object_array *objs,
>  					struct virtio_gpu_fence *fence);
>  void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index f4b7360282ce..390524143139 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -132,10 +132,10 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>  			virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
>  			virtio_gpu_cmd_transfer_to_host_2d
>  				(vgdev, 0,
> -				 cpu_to_le32(plane->state->src_w >> 16),
> -				 cpu_to_le32(plane->state->src_h >> 16),
> -				 cpu_to_le32(plane->state->src_x >> 16),
> -				 cpu_to_le32(plane->state->src_y >> 16),
> +				 plane->state->src_w >> 16,
> +				 plane->state->src_h >> 16,
> +				 plane->state->src_x >> 16,
> +				 plane->state->src_y >> 16,
>  				 objs, NULL);
>  		}
>  	} else {
> @@ -234,8 +234,8 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
>  		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
>  		virtio_gpu_cmd_transfer_to_host_2d
>  			(vgdev, 0,
> -			 cpu_to_le32(plane->state->crtc_w),
> -			 cpu_to_le32(plane->state->crtc_h),
> +			 plane->state->crtc_w,
> +			 plane->state->crtc_h,
>  			 0, 0, objs, vgfb->fence);
>  		dma_fence_wait(&vgfb->fence->f, true);
>  		dma_fence_put(&vgfb->fence->f);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 80176f379ad5..74ad3bc3ebe8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -549,8 +549,8 @@ void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
>  
>  void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>  					uint64_t offset,
> -					__le32 width, __le32 height,
> -					__le32 x, __le32 y,
> +					uint32_t width, uint32_t height,
> +					uint32_t x, uint32_t y,
>  					struct virtio_gpu_object_array *objs,
>  					struct virtio_gpu_fence *fence)
>  {
> @@ -571,10 +571,10 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>  	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D);
>  	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
>  	cmd_p->offset = cpu_to_le64(offset);
> -	cmd_p->r.width = width;
> -	cmd_p->r.height = height;
> -	cmd_p->r.x = x;
> -	cmd_p->r.y = y;
> +	cmd_p->r.width = cpu_to_le32(width);
> +	cmd_p->r.height = cpu_to_le32(height);
> +	cmd_p->r.x = cpu_to_le32(x);
> +	cmd_p->r.y = cpu_to_le32(y);
>  
>  	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
>  }
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
