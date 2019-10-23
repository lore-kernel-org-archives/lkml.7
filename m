Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85878CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBF921906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="STYENaT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403821AbfJWJVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:21:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40338 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403799AbfJWJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:21:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so21214401wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hn8D9HlEsPbkhWg9lbIBIet9NkmHLPjuXeikJJ7gSrw=;
        b=STYENaT1GWt3vSQSzL+13on3OtnPcFf/5cKkTZFHx9/Ozl7Albnihj9Ka518G/6eek
         qIMRPL8mJYaaeIM1PfZz9uH1B5NCFzZDklq5tiETwmNE6HPcTNtTaxwN9K9DuFNQgYKj
         nJsc7rFhe4EbJ2OouUdAS4pQC0arh+zSCIkos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hn8D9HlEsPbkhWg9lbIBIet9NkmHLPjuXeikJJ7gSrw=;
        b=cFigC/YbuL2Nqmc24Xe8TJBZB2zebgTCD/foaHTLysEP9ikZvuxl2m+o3hs/AtFT8k
         cG+neJcTBSaZyv9EM2TcuYWqoTPJj2jzHiI6bXwNOShAm/yvQ6TaIl8GqzLJHdzHLuew
         tkPDSNmZf8mWe1Pyao6Cq4KGOPClYXOwmaYRuVRt/c9HLlseq3s6G3fUHZ5PGYzJJO8z
         CMAUVEEubU1EySWqxe5FKa0ooA79wsMmk9yvtPzISBNb6zeEX1iH3tABoyha6GTTB1z8
         ACvyOlO6LRc6oVLdAPTYkPzIvJ7O8CBu6EDmzjw/ga/S8qozRIaTgcSOU6Fb6S2AsdWZ
         4Ipw==
X-Gm-Message-State: APjAAAXJjzTrNCDtHJVxeuO4kqpJNIYbLLpd06+YBAAdKesDlUYGqr6J
        05swx7vsR3ihPwJyZofXZhDINQ==
X-Google-Smtp-Source: APXvYqxdDqv5OQ1s2mqNxW7PHfRsCvksPP87xgwgwjbsBoLbkTSMPzWP19HgkayLkaPl15bCiIxvhA==
X-Received: by 2002:a05:6000:118f:: with SMTP id g15mr4045292wrx.242.1571822490034;
        Wed, 23 Oct 2019 02:21:30 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id d8sm7872047wrr.71.2019.10.23.02.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 02:21:29 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:21:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        gregkh@linuxfoundation.org, mathewk@google.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, rajatxjain@gmail.com
Subject: Re: [PATCH] drm: Add support for integrated privacy screens
Message-ID: <20191023092127.GY11828@phenom.ffwll.local>
Mail-Followup-To: Rajat Jain <rajatja@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
        mathewk@google.com, Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, rajatxjain@gmail.com
References: <20191023001206.15741-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191023001206.15741-1-rajatja@google.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:12:06PM -0700, Rajat Jain wrote:
> Certain laptops now come with panels that have integrated privacy
> screens on them. This patch adds support for such panels by adding
> a privacy-screen property to the drm_connector for the panel, that
> the userspace can then use to control and check the status. The idea
> was discussed here:
> 
> https://lkml.org/lkml/2019/10/1/786
> 
> ACPI methods are used to identify, query and control privacy screen:
> 
> * Identifying an ACPI object corresponding to the panel: The patch
> follows ACPI Spec 6.3 (available at
> https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf).
> Pages 1119 - 1123 describe what I believe, is a standard way of
> identifying / addressing "display panels" in the ACPI tables, thus
> allowing kernel to attach ACPI nodes to the panel. IMHO, this ability
> to identify and attach ACPI nodes to drm connectors may be useful for
> reasons other privacy-screens, in future.
> 
> * Identifying the presence of privacy screen, and controlling it, is done
> via ACPI _DSM methods.
> 
> Currently, this is done only for the Intel display ports. But in future,
> this can be done for any other ports if the hardware becomes available
> (e.g. external monitors supporting integrated privacy screens?).
> 
> Also, this code can be extended in future to support non-ACPI methods
> (e.g. using a kernel GPIO driver to toggle a gpio that controls the
> privacy-screen).
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

New properties need property docs in the relevant section:

https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#kms-properties

$ make htmldocs

for building them locally.

