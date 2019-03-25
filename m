Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FCB2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GMcnq+lK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfCYJCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:02:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40898 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbfCYJCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:02:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so6776826edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0W9+VWbJgV1z4ZR6FzaLWza+NB7Yp018a28j4xuy3yw=;
        b=GMcnq+lKe8tBEEqn7b+2jJHCeEz+t6m2pE7wgFrS3L6caUTZi+HLH2kVpnh8qEfhRV
         mtNSL6yk0k2xSbPZxVks/QO2aN8v3DEVpfViT1ViXq64kr3Ov9q0BcgF/uDhE21N0GCW
         WMVr8vz8DqVVRUIqrY8XFCHsgkyOUh0ydUKEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0W9+VWbJgV1z4ZR6FzaLWza+NB7Yp018a28j4xuy3yw=;
        b=kX8rndlPSiYKUjNl7vGyeR3gQVurqJ2pEJTT4dV8DToSh3bHYU9fZL9anhhdM08Tw4
         Yxce2IMaBAkguEUcpfSUIzM8OrmOhvjjKfzocivFrkbEL86pBRtWTJXueputdadgatv7
         vbBnY96ZvrzshNXNI7FRSMh56WY1122PVsLB4/jTDMCXSrRsOLJXLzJY4pwT7DS6+d9h
         d5IhJw3dJJn8NR8qRXfgwy6/6EgyPpykuiqWqjbkA4F1aF56z+QOZ1o0sURWdPE3S5Y0
         sQPyjfBTaeI273yczjiN/zFzguem4/07WowhkPJRgS0vf430DJmSzGeF4FTC4dI+WJLR
         bq5A==
X-Gm-Message-State: APjAAAV11eVJAzlSaGH5Z0ZKI4DDTjZYwdQr4HOTFaKqZA7WhR4UCpZp
        C3HENTODHCoYdzkQQAytwKoIzA==
X-Google-Smtp-Source: APXvYqxAsoUuywsGKVQ5GDcJGG+E7gsB3SteQ3EaqQ+QwOpdg/cK8vaU2nIaLeSYhUFaHzZVTzqKCQ==
X-Received: by 2002:a17:906:905:: with SMTP id i5mr13503463ejd.23.1553504535355;
        Mon, 25 Mar 2019 02:02:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e17sm601254eja.33.2019.03.25.02.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 02:02:14 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:02:12 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/ttm: remove set but not used variable 'vgdev'
Message-ID: <20190325090212.GE2665@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190320020308.12745-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320020308.12745-1-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 02:03:08AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_init_mem_type':
> drivers/gpu/drm/virtio/virtgpu_ttm.c:117:28: warning:
>  variable 'vgdev' set but not used [-Wunused-but-set-variable]
> 
> drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_bo_swap_notify':
> drivers/gpu/drm/virtio/virtgpu_ttm.c:300:28: warning:
>  variable 'vgdev' set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in dc5698e80cf7 ("Add virtio gpu driver.")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Subject prefix should be drm/virtio: which is maybe the reason Gerd hasn't
spotted this yet.
-Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_ttm.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> index d6225ba20b30..eb007c2569d8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -114,10 +114,6 @@ static const struct ttm_mem_type_manager_func virtio_gpu_bo_manager_func = {
>  static int virtio_gpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>  				    struct ttm_mem_type_manager *man)
>  {
> -	struct virtio_gpu_device *vgdev;
> -
> -	vgdev = virtio_gpu_get_vgdev(bdev);
> -
>  	switch (type) {
>  	case TTM_PL_SYSTEM:
>  		/* System memory */
> @@ -297,10 +293,8 @@ static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
>  static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
>  {
>  	struct virtio_gpu_object *bo;
> -	struct virtio_gpu_device *vgdev;
>  
>  	bo = container_of(tbo, struct virtio_gpu_object, tbo);
> -	vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
>  
>  	if (bo->pages)
>  		virtio_gpu_object_free_sg_table(bo);
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
