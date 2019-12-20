Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E35C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4562082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOWUq6o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLTUj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:39:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42120 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfLTUj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:39:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so7996315lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZdFGitSiEwOWQgwR2NULowMZqqwYAEdw56eQQuZ8YjU=;
        b=KOWUq6o+22MbQgzjNfbRH+9j2+3Q8L655c0cApWjGBFmf8B/Lrwrni1XfkmRL0FOin
         z/FcFPsFaUN/kF0/beUwSNIBMD76d3r1ZuzoigXuzJ5j2eFRMsSJoN1b9jUj9x3ZrZzX
         I+Kap2IgOVrVUHQXGxIJKYIEEgfzeeyLGQpid/YwG11hfdi1X0FCG3lHvPSDBfrxR2R3
         m8wkDEEHYeeUaLSlBvtZvLgyjbASDBUPCHYK7dzlyqHzy4yQt6Cblh79zbNSxNU2sFB4
         FpSrloX7rQhlAP0RZ+FBW7ZPJSGK+uNDIo/WIFbqu/NcFlJHqg0ESr2Bt5v7DqRsgwu6
         P+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZdFGitSiEwOWQgwR2NULowMZqqwYAEdw56eQQuZ8YjU=;
        b=EHEMHRtePqPb2DH0cxBlS13qi90GPXFgvH5rfRwrgd+6r1ZobRKUokYoS9qU+dv0cy
         izBrp66mDs11ZgyKS8HruLwOjZRs9pvmKOpzyARja5S41JGzPa7mAPajMFR+L8gEpR0q
         tkOFkqwrKb1mSleKmfVX03oXHrPxjXw0Y+p8j2MZwzRlRCc4CdiC6KFBEX6kybm+f2em
         cWvEVTa9WrIWz5Cf5YABKPICIEsULK3Yovymqm8a5Cljspmftfo6U4sVCRi5buOiCQYl
         3F5IyupitG52/feffzlUcKg8lfDJheGV+4r8CVqkN8tVTQDBAdlazZ1N0dyX0GK0djY0
         K4wg==
X-Gm-Message-State: APjAAAWMzTDRPGVPPCss6WsMzo34aoexFR8aFRe51qx2aDWzNExm9UCn
        XR6uapdV2u1D7lcrD65hBixLbDfCxof7cZ/yThCd3g==
X-Google-Smtp-Source: APXvYqxXWyPJcL5DWu7/U7pqUj2gpkoOjMV4XhpKUqXwxXMzKpgL+E8wPxLqCsEmkq++aal6Tr2Rbka9Yd5pPwDxtKE=
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr9975253lfo.85.1576874393918;
 Fri, 20 Dec 2019 12:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191104194147.185642-1-rajatja@google.com>
 <20191104194147.185642-3-rajatja@google.com> <87r222wpvv.fsf@intel.com> <CACK8Z6EU3UvPZUqfPhNQ0x5hdbT+hJnRJ2J0f_WF3yr9+mTRog@mail.gmail.com>
In-Reply-To: <CACK8Z6EU3UvPZUqfPhNQ0x5hdbT+hJnRJ2J0f_WF3yr9+mTRog@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 20 Dec 2019 12:39:16 -0800
Message-ID: <CACK8Z6GZtRer0ZHF-vZzoGFqOqw3U=3o95ntr938ow21Ar6uow@mail.gmail.com>
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

HI Jani,


On Thu, Dec 5, 2019 at 1:34 AM Rajat Jain <rajatja@google.com> wrote:
>
> On Wed, Nov 20, 2019 at 7:04 AM Jani Nikula <jani.nikula@linux.intel.com>=
 wrote:
