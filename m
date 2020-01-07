Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C1BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBAB206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432469;
	bh=hkKkQzKA07HW16eCSUwtMU/boTufp7DhIiDtD6w3ofs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mVWUGj/NrUH4z352DlvrXHNZ3eoqnc+CyZuiuu5oNFDM+aBVzM5HWOm4LX51Z7PwH
	 BqMIy7mE4qEFIjBPy8A2wWt1k+fPJmwKptKHRl/eR/unFZD8Z4AUXA9ZuCQroX3PAX
	 JDw2nbG9xSKtfsJRBcWFZxiYKZY7Vb2MPqhWKMPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgAGV1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbgAGU50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:57:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B083D208C4;
        Tue,  7 Jan 2020 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430645;
        bh=hkKkQzKA07HW16eCSUwtMU/boTufp7DhIiDtD6w3ofs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr4NY0L6wvO/OeDilMPXHqquHMKdfcHQVs40KfLVRQ+pgIIr/oS3Y/aDSBMRh011z
         68XROpcTUYhwKiANor3o6EDOgJnJCXxp/4sJ8F8OyRPh8QZsR3KrxfJzpD3bJKHeGq
         NyceCNkgEBZO9CB2PvND8LYK+c4iWdaSnfiBW5sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 037/191] drm/nouveau: Fix drm-core using atomic code-paths on pre-nv50 hardware
Date:   Tue,  7 Jan 2020 21:52:37 +0100
Message-Id: <20200107205334.982535826@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 64d17f25dcad518461ccf0c260544e1e379c5b35 ]

We do not support atomic modesetting on pre-nv50 hardware, but until now
our connector code was setting drm_connector->state on pre-nv50 hardware.

This causes the core to enter atomic modesetting paths in at least:

1. drm_connector_get_encoder(), returning connector->state->best_encoder
which is always 0, causing us to always report 0 as encoder_id in
the drmModeConnector struct returned by drmModeGetConnector().

2. drm_encoder_get_crtc(), returning NULL because uses_atomic get set,
causing us to always report 0 as crtc_id in the drmModeEncoder struct
returned by drmModeGetEncoder()

Which in turn confuses userspace, at least plymouth thinks that the pipe
has changed because of this and tries to reconfigure it unnecessarily.

More in general we should not set drm_connector->state in the non-atomic
code as this violates the drm-core's expectations.

This commit fixes this by using a nouveau_conn_atom struct embedded in the
nouveau_connector struct for property handling in the non-atomic case.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1706557
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 28 +++++++++++++++------
 drivers/gpu/drm/nouveau/nouveau_connector.h |  6 +++++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index a442a955f98c..eb31c5b6c8e9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -245,14 +245,22 @@ nouveau_conn_atomic_duplicate_state(struct drm_connector *connector)
 void
 nouveau_conn_reset(struct drm_connector *connector)
 {
+	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_conn_atom *asyc;
 
-	if (WARN_ON(!(asyc = kzalloc(sizeof(*asyc), GFP_KERNEL))))
-		return;
+	if (drm_drv_uses_atomic_modeset(connector->dev)) {
+		if (WARN_ON(!(asyc = kzalloc(sizeof(*asyc), GFP_KERNEL))))
+			return;
+
+		if (connector->state)
+			nouveau_conn_atomic_destroy_state(connector,
+							  connector->state);
+
+		__drm_atomic_helper_connector_reset(connector, &asyc->state);
+	} else {
+		asyc = &nv_connector->properties_state;
+	}
 
-	if (connector->state)
-		nouveau_conn_atomic_destroy_state(connector, connector->state);
-	__drm_atomic_helper_connector_reset(connector, &asyc->state);
 	asyc->dither.mode = DITHERING_MODE_AUTO;
 	asyc->dither.depth = DITHERING_DEPTH_AUTO;
 	asyc->scaler.mode = DRM_MODE_SCALE_NONE;
@@ -276,8 +284,14 @@ void
 nouveau_conn_attach_properties(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
-	struct nouveau_conn_atom *armc = nouveau_conn_atom(connector->state);
 	struct nouveau_display *disp = nouveau_display(dev);
+	struct nouveau_connector *nv_connector = nouveau_connector(connector);
+	struct nouveau_conn_atom *armc;
+
+	if (drm_drv_uses_atomic_modeset(connector->dev))
+		armc = nouveau_conn_atom(connector->state);
+	else
+		armc = &nv_connector->properties_state;
 
 	/* Init DVI-I specific properties. */
 	if (connector->connector_type == DRM_MODE_CONNECTOR_DVII)
@@ -749,9 +763,9 @@ static int
 nouveau_connector_set_property(struct drm_connector *connector,
 			       struct drm_property *property, uint64_t value)
 {
-	struct nouveau_conn_atom *asyc = nouveau_conn_atom(connector->state);
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_encoder *nv_encoder = nv_connector->detected_encoder;
+	struct nouveau_conn_atom *asyc = &nv_connector->properties_state;
 	struct drm_encoder *encoder = to_drm_encoder(nv_encoder);
 	int ret;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index de9588420884..de84fb4708c7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -118,6 +118,12 @@ struct nouveau_connector {
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_backlight *backlight;
 #endif
+	/*
+	 * Our connector property code expects a nouveau_conn_atom struct
+	 * even on pre-nv50 where we do not support atomic. This embedded
+	 * version gets used in the non atomic modeset case.
+	 */
+	struct nouveau_conn_atom properties_state;
 };
 
 static inline struct nouveau_connector *nouveau_connector(
-- 
2.20.1



