Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4BAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B854B2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K8BKL5ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfKZOfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:35:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56038 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:35:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so3435440wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTh3/Ue9+Bd/S+4Qjg7rRHgrBCqsmuaM2m1qVNN+rXM=;
        b=K8BKL5ng6W/sTJDdwwzFnVvRSSJdz0Ersv9Drs+4vB6hl6Q9O7PHxOsVzqZliHSz3F
         BfLABQLoNxG3behx7JOFco8vei5l8QDEWBz6+E7V7WmAvCGhMIulGybkLJkGWAVQfw4S
         iIefzzOJgunuhyGY+YUeexOj6m4KwlbGSk79s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tTh3/Ue9+Bd/S+4Qjg7rRHgrBCqsmuaM2m1qVNN+rXM=;
        b=glthpgpt4VKg2p9jmKjvTxC9WzJmJ3svaucTqKbyckND60rUH4LMgRdlyhJZDhiUFA
         8x5y2yDxgrid134lvJfLEoMqtnUFUlR0j7UQRlr6KOGv1r4F6DYZMqasvUDqK79owxoK
         Bojptk6JdsFEz/1mMWMoHRsZFOyo4+e3men/WfBHbXPNKiuZI20e1lc43HBByXfhHfqE
         fnCVIhbeXUnWtfeJgAw+01hDmPR1QFWaToQYMILKk+R9MJk/ht3W5e49Nj4hYlO5LYLF
         1xNlKURqqZwuoipjGVZxE8EXVV0UT3MTyXtq1kGCqbRaSc9TWR4MVLnzdzYQ0HG/4iO9
         pTfg==
X-Gm-Message-State: APjAAAUl4aNFWPhCEZzR+S8QPCJp8Bs8NzOY+pSfj8blPglaBO9MxEQx
        KtJ/2IacHIdo+KqQBs5fIQOx0w==
X-Google-Smtp-Source: APXvYqxwwHxSf01sW4NjpO4UPUnU6bELFb8Pk+GebU1lihLOImY6wYeT9Gd2cGTOwPwKXjXKcBic7w==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr4533786wml.65.1574778936879;
        Tue, 26 Nov 2019 06:35:36 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id 60sm14559560wrn.86.2019.11.26.06.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:35:36 -0800 (PST)
Date:   Tue, 26 Nov 2019 15:35:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 29/30] drm/bridge: add support for device links to bridge
Message-ID: <20191126143534.GW29965@phenom.ffwll.local>
Mail-Followup-To: Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-30-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126131541.47393-30-mihail.atanassov@arm.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 01:16:26PM +0000, Mihail Atanassov wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Bridge devices have been a potential for kernel oops as their lifetime
> is independent of the DRM device that they are bound to.  Hence, if a
> bridge device is unbound while the parent DRM device is using them, the
> parent happily continues to use the bridge device, calling the driver
> and accessing its objects that have been freed.
> 
> This can cause kernel memory corruption and kernel oops.
> 
> To control this, use device links to ensure that the parent DRM device
> is unbound when the bridge device is unbound, and when the bridge
> device is re-bound, automatically rebind the parent DRM device.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Tested-by: Mihail Atanassov <mihail.atanassov@arm.com>
> [reworked to use drm_bridge_init() for setting bridge->device]
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

So I thought the big plan was to put the device_link setup into
drm_bridge_attach, so that it's done for everyone. And we could then
slowly go through the existing drivers that use the component framework to
get this handled correctly.

So my questions:
- is there a problem if we add the device_link for everyone?
- is there an issue if we only add it at drm_bridge_attach time? I kinda
  assumed that it's not needed before that (EPROBE_DEFER should handle
  load dependencies as before), but it could be that some drivers ask for
  a bridge and then check more stuff and then drop the bridge without
  calling drm_bridge_attach. We probably don't have a case like this yet,
  but better robust than sorry.

Anyway, I scrolled through the bridge patches, looked all good, huge
thanks for tackling this! Once we have some agreement on the bigger
questions here I'll try to go through them and review.

Cheers, Daniel
> ---
>  drivers/gpu/drm/drm_bridge.c | 49 ++++++++++++++++++++++++++----------
>  include/drm/drm_bridge.h     |  4 +++
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index cbe680aa6eac..e1f8db84651a 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_device.h>
>  #include <drm/drm_encoder.h>
>  
>  #include "drm_crtc_internal.h"
> @@ -109,6 +110,7 @@ void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
>  	bridge->encoder = NULL;
>  	bridge->next = NULL;
>  
> +	bridge->device = dev;
>  #ifdef CONFIG_OF
>  	bridge->of_node = dev->of_node;
>  #endif
> @@ -492,6 +494,32 @@ void drm_atomic_bridge_enable(struct drm_bridge *bridge,
>  EXPORT_SYMBOL(drm_atomic_bridge_enable);
>  
>  #ifdef CONFIG_OF
> +static struct drm_bridge *drm_bridge_find(struct drm_device *dev,
> +					  struct device_node *np, bool link)
> +{
> +	struct drm_bridge *bridge, *found = NULL;
> +	struct device_link *dl;
> +
> +	mutex_lock(&bridge_lock);
> +
> +	list_for_each_entry(bridge, &bridge_list, list)
> +		if (bridge->of_node == np) {
> +			found = bridge;
> +			break;
> +		}
> +
> +	if (found && link) {
> +		dl = device_link_add(dev->dev, found->device,
> +				     DL_FLAG_AUTOPROBE_CONSUMER);
> +		if (!dl)
> +			found = NULL;
> +	}
> +
> +	mutex_unlock(&bridge_lock);
> +
> +	return found;
> +}
> +
>  /**
>   * of_drm_find_bridge - find the bridge corresponding to the device node in
>   *			the global bridge list
> @@ -503,21 +531,16 @@ EXPORT_SYMBOL(drm_atomic_bridge_enable);
>   */
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  {
> -	struct drm_bridge *bridge;
> -
> -	mutex_lock(&bridge_lock);
> -
> -	list_for_each_entry(bridge, &bridge_list, list) {
> -		if (bridge->of_node == np) {
> -			mutex_unlock(&bridge_lock);
> -			return bridge;
> -		}
> -	}
> -
> -	mutex_unlock(&bridge_lock);
> -	return NULL;
> +	return drm_bridge_find(NULL, np, false);
>  }
>  EXPORT_SYMBOL(of_drm_find_bridge);
> +
> +struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
> +					      struct device_node *np)
> +{
> +	return drm_bridge_find(dev, np, true);
> +}
> +EXPORT_SYMBOL(of_drm_find_bridge_devlink);
>  #endif
>  
>  MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index d6d9d5301551..68b27c69cc3d 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -382,6 +382,8 @@ struct drm_bridge {
>  	struct drm_encoder *encoder;
>  	/** @next: the next bridge in the encoder chain */
>  	struct drm_bridge *next;
> +	/** @device: Linux driver model device */
> +	struct device *device;
>  #ifdef CONFIG_OF
>  	/** @of_node: device node pointer to the bridge */
>  	struct device_node *of_node;
> @@ -407,6 +409,8 @@ void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
>  		     const struct drm_bridge_timings *timings,
>  		     void *driver_private);
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
> +struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
> +					      struct device_node *np);
>  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  		      struct drm_bridge *previous);
>  
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
