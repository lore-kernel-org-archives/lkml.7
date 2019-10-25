Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3CF21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v78dJxug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfJYTBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:01:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36164 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJYTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:01:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so3908789ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wFvTsWNvHJ0WjeT2ge2ILK79JvBVN7ahbjSFyxAR7pU=;
        b=v78dJxugprqotYddXPTzIHDXQSAzW913b2mUSaMFrraFzeBt3Gv9qTo5GUsA3NCsWp
         isa7IL0xKSppXymDvd9mTTBVXIYn9QSjp6bnQhmHyV9lmmgVF9/t8mGEY7zLRp71htRO
         gLlIzxcowaFlVv7WJ5TOqgqkKYjMF1koDORRgfHxYCclB4kLnTPYZAnsa44fCkBBNj5/
         gh5ySPVt3Gln6rKSWty5E+qNev4vJi+OgOH7mBTs75CSPEMvzayyGrXqhDbFcpnxJqoM
         JcK1PFn2OtnzlYGJZ8dmDWa76bqdcScdsYtoAiQl7MTW45J6v2wT8me9SFsIUx/gmHnq
         cMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wFvTsWNvHJ0WjeT2ge2ILK79JvBVN7ahbjSFyxAR7pU=;
        b=J9AL58czMAWkG0JHz61usmGgaIeb/8zhfYuArDOxQ3enFBrCiSHFVayd5K8wozuSo+
         i4j5PHka3IQu7c10+nqD3Z5Md9emW019x2dCgL4maxMsdQSTLXptcTCrpoPdvm3Lpli4
         m2jpCieVdwO6aNX1pcq1GSp4/5GrEUsA7urRmrSFvRnfY4aYh0l9NjFXuHSf3bEgsMwA
         ZCiY4JT8fx63S4zJFKZPFuvuLhSOMmemJEHElmzd6wqXFyJTKX5+1d8+2il5xkFKnys3
         5ziT8ECPZQdJKaGqocVqoX2tDfKbvCrDwl0ZnSHZpBctMTizvVAERMdeezZ3ker4KJ81
         tYiA==
X-Gm-Message-State: APjAAAWLHIdLA7YS3J4nfS3240X2kaq1n9YDPDWapsNsP3ahRwZUDsv6
        cZui1G42q13ZbgptdtknzXA4eM8vJTJ3ZO3Q6QqshA==
X-Google-Smtp-Source: APXvYqxFSfaOsliKazmZ5eJpCmumnqMP2BZkt+/2K7ETI0cBygySHAL7fZJ9CFQ5dJ/sS8ZWldDyOQob+3KKJA1iA20=
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr3088479ljj.112.1572030067022;
 Fri, 25 Oct 2019 12:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191024112040.GE2825247@ulmo>
 <CAA93t1ozojwgVoLCZ=AWx72yddQoiaZCMFG35gQg3mQL9n9Z2w@mail.gmail.com> <20191025113609.GB928835@ulmo>
