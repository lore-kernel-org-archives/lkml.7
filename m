Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF3CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7A02084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsgJREjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfKDTl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:41:58 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:44458 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfKDTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:41:56 -0500
Received: by mail-vk1-f201.google.com with SMTP id m205so8305613vke.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hw2kwOv7aHvONVhhCWMO8y6YePHkYT17+TPLWVMLRSU=;
        b=RsgJREjB0mlFsau8SHnepZumZUcVdUKubJ1bNzsWBi+9P2bPsQpu3xr7xsCEvCoqRQ
         36Q65eYrYtvRFamazrB6URSmqgrn+LooJpHOXrYLGxQ1m9gl2oqkbtITwPAchypEDGSD
         RGDMaxeKlpiNfsjI7VLXJTn426oaMj7lP+7/TdyWPC3jmd6WHydcWRn3mrNuiiIdyqTV
         hjPMI3VdfrI8VkoGlHs5AJB+BDUMQIV2lajUz1bQNyjEdA4TsT5cdmRm6YpDXO8T8q/n
         VT5ge8M6qgX7Rd78Hxo6y4AX7g2BIqIbX3xAGz8ixGOVlUBE5+4hAjHHZVQLC1mQlGlJ
         gg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hw2kwOv7aHvONVhhCWMO8y6YePHkYT17+TPLWVMLRSU=;
        b=sGg8gCgNZYiWzNYtM9pEt6dzrtpDawjHKjs12Fg7bT7o/VXDvwE1VK83pmv6DFf9Tm
         hrf4U2QppHxphLeCoIUVprVFFHItwlCDb2tKqGpfHVd65SlKaeoQmEPq7yicu+nEskYS
         T1p3FeWp12MmvMU7DCXpuGVH1aw9xT3YeI1dBXBmA3pu+S7dovdxJed/jI6x11dHJU5c
         1nxZCu3WVrb7h3uQE8o0EU06EZQs1C3g4Pn6AtP6cvdh48Y5lXEUeoOocvc7Z+qXuN72
         aHWn7JvAku6g4H5yGuxkNGAGQg/oqD+NpCh7blwF9taRaetUqhHgxac6Q/o9F6fTJMzA
         2wyQ==
X-Gm-Message-State: APjAAAXZeKBfrOdrirFdTtStOG9//nyRsfxQNY/ciftUyvc3UC+xvDX4
        NkAhAZ3u8lN9fmeZwIIKT+Z4f/Jua+HG
X-Google-Smtp-Source: APXvYqwb6j34OVjZAiDyjhBEmZpq85fuYsMFGZ6t/xrnw1a7t9N7/et8lPSVl8i0rq89wRb09CV6muZzyUlz
X-Received: by 2002:a1f:accb:: with SMTP id v194mr12398929vke.24.1572896515242;
 Mon, 04 Nov 2019 11:41:55 -0800 (PST)
Date:   Mon,  4 Nov 2019 11:41:46 -0800
In-Reply-To: <20191104194147.185642-1-rajatja@google.com>
Message-Id: <20191104194147.185642-2-rajatja@google.com>
Mime-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191104194147.185642-1-rajatja@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v2 2/3] drm/i915: Lookup and attach ACPI device node for connectors
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

Lookup and attach ACPI nodes for intel connectors. The lookup is done
in compliance with ACPI Spec 6.3
https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
(Ref: Pages 1119 - 1123).

This can be useful for any connector specific platform properties. (This
will be used for privacy screen in next patch).

Signed-off-by: Rajat Jain <rajatja@google.com>
Change-Id: I798e70714a4402554c8cd2a8e58268353f75814f
---
v2: formed by splitting the original patch into ACPI lookup, and privacy
    screen property. Also move it into i915 now that I found existing code
    in i915 that can be re-used.

 drivers/gpu/drm/i915/display/intel_acpi.c     | 50 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_acpi.h     |  4 +-
 .../drm/i915/display/intel_display_types.h    |  3 ++
 drivers/gpu/drm/i915/display/intel_dp.c       |  4 ++
 4 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index 748d9b3125dd..0c10516430b1 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -243,3 +243,53 @@ void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
