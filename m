Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805C8C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF67206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lOeUzLD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfFQOPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:15:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45813 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:15:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so16354948edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYvx+hKlTuvWdDRT83rsHG30d0GVUlP5mRSGQAA1z4U=;
        b=lOeUzLD7n4PAtFX3vYOFGYkqrgu1sQCyqQDXWzLTWLqikYvglRb+IKFBJMleJ1aRe1
         UUg9US9oUwADsm26SYW+wJ25BZAAesxu1FDsxn85zKoHf4riEK0CY2fJ21aza++votM/
         cvZKlJSnYsfAAnUWrTLrv/MCX9rZqWZ2l8HUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AYvx+hKlTuvWdDRT83rsHG30d0GVUlP5mRSGQAA1z4U=;
        b=C9RnJYJqFkktt9nYY6rLtHaTgJ2Ls708MLRKy1QBYZCmypojRsIDOIWem4FP51X9gh
         WLrA8ay0CopTwlC9UZoU3cxqOgfZQbqB5GuiIOgh+WFIebM8rGpXpXcrpbZVMAVVxI2O
         HxTpnh28Bij0srRr3W5sNXHGrKdnb7vwpgr8Rx2AsQmyEOGsddMUqDv3jkYgEuj1CsqK
         5tjUElDozDD4k/qGIkIP1D7GPut5bo6A/QAzMITBFpg5fYS194/iLdFpGaXVvS83a3Lb
         g6nr549qt9e7j5++gBVwFkte68WQSgyzQzXdBUjRAn48UiJ+CjopyceylGLYwaO3c2xZ
         HfEA==
X-Gm-Message-State: APjAAAXG3In4vOjfJ8FbOxkro1v7JvkBxYwFUY0oWlD8TcYNZ5v4gPmr
        ZFK5plj1SSE85cFHGx6YJv+nAw==
X-Google-Smtp-Source: APXvYqwaIDiXPlRgUHNg3kWDu2WCWsswz9JWV+a6jzhjA5v+QP6d6ZCANJoULcIqQzttt4TspRFMiQ==
X-Received: by 2002:a17:906:4356:: with SMTP id z22mr98657350ejm.56.1560780922674;
        Mon, 17 Jun 2019 07:15:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id u15sm3735567edi.10.2019.06.17.07.15.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:15:19 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:15:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/virtio: switch virtio_gpu_wait_ioctl() to gem
 helper.
Message-ID: <20190617141516.GF12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190617111406.14765-1-kraxel@redhat.com>
 <20190617111406.14765-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617111406.14765-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:14:04PM +0200, Gerd Hoffmann wrote:
> Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().

Would be good to mention here that with this the wait becomes lockless, we
don't call ttm_bo_reserve/unreserve anymore.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c0ba1ead740f..e38a6bb46cc7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -464,23 +464,13 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
>  			    struct drm_file *file)
>  {
>  	struct drm_virtgpu_3d_wait *args = data;
> -	struct drm_gem_object *gobj = NULL;
> -	struct virtio_gpu_object *qobj = NULL;
> -	int ret;
> -	bool nowait = false;
> -
> -	gobj = drm_gem_object_lookup(file, args->handle);
> -	if (gobj == NULL)
> -		return -ENOENT;
> -
> -	qobj = gem_to_virtio_gpu_obj(gobj);
> +	long timeout = 15 * HZ;
>  
>  	if (args->flags & VIRTGPU_WAIT_NOWAIT)
> -		nowait = true;
> -	ret = virtio_gpu_object_wait(qobj, nowait);
> +		timeout = 0;

timeout of 0 gets upgrade to a 1 jiffy wait, which is probably not what
you want here. You need to open-code ttm_bo_wait here and call
reservation_object_test_signaled_rcu() for this case.

With that fixed Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  
> -	drm_gem_object_put_unlocked(gobj);
> -	return ret;
> +	return drm_gem_reservation_object_wait(file, args->handle,
> +					       true, timeout);
>  }
>  
>  static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