In-Reply-To: <20191025113609.GB928835@ulmo>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 25 Oct 2019 12:00:29 -0700
Message-ID: <CACK8Z6EfLtT3kSG8r6q_LuV3WpuKs8DvxHO=VieObhPQa3Jgvg@mail.gmail.com>
Subject: Re: [PATCH] drm: Add support for integrated privacy screens
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 4:36 AM Thierry Reding <thierry.reding@gmail.com> w=
rote:
>
> On Thu, Oct 24, 2019 at 01:45:16PM -0700, Rajat Jain wrote:
> > Hi,
> >
> > Thanks for your review and comments. Please see inline below.
> >
> > On Thu, Oct 24, 2019 at 4:20 AM Thierry Reding <thierry.reding@gmail.co=
m> wrote:
> > >
> > > On Tue, Oct 22, 2019 at 05:12:06PM -0700, Rajat Jain wrote:
> > > > Certain laptops now come with panels that have integrated privacy
> > > > screens on them. This patch adds support for such panels by adding
> > > > a privacy-screen property to the drm_connector for the panel, that
> > > > the userspace can then use to control and check the status. The ide=
a
> > > > was discussed here:
> > > >
> > > > https://lkml.org/lkml/2019/10/1/786
> > > >
> > > > ACPI methods are used to identify, query and control privacy screen=
:
> > > >
> > > > * Identifying an ACPI object corresponding to the panel: The patch
> > > > follows ACPI Spec 6.3 (available at
> > > > https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30=
.pdf).
> > > > Pages 1119 - 1123 describe what I believe, is a standard way of
> > > > identifying / addressing "display panels" in the ACPI tables, thus
> > > > allowing kernel to attach ACPI nodes to the panel. IMHO, this abili=
ty
> > > > to identify and attach ACPI nodes to drm connectors may be useful f=
or
> > > > reasons other privacy-screens, in future.
> > > >
> > > > * Identifying the presence of privacy screen, and controlling it, i=
s done
> > > > via ACPI _DSM methods.
> > > >
> > > > Currently, this is done only for the Intel display ports. But in fu=
ture,
> > > > this can be done for any other ports if the hardware becomes availa=
ble
> > > > (e.g. external monitors supporting integrated privacy screens?).
> > > >
> > > > Also, this code can be extended in future to support non-ACPI metho=
ds
> > > > (e.g. using a kernel GPIO driver to toggle a gpio that controls the
> > > > privacy-screen).
> > > >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > >  drivers/gpu/drm/Makefile                |   1 +
> > > >  drivers/gpu/drm/drm_atomic_uapi.c       |   5 +
> > > >  drivers/gpu/drm/drm_connector.c         |  38 +++++
> > > >  drivers/gpu/drm/drm_privacy_screen.c    | 176 ++++++++++++++++++++=
++++
> > > >  drivers/gpu/drm/i915/display/intel_dp.c |   3 +
> > > >  include/drm/drm_connector.h             |  18 +++
> > > >  include/drm/drm_mode_config.h           |   7 +
> > > >  include/drm/drm_privacy_screen.h        |  33 +++++
> > > >  8 files changed, 281 insertions(+)
> > > >  create mode 100644 drivers/gpu/drm/drm_privacy_screen.c
> > > >  create mode 100644 include/drm/drm_privacy_screen.h
> > >
> > > I like this much better than the prior proposal to use sysfs. However
> > > the support currently looks a bit tangled. I realize that we only hav=
e a
> > > single implementation for this in hardware right now, so there's no u=
se
> > > in over-engineering things, but I think we can do a better job from t=
he
> > > start without getting into too many abstractions. See below.
> > >
> > > > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > > > index 82ff826b33cc..e1fc33d69bb7 100644
> > > > --- a/drivers/gpu/drm/Makefile
> > > > +++ b/drivers/gpu/drm/Makefile
> > > > @@ -19,6 +19,7 @@ drm-y       :=3D      drm_auth.o drm_cache.o \
> > > >               drm_syncobj.o drm_lease.o drm_writeback.o drm_client.=
o \
> > > >               drm_client_modeset.o drm_atomic_uapi.o drm_hdcp.o
> > > >
> > > > +drm-$(CONFIG_ACPI) +=3D drm_privacy_screen.o
> > > >  drm-$(CONFIG_DRM_LEGACY) +=3D drm_legacy_misc.o drm_bufs.o drm_con=
text.o drm_dma.o drm_scatter.o drm_lock.o
> > > >  drm-$(CONFIG_DRM_LIB_RANDOM) +=3D lib/drm_random.o
> > > >  drm-$(CONFIG_DRM_VM) +=3D drm_vm.o
> > > > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/dr=
m_atomic_uapi.c
> > > > index 7a26bfb5329c..44131165e4ea 100644
> > > > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > > > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > > > @@ -30,6 +30,7 @@
> > > >  #include <drm/drm_atomic.h>
> > > >  #include <drm/drm_print.h>
> > > >  #include <drm/drm_drv.h>
> > > > +#include <drm/drm_privacy_screen.h>
> > > >  #include <drm/drm_writeback.h>
> > > >  #include <drm/drm_vblank.h>
> > > >
> > > > @@ -766,6 +767,8 @@ static int drm_atomic_connector_set_property(st=
ruct drm_connector *connector,
> > > >                                                  fence_ptr);
> > > >       } else if (property =3D=3D connector->max_bpc_property) {
> > > >               state->max_requested_bpc =3D val;
> > > > +     } else if (property =3D=3D config->privacy_screen_property) {
> > > > +             drm_privacy_screen_set_val(connector, val);
> > >
> > > This doesn't look right. Shouldn't you store the value in the connect=
or
> > > state and then leave it up to the connector driver to set it
> > > appropriately? I think that also has the advantage of untangling this
> > > support a little.
> >
> > Hopefully this gets answered in my explanations below.
> >
> > >
> > > >       } else if (connector->funcs->atomic_set_property) {
> > > >               return connector->funcs->atomic_set_property(connecto=
r,
> > > >                               state, property, val);
> > > > @@ -842,6 +845,8 @@ drm_atomic_connector_get_property(struct drm_co=
nnector *connector,
> > > >               *val =3D 0;
> > > >       } else if (property =3D=3D connector->max_bpc_property) {
> > > >               *val =3D state->max_requested_bpc;
> > > > +     } else if (property =3D=3D config->privacy_screen_property) {
> > > > +             *val =3D drm_privacy_screen_get_val(connector);
> > >
> > > Similarly, I think this can just return the atomic state's value for
> > > this.
> >
> > I did think about having a state variable in software to get and set
> > this. However, I think it is not very far fetched that some platforms
> > may have "hardware kill" switches that allow hardware to switch
> > privacy-screen on and off directly, in addition to the software
> > control that we are implementing. Privacy is a touchy subject in
> > enterprise, and anything that reduces the possibility of having any
> > inconsistency between software state and hardware state is desirable.
> > So in this case, I chose to not have a state in software about this -
> > we just report the hardware state everytime we are asked for it.
>
> So this doesn't really work with atomic KMS, then. The main idea behind
> atomic KMS is that you apply a configuration either completely or not at
> all. So at least for setting this property you'd have to go through the
> state object.
>
> Now, for reading out the property you might be able to get away with the
> above. I'm not sure if that's enough to keep the state up-to-date,
> though. Is there some way for a kill switch to trigger an interrupt or
> other event of some sort so that the state could be kept up-to-date?

I was basically imagining a hardware that I don't have at the moment.
So I do not know the answer, but I think the answer may be yes.

>
> Daniel (or anyone else), do you know of any precedent for state that
> might get modified behind the atomic helpers' back? Seems to me like we
> need to find some point where we can actually read back the current
> "hardware value" of this privacy screen property and store that back
> into the state.
>

I'll wait for suggestions.

What I did not quite understand about the use of a local state in
software is what does this local software state buy us? Even with
local state, in the "set_property" flow, we'll update it at the same
time when we flush it out to hardware. Is it about avoiding an ACPI
call during the "get_property" flow? Also, is it worth it if i brings
with it complexity of interrupt handling?

> >
> > >
> > > >       } else if (connector->funcs->atomic_get_property) {
> > > >               return connector->funcs->atomic_get_property(connecto=
r,
> > > >                               state, property, val);
> > > > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_=
connector.c
> > > > index 4c766624b20d..a31e0382132b 100644
> > > > --- a/drivers/gpu/drm/drm_connector.c
> > > > +++ b/drivers/gpu/drm/drm_connector.c
> > > > @@ -821,6 +821,11 @@ static const struct drm_prop_enum_list drm_pan=
el_orientation_enum_list[] =3D {
> > > >       { DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,  "Right Side Up" },
> > > >  };
> > > >
> > > > +static const struct drm_prop_enum_list drm_privacy_screen_enum_lis=
t[] =3D {
> > > > +     { DRM_PRIVACY_SCREEN_DISABLED, "Disabled" },
> > > > +     { DRM_PRIVACY_SCREEN_ENABLED, "Enabled" },
> > > > +};
> > > > +
> > > >  static const struct drm_prop_enum_list drm_dvi_i_select_enum_list[=
] =3D {
> > > >       { DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I an=
d TV-out */
> > > >       { DRM_MODE_SUBCONNECTOR_DVID,      "DVI-D"     }, /* DVI-I  *=
/
> > > > @@ -2253,6 +2258,39 @@ static void drm_tile_group_free(struct kref =
*kref)
> > > >       kfree(tg);
> > > >  }
> > > >
> > > > +/**
> > > > + * drm_connector_init_privacy_screen_property -
> > > > + *   create and attach the connecter's privacy-screen property.
> > > > + * @connector: connector for which to init the privacy-screen prop=
erty.
> > > > + *
> > > > + * This function creates and attaches the "privacy-screen" propert=
y to the
> > > > + * connector. Initial state of privacy-screen is set to disabled.
> > > > + *
> > > > + * Returns:
> > > > + * Zero on success, negative errno on failure.
> > > > + */
> > > > +int drm_connector_init_privacy_screen_property(struct drm_connecto=
r *connector)
> > > > +{
> > > > +     struct drm_device *dev =3D connector->dev;
> > > > +     struct drm_property *prop;
> > > > +
> > > > +     prop =3D dev->mode_config.privacy_screen_property;
> > > > +     if (!prop) {
> > > > +             prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_=
ENUM,
> > > > +                             "privacy-screen", drm_privacy_screen_=
enum_list,
> > >
> > > Seems to me like the -screen suffix here is somewhat redundant. Yes, =
the
> > > thing that we enable/disable may be called a "privacy screen", but th=
e
> > > property that we enable/disable on the connector is the "privacy" of =
the
> > > user. I'd reflect that in all the related variable names and so on as
> > > well.
> >
> > IMHO a property called "privacy" may be a little generic for the users
> > to understand what it is. For e.g. when I started looking at code, I
> > found the "Content Protection" property and I got confused thinking
> > may be it provides something similar to what I'm trying to do. I think
> > "privacy-screen" conveys the complete context without being long, so
> > there is no confusion or ambiguity. But I don't mind changing it if a
> > property "privacy" is what people think is better to convey what it
> > is, as long as it is clear to user.
>
> This being a property of a display connector it doesn't seem very
> ambiguous to me what this is. How this ends up being presented to the
> users is mostly orthogonal anyway. We've got a bunch of properties whose
> purpose may not be clear to the average user. The properties, while they
> are UABI, don't typically face the user directly. They're still part of
> an API, so as long as they are properly documented there shouldn't be
> any ambiguities.
>

OK, I do not mind changing to whatever is acceptable. Jani / Daniel,
do you have any recommendation here?

> > >
> > > > +                             ARRAY_SIZE(drm_privacy_screen_enum_li=
st));
> > > > +             if (!prop)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             dev->mode_config.privacy_screen_property =3D prop;
> > > > +     }
> > > > +
> > > > +     drm_object_attach_property(&connector->base, prop,
> > > > +                                DRM_PRIVACY_SCREEN_DISABLED);
> > > > +     return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_connector_init_privacy_screen_property);
> > > > +
> > > >  /**
> > > >   * drm_mode_put_tile_group - drop a reference to a tile group.
> > > >   * @dev: DRM device
> > > > diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm=
/drm_privacy_screen.c
> > > > new file mode 100644
> > > > index 000000000000..1d68e8aa6c5f
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/drm_privacy_screen.c
> > > > @@ -0,0 +1,176 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * DRM privacy Screen code
> > > > + *
> > > > + * Copyright =C2=A9 2019 Google Inc.
> > > > + */
> > > > +
> > > > +#include <linux/acpi.h>
> > > > +#include <linux/pci.h>
> > > > +
> > > > +#include <drm/drm_connector.h>
> > > > +#include <drm/drm_device.h>
> > > > +#include <drm/drm_print.h>
> > > > +
> > > > +#define DRM_CONN_DSM_REVID 1
> > > > +
> > > > +#define DRM_CONN_DSM_FN_PRIVACY_GET_STATUS   1
> > > > +#define DRM_CONN_DSM_FN_PRIVACY_ENABLE               2
> > > > +#define DRM_CONN_DSM_FN_PRIVACY_DISABLE              3
> > > > +
> > > > +static const guid_t drm_conn_dsm_guid =3D
> > > > +     GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> > > > +               0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> > > > +
> > > > +/*
> > > > + * Makes _DSM call to set privacy screen status or get privacy scr=
een. Return
> > > > + * value matters only for PRIVACY_GET_STATUS case. Returns 0 if di=
sabled, 1 if
> > > > + * enabled.
> > > > + */
> > > > +static int acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u=
64 func)
> > > > +{
> > > > +     union acpi_object *obj;
> > > > +     int ret =3D 0;
> > > > +
> > > > +     obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
> > > > +                             DRM_CONN_DSM_REVID, func, NULL);
> > > > +     if (!obj) {
> > > > +             DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx=
\n", func);
> > > > +             /* Can't do much. For get_val, assume privacy_screen =
disabled */
> > > > +             goto done;
> > > > +     }
> > > > +
> > > > +     if (func =3D=3D DRM_CONN_DSM_FN_PRIVACY_GET_STATUS &&
> > > > +         obj->type =3D=3D ACPI_TYPE_INTEGER)
> > > > +             ret =3D !!obj->integer.value;
> > > > +done:
> > > > +     ACPI_FREE(obj);
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +void drm_privacy_screen_set_val(struct drm_connector *connector,
> > > > +                              enum drm_privacy_screen val)
> > > > +{
> > > > +     acpi_handle acpi_handle =3D connector->privacy_screen_handle;
> > > > +
> > > > +     if (!acpi_handle)
> > > > +             return;
> > > > +
> > > > +     if (val =3D=3D DRM_PRIVACY_SCREEN_DISABLED)
> > > > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > > > +                                          DRM_CONN_DSM_FN_PRIVACY_=
DISABLE);
> > > > +     else if (val =3D=3D DRM_PRIVACY_SCREEN_ENABLED)
> > > > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > > > +                                          DRM_CONN_DSM_FN_PRIVACY_=
ENABLE);
> > > > +}
> > > > +
> > > > +enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_conn=
ector
> > > > +                                                *connector)
> > > > +{
> > > > +     acpi_handle acpi_handle =3D connector->privacy_screen_handle;
> > > > +
> > > > +     if (acpi_handle &&
> > > > +         acpi_privacy_screen_call_dsm(acpi_handle,
> > > > +                                      DRM_CONN_DSM_FN_PRIVACY_GET_=
STATUS))
> > > > +             return DRM_PRIVACY_SCREEN_ENABLED;
> > > > +
> > > > +     return DRM_PRIVACY_SCREEN_DISABLED;
> > > > +}
> > > > +
> > > > +/*
> > > > + * See ACPI Spec v6.3, Table B-2, "Display Type" for details.
> > > > + * In short, these macros define the base _ADR values for ACPI nod=
es
> > > > + */
> > > > +#define ACPI_BASE_ADR_FOR_OTHERS     (0ULL << 8)
> > > > +#define ACPI_BASE_ADR_FOR_VGA                (1ULL << 8)
> > > > +#define ACPI_BASE_ADR_FOR_TV         (2ULL << 8)
> > > > +#define ACPI_BASE_ADR_FOR_EXT_MON    (3ULL << 8)
> > > > +#define ACPI_BASE_ADR_FOR_INTEGRATED (4ULL << 8)
> > > > +
> > > > +#define ACPI_DEVICE_ID_SCHEME                (1ULL << 31)
> > > > +#define ACPI_FIRMWARE_CAN_DETECT     (1ULL << 16)
> > > > +
> > > > +/*
> > > > + * Ref: ACPI Spec 6.3
> > > > + * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_J=
an30.pdf
> > > > + * Pages 1119 - 1123 describe, what I believe, a standard way of
> > > > + * identifying / addressing "display panels" in the ACPI. Thus it =
provides
> > > > + * a way for the ACPI to define devices for the display panels att=
ached
> > > > + * to the system. It thus provides a way for the BIOS to export an=
y panel
> > > > + * specific properties to the system via ACPI (like device trees).
> > > > + *
> > > > + * The following function looks up the ACPI node for a connector a=
nd links
> > > > + * to it. Technically it is independent from the privacy_screen co=
de, and
> > > > + * ideally may be called for all connectors. It is generally a goo=
d idea to
> > > > + * be able to attach an ACPI node to describe anything if needed. =
(This can
> > > > + * help in future for other panel specific features maybe). Howeve=
r, it
> > > > + * needs a "port index" which I believe is the index within a part=
icular
> > > > + * type of port (Ref to the pages of spec mentioned above). This p=
ort index
> > > > + * unfortunately is not available in DRM code, so currently its ca=
ll is
> > > > + * originated from i915 driver.
> > > > + */
> > > > +static int drm_connector_attach_acpi_node(struct drm_connector *co=
nnector,
> > > > +                                       u8 port_index)
> > > > +{
> > > > +     struct device *dev =3D &connector->dev->pdev->dev;
> > > > +     struct acpi_device *conn_dev;
> > > > +     u64 conn_addr;
> > > > +
> > > > +     /*
> > > > +      * Determine what _ADR to look for, depending on device type =
and
> > > > +      * port number. Potentially we only care about the
> > > > +      * eDP / integrated displays?
> > > > +      */
> > > > +     switch (connector->connector_type) {
2) > > > > +     case DRM_MODE_CONNECTOR_eDP:
> > > > +             conn_addr =3D ACPI_BASE_ADR_FOR_INTEGRATED + port_ind=
ex;
> > > > +             break;
> > > > +     case DRM_MODE_CONNECTOR_VGA:
> > > > +             conn_addr =3D ACPI_BASE_ADR_FOR_VGA + port_index;
> > > > +             break;
> > > > +     case DRM_MODE_CONNECTOR_TV:
> > > > +             conn_addr =3D ACPI_BASE_ADR_FOR_TV + port_index;
> > > > +             break;
> > > > +     case DRM_MODE_CONNECTOR_DisplayPort:
> > > > +             conn_addr =3D ACPI_BASE_ADR_FOR_EXT_MON + port_index;
> > > > +             break;
> > > > +     default:
> > > > +             return -ENOTSUPP;
> > > > +     }
> > > > +
> > > > +     conn_addr |=3D ACPI_DEVICE_ID_SCHEME;
> > > > +     conn_addr |=3D ACPI_FIRMWARE_CAN_DETECT;
> > > > +
> > > > +     DRM_DEV_DEBUG(dev, "%s: Finding drm_connector ACPI node at _A=
DR=3D%llX\n",
> > > > +                   __func__, conn_addr);
> > > > +
> > > > +     /* Look up the connector device, under the PCI device */
> > > > +     conn_dev =3D acpi_find_child_device(ACPI_COMPANION(dev),
> > > > +                                       conn_addr, false);
> > > > +     if (!conn_dev)
> > > > +             return -ENODEV;
> > > > +
> > > > +     connector->privacy_screen_handle =3D conn_dev->handle;
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +bool drm_privacy_screen_present(struct drm_connector *connector, u=
8 port_index)
> > >
> > > This is the main part that I think is a little tangled. This is a ver=
y
> > > specific implementation that hides in a generic API.
> >
> > I agree that this is an ACPI specific implementation, but other than
> > that, I think it does not have any driver specific details. More
> > detailed thoughts on this below.
>
> Well, the port_index kind of ties this to i915 because that uses this
> concept. Other drivers may not.
>
> Also, I'm wondering if you couldn't somehow derive the port_index from
> the connector. If all this does is to find an ACPI node corresponding to
> a connector, shouldn't the connector really be all that you need?
>

