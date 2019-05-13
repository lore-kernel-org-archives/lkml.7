Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2B5C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1D9208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SurjwkHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfEMNPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:15:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:31380 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727747AbfEMNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:15:31 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DDCndD024681;
        Mon, 13 May 2019 15:15:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=z+jHhwBwJ5kIQ/vL9ubJdrHRuDnMR+YPpPiAVmxBKdc=;
 b=SurjwkHWIiIPmx7BHJI1H1JXcGmlUr1FfwyAmMMG6+3nFCzbxK3v6Q0/xWPlo9DWIwxi
 Y5xkj4brF4PVfTyZqGh4kJcDA938QNAV5ii5ud0QFIsleksYQECVRj0+iak9amNTOxDK
 XqsLi5AKlVUPhoaKEYvpNCYKWve6IeOMAEIekWzT6EwnVaMsuxcViwJ+bULzVuIqsyLC
 k2Rik5LIgVGilAams2+uUK/wOatezrSVBmEHLMXWgxHCOHBRzP6wklZyd+Egng6a40yX
 vEFMC02klVKIyEHT8MuewbakJ00aULTDLncv2pFY7mrgeQlJoaTmz6mgcgqUFJWjv4Q/ AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sek5a54b2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 May 2019 15:15:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6BA8A3A;
        Mon, 13 May 2019 13:15:22 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4004B1D84;
        Mon, 13 May 2019 13:15:22 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 May
 2019 15:15:22 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 May 2019 15:15:21
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
Subject: [PATCH v2] drm/stm: ltdc: remove clk_round_rate comment
Date:   Mon, 13 May 2019 15:15:18 +0200
Message-ID: <1557753318-11218-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clk_round_rate returns rounded clock without changing
the hardware in any way.
This function couldn't replace set_rate/get_rate calls.
Todo comment has been removed & a new log inserted.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
Changes in v2:
	- Clk_enable & clk_disable are needed for the SOC STM32F7
	 (not for STM32MP1). I return this part of the patch to make sure the
	 driver is compatible with all SOC STM32.

 drivers/gpu/drm/stm/ltdc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 97912e2..1104e78 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -507,11 +507,6 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
 	int rate = mode->clock * 1000;

-	/*
-	 * TODO clk_round_rate() does not work yet. When ready, it can
-	 * be used instead of clk_set_rate() then clk_get_rate().
-	 */
-
 	clk_disable(ldev->pixel_clk);
 	if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
 		DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate);
@@ -521,6 +516,9 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,

 	adjusted_mode->clock = clk_get_rate(ldev->pixel_clk) / 1000;

+	DRM_DEBUG_DRIVER("requested clock %dkHz, adjusted clock %dkHz\n",
+			 mode->clock, adjusted_mode->clock);
+
 	return true;
 }

--
2.7.4

