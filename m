Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE0C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B232072B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqNcRHsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfLTUEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:04:00 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33307 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLTUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:04:00 -0500
Received: by mail-pf1-f202.google.com with SMTP id c72so6831842pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LBwu1L9QNdiut5loMKNUxbXuFrZXOMmZL+RAL5PKFu0=;
        b=IqNcRHsNMHtKqj2xs/fuPcb/P7vePn/n4G8UbueW02XWggD6LGT63Hym5XKMz09/kF
         ZkWOygqMjmrQfVQ+JjnzN5K9dsTmwQM/aX3vzt38ESEt1b52YigPbQS4eaRGG3dTIXuE
         Tf6Xyz3/vuHVTXxHl7FTi+Ur0Mafl/x0U+U2HHKt0aO9QAvPRAyJibQEqmXihYJAJiq0
         ckkhKJT80NnOQOqTlZmO16tl6uAfVyNuLMSCUZwvHpZ+meyOxGSpFAPd53Wvt8YounWO
         LfEyfkQQzyPdB+uN5AJNeChwMVfymsZbe7h0G82cKPfqp+gsdN+78Xe+GdUhLJr9V0XD
         KtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LBwu1L9QNdiut5loMKNUxbXuFrZXOMmZL+RAL5PKFu0=;
        b=UvoCYjwRiMkgbiPuOCfb2XeR4gRiDcktIU4unZPV2bKpLlTNAKfCLX+LGvhPdgYasN
         Bkm5g18D/s0PHFlxSiA9i/tqCT/n4E2OiLo3i88mKUDesZUa8gPv+YzN7P8LX/G95d3/
         ZKM8Te+yC2D2nGO2Snum898+TMoqAh3jxmKslga8sGvRN/8NdJR+Jkv5oG7z4g2/f5To
         yJF23Xv2b+Jr/bQn0piODhKzzx93hkIGZpp6tQOB9+pjOF9kydoFqjGsxdJmerfp4lya
         4mkOy1iIRcrs3zIc9AhHRe1xs5ZIirNwxw4ITq0MfCfnKPONRd8pWCsgT56+d4fssEFO
         gHgw==
X-Gm-Message-State: APjAAAWg8WYwlg7wi3bXw4lYGydTz3eUjUaigBPOMYm9aUz5Es/RkEKO
        eCpLIfNSvL8TxLt5ZN6l1+87fyfRp473
X-Google-Smtp-Source: APXvYqwUZ29jT0Qo9U95Ey2ilVPP0LEbovlF56NRYldPThgrBzm6dKUKuwAQGXr3m/X/arERHk7zgcIJ5vgC
X-Received: by 2002:a65:538b:: with SMTP id x11mr16466478pgq.395.1576872238039;
 Fri, 20 Dec 2019 12:03:58 -0800 (PST)
Date:   Fri, 20 Dec 2019 12:03:51 -0800
Message-Id: <20191220200353.252399-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v5 1/3] drm/i915: Move the code to populate ACPI device ID
 into intel_acpi
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code that populates the ACPI device ID for devices, into
more appripriate intel_acpi.c. This is done in preparation for more
users of this code (in next patch).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v5: same as v4
v4: Same as v3
v3: * Renamed the function to intel_acpi_*
    * Used forward declaration for structure instead of header file inclusion.
    * Fix a typo
v2: v1 doesn't exist. Found existing code in i915 driver to assign the ACPI ID
    which is what I plan to re-use.

 drivers/gpu/drm/i915/display/intel_acpi.c     | 89 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_acpi.h     |  5 ++
 drivers/gpu/drm/i915/display/intel_opregion.c | 80 +----------------
 3 files changed, 98 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index 3456d33feb46..e21fb14d5e07 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -10,6 +10,7 @@
 
 #include "i915_drv.h"
 #include "intel_acpi.h"
+#include "intel_display_types.h"
 
 #define INTEL_DSM_REVISION_ID 1 /* For Calpella anyway... */
 #define INTEL_DSM_FN_PLATFORM_MUX_INFO 1 /* No args */
@@ -156,3 +157,91 @@ void intel_register_dsm_handler(void)
 void intel_unregister_dsm_handler(void)
 {
 }
