Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2328C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7C62196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lWbjKPSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKLJkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:40:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34843 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:40:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so2193081wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 01:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ejx/kqQy3kcUiiFlaD/FPSSHJrxrW00iUrEoU2xAx90=;
        b=lWbjKPSh3T/bDqJI/OHcdLlHvZS5ZQztXcO2OXBpY5i56aD1VdfCigUlZJ3ECo8PkX
         c5BD6/OUUkowHGZ0krgx5x2QCrVgAaZYg8lbDU4ZKdFofGst8i6HqOXyIbBwSmdeZoYl
         d1iLL7m24zo7aI/7PXf4CBZRYc/omP54nwyD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ejx/kqQy3kcUiiFlaD/FPSSHJrxrW00iUrEoU2xAx90=;
        b=b55TcwaInlwXGsEyzynwgjApgv6dPar35QVf3BPllaMlW3HGUuHbZfTmTyWyZna7TR
         P72/rV4mZMIkntbCwb2TSpGJTFR8sY6FLxLiQnJFw4hhghLWwiwC2GUnJA7Aqm/lP1Xv
         HCR38BGjUbXT88KzX1pgYG3DoNPwWqZF7/XsZaN8E14xymapihhpXe5+Rd+Hlzwnsu0t
         Ppi6wTXBG1lAAIiQD2ngfuW8lK97yk3tLdRE3gcRJODtlmZsk8lGbfcfO89WHTgnPYjG
         r7dkNdchMBZEdUzoPUb2UD3At237hTSOF7PtNKIOHSIhneGrG93+HNrvWaK7qr7WX/SS
         SMlQ==
X-Gm-Message-State: APjAAAXOSRqIXCDM4B4IYGlGMBVLs4aQiK0L6Kn1NhPHc4zk6K7ShIJu
        QEN/5eqR3TqWbarXqVWIDMO7/g==
X-Google-Smtp-Source: APXvYqwrO8bU+BJYM7oebMXYjkT49Im67i7AQuC63Zqgak8bgNrt+yEN/H6dPBWSj91L92X3BD5VAw==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr2985572wmf.162.1573551633503;
        Tue, 12 Nov 2019 01:40:33 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id 62sm26900378wre.38.2019.11.12.01.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 01:40:32 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:40:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtgpu: fix double unregistration
Message-ID: <20191112094031.GF23790@phenom.ffwll.local>
Mail-Followup-To: Chuhong Yuan <hslester96@gmail.com>,
        David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20191109075417.29808-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109075417.29808-1-hslester96@gmail.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2019 at 03:54:17PM +0800, Chuhong Yuan wrote:
> drm_put_dev also calls drm_dev_unregister, so dev will be unregistered
> twice.
> Replace it with drm_dev_put to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Nice catch, I'll apply.

Since this is so confusing, we actually have a todo to remove drm_put_dev
completely from the codebase (and open-code it with explicit
unregister+put). Want to do that little patch series to update the
remaining few drivers and then remove drm_put_dev from core code?

Thanks, Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 0fc32fa0b3c0..fccc24e21af8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -138,7 +138,7 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
>  
>  	drm_dev_unregister(dev);
>  	virtio_gpu_deinit(dev);
> -	drm_put_dev(dev);
> +	drm_dev_put(dev);
>  }
>  
>  static void virtio_gpu_config_changed(struct virtio_device *vdev)
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
