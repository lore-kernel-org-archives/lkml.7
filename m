Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86FEC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCFA206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="CG2fV4o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEBTuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:50:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37564 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfEBTuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:50:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id e2so2447972qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXRjMMNgMJ7AR2t39ARJeKFFNMtttw1Pb6pW3nWpIeo=;
        b=CG2fV4o5E0VsgIzVpLdO9WU6LS3o8P2C48qJUjmPnYfDrmg84QHO0QIQOJnK8kPYU4
         WA+BhLJ1wZ4AdvT8WN9gG8qZY44ljZM9LeAdeJOXmWkcL7SuDfwmZYcTyQ7k8pB44HMo
         Np+rEOV30AH23gmvihg2oC2E8NN8N1QkZa21B4uAdDtrP0lhcQ/HGiZC4g4Sw/bKz4zi
         j2XMVV2DFtAwJ5K4kFGEZtwc9KyZ24EFhC4qXkLV7M00oIgr68pOCBvT8SHkRaMryZCQ
         s0y0oMBLA+nMXiZ5o//+ZekDzXYRmFkD3lXmS1IgOmvU4me41NkTWG2u7jV450M/UrmD
         Hl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXRjMMNgMJ7AR2t39ARJeKFFNMtttw1Pb6pW3nWpIeo=;
        b=bhmKQdgcUD0BnVvZejA6sSCKcnTS6Yl9ZjsL0sUTvR85GFTXn5DLYVugkCILz7K1PK
         POQaDMLSMxb9KWd/IPGh2md6VTTOl9pKTTR5l9JJ9WLS4DiVaAI2WtjHVu/p/HVBt6UQ
         4iKkQUzGpbOnT/ggFjX/4yPnTUhT3ZzjRxZAvz7ATEFQ5NIHxgMfdStwea0EoQJ309s1
         HjuDLT0lAn0pHVvglkLKBX23kNOkM4oKhr8AD765s6HPnVETdK68iZclgZYA4PwBx3Lq
         Znsns/see0dlCMxhSqKNfDCtGM31NdvzUhCaxAte4zDGMrc0wLvawP0e2ktytOk2HiJF
         CQjQ==
X-Gm-Message-State: APjAAAV8GCSnoN0YTjd7cgSeT599toqzaHnI/fD0atafDdXxOrsWo4OC
        QnzDCXkeklvSrtfrOlrsRUWM6w==
X-Google-Smtp-Source: APXvYqzWq5f7dg4chyhc8zhSywRQMasOAeaYaXAtFzVut/t+aNoPXXx9mn7F3d8OSMUcDa/VuWMd3g==
X-Received: by 2002:a0c:ff21:: with SMTP id x1mr4814780qvt.30.1556826619691;
        Thu, 02 May 2019 12:50:19 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k36sm34366qtc.52.2019.05.02.12.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:50:19 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/10] drm: Add atomic variants for bridge enable/disable
Date:   Thu,  2 May 2019 15:49:45 -0400
Message-Id: <20190502194956.218441-4-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190502194956.218441-1-sean@poorly.run>
References: <20190502194956.218441-1-sean@poorly.run>
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

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c |   8 +-
 drivers/gpu/drm/drm_bridge.c        | 110 +++++++++++++++++++++++++++
 include/drm/drm_bridge.h            | 114 ++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 1f81ca8daad7..9d9e47276839 100644
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
index 138b2711d389..accccb586adf 100644
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
+ * the encoder's prepare op.
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
+ * the encoder's prepare op.
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
+ * drm_bridge_pre_enable - prepares for enabling all bridges in the encoder
+ *			   chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.pre_enable (falls back on
+ * &drm_bridge_funcs.pre_enable) op for all the bridges in the encoder chain,
+ * starting from the last bridge to the first. These are called before calling
+ * the encoder's commit op.
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
+ * the encoder's commit op.
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
index d4428913a4e1..86f436895c7b 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -237,6 +237,111 @@ struct drm_bridge_funcs {
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
+	 * &drm_encoder_helper_funcs.atomic_enable,
+	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
+	 * &drm_encoder_helper_funcs.dpms hook.
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
+	 * &drm_encoder_helper_funcs.atomic_enable,
+	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
+	 * &drm_encoder_helper_funcs.dpms hook.
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
+	 * &drm_encoder_helper_funcs.atomic_disable,
+	 * &drm_encoder_helper_funcs.disable, &drm_encoder_helper_funcs.prepare
+	 * or &drm_encoder_helper_funcs.dpms hook.
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
+	 * &drm_encoder_helper_funcs.atomic_disable,
+	 * &drm_encoder_helper_funcs.disable, &drm_encoder_helper_funcs.prepare
+	 * or &drm_encoder_helper_funcs.dpms hook.
+	 *
+	 * The bridge must assume that the display pipe (i.e. clocks and timing
+	 * singals) feeding it is no longer running when this callback is
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
@@ -314,6 +419,15 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
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

