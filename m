Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D5C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF376206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YyLeBzVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfFQOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:08:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46850 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:08:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so16335392edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QclIRmGgE6e1NwC0LyK0y/gOsKzmfG48w5Q/Ut94Q+k=;
        b=YyLeBzVYVYsicyyTQaxOj8/wVRXFIWW/Pk135d0I16nxXxId1a6hq5l4MbpdrVDb1q
         6K00J3TChDALBDD04GdAyKBMsE45rcW3gx1uphcbzC7nmtufgwJsA9J9KKokP6xZk8RF
         IokXKwK/8xTC7O5fOi/xUwQMKRgUFj4H+SzJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QclIRmGgE6e1NwC0LyK0y/gOsKzmfG48w5Q/Ut94Q+k=;
        b=D/nRntlX9oRz3tInTKy7UYPKhjHmqSpm64b/RHfsG9PZuqtHUi291QonKVFuB7GqU3
         4VZTghO5qwRYCNJkzwY698l9mz3Eif5+pcT3foZ3siwMmXgajh4RwbBZcxcsQsIYcgyl
         ZSFnDjzYioK5uYwC9NvkweGKvt8oIXoXDGLKplD04znGKc6msmbSu7jmjY16feajzV8s
         OymbCfPquXCE87hkjAD42CPb3QESAUxoDB+wYB1i02hTuVBtZeJZ/XdsHLLDK3KuvKcH
         tSSwX76kMLmr/BWjJv+LMIc5VCzxCu6hqsHBe3GbyqBcnUrRKRbrf1h64eokJWYjHd4O
         1oNg==
X-Gm-Message-State: APjAAAWvVC1qtdTbdoyJ8H0JHDqpF08bOqrf7sOuek33WlfchIDNud7l
        D8S39fMiuecn3gbO+QLD8Ro32Q==
X-Google-Smtp-Source: APXvYqxFgofUOrCrJe8Zusip83q+AIHX7wVQGYRBZyLeOZT0aLmRPes/a8REwHA8Uo/EXqXeQFakrw==
X-Received: by 2002:a05:6402:8d7:: with SMTP id d23mr76998441edz.17.1560780509384;
        Mon, 17 Jun 2019 07:08:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y3sm3688780edr.27.2019.06.17.07.08.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:08:27 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:08:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/virtio: pass gem reservation object to ttm init
Message-ID: <20190617140825.GD12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190617111406.14765-1-kraxel@redhat.com>
 <20190617111406.14765-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617111406.14765-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:14:03PM +0200, Gerd Hoffmann wrote:
> With this gem and ttm will use the same reservation object,
> so mixing and matching ttm / gem reservation helpers should
> work fine.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

While doing my prime doc+cleanup series I wondered whether we should do
this for everyone, and perhaps even remove ttm_bo.ttm_resv. Only driver
which doesn't yet have a gem_bo embedded in the same allocation is vmwgfx,
and that would be easy to fix by adding a vmwgfx_resv somehwere.

Anyway, looks like a solid start into the convergence story.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index b2da31310d24..242766d644a7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -132,7 +132,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  	virtio_gpu_init_ttm_placement(bo);
>  	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
>  			  ttm_bo_type_device, &bo->placement, 0,
> -			  true, acc_size, NULL, NULL,
> +			  true, acc_size, NULL,
> +			  bo->gem_base.resv,
>  			  &virtio_gpu_ttm_bo_destroy);
>  	/* ttm_bo_init failure will call the destroy */
>  	if (ret != 0)
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
