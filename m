Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4822EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1594B21873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfCUIHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:07:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21786 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727823AbfCUIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:07:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2L83pwd030010;
        Thu, 21 Mar 2019 09:07:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r8q5bmbye-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Mar 2019 09:07:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96DC63D;
        Thu, 21 Mar 2019 08:07:35 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C010324AD;
        Thu, 21 Mar 2019 08:07:34 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Mar
 2019 09:07:34 +0100
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Thu, 21 Mar 2019 09:07:34
 +0100
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] drm/panel: otm8009a: set clock to 29.70 Mhz
Date:   Thu, 21 Mar 2019 09:07:26 +0100
Message-ID: <1553155646-13636-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel does not support clock frequency over 30.74 Mhz.
The clock rate has been reduced to 29.70 Mhz & new timings have
been computed to get a framerate of 50fps.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 87fa316..f715bbe 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -67,15 +67,15 @@ struct otm8009a {
 };
 
 static const struct drm_display_mode default_mode = {
-	.clock = 32729,
+	.clock = 29700,
 	.hdisplay = 480,
-	.hsync_start = 480 + 120,
-	.hsync_end = 480 + 120 + 63,
-	.htotal = 480 + 120 + 63 + 120,
+	.hsync_start = 480 + 98,
+	.hsync_end = 480 + 98 + 32,
+	.htotal = 480 + 98 + 32 + 98,
 	.vdisplay = 800,
-	.vsync_start = 800 + 12,
-	.vsync_end = 800 + 12 + 12,
-	.vtotal = 800 + 12 + 12 + 12,
+	.vsync_start = 800 + 15,
+	.vsync_end = 800 + 15 + 10,
+	.vtotal = 800 + 15 + 10 + 14,
 	.vrefresh = 50,
 	.flags = 0,
 	.width_mm = 52,
-- 
2.7.4

