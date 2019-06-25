Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10225C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA9520883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbfFYSCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:02:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfFYSCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:02:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 8D2A6286276
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v3 3/4] drm/vblank: estimate vblank while disabling vblank if interrupt disabled
Date:   Tue, 25 Jun 2019 18:59:14 +0100
Message-Id: <b96132cef4b63118df1026a99b3c345692e3de26.1561483965.git.bob.beckett@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1561483965.git.bob.beckett@collabora.com>
References: <cover.1561483965.git.bob.beckett@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If interrupts are disabled (e.g. via vblank_disable_fn) and we come to
disable vblank, update the vblank count to best guess as to what it
would be had the interrupts remained enabled, and update the timesamp to
now.

This avoids a stale vblank event being sent while disabling crtcs during
atomic modeset.

Fixes: 68036b08b91bc ("drm/vblank: Do not update vblank count if interrupts
are already disabled.")

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/drm_vblank.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 7dabb2bdb733..db68b8cbf797 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -375,9 +375,23 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe)
 	 * interrupts were enabled. This avoids calling the ->disable_vblank()
 	 * operation in atomic context with the hardware potentially runtime
 	 * suspended.
+	 * If interrupts are disabled (e.g. via blank_disable_fn) then make
+	 * best guess as to what it would be now and make sure we have an up
+	 * to date timestamp.
 	 */
-	if (!vblank->enabled)
+	if (!vblank->enabled) {
+		ktime_t now = ktime_get();
+		u32 diff = 0;
+		if (vblank->framedur_ns) {
+			u64 diff_ns = ktime_to_ns(ktime_sub(now, vblank->time));
+			diff = DIV_ROUND_CLOSEST_ULL(diff_ns,
+						     vblank->framedur_ns);
+		}
+
+		store_vblank(dev, pipe, diff, now, vblank->count);
+
 		goto out;
+	}
 
 	/*
 	 * Update the count and timestamp to maintain the
-- 
2.18.0

