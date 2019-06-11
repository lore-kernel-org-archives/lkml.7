Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4803C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89582173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="evokIjR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390839AbfFKAXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:23:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45419 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390734AbfFKAXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:23:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so5875308pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7l9eJCs2PeowUasvujNxJ+tq7unRBQcTxAKWiz4JMIE=;
        b=evokIjR4FgyjQ4UFLo9iswsV8vW4ne5f+ymL6lDggG9PK5MCubFk6GC/cJ93jctYsM
         VaPiJo+Rs9owKBfAdgdm9x/Qx065hL6/VManLQv5fJsFUhQWa5CSgM5J7VV5u4PffOoj
         05Sca9TKhk3F9uLQLzI9BpVrtyH3VMUHP7vWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7l9eJCs2PeowUasvujNxJ+tq7unRBQcTxAKWiz4JMIE=;
        b=EtThea7FtfhsftSqSrwPlcJn4BDRjcyzdx5Ut4TEvcu0GcD/rZzuBerEWL6Itbp8U/
         hF5iChKrWbU8hygBLluVvY6gui183C2gEtESznBNLhrTJv/JScsWpXvNNeE5e4FrXN20
         AXrcAyXeLXrhQwRh8XPIH95nJ6jLRcoJLLcdFOeruNsFBAJnDI1Dm6Hv4FkiYOG5W8g2
         l7x2FlY1dkOamI6DnrK2Azi4Va0wxD8/02yAWYfhRy8CODZeS4ltwsnZwx7BANLETLm4
         /dUZM63n3K6J7bMldYq9M4DdDt7I1suUvtJZL1AV3nmWEZRqeDBRUg3B1v1evjQ4R2kQ
         MK5w==
X-Gm-Message-State: APjAAAXhqRa8Rbxfh56pd6Xbdo+jm4FGpc0AWNmZd1jaZkg7STluy61j
        OaHqJZV1nSCea0duu3f7j6R45VaTnKg=
X-Google-Smtp-Source: APXvYqxXrwREiReNGSD5SzpOTe3czQMpgGRjtIlULxAPe0ldReXT1NS+YN+qsMaBOSYIsfxHYJn70A==
X-Received: by 2002:a62:2f87:: with SMTP id v129mr78643128pfv.9.1560212588496;
        Mon, 10 Jun 2019 17:23:08 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t4sm540317pjq.19.2019.06.10.17.23.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 17:23:07 -0700 (PDT)
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
Subject: [PATCH 3/5] drm/panel: Add attach/detach callbacks
Date:   Mon, 10 Jun 2019 17:22:54 -0700
Message-Id: <20190611002256.186969-4-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190611002256.186969-1-dbasehore@chromium.org>
References: <20190611002256.186969-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the attach/detach callbacks. These are for setting up
internal state for the connector/panel pair that can't be done at
probe (since the connector doesn't exist) and which don't need to be
repeatedly done for every get/modes, prepare, or enable callback.
Values such as the panel orientation, and display size can be filled
in for the connector.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/gpu/drm/drm_panel.c | 14 ++++++++++++++
 include/drm/drm_panel.h     |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 3b689ce4a51a..72f67678d9d5 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -104,12 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
  */
 int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
 {
+	int ret;
+
 	if (panel->connector)
 		return -EBUSY;
 
 	panel->connector = connector;
 	panel->drm = connector->dev;
 
+	if (panel->funcs->attach) {
+		ret = panel->funcs->attach(panel);
+		if (ret < 0) {
+			panel->connector = NULL;
+			panel->drm = NULL;
+			return ret;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_panel_attach);
@@ -128,6 +139,9 @@ EXPORT_SYMBOL(drm_panel_attach);
  */
 int drm_panel_detach(struct drm_panel *panel)
 {
+	if (panel->funcs->detach)
+		panel->funcs->detach(panel);
+
 	panel->connector = NULL;
 	panel->drm = NULL;
 
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 13631b2efbaa..e136e3a3c996 100644
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
@@ -70,6 +72,8 @@ struct display_timing;
 struct drm_panel_funcs {
 	int (*disable)(struct drm_panel *panel);
 	int (*unprepare)(struct drm_panel *panel);
+	void (*detach)(struct drm_panel *panel);
+	int (*attach)(struct drm_panel *panel);
 	int (*prepare)(struct drm_panel *panel);
 	int (*enable)(struct drm_panel *panel);
 	int (*get_modes)(struct drm_panel *panel);
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

