Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9075ECA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560DA2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Awwva4OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfKDTmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:42:02 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50726 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfKDTmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:42:00 -0500
Received: by mail-pf1-f202.google.com with SMTP id e13so7564041pff.17
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=YdVyYg2TmQWu6y8ro0turwBGFf90uoYSpY3DT2vX64s=;
        b=Awwva4OYZqsgvr4XB0eagEQnkESDAGDOveuMyxA3WOUz8UuvUMXNsmfJCxw8C+D15U
         Y/RcQc3ZcVijXTQNWz8uaJkOx28iDKZscO1fFDaC/dcGcUmHyXv57TEAHJq8C/j7JdAN
         bbR0ylU4f9XtuKy5n5bJttu2tNFrg4HBVhvgX6HHmoyxkJhwlWkJpioZxTnKvp9auQoM
         +HGUS96U5pkKVyfB4aHsK3hCVeRM3xkjLZOHMI1nhB8Cm9KlDxsB3c3ZeEK/xn1Jckzf
         Jgjx+gzf+ZnzOmcXUFx2tKvBiA564FXEaZHx+QpG/kPWTNjkxeCBpx1GgIFjW5uNPB1u
         yKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=YdVyYg2TmQWu6y8ro0turwBGFf90uoYSpY3DT2vX64s=;
        b=eQFyQRR1msUlj6eHYCxMC0GIfiAoRSgTytDtXviIaJsC2VQ0MAAHNZS7yA7xr0vpQb
         0g8DBCa+qR10bpclUv0tEO7NSgtkuBl6GvcWVdB5kUXUKYVZYsISIMLDkUDRFiP562S5
         J7OzAZ5LzLZfMt5WyWWsYe0Xb2cP3HT95PIz1bpEqsVZCZID999phl1Bnof+H3b6hFZy
         be/212B3limj7SXph9Y2kbvcz6mfaK7bUTFn+kkVAgy8nIBlnrWGgcDDn+Il8Tx5trA9
         rzutIaN1xTLWpYLMu+FyZKIN8eN8c5ZnEydZ3P/ooKXgXVvVNYZS96uPhHmLcL/YuwKj
         TecQ==
X-Gm-Message-State: APjAAAUORZmt0IoMHfU3G1fubt9bgnhXwGYR3Ajqp8wqnGpTihaEj9hj
        gddwKar7ev96UWgxHW2XFwK+FpnPUQcf
X-Google-Smtp-Source: APXvYqzWIBzt1JHFt6ogpAZ9xhFDdJOaQRMhLHY3DaK6aSnDATwEYqL9Z+ZpYF7w/1SgRgoQeZ4Pv0z/pePe
X-Received: by 2002:a63:1a5e:: with SMTP id a30mr27305343pgm.299.1572896517733;
 Mon, 04 Nov 2019 11:41:57 -0800 (PST)
Date:   Mon,  4 Nov 2019 11:41:47 -0800
In-Reply-To: <20191104194147.185642-1-rajatja@google.com>
Message-Id: <20191104194147.185642-3-rajatja@google.com>
Mime-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191104194147.185642-1-rajatja@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v2 3/3] drm/i915: Add support for integrated privacy screens
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
        jsbarnes@google.com, Thierry Reding <thierry.reding@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain laptops now come with panels that have integrated privacy
screens on them. This patch adds support for such panels by adding
a privacy-screen property to the intel_connector for the panel, that
the userspace can then use to control and check the status.

Identifying the presence of privacy screen, and controlling it, is done
via ACPI _DSM methods.

Currently, this is done only for the Intel display ports. But in future,
this can be done for any other ports if the hardware becomes available
(e.g. external monitors supporting integrated privacy screens?).