Cheers, Daniel

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
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 82ff826b33cc..e1fc33d69bb7 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -19,6 +19,7 @@ drm-y       :=	drm_auth.o drm_cache.o \
>  		drm_syncobj.o drm_lease.o drm_writeback.o drm_client.o \
>  		drm_client_modeset.o drm_atomic_uapi.o drm_hdcp.o
>  
> +drm-$(CONFIG_ACPI) += drm_privacy_screen.o
>  drm-$(CONFIG_DRM_LEGACY) += drm_legacy_misc.o drm_bufs.o drm_context.o drm_dma.o drm_scatter.o drm_lock.o
>  drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
>  drm-$(CONFIG_DRM_VM) += drm_vm.o
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
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
>  
> @@ -766,6 +767,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>  						   fence_ptr);
>  	} else if (property == connector->max_bpc_property) {
>  		state->max_requested_bpc = val;
> +	} else if (property == config->privacy_screen_property) {
> +		drm_privacy_screen_set_val(connector, val);
>  	} else if (connector->funcs->atomic_set_property) {
>  		return connector->funcs->atomic_set_property(connector,
>  				state, property, val);
> @@ -842,6 +845,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>  		*val = 0;
>  	} else if (property == connector->max_bpc_property) {
>  		*val = state->max_requested_bpc;
> +	} else if (property == config->privacy_screen_property) {
> +		*val = drm_privacy_screen_get_val(connector);
>  	} else if (connector->funcs->atomic_get_property) {
>  		return connector->funcs->atomic_get_property(connector,
>  				state, property, val);
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 4c766624b20d..a31e0382132b 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -821,6 +821,11 @@ static const struct drm_prop_enum_list drm_panel_orientation_enum_list[] = {
>  	{ DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,	"Right Side Up"	},
>  };
>  
> +static const struct drm_prop_enum_list drm_privacy_screen_enum_list[] = {
> +	{ DRM_PRIVACY_SCREEN_DISABLED, "Disabled" },
> +	{ DRM_PRIVACY_SCREEN_ENABLED, "Enabled" },
> +};
> +
>  static const struct drm_prop_enum_list drm_dvi_i_select_enum_list[] = {
>  	{ DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I and TV-out */
>  	{ DRM_MODE_SUBCONNECTOR_DVID,      "DVI-D"     }, /* DVI-I  */
> @@ -2253,6 +2258,39 @@ static void drm_tile_group_free(struct kref *kref)
>  	kfree(tg);
>  }
>  
> +/**
> + * drm_connector_init_privacy_screen_property -
> + *	create and attach the connecter's privacy-screen property.
> + * @connector: connector for which to init the privacy-screen property.
> + *
> + * This function creates and attaches the "privacy-screen" property to the
> + * connector. Initial state of privacy-screen is set to disabled.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_init_privacy_screen_property(struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_property *prop;
> +
> +	prop = dev->mode_config.privacy_screen_property;
> +	if (!prop) {
> +		prop = drm_property_create_enum(dev, DRM_MODE_PROP_ENUM,
> +				"privacy-screen", drm_privacy_screen_enum_list,
> +				ARRAY_SIZE(drm_privacy_screen_enum_list));
> +		if (!prop)
> +			return -ENOMEM;
> +
> +		dev->mode_config.privacy_screen_property = prop;
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
> diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_privacy_screen.c
> new file mode 100644
> index 000000000000..1d68e8aa6c5f
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_privacy_screen.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DRM privacy Screen code
> + *
> + * Copyright © 2019 Google Inc.
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
> +static const guid_t drm_conn_dsm_guid =
> +	GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
> +		  0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
> +
> +/*
> + * Makes _DSM call to set privacy screen status or get privacy screen. Return
> + * value matters only for PRIVACY_GET_STATUS case. Returns 0 if disabled, 1 if
> + * enabled.
> + */
> +static int acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 func)
> +{
> +	union acpi_object *obj;
> +	int ret = 0;
> +
> +	obj = acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
> +				DRM_CONN_DSM_REVID, func, NULL);
> +	if (!obj) {
> +		DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n", func);
> +		/* Can't do much. For get_val, assume privacy_screen disabled */
> +		goto done;
> +	}
> +
> +	if (func == DRM_CONN_DSM_FN_PRIVACY_GET_STATUS &&
> +	    obj->type == ACPI_TYPE_INTEGER)
> +		ret = !!obj->integer.value;
> +done:
> +	ACPI_FREE(obj);
> +	return ret;
> +}
> +
> +void drm_privacy_screen_set_val(struct drm_connector *connector,
> +				 enum drm_privacy_screen val)
> +{
> +	acpi_handle acpi_handle = connector->privacy_screen_handle;
> +
> +	if (!acpi_handle)
> +		return;
> +
> +	if (val == DRM_PRIVACY_SCREEN_DISABLED)
> +		acpi_privacy_screen_call_dsm(acpi_handle,
> +					     DRM_CONN_DSM_FN_PRIVACY_DISABLE);
> +	else if (val == DRM_PRIVACY_SCREEN_ENABLED)
> +		acpi_privacy_screen_call_dsm(acpi_handle,
> +					     DRM_CONN_DSM_FN_PRIVACY_ENABLE);
> +}
> +
> +enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_connector
> +						   *connector)
> +{
> +	acpi_handle acpi_handle = connector->privacy_screen_handle;
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
> + * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> + * Pages 1119 - 1123 describe, what I believe, a standard way of
> + * identifying / addressing "display panels" in the ACPI. Thus it provides
> + * a way for the ACPI to define devices for the display panels attached
> + * to the system. It thus provides a way for the BIOS to export any panel
> + * specific properties to the system via ACPI (like device trees).
> + *
> + * The following function looks up the ACPI node for a connector and links
> + * to it. Technically it is independent from the privacy_screen code, and
> + * ideally may be called for all connectors. It is generally a good idea to
> + * be able to attach an ACPI node to describe anything if needed. (This can
> + * help in future for other panel specific features maybe). However, it
> + * needs a "port index" which I believe is the index within a particular
> + * type of port (Ref to the pages of spec mentioned above). This port index
> + * unfortunately is not available in DRM code, so currently its call is
> + * originated from i915 driver.
> + */
> +static int drm_connector_attach_acpi_node(struct drm_connector *connector,
> +					  u8 port_index)
> +{
> +	struct device *dev = &connector->dev->pdev->dev;
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
> +		conn_addr = ACPI_BASE_ADR_FOR_INTEGRATED + port_index;
> +		break;
> +	case DRM_MODE_CONNECTOR_VGA:
> +		conn_addr = ACPI_BASE_ADR_FOR_VGA + port_index;
> +		break;
> +	case DRM_MODE_CONNECTOR_TV:
> +		conn_addr = ACPI_BASE_ADR_FOR_TV + port_index;
> +		break;
> +	case DRM_MODE_CONNECTOR_DisplayPort:
> +		conn_addr = ACPI_BASE_ADR_FOR_EXT_MON + port_index;
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	conn_addr |= ACPI_DEVICE_ID_SCHEME;
> +	conn_addr |= ACPI_FIRMWARE_CAN_DETECT;
> +
> +	DRM_DEV_DEBUG(dev, "%s: Finding drm_connector ACPI node at _ADR=%llX\n",
> +		      __func__, conn_addr);
> +
> +	/* Look up the connector device, under the PCI device */
> +	conn_dev = acpi_find_child_device(ACPI_COMPANION(dev),
> +					  conn_addr, false);
> +	if (!conn_dev)
> +		return -ENODEV;
> +
> +	connector->privacy_screen_handle = conn_dev->handle;
> +	return 0;
> +}
> +
> +bool drm_privacy_screen_present(struct drm_connector *connector, u8 port_index)
> +{
> +	acpi_handle handle;
> +
> +	if (drm_connector_attach_acpi_node(connector, port_index))
> +		return false;
> +
> +	handle = connector->privacy_screen_handle;
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
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
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
>  
> @@ -6354,6 +6355,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
>  
>  		connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>  
> +		if (drm_privacy_screen_present(connector, port - PORT_A))
> +			drm_connector_init_privacy_screen_property(connector);
>  	}
>  }
>  
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 681cb590f952..63b8318bd68c 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -225,6 +225,20 @@ enum drm_link_status {
>  	DRM_LINK_STATUS_BAD = DRM_MODE_LINK_STATUS_BAD,
>  };
>  
> +/**
> + * enum drm_privacy_screen - privacy_screen status
> + *
> + * This enum is used to track and control the state of the privacy screen.
> + * There are no separate #defines for the uapi!
> + *
> + * @DRM_PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disabled
> + * @DRM_PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enabled
> + */
> +enum drm_privacy_screen {
> +	DRM_PRIVACY_SCREEN_DISABLED = 0,
> +	DRM_PRIVACY_SCREEN_ENABLED = 1,
> +};
> +
>  /**
>   * enum drm_panel_orientation - panel_orientation info for &drm_display_info
>   *
> @@ -1410,6 +1424,9 @@ struct drm_connector {
>  
>  	/** @hdr_sink_metadata: HDR Metadata Information read from sink */
>  	struct hdr_sink_metadata hdr_sink_metadata;
> +
> +	/* Handle used by privacy screen code */
> +	void *privacy_screen_handle;
>  };
>  
>  #define obj_to_connector(x) container_of(x, struct drm_connector, base)
> @@ -1543,6 +1560,7 @@ int drm_connector_init_panel_orientation_property(
>  	struct drm_connector *connector, int width, int height);
>  int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>  					  int min, int max);
> +int drm_connector_init_privacy_screen_property(struct drm_connector *connector);
>  
>  /**
>   * struct drm_tile_group - Tile group metadata
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 3bcbe30339f0..6d5d23da90d4 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -813,6 +813,13 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *panel_orientation_property;
>  
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
> diff --git a/include/drm/drm_privacy_screen.h b/include/drm/drm_privacy_screen.h
> new file mode 100644
> index 000000000000..c589bbc47656
> --- /dev/null
> +++ b/include/drm/drm_privacy_screen.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright © 2019 Google Inc.
> + */
> +
> +#ifndef __DRM_PRIVACY_SCREEN_H__
> +#define __DRM_PRIVACY_SCREEN_H__
> +
> +#ifdef CONFIG_ACPI
> +bool drm_privacy_screen_present(struct drm_connector *connector, u8 port);
> +void drm_privacy_screen_set_val(struct drm_connector *connector,
> +				enum drm_privacy_screen val);
> +enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_connector
> +						   *connector);
> +#else
> +static inline bool drm_privacy_screen_present(struct drm_connector *connector,
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
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
