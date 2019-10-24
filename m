Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3ABCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623A721A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLXApilY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfJXUpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:45:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35892 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfJXUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:45:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id y189so24766122qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BkvUqkcBoeKsIvBA/62Na4ojYX4B9wROqCfCdA19sU0=;
        b=kLXApilYIyrN7Ma0X9eH+WlHKWMxC33nTQWxaz7g8u//kfwHUCpuQfgigpO9kbdRMB
         DFVhRlh1jug6vB/y+EfMHEvuVw8S4Bm4F/bHuWU9iNBhG105DMq9KsJ9Cnr+QTYxWeRr
         skJGBHnBF25aCKZOpr7ObXNFyIsUswZioOP4g8eOnr6rmuZoaN9+zgfFgc1bXhv4XcAQ
         CU+LYXvBr9PEjbWxYYiC+lL1fy98OPFL0w/0jj1XYa4KQWHhu0ZZkBw6X5byO7GU1XZv
         pAeesk4y5KGxx9wVrVUEIzd3HI476HN3Cpt7MP1eretOZkHLQJ4hbuDSfXGy9LLSRS9L
         NCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BkvUqkcBoeKsIvBA/62Na4ojYX4B9wROqCfCdA19sU0=;
        b=MgSg9cTdgypd6nlss8PDmY9iLys92lemaKbJThLJo3esPIAUr0l9So2ldvtyqGdyiW
         pKXSxT8Wxuj83/OwI9KaEzizhhWbZZ0Mv3CbkvZLMPlSd8MZrleDRAhv4d3dL1htIw3o
         3cSF04+KSNnRot+vTTgbXKeUHTvsC1caJ3hGu9mFGhlmMb1L0iZo5VkHpeSzdzNLkCN4
         zpxJ5ip40Q3xgyggBs3v5h1bKIIfxDjY8ZgoJJfLPMsj5ZhxzKkdkB43n+0wBtylBRPT
         lNnVOJvjKfFQ5OOPSb0GBFxLEjCnyL0zPlpbdCA7v0xFZQTdOlpGJt+olGqGxVtLfpNE
         96Aw==
X-Gm-Message-State: APjAAAW6lgIujd6zQ7Zazt2Ey7vMnPZtY0hShvPki+7Xtlt0K2mWMTVQ
        QJjhb0n9Ac2p0IDAQvY0XKwYUI0LooadVi4cyCQ=
X-Google-Smtp-Source: APXvYqwyHdU+oq9FpXx/QNdpyItSFFBx0x0d8p4Yyim3xAHpyzV4PGEXUd2ux6H5aiKOhSAaQJ/zT0A3v/88V43EHrA=
X-Received: by 2002:a05:620a:78e:: with SMTP id 14mr15646087qka.483.1571949927465;
 Thu, 24 Oct 2019 13:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191024112040.GE2825247@ulmo>
In-Reply-To: <20191024112040.GE2825247@ulmo>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Thu, 24 Oct 2019 13:45:16 -0700
Message-ID: <CAA93t1ozojwgVoLCZ=AWx72yddQoiaZCMFG35gQg3mQL9n9Z2w@mail.gmail.com>
Subject: Re: [PATCH] drm: Add support for integrated privacy screens
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Greg KH <gregkh@linuxfoundation.org>, mathewk@google.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review and comments. Please see inline below.

