Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14159C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FF6218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfCON2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:28:06 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56263 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCON2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:28:06 -0400
X-Originating-IP: 90.88.22.102
Received: from aptenodytes (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 924E4C0016;
        Fri, 15 Mar 2019 13:27:57 +0000 (UTC)
Message-ID: <c52be751ac1bc7b1ee21e3e2a30d5b494bf95faa.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH 1/6] drm/bridge: Export drm_bridge_detach
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     jagan@amarulasolutions.com, Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Date:   Fri, 15 Mar 2019 14:27:57 +0100
In-Reply-To: <20190315130825.9005-2-jagan@amarulasolutions.com>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
         <20190315130825.9005-2-jagan@amarulasolutions.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakan,

On Fri, 2019-03-15 at 18:38 +0530, Jagan Teki wrote:
> Export drm_bridge_detach from drm bridge core so-that it
> can use on respective interface or bridge driver while
> detaching the bridge.

I don't see why this change is required based on the commit log. The
DRM bridge code clearly indicates that drm_bridge_attach should *not*
be balanced with a drm_bridge_detach call in the driver, so this seems
quite wrong.

The DRM core itself should handle detaching the bridge, not the driver.
Is there any reason why you need to do things differently for DSI?

Cheers,

Paul

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 1 +
>  include/drm/drm_bridge.h     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 138b2711d389..569d4f345429 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -159,6 +159,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  
>  	bridge->dev = NULL;
>  }
> +EXPORT_SYMBOL(drm_bridge_detach);
>  
>  /**
>   * DOC: bridge callbacks
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 9da8c93f7976..4955e3e50fa4 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -301,6 +301,7 @@ void drm_bridge_remove(struct drm_bridge *bridge);
>  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
>  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  		      struct drm_bridge *previous);
> +void drm_bridge_detach(struct drm_bridge *bridge);
>  
>  bool drm_bridge_mode_fixup(struct drm_bridge *bridge,
>  			   const struct drm_display_mode *mode,
> -- 
> 2.18.0.321.gffc6fa0e3
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

