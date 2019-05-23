Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E807C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D97F2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfEWUIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:08:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38654 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbfEWUIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:08:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A73DC283E19
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv6 2/4] drm/omap: don't check dispc timings for DSI
Date:   Thu, 23 May 2019 22:07:54 +0200
Message-Id: <20190523200756.25314-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523200756.25314-1-sebastian.reichel@collabora.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While most display types only forward their VM to the DISPC, this
is not true for DSI. DSI calculates the VM for DISPC based on its
own, but it's not identical. Actually the DSI VM is not even a valid
DISPC VM making this check fail. Let's restore the old behaviour
and avoid checking the DISPC VM for DSI here.

Fixes: 7c27fa57ef31 ("drm/omap: Call dispc timings check operation directly")
Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 5a29bf01c0e8..86827a061b0b 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -395,10 +395,20 @@ static enum drm_mode_status omap_crtc_mode_valid(struct drm_crtc *crtc,
 	int r;
 
 	drm_display_mode_to_videomode(mode, &vm);
-	r = priv->dispc_ops->mgr_check_timings(priv->dispc, omap_crtc->channel,
-					       &vm);
-	if (r)
-		return r;
+
+	/*
+	 * DSI might not call this, since the supplied mode is not a
+	 * valid DISPC mode. DSI will calculate and configure the
+	 * proper DISPC mode later.
+	 */
+	if (omap_crtc->pipe->output->next == NULL ||
+	    omap_crtc->pipe->output->next->type != OMAP_DISPLAY_TYPE_DSI) {
+		r = priv->dispc_ops->mgr_check_timings(priv->dispc,
+						       omap_crtc->channel,
+						       &vm);
+		if (r)
+			return r;
+	}
 
 	/* Check for bandwidth limit */
 	if (priv->max_bandwidth) {
-- 
2.20.1

