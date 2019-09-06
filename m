Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A9BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26322082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="LilT1R8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391231AbfIFJWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:22:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50618 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbfIFJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:22:45 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x869M3lL025630;
        Fri, 6 Sep 2019 11:22:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=z4f+K9FCvLJRtiC5DZZCJIIPbU+tClnqdagLmTLqx60=;
 b=LilT1R8twNVz2da+lQrKhR+6yGfpSLuCH65T3knsZqFV7MlC+TGFu9Z5eEAlhplhVyfB
 gP1/+wreD6EQzFgZ0075c+A+u2CQXtixqgoMwH6qClCBFidJExhBq7tFkUUj+5RMIyZ6
 Y3TbGiyV8iovbT+OD9BEMxvYY/ZDzjhMYzsn5bpQjAf5t+rRMr1HTe64oNb6zjEWXAJr
 ke9rUXOBngCqDLHb3/neaEC0pqO/d6YW94IQ0vpXi4e6ZHxBwwpvfvdQ7/IsEkC/HsSg
 c+j4HP/Y/uRx6FzlSv26FQcTstzzZsXjVddePSR6wxP4QyNnMzTTT2awiqywguRo9Quo FQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uqec3e3w0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Sep 2019 11:22:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 84EF452;
        Fri,  6 Sep 2019 09:22:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C4082C7C1C;
        Fri,  6 Sep 2019 11:22:22 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Sep 2019
 11:22:22 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Sep 2019 11:22:21
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: ltdc: add pinctrl for DPI encoder mode
Date:   Fri, 6 Sep 2019 11:21:48 +0200
Message-ID: <1567761708-31777-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-06_04:2019-09-04,2019-09-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of functions encoder_enable and encoder_disable
make possible to control the pinctrl according to the encoder type.
The pinctrl must be activated only if the encoder type is DPI.
This helps to move the DPI-related pinctrl configuration from
all the panel or bridge to the LTDC dt node.

Reviewed-by: Philippe Cornu <philippe.cornu@st.com>

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 3ab4fbf..1c4fde0 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -1040,6 +1041,36 @@ static const struct drm_encoder_funcs ltdc_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
+static void ltdc_encoder_disable(struct drm_encoder *encoder)
+{
+	struct drm_device *ddev = encoder->dev;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	/* Set to sleep state the pinctrl whatever type of encoder */
+	pinctrl_pm_select_sleep_state(ddev->dev);
+}
+
+static void ltdc_encoder_enable(struct drm_encoder *encoder)
+{
+	struct drm_device *ddev = encoder->dev;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	/*
+	 * Set to default state the pinctrl only with DPI type.
+	 * Others types like DSI, don't need pinctrl due to
+	 * internal bridge (the signals do not come out of the chipset).
+	 */
+	if (encoder->encoder_type == DRM_MODE_ENCODER_DPI)
+		pinctrl_pm_select_default_state(ddev->dev);
+}
+
+static const struct drm_encoder_helper_funcs ltdc_encoder_helper_funcs = {
+	.disable = ltdc_encoder_disable,
+	.enable = ltdc_encoder_enable,
+};
+
 static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
 {
 	struct drm_encoder *encoder;
@@ -1055,6 +1086,8 @@ static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
 	drm_encoder_init(ddev, encoder, &ltdc_encoder_funcs,
 			 DRM_MODE_ENCODER_DPI, NULL);
 
+	drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
+
 	ret = drm_bridge_attach(encoder, bridge, NULL);
 	if (ret) {
 		drm_encoder_cleanup(encoder);
@@ -1280,6 +1313,8 @@ int ltdc_load(struct drm_device *ddev)
 
 	clk_disable_unprepare(ldev->pixel_clk);
 
+	pinctrl_pm_select_sleep_state(ddev->dev);
+
 	pm_runtime_enable(ddev->dev);
 
 	return 0;
-- 
2.7.4

