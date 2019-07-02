Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE182C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881A521479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VOTidcWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfGBDYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:24:16 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44672 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfGBDYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:24:16 -0400
Received: by mail-vs1-f68.google.com with SMTP id v129so10263740vsb.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NF9sKdd1kTn5hPJQxmdOYAoq8V4x3KJMw7Y6I60fnA0=;
        b=VOTidcWX/vtw+RMbBDMJUzDasnoGqq6CHYdrWRZz3nA3y8ARzIg+9ZV0Mde+Xn055l
         72eOksANj/TrjSKI9swRwHr/3/J1SxmgmB+I9cP1D0bWxRA0UqDlSAmO/qVMBrznaHJ0
         fj8lvRTJAO22Wz0k7X76NClEAN673VrwZ8Fe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NF9sKdd1kTn5hPJQxmdOYAoq8V4x3KJMw7Y6I60fnA0=;
        b=smwt7xvUw/uA0IVocWSHaASJ1KmfA/pXojyOAt8WfI0k4IzAZEhBw/lvtUZKfPgxGW
         fp+opoYYSbdwIJ3MD3zpg00OJmlUHj+7DgRfoGDNJw1PHnL1qrehTEVwk580EJhHW3E4
         t6C5UNVi+AizdGsx9TIOCKwfnCML6ILhk2IGlCdu88UQCHVVIHDQwlmAveNOrZLcwOsb
         fTVty1hBa/ikzjpZLn93HIP35feBMPNhNrNF98ZJUjdZigx3j8yQGDyBCz+LNQ/XY9+I
         Cc28Fcdl/Vbg+2Q3VupcQaV4kPjrXcLtAyO5NVwjbHQMB5neKbN9Ww/FWrCEHnhTxPje
         VzhA==
X-Gm-Message-State: APjAAAWXA3KIaAUi6SXJjoNkevbci2ihokHL7ckwi+jQwEUWuLJXDurH
        COVHsJClsHSVQ5B2LB8HBmGsi4c+7BOK8eCIqSHNGw==
X-Google-Smtp-Source: APXvYqz+Qs9OSpISvLsVtvlCKaQDDzKFeS7ZErnVs6OE/TEItC6SlKxAzJ4IUK1ZOIt0hue4JXmvkCpPszGYyssZDFA=
X-Received: by 2002:a67:7d13:: with SMTP id y19mr16261630vsc.232.1562037854259;
 Mon, 01 Jul 2019 20:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190622034105.188454-1-dbasehore@chromium.org>
 <20190622034105.188454-4-dbasehore@chromium.org> <20190624132413.GN5942@intel.com>
