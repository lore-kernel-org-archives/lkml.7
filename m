Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9956C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966D52464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="md40lg4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfLEJfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:35:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41240 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbfLEJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:35:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so1943113lfp.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xlBRhTw/jtQIcsHp5WmEd30ut2aD0xyE9yaT+wUTc3I=;
        b=md40lg4+8ino9LXdrRZD9ROuX9NvQbPOGvNZ/eVcceTDIhtdLWHy9ECt5z1dQAD4MM
         DdH87tABqmZ3T0s9VvKZuw2d48mq5SaZVrPzQ48tNJ1OpKH6wXWvLIPK2FThEc7d7NnG
         df2dTl4M0F5i6I7nAScI9mhQo2yFc8PapwURaegnN4Eq8iHNfJqzHsFE+pExVO0BQzeF
         3qtDe7gefJwITWPwQKgDCOyGtrXiPMs4P0FfR/glCJp/gubzKE7/YksaEdjJv1HQDO6M
         w5jdH6pM9zDLm/aB8bHU9rUW2s1DqemW8bbBVh9gnaamzATpoaEPrIeTIhA6GFEGfdn7
         EaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xlBRhTw/jtQIcsHp5WmEd30ut2aD0xyE9yaT+wUTc3I=;
        b=nqUBtvLCmDGlDybI+njjz27/VTR9HM/VTLhXYcVF35JQ3eg+HmSGQvndBeTH3qqweL
         jtBwYY3hRfOd85tKuME4JLLkx9Qx3uI6X3tpKuen1m22MKbt6D7l4YacOnYqAc9Viw3s
         FcRRkb3gCJgS5nsyv8bdpAgBWWLR9HpgyT8F1PgnGPI3LVSck+gqUCziAhjHO6FaNLDT
         DnCv5E+xVOWce6+B8iryG/uVAwm/oUzeBsgKzO5c2JJMVJkB/TEn2DEBAsMhCQjDuBD3
         LDKkq746fbBrX5/ig1SR+1vtsZIYJmpWZz1c1gpJzVTXS1g5rU76YUWTzFhbNkKoIXjo
         5xNw==
X-Gm-Message-State: APjAAAUtiM4I7XC8I7hkuFd7kf+kmcSv8bfXTC/PTLHzHYw7DfqQPj/z
        Yxr8uDp5STMww4SlRmxYgoRcPDUkZfOSjyyTilYtWw==
X-Google-Smtp-Source: APXvYqxrfnFijgMewMwGGAyu6M2ppVO81Ru7vemD6fccdEP1qKQwpHm3knUpDelBbZnkhe5FhD+wd3Bf8X1vkMcSuF8=
X-Received: by 2002:ac2:4244:: with SMTP id m4mr4610896lfl.85.1575538531007;
 Thu, 05 Dec 2019 01:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191104194147.185642-1-rajatja@google.com>
 <20191104194147.185642-3-rajatja@google.com> <87r222wpvv.fsf@intel.com>
