Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628BCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0AF20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfDWHkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:40:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbfDWHkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D7FAB462534D3D17ABC7;
        Tue, 23 Apr 2019 15:40:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH next 06/25] drm/omap: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:01 +0800
Message-ID: <20190423075020.173734-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 .../gpu/drm/omapdrm/displays/panel-dsi-cm.c    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 741a5e324767..913e8291a917 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -410,8 +410,7 @@ static const struct backlight_ops dsicm_bl_ops = {
 static ssize_t dsicm_num_errors_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->src;
 	u8 errors = 0;
 	int r;
@@ -442,8 +441,7 @@ static ssize_t dsicm_num_errors_show(struct device *dev,
 static ssize_t dsicm_hw_revision_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->src;
 	u8 id1, id2, id3;
 	int r;
@@ -474,8 +472,7 @@ static ssize_t dsicm_store_ulps(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->src;
 	unsigned long t;
 	int r;
@@ -509,8 +506,7 @@ static ssize_t dsicm_show_ulps(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	unsigned int t;
 
 	mutex_lock(&ddata->lock);
@@ -524,8 +520,7 @@ static ssize_t dsicm_store_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *src = ddata->src;
 	unsigned long t;
 	int r;
@@ -556,8 +551,7 @@ static ssize_t dsicm_show_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	unsigned int t;
 
 	mutex_lock(&ddata->lock);
-- 
2.20.1

