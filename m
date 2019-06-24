Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8685CC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E3620663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WVw0EoU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfFXXFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:05:08 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33447 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFXXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:05:07 -0400
Received: by mail-ua1-f67.google.com with SMTP id f20so6365229ual.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUo1KrRDh5d7CTBF6eaNp9PxHrRcB6qM3gI926f1TeA=;
        b=WVw0EoU/h/EqUukaJvGtqujV+cXiSxfpwlH2O1mjOPjBOWZm7X31Fi0BEpRrTWYB9o
         o3CdLbtue0bwaz7Vgm1UpKlE0E0fSuldvTbmZ5qdmnnWwc+B2pMoaALrgyVv/folYTdx
         o5vrcJW2m//kZ2EHqvUqM4fL2R7S887YcxtaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUo1KrRDh5d7CTBF6eaNp9PxHrRcB6qM3gI926f1TeA=;
        b=hJZyUWLIpm1rFK8R9SKWuZiJXwkdhO5rkpjpchWHZuSI9kCyyWzLy17ntRlkYdJv6H
         1df8lr901RrnJorBSOra/zmjUv4hr8kqgF2gbX/fGXgNg6XVFQwbFcaJwJXnBA/P206N
         l83sO3IGpNNMlNTgXEwmxT/ORZISDhrWEKRey3xnvzouTyUeHYEwS+pLUwIlGoavioEy
         pBvhGBzW865kBvIgdllnmh2/6d+VjiCC896l1w1F9G6rFQwTGQts1eX4hOU/3f7lRxK4
         OpOmfwE8iYe4cRbiid3Ng3A/tlW0FMml+DIR72e/TMNCFgisJFetu0ZdQcveraET+FQ+
         54Zw==
X-Gm-Message-State: APjAAAUqPQkdWwekf+reiLUTejPoTZV/CwkwhYMueyLp+5GpcAgnQWkr
        pToJ6xifs5JtzxnkjHawV/+7pb9RNB8/0axzak2yDg2SXzQ=
X-Google-Smtp-Source: APXvYqzGrtkWF399TOCeEibm6SiwufJW+tbfw85UkDFZQy9sMXwWQnNPBCZCk62frDzlYpVuKPp8w75505JQWMBjpNM=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr30915038uad.15.1561417505834;
 Mon, 24 Jun 2019 16:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190622034105.188454-1-dbasehore@chromium.org> <20190622034105.188454-3-dbasehore@chromium.org>
In-Reply-To: <20190622034105.188454-3-dbasehore@chromium.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Mon, 24 Jun 2019 16:04:54 -0700
Message-ID: <CAGAzgsrhS_nsXqf83ivZS5qcfT+Ss0=pzshH_i2+-Hd1iVNgNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/panel: set display info in panel attach
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 8:41 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> Devicetree systems can set panel orientation via a panel binding, but
> there's no way, as is, to propagate this setting to the connector,
> where the property need to be added.
> To address this, this patch sets orientation, as well as other fixed
> values for the panel, in the drm_panel_attach function. These values
> are stored from probe in the drm_panel struct.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/gpu/drm/drm_panel.c | 28 ++++++++++++++++++++++++++++
>  include/drm/drm_panel.h     | 14 ++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 507099af4b57..5690fca30236 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -104,11 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
>   */
>  int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
>  {
> +       struct drm_display_info *info;
> +
>         if (panel->connector)
>                 return -EBUSY;
>
>         panel->connector = connector;
>         panel->drm = connector->dev;
> +       info = &connector->display_info;
> +       info->width_mm = panel->width_mm;
> +       info->height_mm = panel->height_mm;
> +       info->bpc = panel->bpc;
> +       info->panel_orientation = panel->orientation;
> +       info->bus_flags = panel->bus_flags;
> +       if (panel->bus_formats)
> +               drm_display_info_set_bus_formats(&connector->display_info,
> +                                                panel->bus_formats,
> +                                                panel->num_bus_formats);
>
>         return 0;
>  }
> @@ -128,6 +140,22 @@ EXPORT_SYMBOL(drm_panel_attach);
>   */
>  int drm_panel_detach(struct drm_panel *panel)
>  {
> +       struct drm_display_info *info;
> +
> +       if (!panel->connector)
> +               goto out;
> +
> +       info = &panel->connector->display_info;
> +       info->width_mm = 0;
> +       info->height_mm = 0;
> +       info->bpc = 0;
> +       info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +       info->bus_flags = 0;
> +       kfree(info->bus_formats);
> +       info->bus_formats = NULL;
> +       info->num_bus_formats = 0;
> +
> +out:
>         panel->connector = NULL;
>         panel->drm = NULL;
>
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 3564952f1a4f..760ca5865962 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -37,6 +37,8 @@ struct display_timing;
>   * struct drm_panel_funcs - perform operations on a given panel
>   * @disable: disable panel (turn off back light, etc.)
>   * @unprepare: turn off panel
> + * @detach: detach panel->connector (clear internal state, etc.)
> + * @attach: attach panel->connector (update internal state, etc.)
>   * @prepare: turn on panel and perform set up
>   * @enable: enable panel (turn on back light, etc.)
>   * @get_modes: add modes to the connector that the panel is attached to and
> @@ -93,6 +95,18 @@ struct drm_panel {
>
>         const struct drm_panel_funcs *funcs;
>
> +       /*
> +        * panel information to be set in the connector when the panel is
> +        * attached.
> +        */
> +       unsigned int width_mm;
> +       unsigned int height_mm;
> +       unsigned int bpc;
> +       int orientation;
> +       const u32 *bus_formats;
> +       unsigned int num_bus_formats;
> +       u32 bus_flags;

Should probably put these in a struct to ensure the connector and
panel have the same data types. Will do in a following patch if we
stay with this.

> +
>         struct list_head list;
>  };
>
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
