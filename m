Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB2C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AD52081B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfI3W2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:28:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60272 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfI3W2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:28:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id BE02D283C0F
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH v3 1/5] Revert "drm/rockchip: Use drm_atomic_helper_commit_tail_rpm"
Date:   Mon, 30 Sep 2019 19:27:58 -0300
Message-Id: <20190930222802.32088-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190930222802.32088-1-ezequiel@collabora.com>
References: <20190930222802.32088-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c87fb38df19da3362a0e20df1aad852100995ead,
which conflicts with adding driver-specific behavior in
atomic_commit_tail().

No functional changes expected on this commit, but just preparation
for the upcoming gamma LUT support.

Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
Changes from v2:
* New patch.
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index ca01234c037c..dba352ec0ee3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -105,8 +105,27 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	return ERR_PTR(ret);
 }
 
+static void
+rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
+{
+	struct drm_device *dev = old_state->dev;
+
+	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+
+	drm_atomic_helper_commit_planes(dev, old_state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY);
+
+	drm_atomic_helper_commit_hw_done(old_state);
+
+	drm_atomic_helper_wait_for_vblanks(dev, old_state);
+
+	drm_atomic_helper_cleanup_planes(dev, old_state);
+}
+
 static const struct drm_mode_config_helper_funcs rockchip_mode_config_helpers = {
-	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+	.atomic_commit_tail = rockchip_atomic_helper_commit_tail_rpm,
 };
 
 static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
-- 
2.22.0

