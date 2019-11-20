Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD13206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfKTOvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:51:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:19629 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfKTOvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:51:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 06:50:57 -0800
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="200739584"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 06:50:49 -0800
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
Subject: Re: [PATCH v2 2/3] drm/i915: Lookup and attach ACPI device node for connectors
In-Reply-To: <20191104194147.185642-2-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191023001206.15741-1-rajatja@google.com> <20191104194147.185642-1-rajatja@google.com> <20191104194147.185642-2-rajatja@google.com>
Date:   Wed, 20 Nov 2019 16:50:46 +0200
Message-ID: <87tv6ywqih.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Nov 2019, Rajat Jain <rajatja@google.com> wrote:
> Lookup and attach ACPI nodes for intel connectors. The lookup is done
> in compliance with ACPI Spec 6.3
> https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> (Ref: Pages 1119 - 1123).
>
> This can be useful for any connector specific platform properties. (This
> will be used for privacy screen in next patch).
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Change-Id: I798e70714a4402554c8cd2a8e58268353f75814f
> ---
> v2: formed by splitting the original patch into ACPI lookup, and privacy
>     screen property. Also move it into i915 now that I found existing code
>     in i915 that can be re-used.
>
>  drivers/gpu/drm/i915/display/intel_acpi.c     | 50 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_acpi.h     |  4 +-
>  .../drm/i915/display/intel_display_types.h    |  3 ++
>  drivers/gpu/drm/i915/display/intel_dp.c       |  4 ++
>  4 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index 748d9b3125dd..0c10516430b1 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -243,3 +243,53 @@ void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev)
>  	}
>  	drm_connector_list_iter_end(&conn_iter);
>  }
> +
> +/*
> + * Ref: ACPI Spec 6.3
> + * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> + * Pages 1119 - 1123 describe, what I believe, a standard way of
> + * identifying / addressing "display panels" in the ACPI. It provides
> + * a way for the ACPI to define devices for the display panels attached
> + * to the system. It thus provides a way for the BIOS to export any panel
> + * specific properties to the system via ACPI (like device trees).
> + *
> + * The following functions looks up the ACPI node for a connector and returns
> + * it. Technically it is independent from the i915 code, and
> + * ideally may be called for all connectors. It is generally a good idea to
> + * be able to attach an ACPI node to describe anything if needed. (This can
> + * help in future for other panel specific features maybe). However, it
> + * needs an acpi device ID which is build using an index within a particular
> + * type of port (Ref to the pages of spec mentioned above, and to code in
> + * intel_populate_acpi_ids_for_all_connectors()). This device index
> + * unfortunately is not available in DRM code, so currently its call is
> + * originated from i915 driver. If in future this is useful for other drivers
> + * and we can find a generic way of getting a device index, we should move this
> + * function to drm code, maybe.
> + */
> +void intel_connector_lookup_acpi_node(struct intel_connector *intel_connector)

Nitpick, I'd expect a "lookup" function to return whatever it is looking
up, not modify its argument.

> +{
> +	struct drm_device *drm_dev = intel_connector->base.dev;
> +	struct device *dev = &drm_dev->pdev->dev;
> +	struct acpi_device *conn_dev;
> +	u64 conn_addr;
> +
> +	/*
> +	 * Repopulate ACPI IDs for all connectors is needed because the display
> +	 * index may have changed as a result of hotplugging and unplugging
> +	 * connectors
> +	 */

I think that can only be true for DP MST. For everything else, I don't
think so. Anyway, why are we doing it here then, depending on whether
someone calls this function or not? If it matters, we should be doing
this whenever there's a chance they've changed, right?

> +	intel_populate_acpi_ids_for_all_connectors(drm_dev);
> +
> +	/* Build the _ADR to look for */
> +	conn_addr = intel_connector->acpi_device_id;
> +	conn_addr |= ACPI_DEVICE_ID_SCHEME;
> +	conn_addr |= ACPI_BIOS_CAN_DETECT;
> +
> +	DRM_DEV_INFO(dev, "Looking for connector ACPI node at _ADR=%llX\n",
> +		     conn_addr);
> +
> +	/* Look up the connector device, under the PCI device */
> +	conn_dev = acpi_find_child_device(ACPI_COMPANION(dev), conn_addr,
> +					  false);
> +	intel_connector->acpi_handle = conn_dev ? conn_dev->handle : NULL;

Why don't we do this as part of
intel_populate_acpi_ids_for_all_connectors() or whatever it'll be
called?

> +}
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
> index 8f6d850df6fa..61a4392fac4a 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.h
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.h
> @@ -9,14 +9,16 @@
>  #include "intel_display_types.h"
>  
>  #ifdef CONFIG_ACPI
> +void intel_connector_lookup_acpi_node(struct intel_connector *connector);
>  void intel_register_dsm_handler(void);
>  void intel_unregister_dsm_handler(void);
>  void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev);
>  #else
> +static inline void
> +intel_connector_lookup_acpi_node(struct intel_connector *connector) { return; }
>  static inline void intel_register_dsm_handler(void) { return; }
>  static inline void intel_unregister_dsm_handler(void) { return; }
>  static inline void
> -static inline void

Whoops.

>  intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev) { }
>  #endif /* CONFIG_ACPI */
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 449abaea619f..c2706afc069b 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -400,6 +400,9 @@ struct intel_connector {
>  	/* ACPI device id for ACPI and driver cooperation */
>  	u32 acpi_device_id;
>  
> +	/* ACPI handle corresponding to this connector display, if found */
> +	void *acpi_handle;
> +
>  	/* Reads out the current hw, returning true if the connector is enabled
>  	 * and active (i.e. dpms ON state). */
>  	bool (*get_hw_state)(struct intel_connector *);
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index f865615172a5..4fac408a4299 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -45,6 +45,7 @@
>  #include "i915_debugfs.h"
>  #include "i915_drv.h"
>  #include "i915_trace.h"
> +#include "intel_acpi.h"
>  #include "intel_atomic.h"
>  #include "intel_audio.h"
>  #include "intel_connector.h"
> @@ -6333,6 +6334,7 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
>  {
>  	struct drm_i915_private *dev_priv = to_i915(connector->dev);
>  	enum port port = dp_to_dig_port(intel_dp)->base.port;
> +	struct intel_connector *intel_connector = to_intel_connector(connector);
>  
>  	if (!IS_G4X(dev_priv) && port != PORT_A)
>  		intel_attach_force_audio_property(connector);
> @@ -6354,6 +6356,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
>  
>  		connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>  
> +		/* Lookup the ACPI node corresponding to the connector */
> +		intel_connector_lookup_acpi_node(intel_connector);

This is an odd place to do this, isn't it? It's only called once, but
you say the acpi id may change at hotplug.

BR,
Jani.

>  	}
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
