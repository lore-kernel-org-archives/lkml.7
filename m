Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD1CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266332082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Q98S9ja2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfEPU0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 16:26:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36306 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfEPU0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 16:26:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so7068552edx.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8yZZHCOma5wE75Yy+ujK3Ktu9FJHCJkzhA9Yrh2WVYE=;
        b=Q98S9ja2/IVtOjZB3o7q/lqxjh+gCLb+tfCBb0PRkYaHawbd+6fekaWUyEorRgJdfn
         T8tYiyFVQ1sDKIG8/8yDHLGVYx3rky/alhZ9Z3IbDIhBYkVHMqduZ1DSlJtNlP8naqaD
         xsCLWpLkdDQIuhg+v345d3WoH4VJx7Ng4dfCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=8yZZHCOma5wE75Yy+ujK3Ktu9FJHCJkzhA9Yrh2WVYE=;
        b=QdhNE0Cvr2Brm62Lx0bZcG9Ho4rDd5A65DvXUzMB4Ygv2jjZrgdjf7H4ign0NtEyFX
         8i8ewjnZ+VIi9IJtlVKsrOrPjLdnL0GJQ7kme3vetm2E18+YkE+HvUuNdBsghjyrmXs2
         0Jnegndq5Jd6knwvdm251km+XeQ3CvVPU9eXqQRwSWu8tzpjUEozMhwuvBil/rZeSBnD
         ubsqkwXPVDJG5xarLovdy3gky9EXPVF7AD8Z2QIweD+Zo3tmJsQrvBJKQCShFlbQVK45
         J/NLGksYQuhtRVfteffsN4F1YPoLn5NnbfGM5IQ+J+bRxztt4xsqhSDrOkcCfkxD4Pdp
         uJOg==
X-Gm-Message-State: APjAAAX5vMO2H2dTK4J+y7jcYnNorABohA7yAfss0R6K8erF4wTVBjGf
        DzzxkYWgxv/9F7TOqOrN7Ngyag==
X-Google-Smtp-Source: APXvYqzG1v8f6lqDK748rAUhUkdpUUAtJkbDrCDkFJGH9u8GRbfiWTkXsU2/eVwvvBirf5/w/Eaw2g==
X-Received: by 2002:a17:906:7d16:: with SMTP id u22mr21355882ejo.85.1558038407410;
        Thu, 16 May 2019 13:26:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c20sm1225864ejr.69.2019.05.16.13.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 13:26:46 -0700 (PDT)
Date:   Thu, 16 May 2019 22:26:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm: shmem: Add drm_gem_shmem_map_offset() wrapper
Message-ID: <20190516202644.GE3851@phenom.ffwll.local>
Mail-Followup-To: Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190516141447.46839-1-steven.price@arm.com>
 <20190516141447.46839-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516141447.46839-3-steven.price@arm.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 03:14:46PM +0100, Steven Price wrote:
> Provide a wrapper for drm_gem_map_offset() for clients of shmem. This
> wrapper provides the correct semantics for the drm_gem_shmem_mmap()
> callback.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
>  include/drm/drm_gem_shmem_helper.h     |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 1ee208c2c85e..9dbebc4897d1 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -400,6 +400,26 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
>  
> +/**
> + * drm_gem_map_offset - return the fake mmap offset for a gem object
> + * @file: drm file-private structure containing the gem object
> + * @dev: corresponding drm_device
> + * @handle: gem object handle
> + * @offset: return location for the fake mmap offset
> + *
> + * This provides an offset suitable for user space to return to the
> + * drm_gem_shmem_mmap() callback via an mmap() call.
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_gem_shmem_map_offset(struct drm_file *file, struct drm_device *dev,
> +			     u32 handle, u64 *offset)
> +{
> +	return drm_gem_map_offset(file, dev, handle, offset);
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_map_offset);

Not seeing the point of this mapper, since drm_gem_shmem_map_offset isn't
speficic at all. It works for dumb, shmem, cma and private objects all
equally well. I'd drop this and just directly call the underlying thing,
no need to layer helpers.
-Daniel

> +
>  static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 038b6d313447..4239ddaaaa4f 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -128,6 +128,8 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>  int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>  			      struct drm_mode_create_dumb *args);
>  
> +int drm_gem_shmem_map_offset(struct drm_file *file, struct drm_device *dev,
> +			     u32 handle, u64 *offset);
>  int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma);
>  
>  extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
