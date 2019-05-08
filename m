Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFC9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81A420644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Rqz3G2LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfEHQJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:09:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36368 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfEHQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id c14so1422731qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67oFq0hHUuvlnx5kLZAHcmnIPUOWziYMI8AviI60rfs=;
        b=Rqz3G2LOaRpeooNXRrJax3bpqTSGp6OLZ6quAjdxsqF1V9mdz72qpp2dE9FcxteusI
         HCvyvucKcRnH9s5MG19tfOfnaRBDaesP78Og7e5ll3oD8wTehW5rSw04/vTqlDdaW/My
         4tSGnxy+CtDRgXehQ54AXthiNvig8Yd2bO6vb7tG7vY8tU3AQQzWoLvOF2QtoJsWa+/3
         DaOC7NcrOo0z1d4LuQhljdlSidl2GfColq3N9Ope6gLdY22BN5wExiMMpBxX161QLmd5
         V6/H0/Bu4vHtyo93lkKGdUw4Uepl95sLGGQxF+iCV1uc6Kdigee2lIX1g9Bi7sjRIBya
         xm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67oFq0hHUuvlnx5kLZAHcmnIPUOWziYMI8AviI60rfs=;
        b=KC3Ybx/nmX9oThTzY2Ei4/UnGyh/sqVGfB8YkAxRlg+fwv6TMaD7nFHuSa0pdGqPWN
         bHgvdF7ZCoI9JnpSzKXNKkU4AeRVM8KN8Ier7WhScnm4aucs09BbhaqMCeCqJ8YfZyKS
         iy91lEhFxRAO/B5GgOAVrdH2LtEKt8t2Q8dy/zMTx5aiL6o2pYJzz6dpBivgT8stVjVZ
         rBFWgzjl3f5osq+oKGaxkbKe5gepwpr6ZBIiF2kJjqpwyhBtp9Oi4oDL01ZXQvwbxn72
         w+YhADWdQILrCiBpZyZddJZk8IIk4M6uP+qvtSchdx5RdDOuoyOaOt/k8agrcJ3Jnnao
         U0wg==
X-Gm-Message-State: APjAAAXUIVfDsbbm0ryIWXWOVOLovGYZVjPSAN8VJb4x3IRYdWxAJACR
        /uZzh+owC63yI7iS+ijC6/UW9g==
X-Google-Smtp-Source: APXvYqwl5uH8YCKlrsUZD6qmk/ZnyG/htEksrUfym6gyW4NXUy7ezzFcrcaqA1G2/5x9TABDHJM+kA==
X-Received: by 2002:a37:54d:: with SMTP id 74mr17159593qkf.244.1557331766381;
        Wed, 08 May 2019 09:09:26 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10936877qts.39.2019.05.08.09.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:09:25 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] drm: Add drm_atomic_get_(old|new-_connector_for_encoder() helpers
Date:   Wed,  8 May 2019 12:09:07 -0400
Message-Id: <20190508160920.144739-3-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508160920.144739-1-sean@poorly.run>
References: <20190508160920.144739-1-sean@poorly.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Add functions to the atomic core to retrieve the old and new connectors
associated with an encoder in a drm_atomic_state. This is useful for
encoders and bridges that need to access the connector, for instance for
the drm_display_info.

The CRTC associated with the encoder can also be retrieved through the
connector state, and from it, the old and new CRTC states.

Changed in v4:
- Added to the set

Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[seanpaul removed WARNs from helpers and added docs to explain why
returning NULL might be valid]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_atomic.c | 70 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |  7 ++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 5eb40130fafb..936002495523 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -797,6 +797,76 @@ drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 }
 EXPORT_SYMBOL(drm_atomic_get_private_obj_state);
 
+/**
+ * drm_atomic_get_old_connector_for_encoder - Get old connector for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the connector state for
+ *
+ * This function finds and returns the connector that was connected to @encoder
+ * as specified by the @state.
+ *
+ * If there is no connector in @state which previously had @encoder connected to
+ * it, this function will return NULL. While this may seem like an invalid use
+ * case, it is sometimes a useful to differentiate commits which had no prior
+ * connectors attached to @encoder vs ones that did (and to inspect their
+ * @state). This is especially true in enable hooks because the pipeline has
+ * changed/will change.
+ *
+ * Returns: The old connector connected to @encoder, or NULL if the encoder is
+ * not connected.
+ */
+struct drm_connector *
+drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_connector *connector;
+	unsigned int i;
+
+	for_each_old_connector_in_state(state, connector, conn_state, i) {
+		if (conn_state->best_encoder == encoder)
+			return connector;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_get_old_connector_for_encoder);
+
+/**
+ * drm_atomic_get_new_connector_for_encoder - Get new connector for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the connector state for
+ *
+ * This function finds and returns the connector that will be connected to
+ * @encoder as specified by the @state.
+ *
+ * If there is no connector in @state which will have @encoder connected to it,
+ * this function will return NULL. While this may seem like an invalid use case,
+ * it is sometimes a useful to differentiate commits which have no connectors
+ * attached to @encoder vs ones that do (and to inspect their state). This is
+ * especially true in disable hooks because the pipeline has changed/will
+ * change.
+ *
+ * Returns: The new connector connected to @encoder, or NULL if the encoder is
+ * not connected.
+ */
+struct drm_connector *
+drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_connector *connector;
+	unsigned int i;
+
+	for_each_new_connector_in_state(state, connector, conn_state, i) {
+		if (conn_state->best_encoder == encoder)
+			return connector;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
+
 /**
  * drm_atomic_get_connector_state - get connector state
  * @state: global atomic state object
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 824a5ed4e216..d6b3acd34e1c 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -453,6 +453,13 @@ struct drm_private_state * __must_check
 drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 				 struct drm_private_obj *obj);
 
+struct drm_connector *
+drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder);
+struct drm_connector *
+drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder);
+
 /**
  * drm_atomic_get_existing_crtc_state - get crtc state, if it exists
  * @state: global atomic state object
-- 
Sean Paul, Software Engineer, Google / Chromium OS

