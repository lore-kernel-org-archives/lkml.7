Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F94C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F612133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gvnKygsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfE0KW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:22:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8766 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbfE0KWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:22:25 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RAGcSf031336;
        Mon, 27 May 2019 12:21:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=STMicroelectronics;
 bh=wps+SDKyn14/sTW3Eret7RKWvrgnINJUAp0gJ+ptxDk=;
 b=gvnKygsUyE2/7zsLmyK3byjlXUl15AlFFGnZXXay4/tht9zRv0eFUjQgboXgGkVkG6Ju
 h6ku6Z4gIaLCcqeKKfwVIPusDk/0Oy3k+890b3+4a4eN6K/7Wa9E6UX937/Jk0ASBT28
 GIsazNr4pqEgE5PqEB56/cMIKYtdOV2AP+YzakDwVLsDTBBc0d1tmcSwc43jyCFgGZ45
 UuyhgsE9EvSEnT6EvTr4+zJYzQl6Z1n2kVnBN4V/LMmptiT7oARZ9K6focryReCaPmPt
 GNzKaHf/PobBU0uG+2eq0wsvL/C9U6wYA74KR82gQQe4LI8RRhCOwuLAjD1kKNDzKcD1 uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sptu9jjhj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 May 2019 12:21:49 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C31B531;
        Mon, 27 May 2019 10:21:48 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89C692805;
        Mon, 27 May 2019 10:21:48 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May
 2019 12:21:48 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May 2019 12:21:48
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] drm/stm: dsi: add power on/off phy ops
Date:   Mon, 27 May 2019 12:21:39 +0200
Message-ID: <1558952499-15418-3-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558952499-15418-1-git-send-email-yannick.fertre@st.com>
References: <1558952499-15418-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These new physical operations are helpful to power_on/off the dsi
wrapper. If the dsi wrapper is powered in video mode, the display
controller (ltdc) register access will hang when DSI fifos are full.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index 01db020..0ab32fe 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -210,10 +210,27 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 	if (ret)
 		DRM_DEBUG_DRIVER("!TIMEOUT! waiting PLL, let's continue\n");
 
+	return 0;
+}
+
+static void dw_mipi_dsi_phy_power_on(void *priv_data)
+{
+	struct dw_mipi_dsi_stm *dsi = priv_data;
+
+	DRM_DEBUG_DRIVER("\n");
+
 	/* Enable the DSI wrapper */
 	dsi_set(dsi, DSI_WCR, WCR_DSIEN);
+}
 
-	return 0;
+static void dw_mipi_dsi_phy_power_off(void *priv_data)
+{
+	struct dw_mipi_dsi_stm *dsi = priv_data;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	/* Disable the DSI wrapper */
+	dsi_clear(dsi, DSI_WCR, WCR_DSIEN);
 }
 
 static int
@@ -287,6 +304,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_stm_phy_ops = {
 	.init = dw_mipi_dsi_phy_init,
+	.power_on = dw_mipi_dsi_phy_power_on,
+	.power_off = dw_mipi_dsi_phy_power_off,
 	.get_lane_mbps = dw_mipi_dsi_get_lane_mbps,
 };
 
-- 
2.7.4

