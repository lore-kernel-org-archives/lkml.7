Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAD7C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1382133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ulVHYNCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfE0KWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:22:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8820 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725858AbfE0KWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:22:16 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RAGcSe031336;
        Mon, 27 May 2019 12:21:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=STMicroelectronics;
 bh=K9MPddInRylWsZUKTiMMozhp1doQ8Ls5xxWg0TmbCm0=;
 b=ulVHYNCWpNB/fmvKmxz1BPx6VyZtV6zgHD6llj10aA0P4+8hLCp+5s5tR86b2ITOfLdX
 +d8IbtKqMp2+0HDyn8JKXrtes1np928OvwMtOG4GgWsfC7Y+KvTrj5y+ktExn62V8bNf
 wmH6NK2YiaKzVFREdamSbTbiCJMIJzOvsIeqRCjolGpwcQJ4CiotjC0a/ugjwyLpsaRj
 OdxEobI8380pMauJ6Sec2UhcD2T3H0wgYLppei5lW2K1wRjO5wgASVXO2n6YJRk5BnKf
 kf3NPWCNB8HdCTIFmGFg8s+lqyv9IMC+m7Hyp8IQTUMs6a1CHonpSEyw9HLapDyVGtY3 ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sptu9jjhh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 May 2019 12:21:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A3C7E34;
        Mon, 27 May 2019 10:21:47 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78BE32804;
        Mon, 27 May 2019 10:21:47 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May
 2019 12:21:47 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May 2019 12:21:46
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
Subject: [PATCH v1 1/2] drm/bridge/synopsys: dsi: add power on/off optional phy ops
Date:   Mon, 27 May 2019 12:21:38 +0200
Message-ID: <1558952499-15418-2-git-send-email-yannick.fertre@st.com>
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

Add power on & off optional physical operation functions, helpful to
program specific registers of the DSI physical part.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 8 ++++++++
 include/drm/bridge/dw_mipi_dsi.h              | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index e915ae8..5bb676f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -775,6 +775,10 @@ static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
 static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
 {
 	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
+	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
+
+	if (phy_ops->power_off)
+		phy_ops->power_off(dsi->plat_data->priv_data);
 
 	/*
 	 * Switch to command mode before panel-bridge post_disable &
@@ -874,11 +878,15 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
 static void dw_mipi_dsi_bridge_enable(struct drm_bridge *bridge)
 {
 	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
+	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
 
 	/* Switch to video mode for panel-bridge enable & panel enable */
 	dw_mipi_dsi_set_mode(dsi, MIPI_DSI_MODE_VIDEO);
 	if (dsi->slave)
 		dw_mipi_dsi_set_mode(dsi->slave, MIPI_DSI_MODE_VIDEO);
+
+	if (phy_ops->power_on)
+		phy_ops->power_on(dsi->plat_data->priv_data);
 }
 
 static enum drm_mode_status
diff --git a/include/drm/bridge/dw_mipi_dsi.h b/include/drm/bridge/dw_mipi_dsi.h
index 7d3dd69..df6eda6 100644
--- a/include/drm/bridge/dw_mipi_dsi.h
+++ b/include/drm/bridge/dw_mipi_dsi.h
@@ -14,6 +14,8 @@ struct dw_mipi_dsi;
 
 struct dw_mipi_dsi_phy_ops {
 	int (*init)(void *priv_data);
+	void (*power_on)(void *priv_data);
+	void (*power_off)(void *priv_data);
 	int (*get_lane_mbps)(void *priv_data,
 			     const struct drm_display_mode *mode,
 			     unsigned long mode_flags, u32 lanes, u32 format,
-- 
2.7.4

