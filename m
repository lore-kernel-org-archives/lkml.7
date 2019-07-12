Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7829AC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9D720838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DB9nrgDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfGLQeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:34:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40149 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:34:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so4764962pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxxOs+WHCN8yYkzCsPdgx/BKilpEGbNbxFs4VxLjJ2g=;
        b=DB9nrgDcMI6Oxw7g0G5qgE+YfDLCtL5YMm1MsmimFl+ntc+vS7rbj6LPaNpSrC7Vpr
         z/s4BskP50NzM8fMIcx1kjb4elWF5laVPt8idXtYmoRiCF/NAF0ps6Yk077kQSY7KDXi
         O+DE5PpPU3o/dhoWtgz4BIeO0MBBNGCRYtzlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxxOs+WHCN8yYkzCsPdgx/BKilpEGbNbxFs4VxLjJ2g=;
        b=tmr7NX9eS70yAjzJwAGlGueEols1N72N6W98fWYciYi+WWQZ4rNLlzW3bANc5obso9
         6Q+GpXnp+DOKr/fA++ywVb20eExuNtjjGD2y6zOsZWCYZLB6wKcaPOijhqe/tzasFx0M
         zpFTOfItYpW9JEvKolGGrVTWRlvaV7L9v6fEeW3piEZ6N8yKNq2DbiefbN9HviVFaHbY
         qy2pF8cBvrmoPFYv0aujqF93rKcTfOS76ewSYRJRWxRp0zTgrA1x+X/5mSKbWbURIaEU
         ZozIHl9lhYF5/GLPZRP3uyp0mPNU7Iv/DRPhAcsHdUFa/sQCiD78f8aAbZdV8YT7jyMr
         /2+g==
X-Gm-Message-State: APjAAAW8FcCu7sxzn27W4i4ud5CEmz9P/aClEW+6jWc0+D+lTeURTOF6
        +c3egBNM0MLsy3AvfmF5g87lCw==
X-Google-Smtp-Source: APXvYqzatfDOusSPBh1WqKakLZc0DpjwdDToWjQSECc6hYoF0HYaCY+/Mnn4NcckBdYDj4y7irbB9Q==
X-Received: by 2002:a63:fa57:: with SMTP id g23mr11522684pgk.75.1562949275764;
        Fri, 12 Jul 2019 09:34:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d15sm21571604pjc.8.2019.07.12.09.34.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 09:34:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/panel: simple: Doxygenize 'struct panel_desc'; rename a few functions
Date:   Fri, 12 Jul 2019 09:33:33 -0700
Message-Id: <20190712163333.231884-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This attempts to address outstanding review feedback from commit
b8a2948fa2b3 ("drm/panel: simple: Add ability to override typical
timing").  Specifically:

* It was requested that I document (in the structure definition) that
  the device tree override had no effect if 'struct drm_display_mode'
  was used in the panel description.  I have provided full Doxygen
  comments for 'struct panel_desc' to accomplish that.
* panel_simple_get_fixed_modes() was thought to be a confusing name,
  so it has been renamed to panel_simple_get_display_modes().
* panel_simple_parse_override_mode() was thought to be better named as
  panel_simple_parse_panel_timing_node().

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTES:
- I have not addressed the suggestion of doing 'bool has_override =
  panel->override_mode.type != 0;'.  As per my reply on the mailing
  list I think the convention in this file is to rely on implicit
  conversions from int to bool.
- Sam said that there was still something that he didn't understand
  with regards to the flags.  Sam: if this is something that needs to
  be addressed, please yell.

 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a50871c6836b..f3c0e203f40f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -38,6 +38,22 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 
+/**
+ * @modes: Pointer to array of fixed modes appropriate for this panel.  If
+ *         only one mode then this can just be the address of this the mode.
+ *         NOTE: cannot be used with "timings" and also if this is specified
+ *         then you cannot override the mode in the device tree.
+ * @num_modes: Number of elements in modes array.
+ * @timings: Pointer to array of display timings.  NOTE: cannot be used with
+ *           "modes" and also these will be used to validate a device tree
+ *           override if one is present.
+ * @num_timings: Number of elements in timings array.
+ * @bpc: Bits per color.
+ * @size: Structure containing the physical size of this panel.
+ * @delay: Structure containing various delay values for this panel.
+ * @bus_format: See MEDIA_BUS_FMT_... defines.
+ * @bus_flags: See DRM_BUS_FLAG_... defines.
+ */
 struct panel_desc {
 	const struct drm_display_mode *modes;
 	unsigned int num_modes;
@@ -135,7 +151,7 @@ static unsigned int panel_simple_get_timings_modes(struct panel_simple *panel)
 	return num;
 }
 
-static unsigned int panel_simple_get_fixed_modes(struct panel_simple *panel)
+static unsigned int panel_simple_get_display_modes(struct panel_simple *panel)
 {
 	struct drm_connector *connector = panel->base.connector;
 	struct drm_device *drm = panel->base.drm;
@@ -199,7 +215,7 @@ static int panel_simple_get_non_edid_modes(struct panel_simple *panel)
 	 */
 	WARN_ON(panel->desc->num_timings && panel->desc->num_modes);
 	if (num == 0)
-		num = panel_simple_get_fixed_modes(panel);
+		num = panel_simple_get_display_modes(panel);
 
 	connector->display_info.bpc = panel->desc->bpc;
 	connector->display_info.width_mm = panel->desc->size.width;
@@ -351,9 +367,9 @@ static const struct drm_panel_funcs panel_simple_funcs = {
 #define PANEL_SIMPLE_BOUNDS_CHECK(to_check, bounds, field) \
 	(to_check->field.typ >= bounds->field.min && \
 	 to_check->field.typ <= bounds->field.max)
-static void panel_simple_parse_override_mode(struct device *dev,
-					     struct panel_simple *panel,
-					     const struct display_timing *ot)
+static void panel_simple_parse_panel_timing_node(struct device *dev,
+						 struct panel_simple *panel,
+						 const struct display_timing *ot)
 {
 	const struct panel_desc *desc = panel->desc;
 	struct videomode vm;
@@ -446,7 +462,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	}
 
 	if (!of_get_display_timing(dev->of_node, "panel-timing", &dt))
-		panel_simple_parse_override_mode(dev, panel, &dt);
+		panel_simple_parse_panel_timing_node(dev, panel, &dt);
 
 	drm_panel_init(&panel->base);
 	panel->base.dev = dev;
-- 
2.22.0.510.g264f2c817a-goog

