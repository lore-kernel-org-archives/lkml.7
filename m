Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE3AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEAA21823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfKTOlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:41:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:18807 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfKTOlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:41:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 06:41:01 -0800
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="200736464"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 06:40:52 -0800
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
Subject: Re: [PATCH v2 1/3] drm/i915: Move the code to populate ACPI device ID into intel_acpi
In-Reply-To: <20191104194147.185642-1-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191023001206.15741-1-rajatja@google.com> <20191104194147.185642-1-rajatja@google.com>
Date:   Wed, 20 Nov 2019 16:40:49 +0200
Message-ID: <87wobuwqz2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Nov 2019, Rajat Jain <rajatja@google.com> wrote:
> Move the code that populates the ACPI device ID for devices, into
> more appripriate intel_acpi.c. This is done in preparation for more
> users of this code (in next patch).

I don't think your use of the code makes sense (I'll explain in reply to
the other patches) but I could be persuaded to move the code to
intel_acpi.c.

> Signed-off-by: Rajat Jain <rajatja@google.com>
> Change-Id: Ifb3bd458734985c2a78ba682e6f0a2e63e0626ca

Please drop Change-Ids.

> ---
> v2: v1 doesn't exist. Found existing code in i915 driver to assign the ACPI ID
>     which is what I plan to re-use.
>     
>
>  drivers/gpu/drm/i915/display/intel_acpi.c     | 87 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_acpi.h     |  6 ++
>  drivers/gpu/drm/i915/display/intel_opregion.c | 80 +----------------
>  3 files changed, 97 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index 3456d33feb46..748d9b3125dd 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -156,3 +156,90 @@ void intel_register_dsm_handler(void)
>  void intel_unregister_dsm_handler(void)
>  {
>  }
> +
> +/*
> + * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
> + * Attached to the Display Adapter).
> + */
> +#define ACPI_DISPLAY_INDEX_SHIFT		0
> +#define ACPI_DISPLAY_INDEX_MASK			(0xf << 0)
> +#define ACPI_DISPLAY_PORT_ATTACHMENT_SHIFT	4
> +#define ACPI_DISPLAY_PORT_ATTACHMENT_MASK	(0xf << 4)
> +#define ACPI_DISPLAY_TYPE_SHIFT			8
> +#define ACPI_DISPLAY_TYPE_MASK			(0xf << 8)
> +#define ACPI_DISPLAY_TYPE_OTHER			(0 << 8)
> +#define ACPI_DISPLAY_TYPE_VGA			(1 << 8)
> +#define ACPI_DISPLAY_TYPE_TV			(2 << 8)
> +#define ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL	(3 << 8)
> +#define ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL	(4 << 8)
> +#define ACPI_VENDOR_SPECIFIC_SHIFT		12
> +#define ACPI_VENDOR_SPECIFIC_MASK		(0xf << 12)
> +#define ACPI_BIOS_CAN_DETECT			(1 << 16)
> +#define ACPI_DEPENDS_ON_VGA			(1 << 17)
> +#define ACPI_PIPE_ID_SHIFT			18
> +#define ACPI_PIPE_ID_MASK			(7 << 18)
> +#define ACPI_DEVICE_ID_SCHEME			(1ULL << 31)
> +
> +static u32 acpi_display_type(struct intel_connector *connector)
> +{
> +	u32 display_type;
> +
> +	switch (connector->base.connector_type) {
> +	case DRM_MODE_CONNECTOR_VGA:
> +	case DRM_MODE_CONNECTOR_DVIA:
> +		display_type = ACPI_DISPLAY_TYPE_VGA;
> +		break;
> +	case DRM_MODE_CONNECTOR_Composite:
> +	case DRM_MODE_CONNECTOR_SVIDEO:
> +	case DRM_MODE_CONNECTOR_Component:
> +	case DRM_MODE_CONNECTOR_9PinDIN:
> +	case DRM_MODE_CONNECTOR_TV:
> +		display_type = ACPI_DISPLAY_TYPE_TV;
> +		break;
> +	case DRM_MODE_CONNECTOR_DVII:
> +	case DRM_MODE_CONNECTOR_DVID:
> +	case DRM_MODE_CONNECTOR_DisplayPort:
> +	case DRM_MODE_CONNECTOR_HDMIA:
> +	case DRM_MODE_CONNECTOR_HDMIB:
> +		display_type = ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL;
> +		break;
> +	case DRM_MODE_CONNECTOR_LVDS:
> +	case DRM_MODE_CONNECTOR_eDP:
> +	case DRM_MODE_CONNECTOR_DSI:
> +		display_type = ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL;
> +		break;
> +	case DRM_MODE_CONNECTOR_Unknown:
> +	case DRM_MODE_CONNECTOR_VIRTUAL:
> +		display_type = ACPI_DISPLAY_TYPE_OTHER;
> +		break;
> +	default:
> +		MISSING_CASE(connector->base.connector_type);
> +		display_type = ACPI_DISPLAY_TYPE_OTHER;
> +		break;
> +	}
> +
> +	return display_type;
> +}
> +
> +void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev)

