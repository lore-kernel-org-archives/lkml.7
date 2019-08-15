Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D122C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D48821783
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfHOLFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:05:17 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:24976 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727814AbfHOLFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:05:16 -0400
X-IronPort-AV: E=Sophos;i="5.64,388,1559487600"; 
   d="scan'208";a="24088309"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Aug 2019 20:05:15 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id F1625417763E;
        Thu, 15 Aug 2019 20:05:09 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v2 5/9] drm/panel: Add timings field to drm_panel
Date:   Thu, 15 Aug 2019 12:04:29 +0100
Message-Id: <1565867073-24746-6-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565867073-24746-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1565867073-24746-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to know if the panel supports dual-link, similarly
to bridges, therefore add a reference to drm_timings in
drm_panel.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* new patch

 include/drm/drm_panel.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 8c738c0..cd6ff07 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -26,6 +26,7 @@
 
 #include <linux/errno.h>
 #include <linux/list.h>
+#include <drm/drm_timings.h>
 
 struct device_node;
 struct drm_connector;
@@ -81,6 +82,7 @@ struct drm_panel_funcs {
  * struct drm_panel - DRM panel object
  * @drm: DRM device owning the panel
  * @connector: DRM connector that the panel is attached to
+ * @timings: timing information
  * @dev: parent device of the panel
  * @link: link from panel device (supplier) to DRM device (consumer)
  * @funcs: operations that can be performed on the panel
@@ -89,6 +91,7 @@ struct drm_panel_funcs {
 struct drm_panel {
 	struct drm_device *drm;
 	struct drm_connector *connector;
+	const struct drm_timings *timings;
 	struct device *dev;
 
 	const struct drm_panel_funcs *funcs;
-- 
2.7.4

