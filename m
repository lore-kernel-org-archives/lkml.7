Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C342C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9622216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="AHoHpzUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfEHQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:10:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35599 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfEHQJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id d20so6281575qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5YevbVXRhROWLczBu+rM4sdJCientt/mUS8uGJQbS74=;
        b=AHoHpzUpkM9OwhZT9PcMUp82h3P0mRZIfFpc7JLJEVwyHNxIIm74K3+6t4CZQOvkXY
         KGClZeTm8HiagCU5eeis8gCe40PWHmsFeKkZ5VYNbwpzKwJGtGP3UtslQh662/Wq+naG
         aFPYnNsQ/jWDvkEv69MTVS+xE6pSPY+aZaGYVFoMzSnGirDmNp/WktWzbeBZApsDeErS
         NyiUjyaqOJBniBQIfqyxu/+iEHGa6W2YeBS1ZR61RzwxLUN9QwhKNy+oikvttWKynYRO
         2KMQuh6YLlxw1jk0pw+ACOOSoPHMeVMFWD2N4JkqoNptlce32kBMLP5htLWj58CaV1Z8
         hGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5YevbVXRhROWLczBu+rM4sdJCientt/mUS8uGJQbS74=;
        b=uFA9Q/kB7BNs172AglGOVyqpmvqRnBdnEvgedLYTGzO1fy5WPcYg4IEdaLDvcDT6RC
         ybK4dMFObh+jIdKC1yjgD/9sZ2yehOzIyTT27z5/EpJF7X6t1aed0GzWzOun8EswDeP+
         WWTMyA87cUnY27kIq70RUCwBsuyUWa77VbkrxZdjjeHZlZrCBRsUt/aRRUS69Y9t0l9l
         aUVNue24DGarV3S/MhMiv4JUExspv+/GZOo41lTqq9wOTj/S5nAi+sKzcamDDTK17k0f
         Nas8Y8qV0Ao8TT88/1bfN5QVXn18me6ABz8oYjaERBAHri4vYYQKzhdgFVco600FXO+C
         FT9Q==
X-Gm-Message-State: APjAAAUoykMdGKmRAYYGOZzgGoHbmSAZsObnakAH+3JenNdPGd7TdJBB
        yN57dh9JJcWBjky5kGAJuj2fpA==
X-Google-Smtp-Source: APXvYqx9gjOwlYc8RgobItIWo9StUAhk3EVOON1A3lRGgkENYaJQym72KzhwCzlbNtFhWDXENR50qg==
X-Received: by 2002:a0c:da04:: with SMTP id x4mr11882545qvj.136.1557331768631;
        Wed, 08 May 2019 09:09:28 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10936877qts.39.2019.05.08.09.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:09:27 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] drm: Add atomic variants for bridge enable/disable
Date:   Wed,  8 May 2019 12:09:08 -0400
Message-Id: <20190508160920.144739-4-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508160920.144739-1-sean@poorly.run>
References: <20190508160920.144739-1-sean@poorly.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

This patch adds atomic variants for all of
pre_enable/enable/disable/post_disable bridge functions. These will be
called from the appropriate atomic helper functions. If the bridge
driver doesn't implement the atomic version of the function, we will
fall back to the vanilla implementation.

Note that some drivers call drm_bridge_disable directly, and these cases
are not covered. It's up to the driver to decide whether to implement
both atomic_disable and disable, or if it's not necessary.

Changes in v3:
- Added to the patchset
Changes in v4:
- Fix up docbook references (Daniel)

Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-4-sean@poorly.run

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c |   8 +-
 drivers/gpu/drm/drm_bridge.c        | 110 ++++++++++++++++++++++++++++
 include/drm/drm_bridge.h            | 106 +++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index ccf01831f265..e8b7187a8494 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -995,7 +995,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 		 * Each encoder has at most one connector (since we always steal
 		 * it away), so we won't call disable hooks twice.
 		 */
-		drm_bridge_disable(encoder->bridge);
+		drm_atomic_bridge_disable(encoder->bridge, old_state);
 
 		/* Right function depends upon target state. */
 		if (funcs) {
@@ -1009,7 +1009,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
 		}
 
-		drm_bridge_post_disable(encoder->bridge);
+		drm_atomic_bridge_post_disable(encoder->bridge, old_state);
 	}
 
 	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
@@ -1308,7 +1308,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		 * Each encoder has at most one connector (since we always steal
 		 * it away), so we won't call enable hooks twice.
 		 */
