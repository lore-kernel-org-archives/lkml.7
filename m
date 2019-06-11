Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA854C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDCD2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQSD7BQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbfFKAXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:23:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41167 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbfFKAXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:23:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id 83so5884027pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dK5nepKO/Lu9qcWjch0d2Z8IhG0b83DDW/+1Tc5GcLg=;
        b=CQSD7BQmHeU8dta4f8b5FeRoYweJraemdUXZE33CRhZXzo2oXBuxCTGOM5BsNNhKw5
         IvZrNb952TuK7jl2R5T28ivBeonhQhikKcdqjfd37R2qgBuDst95M8MdOOmp83tshMXF
         enl7C+yuT6sx2o9EbxANZjUSRbg/SsDRj33L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dK5nepKO/Lu9qcWjch0d2Z8IhG0b83DDW/+1Tc5GcLg=;
        b=At0e+i9neCpK6QQ9guuRuXbh2R2Hrs4YCPsLBkwch4aIxBkwYLg1qb7Wi1QMJqXL5p
         H7NhZlKvOvFpRsFu6/zrZerWNifUgguDXVYcuSyN/VEbOngcCKX2iZqlOn0/ycXvvpku
         bp1s+18S/3dDJrs12efTRQae/Qgen6POgqFh5x3EGQEGTj/dXOkAtK8au6UdN1H8FBQe
         gHvGYIuNlbbsFPE+hadpvTdOXNYU4WHcpHuiQQM7fqnwFhGdU8d+qPi5uyxTznz6wqOF
         xS/P5Wpl+B5NjbdYVxtw2VwyMcFJe1MTSnS9Sq6qCAO04dnbrJId2wYqymG+pJkh69kh
         sjFA==
X-Gm-Message-State: APjAAAX4hsqRs5OEiWbEWnsoxaHdBtUcOll5I2yEmZZ2CiT9U3Bk2fQ/
        P7LceCfcQNo3adK9XXB9vU+DnGlPR3U=
X-Google-Smtp-Source: APXvYqwcqMLc4JPOcan8IYdWBHlZr/s4dv56BnUDmV3zQ52JM1dZEdhNG4dhlV/n6npVhEvKjcRd2Q==
X-Received: by 2002:a62:1b85:: with SMTP id b127mr77773519pfb.165.1560212586202;
        Mon, 10 Jun 2019 17:23:06 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t4sm540317pjq.19.2019.06.10.17.23.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 17:23:05 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, sam@ravnborg.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, ck.hu@mediatek.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 1/5] drm/panel: Add helper for reading DT rotation
Date:   Mon, 10 Jun 2019 17:22:52 -0700
Message-Id: <20190611002256.186969-2-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190611002256.186969-1-dbasehore@chromium.org>
References: <20190611002256.186969-1-dbasehore@chromium.org>
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
 drivers/gpu/drm/drm_panel.c | 41 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_panel.h     |  7 +++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index dbd5b873e8f2..3b689ce4a51a 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -172,6 +172,47 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 EXPORT_SYMBOL(of_drm_find_panel);
+
+/**
+ * of_drm_get_panel_orientation - look up the rotation of the panel using a
+ * device tree node
+ * @np: device tree node of the panel
+ * @orientation: orientation enum to be filled in
+ *
+ * Looks up the rotation of a panel in the device tree. The rotation in the
+ * device tree is counter clockwise.
+ *
+ * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
+ * rotation property doesn't exist. -EERROR otherwise.
+ */
+int of_drm_get_panel_orientation(const struct device_node *np, int *orientation)
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
index 8c738c0e6e9f..13631b2efbaa 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -197,11 +197,18 @@ int drm_panel_detach(struct drm_panel *panel);
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
+int of_drm_get_panel_orientation(const struct device_node *np,
+				 int *orientation);
 #else
 static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
 }
+int of_drm_get_panel_orientation(const struct device_node *np,
+				 int *orientation)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

