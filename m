Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7464C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A892146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNt7r1l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfLQUIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:08:38 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56231 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfLQUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:08:38 -0500
Received: by mail-pg1-f201.google.com with SMTP id v30so7982917pga.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Qw4GD/L/BHUnMfNxnXbv2iuA578RGnnJhQc59pGIoc=;
        b=sNt7r1l54qCXMwcU/JndJHedUHyn/DbHJ4OiXxqK//EZcA+w2Uow0BPlrICVDVsY0A
         wtweXoHeXsAAhIvbTIP29lhcyqeVUbfgkJkASX+XqhvnMCZFUBv7/C68uXyCtV/F+Mbn
         v+uBjug5qpANmU+3g2eyH425b8EU2rvLFiUmkLb1kFtDA5iS3yxcO4qtn9HTYeG/O3bN
         BZj8GAzrtLfafLuFC3DvyVDi+x+bRUpRvAiXZOdKmWN846JLu0g6HxwQuzAgOlVsMHuh
         dS2tb0/ULilEsMttVeJv/CMipZwA08fZlngrl1Em5FMl0ysDS7x5raqFm5nbQk79CCfe
         3OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Qw4GD/L/BHUnMfNxnXbv2iuA578RGnnJhQc59pGIoc=;
        b=oNmFtq5JETbTxtqcS67sAJ8762ov8B60iQbXSGQgIi/gff9Mq+VfuC6nPgfY0hlOqv
         36Z+kA3zlxDNYwkNnUB+OZk4MKdwto3Fb27f6ys/ctuoDudTjKQngM0Y960sDJeYaaTE
         maxqqL9gnPbmovm3p35JoGDH5xwpfe+lpPQz81NmXHqzAd88Ro7OCjn4ch0FmVggA/CS
         Q72Njc8nNu6TGJIKugiDRk9N/7FFEzmuPHU/t3t6MB22OhK/vnMRbga9SDnWmUDX8Lnh
         bsbrela5Bb9uAX3KeX9sENsTcvoJe3X/3nt8syJqvbcK9pyU92ujfWTAGvkOYKM6aksk
         mMhQ==
X-Gm-Message-State: APjAAAWrdX53ASjJNynEDMa6z5X/QQ+mObFAQoQ1fyfB4nQ2uNPdZYXm
        ejLxnAewiiaCaduQYSndO18DU1VUSDaV
X-Google-Smtp-Source: APXvYqwjvZMH70noVOzNSK6DTz7LvPJVJ2Thym9CDAU+9EfavMdifR8PT/wOePLfhotp0U5XGFp1fNeF15In
X-Received: by 2002:a63:bc01:: with SMTP id q1mr28463259pge.442.1576613316975;
 Tue, 17 Dec 2019 12:08:36 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:08:28 -0800
In-Reply-To: <20191217200829.120993-1-rajatja@google.com>
Message-Id: <20191217200829.120993-2-rajatja@google.com>
Mime-Version: 1.0
References: <20191217200829.120993-1-rajatja@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 2/3] drm/i915: Lookup and attach ACPI device node for connectors
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
---
v4: Same as v3
v3: fold the code into existing acpi_device_id_update() function
v2: formed by splitting the original patch into ACPI lookup, and privacy
    screen property. Also move it into i915 now that I found existing code
    in i915 that can be re-used.

 drivers/gpu/drm/i915/display/intel_acpi.c     | 24 +++++++++++++++++++
 .../drm/i915/display/intel_display_types.h    |  3 +++
 drivers/gpu/drm/i915/display/intel_dp.c       |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
index e21fb14d5e07..101a56c08996 100644
--- a/drivers/gpu/drm/i915/display/intel_acpi.c
+++ b/drivers/gpu/drm/i915/display/intel_acpi.c
@@ -222,11 +222,23 @@ static u32 acpi_display_type(struct intel_connector *connector)
 	return display_type;
 }
 
+/*
+ * Ref: ACPI Spec 6.3
+ * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
+ * Pages 1119 - 1123 describe, what I believe, a standard way of
+ * identifying / addressing "display panels" in the ACPI. It provides
+ * a way for the ACPI to define devices for the display panels attached
+ * to the system. It thus provides a way for the BIOS to export any panel
+ * specific properties to the system via ACPI (like device trees).
+ */
 void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
 {
 	struct drm_device *drm_dev = &dev_priv->drm;
 	struct intel_connector *connector;
 	struct drm_connector_list_iter conn_iter;
+	struct device *dev = &drm_dev->pdev->dev;
+	struct acpi_device *conn_dev;
+	u64 conn_addr;
 	u8 display_index[16] = {};
 
 	/* Populate the ACPI IDs for all connectors for a given drm_device */
@@ -242,6 +254,18 @@ void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
 		device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
 
 		connector->acpi_device_id = device_id;
+
+		/* Build the _ADR to look for */
+		conn_addr = device_id | ACPI_DEVICE_ID_SCHEME |
+				ACPI_BIOS_CAN_DETECT;
+
+		DRM_DEV_INFO(dev, "Checking connector ACPI node at _ADR=%llX\n",
+			     conn_addr);
+
+		/* Look up the connector device, under the PCI device */
+		conn_dev = acpi_find_child_device(ACPI_COMPANION(dev),
+						  conn_addr, false);
+		connector->acpi_handle = conn_dev ? conn_dev->handle : NULL;
 	}
 	drm_connector_list_iter_end(&conn_iter);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 1a7334dbe802..0a4a04116091 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -407,6 +407,9 @@ struct intel_connector {
 	/* ACPI device id for ACPI and driver cooperation */
 	u32 acpi_device_id;
 
+	/* ACPI handle corresponding to this connector display, if found */
+	void *acpi_handle;
+
 	/* Reads out the current hw, returning true if the connector is enabled
 	 * and active (i.e. dpms ON state). */
 	bool (*get_hw_state)(struct intel_connector *);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index b05b2191b919..93cece8e2516 100644
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
@@ -6623,6 +6624,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 
 		connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
 
+		/* Lookup the ACPI node corresponding to the connector */
+		intel_acpi_device_id_update(dev_priv);
 	}
 }
 
-- 
2.24.1.735.g03f4e72817-goog