Plase use intel_foo_ prefix for functions in intel_foo.c,
i.e. intel_acpi_ here. Say, intel_acpi_device_id_update() or something.

Please always prefer struct drm_i915_private *i915 over struct
drm_device * pointers in i915 code.

> +{
> +	struct intel_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +	u8 display_index[16] = {};
> +	u32 device_id, type;
> +
> +	/* Populate the ACPI IDs for all connectors for a given drm_device */
> +	drm_connector_list_iter_begin(drm_dev, &conn_iter);
> +	for_each_intel_connector_iter(connector, &conn_iter) {
> +

Superfluous newline, the device_id and type local vars could be here as
in the original.

> +		device_id = acpi_display_type(connector);
> +
> +		/* Use display type specific display index. */
> +		type = (device_id & ACPI_DISPLAY_TYPE_MASK)
> +			>> ACPI_DISPLAY_TYPE_SHIFT;
> +		device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
> +
> +		connector->acpi_device_id = device_id;
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +}
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
> index 1c576b3fb712..8f6d850df6fa 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.h
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.h
> @@ -6,12 +6,18 @@
>  #ifndef __INTEL_ACPI_H__
>  #define __INTEL_ACPI_H__
>  
> +#include "intel_display_types.h"
> +

Please prefer forward declarations over adding new includes.

struct drm_i915_private;

>  #ifdef CONFIG_ACPI
>  void intel_register_dsm_handler(void);
>  void intel_unregister_dsm_handler(void);
> +void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev);
>  #else
>  static inline void intel_register_dsm_handler(void) { return; }
>  static inline void intel_unregister_dsm_handler(void) { return; }
> +static inline void
> +static inline void

Whoops.

