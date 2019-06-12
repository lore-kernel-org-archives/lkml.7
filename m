Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4473AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D8A21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393684AbfFMRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:17:40 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:38705 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfFLVSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:18:16 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 187362001E;
        Wed, 12 Jun 2019 23:18:09 +0200 (CEST)
Date:   Wed, 12 Jun 2019 23:18:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/5] drm/panel: Add helper for reading DT rotation
Message-ID: <20190612211807.GA13155@ravnborg.org>
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-2-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611040350.90064-2-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8
        a=Ikd4Dj_1AAAA:8 a=t_KA93f0VNsUmkpjo_oA:9 a=CjuIK1q_8ugA:10
        a=xmb-EsYY8bH0VWELuYED:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek.

On Mon, Jun 10, 2019 at 09:03:46PM -0700, Derek Basehore wrote:
> This adds a helper function for reading the rotation (panel
> orientation) from the device tree.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/gpu/drm/drm_panel.c | 41 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_panel.h     |  7 +++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index dbd5b873e8f2..3b689ce4a51a 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -172,6 +172,47 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
>  	return ERR_PTR(-EPROBE_DEFER);
>  }
>  EXPORT_SYMBOL(of_drm_find_panel);
> +
> +/**
> + * of_drm_get_panel_orientation - look up the rotation of the panel using a
> + * device tree node
> + * @np: device tree node of the panel
> + * @orientation: orientation enum to be filled in
The comment says "enum" but the type used is an int.
Why not use enum drm_panel_orientation?

> + *
> + * Looks up the rotation of a panel in the device tree. The rotation in the
> + * device tree is counter clockwise.
> + *
> + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> + * rotation property doesn't exist. -EERROR otherwise.
> + */
Initially I read -EEROOR as a specific error code.
But I gues the semantic is to say that a negative error code is returned
if something was wrong.
As we do not use the "-EERROR" syntax anywhere else in drm, please
reword like we do in other places.


Also - it is worth to mention that the rotation returned is
DRM_MODE_PANEL_ORIENTATION_UNKNOWN if the property is not specified.
I wonder if this is correct, as no property could also been
interpretated as DRM_MODE_PANEL_ORIENTATION_NORMAL.
And in most cases the roation property is optional, so one could
assume that no property equals 0 degree.


	Sam

> +int of_drm_get_panel_orientation(const struct device_node *np, int *orientation)
> +{
> +	int rotation, ret;
> +
> +	ret = of_property_read_u32(np, "rotation", &rotation);
> +	if (ret == -EINVAL) {
> +		/* Don't return an error if there's no rotation property. */
> +		*orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +		return 0;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (rotation == 0)
> +		*orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
> +	else if (rotation == 90)
> +		*orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
> +	else if (rotation == 180)
> +		*orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
> +	else if (rotation == 270)
> +		*orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(of_drm_get_panel_orientation);
>  #endif
>  
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 8c738c0e6e9f..13631b2efbaa 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -197,11 +197,18 @@ int drm_panel_detach(struct drm_panel *panel);
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
>  struct drm_panel *of_drm_find_panel(const struct device_node *np);
> +int of_drm_get_panel_orientation(const struct device_node *np,
> +				 int *orientation);
>  #else
>  static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> +int of_drm_get_panel_orientation(const struct device_node *np,
> +				 int *orientation)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif
> -- 
> 2.22.0.rc2.383.gf4fbbf30c2-goog
