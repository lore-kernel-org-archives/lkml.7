Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857BBC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6316920835
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfIZWwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfIZWwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:52:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC6FF796ED;
        Thu, 26 Sep 2019 22:52:19 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C54DA600C1;
        Thu, 26 Sep 2019 22:52:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] drm/encoder: WARN() when adding/removing encoders after device registration
Date:   Thu, 26 Sep 2019 18:51:08 -0400
Message-Id: <20190926225122.31455-7-lyude@redhat.com>
In-Reply-To: <20190926225122.31455-1-lyude@redhat.com>
References: <20190926225122.31455-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 26 Sep 2019 22:52:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out that we don't actually check this anywhere, and additionally
actually forget to even mention this in our documentation.

Since we've had one driver making this mistake already, let's clarify
this by mentioning this limitation in the kernel docs. Additionally, for
drivers not using the legacy ->load/->unload() hooks (which make it
impossible to create all encoders before registration): print a big
warning when drm_encoder_init() is called after device registration, or
when drm_encoder_cleanup() is called before device unregistration.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_encoder.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 80d88a55302e..5c5e40aafa4e 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -99,9 +99,12 @@ void drm_encoder_unregister_all(struct drm_device *dev)
  * @encoder_type: user visible type of the encoder
  * @name: printf style format string for the encoder name, or NULL for default name
  *
- * Initialises a preallocated encoder. Encoder should be subclassed as part of
- * driver encoder objects. At driver unload time drm_encoder_cleanup() should be
- * called from the driver's &drm_encoder_funcs.destroy hook.
+ * Initialises a preallocated encoder. The encoder should be subclassed as
+ * part of driver encoder objects. This function may not be called after the
+ * device is registered with drm_dev_register().
+ *
+ * At driver unload time drm_encoder_cleanup() must be called from the
+ * driver's &drm_encoder_funcs.destroy hook.
  *
  * Returns:
  * Zero on success, error code on failure.
@@ -117,6 +120,14 @@ int drm_encoder_init(struct drm_device *dev,
 	if (WARN_ON(dev->mode_config.num_encoder >= 32))
 		return -EINVAL;
 
+	/*
+	 * Encoders should never be added after device registration, with the
+	 * exception of drivers using the legacy load/unload callbacks where
+	 * it's impossible to create encoders beforehand. Such drivers should
+	 * convert to using drm_dev_register() and friends.
+	 */
+	WARN_ON(dev->registered && !dev->driver->load);
+
 	ret = drm_mode_object_add(dev, &encoder->base, DRM_MODE_OBJECT_ENCODER);
 	if (ret)
 		return ret;
@@ -155,16 +166,22 @@ EXPORT_SYMBOL(drm_encoder_init);
  * drm_encoder_cleanup - cleans up an initialised encoder
  * @encoder: encoder to cleanup
  *
- * Cleans up the encoder but doesn't free the object.
+ * Cleans up the encoder but doesn't free the object. This function may not be
+ * called until the respective &struct drm_device has been unregistered from
+ * userspace using drm_dev_unregister().
  */
 void drm_encoder_cleanup(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
 
-	/* Note that the encoder_list is considered to be static; should we
-	 * remove the drm_encoder at runtime we would have to decrement all
-	 * the indices on the drm_encoder after us in the encoder_list.
+	/*
+	 * Encoders should never be removed after device registration, with
+	 * the exception of drivers using the legacy load/unload callbacks
+	 * where it's impossible to remove encoders until after
+	 * deregistration. Such drivers should convert to using
+	 * drm_dev_register() and friends.
 	 */
+	WARN_ON(dev->registered && !dev->driver->unload);
 
 	if (encoder->bridge) {
 		struct drm_bridge *bridge = encoder->bridge;
-- 
2.21.0

