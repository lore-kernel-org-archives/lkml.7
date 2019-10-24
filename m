Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFFA21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpUxgqAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436797AbfJXLUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:20:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40881 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407243AbfJXLUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:20:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so1022113wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wpcTyr1rECh7JQfNDU/HeTIX+AVlGekZlEd3DHxuDDU=;
        b=dpUxgqAGy6sZNIhl7Sf02C3mCce70S5zvNXPWTVs1ItjGN2cqzND9O/MN0w8offyy7
         dPCJytEmqd6er+tmGSrRgTCY+HvgwNqtlRTamrzHewo+3JlDRny/d2lrMpst7s4liaiT
         gdW8vo7AA6pYWD/Je32kqxIa4vfINjoZmFlS72bmqCztBP1dknJGy3xOjI/zBXyZFmdL
         ezJiwY7P8zSKv2mqcro/dXPRIUZxO/IxH/n4hz99su8UsWDJbzoYjM8RP7L/H5N0phdR
         RBz1RUucRUV6y8SzRVMkms+jluwcVmxE6WhA61sJ5NGIjYaCc7t6PGgiFPD+EkuGJU6+
         EQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wpcTyr1rECh7JQfNDU/HeTIX+AVlGekZlEd3DHxuDDU=;
        b=uHlCwHLPK5531ixHHzQ9NqqvZyiKzlzlt/TB9UWTb4esBBK5LIskBBlzaZGV/uLbf/
         6ffnGnSeXbH/USsZm+sEjGhbThfUejOFWPQpV+A9qE5lqZx/h0BvuVZMI3quBiNwCE8m
         sNhGFpHVAex+0Z73Ej/RRG/+PerTiY5t/xl8kjiten1SvZHU0F5YCGEZUkOHbukgV+do
         Bwx2uVI6xjnDsCW2hpwDNyZy4eUoKJWLWxz9IOYajCn68beBA/SzAdkje97l4NteFB3P
         sqD2Csl+6iXyetCLEY+0vWhxcxhRIBTl7YP39Sf8LmdUlFk2AphkwpGbiv7TB2pkrJpG
         J3pQ==
X-Gm-Message-State: APjAAAUk8CYLH6mxkRrPTfH3fhUZb2HOiPLrOCOTpP8E+1wIgZcb7ffK
        6j19wx8cBEYbfLdjRnZ+M54=
X-Google-Smtp-Source: APXvYqx7wCkXMh8CSFtP6z5QVlM8qOfsTEtHgvXiTHm6u2/1JI2rTSObx2++Il9qBO12B1SnXOFrOQ==
X-Received: by 2002:a7b:cf36:: with SMTP id m22mr4232537wmg.98.1571916043732;
        Thu, 24 Oct 2019 04:20:43 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id a17sm22672118wrx.84.2019.10.24.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 04:20:42 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:20:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?utf-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
        mathewk@google.com, Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, rajatxjain@gmail.com
Subject: Re: [PATCH] drm: Add support for integrated privacy screens
Message-ID: <20191024112040.GE2825247@ulmo>
References: <20191023001206.15741-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20191023001206.15741-1-rajatja@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 05:12:06PM -0700, Rajat Jain wrote:
> Certain laptops now come with panels that have integrated privacy
> screens on them. This patch adds support for such panels by adding
> a privacy-screen property to the drm_connector for the panel, that
> the userspace can then use to control and check the status. The idea
> was discussed here:
>=20
> https://lkml.org/lkml/2019/10/1/786
>=20
> ACPI methods are used to identify, query and control privacy screen:
>=20
> * Identifying an ACPI object corresponding to the panel: The patch
> follows ACPI Spec 6.3 (available at
> https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf).
> Pages 1119 - 1123 describe what I believe, is a standard way of
> identifying / addressing "display panels" in the ACPI tables, thus
> allowing kernel to attach ACPI nodes to the panel. IMHO, this ability
> to identify and attach ACPI nodes to drm connectors may be useful for
> reasons other privacy-screens, in future.
>=20
> * Identifying the presence of privacy screen, and controlling it, is done
> via ACPI _DSM methods.
>=20
> Currently, this is done only for the Intel display ports. But in future,
> this can be done for any other ports if the hardware becomes available
> (e.g. external monitors supporting integrated privacy screens?).
>=20
> Also, this code can be extended in future to support non-ACPI methods
> (e.g. using a kernel GPIO driver to toggle a gpio that controls the
> privacy-screen).
>=20
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/gpu/drm/Makefile                |   1 +
>  drivers/gpu/drm/drm_atomic_uapi.c       |   5 +
>  drivers/gpu/drm/drm_connector.c         |  38 +++++
>  drivers/gpu/drm/drm_privacy_screen.c    | 176 ++++++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c |   3 +
>  include/drm/drm_connector.h             |  18 +++
>  include/drm/drm_mode_config.h           |   7 +
>  include/drm/drm_privacy_screen.h        |  33 +++++
>  8 files changed, 281 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_privacy_screen.c
>  create mode 100644 include/drm/drm_privacy_screen.h

