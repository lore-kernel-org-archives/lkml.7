Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAB0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630EA2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfKTPEe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:04:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:24440 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfKTPEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:04:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 07:04:32 -0800
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="200744757"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 07:04:23 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?utf-8?Q?Jos=C3=A9?= Roberto de Souza <jose.souza@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
        mathewk@google.com, Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, Thierry Reding <thierry.reding@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Subject: Re: [PATCH v2 3/3] drm/i915: Add support for integrated privacy screens
In-Reply-To: <20191104194147.185642-3-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191023001206.15741-1-rajatja@google.com> <20191104194147.185642-1-rajatja@google.com> <20191104194147.185642-3-rajatja@google.com>
Date:   Wed, 20 Nov 2019 17:04:20 +0200
Message-ID: <87r222wpvv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Nov 2019, Rajat Jain <rajatja@google.com> wrote:
> Certain laptops now come with panels that have integrated privacy
> screens on them. This patch adds support for such panels by adding
> a privacy-screen property to the intel_connector for the panel, that
> the userspace can then use to control and check the status.
>
> Identifying the presence of privacy screen, and controlling it, is done
> via ACPI _DSM methods.
>
> Currently, this is done only for the Intel display ports. But in future,
> this can be done for any other ports if the hardware becomes available
> (e.g. external monitors supporting integrated privacy screens?).
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Change-Id: Ic9ff07fc4a50797d2d0dfb919f11aa0821a4b548
> ---
> v2: Formed by splitting the original patch into multiple patches.
>     - All code has been moved into i915 now.
>     - Privacy screen is a i915 property
>     - Have a local state variable to store the prvacy screen. Don't read
>       it from hardware.
>
>  drivers/gpu/drm/i915/Makefile                 |  3 +-
>  drivers/gpu/drm/i915/display/intel_atomic.c   | 13 +++-
>  .../gpu/drm/i915/display/intel_connector.c    | 35 ++++++++++
>  .../gpu/drm/i915/display/intel_connector.h    |  1 +
>  .../drm/i915/display/intel_display_types.h    |  4 ++
>  drivers/gpu/drm/i915/display/intel_dp.c       |  5 ++
>  .../drm/i915/display/intel_privacy_screen.c   | 70 +++++++++++++++++++
>  .../drm/i915/display/intel_privacy_screen.h   | 25 +++++++
>  include/uapi/drm/i915_drm.h                   | 14 ++++
>  9 files changed, 166 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
>  create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h
>
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 2587ea834f06..3589ebcf27bc 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -185,7 +185,8 @@ i915-y += \
>  	display/intel_tc.o
>  i915-$(CONFIG_ACPI) += \
>  	display/intel_acpi.o \
> -	display/intel_opregion.o
> +	display/intel_opregion.o \
> +	display/intel_privacy_screen.o

Mmmh, wonder if there'll be non-ACPI based privacy screens. I guess we
can sort this out then. *shrug*

