Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89323C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4538820848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZkHnAqTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgAGVy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:54:29 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:46764 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgAGVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:54:28 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DCFC952F;
        Tue,  7 Jan 2020 22:54:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1578434067;
        bh=/4v7koUSMGC22Tz+qpJKBEp5rFtTL7KHEEbwdvvlN1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkHnAqTKHEBCvE2W9mvM6wOJtvLqn2Udrn3ptppoH6KMRBF4QX01rbOseGJKsm2on
         3uqKUKnsU/aHnDLqsNu0h8qv7e3zsMyDLAnMA6HEt30VmmdDbsO9jBQkkqahMP2xue
         VkfAirHmSgCx16n6uaa0RP7wz2T5VtXfNDuioJ5g=
Date:   Tue, 7 Jan 2020 23:54:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: of: fix link error
Message-ID: <20200107215414.GA7869@pendragon.ideasonboard.com>
References: <20200107213738.635906-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107213738.635906-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Tue, Jan 07, 2020 at 10:37:32PM +0100, Arnd Bergmann wrote:
> The new dummy helper is non-static, so every driver gets
> its own copy, leading to a link failure:
> 
> drivers/gpu/drm/imx/imx-ldb.o: In function `drm_of_lvds_get_dual_link_pixel_order':
> imx-ldb.c:(.text+0x140): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
> drivers/gpu/drm/imx/imx-drm-core.o:imx-drm-core.c:(.text+0x330): first defined here
> drivers/gpu/drm/imx/dw_hdmi-imx.o: In function `drm_of_lvds_get_dual_link_pixel_order':
> dw_hdmi-imx.c:(.text+0xd0): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
> drivers/gpu/drm/imx/imx-drm-core.o:imx-drm-core.c:(.text+0x330): first defined here
> drivers/gpu/drm/bridge/synopsys/dw-hdmi.o: In function `drm_of_lvds_get_dual_link_pixel_order':
> dw-hdmi.c:(.text+0x3b90): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
> drivers/gpu/drm/imx/imx-drm-core.o:imx-drm-core.c:(.text+0x330): first defined here
> drivers/gpu/drm/etnaviv/etnaviv_drv.o: In function `drm_of_lvds_get_dual_link_pixel_order':
> etnaviv_drv.c:(.text+0x9d0): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
> drivers/gpu/drm/imx/imx-drm-core.o:imx-drm-core.c:(.text+0x330): first defined here
> 
> Add the missing 'static' keyword.
> 
> Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've sent "[PATCH] drm: of: Fix linking when CONFIG_OF is not set" to
fix this issue, back on December the 19th. Daniel, Dave, could you pick
this up ? It couldn't be merged through drm-misc last time we checked as
the offending patch wasn't there.

> ---
>  include/drm/drm_of.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
> index 8ec7ca6d2369..3398be966021 100644
> --- a/include/drm/drm_of.h
> +++ b/include/drm/drm_of.h
> @@ -92,7 +92,7 @@ static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
>  	return -EINVAL;
>  }
>  
> -int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
> +static inline int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
>  					  const struct device_node *port2)
>  {
>  	return -EINVAL;

-- 
Regards,

Laurent Pinchart
