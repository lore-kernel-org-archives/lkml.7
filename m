Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF58C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D4B206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="MDTke5Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEBTuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:50:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37555 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfEBTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:50:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id e2so2447816qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQv/EW+pxQy0WvYaV+otVZjtRHAeKNfXoG3CC92/2Uk=;
        b=MDTke5OhkuWbovpVSD6D3qZvleMpftBW4urzoswDNagEWuQ3+jbUlmldjuKLIs6VwM
         KCLWuSXr1AbbcsD0zh8EeiEOcO6o5hCs0V7MG4/E4KsBZuy7rZmAsQl7CE4RkQ141uOG
         NSXDIkISyK9AzaGlk19WNTnj/pUUELNv8qDQezAG2NDNge33bWzOY/tZYCPS7Blhrr4R
         wwRqC8pikKHooesQtFaSNmcAthv1ZkV8BlZEVRwdhVl3d0OBGJL5b7aGubIXvzoszBmO
         DSxQPiGJn2/PCvvBRoPa90uW6dyF5lKwYKw1++PY6fStGFsoQNnXZtNl1cZwyJXKUOpr
         r8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQv/EW+pxQy0WvYaV+otVZjtRHAeKNfXoG3CC92/2Uk=;
        b=nxcQLzRkm49SAtMHykhE4q2O6RMbcm5Vj3PS2xLKnKSG7TZGijRD8mgXZ6vw5I19sX
         EPoXP47pJBgx88HrdfgDw7dCLAYQdin30QjiucHiBXPZPavTUtDwzWqoBBooVAIS1E3I
         CRHl/HqhYXptVNln2UCitROFt3OSMithlE1anTQfQWM9PC2W2NB5b3BrVt9hSt9t80MY
         smZLZBes8ldb1Mz0Ro9oAuqUdqWJglrpgg6/FxwSaIFiK4d9LwUT5U+iP+PMKL3n8Pqe
         QZ/Iuaek2tZW3yxq+685Fk04FQojd3gaE7G8R4wWQMHW9o4Q3PI5sdNCquVJ0u/clAsn
         6iDg==
X-Gm-Message-State: APjAAAWqfPohaKowEVynWvyDgC14xnO2ZdSe3x7pG5H8OJPlPTjb9HZG
        tU/8gdjeU2VTrCtb5+SzQAbJUg==
X-Google-Smtp-Source: APXvYqxx5XOmrLfL3KiwfdtH5c/vXDyekwMuGft/OKBtFITrRm0NboGUXAsQkEbWEFxBJpBCT/7npA==
X-Received: by 2002:a0c:87bb:: with SMTP id 56mr4669280qvj.219.1556826617419;
        Thu, 02 May 2019 12:50:17 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k36sm34366qtc.52.2019.05.02.12.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:50:17 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] drm: Add drm_atomic_crtc_state_for_encoder helper
Date:   Thu,  2 May 2019 15:49:44 -0400
Message-Id: <20190502194956.218441-3-sean@poorly.run>
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

This patch adds a helper to tease out the currently connected crtc for
an encoder, along with its state. This follows the same pattern as the
drm_atomic_crtc_*_for_* macros in the atomic helpers. Since the
relationship of crtc:encoder is 1:n, we don't need a loop since there is
only one crtc per encoder.

Instead of splitting this into 3 functions which all do the same thing,
this is presented as one function. Perhaps that's too ugly and it should
be split to:
struct drm_crtc *drm_atomic_crtc_for_encoder(state, encoder);
struct drm_crtc_state *drm_atomic_new_crtc_state_for_encoder(state, encoder);
struct drm_crtc_state *drm_atomic_old_crtc_state_for_encoder(state, encoder);

Suggestions welcome.

Changes in v3:
- Added to the set

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 48 +++++++++++++++++++++++++++++
 include/drm/drm_atomic_helper.h     |  6 ++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 71cc7d6b0644..1f81ca8daad7 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3591,3 +3591,51 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_legacy_gamma_set);
+
+/**
+ * drm_atomic_crtc_state_for_encoder - Get crtc and new/old state for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the crtc information for
+ * @crtc: If not NULL, receives the currently connected crtc
+ * @old_crtc_state: If not NULL, receives the crtc's old state
+ * @new_crtc_state: If not NULL, receives the crtc's new state
+ *
+ * This function finds the crtc which is currently connected to @encoder and
+ * returns it as well as its old and new state. If there is no crtc currently
+ * connected, the function will clear @crtc, @old_crtc_state, @new_crtc_state.
+ *
+ * All of @crtc, @old_crtc_state, and @new_crtc_state are optional.
+ */
+void drm_atomic_crtc_state_for_encoder(struct drm_atomic_state *state,
+				       struct drm_encoder *encoder,
+				       struct drm_crtc **crtc,
+				       struct drm_crtc_state **old_crtc_state,
+				       struct drm_crtc_state **new_crtc_state)
+{
+	struct drm_crtc *tmp_crtc;
+	struct drm_crtc_state *tmp_new_crtc_state, *tmp_old_crtc_state;
+	u32 enc_mask = drm_encoder_mask(encoder);
+	int i;
+
+	for_each_oldnew_crtc_in_state(state, tmp_crtc, tmp_old_crtc_state,
+				      tmp_new_crtc_state, i) {
+		if (!(tmp_new_crtc_state->encoder_mask & enc_mask))
+			continue;
+
+		if (new_crtc_state)
+			*new_crtc_state = tmp_new_crtc_state;
+		if (old_crtc_state)
+			*old_crtc_state = tmp_old_crtc_state;
+		if (crtc)
+			*crtc = tmp_crtc;
+		return;
+	}
+
+	if (new_crtc_state)
+		*new_crtc_state = NULL;
+	if (old_crtc_state)
+		*old_crtc_state = NULL;
+	if (crtc)
+		*crtc = NULL;
+}
+EXPORT_SYMBOL(drm_atomic_crtc_state_for_encoder);
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 58214be3bf3d..2383550a0cc8 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -153,6 +153,12 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
 				       uint32_t size,
 				       struct drm_modeset_acquire_ctx *ctx);
 
+void drm_atomic_crtc_state_for_encoder(struct drm_atomic_state *state,
+				       struct drm_encoder *encoder,
+				       struct drm_crtc **crtc,
+				       struct drm_crtc_state **old_crtc_state,
+				       struct drm_crtc_state **new_crtc_state);
+
 /**
  * drm_atomic_crtc_for_each_plane - iterate over planes currently attached to CRTC
  * @plane: the loop cursor
-- 
Sean Paul, Software Engineer, Google / Chromium OS

