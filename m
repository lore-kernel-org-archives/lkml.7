Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2100FC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E203E2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfHUARH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfHUARH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:17:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61D37308427D;
        Wed, 21 Aug 2019 00:17:06 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74B8460BF3;
        Wed, 21 Aug 2019 00:17:02 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: Bump encoder limit from 32 to 64
Date:   Tue, 20 Aug 2019 20:16:55 -0400
Message-Id: <20190821001656.32577-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 21 Aug 2019 00:17:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming that GPUs would never have even close to 32 separate video
encoders is quite honestly a pretty reasonable assumption. Unfortunately
we do not live in a reasonable world, as it looks like it is actually
possible to find devices that will create more drm_encoder objects then
this. Case in point: the ThinkPad P71's discrete GPU, which exposes 1
eDP port and 5 DP ports. On the P71, nouveau attempts to create one
encoder for the eDP port, and two encoders for each DP++/USB-C port
along with 4 MST encoders for each DP port. This comes out to 35
different encoders. Unfortunately, this can't really be optimized to
make less encoders either.

So, what if we bumped the limit to 64? Unfortunately this has one very
awkward drawback: we already expose 32-bit bitmasks for encoders to
userspace in drm_encoder->possible_clones. Yikes. While cloning is still
(rarely) used in certain modern video hardware, it's mostly used in
situations where memory bandwidth is so limited that it's not possible
to scan out from 2 CRTCs at once.

So, let's try to compromise here: allow encoders with indexes <32 to
have non-zero values in drm_encoder->possible_clones, and don't allow
encoders with higher indexes to set drm_encoder->possible_clones to a
non-zero value. This allows us to avoid breaking UAPI and keep things
working sanely for hardware which still uses cloning, while still being
able to bump up the encoder limit.

This also fixes driver probing for nouveau on the ThinkPad P71.

Changes since v1:
* Move index+possible_clones check out of drm_encoder_init() and into
  drm_encoder_register_all(), since encoder->possible_clones can get
  changed any time before registration - Daniel Vetter
* Update the commit message a bit to accurately reflect modern day usage
  of hardware cloning, which as Daniel Stone pointed out is apparently a
  thing

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org
---
 drivers/gpu/drm/drm_atomic.c  |  2 +-
 drivers/gpu/drm/drm_encoder.c | 12 ++++++++++--
 include/drm/drm_crtc.h        |  2 +-
 include/drm/drm_encoder.h     | 20 +++++++++++++++-----
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 419381abbdd1..27ce988ef0cc 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -392,7 +392,7 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
 	drm_printf(p, "\tcolor_mgmt_changed=%d\n", state->color_mgmt_changed);
 	drm_printf(p, "\tplane_mask=%x\n", state->plane_mask);
 	drm_printf(p, "\tconnector_mask=%x\n", state->connector_mask);
-	drm_printf(p, "\tencoder_mask=%x\n", state->encoder_mask);
+	drm_printf(p, "\tencoder_mask=%llx\n", state->encoder_mask);
 	drm_printf(p, "\tmode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state->mode));
 
 	if (crtc->funcs->atomic_print_state)
diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 7fb47b7b8b44..9d443b45ebba 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -71,6 +71,14 @@ int drm_encoder_register_all(struct drm_device *dev)
 	int ret = 0;
 
 	drm_for_each_encoder(encoder, dev) {
+		/*
+		 * Since possible_clones has been exposed to userspace as a
+		 * 32bit bitmask, we don't allow creating encoders with an
+		 * index >=32 which are capable of cloning
+		 */
+		if (WARN_ON(encoder->index >= 32 && encoder->possible_clones))
+			return -EINVAL;
+
 		if (encoder->funcs->late_register)
 			ret = encoder->funcs->late_register(encoder);
 		if (ret)
@@ -112,8 +120,8 @@ int drm_encoder_init(struct drm_device *dev,
 {
 	int ret;
 
-	/* encoder index is used with 32bit bitmasks */
-	if (WARN_ON(dev->mode_config.num_encoder >= 32))
+	/* encoder index is used with 64bit bitmasks */
+	if (WARN_ON(dev->mode_config.num_encoder >= 64))
 		return -EINVAL;
 
 	ret = drm_mode_object_add(dev, &encoder->base, DRM_MODE_OBJECT_ENCODER);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 7d14c11bdc0a..fd0b2438c3d5 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -210,7 +210,7 @@ struct drm_crtc_state {
 	 * @encoder_mask: Bitmask of drm_encoder_mask(encoder) of encoders
 	 * attached to this CRTC.
 	 */
-	u32 encoder_mask;
+	u64 encoder_mask;
 
 	/**
 	 * @adjusted_mode:
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 70cfca03d812..3f9cb65694e1 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -159,7 +159,15 @@ struct drm_encoder {
 	 * encoders can be used in a cloned configuration, they both should have
 	 * each another bits set.
 	 *
-	 * In reality almost every driver gets this wrong.
+	 * In reality almost every driver gets this wrong, and most modern
+	 * display hardware does not have support for cloning. As well, while we
+	 * expose this mask to userspace as 32bits long, we do sure purely to
+	 * avoid breaking pre-existing UAPI since the limitation on the number
+	 * of encoders has been increased from 32 bits to 64 bits. In order to
+	 * maintain functionality for drivers which do actually support cloning,
+	 * we only allow cloning with encoders that have an index <32. Encoders
+	 * with indexes higher than 32 are not allowed to specify a non-zero
+	 * value here.
 	 *
 	 * Note that since encoder objects can't be hotplugged the assigned indices
 	 * are stable and hence known before registering all objects.
@@ -198,13 +206,15 @@ static inline unsigned int drm_encoder_index(const struct drm_encoder *encoder)
 }
 
 /**
- * drm_encoder_mask - find the mask of a registered ENCODER
+ * drm_encoder_mask - find the mask of a registered encoder
  * @encoder: encoder to find mask for
  *
- * Given a registered encoder, return the mask bit of that encoder for an
- * encoder's possible_clones field.
+ * Returns:
+ * A bit mask with the nth bit set, where n is the index of the encoder. Take
+ * care when using this, as the DRM UAPI only allows for 32 bit encoder masks
+ * while internally encoder masks are 64 bits.
  */
-static inline u32 drm_encoder_mask(const struct drm_encoder *encoder)
+static inline u64 drm_encoder_mask(const struct drm_encoder *encoder)
 {
 	return 1 << drm_encoder_index(encoder);
 }
-- 
2.21.0

