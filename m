Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4143520663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfFXUgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:36:46 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37636 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbfFXUgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:36:45 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 9A6F28032A;
        Mon, 24 Jun 2019 22:36:38 +0200 (CEST)
Date:   Mon, 24 Jun 2019 22:36:32 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/4] drm/panel: Add helper for reading DT rotation
Message-ID: <20190624203632.GA12316@ravnborg.org>
References: <20190622034105.188454-1-dbasehore@chromium.org>
 <20190622034105.188454-2-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622034105.188454-2-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8
        a=Ikd4Dj_1AAAA:8 a=hD3m9dJnucmI1XD2aicA:9 a=CjuIK1q_8ugA:10
        a=xmb-EsYY8bH0VWELuYED:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek.

On Fri, Jun 21, 2019 at 08:41:02PM -0700, Derek Basehore wrote:
> This adds a helper function for reading the rotation (panel
> orientation) from the device tree.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/gpu/drm/drm_panel.c | 42 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_panel.h     |  7 +++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index dbd5b873e8f2..507099af4b57 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -172,6 +172,48 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
>  	return ERR_PTR(-EPROBE_DEFER);
>  }
>  EXPORT_SYMBOL(of_drm_find_panel);
> +
> +/**
> + * of_drm_get_panel_orientation - look up the rotation of the panel using a
> + * device tree node
> + * @np: device tree node of the panel
> + * @orientation: orientation enum to be filled in
> + *
> + * Looks up the rotation of a panel in the device tree. The rotation in the
> + * device tree is counter clockwise.
> + *
> + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> + * rotation property doesn't exist. -EERROR otherwise.
> + */
This function should better spell out why it talks about rotation versus
orientation.

It happens that orientation, due to bad design choices is named rotation
in DT.
But then this function is all about orientation, that just happens to be
named rotation in DT.
And the comments associated to the function should reflect this.

something like:
/**
 * of_drm_get_panel_orientation - look up the orientation of the panel using a
 * device tree node
 * @np: device tree node of the panel
 * @orientation: orientation enum to be filled in
 *
 * Looks up the rotation property of a panel in the device tree.
 * The orientation of the panel is expressed as a property named
 * "rotation" in the device tree.
 * The rotation in the device tree is counter clockwise.
 *
 * Return: 0 when a valid orientation value (0, 90, 180, or 270) is read or the
 * rotation property doesn't exist. -EERROR otherwise.
 */

This would at least remove some of my confusiuon.
And then maybe add a bit more explanation to the binding property
description too.

	Sam












> +int of_drm_get_panel_orientation(const struct device_node *np,
> +				 enum drm_panel_orientation *orientation)
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
> index 8c738c0e6e9f..3564952f1a4f 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -197,11 +197,18 @@ int drm_panel_detach(struct drm_panel *panel);
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
>  struct drm_panel *of_drm_find_panel(const struct device_node *np);
> +int of_drm_get_panel_orientation(const struct device_node *np,
> +				 enum drm_panel_orientation *orientation);
>  #else
>  static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> +int of_drm_get_panel_orientation(const struct device_node *np,
> +				 enum drm_panel_orientation *orientation)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