+
+/*
+ * Ref: ACPI Spec 6.3
+ * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
+ * Pages 1119 - 1123 describe, what I believe, a standard way of
+ * identifying / addressing "display panels" in the ACPI. It provides
+ * a way for the ACPI to define devices for the display panels attached
+ * to the system. It thus provides a way for the BIOS to export any panel
+ * specific properties to the system via ACPI (like device trees).
+ *
+ * The following functions looks up the ACPI node for a connector and returns
+ * it. Technically it is independent from the i915 code, and
+ * ideally may be called for all connectors. It is generally a good idea to
+ * be able to attach an ACPI node to describe anything if needed. (This can
+ * help in future for other panel specific features maybe). However, it
+ * needs an acpi device ID which is build using an index within a particular
+ * type of port (Ref to the pages of spec mentioned above, and to code in
+ * intel_populate_acpi_ids_for_all_connectors()). This device index
+ * unfortunately is not available in DRM code, so currently its call is
+ * originated from i915 driver. If in future this is useful for other drivers
+ * and we can find a generic way of getting a device index, we should move this
+ * function to drm code, maybe.
+ */
+void intel_connector_lookup_acpi_node(struct intel_connector *intel_connector)
+{
+	struct drm_device *drm_dev = intel_connector->base.dev;
+	struct device *dev = &drm_dev->pdev->dev;
+	struct acpi_device *conn_dev;
+	u64 conn_addr;
+
+	/*
+	 * Repopulate ACPI IDs for all connectors is needed because the display
+	 * index may have changed as a result of hotplugging and unplugging
+	 * connectors
+	 */
+	intel_populate_acpi_ids_for_all_connectors(drm_dev);
+
+	/* Build the _ADR to look for */
+	conn_addr = intel_connector->acpi_device_id;
+	conn_addr |= ACPI_DEVICE_ID_SCHEME;
+	conn_addr |= ACPI_BIOS_CAN_DETECT;
+
+	DRM_DEV_INFO(dev, "Looking for connector ACPI node at _ADR=%llX\n",
+		     conn_addr);
+
+	/* Look up the connector device, under the PCI device */
+	conn_dev = acpi_find_child_device(ACPI_COMPANION(dev), conn_addr,
+					  false);
+	intel_connector->acpi_handle = conn_dev ? conn_dev->handle : NULL;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
index 8f6d850df6fa..61a4392fac4a 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.h
+++ b/drivers/gpu/drm/i915/display/intel_acpi.h
@@ -9,14 +9,16 @@
 #include "intel_display_types.h"
 
 #ifdef CONFIG_ACPI
+void intel_connector_lookup_acpi_node(struct intel_connector *connector);
 void intel_register_dsm_handler(void);
 void intel_unregister_dsm_handler(void);
 void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev);
 #else
+static inline void
+intel_connector_lookup_acpi_node(struct intel_connector *connector) { return; }
 static inline void intel_register_dsm_handler(void) { return; }
 static inline void intel_unregister_dsm_handler(void) { return; }
 static inline void
-static inline void
 intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev) { }
 #endif /* CONFIG_ACPI */
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 449abaea619f..c2706afc069b 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -400,6 +400,9 @@ struct intel_connector {
 	/* ACPI device id for ACPI and driver cooperation */
 	u32 acpi_device_id;
 
+	/* ACPI handle corresponding to this connector display, if found */
+	void *acpi_handle;
+
 	/* Reads out the current hw, returning true if the connector is enabled
 	 * and active (i.e. dpms ON state). */
 	bool (*get_hw_state)(struct intel_connector *);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index f865615172a5..4fac408a4299 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -45,6 +45,7 @@
 #include "i915_debugfs.h"
 #include "i915_drv.h"
 #include "i915_trace.h"
+#include "intel_acpi.h"
 #include "intel_atomic.h"
 #include "intel_audio.h"
 #include "intel_connector.h"
@@ -6333,6 +6334,7 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 	enum port port = dp_to_dig_port(intel_dp)->base.port;
+	struct intel_connector *intel_connector = to_intel_connector(connector);
 
 	if (!IS_G4X(dev_priv) && port != PORT_A)
 		intel_attach_force_audio_property(connector);
@@ -6354,6 +6356,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 
 		connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
 
+		/* Lookup the ACPI node corresponding to the connector */
+		intel_connector_lookup_acpi_node(intel_connector);
 	}
 }
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