I like this much better than the prior proposal to use sysfs. However
the support currently looks a bit tangled. I realize that we only have a
single implementation for this in hardware right now, so there's no use
in over-engineering things, but I think we can do a better job from the
start without getting into too many abstractions. See below.

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 82ff826b33cc..e1fc33d69bb7 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -19,6 +19,7 @@ drm-y       :=3D	drm_auth.o drm_cache.o \
>  		drm_syncobj.o drm_lease.o drm_writeback.o drm_client.o \
>  		drm_client_modeset.o drm_atomic_uapi.o drm_hdcp.o
> =20
> +drm-$(CONFIG_ACPI) +=3D drm_privacy_screen.o
>  drm-$(CONFIG_DRM_LEGACY) +=3D drm_legacy_misc.o drm_bufs.o drm_context.o=
 drm_dma.o drm_scatter.o drm_lock.o
>  drm-$(CONFIG_DRM_LIB_RANDOM) +=3D lib/drm_random.o
>  drm-$(CONFIG_DRM_VM) +=3D drm_vm.o
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 7a26bfb5329c..44131165e4ea 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -30,6 +30,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_privacy_screen.h>
>  #include <drm/drm_writeback.h>
>  #include <drm/drm_vblank.h>
> =20
> @@ -766,6 +767,8 @@ static int drm_atomic_connector_set_property(struct d=
rm_connector *connector,
>  						   fence_ptr);
>  	} else if (property =3D=3D connector->max_bpc_property) {
>  		state->max_requested_bpc =3D val;
> +	} else if (property =3D=3D config->privacy_screen_property) {
> +		drm_privacy_screen_set_val(connector, val);

This doesn't look right. Shouldn't you store the value in the connector
state and then leave it up to the connector driver to set it
appropriately? I think that also has the advantage of untangling this
support a little.

>  	} else if (connector->funcs->atomic_set_property) {
>  		return connector->funcs->atomic_set_property(connector,
>  				state, property, val);
> @@ -842,6 +845,8 @@ drm_atomic_connector_get_property(struct drm_connecto=
r *connector,
>  		*val =3D 0;
>  	} else if (property =3D=3D connector->max_bpc_property) {
>  		*val =3D state->max_requested_bpc;
> +	} else if (property =3D=3D config->privacy_screen_property) {
> +		*val =3D drm_privacy_screen_get_val(connector);

Similarly, I think this can just return the atomic state's value for
this.

>  	} else if (connector->funcs->atomic_get_property) {
>  		return connector->funcs->atomic_get_property(connector,
>  				state, property, val);
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 4c766624b20d..a31e0382132b 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -821,6 +821,11 @@ static const struct drm_prop_enum_list drm_panel_ori=
entation_enum_list[] =3D {
>  	{ DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,	"Right Side Up"	},
>  };
> =20
> +static const struct drm_prop_enum_list drm_privacy_screen_enum_list[] =
=3D {
> +	{ DRM_PRIVACY_SCREEN_DISABLED, "Disabled" },
> +	{ DRM_PRIVACY_SCREEN_ENABLED, "Enabled" },
> +};
> +
>  static const struct drm_prop_enum_list drm_dvi_i_select_enum_list[] =3D {
>  	{ DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I and TV-out */
>  	{ DRM_MODE_SUBCONNECTOR_DVID,      "DVI-D"     }, /* DVI-I  */
> @@ -2253,6 +2258,39 @@ static void drm_tile_group_free(struct kref *kref)
>  	kfree(tg);
>  }
> =20
> +/**
> + * drm_connector_init_privacy_screen_property -
> + *	create and attach the connecter's privacy-screen property.
> + * @connector: connector for which to init the privacy-screen property.
> + *
> + * This function creates and attaches the "privacy-screen" property to t=
he
> + * connector. Initial state of privacy-screen is set to disabled.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_init_privacy_screen_property(struct drm_connector *con=
nector)
> +{
> +	struct drm_device *dev =3D connector->dev;
> +	struct drm_property *prop;
> +
> +	prop =3D dev->mode_config.privacy_screen_property;
> +	if (!prop) {
> +		prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_ENUM,
> +				"privacy-screen", drm_privacy_screen_enum_list,

Seems to me like the -screen suffix here is somewhat redundant. Yes, the
thing that we enable/disable may be called a "privacy screen", but the
property that we enable/disable on the connector is the "privacy" of the
user. I'd reflect that in all the related variable names and so on as
well.

> +				ARRAY_SIZE(drm_privacy_screen_enum_list));
> +		if (!prop)
> +			return -ENOMEM;
> +
> +		dev->mode_config.privacy_screen_property =3D prop;
> +	}
> +
> +	drm_object_attach_property(&connector->base, prop,
> +				   DRM_PRIVACY_SCREEN_DISABLED);
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_init_privacy_screen_property);
> +
>  /**
>   * drm_mode_put_tile_group - drop a reference to a tile group.
>   * @dev: DRM device
> diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_p=
rivacy_screen.c
> new file mode 100644
> index 000000000000..1d68e8aa6c5f
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_privacy_screen.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DRM privacy Screen code
> + *
> + * Copyright =C2=A9 2019 Google Inc.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/pci.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_print.h>
> +
> +#define DRM_CONN_DSM_REVID 1
> +
> +#define DRM_CONN_DSM_FN_PRIVACY_GET_STATUS	1
> +#define DRM_CONN_DSM_FN_PRIVACY_ENABLE		2
> +#define DRM_CONN_DSM_FN_PRIVACY_DISABLE		3
> +
> +static const guid_t drm_conn_dsm_guid =3D
> +	GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> +		  0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> +
> +/*
> + * Makes _DSM call to set privacy screen status or get privacy screen. R=
eturn
> + * value matters only for PRIVACY_GET_STATUS case. Returns 0 if disabled=
, 1 if
> + * enabled.
> + */
> +static int acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 fun=
c)
> +{
> +	union acpi_object *obj;
> +	int ret =3D 0;
> +
> +	obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
> +				DRM_CONN_DSM_REVID, func, NULL);
> +	if (!obj) {
> +		DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n", func);
> +		/* Can't do much. For get_val, assume privacy_screen disabled */
> +		goto done;
> +	}
> +
> +	if (func =3D=3D DRM_CONN_DSM_FN_PRIVACY_GET_STATUS &&
> +	    obj->type =3D=3D ACPI_TYPE_INTEGER)
> +		ret =3D !!obj->integer.value;
> +done:
> +	ACPI_FREE(obj);
> +	return ret;
> +}
> +
> +void drm_privacy_screen_set_val(struct drm_connector *connector,
> +				 enum drm_privacy_screen val)
> +{
> +	acpi_handle acpi_handle =3D connector->privacy_screen_handle;
> +
> +	if (!acpi_handle)
> +		return;
> +
> +	if (val =3D=3D DRM_PRIVACY_SCREEN_DISABLED)
> +		acpi_privacy_screen_call_dsm(acpi_handle,
> +					     DRM_CONN_DSM_FN_PRIVACY_DISABLE);
> +	else if (val =3D=3D DRM_PRIVACY_SCREEN_ENABLED)
> +		acpi_privacy_screen_call_dsm(acpi_handle,
> +					     DRM_CONN_DSM_FN_PRIVACY_ENABLE);
> +}
> +
> +enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_connector
> +						   *connector)
> +{
> +	acpi_handle acpi_handle =3D connector->privacy_screen_handle;
> +
> +	if (acpi_handle &&
> +	    acpi_privacy_screen_call_dsm(acpi_handle,
> +					 DRM_CONN_DSM_FN_PRIVACY_GET_STATUS))
> +		return DRM_PRIVACY_SCREEN_ENABLED;
> +
> +	return DRM_PRIVACY_SCREEN_DISABLED;
> +}
> +
> +/*
> + * See ACPI Spec v6.3, Table B-2, "Display Type" for details.
> + * In short, these macros define the base _ADR values for ACPI nodes
> + */
> +#define ACPI_BASE_ADR_FOR_OTHERS	(0ULL << 8)
> +#define ACPI_BASE_ADR_FOR_VGA		(1ULL << 8)
> +#define ACPI_BASE_ADR_FOR_TV		(2ULL << 8)
> +#define ACPI_BASE_ADR_FOR_EXT_MON	(3ULL << 8)
> +#define ACPI_BASE_ADR_FOR_INTEGRATED	(4ULL << 8)
> +
> +#define ACPI_DEVICE_ID_SCHEME		(1ULL << 31)
> +#define ACPI_FIRMWARE_CAN_DETECT	(1ULL << 16)
> +
> +/*
> + * Ref: ACPI Spec 6.3
> + * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.p=
df
> + * Pages 1119 - 1123 describe, what I believe, a standard way of
> + * identifying / addressing "display panels" in the ACPI. Thus it provid=
es
> + * a way for the ACPI to define devices for the display panels attached
> + * to the system. It thus provides a way for the BIOS to export any panel
> + * specific properties to the system via ACPI (like device trees).
> + *
> + * The following function looks up the ACPI node for a connector and lin=
ks
> + * to it. Technically it is independent from the privacy_screen code, and
> + * ideally may be called for all connectors. It is generally a good idea=
 to
> + * be able to attach an ACPI node to describe anything if needed. (This =
can
> + * help in future for other panel specific features maybe). However, it
> + * needs a "port index" which I believe is the index within a particular
> + * type of port (Ref to the pages of spec mentioned above). This port in=
dex
> + * unfortunately is not available in DRM code, so currently its call is
> + * originated from i915 driver.
> + */
> +static int drm_connector_attach_acpi_node(struct drm_connector *connecto=
r,
> +					  u8 port_index)
> +{
> +	struct device *dev =3D &connector->dev->pdev->dev;
> +	struct acpi_device *conn_dev;
> +	u64 conn_addr;
> +
> +	/*
> +	 * Determine what _ADR to look for, depending on device type and
> +	 * port number. Potentially we only care about the
> +	 * eDP / integrated displays?
> +	 */
> +	switch (connector->connector_type) {
> +	case DRM_MODE_CONNECTOR_eDP:
> +		conn_addr =3D ACPI_BASE_ADR_FOR_INTEGRATED + port_index;
> +		break;
> +	case DRM_MODE_CONNECTOR_VGA:
> +		conn_addr =3D ACPI_BASE_ADR_FOR_VGA + port_index;
> +		break;
> +	case DRM_MODE_CONNECTOR_TV:
> +		conn_addr =3D ACPI_BASE_ADR_FOR_TV + port_index;
> +		break;
> +	case DRM_MODE_CONNECTOR_DisplayPort:
> +		conn_addr =3D ACPI_BASE_ADR_FOR_EXT_MON + port_index;
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	conn_addr |=3D ACPI_DEVICE_ID_SCHEME;
> +	conn_addr |=3D ACPI_FIRMWARE_CAN_DETECT;
> +
> +	DRM_DEV_DEBUG(dev, "%s: Finding drm_connector ACPI node at _ADR=3D%llX\=
n",
> +		      __func__, conn_addr);
> +
> +	/* Look up the connector device, under the PCI device */
> +	conn_dev =3D acpi_find_child_device(ACPI_COMPANION(dev),
> +					  conn_addr, false);
> +	if (!conn_dev)
> +		return -ENODEV;
> +
> +	connector->privacy_screen_handle =3D conn_dev->handle;
> +	return 0;
> +}
> +
> +bool drm_privacy_screen_present(struct drm_connector *connector, u8 port=
_index)

This is the main part that I think is a little tangled. This is a very
specific implementation that hides in a generic API.

I we store the privacy setting in the atomic state, there isn't really a
reason to store the privacy handle in the connector. Instead it could be
simply stored in the driver that supports this.

Ideally I think we'd have a very small drm_privacy_screen object type
that would just wrap this, but perhaps we don't need that right away,
given that we only have a single implementation so far.

However, I think if we just pushed this specific implementation into the
drivers that'd help pave the way for something more generic later on
without a lot of extra work up front.

For example you could turn the drm_connector_attach_acpi_node() into a
helper that simply returns the ACPI handle, something like this perhaps:

	struct acpi_handle *drm_acpi_find_privacy_screen(struct drm_connector *con=
nector,
							 unsigned int port)
	{
		...
	}

That the i915 driver would then call and store the returned value
internally. When it commits the atomic state for the connector it can
then call the drm_acpi_set_privacy() (I think that'd be a better name
for your drm_privacy_screen_set_val()) by passing that handle and the
value from the atomic state.

The above has the advantage that we don't clutter the generic core with
something that's not at all generic. If eventually we see that these
types of privacy screens are implemented in more device we can always
refactor this into something really generic and maybe even decide to put
it into the drm_connector directly.

> +{
> +	acpi_handle handle;
> +
> +	if (drm_connector_attach_acpi_node(connector, port_index))
> +		return false;
> +
> +	handle =3D connector->privacy_screen_handle;
> +	if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
> +			    DRM_CONN_DSM_REVID,
> +			    1 << DRM_CONN_DSM_FN_PRIVACY_GET_STATUS |
> +			    1 << DRM_CONN_DSM_FN_PRIVACY_ENABLE |
> +			    1 << DRM_CONN_DSM_FN_PRIVACY_DISABLE)) {
> +		DRM_WARN("%s: Odd, connector ACPI node but no privacy scrn?\n",
> +			 connector->dev->dev);
> +		return false;
> +	}
> +	DRM_DEV_INFO(connector->dev->dev, "supports privacy screen\n");
> +	return true;
> +}
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 57e9f0ba331b..3ff3962d27db 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -39,6 +39,7 @@
>  #include <drm/drm_dp_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_hdcp.h>
> +#include <drm/drm_privacy_screen.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/i915_drm.h>
> =20
> @@ -6354,6 +6355,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, =
struct drm_connector *connect
> =20
>  		connector->state->scaling_mode =3D DRM_MODE_SCALE_ASPECT;
> =20
> +		if (drm_privacy_screen_present(connector, port - PORT_A))
> +			drm_connector_init_privacy_screen_property(connector);
>  	}
>  }
> =20
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 681cb590f952..63b8318bd68c 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -225,6 +225,20 @@ enum drm_link_status {
>  	DRM_LINK_STATUS_BAD =3D DRM_MODE_LINK_STATUS_BAD,
>  };
> =20
> +/**
> + * enum drm_privacy_screen - privacy_screen status
> + *
> + * This enum is used to track and control the state of the privacy scree=
n.
> + * There are no separate #defines for the uapi!
> + *
> + * @DRM_PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disa=
bled
> + * @DRM_PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enab=
led
> + */
> +enum drm_privacy_screen {
> +	DRM_PRIVACY_SCREEN_DISABLED =3D 0,
> +	DRM_PRIVACY_SCREEN_ENABLED =3D 1,
> +};
> +

