Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A22C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE05207FA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfKFGkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:40:43 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:26927 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728724AbfKFGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:40:42 -0500
X-UUID: 78686ba0df8a4be7b48ecccce2e7562e-20191106
X-UUID: 78686ba0df8a4be7b48ecccce2e7562e-20191106
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1127936845; Wed, 06 Nov 2019 14:40:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Nov
 2019 14:40:22 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 6 Nov 2019 14:40:21 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        CK Hu <ck.hu@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>, <sj.huang@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH] drm/panel: seperate panel power control from panel prepare/unprepare
Date:   Wed, 6 Nov 2019 14:40:05 +0800
Message-ID: <20191106064005.8016-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 224C4AAF48E6FE1BCE1C6862644246DA71F19843E559249984CDFA4CC65D93E32000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dsi panels require the dsi lanes keeping low before panel power
on. So seperate the panel power control and the communication with panel.

And put the power control in drm_panel_prepare_power and
drm_panel_unprepare_power. Put the communication with panel in
drm_panel_prepare and drm_panel_unprepare.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/drm_panel.c | 38 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_panel.h     | 17 +++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 6b0bf42039cf..e57f6385d2cc 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -131,6 +131,24 @@ void drm_panel_detach(struct drm_panel *panel)
 }
 EXPORT_SYMBOL(drm_panel_detach);
 
+/**
+ * drm_panel_prepare_power - power on a panel's power
+ * @panel: DRM panel
+ *
+ * Calling this function will enable power and deassert any reset signals to
+ * the panel.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int drm_panel_prepare_power(struct drm_panel *panel)
+{
+	if (panel && panel->funcs && panel->funcs->prepare_power)
+		return panel->funcs->prepare_power(panel);
+
+	return panel ? -ENOSYS : -EINVAL;
+}
+EXPORT_SYMBOL(drm_panel_prepare_power);
+
 /**
  * drm_panel_prepare - power on a panel
  * @panel: DRM panel
@@ -170,6 +188,26 @@ int drm_panel_unprepare(struct drm_panel *panel)
 }
 EXPORT_SYMBOL(drm_panel_unprepare);
 
+/**
+ * drm_panel_unprepare_power - power off a panel
+ * @panel: DRM panel
+ *
+ * Calling this function will completely power off a panel (assert the panel's
+ * reset, turn off power supplies, ...). After this function has completed, it
+ * is usually no longer possible to communicate with the panel until another
+ * call to drm_panel_prepare_power and drm_panel_prepare().
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int drm_panel_unprepare_power(struct drm_panel *panel)
+{
+	if (panel && panel->funcs && panel->funcs->unprepare_power)
+		return panel->funcs->unprepare_power(panel);
+
+	return panel ? -ENOSYS : -EINVAL;
+}
+EXPORT_SYMBOL(drm_panel_unprepare_power);
+
 /**
  * drm_panel_enable - enable a panel
  * @panel: DRM panel
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 624bd15ecfab..0d8c4855405c 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -61,6 +61,13 @@ struct display_timing;
  * the panel. This is the job of the .unprepare() function.
  */
 struct drm_panel_funcs {
+	/**
+	 * @prepare_power:
+	 *
+	 * Turn on panel power.
+	 */
+	int (*prepare_power)(struct drm_panel *panel);
+
 	/**
 	 * @prepare:
 	 *
@@ -89,6 +96,13 @@ struct drm_panel_funcs {
 	 */
 	int (*unprepare)(struct drm_panel *panel);
 
+	/**
+	 * @unprepare_power:
+	 *
+	 * Turn off panel_power.
+	 */
+	int (*unprepare_power)(struct drm_panel *panel);
+
 	/**
 	 * @get_modes:
 	 *
@@ -155,6 +169,9 @@ void drm_panel_remove(struct drm_panel *panel);
 int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector);
 void drm_panel_detach(struct drm_panel *panel);
 
+int drm_panel_prepare_power(struct drm_panel *panel);
+int drm_panel_unprepare_power(struct drm_panel *panel);
+
 int drm_panel_prepare(struct drm_panel *panel);
 int drm_panel_unprepare(struct drm_panel *panel);
 
-- 
2.21.0