> >
> > On Mon, 04 Nov 2019, Rajat Jain <rajatja@google.com> wrote:
> > > Certain laptops now come with panels that have integrated privacy
> > > screens on them. This patch adds support for such panels by adding
> > > a privacy-screen property to the intel_connector for the panel, that
> > > the userspace can then use to control and check the status.
> > >
> > > Identifying the presence of privacy screen, and controlling it, is do=
ne
> > > via ACPI _DSM methods.
> > >
> > > Currently, this is done only for the Intel display ports. But in futu=
re,
> > > this can be done for any other ports if the hardware becomes availabl=
e
> > > (e.g. external monitors supporting integrated privacy screens?).
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > Change-Id: Ic9ff07fc4a50797d2d0dfb919f11aa0821a4b548
> > > ---
> > > v2: Formed by splitting the original patch into multiple patches.
> > >     - All code has been moved into i915 now.
> > >     - Privacy screen is a i915 property
> > >     - Have a local state variable to store the prvacy screen. Don't r=
ead
> > >       it from hardware.
> > >
> > >  drivers/gpu/drm/i915/Makefile                 |  3 +-
> > >  drivers/gpu/drm/i915/display/intel_atomic.c   | 13 +++-
> > >  .../gpu/drm/i915/display/intel_connector.c    | 35 ++++++++++
> > >  .../gpu/drm/i915/display/intel_connector.h    |  1 +
> > >  .../drm/i915/display/intel_display_types.h    |  4 ++
> > >  drivers/gpu/drm/i915/display/intel_dp.c       |  5 ++
> > >  .../drm/i915/display/intel_privacy_screen.c   | 70 +++++++++++++++++=
++
> > >  .../drm/i915/display/intel_privacy_screen.h   | 25 +++++++
> > >  include/uapi/drm/i915_drm.h                   | 14 ++++
> > >  9 files changed, 166 insertions(+), 4 deletions(-)
> > >  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen=
.c
> > >  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen=
.h
> > >
> > > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Mak=
efile
> > > index 2587ea834f06..3589ebcf27bc 100644
> > > --- a/drivers/gpu/drm/i915/Makefile
> > > +++ b/drivers/gpu/drm/i915/Makefile
> > > @@ -185,7 +185,8 @@ i915-y +=3D \
> > >       display/intel_tc.o
> > >  i915-$(CONFIG_ACPI) +=3D \
> > >       display/intel_acpi.o \
> > > -     display/intel_opregion.o
> > > +     display/intel_opregion.o \
> > > +     display/intel_privacy_screen.o
> >
> > Mmmh, wonder if there'll be non-ACPI based privacy screens. I guess we
> > can sort this out then. *shrug*
> >
> > >  i915-$(CONFIG_DRM_FBDEV_EMULATION) +=3D \
> > >       display/intel_fbdev.o
> > >
> > > diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gp=
u/drm/i915/display/intel_atomic.c
> > > index d3fb75bb9eb1..378772d3449c 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> > > @@ -37,6 +37,7 @@
> > >  #include "intel_atomic.h"
> > >  #include "intel_display_types.h"
> > >  #include "intel_hdcp.h"
> > > +#include "intel_privacy_screen.h"
> > >  #include "intel_sprite.h"
> > >
> > >  /**
> > > @@ -57,11 +58,14 @@ int intel_digital_connector_atomic_get_property(s=
truct drm_connector *connector,
> > >       struct drm_i915_private *dev_priv =3D to_i915(dev);
> > >       struct intel_digital_connector_state *intel_conn_state =3D
> > >               to_intel_digital_connector_state(state);
> > > +     struct intel_connector *intel_connector =3D to_intel_connector(=
connector);
> > >
> > >       if (property =3D=3D dev_priv->force_audio_property)
> > >               *val =3D intel_conn_state->force_audio;
> > >       else if (property =3D=3D dev_priv->broadcast_rgb_property)
> > >               *val =3D intel_conn_state->broadcast_rgb;
> > > +     else if (property =3D=3D intel_connector->privacy_screen_proper=
ty)
> > > +             *val =3D intel_conn_state->privacy_screen_status;
> > >       else {
> > >               DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
> > >                                property->base.id, property->name);
> > > @@ -89,15 +93,18 @@ int intel_digital_connector_atomic_set_property(s=
truct drm_connector *connector,
> > >       struct drm_i915_private *dev_priv =3D to_i915(dev);
> > >       struct intel_digital_connector_state *intel_conn_state =3D
> > >               to_intel_digital_connector_state(state);
> > > +     struct intel_connector *intel_connector =3D to_intel_connector(=
connector);
> > >
> > >       if (property =3D=3D dev_priv->force_audio_property) {
> > >               intel_conn_state->force_audio =3D val;
> > >               return 0;
> > > -     }
> > > -
> > > -     if (property =3D=3D dev_priv->broadcast_rgb_property) {
> > > +     } else if (property =3D=3D dev_priv->broadcast_rgb_property) {
> > >               intel_conn_state->broadcast_rgb =3D val;
> > >               return 0;
> > > +     } else if (property =3D=3D intel_connector->privacy_screen_prop=
erty) {
> > > +             intel_privacy_screen_set_val(intel_connector, val);
> > > +             intel_conn_state->privacy_screen_status =3D val;
> > > +             return 0;
> > >       }
> > >
> > >       DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
> > > diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers=
/gpu/drm/i915/display/intel_connector.c
> > > index 308ec63207ee..3ccbf52aedf9 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_connector.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_connector.c
> > > @@ -281,3 +281,38 @@ intel_attach_colorspace_property(struct drm_conn=
ector *connector)
> > >               drm_object_attach_property(&connector->base,
> > >                                          connector->colorspace_proper=
ty, 0);
> > >  }
> > > +
> > > +static const struct drm_prop_enum_list privacy_screen_enum[] =3D {
> > > +     { PRIVACY_SCREEN_DISABLED, "Disabled" },
> > > +     { PRIVACY_SCREEN_ENABLED, "Enabled" },
> > > +};
> > > +
> > > +/**
> > > + * intel_attach_privacy_screen_property -
> > > + *     create and attach the connecter's privacy-screen property. *
> > > + * @connector: connector for which to init the privacy-screen proper=
ty
> > > + *
> > > + * This function creates and attaches the "privacy-screen" property =
to the
> > > + * connector. Initial state of privacy-screen is set to disabled.
> > > + */
> > > +void
> > > +intel_attach_privacy_screen_property(struct drm_connector *connector=
)
> > > +{
> > > +     struct intel_connector *intel_connector =3D to_intel_connector(=
connector);
> > > +     struct drm_property *prop;
> > > +
> > > +     if (!intel_connector->privacy_screen_property) {
> > > +             prop =3D drm_property_create_enum(connector->dev,
> > > +                                             DRM_MODE_PROP_ENUM,
> > > +                                             "privacy-screen",
> > > +                                             privacy_screen_enum,
> > > +                                         ARRAY_SIZE(privacy_screen_e=
num));
> > > +             if (!prop)
> > > +                     return;
> > > +
> > > +             intel_connector->privacy_screen_property =3D prop;
> > > +     }
> > > +
> > > +     drm_object_attach_property(&connector->base, prop,
> > > +                                PRIVACY_SCREEN_DISABLED);
> > > +}
> >
> > I think this should be a drm core level property in drm_connector.[ch]
> > so that *all* drivers would use the same thing for privacy screens. Not
> > i915 specific.
> >
> > I think this is the biggest issue in the patch series.
>
> I actually would be happy to make it a drm_connector property, like I
> had in my original patch series. I changed it to i915 specific because
> it seemed to me based on the comments that the general sentiment is
> that anything to do with acpi should be in i915.
>
> Note that the privacy screen property essentially needs an ACPI handle
> to work on, so if I were to move the property into drm_connector, I'd
> likely rename the intel_privacy_screen* code to drm_privacy_screen*
> code, and it'll still operate on an ACPI handle (stored in
> drm_connector structure). The i915's job will then be to lookup that
> ACPI handle (because lookup requires display index) and populate it in
> drm_connector. Does this sound OK?

