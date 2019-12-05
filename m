Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B817C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD6521823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Om+jGb6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfLEMkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:40:32 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:60754 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEMkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:40:31 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 133182E5;
        Thu,  5 Dec 2019 13:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1575549629;
        bh=4t62tO3hAEzg4VyyZFBo9HwlULB/1/03jaZKqCnIwcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Om+jGb6vA2fWUhD45A1KuG3sf+5G0dgeBA4h+qDaDcPaBPD34QAEaB5hB1EwYYrx2
         y8sgb/qXemVuPeB+leFbQRj3pGH9697LvfY5wLlT5VKsUwXdxg7BaT7HnS2mu7/iIg
         jY3C79YzOWFQ/FCDIc+8Shy6gJ/YVZZYpIZU/rbQ=
Date:   Thu, 5 Dec 2019 14:40:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 01/28] drm: Introduce drm_bridge_init()
Message-ID: <20191205124022.GA16034@pendragon.ideasonboard.com>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
 <20191204114732.28514-2-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191204114732.28514-2-mihail.atanassov@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail,

Thank you for the patch.

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

You add a final period here and in the documentation of struct
drm_bridge, but the new function you're adding doesn't have one :-) I'd
drop the period here and for drm_bridge to be consistent with the rest
of the code.

> + *
> + * Drivers should call drm_bridge_init() prior adding it to the list.

s/should/shall/
s/prior adding it/prior to adding the bridge/

> + * Drivers should call drm_bridge_remove() to clean up the bridge list.

I'd replace this sentence with "Before deleting a bridge (usually when
the driver is unbound from the device), drivers shall call
drm_bridge_remove() to remove it from the global list."

>   *
>   * @bridge: bridge control structure
>   */
> @@ -89,6 +92,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_remove);
>  
> +/**
> + * drm_bridge_init - initialise a drm_bridge structure

initialise or initialize ? :-)

> + *
> + * @bridge: bridge control structure
> + * @funcs: control functions
> + * @dev: device associated with this drm_bridge

dev goes before funcs

> + * @timings: timing specification for the bridge; optional (may be NULL)
> + * @driver_private: pointer to the bridge driver internal context (may be NULL)

I'm not too sure about the last two parameters. Having NULL, NULL in
most callers is confusing, and having a void * as one of the parameters
means that the compiler won't catch errors if the two parameters are
reversed. I think this is quite error prone.

There are very few drivers using driver_private (I count 6 of them, with
2 additional drivers that set driver_private but never use it). How
about embedding the bridge structure in those 6 drivers and getting rid
of the field altogether ? This could be part of a separate series, but
in any case I'd drop driver_private from drm_bridge_init().

> + */
> +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> +		     const struct drm_bridge_funcs *funcs,
> +		     const struct drm_bridge_timings *timings,
> +		     void *driver_private)
> +{
> +	WARN_ON(!funcs || !dev);
> +
> +	bridge->dev = NULL;

NULL ? Shouldn't this be dev ?

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

s/bridge driver/bridge structure/ (or drm_bridge structure)

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

-- 
Regards,

Laurent Pinchart
