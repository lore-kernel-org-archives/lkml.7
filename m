Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6CAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C702070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wQcFB9Lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfK0KXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:23:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50896 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbfK0KXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:23:49 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARAMdUZ021243;
        Wed, 27 Nov 2019 11:23:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=JJSf8q2JoRexvh5kfOMyzAlAfib54Yh6pgtrZwuFoHs=;
 b=wQcFB9Lm+wS2aIK88V+NQ7mmLRFme4CfBdWQgIrLQdVZ4rPoqIufIkbgpJF4FKdBlDvO
 hj+RQCTLCfeUC3mfAMy0DYu/wGGjrnw+/BEN1m3EO815nBrNWxllwlAAreYqvQ2fvbF/
 M6NHkILX6jN4hJH29UYsZ4jyZelHzZ4LOFFC8AEgLuKJHr3pH/z1OUzUmUd/ZDDw9ysW
 b8C6DuFiOat5k7L5a7vEZQFOPpClz6C5p4WJESDjGxtLTnFhPUvb7YY0YWD1ho2zwDx/
 UEkPA7d1TXCzz7sSafh9LrZDGCy9/jjLtnhG6pRbP7S+fPrH1HY3JxthNCdG8aIic4VP ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxyb0n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 11:23:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C9AC810002A;
        Wed, 27 Nov 2019 11:23:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 233552B1214;
        Wed, 27 Nov 2019 11:23:40 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov 2019 11:23:39
 +0100
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: ltdc: move pinctrl to encoder mode set
Date:   Wed, 27 Nov 2019 11:23:38 +0100
Message-ID: <1574850218-13257-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

The pin control must be set to default as soon as possible to
establish a good video link between tv & bridge hdmi
(encoder mode set is call before encoder enable).

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 49ef406..dba8e7f 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -435,9 +435,6 @@ static void ltdc_crtc_atomic_enable(struct drm_crtc *crtc,
 	/* Commit shadow registers = update planes at next vblank */
 	reg_set(ldev->regs, LTDC_SRCR, SRCR_VBR);
 
-	/* Enable LTDC */
-	reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
-
 	drm_crtc_vblank_on(crtc);
 }
 
@@ -451,9 +448,6 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	drm_crtc_vblank_off(crtc);
 
-	/* disable LTDC */
-	reg_clear(ldev->regs, LTDC_GCR, GCR_LTDCEN);
-
 	/* disable IRQ */
 	reg_clear(ldev->regs, LTDC_IER, IER_RRIE | IER_FUIE | IER_TERRIE);
 
@@ -1042,9 +1036,13 @@ static const struct drm_encoder_funcs ltdc_encoder_funcs = {
 static void ltdc_encoder_disable(struct drm_encoder *encoder)
 {
 	struct drm_device *ddev = encoder->dev;
+	struct ltdc_device *ldev = ddev->dev_private;
 
 	DRM_DEBUG_DRIVER("\n");
 
+	/* Disable LTDC */
+	reg_clear(ldev->regs, LTDC_GCR, GCR_LTDCEN);
+
 	/* Set to sleep state the pinctrl whatever type of encoder */
 	pinctrl_pm_select_sleep_state(ddev->dev);
 }
@@ -1052,6 +1050,19 @@ static void ltdc_encoder_disable(struct drm_encoder *encoder)
 static void ltdc_encoder_enable(struct drm_encoder *encoder)
 {
 	struct drm_device *ddev = encoder->dev;
+	struct ltdc_device *ldev = ddev->dev_private;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	/* Enable LTDC */
+	reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
+}
+
+static void ltdc_encoder_mode_set(struct drm_encoder *encoder,
+				  struct drm_display_mode *mode,
+				  struct drm_display_mode *adjusted_mode)
+{
+	struct drm_device *ddev = encoder->dev;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -1067,6 +1078,7 @@ static void ltdc_encoder_enable(struct drm_encoder *encoder)
 static const struct drm_encoder_helper_funcs ltdc_encoder_helper_funcs = {
 	.disable = ltdc_encoder_disable,
 	.enable = ltdc_encoder_enable,
+	.mode_set = ltdc_encoder_mode_set,
 };
 
 static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
-- 
2.7.4