In-Reply-To: <87r222wpvv.fsf@intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 5 Dec 2019 01:34:53 -0800
Message-ID: <CACK8Z6EU3UvPZUqfPhNQ0x5hdbT+hJnRJ2J0f_WF3yr9+mTRog@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/i915: Add support for integrated privacy screens
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 7:04 AM Jani Nikula <jani.nikula@linux.intel.com> w=
rote:
>
> On Mon, 04 Nov 2019, Rajat Jain <rajatja@google.com> wrote:
> > Certain laptops now come with panels that have integrated privacy
> > screens on them. This patch adds support for such panels by adding
> > a privacy-screen property to the intel_connector for the panel, that
> > the userspace can then use to control and check the status.
> >
> > Identifying the presence of privacy screen, and controlling it, is done
> > via ACPI _DSM methods.
> >
> > Currently, this is done only for the Intel display ports. But in future=
,
> > this can be done for any other ports if the hardware becomes available
> > (e.g. external monitors supporting integrated privacy screens?).
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Change-Id: Ic9ff07fc4a50797d2d0dfb919f11aa0821a4b548
> > ---
> > v2: Formed by splitting the original patch into multiple patches.
> >     - All code has been moved into i915 now.
> >     - Privacy screen is a i915 property
> >     - Have a local state variable to store the prvacy screen. Don't rea=
d
> >       it from hardware.
> >
> >  drivers/gpu/drm/i915/Makefile                 |  3 +-
> >  drivers/gpu/drm/i915/display/intel_atomic.c   | 13 +++-
> >  .../gpu/drm/i915/display/intel_connector.c    | 35 ++++++++++
> >  .../gpu/drm/i915/display/intel_connector.h    |  1 +
> >  .../drm/i915/display/intel_display_types.h    |  4 ++
> >  drivers/gpu/drm/i915/display/intel_dp.c       |  5 ++
> >  .../drm/i915/display/intel_privacy_screen.c   | 70 +++++++++++++++++++
> >  .../drm/i915/display/intel_privacy_screen.h   | 25 +++++++
> >  include/uapi/drm/i915_drm.h                   | 14 ++++
> >  9 files changed, 166 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h
> >
> > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makef=
ile
> > index 2587ea834f06..3589ebcf27bc 100644
> > --- a/drivers/gpu/drm/i915/Makefile
> > +++ b/drivers/gpu/drm/i915/Makefile
> > @@ -185,7 +185,8 @@ i915-y +=3D \
> >       display/intel_tc.o
> >  i915-$(CONFIG_ACPI) +=3D \
> >       display/intel_acpi.o \
> > -     display/intel_opregion.o
> > +     display/intel_opregion.o \
> > +     display/intel_privacy_screen.o
>
> Mmmh, wonder if there'll be non-ACPI based privacy screens. I guess we
> can sort this out then. *shrug*
>
> >  i915-$(CONFIG_DRM_FBDEV_EMULATION) +=3D \
> >       display/intel_fbdev.o
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/=
drm/i915/display/intel_atomic.c
> > index d3fb75bb9eb1..378772d3449c 100644
> > --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> > +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> > @@ -37,6 +37,7 @@
> >  #include "intel_atomic.h"
> >  #include "intel_display_types.h"
> >  #include "intel_hdcp.h"
> > +#include "intel_privacy_screen.h"
> >  #include "intel_sprite.h"
> >
> >  /**
> > @@ -57,11 +58,14 @@ int intel_digital_connector_atomic_get_property(str=
uct drm_connector *connector,
> >       struct drm_i915_private *dev_priv =3D to_i915(dev);
> >       struct intel_digital_connector_state *intel_conn_state =3D
> >               to_intel_digital_connector_state(state);
> > +     struct intel_connector *intel_connector =3D to_intel_connector(co=
nnector);
> >
> >       if (property =3D=3D dev_priv->force_audio_property)
> >               *val =3D intel_conn_state->force_audio;
> >       else if (property =3D=3D dev_priv->broadcast_rgb_property)
> >               *val =3D intel_conn_state->broadcast_rgb;
> > +     else if (property =3D=3D intel_connector->privacy_screen_property=
)
> > +             *val =3D intel_conn_state->privacy_screen_status;
> >       else {
> >               DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
> >                                property->base.id, property->name);
> > @@ -89,15 +93,18 @@ int intel_digital_connector_atomic_set_property(str=
uct drm_connector *connector,
> >       struct drm_i915_private *dev_priv =3D to_i915(dev);
> >       struct intel_digital_connector_state *intel_conn_state =3D
> >               to_intel_digital_connector_state(state);
> > +     struct intel_connector *intel_connector =3D to_intel_connector(co=
nnector);
> >
> >       if (property =3D=3D dev_priv->force_audio_property) {
> >               intel_conn_state->force_audio =3D val;
> >               return 0;
> > -     }
> > -
> > -     if (property =3D=3D dev_priv->broadcast_rgb_property) {
> > +     } else if (property =3D=3D dev_priv->broadcast_rgb_property) {
> >               intel_conn_state->broadcast_rgb =3D val;
> >               return 0;
> > +     } else if (property =3D=3D intel_connector->privacy_screen_proper=
ty) {
> > +             intel_privacy_screen_set_val(intel_connector, val);
> > +             intel_conn_state->privacy_screen_status =3D val;
> > +             return 0;
> >       }
> >
> >       DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
> > diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/g=
pu/drm/i915/display/intel_connector.c
> > index 308ec63207ee..3ccbf52aedf9 100644
> > --- a/drivers/gpu/drm/i915/display/intel_connector.c
> > +++ b/drivers/gpu/drm/i915/display/intel_connector.c
> > @@ -281,3 +281,38 @@ intel_attach_colorspace_property(struct drm_connec=
tor *connector)
> >               drm_object_attach_property(&connector->base,
> >                                          connector->colorspace_property=
, 0);
> >  }
> > +
> > +static const struct drm_prop_enum_list privacy_screen_enum[] =3D {
> > +     { PRIVACY_SCREEN_DISABLED, "Disabled" },
> > +     { PRIVACY_SCREEN_ENABLED, "Enabled" },
> > +};
> > +
> > +/**
> > + * intel_attach_privacy_screen_property -
> > + *     create and attach the connecter's privacy-screen property. *
> > + * @connector: connector for which to init the privacy-screen property
> > + *
> > + * This function creates and attaches the "privacy-screen" property to=
 the
> > + * connector. Initial state of privacy-screen is set to disabled.
> > + */
> > +void
> > +intel_attach_privacy_screen_property(struct drm_connector *connector)
> > +{
> > +     struct intel_connector *intel_connector =3D to_intel_connector(co=
nnector);
> > +     struct drm_property *prop;
> > +
> > +     if (!intel_connector->privacy_screen_property) {
> > +             prop =3D drm_property_create_enum(connector->dev,
> > +                                             DRM_MODE_PROP_ENUM,
> > +                                             "privacy-screen",
> > +                                             privacy_screen_enum,
> > +                                         ARRAY_SIZE(privacy_screen_enu=
m));
> > +             if (!prop)
> > +                     return;
> > +
> > +             intel_connector->privacy_screen_property =3D prop;
> > +     }
> > +
> > +     drm_object_attach_property(&connector->base, prop,
> > +                                PRIVACY_SCREEN_DISABLED);
> > +}
>
> I think this should be a drm core level property in drm_connector.[ch]
> so that *all* drivers would use the same thing for privacy screens. Not
> i915 specific.
>
> I think this is the biggest issue in the patch series.

