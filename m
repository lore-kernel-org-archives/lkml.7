Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62C6C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA4B2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TLtiOByY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfLDNKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:10:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50741 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfLDNKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:10:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so6962048wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ya3ULspfRCxqb9BJ+lx6dOJ4biNd6N6uQMSWdH/X0D0=;
        b=TLtiOByYiqqBKccq8pcm8/MxTUNlQqnIG0q25Qu4YEAvv/Q076tchnUAy4Oie3yuKF
         RgCMK4EKG+mz6y4jzNr+gdtAJk2ukGoyKei/9Tur8JBncaB/OyuUfWSkMrlLDM+gXx4H
         mOIPRcpVzdh/SJnkZ9UHQ4OlPtJdDtzoI1vnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ya3ULspfRCxqb9BJ+lx6dOJ4biNd6N6uQMSWdH/X0D0=;
        b=rP2wp0/HOQkGRoSaN6FeAlugLmVrr5eIeUFgmPwXUfTMUoTbxuP5RugL6DRU6Hm4Oz
         7n4NH01Re4SXBxP0Y6OMfcpCt92HVb0wOs7rvP4wWVOn3kQD4oKvXo+AGMkKNzRC+pUN
         QWbSwkYrsHz5pdswjDf73ai66mejKH5Ixk7J7Z1YisBWOuJaJ10/TPkVwxMsGNQJ8jhp
         1htWbMWfJRrRGOwtcITCz82M6jWcAqA5mtCVGfrnZdnRJ4u3TiFvHsj9T3tzwgIGtCSd
         sln1N/GDo5qHPz4V63v0Nop1qHVx/lQt4W5I9/fxeL2T3H0fnvk4v761Q93V+eo9HFRx
         dW+w==
X-Gm-Message-State: APjAAAXaHfIbMdPpUHUyblSK3ybMcoaSKFGUFPUbQdKqJc0yv/wB40uP
        ibhpsxGujUXe8VzbV2UqaU4u2Q==
X-Google-Smtp-Source: APXvYqyQBy6592ScOME/ngkja2wqo9+13JFobmHRZmXuTp4Zb4qokOGf8zh8oomBaXZ//Qm01GI/hA==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr37626595wmj.58.1575465018010;
        Wed, 04 Dec 2019 05:10:18 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id e16sm8132348wrj.80.2019.12.04.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 05:10:17 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:10:15 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/28] drm: Introduce drm_bridge_init()
Message-ID: <20191204131015.GM624164@phenom.ffwll.local>
Mail-Followup-To: Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
 <20191204114732.28514-2-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204114732.28514-2-mihail.atanassov@arm.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 11:48:02AM +0000, Mihail Atanassov wrote:
> A simple convenience function to initialize the struct drm_bridge. The
> goal is to standardize initialization for any bridge registered with
> drm_bridge_add() so that we can later add device links for consumers of
> those bridges.
> 
> v2:
>  - s/WARN_ON(!funcs)/WARN_ON(!funcs || !dev)/ as suggested by Daniel
>  - expand on some kerneldoc comments as suggested by Daniel
>  - update commit message as suggested by Daniel
> 
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_bridge.c | 34 +++++++++++++++++++++++++++++++++-
>  include/drm/drm_bridge.h     | 15 ++++++++++++++-
>  2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index cba537c99e43..50e1c1b46e20 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -64,7 +64,10 @@ static DEFINE_MUTEX(bridge_lock);
>  static LIST_HEAD(bridge_list);
>  
>  /**
> - * drm_bridge_add - add the given bridge to the global bridge list
> + * drm_bridge_add - add the given bridge to the global bridge list.
> + *
> + * Drivers should call drm_bridge_init() prior adding it to the list.
> + * Drivers should call drm_bridge_remove() to clean up the bridge list.
>   *
>   * @bridge: bridge control structure
>   */
> @@ -89,6 +92,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_remove);
>  
> +/**
> + * drm_bridge_init - initialise a drm_bridge structure
> + *
> + * @bridge: bridge control structure
> + * @funcs: control functions
> + * @dev: device associated with this drm_bridge
> + * @timings: timing specification for the bridge; optional (may be NULL)
> + * @driver_private: pointer to the bridge driver internal context (may be NULL)
> + */
> +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> +		     const struct drm_bridge_funcs *funcs,
> +		     const struct drm_bridge_timings *timings,
> +		     void *driver_private)
> +{
> +	WARN_ON(!funcs || !dev);
> +
> +	bridge->dev = NULL;
> +	bridge->encoder = NULL;
> +	bridge->next = NULL;
> +
> +#ifdef CONFIG_OF
> +	bridge->of_node = dev->of_node;
> +#endif
> +	bridge->timings = timings;
> +	bridge->funcs = funcs;
> +	bridge->driver_private = driver_private;
> +}
> +EXPORT_SYMBOL(drm_bridge_init);
> +
>  /**
>   * drm_bridge_attach - attach the bridge to an encoder's chain
>   *
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index c0a2286a81e9..949e4f401a53 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -373,7 +373,16 @@ struct drm_bridge_timings {
>  };
>  
>  /**
> - * struct drm_bridge - central DRM bridge control structure
> + * struct drm_bridge - central DRM bridge control structure.
> + *
> + * Bridge drivers should call drm_bridge_init() to initialize a bridge
> + * driver, and then register it with drm_bridge_add().
> + *
> + * Users of bridges link a bridge driver into their overall display output
> + * pipeline by calling drm_bridge_attach().
> + *
> + * Modular drivers in OF systems can query the list of registered bridges
> + * with of_drm_find_bridge().
>   */
>  struct drm_bridge {
>  	/** @dev: DRM device this bridge belongs to */
> @@ -402,6 +411,10 @@ struct drm_bridge {
>  
>  void drm_bridge_add(struct drm_bridge *bridge);
>  void drm_bridge_remove(struct drm_bridge *bridge);
> +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> +		     const struct drm_bridge_funcs *funcs,
> +		     const struct drm_bridge_timings *timings,
> +		     void *driver_private);
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
>  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  		      struct drm_bridge *previous);
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