Yes, I agree that finding an ACPI node corresponding to a connector,
should require only the info that the connector already has.

> > > I we store the privacy setting in the atomic state, there isn't reall=
y a
> > > reason to store the privacy handle in the connector. Instead it could=
 be
> > > simply stored in the driver that supports this.
> > >
> > > Ideally I think we'd have a very small drm_privacy_screen object type
> > > that would just wrap this, but perhaps we don't need that right away,
> > > given that we only have a single implementation so far.
> >
> > Yes, agreed.
> >
> > >
> > > However, I think if we just pushed this specific implementation into =
the
> > > drivers that'd help pave the way for something more generic later on
> > > without a lot of extra work up front.
> > >
> > > For example you could turn the drm_connector_attach_acpi_node() into =
a
> > > helper that simply returns the ACPI handle, something like this perha=
ps:
> > >
> > >         struct acpi_handle *drm_acpi_find_privacy_screen(struct drm_c=
onnector *connector,
> > >                                                          unsigned int=
 port)
> > >         {
> > >                 ...
> > >         }
> >
> > Yes, I like that idea of making it a helper function. In fact, finding
> > an ACPI node for the connector doesn't have to do anything with
> > privacy screen (so it can be used for other purposes also, in future).
>
> Looks like I misunderstood the purpose of that function. You store the
> ACPI handle as connector->privacy_screen_handle, so I was assuming that
> it was getting an ACPI handle for some privacy screen subdevice.
>
> > > That the i915 driver would then call and store the returned value
> > > internally. When it commits the atomic state for the connector it can
> > > then call the drm_acpi_set_privacy() (I think that'd be a better name
> > > for your drm_privacy_screen_set_val()) by passing that handle and the
> > > value from the atomic state.
> > >
> > > The above has the advantage that we don't clutter the generic core wi=
th
> > > something that's not at all generic. If eventually we see that these
> > > types of privacy screens are implemented in more device we can always
> > > refactor this into something really generic and maybe even decide to =
put
> > > it into the drm_connector directly.
> >
> > This is where I think I'm in slight disagreement. I think the
> > functionality we're adding is still "generic", just that the only
> > hardware *I have today* to test is using Intel eDP ports. But I don't
> > see why AMD CPU laptops can't have it (For E.g. HP's Elitebook 745 G5
> > seems to use AMD and has integrated privacy screen feature
> > http://www8.hp.com/h20195/V2/GetPDF.aspx/4aa7-2802eee) .
> > My worry is that if we don't make it generic today, we might see
> > duplicate / similar-but-different / different ways of this in other
> > places (e.g. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/commit/?id=3D110ea1d833ad)
> > because unless it is generic to start with, it is difficult for some
> > one to change later for the fear of breaking hardware that is already
> > in market given that
> >  * hardware may not be available to new developer to test for
> > regressions (also there is very little motivation to check any
> > hardware other than your own).
> >  * specially for a code that relies on firmware ACPI (firmware
> > upgrades in field are always costly).
> >
> > My understanding is that we're adding 2 functionalities here:
> >
> > 1) Identify and Attach ACPI node to DRM connector. Since this is
> > following ACPI spec, I think this is  generic enough.
>
> It's probably worth making this a separate patch in that case. If the
> ACPI handle really represents the connector itself, then it seems fine
> to store it in the connector. But it shouldn't be called privacy_screen
> in that case.