On Thu, Oct 24, 2019 at 4:20 AM Thierry Reding <thierry.reding@gmail.com> w=
rote:
>
> On Tue, Oct 22, 2019 at 05:12:06PM -0700, Rajat Jain wrote:
> > Certain laptops now come with panels that have integrated privacy
> > screens on them. This patch adds support for such panels by adding
> > a privacy-screen property to the drm_connector for the panel, that
> > the userspace can then use to control and check the status. The idea
> > was discussed here:
> >
> > https://lkml.org/lkml/2019/10/1/786
> >
> > ACPI methods are used to identify, query and control privacy screen:
> >
> > * Identifying an ACPI object corresponding to the panel: The patch
> > follows ACPI Spec 6.3 (available at
> > https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf=
).
> > Pages 1119 - 1123 describe what I believe, is a standard way of
> > identifying / addressing "display panels" in the ACPI tables, thus
> > allowing kernel to attach ACPI nodes to the panel. IMHO, this ability
> > to identify and attach ACPI nodes to drm connectors may be useful for
> > reasons other privacy-screens, in future.
> >
> > * Identifying the presence of privacy screen, and controlling it, is do=
ne
> > via ACPI _DSM methods.
> >
> > Currently, this is done only for the Intel display ports. But in future=
,
> > this can be done for any other ports if the hardware becomes available
> > (e.g. external monitors supporting integrated privacy screens?).
> >
> > Also, this code can be extended in future to support non-ACPI methods
> > (e.g. using a kernel GPIO driver to toggle a gpio that controls the
> > privacy-screen).
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/gpu/drm/Makefile                |   1 +
> >  drivers/gpu/drm/drm_atomic_uapi.c       |   5 +
> >  drivers/gpu/drm/drm_connector.c         |  38 +++++
> >  drivers/gpu/drm/drm_privacy_screen.c    | 176 ++++++++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_dp.c |   3 +
> >  include/drm/drm_connector.h             |  18 +++
> >  include/drm/drm_mode_config.h           |   7 +
> >  include/drm/drm_privacy_screen.h        |  33 +++++
> >  8 files changed, 281 insertions(+)
> >  create mode 100644 drivers/gpu/drm/drm_privacy_screen.c
> >  create mode 100644 include/drm/drm_privacy_screen.h
>
> I like this much better than the prior proposal to use sysfs. However
> the support currently looks a bit tangled. I realize that we only have a
> single implementation for this in hardware right now, so there's no use
> in over-engineering things, but I think we can do a better job from the
> start without getting into too many abstractions. See below.
>
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 82ff826b33cc..e1fc33d69bb7 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -19,6 +19,7 @@ drm-y       :=3D      drm_auth.o drm_cache.o \
> >               drm_syncobj.o drm_lease.o drm_writeback.o drm_client.o \
> >               drm_client_modeset.o drm_atomic_uapi.o drm_hdcp.o
> >
> > +drm-$(CONFIG_ACPI) +=3D drm_privacy_screen.o
> >  drm-$(CONFIG_DRM_LEGACY) +=3D drm_legacy_misc.o drm_bufs.o drm_context=
.o drm_dma.o drm_scatter.o drm_lock.o
> >  drm-$(CONFIG_DRM_LIB_RANDOM) +=3D lib/drm_random.o
> >  drm-$(CONFIG_DRM_VM) +=3D drm_vm.o
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_at=
omic_uapi.c
> > index 7a26bfb5329c..44131165e4ea 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -30,6 +30,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_print.h>
> >  #include <drm/drm_drv.h>
> > +#include <drm/drm_privacy_screen.h>
> >  #include <drm/drm_writeback.h>
> >  #include <drm/drm_vblank.h>
> >
> > @@ -766,6 +767,8 @@ static int drm_atomic_connector_set_property(struct=
 drm_connector *connector,
> >                                                  fence_ptr);
> >       } else if (property =3D=3D connector->max_bpc_property) {
> >               state->max_requested_bpc =3D val;
> > +     } else if (property =3D=3D config->privacy_screen_property) {
> > +             drm_privacy_screen_set_val(connector, val);
>
> This doesn't look right. Shouldn't you store the value in the connector
> state and then leave it up to the connector driver to set it
> appropriately? I think that also has the advantage of untangling this
> support a little.

Hopefully this gets answered in my explanations below.

>
> >       } else if (connector->funcs->atomic_set_property) {
> >               return connector->funcs->atomic_set_property(connector,
> >                               state, property, val);
> > @@ -842,6 +845,8 @@ drm_atomic_connector_get_property(struct drm_connec=
tor *connector,
> >               *val =3D 0;
> >       } else if (property =3D=3D connector->max_bpc_property) {
> >               *val =3D state->max_requested_bpc;
> > +     } else if (property =3D=3D config->privacy_screen_property) {
> > +             *val =3D drm_privacy_screen_get_val(connector);
>
> Similarly, I think this can just return the atomic state's value for
> this.

I did think about having a state variable in software to get and set
this. However, I think it is not very far fetched that some platforms
may have "hardware kill" switches that allow hardware to switch
privacy-screen on and off directly, in addition to the software
control that we are implementing. Privacy is a touchy subject in
enterprise, and anything that reduces the possibility of having any
inconsistency between software state and hardware state is desirable.
So in this case, I chose to not have a state in software about this -
we just report the hardware state everytime we are asked for it.

>
> >       } else if (connector->funcs->atomic_get_property) {
> >               return connector->funcs->atomic_get_property(connector,
> >                               state, property, val);
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_conn=
ector.c
> > index 4c766624b20d..a31e0382132b 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -821,6 +821,11 @@ static const struct drm_prop_enum_list drm_panel_o=
rientation_enum_list[] =3D {
> >       { DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,  "Right Side Up" },
> >  };
> >
> > +static const struct drm_prop_enum_list drm_privacy_screen_enum_list[] =
=3D {
> > +     { DRM_PRIVACY_SCREEN_DISABLED, "Disabled" },
> > +     { DRM_PRIVACY_SCREEN_ENABLED, "Enabled" },
> > +};
> > +
> >  static const struct drm_prop_enum_list drm_dvi_i_select_enum_list[] =
=3D {
> >       { DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I and TV=
-out */
> >       { DRM_MODE_SUBCONNECTOR_DVID,      "DVI-D"     }, /* DVI-I  */
> > @@ -2253,6 +2258,39 @@ static void drm_tile_group_free(struct kref *kre=
f)
> >       kfree(tg);
> >  }
> >
> > +/**
> > + * drm_connector_init_privacy_screen_property -
> > + *   create and attach the connecter's privacy-screen property.
> > + * @connector: connector for which to init the privacy-screen property=
.
> > + *
> > + * This function creates and attaches the "privacy-screen" property to=
 the
> > + * connector. Initial state of privacy-screen is set to disabled.
> > + *
> > + * Returns:
> > + * Zero on success, negative errno on failure.
> > + */
> > +int drm_connector_init_privacy_screen_property(struct drm_connector *c=
onnector)
> > +{
> > +     struct drm_device *dev =3D connector->dev;
> > +     struct drm_property *prop;
> > +
> > +     prop =3D dev->mode_config.privacy_screen_property;
> > +     if (!prop) {
> > +             prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_ENUM=
,
> > +                             "privacy-screen", drm_privacy_screen_enum=
_list,
>
> Seems to me like the -screen suffix here is somewhat redundant. Yes, the
> thing that we enable/disable may be called a "privacy screen", but the
> property that we enable/disable on the connector is the "privacy" of the
> user. I'd reflect that in all the related variable names and so on as
> well.

IMHO a property called "privacy" may be a little generic for the users
to understand what it is. For e.g. when I started looking at code, I
found the "Content Protection" property and I got confused thinking
may be it provides something similar to what I'm trying to do. I think
"privacy-screen" conveys the complete context without being long, so
there is no confusion or ambiguity. But I don't mind changing it if a
property "privacy" is what people think is better to convey what it
is, as long as it is clear to user.

>
> > +                             ARRAY_SIZE(drm_privacy_screen_enum_list))=
;
> > +             if (!prop)
> > +                     return -ENOMEM;
> > +
> > +             dev->mode_config.privacy_screen_property =3D prop;
> > +     }
> > +
> > +     drm_object_attach_property(&connector->base, prop,
> > +                                DRM_PRIVACY_SCREEN_DISABLED);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(drm_connector_init_privacy_screen_property);
> > +
> >  /**
> >   * drm_mode_put_tile_group - drop a reference to a tile group.
> >   * @dev: DRM device
> > diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm=
_privacy_screen.c
> > new file mode 100644
> > index 000000000000..1d68e8aa6c5f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/drm_privacy_screen.c
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * DRM privacy Screen code
> > + *
> > + * Copyright =C2=A9 2019 Google Inc.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/pci.h>
> > +
> > +#include <drm/drm_connector.h>
> > +#include <drm/drm_device.h>
> > +#include <drm/drm_print.h>
> > +
> > +#define DRM_CONN_DSM_REVID 1
> > +
> > +#define DRM_CONN_DSM_FN_PRIVACY_GET_STATUS   1
> > +#define DRM_CONN_DSM_FN_PRIVACY_ENABLE               2
> > +#define DRM_CONN_DSM_FN_PRIVACY_DISABLE              3
> > +
> > +static const guid_t drm_conn_dsm_guid =3D
> > +     GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> > +               0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> > +
> > +/*
> > + * Makes _DSM call to set privacy screen status or get privacy screen.=
 Return
> > + * value matters only for PRIVACY_GET_STATUS case. Returns 0 if disabl=
ed, 1 if
> > + * enabled.
> > + */
> > +static int acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 f=
unc)
> > +{
> > +     union acpi_object *obj;
> > +     int ret =3D 0;
> > +
> > +     obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
> > +                             DRM_CONN_DSM_REVID, func, NULL);
> > +     if (!obj) {
> > +             DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n",=
 func);
> > +             /* Can't do much. For get_val, assume privacy_screen disa=
bled */
> > +             goto done;
> > +     }
> > +
> > +     if (func =3D=3D DRM_CONN_DSM_FN_PRIVACY_GET_STATUS &&
> > +         obj->type =3D=3D ACPI_TYPE_INTEGER)
> > +             ret =3D !!obj->integer.value;
> > +done:
> > +     ACPI_FREE(obj);
> > +     return ret;
> > +}
> > +
> > +void drm_privacy_screen_set_val(struct drm_connector *connector,
> > +                              enum drm_privacy_screen val)
> > +{
> > +     acpi_handle acpi_handle =3D connector->privacy_screen_handle;
> > +
> > +     if (!acpi_handle)
> > +             return;
> > +
> > +     if (val =3D=3D DRM_PRIVACY_SCREEN_DISABLED)
> > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > +                                          DRM_CONN_DSM_FN_PRIVACY_DISA=
BLE);
> > +     else if (val =3D=3D DRM_PRIVACY_SCREEN_ENABLED)
> > +             acpi_privacy_screen_call_dsm(acpi_handle,
> > +                                          DRM_CONN_DSM_FN_PRIVACY_ENAB=
LE);
> > +}
> > +
> > +enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_connecto=
r
> > +                                                *connector)
> > +{
> > +     acpi_handle acpi_handle =3D connector->privacy_screen_handle;
> > +
> > +     if (acpi_handle &&
> > +         acpi_privacy_screen_call_dsm(acpi_handle,
> > +                                      DRM_CONN_DSM_FN_PRIVACY_GET_STAT=
US))
> > +             return DRM_PRIVACY_SCREEN_ENABLED;
> > +
> > +     return DRM_PRIVACY_SCREEN_DISABLED;
> > +}
> > +
> > +/*
> > + * See ACPI Spec v6.3, Table B-2, "Display Type" for details.
> > + * In short, these macros define the base _ADR values for ACPI nodes
> > + */
> > +#define ACPI_BASE_ADR_FOR_OTHERS     (0ULL << 8)
> > +#define ACPI_BASE_ADR_FOR_VGA                (1ULL << 8)
> > +#define ACPI_BASE_ADR_FOR_TV         (2ULL << 8)
> > +#define ACPI_BASE_ADR_FOR_EXT_MON    (3ULL << 8)
> > +#define ACPI_BASE_ADR_FOR_INTEGRATED (4ULL << 8)
> > +
> > +#define ACPI_DEVICE_ID_SCHEME                (1ULL << 31)
> > +#define ACPI_FIRMWARE_CAN_DETECT     (1ULL << 16)
> > +
> > +/*
> > + * Ref: ACPI Spec 6.3
> > + * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30=
.pdf
> > + * Pages 1119 - 1123 describe, what I believe, a standard way of
> > + * identifying / addressing "display panels" in the ACPI. Thus it prov=
ides
> > + * a way for the ACPI to define devices for the display panels attache=
d
> > + * to the system. It thus provides a way for the BIOS to export any pa=
nel
> > + * specific properties to the system via ACPI (like device trees).
> > + *
> > + * The following function looks up the ACPI node for a connector and l=
inks
> > + * to it. Technically it is independent from the privacy_screen code, =
and
> > + * ideally may be called for all connectors. It is generally a good id=
ea to
> > + * be able to attach an ACPI node to describe anything if needed. (Thi=
s can
> > + * help in future for other panel specific features maybe). However, i=
t
> > + * needs a "port index" which I believe is the index within a particul=
ar
> > + * type of port (Ref to the pages of spec mentioned above). This port =
index
> > + * unfortunately is not available in DRM code, so currently its call i=
s
> > + * originated from i915 driver.
> > + */
> > +static int drm_connector_attach_acpi_node(struct drm_connector *connec=
tor,
> > +                                       u8 port_index)
> > +{
> > +     struct device *dev =3D &connector->dev->pdev->dev;
> > +     struct acpi_device *conn_dev;
> > +     u64 conn_addr;
> > +
> > +     /*
> > +      * Determine what _ADR to look for, depending on device type and
> > +      * port number. Potentially we only care about the
> > +      * eDP / integrated displays?
> > +      */
> > +     switch (connector->connector_type) {
> > +     case DRM_MODE_CONNECTOR_eDP:
> > +             conn_addr =3D ACPI_BASE_ADR_FOR_INTEGRATED + port_index;
> > +             break;
> > +     case DRM_MODE_CONNECTOR_VGA:
> > +             conn_addr =3D ACPI_BASE_ADR_FOR_VGA + port_index;
> > +             break;
> > +     case DRM_MODE_CONNECTOR_TV:
> > +             conn_addr =3D ACPI_BASE_ADR_FOR_TV + port_index;
> > +             break;
> > +     case DRM_MODE_CONNECTOR_DisplayPort:
> > +             conn_addr =3D ACPI_BASE_ADR_FOR_EXT_MON + port_index;
> > +             break;
> > +     default:
> > +             return -ENOTSUPP;
> > +     }
> > +
> > +     conn_addr |=3D ACPI_DEVICE_ID_SCHEME;
> > +     conn_addr |=3D ACPI_FIRMWARE_CAN_DETECT;
> > +
> > +     DRM_DEV_DEBUG(dev, "%s: Finding drm_connector ACPI node at _ADR=
=3D%llX\n",
> > +                   __func__, conn_addr);
> > +
> > +     /* Look up the connector device, under the PCI device */
> > +     conn_dev =3D acpi_find_child_device(ACPI_COMPANION(dev),
> > +                                       conn_addr, false);
> > +     if (!conn_dev)
> > +             return -ENODEV;
> > +
> > +     connector->privacy_screen_handle =3D conn_dev->handle;
> > +     return 0;
> > +}
> > +
> > +bool drm_privacy_screen_present(struct drm_connector *connector, u8 po=
rt_index)
>
> This is the main part that I think is a little tangled. This is a very
> specific implementation that hides in a generic API.

