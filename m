Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6C6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595432064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPG4E9Jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfJWAMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:12:15 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55473 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbfJWAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:12:14 -0400
Received: by mail-pf1-f201.google.com with SMTP id u21so14657591pfm.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=zqN70IYDrp81wg8yHsEcapQPROi/kGtOXEycNw/gKkQ=;
        b=IPG4E9Jd3M9QM7xqGkEWwl+GQZ0MoJs5TAYppdgWpKNp36i/QO5U4VbZEEIgFvGcUk
         4tkSvhFZvSj/+AjhQQaRpQPA+AeW7P4qSAL5BNogVEOoBVdE5Y3sfeecY8YtAYtC0O1O
         ZRFQaftpImMnjc9w6v0gsUGa7RkLKxaXNy2vEXGMfxjDJtSSyAPCweikFkRN+58BGWHK
         ssK58sRac8FbE/Wp+63t3C08WlqINZY9sLsSMxCudOXkxJCPhI8R4b7jY6RH5dCCW1K8
         6EOBknpX1HH6tRhjvnc8uVMQFGQzLnmiFev1g+VOtReTkDYTUFykpyZvRgnn+BVrF3P5
         laVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=zqN70IYDrp81wg8yHsEcapQPROi/kGtOXEycNw/gKkQ=;
        b=UkeEQeLedFmXc7oJTxReHDk2qnggJPKXa1S5FmpONJ8UZogDKPC/yDjT6h7gZ/72VP
         apklltCGI7seTIggRuLQtqtKY0mqZc+q1yZ3vLFGu3qPtUQK1ZHnmhX74FO+b6v9VHJt
         Q21Ms1CX9toiKsdMH9nfp7sPeFSh1nXDg+pCvPzZ+7vC7Cjbs+/vIjC+iR2s1DLaT/Be
         xuFRxnEDRQ8TpXtVKIRVtrP1E+JZPzV0jpVnLVJvf8QFoymteLlRWbewcBA96U5QObUs
         NBar0LDl0lfQHV8AfLiTehSpvGSwh8nRuzdYZ61V1DZ6FUNNgezfjhPYkD4KTbT6J9g7
         KkVg==
X-Gm-Message-State: APjAAAV65b9RMF1qqAtqpRI0n3cwlIhE/RpLK8bmgtZyPVmZ8SakW3ix
        9tfU7s53iHBQCIx9OEDG+TTEfKHzN1wk
X-Google-Smtp-Source: APXvYqw0RcW/1e3HqLig1fAtZTymKCDkceIZ6JqDsGNrVS5AfGoBiOE2MkD/KI39gMRybb4d8Nd1Z3gbMxO+
X-Received: by 2002:a63:ea45:: with SMTP id l5mr6455839pgk.189.1571789531805;
 Tue, 22 Oct 2019 17:12:11 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:12:06 -0700
Message-Id: <20191023001206.15741-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH] drm: Add support for integrated privacy screens
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        "=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?=" <jose.souza@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
        mathewk@google.com, Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain laptops now come with panels that have integrated privacy
screens on them. This patch adds support for such panels by adding
a privacy-screen property to the drm_connector for the panel, that
the userspace can then use to control and check the status. The idea
was discussed here:

https://lkml.org/lkml/2019/10/1/786

ACPI methods are used to identify, query and control privacy screen:

* Identifying an ACPI object corresponding to the panel: The patch
follows ACPI Spec 6.3 (available at
https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf).
Pages 1119 - 1123 describe what I believe, is a standard way of
identifying / addressing "display panels" in the ACPI tables, thus
allowing kernel to attach ACPI nodes to the panel. IMHO, this ability
to identify and attach ACPI nodes to drm connectors may be useful for
reasons other privacy-screens, in future.

* Identifying the presence of privacy screen, and controlling it, is done
via ACPI _DSM methods.

Currently, this is done only for the Intel display ports. But in future,
this can be done for any other ports if the hardware becomes available
(e.g. external monitors supporting integrated privacy screens?).

