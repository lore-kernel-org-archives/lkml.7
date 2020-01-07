Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07639C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE50D2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430649;
	bh=l6nEf4vQfBED9d1RXxUJd2BaekDpRFJovsar23ILT6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E70LTNvqgEWGTaQTA2V9Pktr1ffpKZT9KRPo68SZ1b0YhFDLUxtdLR6c/e0g7IVDl
	 NFSgUlFMBLP9l6CvgQaTQ6snWOQ89FLzOQ7hr9svR820BcsNdJBDFM4NZBtO6OAXl5
	 u6vmiPEkL6uvdqzeSmHqAx+CscU/9jKtxTqgJIpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgAGU52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbgAGU5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:57:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E432081E;
        Tue,  7 Jan 2020 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430642;
        bh=l6nEf4vQfBED9d1RXxUJd2BaekDpRFJovsar23ILT6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uww4aU8TMgDOptgcUen4hMeLe+e0Vq/fGbHRtJpQD9W1+doHmjEPPWlyeBucyQX+3
         +TieFEmHNViEXkQOzhWCqTLiTkBs9F7E8kT1fwI+V5L88zHn4eYGFj5bHTszICr0TZ
         OY/5wNK+gix6DwROG75Mwk4R0fj7//Y9+FLyV0OU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 036/191] drm/nouveau: Move the declaration of struct nouveau_conn_atom up a bit
Date:   Tue,  7 Jan 2020 21:52:36 +0100
Message-Id: <20200107205334.929300882@linuxfoundation.org>
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

[ Upstream commit 37a68eab4cd92b507c9e8afd760fdc18e4fecac6 ]

Place the declaration of struct nouveau_conn_atom above that of
struct nouveau_connector. This commit makes no changes to the moved
block what so ever, it just moves it up a bit.

This is a preparation patch to fix some issues with connector handling
on pre nv50 displays (which do not use atomic modesetting).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.h | 110 ++++++++++----------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index f43a8d63aef8..de9588420884 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -29,6 +29,7 @@
 
 #include <nvif/notify.h>
 
+#include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_dp_helper.h>
@@ -44,6 +45,60 @@ struct dcb_output;
 struct nouveau_backlight;
 #endif
 
+#define nouveau_conn_atom(p)                                                   \
+	container_of((p), struct nouveau_conn_atom, state)
+
+struct nouveau_conn_atom {
+	struct drm_connector_state state;
+
+	struct {
+		/* The enum values specifically defined here match nv50/gf119
+		 * hw values, and the code relies on this.
+		 */
+		enum {
+			DITHERING_MODE_OFF = 0x00,
+			DITHERING_MODE_ON = 0x01,
+			DITHERING_MODE_DYNAMIC2X2 = 0x10 | DITHERING_MODE_ON,
+			DITHERING_MODE_STATIC2X2 = 0x18 | DITHERING_MODE_ON,
+			DITHERING_MODE_TEMPORAL = 0x20 | DITHERING_MODE_ON,
+			DITHERING_MODE_AUTO
+		} mode;
+		enum {
+			DITHERING_DEPTH_6BPC = 0x00,
+			DITHERING_DEPTH_8BPC = 0x02,
+			DITHERING_DEPTH_AUTO
+		} depth;
+	} dither;
+
+	struct {
+		int mode;	/* DRM_MODE_SCALE_* */
+		struct {
+			enum {
+				UNDERSCAN_OFF,
+				UNDERSCAN_ON,
+				UNDERSCAN_AUTO,
+			} mode;
+			u32 hborder;
+			u32 vborder;
+		} underscan;
+		bool full;
+	} scaler;
+
+	struct {
+		int color_vibrance;
+		int vibrant_hue;
+	} procamp;
+
+	union {
+		struct {
+			bool dither:1;
+			bool scaler:1;
+			bool procamp:1;
+		};
+		u8 mask;
+	} set;
+};
+
 struct nouveau_connector {
 	struct drm_connector base;
 	enum dcb_connector_type type;
@@ -121,61 +176,6 @@ extern int nouveau_ignorelid;
 extern int nouveau_duallink;
 extern int nouveau_hdmimhz;
 
-#include <drm/drm_crtc.h>
-#define nouveau_conn_atom(p)                                                   \
-	container_of((p), struct nouveau_conn_atom, state)
-
-struct nouveau_conn_atom {
-	struct drm_connector_state state;
-
-	struct {
-		/* The enum values specifically defined here match nv50/gf119
-		 * hw values, and the code relies on this.
-		 */
-		enum {
-			DITHERING_MODE_OFF = 0x00,
-			DITHERING_MODE_ON = 0x01,
-			DITHERING_MODE_DYNAMIC2X2 = 0x10 | DITHERING_MODE_ON,
-			DITHERING_MODE_STATIC2X2 = 0x18 | DITHERING_MODE_ON,
-			DITHERING_MODE_TEMPORAL = 0x20 | DITHERING_MODE_ON,
-			DITHERING_MODE_AUTO
-		} mode;
-		enum {
-			DITHERING_DEPTH_6BPC = 0x00,
-			DITHERING_DEPTH_8BPC = 0x02,
-			DITHERING_DEPTH_AUTO
-		} depth;
-	} dither;
-
-	struct {
-		int mode;	/* DRM_MODE_SCALE_* */
-		struct {
-			enum {
-				UNDERSCAN_OFF,
-				UNDERSCAN_ON,
-				UNDERSCAN_AUTO,
-			} mode;
-			u32 hborder;
-			u32 vborder;
-		} underscan;
-		bool full;
-	} scaler;
-
-	struct {
-		int color_vibrance;
-		int vibrant_hue;
-	} procamp;
-
-	union {
-		struct {
-			bool dither:1;
-			bool scaler:1;
-			bool procamp:1;
-		};
-		u8 mask;
-	} set;
-};
-
 void nouveau_conn_attach_properties(struct drm_connector *);
 void nouveau_conn_reset(struct drm_connector *);
 struct drm_connector_state *
-- 
2.20.1



