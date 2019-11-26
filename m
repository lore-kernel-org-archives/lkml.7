Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3079C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8B620727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ckigHzDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfKZO0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:26:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40009 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfKZO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:26:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id y5so3530248wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDBMx84MNQ4JO1hOAPTWtTE8IwzW6f/UIE56/wZs544=;
        b=ckigHzDJM2lagyXYX15JNGg4QSX3se9I/QNfqOg+vB//dBNRthqtxEyOZJjEelqAng
         GySlW0UuMvc7r+pIVgtzr83Wsngpci+bO1KR5nFd2PgFsWbcKGZ0TcdLsdTIA9RRBaWs
         hMwjTMprb4aeW3Q/dFVa5lBxDSViMoulM9PV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hDBMx84MNQ4JO1hOAPTWtTE8IwzW6f/UIE56/wZs544=;
        b=W3trPHTmIlLJOPrCZWgcxFtuAPkBEB4UNxm6Igh8M70OQ/OEK8qjC7bZjEtp2Gvpe0
         oZ2BptXvRghvgmtQU5EkCTygBU2FPWNzrdWaD5E017ClIu1GqMwVAPcGVjh+MBcVqwov
         o4x60OJsc5zMZWB3t+PlIJk9kO001iXpyrpZzj92C6DCuucnJ2AqLfz5lMV5q4NHh+kJ
         SQFRhYYKk+EzTEAXJzUBhqNkvVCOdamyD+rpDMH7wmdJZVsNnKvqIbLp6vr4vACzJrod
         81wY4xyJf8ZA3rabP8IMIvJHurSZdLbxw9D850vCxeByvSAxQiYMncHsSrNl7e1O60FL
         QfIg==
X-Gm-Message-State: APjAAAV3lFroj0FOMd97zoUD+xNAEWfPO6wRSAlL3hEPh9waQpaweM0a
        V1bqMnkw5NPaIB5EnGOLjCdAUQ==
X-Google-Smtp-Source: APXvYqw3mMqV/EKHUOc8n4CFqdLeiNZt0HctyQ9zHZyM94EzbolvWs2Jy8VO1O3B47x0kHSq8nFgKg==
X-Received: by 2002:a1c:ca:: with SMTP id 193mr4532398wma.111.1574778373388;
        Tue, 26 Nov 2019 06:26:13 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j10sm14979375wrx.30.2019.11.26.06.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:26:12 -0800 (PST)
Date:   Tue, 26 Nov 2019 15:26:10 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/30] drm: Introduce drm_bridge_init()
Message-ID: <20191126142610.GV29965@phenom.ffwll.local>
Mail-Followup-To: Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-2-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126131541.47393-2-mihail.atanassov@arm.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 01:15:59PM +0000, Mihail Atanassov wrote:
> A simple convenience function to initialize the struct drm_bridge.
> 
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

The commit message here leaves figuring out why we need this to the
reader. Reading ahead the reasons seems to be to roll out bridge->dev
setting for everyone, so that we can set the device_link. Please explain
that in the commit message so the patch is properly motivated.

> ---
>  drivers/gpu/drm/drm_bridge.c | 29 +++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     |  4 ++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index cba537c99e43..cbe680aa6eac 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -89,6 +89,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_remove);
>  
> +/**
> + * drm_bridge_init - initialise a drm_bridge structure
> + *
> + * @bridge: bridge control structure
> + * @funcs: control functions
> + * @dev: device
> + * @timings: timing specification for the bridge; optional (may be NULL)
> + * @driver_private: pointer to the bridge driver internal context (may be NULL)

Please also sprinkle some links to this new function to relevant places,
I'd add at least:

"Drivers should call drm_bridge_init() first." to the kerneldoc for
drm_bridge_add. drm_bridge_add should also mention drm_bridge_remove as
the undo function.

And perhaps a longer paragraph to &struct drm_bridge:

"Bridge drivers should call drm_bridge_init() to initialized a bridge
driver, and then register it with drm_bridge_add().

"Users of bridges link a bridge driver into their overall display output
pipeline by calling drm_bridge_attach()."

> + */
> +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> +		     const struct drm_bridge_funcs *funcs,
> +		     const struct drm_bridge_timings *timings,
> +		     void *driver_private)
> +{
> +	WARN_ON(!funcs);
> +
> +	bridge->dev = NULL;

Given that the goal here is to get bridge->dev set up, why not

	WARN_ON(!dev);
	bridge->dev = dev;

That should help us to really move forward with all this.
-Daniel

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
> index c0a2286a81e9..d6d9d5301551 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -402,6 +402,10 @@ struct drm_bridge {
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