In-Reply-To: <20190624132413.GN5942@intel.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Mon, 1 Jul 2019 20:24:03 -0700
Message-ID: <CAGAzgsreBg1kpVUtvi70P6ufJ+b6m=LdJk+E9hB4yp3N_ZePkg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v3 3/4] drm/connector: Split out orientation
 quirk detection
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        CK Hu <ck.hu@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 6:24 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Jun 21, 2019 at 08:41:04PM -0700, Derek Basehore wrote:
> > Not every platform needs quirk detection for panel orientation, so
> > split the drm_connector_init_panel_orientation_property into two
> > functions. One for platforms without the need for quirks, and the
> > other for platforms that need quirks.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_connector.c | 45 ++++++++++++++++++++++++---------
> >  drivers/gpu/drm/i915/intel_dp.c |  4 +--
> >  drivers/gpu/drm/i915/vlv_dsi.c  |  5 ++--
> >  include/drm/drm_connector.h     |  2 ++
> >  4 files changed, 39 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_conn=
ector.c
> > index e17586aaa80f..c4b01adf927a 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -1894,31 +1894,23 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_pro=
perty);
> >   * drm_connector_init_panel_orientation_property -
> >   *   initialize the connecters panel_orientation property
> >   * @connector: connector for which to init the panel-orientation prope=
rty.
> > - * @width: width in pixels of the panel, used for panel quirk detectio=
n
> > - * @height: height in pixels of the panel, used for panel quirk detect=
ion
> >   *
> >   * This function should only be called for built-in panels, after sett=
ing
> >   * connector->display_info.panel_orientation first (if known).
> >   *
> > - * This function will check for platform specific (e.g. DMI based) qui=
rks
> > - * overriding display_info.panel_orientation first, then if panel_orie=
ntation
> > - * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
> > - * "panel orientation" property to the connector.
> > + * This function will check if the panel_orientation is not
> > + * DRM_MODE_PANEL_ORIENTATION_UNKNOWN. If not, it will attach the "pan=
el
> > + * orientation" property to the connector.
> >   *
> >   * Returns:
> >   * Zero on success, negative errno on failure.
> >   */
> >  int drm_connector_init_panel_orientation_property(
> > -     struct drm_connector *connector, int width, int height)
> > +     struct drm_connector *connector)
> >  {
> >       struct drm_device *dev =3D connector->dev;
> >       struct drm_display_info *info =3D &connector->display_info;
> >       struct drm_property *prop;
> > -     int orientation_quirk;
> > -
> > -     orientation_quirk =3D drm_get_panel_orientation_quirk(width, heig=
ht);
> > -     if (orientation_quirk !=3D DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> > -             info->panel_orientation =3D orientation_quirk;
> >
> >       if (info->panel_orientation =3D=3D DRM_MODE_PANEL_ORIENTATION_UNK=
NOWN)
> >               return 0;
> > @@ -1941,6 +1933,35 @@ int drm_connector_init_panel_orientation_propert=
y(
> >  }
> >  EXPORT_SYMBOL(drm_connector_init_panel_orientation_property);
> >
> > +/**
> > + * drm_connector_init_panel_orientation_property_quirk -
> > + *   initialize the connecters panel_orientation property with a quirk
> > + *   override
> > + * @connector: connector for which to init the panel-orientation prope=
rty.
> > + * @width: width in pixels of the panel, used for panel quirk detectio=
n
> > + * @height: height in pixels of the panel, used for panel quirk detect=
ion
> > + *
> > + * This function will check for platform specific (e.g. DMI based) qui=
rks
> > + * overriding display_info.panel_orientation first, then if panel_orie=
ntation
> > + * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
> > + * "panel orientation" property to the connector.
> > + *
> > + * Returns:
> > + * Zero on success, negative errno on failure.
> > + */
> > +int drm_connector_init_panel_orientation_property_quirk(
> > +     struct drm_connector *connector, int width, int height)
> > +{
> > +     int orientation_quirk;
> > +
> > +     orientation_quirk =3D drm_get_panel_orientation_quirk(width, heig=
ht);
> > +     if (orientation_quirk !=3D DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> > +             connector->display_info.panel_orientation =3D orientation=
_quirk;
> > +
> > +     return drm_connector_init_panel_orientation_property(connector);
> > +}
> > +EXPORT_SYMBOL(drm_connector_init_panel_orientation_property_quirk);
> > +
> >  int drm_connector_set_obj_prop(struct drm_mode_object *obj,
> >                                   struct drm_property *property,
> >                                   uint64_t value)
> > diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/int=
el_dp.c
> > index b099a9dc28fd..7d4e61cf5463 100644
> > --- a/drivers/gpu/drm/i915/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > @@ -7282,8 +7282,8 @@ static bool intel_edp_init_connector(struct intel=
_dp *intel_dp,
> >       intel_panel_setup_backlight(connector, pipe);
> >
> >       if (fixed_mode)
> > -             drm_connector_init_panel_orientation_property(
> > -                     connector, fixed_mode->hdisplay, fixed_mode->vdis=
play);
> > +             drm_connector_init_panel_orientation_property_quirk(conne=
ctor,
> > +                             fixed_mode->hdisplay, fixed_mode->vdispla=
y);
> >
> >       return true;
> >
> > diff --git a/drivers/gpu/drm/i915/vlv_dsi.c b/drivers/gpu/drm/i915/vlv_=
dsi.c
> > index bfe2891eac37..fa9833dbe359 100644
> > --- a/drivers/gpu/drm/i915/vlv_dsi.c
> > +++ b/drivers/gpu/drm/i915/vlv_dsi.c
> > @@ -1650,6 +1650,7 @@ static void intel_dsi_add_properties(struct intel=
_connector *connector)
> >
> >       if (connector->panel.fixed_mode) {
> >               u32 allowed_scalers;
> > +             int orientation;
> >
> >               allowed_scalers =3D BIT(DRM_MODE_SCALE_ASPECT) | BIT(DRM_=
MODE_SCALE_FULLSCREEN);
> >               if (!HAS_GMCH(dev_priv))
> > @@ -1660,9 +1661,7 @@ static void intel_dsi_add_properties(struct intel=
_connector *connector)
> >
> >               connector->base.state->scaling_mode =3D DRM_MODE_SCALE_AS=
PECT;
> >
> > -             connector->base.display_info.panel_orientation =3D
> > -                     vlv_dsi_get_panel_orientation(connector);
>
> Where did that go?

Oops. Nice catch.

>
> > -             drm_connector_init_panel_orientation_property(
> > +             drm_connector_init_panel_orientation_property_quirk(
> >                               &connector->base,
> >                               connector->panel.fixed_mode->hdisplay,
> >                               connector->panel.fixed_mode->vdisplay);
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index 47e749b74e5f..0468fd9a4418 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -1370,6 +1370,8 @@ void drm_connector_set_link_status_property(struc=
t drm_connector *connector,
> >  void drm_connector_set_vrr_capable_property(
> >               struct drm_connector *connector, bool capable);
> >  int drm_connector_init_panel_orientation_property(
> > +     struct drm_connector *connector);
> > +int drm_connector_init_panel_orientation_property_quirk(
> >       struct drm_connector *connector, int width, int height);
> >  int drm_connector_attach_max_bpc_property(struct drm_connector *connec=
tor,
> >                                         int min, int max);
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

Thanks for the review