Yes, I agree.

>
> > 2) Use ACPI _DSM mthods to identify screen, set and get values. This
> > is where I think we're setting (generic) expectations for the ACPI
> > methods in how they should behave if ACPI is to be used to control
> > privacy screen. If we put this in generic code today, future
> > developers can look at this to understand how their ACPI for new
> > platforms is to behave if they want to use this generic code. If we
> > put it in i915 specific code, this will be seen as driver specific
> > behavior and developers may choose some other behavior in their
> > driver.
>
> I think it's fine to put this functionality into generic code. What I
> don't think is good to do is to have this code called from generic code.
> It's opt-in functionality that drivers should call if they know that the
> connector has an associated ACPI handle that can be used for privacy
> screen control.

Ah, OK, I see where the disconnect was. Sure, I think we are converging now=
.

>
> After reading the patch again and realizing that you're not actually
> dealing with an ACPI handle to the privacy screen directly but one for
> the connector, I think this is okay. You do in fact call into this from
> the i915 only. I still don't think the naming is great, and it'd be nice
> to see ACPI as part of the function name to make that explicit. We could
> always address that at a later point, but may as well do it right from
> the start.

Sure, I agree and will change the naming.

>
> > I agree that the functionality we're adding is ACPI specific (today -
> > but can be extended to gpio in future for non x86 platforms), but not
> > necessarily driver specific. Actually the only reason, I had to call
> > the drm_privacy_screen_present() (and the
> > drm_init_privacy_screen_property()) function from i915 code is because
> > we need a port_index to lookup ACPI node. If we had that available in
> > drm code, we wouldn't need to call anything from i915 at all.
>
> You're kind of proving my point about this API being driver-specific, or
> at least ACPI specific. Non-ACPI devices (maybe even non-i915 devices?)
> may not have a concept of a port index. Encoding this in the API makes
> the API non-generic.
>
> As I mentioned above, if we could derive the port index from the
> connector, that'd be much better. Could you perhaps use drm_connector's
> index field?