I actually would be happy to make it a drm_connector property, like I
had in my original patch series. I changed it to i915 specific because
it seemed to me based on the comments that the general sentiment is
that anything to do with acpi should be in i915.

Note that the privacy screen property essentially needs an ACPI handle
to work on, so if I were to move the property into drm_connector, I'd
likely rename the intel_privacy_screen* code to dem_privacy_screen*
code, and it'll still operate on an ACPI handle (stored in
drm_connector structure). The i915's job will then be to lookup that
ACPI handle (because lookup requires display index) and populate it in
drm_connector. Does this sound OK?

>
> > diff --git a/drivers/gpu/drm/i915/display/intel_connector.h b/drivers/g=
pu/drm/i915/display/intel_connector.h
> > index 93a7375c8196..61005f37a338 100644
> > --- a/drivers/gpu/drm/i915/display/intel_connector.h
> > +++ b/drivers/gpu/drm/i915/display/intel_connector.h
> > @@ -31,5 +31,6 @@ void intel_attach_force_audio_property(struct drm_con=
nector *connector);
> >  void intel_attach_broadcast_rgb_property(struct drm_connector *connect=
or);
> >  void intel_attach_aspect_ratio_property(struct drm_connector *connecto=
r);
> >  void intel_attach_colorspace_property(struct drm_connector *connector)=
;
> > +void intel_attach_privacy_screen_property(struct drm_connector *connec=
tor);
> >
> >  #endif /* __INTEL_CONNECTOR_H__ */
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drive=
rs/gpu/drm/i915/display/intel_display_types.h
> > index c2706afc069b..83b8c98049a7 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> > +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> > @@ -426,6 +426,9 @@ struct intel_connector {
> >       struct work_struct modeset_retry_work;
> >
> >       struct intel_hdcp hdcp;
> > +
> > +     /* Optional "privacy-screen" property for the connector panel */
> > +     struct drm_property *privacy_screen_property;
> >  };
> >
> >  struct intel_digital_connector_state {
> > @@ -433,6 +436,7 @@ struct intel_digital_connector_state {
> >
> >       enum hdmi_force_audio force_audio;
> >       int broadcast_rgb;
> > +     enum intel_privacy_screen_status privacy_screen_status;
> >  };
> >
> >  #define to_intel_digital_connector_state(x) container_of(x, struct int=
el_digital_connector_state, base)
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/=
i915/display/intel_dp.c
> > index 4fac408a4299..1963e92404ba 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -62,6 +62,7 @@
> >  #include "intel_lspcon.h"
> >  #include "intel_lvds.h"
> >  #include "intel_panel.h"
> > +#include "intel_privacy_screen.h"
> >  #include "intel_psr.h"
> >  #include "intel_sideband.h"
> >  #include "intel_tc.h"
> > @@ -6358,6 +6359,10 @@ intel_dp_add_properties(struct intel_dp *intel_d=
p, struct drm_connector *connect
> >
> >               /* Lookup the ACPI node corresponding to the connector */
> >               intel_connector_lookup_acpi_node(intel_connector);
> > +
> > +             /* Check for integrated Privacy screen support */
> > +             if (intel_privacy_screen_present(intel_connector))
> > +                     intel_attach_privacy_screen_property(connector);
> >       }
> >  }
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/driv=
ers/gpu/drm/i915/display/intel_privacy_screen.c
> > new file mode 100644
> > index 000000000000..4c422e38c51a
> > --- /dev/null
> > +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
>
> Please read http://mid.mail-archive.com/CAKMK7uH-8+tbKsAoiChsxELEc_77RVVx=
P2wapHWhqB+0Viifog@mail.gmail.com

