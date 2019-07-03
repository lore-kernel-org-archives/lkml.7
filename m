Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA1BC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E27921852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AvAPogXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfGCXCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:02:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34037 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCXCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:02:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so1987214pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aN1fc/2k+rfSW/EC4oQs93BniUXT0kzrcpLPTc60YrA=;
        b=AvAPogXeMhAMyX6Qn73Z4Mb7gUtQ6GdM3hW2lA0fqx3qKFbiNPs0oqDDEcOvWLEgX4
         aStyjhVWEcNNkVbiS4n/Ij8W4hS+WWcIhDQKoq/CfAIywTOhiYopNzj8Mcfy6hwnvEd0
         tbxJjj4OUCR1uSSEZ8ews+4V3aSvZvUuGIHOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aN1fc/2k+rfSW/EC4oQs93BniUXT0kzrcpLPTc60YrA=;
        b=iac9q6CB7TAEHPDXL5vz5c02dF+OEIAwmWgEJeFYBMZxqe/R9fHCaJZYVaQImqb0+w
         dQHSPLcxu0o2gEnJ/Qk2T2bKk+Sl1ZZ4cxFJgpW3ML5HJ5uYuUgONZVGl0iw9Ub67sXC
         w7rRayYQbGCvNVu71GWLSlhyWZcdP2iaue+ijfdue8ewwYei7aixaoX2UK/o6T0nOZaE
         R1RxFseK/WaWCvA+f2XQWambyNe8vp+PAid50ywMsvlBxn8zyqEL1GAC+TiUMAuPBaOr
         BbTcM0rlabU/7vt3A9GcR89V0/D7pp8715+c25IgcFO3A4kF0umSsS6wLjVQz+ki9Q8s
         XOdg==
X-Gm-Message-State: APjAAAXcVeh9r+gUTS8lZNtuF8rr0DVrl1lqgKnTK4O12NWizV3AQESX
        EGvEtO+tqGUQ+tOWUWfRYw1uZv89UD4=
X-Google-Smtp-Source: APXvYqwGEvAR6zi5SrOPI4u7LIZvp0MZxpg+7T/OEbRruM5ijz441RyoI54cDcWadbGHrUXH5auLEw==
X-Received: by 2002:a63:34c3:: with SMTP id b186mr39455164pga.294.1562194936143;
        Wed, 03 Jul 2019 16:02:16 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t8sm4245171pfq.31.2019.07.03.16.02.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 16:02:15 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v5 1/4] drm/panel: Add helper for reading DT rotation
Date:   Wed,  3 Jul 2019 16:02:07 -0700
Message-Id: <20190703230210.85342-2-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190703230210.85342-1-dbasehore@chromium.org>
References: <20190703230210.85342-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a helper function for reading the rotation (panel
orientation) from the device tree.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/gpu/drm/drm_panel.c | 43 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_panel.h     |  7 ++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index dbd5b873e8f2..169bab54d52d 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -172,6 +172,49 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 EXPORT_SYMBOL(of_drm_find_panel);
+
+/**
+ * of_drm_get_panel_orientation - look up the orientation of the panel through
+ * the "rotation" binding from a device tree node
+ * @np: device tree node of the panel
+ * @orientation: orientation enum to be filled in
+ *
+ * Looks up the rotation of a panel in the device tree. The orientation of the
+ * panel is expressed as a property name "rotation" in the device tree. The
+ * rotation in the device tree is counter clockwise.
+ *
+ * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
+ * rotation property doesn't exist. -EERROR otherwise.
+ */
+int of_drm_get_panel_orientation(const struct device_node *np,
+				 enum drm_panel_orientation *orientation)
+{
+	int rotation, ret;
+
+	ret = of_property_read_u32(np, "rotation", &rotation);
+	if (ret == -EINVAL) {
+		/* Don't return an error if there's no rotation property. */
+		*orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+		return 0;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	if (rotation == 0)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+	else if (rotation == 90)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+	else if (rotation == 180)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+	else if (rotation == 270)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(of_drm_get_panel_orientation);
 #endif
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 8c738c0e6e9f..3564952f1a4f 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -197,11 +197,18 @@ int drm_panel_detach(struct drm_panel *panel);
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
+int of_drm_get_panel_orientation(const struct device_node *np,
+				 enum drm_panel_orientation *orientation);
 #else
 static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
 }
+int of_drm_get_panel_orientation(const struct device_node *np,
+				 enum drm_panel_orientation *orientation)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif
-- 
2.22.0.410.gd8fdbe21b5-goog

