Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68C7214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tg2zDJoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfE0L6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:58:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23442 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbfE0L6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:58:50 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RBqHta004118;
        Mon, 27 May 2019 13:58:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=CHNiLECO7COJeJykJENYiJJ3vrh3cyTCAguGAsVnNK8=;
 b=tg2zDJoONVSJEtDceghChtbL1O2vw81Tyd4NdODekOXiJzVpk2S/HtQ51BLR+lPFK8W8
 1yEOdH+MMu7kjaFpNVrBCOonUMEH6uS1ZeLgYr2keJZlGnKfR530U17kWDkTRAgkfw7t
 i0YsN4zStVhAbPiDFefzLknaw3G1DbBwxiS/OetzihCaIraCIpmMwlvrZ07HkrdhKn/N
 uU26gPuiccaXbcCRq/+xxq152uiZYl63BJtp7ShiUtErfPXC7SIQ2gtegYyxmUL4bg5R
 HmYYjXp06iCTa5NzTp0+1bnjZ9aJWEJLgkf+PodDjij2fyY0S5NnhR9Y8CVLmbsFaN+j 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sptu9k0sp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 May 2019 13:58:37 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E78138;
        Mon, 27 May 2019 11:58:35 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2CF622A01;
        Mon, 27 May 2019 11:58:35 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May
 2019 13:58:34 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May 2019 13:58:34
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <yannick.fertre@st.com>, <philippe.cornu@st.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <alexandre.torgue@st.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH] drm/stm: ltdc: restore calls to clk_{enable/disable}
Date:   Mon, 27 May 2019 13:58:30 +0200
Message-ID: <20190527115830.15836-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Restore calls to clk_{enable/disable} deleted after applying the wrong
version of the patch

Fixes: fd6905fca4f0 ("drm/stm: ltdc: remove clk_round_rate comment")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/stm/ltdc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index ae2aaf2a62ee..ac29890edeb6 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -507,10 +507,12 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
 	int rate = mode->clock * 1000;
 
+	clk_disable(ldev->pixel_clk);
 	if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
 		DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate);
 		return false;
 	}
+	clk_enable(ldev->pixel_clk);
 
 	adjusted_mode->clock = clk_get_rate(ldev->pixel_clk) / 1000;
 
-- 
2.15.0

