Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A020BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73486217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfCONqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:46:39 -0400
Received: from mail.utcluj.ro ([193.226.5.35]:45650 "EHLO mail.utcluj.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfCONqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:46:39 -0400
Received: from helios.el.el.obs.utcluj.ro (helios.el.obs.utcluj.ro [193.226.6.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gabil)
        by mail.utcluj.ro (Postfix) with ESMTPSA id 11942A8A;
        Fri, 15 Mar 2019 15:46:35 +0200 (EET)
From:   Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
Cc:     Gabriel Lazar <gabriel.lazar@com.utcluj.ro>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel-orientation-quirks: Add rotation quirk for Myria MY8307
Date:   Fri, 15 Mar 2019 15:46:07 +0200
Message-Id: <20190315134606.27746-1-gabriel.lazar@com.utcluj.ro>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rotation quirk for the Myria MY8307 2-in-1 laptop.

Signed-off-by: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 52e445bb1aa5..9887f9b1ac07 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -80,6 +80,12 @@ static const struct drm_dmi_panel_orientation_data lcd800x1280_rightside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data myria_my8307 = {
+	.width = 800,
+	.height = 1280,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct dmi_system_id orientation_data[] = {
 	{	/* Acer One 10 (S1003) */
 		.matches = {
@@ -148,6 +154,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* Myria MY8307 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MY8307"),
+		},
+		.driver_data = (void *)&myria_my8307,
 	}, {	/* VIOS LTH17 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
-- 
2.21.0

