Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA1DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76552064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCSQgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:36:39 -0400
Received: from sauhun.de ([88.99.104.3]:46106 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfCSQgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:36:36 -0400
Received: from localhost (p5486CE21.dip0.t-ipconnect.de [84.134.206.33])
        by pokefinder.org (Postfix) with ESMTPSA id ADD814A1348;
        Tue, 19 Mar 2019 17:36:33 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/omap: simplify getting .driver_data
Date:   Tue, 19 Mar 2019 17:36:29 +0100
Message-Id: <20190319163629.30660-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190319163629.30660-1-wsa+renesas@sang-engineering.com>
References: <20190319163629.30660-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 29692a5217c5..88d4b0c60689 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -412,8 +412,7 @@ static const struct backlight_ops dsicm_bl_ops = {
 static ssize_t dsicm_num_errors_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->dssdev.src;
 	u8 errors = 0;
 	int r;
@@ -444,8 +443,7 @@ static ssize_t dsicm_num_errors_show(struct device *dev,
 static ssize_t dsicm_hw_revision_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->dssdev.src;
 	u8 id1, id2, id3;
 	int r;
@@ -476,8 +474,7 @@ static ssize_t dsicm_store_ulps(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->dssdev.src;
 	unsigned long t;
 	int r;
@@ -511,8 +508,7 @@ static ssize_t dsicm_show_ulps(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	unsigned int t;
 
 	mutex_lock(&ddata->lock);
@@ -526,8 +522,7 @@ static ssize_t dsicm_store_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->dssdev.src;
 	unsigned long t;
 	int r;
@@ -558,8 +553,7 @@ static ssize_t dsicm_show_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	unsigned int t;
 
 	mutex_lock(&ddata->lock);
-- 
2.11.0