I agree that this is an ACPI specific implementation, but other than
that, I think it does not have any driver specific details. More
detailed thoughts on this below.

>
> I we store the privacy setting in the atomic state, there isn't really a
> reason to store the privacy handle in the connector. Instead it could be
> simply stored in the driver that supports this.
>
> Ideally I think we'd have a very small drm_privacy_screen object type
> that would just wrap this, but perhaps we don't need that right away,
> given that we only have a single implementation so far.

Yes, agreed.

>
> However, I think if we just pushed this specific implementation into the
> drivers that'd help pave the way for something more generic later on
> without a lot of extra work up front.
>
> For example you could turn the drm_connector_attach_acpi_node() into a
> helper that simply returns the ACPI handle, something like this perhaps:
>
>         struct acpi_handle *drm_acpi_find_privacy_screen(struct drm_conne=
ctor *connector,
>                                                          unsigned int por=
t)
>         {
>                 ...
>         }

Yes, I like that idea of making it a helper function. In fact, finding
an ACPI node for the connector doesn't have to do anything with
privacy screen (so it can be used for other purposes also, in future).

>
> That the i915 driver would then call and store the returned value
> internally. When it commits the atomic state for the connector it can
> then call the drm_acpi_set_privacy() (I think that'd be a better name
> for your drm_privacy_screen_set_val()) by passing that handle and the
> value from the atomic state.
>
> The above has the advantage that we don't clutter the generic core with
> something that's not at all generic. If eventually we see that these
> types of privacy screens are implemented in more device we can always
> refactor this into something really generic and maybe even decide to put
> it into the drm_connector directly.

