Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A1221726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eyBBu9iY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbfHVNJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:09:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35166 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbfHVNJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id t50so7883287edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ct+pvFgmTwPh52glIEGsAjP8pa5OgYXxgpqmL6lQd34=;
        b=eyBBu9iYdg2nO8/CePlnSjFCGm9CqFYCCiSKOQiy3w9BoyyceU/lhyzwvmT/uouFer
         kNFW7tUZ5RlYTHRVgDP5CXQUFfScLAGdFbXce6yfDkpQuZiNWVTFyZAS1ule0dENhkcj
         ICdD0aCcalUIoBqIlSfEmrju1vD/z1VjhO7KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ct+pvFgmTwPh52glIEGsAjP8pa5OgYXxgpqmL6lQd34=;
        b=DNVO8s+6qGJwZSpCSIJYg92R36fU4yWbUK7CQZUidt9uZne4EwigtG69Po2moDXA1u
         pMXgO0HeHEOGOLx1PEkhMgsrphi26AyGETn0v1MUb4ySYrSfhhz23aoYUuSdIpoakGYJ
         /LGyYlYrx+Z0asFy4ImrDUZ80WT+13GlbONJIlkYcxXBKAq+blQ9EX8OYaERuvsTo426
         ei439fmPjq8BUGUYNQtezfgOZarIh9wIAH9nOTL+NwTRMF6a8ISLFCPWi7WN9eXPB65e
         z3MpOxG0PBWhXkkV96wu2dDywLpLn2wkf6vMJijC5hNCOLtUDt68DX6vtQOvxTZv2R9R
         EIdQ==
X-Gm-Message-State: APjAAAV4tcDH6sutIkruOdhGy7DZpCIUqiJ+2B03scPN6EChXfvg3t5j
        8rCHfRkTWO0vTA3EK4YqxcaHEg==
X-Google-Smtp-Source: APXvYqx6dMxiOov/ACP8syk5Qv8zhXwRN6GP6jKrz23a3jQE3ts1XPKx5XbS73SbRFGQffIklCa9/g==
X-Received: by 2002:a50:fa43:: with SMTP id c3mr41823097edq.94.1566479342268;
        Thu, 22 Aug 2019 06:09:02 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id c14sm4849940edb.5.2019.08.22.06.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 06:09:01 -0700 (PDT)
Date:   Thu, 22 Aug 2019 15:08:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/3] drm: drop resource_id parameter from
 drm_fb_helper_remove_conflicting_pci_framebuffers
Message-ID: <20190822130859.GW11147@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
References: <20190822090645.25410-1-kraxel@redhat.com>
 <20190822090645.25410-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822090645.25410-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:06:44AM +0200, Gerd Hoffmann wrote:
> Not needed any more for remove_conflicting_pci_framebuffers calls.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  include/drm/drm_fb_helper.h             | 4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  drivers/gpu/drm/bochs/bochs_drv.c       | 2 +-
>  drivers/gpu/drm/cirrus/cirrus.c         | 2 +-
>  drivers/gpu/drm/mgag200/mgag200_drv.c   | 2 +-
>  drivers/gpu/drm/qxl/qxl_drv.c           | 2 +-
>  drivers/gpu/drm/radeon/radeon_drv.c     | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.c    | 1 -
>  8 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 5a5f4b1d8241..8dcc012ccbc8 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -539,18 +539,16 @@ drm_fb_helper_remove_conflicting_framebuffers(struct apertures_struct *a,
>  /**
>   * drm_fb_helper_remove_conflicting_pci_framebuffers - remove firmware-configured framebuffers for PCI devices
>   * @pdev: PCI device
> - * @resource_id: index of PCI BAR configuring framebuffer memory
>   * @name: requesting driver name
>   *
>   * This function removes framebuffer devices (eg. initialized by firmware)
> - * using memory range configured for @pdev's BAR @resource_id.
> + * using memory range configured for any of @pdev's memory bars.
>   *
>   * The function assumes that PCI device with shadowed ROM drives a primary
>   * display and so kicks out vga16fb.
>   */
>  static inline int
>  drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
> -						  int resource_id,
>  						  const char *name)
>  {
>  	int ret = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 98df55534a6d..6b96a5738e57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1031,7 +1031,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Get rid of things like offb */
> -	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "amdgpudrmfb");
> +	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "amdgpudrmfb");
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index 770e1625d05e..3b9b0d9bbc14 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -114,7 +114,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>  		return -ENOMEM;
>  	}
>  
> -	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "bochsdrmfb");
> +	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "bochsdrmfb");
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
> index 36a69aec8a4b..89d9e6fdeb8c 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -532,7 +532,7 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  	struct cirrus_device *cirrus;
>  	int ret;
>  
> -	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "cirrusdrmfb");
> +	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "cirrusdrmfb");
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
> index afd9119b6cf1..4f9df3b93598 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -46,7 +46,7 @@ MODULE_DEVICE_TABLE(pci, pciidlist);
>  
>  static int mga_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
> -	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "mgag200drmfb");
> +	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "mgag200drmfb");
>  
>  	return drm_get_pci_dev(pdev, ent, &driver);
>  }
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index c1802e01d9f6..2b726a51a302 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -83,7 +83,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		goto free_dev;
>  
> -	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> +	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "qxl");
>  	if (ret)
>  		goto disable_pci;
>  
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index a4a78dfdef37..624aa580d418 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -329,7 +329,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>  		return -EPROBE_DEFER;
>  
>  	/* Get rid of things like offb */
> -	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "radeondrmfb");
> +	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "radeondrmfb");
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 0fc32fa0b3c0..3d24181636e1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -56,7 +56,6 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev, struct virtio_device *vd
>  	dev->pdev = pdev;
>  	if (vga)
>  		drm_fb_helper_remove_conflicting_pci_framebuffers(pdev,
> -								  0,
>  								  "virtiodrmfb");
>  
>  	/*
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