Also, this code can be extended in future to support non-ACPI methods
(e.g. using a kernel GPIO driver to toggle a gpio that controls the
privacy-screen).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/gpu/drm/Makefile                |   1 +
 drivers/gpu/drm/drm_atomic_uapi.c       |   5 +
 drivers/gpu/drm/drm_connector.c         |  38 +++++
 drivers/gpu/drm/drm_privacy_screen.c    | 176 ++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c |   3 +
 include/drm/drm_connector.h             |  18 +++
 include/drm/drm_mode_config.h           |   7 +
 include/drm/drm_privacy_screen.h        |  33 +++++
 8 files changed, 281 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_privacy_screen.c
 create mode 100644 include/drm/drm_privacy_screen.h

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 82ff826b33cc..e1fc33d69bb7 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -19,6 +19,7 @@ drm-y       :=3D	drm_auth.o drm_cache.o \
 		drm_syncobj.o drm_lease.o drm_writeback.o drm_client.o \
 		drm_client_modeset.o drm_atomic_uapi.o drm_hdcp.o
=20
+drm-$(CONFIG_ACPI) +=3D drm_privacy_screen.o
 drm-$(CONFIG_DRM_LEGACY) +=3D drm_legacy_misc.o drm_bufs.o drm_context.o d=
rm_dma.o drm_scatter.o drm_lock.o
 drm-$(CONFIG_DRM_LIB_RANDOM) +=3D lib/drm_random.o
 drm-$(CONFIG_DRM_VM) +=3D drm_vm.o
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic=
_uapi.c
index 7a26bfb5329c..44131165e4ea 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -30,6 +30,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_privacy_screen.h>
 #include <drm/drm_writeback.h>
 #include <drm/drm_vblank.h>
