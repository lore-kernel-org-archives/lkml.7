Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BDCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F70208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfF1MGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:06:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53996 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfF1MGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:06:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id DAE3428A3A1
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v4 1/2] drm/vblank: warn on sending stale event
Date:   Fri, 28 Jun 2019 13:05:31 +0100
Message-Id: <66e100219a2740e493a7b96ebb95d0a2e697f121.1561722822.git.bob.beckett@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1561722822.git.bob.beckett@collabora.com>
References: <cover.1561722822.git.bob.beckett@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn when about to send stale vblank info and add advice to
documentation on how to avoid.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/drm_vblank.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 603ab105125d..7dabb2bdb733 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -918,6 +918,19 @@ EXPORT_SYMBOL(drm_crtc_arm_vblank_event);
  *
  * See drm_crtc_arm_vblank_event() for a helper which can be used in certain
  * situation, especially to send out events for atomic commit operations.
+ *
+ * Care should be taken to avoid stale timestamps. If:
+ *   - your driver has vblank support (i.e. dev->num_crtcs > 0)
+ *   - the vblank irq is off (i.e. no one called drm_crtc_vblank_get)
+ *   - from the vblank code's pov the pipe is still running (i.e. not
+ *     in-between a drm_crtc_vblank_off()/on() pair)
+ * If all of these conditions hold then drm_crtc_send_vblank_event is
+ * going to give you a garbage timestamp and and sequence number (the last
+ * recorded before the irq was disabled). If you call drm_crtc_vblank_get/put
+ * around it, or after vblank_off, then either of those will have rolled things
+ * forward for you.
+ * So, drivers should call drm_crtc_vblank_off() before this function in their
+ * crtc atomic_disable handlers.
  */
 void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 				struct drm_pending_vblank_event *e)
@@ -925,8 +938,12 @@ void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 	struct drm_device *dev = crtc->dev;
 	u64 seq;
 	unsigned int pipe = drm_crtc_index(crtc);
+	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 	ktime_t now;
 
+	WARN_ONCE(dev->num_crtcs > 0 && !vblank->enabled && !vblank->inmodeset,
+		  "sending stale vblank info\n");
+
 	if (dev->num_crtcs > 0) {
 		seq = drm_vblank_count_and_time(dev, pipe, &now);
 	} else {
-- 
2.18.0

