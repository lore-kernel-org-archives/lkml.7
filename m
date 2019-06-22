Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243DC48BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 03:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A9D2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 03:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nGznlI0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfFVDlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 23:41:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39074 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFVDlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 23:41:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so4530236pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 20:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFX9zU9cvHHYWyBJrumOSQOw8f8w9KPwvR2c+phKtRQ=;
        b=nGznlI0F66L8RL06I6cenPynTwrwFqOG2ddbEAXYoV9pMLE/pKzGj4kkCDvFyLCxFZ
         hlYhUadnJqRHVyTTIWYjzsxmoYVDQamNaw4IpvOA+lTOnxlDisXodVaAVfNNvGzcoz8C
         u0XZFnPhkSXHGvNgx60MUMWaQjFqC2lutIHEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFX9zU9cvHHYWyBJrumOSQOw8f8w9KPwvR2c+phKtRQ=;
        b=IAJXAZmeB9HJYn1icGJ5UCIKfhGqe6jlVKFrSxPqdxq5wl4fycfbFRiEYzeOCk7eKF
         MJ4GYlOVZxnplRTE37NH+5jBugUonn0ftvF7kcQHrGquhCBQ39uWpy6MIeQcYgGDeeEw
         CsTXtkbl10G82kkOPMJ/ilshfGC9LtNRVFSWu13yYdKTua0s4ylgS8FgB82hFa/Zizm6
         3KQ7gBdcKE6wZQj9eL0wOnc6FA6qNuoYo3F2Y8ZGPQJhiXovGpr/YZ4y6kDkfLmz7b2B
         8/Iv3e1912OGtTEbLe6UsSYKtD98mIl0B/oS134EVXmfLDZJkbNqcRnyMyZJjITK0DFQ
         epRg==
X-Gm-Message-State: APjAAAXE48ZZvyT5ps4qKOB2ErxaFhzP10OIMTV1zU4ef8M0xV0kgETD
        YNiimPtW9hPeKpXrCSKe0faHxoqzBuQ=
X-Google-Smtp-Source: APXvYqwSDNQzNs53Gsghnfp1ASH53KKgDd72JJ5prFnEOErODUIjlPIU2WbLczECLr/v+Jj8FXjE0g==
X-Received: by 2002:a65:620a:: with SMTP id d10mr21751149pgv.42.1561174873308;
        Fri, 21 Jun 2019 20:41:13 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id u128sm4756688pfu.26.2019.06.21.20.41.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 20:41:12 -0700 (PDT)
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
Subject: [PATCH v3 2/4] drm/panel: set display info in panel attach
Date:   Fri, 21 Jun 2019 20:41:03 -0700
Message-Id: <20190622034105.188454-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190622034105.188454-1-dbasehore@chromium.org>
References: <20190622034105.188454-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree systems can set panel orientation via a panel binding, but
there's no way, as is, to propagate this setting to the connector,
where the property need to be added.
To address this, this patch sets orientation, as well as other fixed
values for the panel, in the drm_panel_attach function. These values
are stored from probe in the drm_panel struct.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/gpu/drm/drm_panel.c | 28 ++++++++++++++++++++++++++++
 include/drm/drm_panel.h     | 14 ++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 507099af4b57..5690fca30236 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -104,11 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
  */
 int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
 {
+	struct drm_display_info *info;
+
 	if (panel->connector)
 		return -EBUSY;
 
 	panel->connector = connector;
 	panel->drm = connector->dev;
+	info = &connector->display_info;
+	info->width_mm = panel->width_mm;
+	info->height_mm = panel->height_mm;
+	info->bpc = panel->bpc;
+	info->panel_orientation = panel->orientation;
+	info->bus_flags = panel->bus_flags;
+	if (panel->bus_formats)
+		drm_display_info_set_bus_formats(&connector->display_info,
+						 panel->bus_formats,
+						 panel->num_bus_formats);
 
 	return 0;
 }
@@ -128,6 +140,22 @@ EXPORT_SYMBOL(drm_panel_attach);
  */
 int drm_panel_detach(struct drm_panel *panel)
 {
+	struct drm_display_info *info;
+
+	if (!panel->connector)
+		goto out;
+
+	info = &panel->connector->display_info;
+	info->width_mm = 0;
+	info->height_mm = 0;
+	info->bpc = 0;
+	info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+	info->bus_flags = 0;
+	kfree(info->bus_formats);
+	info->bus_formats = NULL;
+	info->num_bus_formats = 0;
+
+out:
 	panel->connector = NULL;
 	panel->drm = NULL;
 
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 3564952f1a4f..760ca5865962 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -37,6 +37,8 @@ struct display_timing;
  * struct drm_panel_funcs - perform operations on a given panel
  * @disable: disable panel (turn off back light, etc.)
  * @unprepare: turn off panel
+ * @detach: detach panel->connector (clear internal state, etc.)
+ * @attach: attach panel->connector (update internal state, etc.)
  * @prepare: turn on panel and perform set up
  * @enable: enable panel (turn on back light, etc.)
  * @get_modes: add modes to the connector that the panel is attached to and
@@ -93,6 +95,18 @@ struct drm_panel {
 
 	const struct drm_panel_funcs *funcs;
 
+	/*
+	 * panel information to be set in the connector when the panel is
+	 * attached.
+	 */
+	unsigned int width_mm;
+	unsigned int height_mm;
+	unsigned int bpc;
+	int orientation;
+	const u32 *bus_formats;
+	unsigned int num_bus_formats;
+	u32 bus_flags;
+
 	struct list_head list;
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