=20
@@ -766,6 +767,8 @@ static int drm_atomic_connector_set_property(struct drm=
_connector *connector,
 						   fence_ptr);
 	} else if (property =3D=3D connector->max_bpc_property) {
 		state->max_requested_bpc =3D val;
+	} else if (property =3D=3D config->privacy_screen_property) {
+		drm_privacy_screen_set_val(connector, val);
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -842,6 +845,8 @@ drm_atomic_connector_get_property(struct drm_connector =
*connector,
 		*val =3D 0;
 	} else if (property =3D=3D connector->max_bpc_property) {
 		*val =3D state->max_requested_bpc;
+	} else if (property =3D=3D config->privacy_screen_property) {
+		*val =3D drm_privacy_screen_get_val(connector);
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connecto=
r.c
index 4c766624b20d..a31e0382132b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -821,6 +821,11 @@ static const struct drm_prop_enum_list drm_panel_orien=
tation_enum_list[] =3D {
 	{ DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,	"Right Side Up"	},
 };
=20
+static const struct drm_prop_enum_list drm_privacy_screen_enum_list[] =3D =
{
+	{ DRM_PRIVACY_SCREEN_DISABLED, "Disabled" },
+	{ DRM_PRIVACY_SCREEN_ENABLED, "Enabled" },
+};
+
 static const struct drm_prop_enum_list drm_dvi_i_select_enum_list[] =3D {
 	{ DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I and TV-out */
 	{ DRM_MODE_SUBCONNECTOR_DVID,      "DVI-D"     }, /* DVI-I  */
@@ -2253,6 +2258,39 @@ static void drm_tile_group_free(struct kref *kref)
 	kfree(tg);
 }
=20
+/**
+ * drm_connector_init_privacy_screen_property -
+ *	create and attach the connecter's privacy-screen property.
+ * @connector: connector for which to init the privacy-screen property.
+ *
+ * This function creates and attaches the "privacy-screen" property to the
+ * connector. Initial state of privacy-screen is set to disabled.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_init_privacy_screen_property(struct drm_connector *conne=
ctor)
+{
+	struct drm_device *dev =3D connector->dev;
+	struct drm_property *prop;
+
+	prop =3D dev->mode_config.privacy_screen_property;
+	if (!prop) {
+		prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_ENUM,
+				"privacy-screen", drm_privacy_screen_enum_list,
+				ARRAY_SIZE(drm_privacy_screen_enum_list));
+		if (!prop)
+			return -ENOMEM;
+
+		dev->mode_config.privacy_screen_property =3D prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop,
+				   DRM_PRIVACY_SCREEN_DISABLED);
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_init_privacy_screen_property);
+
 /**
  * drm_mode_put_tile_group - drop a reference to a tile group.
  * @dev: DRM device
diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_pri=
vacy_screen.c
new file mode 100644
index 000000000000..1d68e8aa6c5f
--- /dev/null
+++ b/drivers/gpu/drm/drm_privacy_screen.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DRM privacy Screen code
+ *
+ * Copyright =C2=A9 2019 Google Inc.
+ */
+
+#include <linux/acpi.h>
+#include <linux/pci.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_device.h>
+#include <drm/drm_print.h>
+
+#define DRM_CONN_DSM_REVID 1
+
+#define DRM_CONN_DSM_FN_PRIVACY_GET_STATUS	1
+#define DRM_CONN_DSM_FN_PRIVACY_ENABLE		2
+#define DRM_CONN_DSM_FN_PRIVACY_DISABLE		3
+
+static const guid_t drm_conn_dsm_guid =3D
+	GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
+		  0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
+
+/*
+ * Makes _DSM call to set privacy screen status or get privacy screen. Ret=
urn
+ * value matters only for PRIVACY_GET_STATUS case. Returns 0 if disabled, =
1 if
+ * enabled.
+ */
+static int acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 func)
+{
+	union acpi_object *obj;
+	int ret =3D 0;
+
+	obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
+				DRM_CONN_DSM_REVID, func, NULL);
+	if (!obj) {
+		DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n", func);
+		/* Can't do much. For get_val, assume privacy_screen disabled */
+		goto done;
+	}
+
+	if (func =3D=3D DRM_CONN_DSM_FN_PRIVACY_GET_STATUS &&
+	    obj->type =3D=3D ACPI_TYPE_INTEGER)
+		ret =3D !!obj->integer.value;
+done:
+	ACPI_FREE(obj);
+	return ret;
+}
+
+void drm_privacy_screen_set_val(struct drm_connector *connector,
+				 enum drm_privacy_screen val)
+{
+	acpi_handle acpi_handle =3D connector->privacy_screen_handle;
+
+	if (!acpi_handle)
+		return;
+
+	if (val =3D=3D DRM_PRIVACY_SCREEN_DISABLED)
+		acpi_privacy_screen_call_dsm(acpi_handle,
+					     DRM_CONN_DSM_FN_PRIVACY_DISABLE);
+	else if (val =3D=3D DRM_PRIVACY_SCREEN_ENABLED)
+		acpi_privacy_screen_call_dsm(acpi_handle,
+					     DRM_CONN_DSM_FN_PRIVACY_ENABLE);
+}
+
+enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_connector
+						   *connector)
+{
+	acpi_handle acpi_handle =3D connector->privacy_screen_handle;
+
+	if (acpi_handle &&
+	    acpi_privacy_screen_call_dsm(acpi_handle,
+					 DRM_CONN_DSM_FN_PRIVACY_GET_STATUS))
+		return DRM_PRIVACY_SCREEN_ENABLED;
+
+	return DRM_PRIVACY_SCREEN_DISABLED;
+}
+
+/*
+ * See ACPI Spec v6.3, Table B-2, "Display Type" for details.
+ * In short, these macros define the base _ADR values for ACPI nodes
+ */
+#define ACPI_BASE_ADR_FOR_OTHERS	(0ULL << 8)
+#define ACPI_BASE_ADR_FOR_VGA		(1ULL << 8)
+#define ACPI_BASE_ADR_FOR_TV		(2ULL << 8)
+#define ACPI_BASE_ADR_FOR_EXT_MON	(3ULL << 8)
+#define ACPI_BASE_ADR_FOR_INTEGRATED	(4ULL << 8)
+
+#define ACPI_DEVICE_ID_SCHEME		(1ULL << 31)
+#define ACPI_FIRMWARE_CAN_DETECT	(1ULL << 16)
+
+/*
+ * Ref: ACPI Spec 6.3
+ * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
+ * Pages 1119 - 1123 describe, what I believe, a standard way of
+ * identifying / addressing "display panels" in the ACPI. Thus it provides
+ * a way for the ACPI to define devices for the display panels attached
+ * to the system. It thus provides a way for the BIOS to export any panel
+ * specific properties to the system via ACPI (like device trees).
+ *
+ * The following function looks up the ACPI node for a connector and links
+ * to it. Technically it is independent from the privacy_screen code, and
+ * ideally may be called for all connectors. It is generally a good idea t=
o
+ * be able to attach an ACPI node to describe anything if needed. (This ca=
n
+ * help in future for other panel specific features maybe). However, it
+ * needs a "port index" which I believe is the index within a particular
+ * type of port (Ref to the pages of spec mentioned above). This port inde=
x
+ * unfortunately is not available in DRM code, so currently its call is
+ * originated from i915 driver.
+ */
+static int drm_connector_attach_acpi_node(struct drm_connector *connector,
+					  u8 port_index)
+{
+	struct device *dev =3D &connector->dev->pdev->dev;
+	struct acpi_device *conn_dev;
+	u64 conn_addr;
+
+	/*
+	 * Determine what _ADR to look for, depending on device type and
+	 * port number. Potentially we only care about the
+	 * eDP / integrated displays?
+	 */
+	switch (connector->connector_type) {
+	case DRM_MODE_CONNECTOR_eDP:
+		conn_addr =3D ACPI_BASE_ADR_FOR_INTEGRATED + port_index;
+		break;
+	case DRM_MODE_CONNECTOR_VGA:
+		conn_addr =3D ACPI_BASE_ADR_FOR_VGA + port_index;
+		break;
+	case DRM_MODE_CONNECTOR_TV:
+		conn_addr =3D ACPI_BASE_ADR_FOR_TV + port_index;
+		break;
+	case DRM_MODE_CONNECTOR_DisplayPort:
+		conn_addr =3D ACPI_BASE_ADR_FOR_EXT_MON + port_index;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	conn_addr |=3D ACPI_DEVICE_ID_SCHEME;
+	conn_addr |=3D ACPI_FIRMWARE_CAN_DETECT;
+
+	DRM_DEV_DEBUG(dev, "%s: Finding drm_connector ACPI node at _ADR=3D%llX\n"=
,
+		      __func__, conn_addr);
+
+	/* Look up the connector device, under the PCI device */
+	conn_dev =3D acpi_find_child_device(ACPI_COMPANION(dev),
+					  conn_addr, false);
+	if (!conn_dev)
+		return -ENODEV;
+
+	connector->privacy_screen_handle =3D conn_dev->handle;
+	return 0;
+}
+
+bool drm_privacy_screen_present(struct drm_connector *connector, u8 port_i=
ndex)
+{
+	acpi_handle handle;
+
+	if (drm_connector_attach_acpi_node(connector, port_index))
+		return false;
+
+	handle =3D connector->privacy_screen_handle;
+	if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
+			    DRM_CONN_DSM_REVID,
+			    1 << DRM_CONN_DSM_FN_PRIVACY_GET_STATUS |
+			    1 << DRM_CONN_DSM_FN_PRIVACY_ENABLE |
+			    1 << DRM_CONN_DSM_FN_PRIVACY_DISABLE)) {
+		DRM_WARN("%s: Odd, connector ACPI node but no privacy scrn?\n",
+			 connector->dev->dev);
+		return false;
+	}
+	DRM_DEV_INFO(connector->dev->dev, "supports privacy screen\n");
+	return true;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915=
/display/intel_dp.c
index 57e9f0ba331b..3ff3962d27db 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -39,6 +39,7 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_hdcp.h>
+#include <drm/drm_privacy_screen.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/i915_drm.h>
=20
@@ -6354,6 +6355,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, st=
ruct drm_connector *connect
=20
 		connector->state->scaling_mode =3D DRM_MODE_SCALE_ASPECT;