> +intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev) { }
>  #endif /* CONFIG_ACPI */
>  
>  #endif /* __INTEL_ACPI_H__ */
> diff --git a/drivers/gpu/drm/i915/display/intel_opregion.c b/drivers/gpu/drm/i915/display/intel_opregion.c
> index 969ade623691..f5976a6ab3c4 100644
> --- a/drivers/gpu/drm/i915/display/intel_opregion.c
> +++ b/drivers/gpu/drm/i915/display/intel_opregion.c
> @@ -35,6 +35,7 @@
>  #include "display/intel_panel.h"
>  
>  #include "i915_drv.h"
> +#include "intel_acpi.h"
>  #include "intel_display_types.h"
>  #include "intel_opregion.h"
>  
> @@ -242,29 +243,6 @@ struct opregion_asle_ext {
>  #define SWSCI_SBCB_POST_VBE_PM		SWSCI_FUNCTION_CODE(SWSCI_SBCB, 19)
>  #define SWSCI_SBCB_ENABLE_DISABLE_AUDIO	SWSCI_FUNCTION_CODE(SWSCI_SBCB, 21)
>  
> -/*
> - * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
> - * Attached to the Display Adapter).
> - */
> -#define ACPI_DISPLAY_INDEX_SHIFT		0
> -#define ACPI_DISPLAY_INDEX_MASK			(0xf << 0)
> -#define ACPI_DISPLAY_PORT_ATTACHMENT_SHIFT	4
> -#define ACPI_DISPLAY_PORT_ATTACHMENT_MASK	(0xf << 4)
> -#define ACPI_DISPLAY_TYPE_SHIFT			8
> -#define ACPI_DISPLAY_TYPE_MASK			(0xf << 8)
> -#define ACPI_DISPLAY_TYPE_OTHER			(0 << 8)
> -#define ACPI_DISPLAY_TYPE_VGA			(1 << 8)
> -#define ACPI_DISPLAY_TYPE_TV			(2 << 8)
> -#define ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL	(3 << 8)
> -#define ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL	(4 << 8)
> -#define ACPI_VENDOR_SPECIFIC_SHIFT		12
> -#define ACPI_VENDOR_SPECIFIC_MASK		(0xf << 12)
> -#define ACPI_BIOS_CAN_DETECT			(1 << 16)
> -#define ACPI_DEPENDS_ON_VGA			(1 << 17)
> -#define ACPI_PIPE_ID_SHIFT			18
> -#define ACPI_PIPE_ID_MASK			(7 << 18)
> -#define ACPI_DEVICE_ID_SCHEME			(1 << 31)
> -
>  #define MAX_DSLP	1500
>  
>  static int swsci(struct drm_i915_private *dev_priv,
> @@ -662,54 +640,12 @@ static void set_did(struct intel_opregion *opregion, int i, u32 val)
>  	}
>  }
>  
> -static u32 acpi_display_type(struct intel_connector *connector)
> -{
> -	u32 display_type;
> -
> -	switch (connector->base.connector_type) {
> -	case DRM_MODE_CONNECTOR_VGA:
> -	case DRM_MODE_CONNECTOR_DVIA:
> -		display_type = ACPI_DISPLAY_TYPE_VGA;
> -		break;
> -	case DRM_MODE_CONNECTOR_Composite:
> -	case DRM_MODE_CONNECTOR_SVIDEO:
> -	case DRM_MODE_CONNECTOR_Component:
> -	case DRM_MODE_CONNECTOR_9PinDIN:
> -	case DRM_MODE_CONNECTOR_TV:
> -		display_type = ACPI_DISPLAY_TYPE_TV;
> -		break;
> -	case DRM_MODE_CONNECTOR_DVII:
> -	case DRM_MODE_CONNECTOR_DVID:
> -	case DRM_MODE_CONNECTOR_DisplayPort:
> -	case DRM_MODE_CONNECTOR_HDMIA:
> -	case DRM_MODE_CONNECTOR_HDMIB:
> -		display_type = ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL;
> -		break;
> -	case DRM_MODE_CONNECTOR_LVDS:
> -	case DRM_MODE_CONNECTOR_eDP:
> -	case DRM_MODE_CONNECTOR_DSI:
> -		display_type = ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL;
> -		break;
> -	case DRM_MODE_CONNECTOR_Unknown:
> -	case DRM_MODE_CONNECTOR_VIRTUAL:
> -		display_type = ACPI_DISPLAY_TYPE_OTHER;
> -		break;
> -	default:
> -		MISSING_CASE(connector->base.connector_type);
> -		display_type = ACPI_DISPLAY_TYPE_OTHER;
> -		break;
> -	}
> -
> -	return display_type;
> -}
> -
>  static void intel_didl_outputs(struct drm_i915_private *dev_priv)
>  {
>  	struct intel_opregion *opregion = &dev_priv->opregion;
>  	struct intel_connector *connector;
>  	struct drm_connector_list_iter conn_iter;
>  	int i = 0, max_outputs;
> -	int display_index[16] = {};
>  
>  	/*
>  	 * In theory, did2, the extended didl, gets added at opregion version
> @@ -721,20 +657,12 @@ static void intel_didl_outputs(struct drm_i915_private *dev_priv)
>  	max_outputs = ARRAY_SIZE(opregion->acpi->didl) +
>  		ARRAY_SIZE(opregion->acpi->did2);
>  
> +	intel_populate_acpi_ids_for_all_connectors(&dev_priv->drm);
> +

As the acpi_device_ids will be used elsewhere too, maybe this call needs
to be moved to a higher level and called on the resume path. *shrug*

BR,
Jani.

>  	drm_connector_list_iter_begin(&dev_priv->drm, &conn_iter);
>  	for_each_intel_connector_iter(connector, &conn_iter) {
> -		u32 device_id, type;
> -
> -		device_id = acpi_display_type(connector);
> -
> -		/* Use display type specific display index. */
> -		type = (device_id & ACPI_DISPLAY_TYPE_MASK)
> -			>> ACPI_DISPLAY_TYPE_SHIFT;
> -		device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
> -
> -		connector->acpi_device_id = device_id;
>  		if (i < max_outputs)
> -			set_did(opregion, i, device_id);
> +			set_did(opregion, i, connector->acpi_device_id);
>  		i++;
>  	}
>  	drm_connector_list_iter_end(&conn_iter);

-- 
Jani Nikula, Intel Open Source Graphics Center