-		drm_bridge_pre_enable(encoder->bridge);
+		drm_atomic_bridge_pre_enable(encoder->bridge, old_state);
 
 		if (funcs) {
 			if (funcs->atomic_enable)
@@ -1319,7 +1319,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 				funcs->commit(encoder);
 		}
 
-		drm_bridge_enable(encoder->bridge);
+		drm_atomic_bridge_enable(encoder->bridge, old_state);
 	}
 
 	drm_atomic_helper_commit_writebacks(dev, old_state);
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 138b2711d389..cba537c99e43 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -352,6 +352,116 @@ void drm_bridge_enable(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_enable);
 
+/**
+ * drm_atomic_bridge_disable - disables all bridges in the encoder chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.atomic_disable (falls back on
+ * &drm_bridge_funcs.disable) op for all the bridges in the encoder chain,
+ * starting from the last bridge to the first. These are called before calling
+ * &drm_encoder_helper_funcs.atomic_disable
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ */
+void drm_atomic_bridge_disable(struct drm_bridge *bridge,
+			       struct drm_atomic_state *state)
+{
+	if (!bridge)
+		return;
+
+	drm_atomic_bridge_disable(bridge->next, state);
+
+	if (bridge->funcs->atomic_disable)
+		bridge->funcs->atomic_disable(bridge, state);
+	else if (bridge->funcs->disable)
+		bridge->funcs->disable(bridge);
+}
+EXPORT_SYMBOL(drm_atomic_bridge_disable);
+
+/**
+ * drm_atomic_bridge_post_disable - cleans up after disabling all bridges in the
+ *				    encoder chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.atomic_post_disable (falls back on
+ * &drm_bridge_funcs.post_disable) op for all the bridges in the encoder chain,
+ * starting from the first bridge to the last. These are called after completing
+ * &drm_encoder_helper_funcs.atomic_disable
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ */
+void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
+				    struct drm_atomic_state *state)
+{
+	if (!bridge)
+		return;
+
+	if (bridge->funcs->atomic_post_disable)
+		bridge->funcs->atomic_post_disable(bridge, state);
+	else if (bridge->funcs->post_disable)
+		bridge->funcs->post_disable(bridge);
+
+	drm_atomic_bridge_post_disable(bridge->next, state);
+}
+EXPORT_SYMBOL(drm_atomic_bridge_post_disable);
+
+/**
+ * drm_atomic_bridge_pre_enable - prepares for enabling all bridges in the
+ *				  encoder chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.atomic_pre_enable (falls back on
+ * &drm_bridge_funcs.pre_enable) op for all the bridges in the encoder chain,
+ * starting from the last bridge to the first. These are called before calling
+ * &drm_encoder_helper_funcs.atomic_enable
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ */
+void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
+				  struct drm_atomic_state *state)
+{
+	if (!bridge)
+		return;
+
+	drm_atomic_bridge_pre_enable(bridge->next, state);
+
+	if (bridge->funcs->atomic_pre_enable)
+		bridge->funcs->atomic_pre_enable(bridge, state);
+	else if (bridge->funcs->pre_enable)
+		bridge->funcs->pre_enable(bridge);
+}
+EXPORT_SYMBOL(drm_atomic_bridge_pre_enable);
+
+/**
+ * drm_atomic_bridge_enable - enables all bridges in the encoder chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.atomic_enable (falls back on
+ * &drm_bridge_funcs.enable) op for all the bridges in the encoder chain,
+ * starting from the first bridge to the last. These are called after completing
+ * &drm_encoder_helper_funcs.atomic_enable
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ */
+void drm_atomic_bridge_enable(struct drm_bridge *bridge,
+			      struct drm_atomic_state *state)
+{
+	if (!bridge)
+		return;
+
+	if (bridge->funcs->atomic_enable)
+		bridge->funcs->atomic_enable(bridge, state);
+	else if (bridge->funcs->enable)
+		bridge->funcs->enable(bridge);
+
+	drm_atomic_bridge_enable(bridge->next, state);
+}
+EXPORT_SYMBOL(drm_atomic_bridge_enable);
+
 #ifdef CONFIG_OF
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node in
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d4428913a4e1..322801884814 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -237,6 +237,103 @@ struct drm_bridge_funcs {
 	 * The enable callback is optional.
 	 */
 	void (*enable)(struct drm_bridge *bridge);
+
+	/**
+	 * @atomic_pre_enable:
+	 *
+	 * This callback should enable the bridge. It is called right before
+	 * the preceding element in the display pipe is enabled. If the
+	 * preceding element is a bridge this means it's called before that
+	 * bridge's @atomic_pre_enable or @pre_enable function. If the preceding
+	 * element is a &drm_encoder it's called right before the encoder's
+	 * &drm_encoder_helper_funcs.atomic_enable hook.
+	 *
+	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
+	 * will not yet be running when this callback is called. The bridge must
+	 * not enable the display link feeding the next bridge in the chain (if
+	 * there is one) when this callback is called.
+	 *
+	 * Note that this function will only be invoked in the context of an
+	 * atomic commit. It will not be invoked from &drm_bridge_pre_enable. It
+	 * would be prudent to also provide an implementation of @pre_enable if
+	 * you are expecting driver calls into &drm_bridge_pre_enable.
+	 *
+	 * The @atomic_pre_enable callback is optional.
+	 */
+	void (*atomic_pre_enable)(struct drm_bridge *bridge,
+				  struct drm_atomic_state *state);
+
+	/**
+	 * @atomic_enable:
+	 *
+	 * This callback should enable the bridge. It is called right after
+	 * the preceding element in the display pipe is enabled. If the
+	 * preceding element is a bridge this means it's called after that
+	 * bridge's @atomic_enable or @enable function. If the preceding element
+	 * is a &drm_encoder it's called right after the encoder's
+	 * &drm_encoder_helper_funcs.atomic_enable hook.
+	 *
+	 * The bridge can assume that the display pipe (i.e. clocks and timing
+	 * signals) feeding it is running when this callback is called. This
+	 * callback must enable the display link feeding the next bridge in the
+	 * chain if there is one.
+	 *
+	 * Note that this function will only be invoked in the context of an
+	 * atomic commit. It will not be invoked from &drm_bridge_enable. It
+	 * would be prudent to also provide an implementation of @enable if
+	 * you are expecting driver calls into &drm_bridge_enable.
+	 *
+	 * The enable callback is optional.
+	 */
+	void (*atomic_enable)(struct drm_bridge *bridge,
+			      struct drm_atomic_state *state);
+	/**
+	 * @atomic_disable:
+	 *
+	 * This callback should disable the bridge. It is called right before
+	 * the preceding element in the display pipe is disabled. If the
+	 * preceding element is a bridge this means it's called before that
+	 * bridge's @atomic_disable or @disable vfunc. If the preceding element
+	 * is a &drm_encoder it's called right before the
+	 * &drm_encoder_helper_funcs.atomic_disable hook.
+	 *
+	 * The bridge can assume that the display pipe (i.e. clocks and timing
+	 * signals) feeding it is still running when this callback is called.
+	 *
+	 * Note that this function will only be invoked in the context of an
+	 * atomic commit. It will not be invoked from &drm_bridge_disable. It
+	 * would be prudent to also provide an implementation of @disable if
+	 * you are expecting driver calls into &drm_bridge_disable.
+	 *
+	 * The disable callback is optional.
+	 */
+	void (*atomic_disable)(struct drm_bridge *bridge,
+			       struct drm_atomic_state *state);
+
+	/**
+	 * @atomic_post_disable:
+	 *
+	 * This callback should disable the bridge. It is called right after the
+	 * preceding element in the display pipe is disabled. If the preceding
+	 * element is a bridge this means it's called after that bridge's
+	 * @atomic_post_disable or @post_disable function. If the preceding
+	 * element is a &drm_encoder it's called right after the encoder's
+	 * &drm_encoder_helper_funcs.atomic_disable hook.
+	 *
+	 * The bridge must assume that the display pipe (i.e. clocks and timing
+	 * signals) feeding it is no longer running when this callback is
+	 * called.
+	 *
+	 * Note that this function will only be invoked in the context of an
+	 * atomic commit. It will not be invoked from &drm_bridge_post_disable.
+	 * It would be prudent to also provide an implementation of
+	 * @post_disable if you are expecting driver calls into
+	 * &drm_bridge_post_disable.
+	 *
+	 * The post_disable callback is optional.
+	 */
+	void (*atomic_post_disable)(struct drm_bridge *bridge,
+				    struct drm_atomic_state *state);
 };
 
 /**
@@ -314,6 +411,15 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
 void drm_bridge_pre_enable(struct drm_bridge *bridge);
 void drm_bridge_enable(struct drm_bridge *bridge);
 
+void drm_atomic_bridge_disable(struct drm_bridge *bridge,
+			       struct drm_atomic_state *state);
+void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
+				    struct drm_atomic_state *state);
+void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
+				  struct drm_atomic_state *state);
+void drm_atomic_bridge_enable(struct drm_bridge *bridge,
+			      struct drm_atomic_state *state);
+
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
 					u32 connector_type);
-- 
Sean Paul, Software Engineer, Google / Chromium OS