=20
+		if (drm_privacy_screen_present(connector, port - PORT_A))
+			drm_connector_init_privacy_screen_property(connector);
 	}
 }
=20
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 681cb590f952..63b8318bd68c 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -225,6 +225,20 @@ enum drm_link_status {
 	DRM_LINK_STATUS_BAD =3D DRM_MODE_LINK_STATUS_BAD,
 };
=20
+/**
+ * enum drm_privacy_screen - privacy_screen status
+ *
+ * This enum is used to track and control the state of the privacy screen.
+ * There are no separate #defines for the uapi!
+ *
+ * @DRM_PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disabl=
ed
+ * @DRM_PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enable=
d
+ */
+enum drm_privacy_screen {
+	DRM_PRIVACY_SCREEN_DISABLED =3D 0,
+	DRM_PRIVACY_SCREEN_ENABLED =3D 1,
+};
+
 /**
  * enum drm_panel_orientation - panel_orientation info for &drm_display_in=
fo
  *
@@ -1410,6 +1424,9 @@ struct drm_connector {
=20
 	/** @hdr_sink_metadata: HDR Metadata Information read from sink */
 	struct hdr_sink_metadata hdr_sink_metadata;
+
+	/* Handle used by privacy screen code */
+	void *privacy_screen_handle;
 };
