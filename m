Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E863CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A537C20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kOcHALov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfDPHTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:19:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40281 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDPHTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:19:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id d46so12142433eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m48/eBR4UYgBq/drzBRwIdDKxpTLISr7naMLV1Ww6AI=;
        b=kOcHALov67meyo3+VshAzhBVsUQhMm9V4EFUS064TxlMwbM2yr4rSkMYXp/V45EAxo
         PCG/H9z39VSHxATzVfxlZcBJKGU/VMYUCNyytHo2txrwLZas4+UMXoUs+Db1aAc4iq80
         Brcb2NOdOPdzU/gXOPxJeuhWLviWwW8J3ckpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=m48/eBR4UYgBq/drzBRwIdDKxpTLISr7naMLV1Ww6AI=;
        b=AlsM92cpUK/gn+jHs8IU/3SsALWlKrOjhUmYEo7VQn5UzIi3lvhupw6hTjWbsJb3V/
         UjKLCDcEGphUFsQ+gTVaKhm7/FtDQH2nAnCi0uYPTwbFJBmDrXOCHCj4cXvB9J8NvzRi
         hQmWCeYVF6tuphprF2xFfIG3Nr2mWIJvwkMqilcJUiziRXFIs5mL96uoAbKT2iKSgIjd
         jqKW6E3KNw0JuwY9//G1d2fLj8L13jk9tvHXhDi7vLowIpy5a7oxW8+YCN5lD4UpPl77
         inGNIsKzozLKGSRunmmpTlW3VOjl3xypYrIs4tB5C9e3hl22LdSWjrYgcCcjiOwp9r9k
         Pgrw==
X-Gm-Message-State: APjAAAU07KYbuMmV6zOe8EiwECXxx1TA53GGrQvmoNIrE6z96G95oSqi
        4H2ul6G4xQ/PtAHBM+btmE4NBw==
X-Google-Smtp-Source: APXvYqxNh6+V0qNYvgaujTGzWcigAxyo3uNdJamj48gEob8oyhV1GUD/pTncEKcZF8mIYLbAkYSFfg==
X-Received: by 2002:a50:d70b:: with SMTP id t11mr50717336edi.123.1555399178161;
        Tue, 16 Apr 2019 00:19:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b54sm15496347ede.58.2019.04.16.00.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 00:19:37 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:19:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: add DRM_PRIME_CAP_LOCAL
Message-ID: <20190416071935.GK2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190410074712.5649-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410074712.5649-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:47:12AM +0200, Gerd Hoffmann wrote:
> Some drivers (for example qxl) support neither import nor export of
> dma-bufs.  But you can still use dma-bufs to pass buffer references
> from one process to another; drm_gem_prime_import() will figure the
> dma-buf came from the same driver and just takes a reference in that
> case instead of doing a full export/import.
> 
> Right now there is no way for userspace to figure it can do this.  Add
> the new prime capability DRM_PRIME_CAP_LOCAL to indicate that.  Set the
> bit for every driver which has the DRIVER_PRIME feature bit set.

It can just try? Any driver that supports dma-buf (even if only for
self-import) should set DRIVER_PRIME. It's perfectly fine to reject any
other sharing.
-Daniel

> 
> Cc: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/uapi/drm/drm.h      | 1 +
>  drivers/gpu/drm/drm_ioctl.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 236b01a1fabf..b6157d48dc1a 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -632,6 +632,7 @@ struct drm_gem_open {
>  #define DRM_CAP_PRIME			0x5
>  #define  DRM_PRIME_CAP_IMPORT		0x1
>  #define  DRM_PRIME_CAP_EXPORT		0x2
> +#define  DRM_PRIME_CAP_LOCAL		0x4
>  #define DRM_CAP_TIMESTAMP_MONOTONIC	0x6
>  #define DRM_CAP_ASYNC_PAGE_FLIP		0x7
>  /*
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index d337f161909c..00599758783b 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -241,6 +241,8 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
>  	case DRM_CAP_PRIME:
>  		req->value |= dev->driver->prime_fd_to_handle ? DRM_PRIME_CAP_IMPORT : 0;
>  		req->value |= dev->driver->prime_handle_to_fd ? DRM_PRIME_CAP_EXPORT : 0;
> +		req->value |= (dev->driver->driver_features & DRIVER_PRIME)
> +			? DRM_PRIME_CAP_LOCAL : 0;
>  		return 0;
>  	case DRM_CAP_SYNCOBJ:
>  		req->value = drm_core_check_feature(dev, DRIVER_SYNCOBJ);
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
