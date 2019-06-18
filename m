Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345B1C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0889D20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XjzjnU22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfFROHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:07:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38418 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFROHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:07:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so19741617edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbjXiDHUcs03Ham95m0Whx0OgVZ5j2550aVQnPTfdxQ=;
        b=XjzjnU228yADptN7urnRtwf8Ole5zcytiEo9ewubNXfcudMgl6XJCKZLzRyF6DK60v
         r0lXIvAbGBB3ijq69WVn9MUKU9OXLTsAtICIh3LWg6xWSLwVd9duS4BDQdd94/O/UjBN
         Gf1rHG7pIdcfWWxcH62s7t4gajFPKygSMxMBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=kbjXiDHUcs03Ham95m0Whx0OgVZ5j2550aVQnPTfdxQ=;
        b=dHn9M68IOdoW9f7C016LnCN4UT6Hyt+u9D+LDYLc85XkeWpF46NBhj9/R/QfRLLyiA
         ashxwSdaPgss4CcumN55fGTAB9d3YqZSpIVGq0XErTcpgNGUNKKXwK1uTMO9lsXlIF7A
         wEHD8K608pZMVlcVPfVOXemv3vdt0ijjUmPCHOg4A/9X1aKHNeOU+5FO/XqVu30xCSDV
         H7N+dXiu2pL4TkugWigRNsyVmLp7yNX3/C50B8SBo1V5+Dm2bP9CZMx8uITG3BoATyGi
         wRKf6ckbf4C3jD46f2tltFJj4Kwa5nKE/kU0aAvo9NLBVhWIYwq3LEVnM0L8lWk8tbOi
         ENEw==
X-Gm-Message-State: APjAAAUMT4T1IoFZOsSQtskfD08ncHb9WkRdJlp7UKUhoZw2eWbve9w6
        N2+jG8NSxH1mPml2mHZtktF3mQ==
X-Google-Smtp-Source: APXvYqybQkv2LSTpbVQqBNG0vU3Pn6LJz77TNlXyMjfN4HiYSdsBYRstxuDZf20J7rLw9S/ZVFFw7Q==
X-Received: by 2002:a50:900d:: with SMTP id b13mr93026672eda.289.1560866827421;
        Tue, 18 Jun 2019 07:07:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b25sm4631135ede.34.2019.06.18.07.07.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 07:07:06 -0700 (PDT)
Date:   Tue, 18 Jun 2019 16:07:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/12] drm/virtio: switch virtio_gpu_wait_ioctl() to
 gem helper.
Message-ID: <20190618140704.GA12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190618135821.8644-1-kraxel@redhat.com>
 <20190618135821.8644-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618135821.8644-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 03:58:10PM +0200, Gerd Hoffmann wrote:
> Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
> This also makes the ioctl run lockless.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Nit: Missing the v2 changelog here.
-Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index ac60be9b5c19..313c770ea2c5 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -464,23 +464,19 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
>  			    struct drm_file *file)
>  {
>  	struct drm_virtgpu_3d_wait *args = data;
> -	struct drm_gem_object *gobj = NULL;
> -	struct virtio_gpu_object *qobj = NULL;
> +	struct drm_gem_object *obj;
> +	long timeout = 15 * HZ;
>  	int ret;
> -	bool nowait = false;
>  
> -	gobj = drm_gem_object_lookup(file, args->handle);
> -	if (gobj == NULL)
> -		return -ENOENT;
> +	if (args->flags & VIRTGPU_WAIT_NOWAIT) {
> +		obj = drm_gem_object_lookup(file, args->handle);
> +		ret = reservation_object_test_signaled_rcu(obj->resv, true);
> +		drm_gem_object_put_unlocked(obj);
> +		return ret ? 0 : -EBUSY;
> +	}
>  
> -	qobj = gem_to_virtio_gpu_obj(gobj);
> -
> -	if (args->flags & VIRTGPU_WAIT_NOWAIT)
> -		nowait = true;
> -	ret = virtio_gpu_object_wait(qobj, nowait);
> -
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
