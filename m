Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2A3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E3821880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QjMnrXve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfGXWPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:15:33 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37144 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfGXWPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:15:32 -0400
Received: by mail-ua1-f66.google.com with SMTP id z13so19067164uaa.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6iTGbrUj20I8zXniTeQ544bNCuLGyZB+YlcvBGsDjw=;
        b=QjMnrXveL05m7SHFOkDi+a02nbwWABa8uU8sNtH30U4t6yef45p+bYczQ9t7NU/950
         mTkzHvr0KUu9Gz63UOr+C9TUeTOcrYKzHzRbGoLZrL02mYYBlsT+wdqezNU65Lmixk/C
         UBThtKqkwyQehSA5xllnpBSs2w4OYjl1HLulM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6iTGbrUj20I8zXniTeQ544bNCuLGyZB+YlcvBGsDjw=;
        b=ovRAPvK6wTcKynBYxxYmH5Tp0eooXmOX0Mfx1Zo/MXP84cyahbGgzVeKGTgMlONSHw
         SokSMkA5NuUXHr7xBEtOHAB1z+4txbdREglBUaC2v3NynS2renimkW8gz4Di2QzgKPTG
         usXRm03XrfiUyEaLEsGDviTCOgWIhPtIJxhtwJ159+GOfscOnGXzi5hoql95qagmtKcj
         ieFNT8nBVnjgTOkew4oVgqVm+citWxDrZzbdsBpE8T4RoBTpdBLmq8eE3mB4kizhmvb6
         /xGGxSvKEaq8Ymj0srTpDXoKebzCTv0Pdby1iVBuCiPmTbM02Xer92qClgSy4HIQ4hO0
         rKsw==
X-Gm-Message-State: APjAAAXlbWFSL5AH7WQQSH4SZ9UZdp2vUrbCpwQYauwtVOOEKD7Lax/+
        Ej5NSrGZb52niGL05grPfW6ppRjxQzRXyQXSdC0Oww==
X-Google-Smtp-Source: APXvYqx7BFn9iOZ2wlwR0mjBuA9rIFMZM3RWFpJKuC+0oBv8yw1N5p6TIxqSauPfez/DPzzJ4xYri1jiwaditw5mz3E=
X-Received: by 2002:ab0:614d:: with SMTP id w13mr34675942uan.66.1564006530811;
 Wed, 24 Jul 2019 15:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190710021659.177950-1-dbasehore@chromium.org>
 <20190710021659.177950-3-dbasehore@chromium.org> <20190723091945.GD787@ravnborg.org>
In-Reply-To: <20190723091945.GD787@ravnborg.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Wed, 24 Jul 2019 15:15:19 -0700
Message-ID: <CAGAzgsonxAcOLxPSoP6Swab+AFPxWaxmC_tg87J=6Nes_awACg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] drm/panel: set display info in panel attach
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, Sean Paul <sean@poorly.run>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, thanks for pointing out the potential conflict.

On Tue, Jul 23, 2019 at 2:19 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Derek.
>
> On Tue, Jul 09, 2019 at 07:16:57PM -0700, Derek Basehore wrote:
> > Devicetree systems can set panel orientation via a panel binding, but
> > there's no way, as is, to propagate this setting to the connector,
> > where the property need to be added.
> > To address this, this patch sets orientation, as well as other fixed
> > values for the panel, in the drm_panel_attach function. These values
> > are stored from probe in the drm_panel struct.
>
> This approch seems to conflict with work done by Laurent where the
> ownership/creation of the connector will be moved to the display controller.
>
> If I understand it correct then there should not be a 1:1 relation
> between a panel and a connector anymore.


Can you point me to this work? I still see the lone drm_display_info
struct in the drm_connector struct. This seems to indicate that the
kernel still assume one display per connector.

>
> We should not try to work in two different directions with this.
> Laurent, can you comment on this?
>
> If we move forard with this patch, then all fields in drm_panel needs
> kernel-doc - preferably inline.
>
>         Sam
>
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_panel.c | 28 ++++++++++++++++++++++++++++
> >  include/drm/drm_panel.h     | 14 ++++++++++++++
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index 169bab54d52d..ca01095470a9 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -104,11 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
> >   */
> >  int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
> >  {
> > +     struct drm_display_info *info;
> > +
> >       if (panel->connector)
> >               return -EBUSY;
> >
> >       panel->connector = connector;
> >       panel->drm = connector->dev;
> > +     info = &connector->display_info;
> > +     info->width_mm = panel->width_mm;
> > +     info->height_mm = panel->height_mm;
> > +     info->bpc = panel->bpc;
> > +     info->panel_orientation = panel->orientation;
> > +     info->bus_flags = panel->bus_flags;
> > +     if (panel->bus_formats)
> > +             drm_display_info_set_bus_formats(&connector->display_info,
> > +                                              panel->bus_formats,
> > +                                              panel->num_bus_formats);
> >
> >       return 0;
> >  }
> > @@ -128,6 +140,22 @@ EXPORT_SYMBOL(drm_panel_attach);
> >   */
> >  int drm_panel_detach(struct drm_panel *panel)
> >  {
> > +     struct drm_display_info *info;
> > +
> > +     if (!panel->connector)
> > +             goto out;
> > +
> > +     info = &panel->connector->display_info;
> > +     info->width_mm = 0;
> > +     info->height_mm = 0;
> > +     info->bpc = 0;
> > +     info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> > +     info->bus_flags = 0;
> > +     kfree(info->bus_formats);
> > +     info->bus_formats = NULL;
> > +     info->num_bus_formats = 0;
> > +
> > +out:
> >       panel->connector = NULL;
> >       panel->drm = NULL;
> >
> > diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> > index fc7da55f41d9..a6a881b987dd 100644
> > --- a/include/drm/drm_panel.h
> > +++ b/include/drm/drm_panel.h
> > @@ -39,6 +39,8 @@ enum drm_panel_orientation;
> >   * struct drm_panel_funcs - perform operations on a given panel
> >   * @disable: disable panel (turn off back light, etc.)
> >   * @unprepare: turn off panel
> > + * @detach: detach panel->connector (clear internal state, etc.)
> > + * @attach: attach panel->connector (update internal state, etc.)
> >   * @prepare: turn on panel and perform set up
> >   * @enable: enable panel (turn on back light, etc.)
> >   * @get_modes: add modes to the connector that the panel is attached to and
> > @@ -95,6 +97,18 @@ struct drm_panel {
> >
> >       const struct drm_panel_funcs *funcs;
> >
> > +     /*
> > +      * panel information to be set in the connector when the panel is
> > +      * attached.
> > +      */
> > +     unsigned int width_mm;
> > +     unsigned int height_mm;
> > +     unsigned int bpc;
> > +     int orientation;
> > +     const u32 *bus_formats;
> > +     unsigned int num_bus_formats;
> > +     u32 bus_flags;
> > +
> >       struct list_head list;
> >  };
> >
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