OK, I changed it to SPDX-License-Identifier: GPL-2.0 OR MIT


>
> > +/*
> > + * Intel ACPI privacy screen code
> > + *
> > + * Copyright =C2=A9 2019 Google Inc.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +
> > +#include "intel_privacy_screen.h"
> > +
> > +#define CONNECTOR_DSM_REVID 1
> > +
> > +#define CONNECTOR_DSM_FN_PRIVACY_ENABLE              2
> > +#define CONNECTOR_DSM_FN_PRIVACY_DISABLE             3
> > +
> > +static const guid_t drm_conn_dsm_guid =3D
> > +     GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> > +               0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> > +
> > +/* Makes _DSM call to set privacy screen status */
> > +static void acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 =
func)
> > +{
> > +     union acpi_object *obj;
> > +
> > +     obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
> > +                             CONNECTOR_DSM_REVID, func, NULL);
> > +     if (!obj) {
> > +             DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n",=
 func);
> > +             return;
> > +     }
> > +
> > +     ACPI_FREE(obj);
> > +}
> > +
> > +void intel_privacy_screen_set_val(struct intel_connector *intel_connec=
tor,
> > +                               enum intel_privacy_screen_status val)
>
> Just name the parameter connector, not intel_connector. This throughout.

Done.

>
> > +{
> > +     acpi_handle acpi_handle =3D intel_connector->acpi_handle;
> > +
> > +     if (!acpi_handle)
> > +             return;
> > +
> > +     if (val =3D=3D PRIVACY_SCREEN_DISABLED)
> > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > +                                          CONNECTOR_DSM_FN_PRIVACY_DIS=
ABLE);
> > +     else if (val =3D=3D PRIVACY_SCREEN_ENABLED)
> > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > +                                          CONNECTOR_DSM_FN_PRIVACY_ENA=
BLE);
>
> else complain?
>