Signed-off-by: Rajat Jain <rajatja@google.com>
Change-Id: Ic9ff07fc4a50797d2d0dfb919f11aa0821a4b548
---
v2: Formed by splitting the original patch into multiple patches.
    - All code has been moved into i915 now.
    - Privacy screen is a i915 property
    - Have a local state variable to store the prvacy screen. Don't read
      it from hardware.

 drivers/gpu/drm/i915/Makefile                 |  3 +-
 drivers/gpu/drm/i915/display/intel_atomic.c   | 13 +++-
 .../gpu/drm/i915/display/intel_connector.c    | 35 ++++++++++
 .../gpu/drm/i915/display/intel_connector.h    |  1 +
 .../drm/i915/display/intel_display_types.h    |  4 ++
 drivers/gpu/drm/i915/display/intel_dp.c       |  5 ++
 .../drm/i915/display/intel_privacy_screen.c   | 70 +++++++++++++++++++
 .../drm/i915/display/intel_privacy_screen.h   | 25 +++++++
 include/uapi/drm/i915_drm.h                   | 14 ++++
 9 files changed, 166 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 2587ea834f06..3589ebcf27bc 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -185,7 +185,8 @@ i915-y +=3D \
 	display/intel_tc.o
 i915-$(CONFIG_ACPI) +=3D \
 	display/intel_acpi.o \
-	display/intel_opregion.o
+	display/intel_opregion.o \
+	display/intel_privacy_screen.o
 i915-$(CONFIG_DRM_FBDEV_EMULATION) +=3D \
 	display/intel_fbdev.o
=20
diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/=
i915/display/intel_atomic.c
index d3fb75bb9eb1..378772d3449c 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -37,6 +37,7 @@
 #include "intel_atomic.h"
 #include "intel_display_types.h"
 #include "intel_hdcp.h"
+#include "intel_privacy_screen.h"
 #include "intel_sprite.h"
