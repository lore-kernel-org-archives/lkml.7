Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F68C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E90D2067B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="fxB9cPqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJGQiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:38:25 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38678 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfJGQiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:38:25 -0400
Received: by mail-yb1-f194.google.com with SMTP id k10so1689621ybs.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FzqVNr7tcxlwpcYADlhda0qZOie+lz7LOX/589zfMus=;
        b=fxB9cPqg4HqUGdYDivJJPdLacJmb3vp4VEHC//Z5ObTlsNu+ii6NbHEEOfwrQeRYHX
         rk9Jb8c/1D5BKy/LV/oDJUA6MnC9WVmwmt3fSMpUNLRxWG7ZP3rRNW4/ClVWqlZbovZy
         As3Gj9d4k//dQ6J9KSx8hENX+9aQYBCkzmyixVJHF7sf7hj6lmE9pUqAM43YZOgedk1y
         eawFwM01quT63JTy3IF4txAahS6VVT4G3O1ZwheamhN+J4JnEqmVqpUwPmZxqwgvAOzM
         I7psY1x+jCMxZFFJuHBb0X2S9SPae9WZjlXUS1+DbdH7W4YHGmcjuUR0yuC9HHwjsVvw
         tZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FzqVNr7tcxlwpcYADlhda0qZOie+lz7LOX/589zfMus=;
        b=W9iOQQzIV4zc80zfX9ownULhNcVA6/ACfLt6JkewpEeYGhe13CL1pkHFVNZSUwwxTo
         r8HqstXH5/0rudOaTxTmVX8vlEM8qIhlAO0bkrr1kESdEwePOhSAm3r0KqnoogMiMUMC
         2nCAJeX4SRf34hNTodsCcghrgw43W1k1J9W0wR0ltAHO6OSNb+ba49mOjGaqScRUyIb7
         D8kKKE6PixFcYLCiVXE2ZXgw4AHVUi0hKxTwGK8raL+ghYpbx1Ts8oD3YzTfan+CHGrH
         fn+/Q7ruMVhwTmcSRpiYRhPLHMtKPVvV900IOuAZv4auBmlCrUHmy7BfIShcxfOoP+Gh
         0QvA==
X-Gm-Message-State: APjAAAXPtYOLlOQ1IbJ9Xqz/ydCgcO29Ce+u59MZQmaHkKimBpxDUwuZ
        6mfTfx/F8ZbFbKPlyo2KcgXP4w==
X-Google-Smtp-Source: APXvYqww9OLyqPatL8zc7IngE43C3NP4GfhRl0dthKOPI8ogAAGGRmA5omVo9qg/Jiq5DILIRaCmMg==
X-Received: by 2002:a25:bfc3:: with SMTP id q3mr4652388ybm.507.1570466303991;
        Mon, 07 Oct 2019 09:38:23 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id g20sm3932702ywe.98.2019.10.07.09.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:38:23 -0700 (PDT)
Date:   Mon, 7 Oct 2019 12:38:22 -0400
From:   Sean Paul <sean@poorly.run>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 1/4] drm/panel: Add helper for reading DT rotation
Message-ID: <20191007163822.GA126146@art_vandelay>
References: <20190925225833.7310-1-dbasehore@chromium.org>
 <20190925225833.7310-2-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925225833.7310-2-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:58:30PM -0700, Derek Basehore wrote:
> This adds a helper function for reading the rotation (panel
> orientation) from the device tree.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

The patch LGTM, but I don't see it used anywhere later in the patch? Is there a
panel driver incoming?

Sean

> ---
>  drivers/gpu/drm/drm_panel.c | 43 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_panel.h     |  9 ++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 6b0bf42039cf..0909b53b74e6 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -264,6 +264,49 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
>  	return ERR_PTR(-EPROBE_DEFER);
>  }
>  EXPORT_SYMBOL(of_drm_find_panel);
> +
> +/**
> + * of_drm_get_panel_orientation - look up the orientation of the panel through
> + * the "rotation" binding from a device tree node
> + * @np: device tree node of the panel
> + * @orientation: orientation enum to be filled in
> + *
> + * Looks up the rotation of a panel in the device tree. The orientation of the
> + * panel is expressed as a property name "rotation" in the device tree. The
> + * rotation in the device tree is counter clockwise.
> + *
> + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> + * rotation property doesn't exist. -EERROR otherwise.
> + */
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
> index 624bd15ecfab..d16158deacdc 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -34,6 +34,8 @@ struct drm_device;
>  struct drm_panel;
>  struct display_timing;
>  
> +enum drm_panel_orientation;
> +
>  /**
>   * struct drm_panel_funcs - perform operations on a given panel
>   *
> @@ -165,11 +167,18 @@ int drm_panel_get_modes(struct drm_panel *panel);
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
> +static inline int of_drm_get_panel_orientation(const struct device_node *np,
> +		enum drm_panel_orientation *orientation)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif
> -- 
> 2.23.0.351.gc4317032e6-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
