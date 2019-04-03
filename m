Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04430C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C755221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDCJYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:24:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22852 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfDCJYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:24:30 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x339L3vM025652;
        Wed, 3 Apr 2019 11:24:19 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgmx2wjn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 11:24:19 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12A0434;
        Wed,  3 Apr 2019 09:24:19 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4BB71AE1;
        Wed,  3 Apr 2019 09:24:18 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019
 11:24:19 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 11:24:18
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
Subject: [PATCH] drm/stm: ltdc: reset controller to avoid partial refresh
Date:   Wed, 3 Apr 2019 11:24:13 +0200
Message-ID: <1554283453-2879-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display controller reset must be done as soon as possible after enable
the clock to avoid partial refresh on screen.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 32fd6a3..7bbe61c 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1134,6 +1134,12 @@ int ltdc_load(struct drm_device *ddev)
 		return -ENODEV;
 	}
 
+	if (!IS_ERR(rstc)) {
+		reset_control_assert(rstc);
+		usleep_range(10, 20);
+		reset_control_deassert(rstc);
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ldev->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ldev->regs)) {
@@ -1156,12 +1162,6 @@ int ltdc_load(struct drm_device *ddev)
 		}
 	}
 
-	if (!IS_ERR(rstc)) {
-		reset_control_assert(rstc);
-		usleep_range(10, 20);
-		reset_control_deassert(rstc);
-	}
-
 	/* Disable interrupts */
 	reg_clear(ldev->regs, LTDC_IER,
 		  IER_LIE | IER_RRIE | IER_FUIE | IER_TERRIE);
-- 
2.7.4