=20
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
@@ -1543,6 +1560,7 @@ int drm_connector_init_panel_orientation_property(
 	struct drm_connector *connector, int width, int height);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
+int drm_connector_init_privacy_screen_property(struct drm_connector *conne=
ctor);
=20
 /**
  * struct drm_tile_group - Tile group metadata
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 3bcbe30339f0..6d5d23da90d4 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -813,6 +813,13 @@ struct drm_mode_config {
 	 */
 	struct drm_property *panel_orientation_property;
=20
+	/**
+	 * @privacy_screen_property: Optional connector property to indicate
+	 * and control the state (enabled / disabled) of privacy-screen on the
+	 * panel, if present.
+	 */
+	struct drm_property *privacy_screen_property;
+
 	/**
 	 * @writeback_fb_id_property: Property for writeback connectors, storing
 	 * the ID of the output framebuffer.
diff --git a/include/drm/drm_privacy_screen.h b/include/drm/drm_privacy_scr=
een.h
new file mode 100644
index 000000000000..c589bbc47656
--- /dev/null
+++ b/include/drm/drm_privacy_screen.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright =C2=A9 2019 Google Inc.
+ */
+
+#ifndef __DRM_PRIVACY_SCREEN_H__
+#define __DRM_PRIVACY_SCREEN_H__
+
+#ifdef CONFIG_ACPI
+bool drm_privacy_screen_present(struct drm_connector *connector, u8 port);
+void drm_privacy_screen_set_val(struct drm_connector *connector,
+				enum drm_privacy_screen val);
+enum drm_privacy_screen drm_privacy_screen_get_val(struct drm_connector
+						   *connector);
+#else
+static inline bool drm_privacy_screen_present(struct drm_connector *connec=
tor,
+					      u8 port)
+{
+	return false;
+}
+
+void drm_privacy_screen_set_val(struct drm_connector *connector,
+				enum drm_privacy_screen val)
+{ }
+
+enum drm_privacy_screen drm_privacy_screen_get_val(
+					struct drm_connector *connector)
+{
+	return DRM_PRIVACY_SCREEN_DISABLED;
+}
+#endif /* CONFIG_ACPI */
+
+#endif /* __DRM_PRIVACY_SCREEN_H__ */
--=20
2.23.0.866.gb869b98d4c-goog

