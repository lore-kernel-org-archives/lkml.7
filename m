Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72D4C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B3521479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="DxjeenHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfILI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:57:16 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8194 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbfILI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:57:16 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8C8u6xt002413;
        Thu, 12 Sep 2019 10:56:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=hC/Ep7sILGc8IpTJGW+E2kTEYIt84RL/dPIXG9oXwF0=;
 b=DxjeenHlDwZIXSKz4Z4Cj9H1cpx4vn5MQKPwyPNsHrltd/aGq+o1yO8tGnckqJRC1rQT
 TTPOBEn7Xm3/pY0nTQv62iCWyOKOPdXagbxmaGYUTGLFXVJRr9J745Yf0T8YzhMgvxIj
 Egqir2G8pxnZajnCAKontJPhtgQ3bODtPj0En19MSxqkZnR62OROnca6RjLlA+wST1Kv
 0+UXJgXGPswnPexcPT76AarTnogHSI0AsJoVVCIZICvYkoaPww4Pbdl2oNvga7B66J5P
 5HaDRbiCk1h77MaWfvXvtIl9nPZnpZLMtIg/C1rvoSeOq5j8JYibDjDUguNOPx5DkzdF YA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uv2awg4hb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Sep 2019 10:56:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C5C2A53;
        Thu, 12 Sep 2019 08:56:46 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1BA12B841B;
        Thu, 12 Sep 2019 10:56:45 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 12 Sep
 2019 10:56:45 +0200
Received: from localhost (10.201.23.97) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 12 Sep 2019 10:56:45
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
Subject: [PATCH] drm/stm: dsi: higher pll out only in video burst mode
Date:   Thu, 12 Sep 2019 10:56:29 +0200
Message-ID: <1568278589-20400-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_04:2019-09-11,2019-09-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to better support video non-burst modes,
the +20% on pll out is added only in burst mode.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
Reviewed-by: Yannick FERTRE <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index a03a642..514efef 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -260,8 +260,11 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 	/* Compute requested pll out */
 	bpp = mipi_dsi_pixel_format_to_bpp(format);
 	pll_out_khz = mode->clock * bpp / lanes;
+
 	/* Add 20% to pll out to be higher than pixel bw (burst mode only) */
-	pll_out_khz = (pll_out_khz * 12) / 10;
+	if (mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		pll_out_khz = (pll_out_khz * 12) / 10;
+
 	if (pll_out_khz > dsi->lane_max_kbps) {
 		pll_out_khz = dsi->lane_max_kbps;
 		DRM_WARN("Warning max phy mbps is used\n");
-- 
2.7.4

