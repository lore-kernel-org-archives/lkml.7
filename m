Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A50C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD13C21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="D8noIPyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfEBTuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:50:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41518 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfEBTuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:50:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id c13so4062531qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/u+2wMWD5qgsv9mU8zFBG54a7HxlNWxbgZL8h1Zsk8=;
        b=D8noIPyBltKrHNdSLQv7QwB5qTJfo2xDPFC/KvHjHwbbZxsQRAFHWU7b3vXAAvEHvZ
         5TxYtvys+v824zV3i33ByAa95amPXEwvI44S9nyP641VX+lI/6Gh6giAK8RbwU+Ejmf6
         xbvbJxTBP4hP0xmhATwTHiBjqIZsarK+ZCZ2dVacQkWL3cH1uYl0xZw6uRVomJRKi3Qx
         RbtPVEwYHf5RwppKGHDksQvLa67KHuYniPsdjCGJhHXba+A+zrib10fimTk+oIZPaw5P
         GN3rVEAXdwlllHeoyq1qbeH2zHFV8CPmDb8uBlYCJi2xebkFwSVSaO7DdT96FLM/a8WF
         /3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/u+2wMWD5qgsv9mU8zFBG54a7HxlNWxbgZL8h1Zsk8=;
        b=du1RU4gegPbLYYL012BGg0Eq07Jg6S5JABbW8+u+L2ka8ezfGTaFrOUi2AlqYZwVv4
         tR8RfCdS1TRZQpRje5+hVsWfMiUJ1nLwyZciXimIsJROyVwvf9AvlKrDKhsTSolh7wJ1
         kwKeGH4Y98txFnf0kwUjdC+juejb7yNHKMn4h1Ju3FBjzZf1KuMBGXPkLWsMTffgXwdg
         sNMCg7DNwh1zARsTEeo++VmD3LpFp5xtUret0/+UgpnwOe536bijT7MxGaE7Gw/dJOKM
         L9mRfXLQIjIEKZawOTnRfMjzFUYq8lBktPwTDv9Ep5DAb3p+CLAWw9cVYCM63iUjdAVF
         Fk1Q==
X-Gm-Message-State: APjAAAVjNfBss5TTeD2ig6h8fSNwFp80chJ8mJwgi74TXuSGhx3s7Gb6
        dUWBDNw0z/TjK6Av8aiceFfl4FOmpJo=
X-Google-Smtp-Source: APXvYqxIvmYWNDjFSgSitmtaXaEYuycKYhYf5LPkJShiYp2oXu8Cmuhjsdd+iZmhigaosQYCQoLaJg==
X-Received: by 2002:aed:2188:: with SMTP id l8mr4937051qtc.332.1556826614723;
        Thu, 02 May 2019 12:50:14 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k36sm34366qtc.52.2019.05.02.12.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:50:14 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] drm: Add atomic variants of enable/disable to encoder helper funcs
Date:   Thu,  2 May 2019 15:49:43 -0400
Message-Id: <20190502194956.218441-2-sean@poorly.run>
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

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c      |  6 +++-
 include/drm/drm_modeset_helper_vtables.h | 45 ++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 553415fe8ede..71cc7d6b0644 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1001,6 +1001,8 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 		if (funcs) {
 			if (new_conn_state->crtc && funcs->prepare)
 				funcs->prepare(encoder);
+			else if (funcs->atomic_disable)
+				funcs->atomic_disable(encoder, old_state);
 			else if (funcs->disable)
 				funcs->disable(encoder);
 			else if (funcs->dpms)
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
index 8f3602811eb5..de57fb40cb6e 100644
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
-- 
Sean Paul, Software Engineer, Google / Chromium OS