That's a good idea. I'll check it out to see if it matches my needs.
If it does, I think we might have found a way to make it totally
separate from i915. I don't have a vast range of test hardware and
monitors etc to test though. So I'll test with what I have available.

I'll keep you updated.

>
> Unless there's a way to reliably detect this type of functionality from
> generic code, I think it should always be called from the driver.
>
> > So, for the reasons stated above, IMHO it is better to retain this
> > functionality in drm code instead of i915 driver. But I'm new to the
> > drm / i915 code, and would be happy to change my code if people have
> > strong opinions about this. Let me know.
>
> Maybe I was being unclear. I wasn't arguing that all the code should be
> moved into the i915 driver. All I was saying that instead of storing the
> ACPI handle inside struct drm_connector, we should maybe store it inside
> the i915 driver's connector structure. struct drm_connector is a very
> generic concept and each and every connector object on every platform
> will get that ACPI handle pointer if you add it there. I don't think an
> ACPI handle belongs there. For example, on ARM SoCs it's common to have
> connectors be backed by a struct device (or struct platform_device more
> specifically). But we don't put that information into drm_connector
> because PCI graphics adapters don't have a struct device that represents
> the connector.

OK, I understand what you are saying. The ACPI handle essentially
denotes the firmware node for that drm_connector device, analogous to
the device tree nodes. Ideally, I wanted to have it stored in the
drm_connector->kdev->fwnode which I think was the best place as it
would also make the ACPI node visible in the sysfs like it is visible
for PCI devices today. Unfortunately I found that the
drm_connector->kdev is not created at the time when I need to lookup
and register privacy screen (kdev is created much later), so that is
not an option. Note that the drm_privacy_screen_set_val() and
drm_privacy_screen_get_val() will need to access this ACPI handle to
do their jobs. So unless I move that code or the property representing
privacy screen also into i915, I can't really put that handle in i915.