This is where I think I'm in slight disagreement. I think the
functionality we're adding is still "generic", just that the only
hardware *I have today* to test is using Intel eDP ports. But I don't
see why AMD CPU laptops can't have it (For E.g. HP's Elitebook 745 G5
seems to use AMD and has integrated privacy screen feature
http://www8.hp.com/h20195/V2/GetPDF.aspx/4aa7-2802eee) .
My worry is that if we don't make it generic today, we might see
duplicate / similar-but-different / different ways of this in other
places (e.g. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3D110ea1d833ad)
because unless it is generic to start with, it is difficult for some
one to change later for the fear of breaking hardware that is already
in market given that
 * hardware may not be available to new developer to test for
regressions (also there is very little motivation to check any
hardware other than your own).
 * specially for a code that relies on firmware ACPI (firmware
upgrades in field are always costly).

My understanding is that we're adding 2 functionalities here:

1) Identify and Attach ACPI node to DRM connector. Since this is
following ACPI spec, I think this is  generic enough.

2) Use ACPI _DSM mthods to identify screen, set and get values. This
is where I think we're setting (generic) expectations for the ACPI
methods in how they should behave if ACPI is to be used to control
privacy screen. If we put this in generic code today, future
developers can look at this to understand how their ACPI for new
platforms is to behave if they want to use this generic code. If we
put it in i915 specific code, this will be seen as driver specific
behavior and developers may choose some other behavior in their
driver.

