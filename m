Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3AFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C1420644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="BiI93sTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfEHQJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:09:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35589 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEHQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id d20so6281307qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATJVqwKnuJNVrskurSmrA7uNnNg1EGswZWkepzxe4V0=;
        b=BiI93sTPDI48u09oo5aW642Ut7uWXIbHaxIRSxvko7OVMBUkzwcWiQ9SVCKGZjYKrM
         b8BQoBiGYLq0iaQD8r2FC8gFTMdkXikTyh1wLqnQtRAoT7Ee3S68CBurfetg9JHg3lKw
         cTVwH36YY5I0EWFgVcaEPEiZtqo5Yy/WVCpcQgQvvuBRhluDbtBis8Xng/wsRoQxtl2c
         iYnYY6memCt2zMpj9lrDxmxGB+jtjUBQ5aUwSLCIFeWrEGWo8EYV8jgf+zyL16ql6dWs
         7eKqObYCVHTy3fGe78lul8ytvnDE80Ils3oUQHPuqXVBTICNkraYZAR0x1+N5HTCFnAW
         F5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATJVqwKnuJNVrskurSmrA7uNnNg1EGswZWkepzxe4V0=;
        b=h6+hrhSUeS9D27kGwkak4PfFfSWAEFLY7mKAuTFIknNqZ+235NfK2o/aegWyjlSXhr
         76Qk7miro2dqFaexDiXuB+cvnP46uYvMhxyY/ovlGMMr3OtIu0hAFv4PpaGdZYAmR2/M
         KN9Rz0cC7JyoeudHrHKX7XyvtQqPL8ipZJRCDrqK1qYOa5tvOJGC9idvjSIwdf1/9MBI
         vTOAnRoLzI3RpugvYsOUp7zvKw/4olcQXepLHqQeCVSS9fXCWGv35ODShke6jFWdy1w/
         ZBTJG1Htdmv6N95SWFv+ry+t1YV1ovZW9p3dGxkLrtLFne0c772A8fW07TKiHRnsoGwn
         Uqaw==
X-Gm-Message-State: APjAAAWMVkNFpG7zLRc0g5Cd2fgLr97eBqo6UxC0kV3IroeU0IOM1nD5
        dDdnjZ5Vyh0bslyLpbvSBX0kXg==
X-Google-Smtp-Source: APXvYqxNAXHpT8n2TmVaIrnB5HPtlaM3y7yNdf916J/CD2CsowIaYFGsxsuJy5ivIO/l0/VIXTgvAQ==
X-Received: by 2002:a0c:a944:: with SMTP id z4mr31106261qva.119.1557331764507;
        Wed, 08 May 2019 09:09:24 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10936877qts.39.2019.05.08.09.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:09:23 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] drm: Add atomic variants of enable/disable to encoder helper funcs
Date:   Wed,  8 May 2019 12:09:06 -0400
Message-Id: <20190508160920.144739-2-sean@poorly.run>
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

This patch adds atomic_enable and atomic_disable callbacks to the
encoder helpers. This will allow encoders to make informed decisions in
their start-up/shutdown based on the committed state.

Aside from the new hooks, this patch also introduces the new signature
for .atomic_* functions going forward. Instead of passing object state
(well, encoders don't have atomic state, but let's ignore that), we pass
the entire atomic state so the driver can inspect more than what's
happening locally.

This is particularly important for the upcoming self refresh helpers.

Changes in v3:
- Added patch to the set
Changes in v4:
- Move atomic_disable above prepare (Daniel)
- Add breadcrumb to .enable() docbook (Daniel)

Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-2-sean@poorly.run

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c      |  8 +++-
 include/drm/drm_modeset_helper_vtables.h | 48 ++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 553415fe8ede..ccf01831f265 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -999,7 +999,9 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 
 		/* Right function depends upon target state. */
 		if (funcs) {
-			if (new_conn_state->crtc && funcs->prepare)
+			if (funcs->atomic_disable)
+				funcs->atomic_disable(encoder, old_state);
+			else if (new_conn_state->crtc && funcs->prepare)
 				funcs->prepare(encoder);
 			else if (funcs->disable)
 				funcs->disable(encoder);
@@ -1309,7 +1311,9 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		drm_bridge_pre_enable(encoder->bridge);
 
 		if (funcs) {
-			if (funcs->enable)
+			if (funcs->atomic_enable)
+				funcs->atomic_enable(encoder, old_state);
+			else if (funcs->enable)
 				funcs->enable(encoder);
 			else if (funcs->commit)
 				funcs->commit(encoder);
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 8f3602811eb5..aa509c107083 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -675,6 +675,51 @@ struct drm_encoder_helper_funcs {
 	enum drm_connector_status (*detect)(struct drm_encoder *encoder,
 					    struct drm_connector *connector);
 
+	/**
+	 * @atomic_disable:
+	 *
+	 * This callback should be used to disable the encoder. With the atomic
+	 * drivers it is called before this encoder's CRTC has been shut off
+	 * using their own &drm_crtc_helper_funcs.atomic_disable hook. If that
+	 * sequence is too simple drivers can just add their own driver private
+	 * encoder hooks and call them from CRTC's callback by looping over all
+	 * encoders connected to it using for_each_encoder_on_crtc().
+	 *
+	 * This callback is a variant of @disable that provides the atomic state
+	 * to the driver. It takes priority over @disable during atomic commits.
+	 *
+	 * This hook is used only by atomic helpers. Atomic drivers don't need
+	 * to implement it if there's no need to disable anything at the encoder
+	 * level. To ensure that runtime PM handling (using either DPMS or the
+	 * new "ACTIVE" property) works @atomic_disable must be the inverse of
+	 * @atomic_enable.
+	 */
+	void (*atomic_disable)(struct drm_encoder *encoder,
+			       struct drm_atomic_state *state);
+
+	/**
+	 * @atomic_enable:
+	 *
+	 * This callback should be used to enable the encoder. It is called
+	 * after this encoder's CRTC has been enabled using their own
+	 * &drm_crtc_helper_funcs.atomic_enable hook. If that sequence is
+	 * too simple drivers can just add their own driver private encoder
+	 * hooks and call them from CRTC's callback by looping over all encoders
+	 * connected to it using for_each_encoder_on_crtc().
+	 *
+	 * This callback is a variant of @enable that provides the atomic state
+	 * to the driver. It is called in place of @enable during atomic
+	 * commits.
+	 *
+	 * This hook is used only by atomic helpers, for symmetry with @disable.
+	 * Atomic drivers don't need to implement it if there's no need to
+	 * enable anything at the encoder level. To ensure that runtime PM
+	 * handling (using either DPMS or the new "ACTIVE" property) works
+	 * @enable must be the inverse of @disable for atomic drivers.
+	 */
+	void (*atomic_enable)(struct drm_encoder *encoder,
+			      struct drm_atomic_state *state);
+
 	/**
 	 * @disable:
 	 *
@@ -691,6 +736,9 @@ struct drm_encoder_helper_funcs {
 	 * handling (using either DPMS or the new "ACTIVE" property) works
 	 * @disable must be the inverse of @enable for atomic drivers.
 	 *
+	 * For atomic drivers also consider @atomic_disable and save yourself
+	 * from having to read the NOTE below!
+	 *
 	 * NOTE:
 	 *
 	 * With legacy CRTC helpers there's a big semantic difference between
-- 
Sean Paul, Software Engineer, Google / Chromium OS