>  i915-$(CONFIG_DRM_FBDEV_EMULATION) += \
>  	display/intel_fbdev.o
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
> index d3fb75bb9eb1..378772d3449c 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> @@ -37,6 +37,7 @@
>  #include "intel_atomic.h"
>  #include "intel_display_types.h"
>  #include "intel_hdcp.h"
> +#include "intel_privacy_screen.h"
>  #include "intel_sprite.h"
>  
>  /**
> @@ -57,11 +58,14 @@ int intel_digital_connector_atomic_get_property(struct drm_connector *connector,
>  	struct drm_i915_private *dev_priv = to_i915(dev);
>  	struct intel_digital_connector_state *intel_conn_state =
>  		to_intel_digital_connector_state(state);
> +	struct intel_connector *intel_connector = to_intel_connector(connector);
>  
>  	if (property == dev_priv->force_audio_property)
>  		*val = intel_conn_state->force_audio;
>  	else if (property == dev_priv->broadcast_rgb_property)
>  		*val = intel_conn_state->broadcast_rgb;
> +	else if (property == intel_connector->privacy_screen_property)
> +		*val = intel_conn_state->privacy_screen_status;
>  	else {
>  		DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
>  				 property->base.id, property->name);
> @@ -89,15 +93,18 @@ int intel_digital_connector_atomic_set_property(struct drm_connector *connector,
>  	struct drm_i915_private *dev_priv = to_i915(dev);
>  	struct intel_digital_connector_state *intel_conn_state =
>  		to_intel_digital_connector_state(state);
> +	struct intel_connector *intel_connector = to_intel_connector(connector);
>  
>  	if (property == dev_priv->force_audio_property) {
>  		intel_conn_state->force_audio = val;
>  		return 0;
> -	}
> -
> -	if (property == dev_priv->broadcast_rgb_property) {
> +	} else if (property == dev_priv->broadcast_rgb_property) {
>  		intel_conn_state->broadcast_rgb = val;
>  		return 0;
> +	} else if (property == intel_connector->privacy_screen_property) {
> +		intel_privacy_screen_set_val(intel_connector, val);
> +		intel_conn_state->privacy_screen_status = val;
> +		return 0;
>  	}
>  
>  	DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
> diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/drm/i915/display/intel_connector.c
> index 308ec63207ee..3ccbf52aedf9 100644
> --- a/drivers/gpu/drm/i915/display/intel_connector.c
> +++ b/drivers/gpu/drm/i915/display/intel_connector.c
> @@ -281,3 +281,38 @@ intel_attach_colorspace_property(struct drm_connector *connector)
>  		drm_object_attach_property(&connector->base,
>  					   connector->colorspace_property, 0);
>  }
> +
> +static const struct drm_prop_enum_list privacy_screen_enum[] = {
> +	{ PRIVACY_SCREEN_DISABLED, "Disabled" },
> +	{ PRIVACY_SCREEN_ENABLED, "Enabled" },
> +};
> +
> +/**
> + * intel_attach_privacy_screen_property -
> + *     create and attach the connecter's privacy-screen property. *
> + * @connector: connector for which to init the privacy-screen property
> + *
> + * This function creates and attaches the "privacy-screen" property to the
> + * connector. Initial state of privacy-screen is set to disabled.
> + */
> +void
> +intel_attach_privacy_screen_property(struct drm_connector *connector)
> +{
> +	struct intel_connector *intel_connector = to_intel_connector(connector);
> +	struct drm_property *prop;
> +
> +	if (!intel_connector->privacy_screen_property) {
> +		prop = drm_property_create_enum(connector->dev,
> +						DRM_MODE_PROP_ENUM,
> +						"privacy-screen",
> +						privacy_screen_enum,
> +					    ARRAY_SIZE(privacy_screen_enum));
> +		if (!prop)
> +			return;
> +
> +		intel_connector->privacy_screen_property = prop;
> +	}
> +
> +	drm_object_attach_property(&connector->base, prop,
> +				   PRIVACY_SCREEN_DISABLED);
> +}

I think this should be a drm core level property in drm_connector.[ch]
so that *all* drivers would use the same thing for privacy screens. Not
i915 specific.

I think this is the biggest issue in the patch series.

> diff --git a/drivers/gpu/drm/i915/display/intel_connector.h b/drivers/gpu/drm/i915/display/intel_connector.h
> index 93a7375c8196..61005f37a338 100644
> --- a/drivers/gpu/drm/i915/display/intel_connector.h
> +++ b/drivers/gpu/drm/i915/display/intel_connector.h
> @@ -31,5 +31,6 @@ void intel_attach_force_audio_property(struct drm_connector *connector);
>  void intel_attach_broadcast_rgb_property(struct drm_connector *connector);
>  void intel_attach_aspect_ratio_property(struct drm_connector *connector);
>  void intel_attach_colorspace_property(struct drm_connector *connector);
> +void intel_attach_privacy_screen_property(struct drm_connector *connector);
>  
>  #endif /* __INTEL_CONNECTOR_H__ */
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index c2706afc069b..83b8c98049a7 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -426,6 +426,9 @@ struct intel_connector {
>  	struct work_struct modeset_retry_work;
>  
>  	struct intel_hdcp hdcp;
> +
> +	/* Optional "privacy-screen" property for the connector panel */
> +	struct drm_property *privacy_screen_property;
>  };
>  
>  struct intel_digital_connector_state {
> @@ -433,6 +436,7 @@ struct intel_digital_connector_state {
>  
>  	enum hdmi_force_audio force_audio;
>  	int broadcast_rgb;
> +	enum intel_privacy_screen_status privacy_screen_status;
>  };
>  
>  #define to_intel_digital_connector_state(x) container_of(x, struct intel_digital_connector_state, base)
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 4fac408a4299..1963e92404ba 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -62,6 +62,7 @@
>  #include "intel_lspcon.h"
>  #include "intel_lvds.h"
>  #include "intel_panel.h"
> +#include "intel_privacy_screen.h"
>  #include "intel_psr.h"
>  #include "intel_sideband.h"
>  #include "intel_tc.h"
> @@ -6358,6 +6359,10 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
>  
>  		/* Lookup the ACPI node corresponding to the connector */
>  		intel_connector_lookup_acpi_node(intel_connector);
> +
> +		/* Check for integrated Privacy screen support */
> +		if (intel_privacy_screen_present(intel_connector))
> +			intel_attach_privacy_screen_property(connector);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
> new file mode 100644
> index 000000000000..4c422e38c51a
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Please read http://mid.mail-archive.com/CAKMK7uH-8+tbKsAoiChsxELEc_77RVVxP2wapHWhqB+0Viifog@mail.gmail.com

> +/*
> + * Intel ACPI privacy screen code
> + *
> + * Copyright © 2019 Google Inc.
> + */
> +
> +#include <linux/acpi.h>
> +
> +#include "intel_privacy_screen.h"
> +
> +#define CONNECTOR_DSM_REVID 1
> +
> +#define CONNECTOR_DSM_FN_PRIVACY_ENABLE		2
> +#define CONNECTOR_DSM_FN_PRIVACY_DISABLE		3
> +
> +static const guid_t drm_conn_dsm_guid =
> +	GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> +		  0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> +
> +/* Makes _DSM call to set privacy screen status */
> +static void acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 func)
> +{
> +	union acpi_object *obj;
> +
> +	obj = acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
> +				CONNECTOR_DSM_REVID, func, NULL);
> +	if (!obj) {
> +		DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n", func);
> +		return;
> +	}
> +
> +	ACPI_FREE(obj);
> +}
> +
> +void intel_privacy_screen_set_val(struct intel_connector *intel_connector,
> +				  enum intel_privacy_screen_status val)

