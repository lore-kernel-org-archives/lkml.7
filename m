Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5EBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAE5218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lKVMMF8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbfJVJFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:05:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46023 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfJVJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:05:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id q13so12123802wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i9cWg6hkC3Jwd63HaaPFghAt5dBBQDhYdlHJZBLH9+s=;
        b=lKVMMF8g8YiYTjlh2fqJFDY3PXwKTV+YIsCC2A+Y7rv0/syyGNnigyxwTKYIJjrBgK
         +SydfOo9H8S9CQJnwAGQRgvNvyWYVdxsGV0uvnJa2h22JPjrjwPocmjxVAHK3w663hHQ
         bI7kCLc9VTBs/oElUMSqxYs7bHKplYJbhethI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=i9cWg6hkC3Jwd63HaaPFghAt5dBBQDhYdlHJZBLH9+s=;
        b=YIoO3F1nD1ppGbsLJVl2wUHMy4tzN5JA/w22VpQs2mG+S2gXqP1xHnpZjiHAijUiJE
         o5YxLTL1MYBxKD8gxNzfaEt+Rrua87YFUAslrK9+87sYTsDxHgi2F/Ja2qLDrCjuL1f8
         tqArsYVTeaU591mBR38bndpF69WRPTlPEn49jT+JBX0RlurjS3Vc46/YxboEflLZvRHW
         21ZfynZXW548jFM31mzVS0UwL8fSLvrcK5/URePovZOkkYm4SYE2gjuiheN/DheFyPY2
         qMk7DBpYMF5dkJzEZfNJif2p0sPGrVJ/ZCdofLM90nAIRMqkOWWtv/VSljAQsXK537+q
         KSXw==
X-Gm-Message-State: APjAAAXIHTiZuo+p1kNgTnx8ZK46niHfkN5/B63gBVCFvVtk8IuFeuVV
        Q70EUegeU+mED3uKuEF/SANfuA==
X-Google-Smtp-Source: APXvYqzpbMbxT2yU70Z+fHkQQr9yWCG0/09XbqcMbnTOZqVwPDK93hJ38k/7uXKowUqTJaukb4eMTg==
X-Received: by 2002:adf:f4cb:: with SMTP id h11mr2679088wrp.260.1571735136188;
        Tue, 22 Oct 2019 02:05:36 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id s21sm20815085wrb.31.2019.10.22.02.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:05:35 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:05:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: print a single line with device features
Message-ID: <20191022090533.GB11828@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191018113832.5460-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018113832.5460-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:38:32PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_kms.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 0b3cdb0d83b0..2f5773e43557 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -155,16 +155,15 @@ int virtio_gpu_init(struct drm_device *dev)
>  #ifdef __LITTLE_ENDIAN
>  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
>  		vgdev->has_virgl_3d = true;
> -	DRM_INFO("virgl 3d acceleration %s\n",
> -		 vgdev->has_virgl_3d ? "enabled" : "not supported by host");
> -#else
> -	DRM_INFO("virgl 3d acceleration not supported by guest\n");
>  #endif
>  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
>  		vgdev->has_edid = true;
> -		DRM_INFO("EDID support available.\n");
>  	}
>  
> +	DRM_INFO("features: %cvirgl %cedid\n",
> +		 vgdev->has_virgl_3d ? '+' : '-',
> +		 vgdev->has_edid     ? '+' : '-');

Maybe we should move the various yesno/onoff/enableddisabled helpers from
i915_utils.h to drm_utils.h and use them more widely?

Anyway Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> +
>  	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
>  	if (ret) {
>  		DRM_ERROR("failed to find virt queues\n");
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