Wondering if you ever got my email. I found out this week that I
needed to be a member of intel-gfx mailing list otherwise my patches
won't show up on patchwork.freedesktop.org. I'm now a member, and I
have posted my latest patchset at:

https://patchwork.freedesktop.org/patch/346275/

I'd appreciate if you could please review and comment and provide your
valuable suggestions.

Thanks & Best Regards,

Rajat

>
> >
> > > diff --git a/drivers/gpu/drm/i915/display/intel_connector.h b/drivers=
/gpu/drm/i915/display/intel_connector.h
> > > index 93a7375c8196..61005f37a338 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_connector.h
> > > +++ b/drivers/gpu/drm/i915/display/intel_connector.h
> > > @@ -31,5 +31,6 @@ void intel_attach_force_audio_property(struct drm_c=
onnector *connector);
> > >  void intel_attach_broadcast_rgb_property(struct drm_connector *conne=
ctor);
> > >  void intel_attach_aspect_ratio_property(struct drm_connector *connec=
tor);
> > >  void intel_attach_colorspace_property(struct drm_connector *connecto=
r);
> > > +void intel_attach_privacy_screen_property(struct drm_connector *conn=
ector);
> > >
> > >  #endif /* __INTEL_CONNECTOR_H__ */
> > > diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/dri=
vers/gpu/drm/i915/display/intel_display_types.h
> > > index c2706afc069b..83b8c98049a7 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> > > +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> > > @@ -426,6 +426,9 @@ struct intel_connector {
> > >       struct work_struct modeset_retry_work;
> > >
> > >       struct intel_hdcp hdcp;
> > > +
> > > +     /* Optional "privacy-screen" property for the connector panel *=
/
> > > +     struct drm_property *privacy_screen_property;
> > >  };
> > >
> > >  struct intel_digital_connector_state {
> > > @@ -433,6 +436,7 @@ struct intel_digital_connector_state {
> > >
> > >       enum hdmi_force_audio force_audio;
> > >       int broadcast_rgb;
> > > +     enum intel_privacy_screen_status privacy_screen_status;
> > >  };
> > >
> > >  #define to_intel_digital_connector_state(x) container_of(x, struct i=
ntel_digital_connector_state, base)
> > > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/dr=
m/i915/display/intel_dp.c
> > > index 4fac408a4299..1963e92404ba 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > > @@ -62,6 +62,7 @@
> > >  #include "intel_lspcon.h"
> > >  #include "intel_lvds.h"
> > >  #include "intel_panel.h"
> > > +#include "intel_privacy_screen.h"
> > >  #include "intel_psr.h"
> > >  #include "intel_sideband.h"
> > >  #include "intel_tc.h"
> > > @@ -6358,6 +6359,10 @@ intel_dp_add_properties(struct intel_dp *intel=
_dp, struct drm_connector *connect
> > >
> > >               /* Lookup the ACPI node corresponding to the connector =
*/
> > >               intel_connector_lookup_acpi_node(intel_connector);
> > > +
> > > +             /* Check for integrated Privacy screen support */
> > > +             if (intel_privacy_screen_present(intel_connector))
> > > +                     intel_attach_privacy_screen_property(connector)=
;
> > >       }
> > >  }
> > >
> > > diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/dr=
ivers/gpu/drm/i915/display/intel_privacy_screen.c
> > > new file mode 100644
> > > index 000000000000..4c422e38c51a
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
> > > @@ -0,0 +1,70 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> >
> > Please read http://mid.mail-archive.com/CAKMK7uH-8+tbKsAoiChsxELEc_77RV=
VxP2wapHWhqB+0Viifog@mail.gmail.com
>
> OK, I changed it to SPDX-License-Identifier: GPL-2.0 OR MIT
>
>
> >
> > > +/*
> > > + * Intel ACPI privacy screen code
> > > + *
> > > + * Copyright =C2=A9 2019 Google Inc.
> > > + */
> > > +
> > > +#include <linux/acpi.h>
> > > +
> > > +#include "intel_privacy_screen.h"
> > > +
> > > +#define CONNECTOR_DSM_REVID 1
> > > +
> > > +#define CONNECTOR_DSM_FN_PRIVACY_ENABLE              2
> > > +#define CONNECTOR_DSM_FN_PRIVACY_DISABLE             3
> > > +
> > > +static const guid_t drm_conn_dsm_guid =3D
> > > +     GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> > > +               0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> > > +
> > > +/* Makes _DSM call to set privacy screen status */
> > > +static void acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u6=
4 func)
> > > +{
> > > +     union acpi_object *obj;
> > > +
> > > +     obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
> > > +                             CONNECTOR_DSM_REVID, func, NULL);
> > > +     if (!obj) {
> > > +             DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n=
", func);
> > > +             return;
> > > +     }
> > > +
> > > +     ACPI_FREE(obj);
> > > +}
> > > +
> > > +void intel_privacy_screen_set_val(struct intel_connector *intel_conn=
ector,
> > > +                               enum intel_privacy_screen_status val)
> >
> > Just name the parameter connector, not intel_connector. This throughout=
.
>
> Done.
>
> >
> > > +{
> > > +     acpi_handle acpi_handle =3D intel_connector->acpi_handle;
> > > +
> > > +     if (!acpi_handle)
> > > +             return;
> > > +
> > > +     if (val =3D=3D PRIVACY_SCREEN_DISABLED)
> > > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > > +                                          CONNECTOR_DSM_FN_PRIVACY_D=
ISABLE);
> > > +     else if (val =3D=3D PRIVACY_SCREEN_ENABLED)
> > > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > > +                                          CONNECTOR_DSM_FN_PRIVACY_E=
NABLE);
> >
> > else complain?
> >
>
> Done.
>
> > > +}
> > > +
> > > +bool intel_privacy_screen_present(struct intel_connector *intel_conn=
ector)
> > > +{
> > > +     acpi_handle handle =3D intel_connector->acpi_handle;
> > > +
> > > +     if (!handle)
> > > +             return false;
> > > +
> > > +     if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
> > > +                         CONNECTOR_DSM_REVID,
> > > +                         1 << CONNECTOR_DSM_FN_PRIVACY_ENABLE |
> > > +                         1 << CONNECTOR_DSM_FN_PRIVACY_DISABLE)) {
> > > +             DRM_WARN("%s: Odd, connector ACPI node but no privacy s=
crn?\n",
> > > +                      dev_name(intel_connector->base.dev->dev));
> > > +             return false;
> > > +     }
> > > +     DRM_DEV_INFO(intel_connector->base.dev->dev,
> > > +                  "supports privacy screen\n");
> > > +     return true;
> > > +}
> > > diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/dr=
ivers/gpu/drm/i915/display/intel_privacy_screen.h
> > > new file mode 100644
> > > index 000000000000..212f73349a00
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
> > > @@ -0,0 +1,25 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * Copyright =C2=A9 2019 Google Inc.
> > > + */
> > > +
> > > +#ifndef __DRM_PRIVACY_SCREEN_H__
> > > +#define __DRM_PRIVACY_SCREEN_H__
> > > +
> > > +#include "intel_display_types.h"
> > > +
> > > +#ifdef CONFIG_ACPI
> > > +bool intel_privacy_screen_present(struct intel_connector *intel_conn=
ector);
> > > +void intel_privacy_screen_set_val(struct intel_connector *intel_conn=
ector,
> > > +                               enum intel_privacy_screen_status val)=
;
> > > +#else
> > > +bool intel_privacy_screen_present(struct intel_connector *intel_conn=
ector);
> > > +{
> > > +     return false;
> > > +}
> > > +void intel_privacy_screen_set_val(struct intel_connector *intel_conn=
ector,
> > > +                               enum intel_privacy_screen_status val)
> > > +{ }
> > > +#endif /* CONFIG_ACPI */
> > > +
> > > +#endif /* __DRM_PRIVACY_SCREEN_H__ */
> > > diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.=
h
> > > index 469dc512cca3..cf08d5636363 100644
> > > --- a/include/uapi/drm/i915_drm.h
> > > +++ b/include/uapi/drm/i915_drm.h
> > > @@ -2123,6 +2123,20 @@ struct drm_i915_query_engine_info {
> > >       struct drm_i915_engine_info engines[];
> > >  };
> > >
> > > +/**
> > > + * enum intel_privacy_screen_status - privacy_screen status
> > > + *
> > > + * This enum is used to track and control the state of the integrate=
d privacy
> > > + * screen present on some display panels, via the "privacy-screen" p=
roperty.
> > > + *
> > > + * @PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disa=
bled
> > > + * @PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enab=
led
> > > + **/
> > > +enum intel_privacy_screen_status {
> > > +     PRIVACY_SCREEN_DISABLED =3D 0,
> > > +     PRIVACY_SCREEN_ENABLED =3D 1,
> > > +};
> > > +
> >
> > The drm_property interface UAPI is based on the strings, *not* on the
> > values. Please move the enum out of uapi into the drm code.
>
> Oh, so we don't have to expose this to userspace? Understand, so I
> moved it to intel_display_types.h
>
> Thanks,
>
> Rajat.
>
>
> >
> > BR,
> > jani.
> >
> > >  #if defined(__cplusplus)
> > >  }
> > >  #endif
> >
> > --
> > Jani Nikula, Intel Open Source Graphics Center
