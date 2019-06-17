Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523A4C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273EE2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TX9y/JY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfFQOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:18:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36732 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:18:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so16428190edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U2V9LJPWxdq3Nk0NdolFrZTzs3MZNPXv0KUg5LpciuY=;
        b=TX9y/JY5+hWC5Xm03AWZ7CFI378GG+jP0eC99ozrl7NkaoFW7f2OyEKmFeRlTvFdZT
         mdBp9hIJKhB/xFbTv3WTXFNOIL+SPWdM7qHW4Yl7/gp+275Kk4xi7OuN+a9JSaDJfGDY
         DR3ea0qGW/U8eTxdzsyRLfEoBA3bDdI7LjFHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=U2V9LJPWxdq3Nk0NdolFrZTzs3MZNPXv0KUg5LpciuY=;
        b=HS1GlP7B+ef67etu0eBU1yLS0fIWGzhsPnysTr4J80rDdeXcBpZaL+iL1qKPsYqcTD
         FaxMU1dNMkbxKzFXwU7NeJc5N3lPS3bY4fJoOcQWdmzqrMDDlM9IssZi+vo9e5czd4sI
         80+UsmI2OkMZHXOHIxGcd7asSHk+MV4ceQVwrWwJTO688elMnthIvW6vKn7Jg1jb3RPQ
         F/E1gO6t+sXGBEaG2UtqTy9AvH4kHwky2LPRUrnBgAwGR0GB4L3Jwq/lDt0ZgmBJ4H2z
         XNuqmZsNrIIwlPn2TgMf/H2cITsAHJMYoVQFZKhmFRJ7wjiDYDnJcd7WuHtNFkjghzcU
         Lb9A==
X-Gm-Message-State: APjAAAWHlwzirND0uH7u7QdTxEq8yC/tL1cc66iwuaJQias7p/cw4NeW
        gFhXQALwvm+HLk3IlCYrRjhKKQ==
X-Google-Smtp-Source: APXvYqxt2wSFUMgJfQfTbf6PTQBIyVKZ3jLP6op9fPVtWFiQN/oXdv9RZbjIFHvLB1CrQt7BljrzOg==
X-Received: by 2002:a50:9168:: with SMTP id f37mr11016448eda.242.1560781089631;
        Mon, 17 Jun 2019 07:18:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 14sm1868433ejj.12.2019.06.17.07.18.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:18:08 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:18:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/virtio: simplify cursor updates
Message-ID: <20190617141806.GG12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190617111406.14765-1-kraxel@redhat.com>
 <20190617111406.14765-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617111406.14765-4-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:14:05PM +0200, Gerd Hoffmann wrote:
> No need to do the reservation dance,
> we can just wait on the fence directly.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 024c2aa0c929..4b805bf466d3 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -184,7 +184,6 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
>  	struct virtio_gpu_framebuffer *vgfb;
>  	struct virtio_gpu_object *bo = NULL;
>  	uint32_t handle;
> -	int ret = 0;
>  
>  	if (plane->state->crtc)
>  		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
> @@ -208,15 +207,9 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
>  			 cpu_to_le32(plane->state->crtc_w),
>  			 cpu_to_le32(plane->state->crtc_h),
>  			 0, 0, vgfb->fence);
> -		ret = virtio_gpu_object_reserve(bo, false);
> -		if (!ret) {
> -			reservation_object_add_excl_fence(bo->tbo.resv,
> -							  &vgfb->fence->f);
> -			dma_fence_put(&vgfb->fence->f);
> -			vgfb->fence = NULL;
> -			virtio_gpu_object_unreserve(bo);
> -			virtio_gpu_object_wait(bo, false);
> -		}
> +		dma_fence_wait(&vgfb->fence->f, true);
> +		dma_fence_put(&vgfb->fence->f);
> +		vgfb->fence = NULL;

Even nicer would be to add the fence using
drm_atomic_set_fence_for_plane() in the prepare_fb hook. Assuming this
isn't necessary for correctness (but then I kinda have questions about
races and stuff).

But this gets the job done too I think, so:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	}
>  
>  	if (plane->state->fb != old_state->fb) {
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