Shouldn't this go into include/uapi/drm/drm_mode.h? That would have the
advantage of giving userspace symbolic names to use when setting the
property.

Maybe also rename these to something like:

	#define DRM_MODE_PRIVACY_DISABLED 0
	#define DRM_MODE_PRIVACY_ENABLED 1

for consistency with other properties.

Thierry

>  /**
>   * enum drm_panel_orientation - panel_orientation info for &drm_display_=
info
>   *
> @@ -1410,6 +1424,9 @@ struct drm_connector {
> =20
>  	/** @hdr_sink_metadata: HDR Metadata Information read from sink */
>  	struct hdr_sink_metadata hdr_sink_metadata;
> +
> +	/* Handle used by privacy screen code */
> +	void *privacy_screen_handle;
>  };
> =20
>  #define obj_to_connector(x) container_of(x, struct drm_connector, base)
> @@ -1543,6 +1560,7 @@ int drm_connector_init_panel_orientation_property(
>  	struct drm_connector *connector, int width, int height);
>  int drm_connector_attach_max_bpc_property(struct drm_connector *connecto=
r,
>  					  int min, int max);
> +int drm_connector_init_privacy_screen_property(struct drm_connector *con=
nector);
> =20
>  /**
>   * struct drm_tile_group - Tile group metadata
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 3bcbe30339f0..6d5d23da90d4 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -813,6 +813,13 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *panel_orientation_property;
> =20
> +	/**
> +	 * @privacy_screen_property: Optional connector property to indicate
> +	 * and control the state (enabled / disabled) of privacy-screen on the
> +	 * panel, if present.
> +	 */
> +	struct drm_property *privacy_screen_property;
> +
>  	/**
>  	 * @writeback_fb_id_property: Property for writeback connectors, storing
>  	 * the ID of the output framebuffer.
> diff --git a/include/drm/drm_privacy_screen.h b/include/drm/drm_privacy_s=
creen.h
> new file mode 100644
> index 000000000000..c589bbc47656
> --- /dev/null
> +++ b/include/drm/drm_privacy_screen.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright =C2=A9 2019 Google Inc.
> + */
> +
> +#ifndef __DRM_PRIVACY_SCREEN_H__
> +#define __DRM_PRIVACY_SCREEN_H__
> +
> +#ifdef CONFIG_ACPI
> +bool drm_privacy_screen_present(struct drm_connector *connector, u8 port=
);
> +void drm_privacy_screen_set_val(struct drm_connector *connector,
> +				enum drm_privacy_screen val);
> +enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_connector
> +						   *connector);
> +#else
> +static inline bool drm_privacy_screen_present(struct drm_connector *conn=
ector,
> +					      u8 port)
> +{
> +	return false;
> +}
> +
> +void drm_privacy_screen_set_val(struct drm_connector *connector,
> +				enum drm_privacy_screen val)
> +{ }
> +
> +enum drm_privacy_screen drm_privacy_screen_get_val(
> +					struct drm_connector *connector)
> +{
> +	return DRM_PRIVACY_SCREEN_DISABLED;
> +}
> +#endif /* CONFIG_ACPI */
> +
> +#endif /* __DRM_PRIVACY_SCREEN_H__ */
> --=20
> 2.23.0.866.gb869b98d4c-goog
>=20

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2xiQYACgkQ3SOs138+
s6FIFw/+OgfgYZVij2i0Wd2xkIAw2rC8Q7WYbIvPk4imLA6f3LTAyJmLuzhCcCeR
/vq8P4xd19FKn//vdpU1oAJC2vgIzIc/3CLeKutco+bqlINfNBNsh89/4tBml3z9
fFLHBfyspJ4L4IUvB+M8QjPB/p6zAFx9bilpTwExfjc/GhjZJV2nBFcE4bp0W7+A
HNXfuFldUZJo1sFecLh1+opM6crjS7vaMLpIq8Sr1syI2OfvFml9Lt8PgEcFoKvO
FZiAe/T2rl90WQRSFBFe6qSkPrymrYwvHcCCIAgHdkRIJrFs9LIAy5/2hGuwCNyC
C4C4TLZdIiHPbhNT4dFijm3Xg+pSK03Y5nupv8kLOsHXMGu4TD2SrFkNAnL2grd9
uZRptY6uMhgVpgkNZ6kfPNeb0tAj3NNP0co4ReNcsr5weHJi99vpkNLHu8mISoJQ
iWHdhE8R7wT8nhmF8Z4eaCjngiEHwema7wPFpL8JX7bDzhss0yu7UEzT0Gi1nJJZ
G4odhgBPQpZ1dWkmu4LTuQL756tEycF08R6RPwH4b26SXKIyhz+81HV1AWfhKOXj
lu+QSokLedNNvkBM0LITUw5H52b1wlX5rnm/09neYPpZ6vvWBd1JKJ4I1P32cQyL
kjeqotIfHunHZIWVfJxJe9lLCtXMFkUWU5NctDvWB2nORwhIgDM=
=MSdl
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