Done.

> > +}
> > +
> > +bool intel_privacy_screen_present(struct intel_connector *intel_connec=
tor)
> > +{
> > +     acpi_handle handle =3D intel_connector->acpi_handle;
> > +
> > +     if (!handle)
> > +             return false;
> > +
> > +     if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
> > +                         CONNECTOR_DSM_REVID,
> > +                         1 << CONNECTOR_DSM_FN_PRIVACY_ENABLE |
> > +                         1 << CONNECTOR_DSM_FN_PRIVACY_DISABLE)) {
> > +             DRM_WARN("%s: Odd, connector ACPI node but no privacy scr=
n?\n",
> > +                      dev_name(intel_connector->base.dev->dev));
> > +             return false;
> > +     }
> > +     DRM_DEV_INFO(intel_connector->base.dev->dev,
> > +                  "supports privacy screen\n");
> > +     return true;
> > +}
> > diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/driv=
ers/gpu/drm/i915/display/intel_privacy_screen.h
> > new file mode 100644
> > index 000000000000..212f73349a00
> > --- /dev/null
> > +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright =C2=A9 2019 Google Inc.
> > + */
> > +
> > +#ifndef __DRM_PRIVACY_SCREEN_H__
> > +#define __DRM_PRIVACY_SCREEN_H__
> > +
> > +#include "intel_display_types.h"
> > +
> > +#ifdef CONFIG_ACPI
> > +bool intel_privacy_screen_present(struct intel_connector *intel_connec=
tor);
> > +void intel_privacy_screen_set_val(struct intel_connector *intel_connec=
tor,
> > +                               enum intel_privacy_screen_status val);
> > +#else
> > +bool intel_privacy_screen_present(struct intel_connector *intel_connec=
tor);
> > +{
> > +     return false;
> > +}
> > +void intel_privacy_screen_set_val(struct intel_connector *intel_connec=
tor,
> > +                               enum intel_privacy_screen_status val)
> > +{ }
> > +#endif /* CONFIG_ACPI */
> > +
> > +#endif /* __DRM_PRIVACY_SCREEN_H__ */
> > diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
> > index 469dc512cca3..cf08d5636363 100644
> > --- a/include/uapi/drm/i915_drm.h
> > +++ b/include/uapi/drm/i915_drm.h
> > @@ -2123,6 +2123,20 @@ struct drm_i915_query_engine_info {
> >       struct drm_i915_engine_info engines[];
> >  };
> >
> > +/**
> > + * enum intel_privacy_screen_status - privacy_screen status
> > + *
> > + * This enum is used to track and control the state of the integrated =
privacy
> > + * screen present on some display panels, via the "privacy-screen" pro=
perty.
> > + *
> > + * @PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disabl=
ed
> > + * @PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enable=
d
> > + **/
> > +enum intel_privacy_screen_status {
> > +     PRIVACY_SCREEN_DISABLED =3D 0,
> > +     PRIVACY_SCREEN_ENABLED =3D 1,
> > +};
> > +
>
> The drm_property interface UAPI is based on the strings, *not* on the
> values. Please move the enum out of uapi into the drm code.

Oh, so we don't have to expose this to userspace? Understand, so I
moved it to intel_display_types.h

Thanks,

Rajat.


>
> BR,
> jani.
>
> >  #if defined(__cplusplus)
> >  }
> >  #endif
>
> --
> Jani Nikula, Intel Open Source Graphics Center
