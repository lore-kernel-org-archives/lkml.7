Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60084C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282FE218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EcOJWfaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfGCXCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:02:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35676 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGCXCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:02:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so1946052pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 16:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9zUB08xFvBxYu2RwuQgWZYO7269mKq4j/1Liwi0s7g=;
        b=EcOJWfaWPBl5iU7aepT+yYAsjTHNMWBKdA3MesZogv7wsYDwY8U4Tf0Uu23WK4Lqfj
         WKELViP7kELhAW6xmCvjV3Ekj/o/nLD+xEnBxekWjRQyoKXx8LY1c0uRF86jb06syE5L
         LDlhc2OjNnMV2xd+Z6k43KAaPx76sppQh04V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9zUB08xFvBxYu2RwuQgWZYO7269mKq4j/1Liwi0s7g=;
        b=PHs0EXyuyrSCIs9oXwizsqkFfGPotOn/yv4AxxrGNPTiDYKoBXwdrBHdscsnIuwNZ9
         fgC0EPeg/O1QkLiAy4Wb+hK+qKAlBl94LE7uxPdFBTtsh2YBXnQoSOdgtmloFQs+lEag
         4urO1HoaUOXbdSipTjquSC8BPJV1ZByf90LxP/3JFSiJH8RWST8MEimH4Oz3vShjz5hB
         LBahu1mIRw6shkL4fAjQOEfLYL4lzTJCPrJJ+oX/ee1fNe8SzdUiwvXKPYfyrKb7AYjM
         MI9sz5eB+ch+hhv4fvg8as6MC/jE7F+f1dJ1kwcaRk1vRHwzKfcrZw1cj571VUM9FCVv
         u+nQ==
X-Gm-Message-State: APjAAAVL6Ha6BpBQMr92+fKEPWbtLnS93IqN11GdFuKSIcboSlcCLU1q
        48sUCM0KELSuA3FrNHIRBYtB9D+aK28=
X-Google-Smtp-Source: APXvYqzH+99dike0uKpjK42o7QgHOWON3ga+dxJxgB4yOmqfMTE+Cbm40RG4x++v1fvJ9Xi/qLJVWA==
X-Received: by 2002:a17:90a:2023:: with SMTP id n32mr14939380pjc.3.1562194937600;
        Wed, 03 Jul 2019 16:02:17 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t8sm4245171pfq.31.2019.07.03.16.02.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 16:02:17 -0700 (PDT)
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
Subject: [PATCH v5 2/4] drm/panel: set display info in panel attach
Date:   Wed,  3 Jul 2019 16:02:08 -0700
Message-Id: <20190703230210.85342-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190703230210.85342-1-dbasehore@chromium.org>
References: <20190703230210.85342-1-dbasehore@chromium.org>
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
index 169bab54d52d..ca01095470a9 100644
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