Just name the parameter connector, not intel_connector. This throughout.

> +{
> +	acpi_handle acpi_handle = intel_connector->acpi_handle;
> +
> +	if (!acpi_handle)
> +		return;
> +
> +	if (val == PRIVACY_SCREEN_DISABLED)
> +		acpi_privacy_screen_call_dsm(acpi_handle,
> +					     CONNECTOR_DSM_FN_PRIVACY_DISABLE);
> +	else if (val == PRIVACY_SCREEN_ENABLED)
> +		acpi_privacy_screen_call_dsm(acpi_handle,
> +					     CONNECTOR_DSM_FN_PRIVACY_ENABLE);

else complain?

> +}
> +
> +bool intel_privacy_screen_present(struct intel_connector *intel_connector)
> +{
> +	acpi_handle handle = intel_connector->acpi_handle;
> +
> +	if (!handle)
> +		return false;
> +
> +	if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
> +			    CONNECTOR_DSM_REVID,
> +			    1 << CONNECTOR_DSM_FN_PRIVACY_ENABLE |
> +			    1 << CONNECTOR_DSM_FN_PRIVACY_DISABLE)) {
> +		DRM_WARN("%s: Odd, connector ACPI node but no privacy scrn?\n",
> +			 dev_name(intel_connector->base.dev->dev));
> +		return false;
> +	}
> +	DRM_DEV_INFO(intel_connector->base.dev->dev,
> +		     "supports privacy screen\n");
> +	return true;
> +}
> diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
> new file mode 100644
> index 000000000000..212f73349a00
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright © 2019 Google Inc.
> + */
> +
> +#ifndef __DRM_PRIVACY_SCREEN_H__
> +#define __DRM_PRIVACY_SCREEN_H__
> +
> +#include "intel_display_types.h"
> +
> +#ifdef CONFIG_ACPI
> +bool intel_privacy_screen_present(struct intel_connector *intel_connector);
> +void intel_privacy_screen_set_val(struct intel_connector *intel_connector,
> +				  enum intel_privacy_screen_status val);
> +#else
> +bool intel_privacy_screen_present(struct intel_connector *intel_connector);
> +{
> +	return false;
> +}
> +void intel_privacy_screen_set_val(struct intel_connector *intel_connector,
> +				  enum intel_privacy_screen_status val)
> +{ }
> +#endif /* CONFIG_ACPI */
> +
> +#endif /* __DRM_PRIVACY_SCREEN_H__ */
> diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
> index 469dc512cca3..cf08d5636363 100644
> --- a/include/uapi/drm/i915_drm.h
> +++ b/include/uapi/drm/i915_drm.h
> @@ -2123,6 +2123,20 @@ struct drm_i915_query_engine_info {
>  	struct drm_i915_engine_info engines[];
>  };
>  
> +/**
> + * enum intel_privacy_screen_status - privacy_screen status
> + *
> + * This enum is used to track and control the state of the integrated privacy
> + * screen present on some display panels, via the "privacy-screen" property.
> + *
> + * @PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disabled
> + * @PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enabled
> + **/
> +enum intel_privacy_screen_status {
> +	PRIVACY_SCREEN_DISABLED = 0,
> +	PRIVACY_SCREEN_ENABLED = 1,
> +};
> +

The drm_property interface UAPI is based on the strings, *not* on the
values. Please move the enum out of uapi into the drm code.

BR,
jani.

>  #if defined(__cplusplus)
>  }
>  #endif

-- 
Jani Nikula, Intel Open Source Graphics Center