Thanks,

Rajat



>
> Thierry
>
> >
> > Thanks & Best Regards,
> >
> > Rajat
> >
> > >
> > > > +{
> > > > +     acpi_handle handle;
> > > > +
> > > > +     if (drm_connector_attach_acpi_node(connector, port_index))
> > > > +             return false;
> > > > +
> > > > +     handle =3D connector->privacy_screen_handle;
> > > > +     if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
> > > > +                         DRM_CONN_DSM_REVID,
> > > > +                         1 << DRM_CONN_DSM_FN_PRIVACY_GET_STATUS |
> > > > +                         1 << DRM_CONN_DSM_FN_PRIVACY_ENABLE |
> > > > +                         1 << DRM_CONN_DSM_FN_PRIVACY_DISABLE)) {
> > > > +             DRM_WARN("%s: Odd, connector ACPI node but no privacy=
 scrn?\n",
> > > > +                      connector->dev->dev);
> > > > +             return false;
> > > > +     }
> > > > +     DRM_DEV_INFO(connector->dev->dev, "supports privacy screen\n"=
);
> > > > +     return true;
> > > > +}
> > > > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/=
drm/i915/display/intel_dp.c
> > > > index 57e9f0ba331b..3ff3962d27db 100644
> > > > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > > > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > > > @@ -39,6 +39,7 @@
> > > >  #include <drm/drm_dp_helper.h>
> > > >  #include <drm/drm_edid.h>
> > > >  #include <drm/drm_hdcp.h>
> > > > +#include <drm/drm_privacy_screen.h>
> > > >  #include <drm/drm_probe_helper.h>
> > > >  #include <drm/i915_drm.h>
> > > >
> > > > @@ -6354,6 +6355,8 @@ intel_dp_add_properties(struct intel_dp *inte=
l_dp, struct drm_connector *connect
> > > >
> > > >               connector->state->scaling_mode =3D DRM_MODE_SCALE_ASP=
ECT;
> > > >
> > > > +             if (drm_privacy_screen_present(connector, port - PORT=
_A))
> > > > +                     drm_connector_init_privacy_screen_property(co=
nnector);
> > > >       }
> > > >  }
> > > >
> > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connecto=
r.h
> > > > index 681cb590f952..63b8318bd68c 100644
> > > > --- a/include/drm/drm_connector.h
> > > > +++ b/include/drm/drm_connector.h
> > > > @@ -225,6 +225,20 @@ enum drm_link_status {
> > > >       DRM_LINK_STATUS_BAD =3D DRM_MODE_LINK_STATUS_BAD,
> > > >  };
> > > >
> > > > +/**
> > > > + * enum drm_privacy_screen - privacy_screen status
> > > > + *
> > > > + * This enum is used to track and control the state of the privacy=
 screen.
> > > > + * There are no separate #defines for the uapi!
> > > > + *
> > > > + * @DRM_PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel i=
s disabled
> > > > + * @DRM_PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel i=
s enabled
> > > > + */
> > > > +enum drm_privacy_screen {
> > > > +     DRM_PRIVACY_SCREEN_DISABLED =3D 0,
> > > > +     DRM_PRIVACY_SCREEN_ENABLED =3D 1,
> > > > +};
> > > > +
> > >
> > > Shouldn't this go into include/uapi/drm/drm_mode.h? That would have t=
he
> > > advantage of giving userspace symbolic names to use when setting the
> > > property.
> > >
> > > Maybe also rename these to something like:
> > >
> > >         #define DRM_MODE_PRIVACY_DISABLED 0
> > >         #define DRM_MODE_PRIVACY_ENABLED 1
> > >
> > > for consistency with other properties.
> > >
> > > Thierry
> > >
> > > >  /**
> > > >   * enum drm_panel_orientation - panel_orientation info for &drm_di=
splay_info
> > > >   *
> > > > @@ -1410,6 +1424,9 @@ struct drm_connector {
> > > >
> > > >       /** @hdr_sink_metadata: HDR Metadata Information read from si=
nk */
> > > >       struct hdr_sink_metadata hdr_sink_metadata;
> > > > +
> > > > +     /* Handle used by privacy screen code */
> > > > +     void *privacy_screen_handle;
> > > >  };
> > > >
> > > >  #define obj_to_connector(x) container_of(x, struct drm_connector, =
base)
> > > > @@ -1543,6 +1560,7 @@ int drm_connector_init_panel_orientation_prop=
erty(
> > > >       struct drm_connector *connector, int width, int height);
> > > >  int drm_connector_attach_max_bpc_property(struct drm_connector *co=
nnector,
> > > >                                         int min, int max);
> > > > +int drm_connector_init_privacy_screen_property(struct drm_connecto=
r *connector);
> > > >
> > > >  /**
> > > >   * struct drm_tile_group - Tile group metadata
> > > > diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_c=
onfig.h
> > > > index 3bcbe30339f0..6d5d23da90d4 100644
> > > > --- a/include/drm/drm_mode_config.h
> > > > +++ b/include/drm/drm_mode_config.h
> > > > @@ -813,6 +813,13 @@ struct drm_mode_config {
> > > >        */
> > > >       struct drm_property *panel_orientation_property;
> > > >
> > > > +     /**
> > > > +      * @privacy_screen_property: Optional connector property to i=
ndicate
> > > > +      * and control the state (enabled / disabled) of privacy-scre=
en on the
> > > > +      * panel, if present.
> > > > +      */
> > > > +     struct drm_property *privacy_screen_property;
> > > > +
> > > >       /**
> > > >        * @writeback_fb_id_property: Property for writeback connecto=
rs, storing
> > > >        * the ID of the output framebuffer.
> > > > diff --git a/include/drm/drm_privacy_screen.h b/include/drm/drm_pri=
vacy_screen.h
> > > > new file mode 100644
> > > > index 000000000000..c589bbc47656
> > > > --- /dev/null
> > > > +++ b/include/drm/drm_privacy_screen.h
> > > > @@ -0,0 +1,33 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > > +/*
> > > > + * Copyright =C2=A9 2019 Google Inc.
> > > > + */
> > > > +
> > > > +#ifndef __DRM_PRIVACY_SCREEN_H__
> > > > +#define __DRM_PRIVACY_SCREEN_H__
> > > > +
> > > > +#ifdef CONFIG_ACPI
> > > > +bool drm_privacy_screen_present(struct drm_connector *connector, u=
8 port);
> > > > +void drm_privacy_screen_set_val(struct drm_connector *connector,
> > > > +                             enum drm_privacy_screen val);
> > > > +enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_conn=
ector
> > > > +                                                *connector);
> > > > +#else
> > > > +static inline bool drm_privacy_screen_present(struct drm_connector=
 *connector,
> > > > +                                           u8 port)
> > > > +{
> > > > +     return false;
> > > > +}
> > > > +
> > > > +void drm_privacy_screen_set_val(struct drm_connector *connector,
> > > > +                             enum drm_privacy_screen val)
> > > > +{ }
> > > > +
> > > > +enum drm_privacy_screen drm_privacy_screen_get_val(
> > > > +                                     struct drm_connector *connect=
or)
> > > > +{
> > > > +     return DRM_PRIVACY_SCREEN_DISABLED;
> > > > +}
> > > > +#endif /* CONFIG_ACPI */
> > > > +
> > > > +#endif /* __DRM_PRIVACY_SCREEN_H__ */
> > > > --
> > > > 2.23.0.866.gb869b98d4c-goog
> > > >