+
+/*
+ * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
+ * Attached to the Display Adapter).
+ */
+#define ACPI_DISPLAY_INDEX_SHIFT		0
+#define ACPI_DISPLAY_INDEX_MASK			(0xf << 0)
+#define ACPI_DISPLAY_PORT_ATTACHMENT_SHIFT	4
+#define ACPI_DISPLAY_PORT_ATTACHMENT_MASK	(0xf << 4)
+#define ACPI_DISPLAY_TYPE_SHIFT			8
+#define ACPI_DISPLAY_TYPE_MASK			(0xf << 8)
+#define ACPI_DISPLAY_TYPE_OTHER			(0 << 8)
+#define ACPI_DISPLAY_TYPE_VGA			(1 << 8)
+#define ACPI_DISPLAY_TYPE_TV			(2 << 8)
+#define ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL	(3 << 8)
+#define ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL	(4 << 8)
+#define ACPI_VENDOR_SPECIFIC_SHIFT		12
+#define ACPI_VENDOR_SPECIFIC_MASK		(0xf << 12)
+#define ACPI_BIOS_CAN_DETECT			(1 << 16)
+#define ACPI_DEPENDS_ON_VGA			(1 << 17)
+#define ACPI_PIPE_ID_SHIFT			18
+#define ACPI_PIPE_ID_MASK			(7 << 18)
+#define ACPI_DEVICE_ID_SCHEME			(1ULL << 31)
+
+static u32 acpi_display_type(struct intel_connector *connector)
+{
+	u32 display_type;
+
+	switch (connector->base.connector_type) {
+	case DRM_MODE_CONNECTOR_VGA:
+	case DRM_MODE_CONNECTOR_DVIA:
+		display_type = ACPI_DISPLAY_TYPE_VGA;
+		break;
+	case DRM_MODE_CONNECTOR_Composite:
+	case DRM_MODE_CONNECTOR_SVIDEO:
+	case DRM_MODE_CONNECTOR_Component:
+	case DRM_MODE_CONNECTOR_9PinDIN:
+	case DRM_MODE_CONNECTOR_TV:
+		display_type = ACPI_DISPLAY_TYPE_TV;
+		break;
+	case DRM_MODE_CONNECTOR_DVII:
+	case DRM_MODE_CONNECTOR_DVID:
+	case DRM_MODE_CONNECTOR_DisplayPort:
+	case DRM_MODE_CONNECTOR_HDMIA:
+	case DRM_MODE_CONNECTOR_HDMIB:
+		display_type = ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL;
+		break;
+	case DRM_MODE_CONNECTOR_LVDS:
+	case DRM_MODE_CONNECTOR_eDP:
+	case DRM_MODE_CONNECTOR_DSI:
+		display_type = ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL;
+		break;
+	case DRM_MODE_CONNECTOR_Unknown:
+	case DRM_MODE_CONNECTOR_VIRTUAL:
+		display_type = ACPI_DISPLAY_TYPE_OTHER;
+		break;
+	default:
+		MISSING_CASE(connector->base.connector_type);
+		display_type = ACPI_DISPLAY_TYPE_OTHER;
+		break;
+	}
+
+	return display_type;
+}
+
+void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
+{
+	struct drm_device *drm_dev = &dev_priv->drm;
+	struct intel_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	u8 display_index[16] = {};
+
+	/* Populate the ACPI IDs for all connectors for a given drm_device */
+	drm_connector_list_iter_begin(drm_dev, &conn_iter);
+	for_each_intel_connector_iter(connector, &conn_iter) {
+		u32 device_id, type;
+
+		device_id = acpi_display_type(connector);
+
+		/* Use display type specific display index. */
+		type = (device_id & ACPI_DISPLAY_TYPE_MASK)
+			>> ACPI_DISPLAY_TYPE_SHIFT;
+		device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
+
+		connector->acpi_device_id = device_id;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
index 1c576b3fb712..e8b068661d22 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.h
+++ b/drivers/gpu/drm/i915/display/intel_acpi.h
@@ -6,12 +6,17 @@
 #ifndef __INTEL_ACPI_H__
 #define __INTEL_ACPI_H__
 
+struct drm_i915_private;
+
 #ifdef CONFIG_ACPI
 void intel_register_dsm_handler(void);
 void intel_unregister_dsm_handler(void);
+void intel_acpi_device_id_update(struct drm_i915_private *i915);
 #else
 static inline void intel_register_dsm_handler(void) { return; }
 static inline void intel_unregister_dsm_handler(void) { return; }
+static inline
+void intel_acpi_device_id_update(struct drm_i915_private *i915) { return; }
 #endif /* CONFIG_ACPI */
 
 #endif /* __INTEL_ACPI_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_opregion.c b/drivers/gpu/drm/i915/display/intel_opregion.c
index 969ade623691..6422384f199e 100644
--- a/drivers/gpu/drm/i915/display/intel_opregion.c
+++ b/drivers/gpu/drm/i915/display/intel_opregion.c
@@ -35,6 +35,7 @@
 #include "display/intel_panel.h"
 
 #include "i915_drv.h"
+#include "intel_acpi.h"
 #include "intel_display_types.h"
 #include "intel_opregion.h"
 
@@ -242,29 +243,6 @@ struct opregion_asle_ext {
 #define SWSCI_SBCB_POST_VBE_PM		SWSCI_FUNCTION_CODE(SWSCI_SBCB, 19)
 #define SWSCI_SBCB_ENABLE_DISABLE_AUDIO	SWSCI_FUNCTION_CODE(SWSCI_SBCB, 21)
 
-/*
- * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
- * Attached to the Display Adapter).
- */
-#define ACPI_DISPLAY_INDEX_SHIFT		0
-#define ACPI_DISPLAY_INDEX_MASK			(0xf << 0)
-#define ACPI_DISPLAY_PORT_ATTACHMENT_SHIFT	4
-#define ACPI_DISPLAY_PORT_ATTACHMENT_MASK	(0xf << 4)
-#define ACPI_DISPLAY_TYPE_SHIFT			8
-#define ACPI_DISPLAY_TYPE_MASK			(0xf << 8)
-#define ACPI_DISPLAY_TYPE_OTHER			(0 << 8)
-#define ACPI_DISPLAY_TYPE_VGA			(1 << 8)
-#define ACPI_DISPLAY_TYPE_TV			(2 << 8)
-#define ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL	(3 << 8)
-#define ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL	(4 << 8)
-#define ACPI_VENDOR_SPECIFIC_SHIFT		12
-#define ACPI_VENDOR_SPECIFIC_MASK		(0xf << 12)
-#define ACPI_BIOS_CAN_DETECT			(1 << 16)
-#define ACPI_DEPENDS_ON_VGA			(1 << 17)
-#define ACPI_PIPE_ID_SHIFT			18
-#define ACPI_PIPE_ID_MASK			(7 << 18)
-#define ACPI_DEVICE_ID_SCHEME			(1 << 31)
-
 #define MAX_DSLP	1500
 
 static int swsci(struct drm_i915_private *dev_priv,
@@ -662,54 +640,12 @@ static void set_did(struct intel_opregion *opregion, int i, u32 val)
 	}
 }
 
-static u32 acpi_display_type(struct intel_connector *connector)
-{
-	u32 display_type;
-
-	switch (connector->base.connector_type) {
-	case DRM_MODE_CONNECTOR_VGA:
-	case DRM_MODE_CONNECTOR_DVIA:
-		display_type = ACPI_DISPLAY_TYPE_VGA;
-		break;
-	case DRM_MODE_CONNECTOR_Composite:
-	case DRM_MODE_CONNECTOR_SVIDEO:
-	case DRM_MODE_CONNECTOR_Component:
-	case DRM_MODE_CONNECTOR_9PinDIN:
-	case DRM_MODE_CONNECTOR_TV:
-		display_type = ACPI_DISPLAY_TYPE_TV;
-		break;
-	case DRM_MODE_CONNECTOR_DVII:
-	case DRM_MODE_CONNECTOR_DVID:
-	case DRM_MODE_CONNECTOR_DisplayPort:
-	case DRM_MODE_CONNECTOR_HDMIA:
-	case DRM_MODE_CONNECTOR_HDMIB:
-		display_type = ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL;
-		break;
-	case DRM_MODE_CONNECTOR_LVDS:
-	case DRM_MODE_CONNECTOR_eDP:
-	case DRM_MODE_CONNECTOR_DSI:
-		display_type = ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL;
-		break;
-	case DRM_MODE_CONNECTOR_Unknown:
-	case DRM_MODE_CONNECTOR_VIRTUAL:
-		display_type = ACPI_DISPLAY_TYPE_OTHER;
-		break;
-	default:
-		MISSING_CASE(connector->base.connector_type);
-		display_type = ACPI_DISPLAY_TYPE_OTHER;
-		break;
-	}
-
-	return display_type;
-}
-
 static void intel_didl_outputs(struct drm_i915_private *dev_priv)
 {
 	struct intel_opregion *opregion = &dev_priv->opregion;
 	struct intel_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 	int i = 0, max_outputs;
-	int display_index[16] = {};
 
 	/*
 	 * In theory, did2, the extended didl, gets added at opregion version
@@ -721,20 +657,12 @@ static void intel_didl_outputs(struct drm_i915_private *dev_priv)
 	max_outputs = ARRAY_SIZE(opregion->acpi->didl) +
 		ARRAY_SIZE(opregion->acpi->did2);
 
+	intel_acpi_device_id_update(dev_priv);
+
 	drm_connector_list_iter_begin(&dev_priv->drm, &conn_iter);
 	for_each_intel_connector_iter(connector, &conn_iter) {
-		u32 device_id, type;
-
-		device_id = acpi_display_type(connector);
-
-		/* Use display type specific display index. */
-		type = (device_id & ACPI_DISPLAY_TYPE_MASK)
-			>> ACPI_DISPLAY_TYPE_SHIFT;
-		device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
-
-		connector->acpi_device_id = device_id;
 		if (i < max_outputs)
-			set_did(opregion, i, device_id);
+			set_did(opregion, i, connector->acpi_device_id);
 		i++;
 	}
 	drm_connector_list_iter_end(&conn_iter);
-- 
2.24.1.735.g03f4e72817-goog