I agree that the functionality we're adding is ACPI specific (today -
but can be extended to gpio in future for non x86 platforms), but not
necessarily driver specific. Actually the only reason, I had to call
the drm_privacy_screen_present() (and the
drm_init_privacy_screen_property()) function from i915 code is because
we need a port_index to lookup ACPI node. If we had that available in
drm code, we wouldn't need to call anything from i915 at all.

So, for the reasons stated above, IMHO it is better to retain this
functionality in drm code instead of i915 driver. But I'm new to the
drm / i915 code, and would be happy to change my code if people have
strong opinions about this. Let me know.

Thanks & Best Regards,

Rajat

>
> > +{
> > +     acpi_handle handle;
> > +
> > +     if (drm_connector_attach_acpi_node(connector, port_index))
> > +             return false;
> > +
> > +     handle =3D connector->privacy_screen_handle;
> > +     if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
> > +                         DRM_CONN_DSM_REVID,
> > +                         1 << DRM_CONN_DSM_FN_PRIVACY_GET_STATUS |
> > +                         1 << DRM_CONN_DSM_FN_PRIVACY_ENABLE |
> > +                         1 << DRM_CONN_DSM_FN_PRIVACY_DISABLE)) {
> > +             DRM_WARN("%s: Odd, connector ACPI node but no privacy scr=
n?\n",
> > +                      connector->dev->dev);
> > +             return false;
> > +     }
> > +     DRM_DEV_INFO(connector->dev->dev, "supports privacy screen\n");
> > +     return true;
> > +}
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/=
i915/display/intel_dp.c
> > index 57e9f0ba331b..3ff3962d27db 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -39,6 +39,7 @@
> >  #include <drm/drm_dp_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_hdcp.h>
> > +#include <drm/drm_privacy_screen.h>
> >  #include <drm/drm_probe_helper.h>
> >  #include <drm/i915_drm.h>
> >
> > @@ -6354,6 +6355,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp=
, struct drm_connector *connect
> >
> >               connector->state->scaling_mode =3D DRM_MODE_SCALE_ASPECT;
> >
> > +             if (drm_privacy_screen_present(connector, port - PORT_A))
> > +                     drm_connector_init_privacy_screen_property(connec=
tor);
> >       }
> >  }
> >
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index 681cb590f952..63b8318bd68c 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -225,6 +225,20 @@ enum drm_link_status {
> >       DRM_LINK_STATUS_BAD =3D DRM_MODE_LINK_STATUS_BAD,
> >  };
> >
> > +/**
> > + * enum drm_privacy_screen - privacy_screen status
> > + *
> > + * This enum is used to track and control the state of the privacy scr=
een.
> > + * There are no separate #defines for the uapi!
> > + *
> > + * @DRM_PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is di=
sabled
> > + * @DRM_PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is en=
abled
> > + */
> > +enum drm_privacy_screen {
> > +     DRM_PRIVACY_SCREEN_DISABLED =3D 0,
> > +     DRM_PRIVACY_SCREEN_ENABLED =3D 1,
> > +};
> > +
>
> Shouldn't this go into include/uapi/drm/drm_mode.h? That would have the
> advantage of giving userspace symbolic names to use when setting the
> property.
>
> Maybe also rename these to something like:
>
>         #define DRM_MODE_PRIVACY_DISABLED 0
>         #define DRM_MODE_PRIVACY_ENABLED 1
>
> for consistency with other properties.
>
> Thierry
>
> >  /**
> >   * enum drm_panel_orientation - panel_orientation info for &drm_displa=
y_info
> >   *
> > @@ -1410,6 +1424,9 @@ struct drm_connector {
> >
> >       /** @hdr_sink_metadata: HDR Metadata Information read from sink *=
/
> >       struct hdr_sink_metadata hdr_sink_metadata;
> > +
> > +     /* Handle used by privacy screen code */
> > +     void *privacy_screen_handle;
> >  };
> >
> >  #define obj_to_connector(x) container_of(x, struct drm_connector, base=
)
> > @@ -1543,6 +1560,7 @@ int drm_connector_init_panel_orientation_property=
(
> >       struct drm_connector *connector, int width, int height);
> >  int drm_connector_attach_max_bpc_property(struct drm_connector *connec=
tor,
> >                                         int min, int max);
> > +int drm_connector_init_privacy_screen_property(struct drm_connector *c=
onnector);
> >
> >  /**
> >   * struct drm_tile_group - Tile group metadata
> > diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_confi=
g.h
> > index 3bcbe30339f0..6d5d23da90d4 100644
> > --- a/include/drm/drm_mode_config.h
> > +++ b/include/drm/drm_mode_config.h
> > @@ -813,6 +813,13 @@ struct drm_mode_config {
> >        */
> >       struct drm_property *panel_orientation_property;
> >
> > +     /**
> > +      * @privacy_screen_property: Optional connector property to indic=
ate
> > +      * and control the state (enabled / disabled) of privacy-screen o=
n the
> > +      * panel, if present.
> > +      */
> > +     struct drm_property *privacy_screen_property;
> > +
> >       /**
> >        * @writeback_fb_id_property: Property for writeback connectors, =
storing
> >        * the ID of the output framebuffer.
> > diff --git a/include/drm/drm_privacy_screen.h b/include/drm/drm_privacy=
_screen.h
> > new file mode 100644
> > index 000000000000..c589bbc47656
> > --- /dev/null
> > +++ b/include/drm/drm_privacy_screen.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright =C2=A9 2019 Google Inc.
> > + */
> > +
> > +#ifndef __DRM_PRIVACY_SCREEN_H__
> > +#define __DRM_PRIVACY_SCREEN_H__
> > +
> > +#ifdef CONFIG_ACPI
> > +bool drm_privacy_screen_present(struct drm_connector *connector, u8 po=
rt);
> > +void drm_privacy_screen_set_val(struct drm_connector *connector,
> > +                             enum drm_privacy_screen val);
> > +enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_connecto=
r
> > +                                                *connector);
> > +#else
> > +static inline bool drm_privacy_screen_present(struct drm_connector *co=
nnector,
> > +                                           u8 port)
> > +{
> > +     return false;
> > +}
> > +
> > +void drm_privacy_screen_set_val(struct drm_connector *connector,
> > +                             enum drm_privacy_screen val)
> > +{ }
> > +
> > +enum drm_privacy_screen drm_privacy_screen_get_val(
> > +                                     struct drm_connector *connector)
> > +{
> > +     return DRM_PRIVACY_SCREEN_DISABLED;
> > +}
> > +#endif /* CONFIG_ACPI */
> > +
> > +#endif /* __DRM_PRIVACY_SCREEN_H__ */
> > --
> > 2.23.0.866.gb869b98d4c-goog
> >