=20
 /**
@@ -57,11 +58,14 @@ int intel_digital_connector_atomic_get_property(struct =
drm_connector *connector,
 	struct drm_i915_private *dev_priv =3D to_i915(dev);
 	struct intel_digital_connector_state *intel_conn_state =3D
 		to_intel_digital_connector_state(state);
+	struct intel_connector *intel_connector =3D to_intel_connector(connector)=
;
=20
 	if (property =3D=3D dev_priv->force_audio_property)
 		*val =3D intel_conn_state->force_audio;
 	else if (property =3D=3D dev_priv->broadcast_rgb_property)
 		*val =3D intel_conn_state->broadcast_rgb;
+	else if (property =3D=3D intel_connector->privacy_screen_property)
+		*val =3D intel_conn_state->privacy_screen_status;
 	else {
 		DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
 				 property->base.id, property->name);
@@ -89,15 +93,18 @@ int intel_digital_connector_atomic_set_property(struct =
drm_connector *connector,
 	struct drm_i915_private *dev_priv =3D to_i915(dev);
 	struct intel_digital_connector_state *intel_conn_state =3D
 		to_intel_digital_connector_state(state);
+	struct intel_connector *intel_connector =3D to_intel_connector(connector)=
;
=20
 	if (property =3D=3D dev_priv->force_audio_property) {
 		intel_conn_state->force_audio =3D val;
 		return 0;
-	}
-
-	if (property =3D=3D dev_priv->broadcast_rgb_property) {
+	} else if (property =3D=3D dev_priv->broadcast_rgb_property) {
 		intel_conn_state->broadcast_rgb =3D val;
 		return 0;
+	} else if (property =3D=3D intel_connector->privacy_screen_property) {
+		intel_privacy_screen_set_val(intel_connector, val);
+		intel_conn_state->privacy_screen_status =3D val;
+		return 0;
 	}
=20
 	DRM_DEBUG_ATOMIC("Unknown property [PROP:%d:%s]\n",
diff --git a/drivers/gpu/drm/i915/display/intel_connector.c b/drivers/gpu/d=
rm/i915/display/intel_connector.c
index 308ec63207ee..3ccbf52aedf9 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.c
+++ b/drivers/gpu/drm/i915/display/intel_connector.c
@@ -281,3 +281,38 @@ intel_attach_colorspace_property(struct drm_connector =
*connector)
 		drm_object_attach_property(&connector->base,
 					   connector->colorspace_property, 0);
 }
+
+static const struct drm_prop_enum_list privacy_screen_enum[] =3D {
+	{ PRIVACY_SCREEN_DISABLED, "Disabled" },
+	{ PRIVACY_SCREEN_ENABLED, "Enabled" },
+};
+
+/**
+ * intel_attach_privacy_screen_property -
+ *     create and attach the connecter's privacy-screen property. *
+ * @connector: connector for which to init the privacy-screen property
+ *
+ * This function creates and attaches the "privacy-screen" property to the
+ * connector. Initial state of privacy-screen is set to disabled.
+ */
+void
+intel_attach_privacy_screen_property(struct drm_connector *connector)
+{
+	struct intel_connector *intel_connector =3D to_intel_connector(connector)=
;
+	struct drm_property *prop;
+
+	if (!intel_connector->privacy_screen_property) {
+		prop =3D drm_property_create_enum(connector->dev,
+						DRM_MODE_PROP_ENUM,
+						"privacy-screen",
+						privacy_screen_enum,
+					    ARRAY_SIZE(privacy_screen_enum));
+		if (!prop)
+			return;
+
+		intel_connector->privacy_screen_property =3D prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop,
+				   PRIVACY_SCREEN_DISABLED);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_connector.h b/drivers/gpu/d=
rm/i915/display/intel_connector.h
index 93a7375c8196..61005f37a338 100644
--- a/drivers/gpu/drm/i915/display/intel_connector.h
+++ b/drivers/gpu/drm/i915/display/intel_connector.h
@@ -31,5 +31,6 @@ void intel_attach_force_audio_property(struct drm_connect=
or *connector);
 void intel_attach_broadcast_rgb_property(struct drm_connector *connector);
 void intel_attach_aspect_ratio_property(struct drm_connector *connector);
 void intel_attach_colorspace_property(struct drm_connector *connector);
+void intel_attach_privacy_screen_property(struct drm_connector *connector)=
;
=20
 #endif /* __INTEL_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/g=
pu/drm/i915/display/intel_display_types.h
index c2706afc069b..83b8c98049a7 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -426,6 +426,9 @@ struct intel_connector {
 	struct work_struct modeset_retry_work;
=20
 	struct intel_hdcp hdcp;
+
+	/* Optional "privacy-screen" property for the connector panel */
+	struct drm_property *privacy_screen_property;
 };
=20
 struct intel_digital_connector_state {
@@ -433,6 +436,7 @@ struct intel_digital_connector_state {
=20
 	enum hdmi_force_audio force_audio;
 	int broadcast_rgb;
+	enum intel_privacy_screen_status privacy_screen_status;
 };
=20
 #define to_intel_digital_connector_state(x) container_of(x, struct intel_d=
igital_connector_state, base)
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915=
/display/intel_dp.c
index 4fac408a4299..1963e92404ba 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -62,6 +62,7 @@
 #include "intel_lspcon.h"
 #include "intel_lvds.h"
 #include "intel_panel.h"
+#include "intel_privacy_screen.h"
 #include "intel_psr.h"
 #include "intel_sideband.h"
 #include "intel_tc.h"
@@ -6358,6 +6359,10 @@ intel_dp_add_properties(struct intel_dp *intel_dp, s=
truct drm_connector *connect
=20
 		/* Lookup the ACPI node corresponding to the connector */
 		intel_connector_lookup_acpi_node(intel_connector);
+
+		/* Check for integrated Privacy screen support */
+		if (intel_privacy_screen_present(intel_connector))
+			intel_attach_privacy_screen_property(connector);
 	}
 }
