Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC5DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901C32077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eRq4Z/9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfDXNU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:20:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37225 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfDXNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:20:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id f53so15909178ede.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s3RBwrMdzgChLH4ce2VnBo4LCSLHLPxfh4HphYdAYRw=;
        b=eRq4Z/9QwrZ3in1xLNw/zXiDjUTlPf49/e6wCsHV/rwFPY3z5h7ChSEiD3XP37Wc6d
         RGHhY0BodiCGStoadhdWAbcGU0mj25ok7/vXXGtheINuShcPuHIS6UVMsSq/498JqPJ1
         DT+zG4faPXDM5Bwd7hPdXGC6GhQ2PLeJe5cgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=s3RBwrMdzgChLH4ce2VnBo4LCSLHLPxfh4HphYdAYRw=;
        b=FhyTqb2NjrUEpIagIaf/G0uBy0bfh+lcEaHPnxH7hZbC+vGNJvR/UOhW60R3pL5J5p
         IeZ5bSybEw4Fzwf/6QE68nKMBnBWzzD8AyEYGnLHiEfMOw5brKiRsSh7FnB0/puoxuec
         x9t6nqX0wIhmzFsG7ALTzHM6guVpbpuwTToDMaI8RJ8Fxc2Kq09fvKzpITsdzNfwp9zM
         4vpkOCxgdzEl+El6qg6YubXzTO+Sf8R4Or8jisLyWHF0NsEgrkYf75esP0ruvRhkJNbf
         tGbJ9b3H8zXFtvx8syc4a9su44cU7owcAnrOuQaYwbp7heLgYx3cSCFDJypdgJkg185x
         4L0Q==
X-Gm-Message-State: APjAAAW0bRsXCv1y495cABw9cizDfbj45kvm+ZjIwuO15EEUBeL7011W
        3zdVVSPuWw7Hn9JaCV0s3JQKKg==
X-Google-Smtp-Source: APXvYqxLwFnK6ikMoqX7rwN+WbBMPrGxLW4VFRvw7aBCsrULr2Q8H2dY2u2R/6wsiGYkk4KmAD8kaA==
X-Received: by 2002:a17:906:7201:: with SMTP id m1mr13258455ejk.96.1556112024242;
        Wed, 24 Apr 2019 06:20:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o15sm625194edj.44.2019.04.24.06.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 06:20:23 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:20:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panfrost: Add sanity checks to submit IOCTL
Message-ID: <20190424132019.GS9857@phenom.ffwll.local>
Mail-Followup-To: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20190424131355.62817-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424131355.62817-1-tomeu.vizoso@collabora.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:13:53PM +0200, Tomeu Vizoso wrote:
> So userspace can get feedback on any error conditions, instead of going
> ahead and things breaking later.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Bonus: some igts to exercise these corner cases. It helps a lot with uapi
review and testing.
-Daniel

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 35 +++++++++++++++++--------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index c06af78ab833..0f2863cb8077 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -172,13 +172,27 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
>  {
>  	struct panfrost_device *pfdev = dev->dev_private;
>  	struct drm_panfrost_submit *args = data;
> -	struct drm_syncobj *sync_out;
> +	struct drm_syncobj *sync_out = NULL;
>  	struct panfrost_job *job;
>  	int ret = 0;
>  
> +	if (!args->jc)
> +		return -EINVAL;
> +
> +	if (args->requirements && args->requirements != PANFROST_JD_REQ_FS)
> +		return -EINVAL;
> +
> +	if (args->out_sync > 0) {
> +		sync_out = drm_syncobj_find(file, args->out_sync);
> +		if (!sync_out)
> +			return -ENODEV;
> +	}
> +
>  	job = kzalloc(sizeof(*job), GFP_KERNEL);
> -	if (!job)
> -		return -ENOMEM;
> +	if (!job) {
> +		ret = -ENOMEM;
> +		goto fail_out_sync;
> +	}
>  
>  	kref_init(&job->refcount);
>  
> @@ -190,25 +204,24 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
>  
>  	ret = panfrost_copy_in_sync(dev, file, args, job);
>  	if (ret)
> -		goto fail;
> +		goto fail_job;
>  
>  	ret = panfrost_lookup_bos(dev, file, args, job);
>  	if (ret)
> -		goto fail;
> +		goto fail_job;
>  
>  	ret = panfrost_job_push(job);
>  	if (ret)
> -		goto fail;
> +		goto fail_job;
>  
>  	/* Update the return sync object for the job */
> -	sync_out = drm_syncobj_find(file, args->out_sync);
> -	if (sync_out) {
> +	if (sync_out)
>  		drm_syncobj_replace_fence(sync_out, job->render_done_fence);
> -		drm_syncobj_put(sync_out);
> -	}
>  
> -fail:
> +fail_job:
>  	panfrost_job_put(job);
> +fail_out_sync:
> +	drm_syncobj_put(sync_out);
>  
>  	return ret;
>  }
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
