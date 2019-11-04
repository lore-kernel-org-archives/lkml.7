Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED980CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1774206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5uKi/m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfKDTlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:41:55 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44711 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfKDTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:41:55 -0500
Received: by mail-pg1-f202.google.com with SMTP id k23so13354435pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3VArYdzuhYZ5F7lzuhgwCdAuyaphVwUyvDoIU6FlqsQ=;
        b=T5uKi/m7kOXDbQheqvsINWaygZIAlT7klsFKc8D9sd2E5YTaoR+mABMHRMkacGBYQk
         TEeJ3xc2lNA7+zQEWB2APhBk67PDsVThT/qB5bti/4GmYGPYBlYQgQ/YgSXT7FGeJ6jT
         zCIABfGkVqhvJXDyO9dHfXcqQj5qMqYgGshJ3CWrdRfFaRNrWgSwBaut6SaVN8hubDUC
         6DQzIiA5sBYokHALDfa7gOnf+8hxTpdT1pqiueGDmIp5rA1AS5VB5k00iSFnsfFCE8gX
         MoKY+znZF0NNfaAqA2D9JReZ/spsiGyR0hBuXAPTegztfQT6fUAjlvfQf4E9ORdtoN8y
         rzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3VArYdzuhYZ5F7lzuhgwCdAuyaphVwUyvDoIU6FlqsQ=;
        b=JrdtdnkhiSvwIPyHTJi7VVlUU28oRtEZwaUz4b8f9s0XyErXYol6oeRM6fngd0njkG
         Hq2OnowHl24tWNB3lca5Vgyt3g2K4wQ9Z0D0zgVYzpriYj1REvejF4+sb+Vzcxd89ham
         Fh6gkcD1Rk1UnjuJSsJ5TGCpe3y9AeLkyyFyvgWYm8aNB0g5PZzDq9OBHTeF9/hceq+r
         V2ba85lrdD9qLsmhW83JFADsQxfFR6CLlT+1Fc12RT+qm8flZk/9RYVsWSHsZ0Ob0dj2
         U4KTES6AIxmUBymrNiWm9ghr6RR0Ai+JVVexSoCHmxZBC+ZmQa01+XKTKaf5JOPkZCE9
         zJ5A==
X-Gm-Message-State: APjAAAWOOCA9Nut4uI/F9mfGZdFB7ixPLejs5eyY7FJxCVCtJHBASg4C
        1cGbulfWpO3S0qClDFUboLWcyl1gkv3r
X-Google-Smtp-Source: APXvYqzgyJKX/aMK/PCesa/JZEFUnHC+1EnTiVopo5JDa033eb7ODBNtkyHZnqytRQQWMtuqBDosgK+6/LRl
X-Received: by 2002:a63:1c10:: with SMTP id c16mr30979864pgc.183.1572896512467;
 Mon, 04 Nov 2019 11:41:52 -0800 (PST)
Date:   Mon,  4 Nov 2019 11:41:45 -0800
In-Reply-To: <20191023001206.15741-1-rajatja@google.com>
Message-Id: <20191104194147.185642-1-rajatja@google.com>
Mime-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v2 1/3] drm/i915: Move the code to populate ACPI device ID
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
Change-Id: Ifb3bd458734985c2a78ba682e6f0a2e63e0626ca
---
v2: v1 doesn't exist. Found existing code in i915 driver to assign the ACPI ID
    which is what I plan to re-use.
    

 drivers/gpu/drm/i915/display/intel_acpi.c     | 87 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_acpi.h     |  6 ++
 drivers/gpu/drm/i915/display/intel_opregion.c | 80 +----------------
 3 files changed, 97 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index 3456d33feb46..748d9b3125dd 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -156,3 +156,90 @@ void intel_register_dsm_handler(void)
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
+void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev)
+{
+	struct intel_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	u8 display_index[16] = {};
+	u32 device_id, type;
+
+	/* Populate the ACPI IDs for all connectors for a given drm_device */
+	drm_connector_list_iter_begin(drm_dev, &conn_iter);
+	for_each_intel_connector_iter(connector, &conn_iter) {
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
index 1c576b3fb712..8f6d850df6fa 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.h
+++ b/drivers/gpu/drm/i915/display/intel_acpi.h
@@ -6,12 +6,18 @@
 #ifndef __INTEL_ACPI_H__
 #define __INTEL_ACPI_H__
 
+#include "intel_display_types.h"
+
 #ifdef CONFIG_ACPI
 void intel_register_dsm_handler(void);
 void intel_unregister_dsm_handler(void);
+void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev);
 #else
 static inline void intel_register_dsm_handler(void) { return; }
 static inline void intel_unregister_dsm_handler(void) { return; }
+static inline void
+static inline void
+intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev) { }
 #endif /* CONFIG_ACPI */
 
 #endif /* __INTEL_ACPI_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_opregion.c b/drivers/gpu/drm/i915/display/intel_opregion.c
index 969ade623691..f5976a6ab3c4 100644
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
 
+	intel_populate_acpi_ids_for_all_connectors(&dev_priv->drm);
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
2.24.0.rc1.363.gb1bccd3e3d-goog