=20
diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.c b/drivers/=
gpu/drm/i915/display/intel_privacy_screen.c
new file mode 100644
index 000000000000..4c422e38c51a
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Intel ACPI privacy screen code
+ *
+ * Copyright =C2=A9 2019 Google Inc.
+ */
+
+#include <linux/acpi.h>
+
+#include "intel_privacy_screen.h"
+
+#define CONNECTOR_DSM_REVID 1
+
+#define CONNECTOR_DSM_FN_PRIVACY_ENABLE		2
+#define CONNECTOR_DSM_FN_PRIVACY_DISABLE		3
+
+static const guid_t drm_conn_dsm_guid =3D
+	GUID_INIT(0xC7033113, 0x8720, 0x4CEB,
+		  0x90, 0x90, 0x9D, 0x52, 0xB3, 0xE5, 0x2D, 0x73);
+
+/* Makes _DSM call to set privacy screen status */
+static void acpi_privacy_screen_call_dsm(acpi_handle conn_handle, u64 func=
)
+{
+	union acpi_object *obj;
+
+	obj =3D acpi_evaluate_dsm(conn_handle, &drm_conn_dsm_guid,
+				CONNECTOR_DSM_REVID, func, NULL);
+	if (!obj) {
+		DRM_DEBUG_DRIVER("failed to evaluate _DSM for fn %llx\n", func);
+		return;
+	}
+
+	ACPI_FREE(obj);
+}
+
+void intel_privacy_screen_set_val(struct intel_connector *intel_connector,
+				  enum intel_privacy_screen_status val)
+{
+	acpi_handle acpi_handle =3D intel_connector->acpi_handle;
+
+	if (!acpi_handle)
+		return;
+
+	if (val =3D=3D PRIVACY_SCREEN_DISABLED)
+		acpi_privacy_screen_call_dsm(acpi_handle,
+					     CONNECTOR_DSM_FN_PRIVACY_DISABLE);
+	else if (val =3D=3D PRIVACY_SCREEN_ENABLED)
+		acpi_privacy_screen_call_dsm(acpi_handle,
+					     CONNECTOR_DSM_FN_PRIVACY_ENABLE);
+}
+
+bool intel_privacy_screen_present(struct intel_connector *intel_connector)
+{
+	acpi_handle handle =3D intel_connector->acpi_handle;
+
+	if (!handle)
+		return false;
+
+	if (!acpi_check_dsm(handle, &drm_conn_dsm_guid,
+			    CONNECTOR_DSM_REVID,
+			    1 << CONNECTOR_DSM_FN_PRIVACY_ENABLE |
+			    1 << CONNECTOR_DSM_FN_PRIVACY_DISABLE)) {
+		DRM_WARN("%s: Odd, connector ACPI node but no privacy scrn?\n",
+			 dev_name(intel_connector->base.dev->dev));
+		return false;
+	}
+	DRM_DEV_INFO(intel_connector->base.dev->dev,
+		     "supports privacy screen\n");
+	return true;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_privacy_screen.h b/drivers/=
gpu/drm/i915/display/intel_privacy_screen.h
new file mode 100644
index 000000000000..212f73349a00
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_privacy_screen.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright =C2=A9 2019 Google Inc.
+ */
+
+#ifndef __DRM_PRIVACY_SCREEN_H__
+#define __DRM_PRIVACY_SCREEN_H__
+
+#include "intel_display_types.h"
+
+#ifdef CONFIG_ACPI
+bool intel_privacy_screen_present(struct intel_connector *intel_connector)=
;
+void intel_privacy_screen_set_val(struct intel_connector *intel_connector,
+				  enum intel_privacy_screen_status val);
+#else
+bool intel_privacy_screen_present(struct intel_connector *intel_connector)=
;
+{
+	return false;
+}
+void intel_privacy_screen_set_val(struct intel_connector *intel_connector,
+				  enum intel_privacy_screen_status val)
+{ }
+#endif /* CONFIG_ACPI */
+
+#endif /* __DRM_PRIVACY_SCREEN_H__ */
diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
index 469dc512cca3..cf08d5636363 100644
--- a/include/uapi/drm/i915_drm.h
+++ b/include/uapi/drm/i915_drm.h
@@ -2123,6 +2123,20 @@ struct drm_i915_query_engine_info {
 	struct drm_i915_engine_info engines[];
 };
=20
+/**
+ * enum intel_privacy_screen_status - privacy_screen status
+ *
+ * This enum is used to track and control the state of the integrated priv=
acy
+ * screen present on some display panels, via the "privacy-screen" propert=
y.
+ *
+ * @PRIVACY_SCREEN_DISABLED: The privacy-screen on the panel is disabled
+ * @PRIVACY_SCREEN_ENABLED:  The privacy-screen on the panel is enabled
+ **/
+enum intel_privacy_screen_status {
+	PRIVACY_SCREEN_DISABLED =3D 0,
+	PRIVACY_SCREEN_ENABLED =3D 1,
+};
+
 #if defined(__cplusplus)
 }
 #endif
--=20
2.24.0.rc1.363.gb1bccd3e3d-goog

