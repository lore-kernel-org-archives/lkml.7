Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812A9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C04E206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WOTe4Rk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKLS1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:27:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:27:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so19619637wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1crLA0CDKaHQwRJPotAhe5OcKExhLg2j+GgM+2/R+w=;
        b=WOTe4Rk++ZKTe5OkVwhtp2PBDWd64FRPeMbBRl6vaLQK18RMPEdPfYp1O3CW8xOoY9
         Uf6XLg3iOFbWpfV6RgKHYqs+4Q1kv18AyOlSw7nERne80NjZneMrQHdcN76U6zjQI4RW
         baX285iYeAGi75nrGFHBLd22pKNgZQ55b3fSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+1crLA0CDKaHQwRJPotAhe5OcKExhLg2j+GgM+2/R+w=;
        b=hwFaDkiwpQmOOLGwDKXO6mbplsaGRFx/7sRX7rVx4/04ieJOWCySashFAudtv4Nafk
         t50ASI8amrB04vc7coib6HQB1yb81rTTW4oWegTX3yFD+UfgeJHa9kFupk+VI4e5jbUU
         R/5fbAhMNuaJ2WJ2pSgq9X6ixXANFBZbMhX6k+PdiH8xha1nxEEaU3ckxx8inYhEQhs6
         ljauHgU398HoMcQCXgHuYdbNIaGuLa7SujkN5gmjn8Fca8D00JXYDEthBCUoZRL0UlZi
         rJklYBM566uFL567JsMVMuSQ4456IyIaWHH9g6yOl1KPhaToK2/aFUexX8JJAlaQejz9
         pXuQ==
X-Gm-Message-State: APjAAAXQcUMwn0SdrdNEqZjjHxnRbjInLdX18OOvaKZ1p02YdCUNhlKB
        QzwofoU/2ZvyP5i1zaEjAmeULg==
X-Google-Smtp-Source: APXvYqwZ7ywdeBuu1gQvv84kaTS38RQgBQlM0G4DKyDzEaNTlWyLXFzRg8XRso2b/Wetke5i+xxMMQ==
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr27912754wro.132.1573583228225;
        Tue, 12 Nov 2019 10:27:08 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id d202sm3980158wmd.47.2019.11.12.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:27:07 -0800 (PST)
Date:   Tue, 12 Nov 2019 19:27:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/print: add DRM_DEV_WARN macro
Message-ID: <20191112182705.GL23790@phenom.ffwll.local>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191112170909.13733-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112170909.13733-1-wambui.karugax@gmail.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:09:09PM +0300, Wambui Karuga wrote:
> Add the DRM_DEV_WARN helper macro for printing warnings
> that use device pointers in their log output format.
> DRM_DEV_WARN can replace the use of dev_warn in such cases.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Can you pls include this in the patch to add the first user with rockchip?
Otherwise always a bit awkward when we add functions without callers.

lgtm otherwise.
-Daniel

> ---
>  include/drm/drm_print.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 5b8049992c24..6ddf91c0cb29 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -329,6 +329,15 @@ void drm_err(const char *format, ...);
>  #define DRM_WARN_ONCE(fmt, ...)						\
>  	_DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
>  
> +/**
> + * Warning output.
> + *
> + * @dev: device pointer
> + * @fmt: printf() like format string.
> + */
> +#define DRM_DEV_WARN(dev, fmt, ...)					\
> +	drm_dev_printk(dev, KERN_WARNING, fmt, ##__VA_ARGS__)
> +
>  /**
>   * Error output.
>   *
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
