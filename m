Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD1C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90462085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iz+ztRpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfFROJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:09:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41903 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFROJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:09:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so21914782eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rd5swHtQn6I4g05FOd476JWDZK1W4dVOi6bXk+VCUPQ=;
        b=iz+ztRpIBrIo4iXy7HZw7wvhbwfGBVktYhUlYiMIbgaOxZQNafxnYMroWZS3Hvj4V/
         qIDUojvQUiaWn1A5Vt3azHhw+MYeoDPl5oah6fT//VjXyLmBISjRJLLZKJ4fPrbUnB6I
         c5RFdqjzd7ASAlYn1rZ96LAmB/zO6r2XJM6QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rd5swHtQn6I4g05FOd476JWDZK1W4dVOi6bXk+VCUPQ=;
        b=JRJdbUqiBAwryRMT2bF4f7lQ1mp+ZgU9fB12yo5mJH6kF3WZ2vn4Dr3hZftamtiU7U
         HKsrNSUSYexJzighy1ezc9+FVqVoGIVPSk3Q0EcbRrFpQbpn84WNSw64ViB03SZH1arX
         mn5XrSQ+YJy4yIQIflAM0ZIdof0knK+0yct7/T64pNmnV3IEBhCnEjZF8G/YlqOf9Oy4
         6p2cTzBS5Lyz9CkhpWLXSRQ/333RexluiFf9cH6NA5m0rzzxMEStmCJ1VyzfjPi1ISLk
         oXNdakOPiwB03lKvdi4lqaD5JzppIoUTTsHh5IzUQpMkpNRS0EiqpLfNwqY6CTE1HWgw
         kQWQ==
X-Gm-Message-State: APjAAAWPdBFUFiPf9Rp50dufI9j7f84krjFL+mZwobkyVu+QzzMPZ+FJ
        KUGslQKr5jCsmVuYKirsPYC+vQ==
X-Google-Smtp-Source: APXvYqxfjGPU2BQiQCTzJdcSdy/5MdYMFSVDaL4zuBQZvv/UJIsO2W/GMuSac5Zl+3oa3BfMmQ4AWg==
X-Received: by 2002:a50:b635:: with SMTP id b50mr31792908ede.293.1560866969483;
        Tue, 18 Jun 2019 07:09:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a9sm4932323edc.44.2019.06.18.07.09.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 07:09:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 16:09:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/12] drm/virtio: remove ttm calls from in
 virtio_gpu_object_{reserve,unreserve}
Message-ID: <20190618140925.GB12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190618135821.8644-1-kraxel@redhat.com>
 <20190618135821.8644-7-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618135821.8644-7-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 03:58:14PM +0200, Gerd Hoffmann wrote:
> Call reservation_object_* directly instead
> of using ttm_bo_{reserve,unreserve}.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 06cc0e961df6..91c320819a8c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -402,7 +402,7 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  {
>  	int r;
>  
> -	r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> +	r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
>  	if (unlikely(r != 0)) {
>  		if (r != -ERESTARTSYS) {

errno semantics change here, I think you now get EINTR. With that fixed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  			struct virtio_gpu_device *qdev =
> @@ -416,7 +416,7 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  
>  static inline void virtio_gpu_object_unreserve(struct virtio_gpu_object *bo)
>  {
> -	ttm_bo_unreserve(&bo->tbo);
> +	reservation_object_unlock(bo->gem_base.resv);
>  }
>  
>  /* virgl debufs */
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
