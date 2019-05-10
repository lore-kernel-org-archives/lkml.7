Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F87C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8E2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="y9+Lix1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfEJPDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:03:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28940 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727346AbfEJPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:03:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AErgJP004964;
        Fri, 10 May 2019 17:03:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=WEEddrwDkIHLSmRlPP82HL8Zh6nr2g7bNKK4fLQdDyM=;
 b=y9+Lix1ZuXzL5a9DeIi/XePgAd7t9QEb1DElD58ROp5opc6t8id9Mh3aiFqHrUZRlWCG
 6QoABaK9EwTN9ic6cACvXC9QaBPqrV9c6DKUceqVH7lDJEo0Y6jQln+cWOB6TU+2EQ/g
 e+XkNkYamNYwneMZ4ToZQ/xAFxDVsRc2rjW2P3G9Jdi8Zgkcw0nw9XUqlfdDRtQKDL3U
 Ixyxk2Pn8gKIx29sOeopNOrj/n9sWPlKsw6JiRC6NxnDFj/GhX0YILSYAPyrqVWxVY5s
 5abTGLkevqZn7rnF9pOZksOjcREH2PYxQGj9k3VuUq2TWF1JzOpW6dgkqxJXT3v4VLru NA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sc9s4k49q-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 17:03:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9473F34;
        Fri, 10 May 2019 15:03:08 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7252B2AB8;
        Fri, 10 May 2019 15:03:08 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May
 2019 17:03:08 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May 2019 17:03:07
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
Subject: [PATCH] drm/stm: dsi: check hardware version
Date:   Fri, 10 May 2019 17:02:59 +0200
Message-ID: <1557500579-19720-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check version of DSI hardware IP. Only versions 1.30 & 1.31
are supported.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index 22bd095..29105e9 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -227,7 +227,6 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 	u32 val;
 
 	/* Update lane capabilities according to hw version */
-	dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
 	dsi->lane_min_kbps = LANE_MIN_KBPS;
 	dsi->lane_max_kbps = LANE_MAX_KBPS;
 	if (dsi->hw_version == HWVER_131) {
@@ -306,6 +305,7 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_mipi_dsi_stm *dsi;
+	struct clk *pclk;
 	struct resource *res;
 	int ret;
 
@@ -347,6 +347,28 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 		goto err_clk_get;
 	}
 
+	pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(pclk)) {
+		ret = PTR_ERR(pclk);
+		DRM_ERROR("Unable to get peripheral clock: %d\n", ret);
+		goto err_dsi_probe;
+	}
+
+	ret = clk_prepare_enable(pclk);
+	if (ret) {
+		DRM_ERROR("%s: Failed to enable peripheral clk\n", __func__);
+		goto err_dsi_probe;
+	}
+
+	dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
+	clk_disable_unprepare(pclk);
+
+	if (dsi->hw_version != HWVER_130 && dsi->hw_version != HWVER_131) {
+		ret = -ENODEV;
+		DRM_ERROR("bad dsi hardware version\n");
+		goto err_dsi_probe;
+	}
+
 	dw_mipi_dsi_stm_plat_data.base = dsi->base;
 	dw_mipi_dsi_stm_plat_data.priv_data = dsi;
 
-- 
2.7.4

