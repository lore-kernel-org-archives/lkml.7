Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4605EC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9CB27D8F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ejkUkIvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfFCIcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:32:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52080 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfFCIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:32:03 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x538VI0P012223;
        Mon, 3 Jun 2019 10:31:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=E3rVaIy9kAIHI7M+214fHf8F4WB/bpg155JaSxbNFQ4=;
 b=ejkUkIvy9/n+XTOUFTHEic+5n733rjUac84ytlorYMH7sM9c1SEGoeE2tPPOaQQvObQD
 yKHW5phkhg3z/KcLKjHRxkL/a2TdIbUrf4s6fNWDUlYF2S/IksOnpjntbXPr+2J4THPh
 uwgX+OYSxOJrOde0FoQ11zD/sLBEgVriYtokLX1paw6Hn+A+yx363N61csMOvWb4d9lM
 0RC+r0JlSGZdwKRl6/TH+1121ZGTsAZETdNgu0ghxisDXIazS9WH3mLmX+n6VRk/1Qe2
 irMiT/VcNhhl9zeQweWl0/93PFNZ00UNPG5PDYzG2K/h8s8Ll/YlRpW4FoXXa3I7mT80 Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sundrs730-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Jun 2019 10:31:49 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F2F8931;
        Mon,  3 Jun 2019 08:31:45 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE3CF2514;
        Mon,  3 Jun 2019 08:31:45 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 10:31:45 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019 10:31:45
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
Subject: [PATCH] drm/stm: ltdc: No message if probe
Date:   Mon, 3 Jun 2019 10:31:34 +0200
Message-ID: <1559550694-14042-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print display controller hardware version in debug mode only.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index a40870b..2fe6c4a 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1229,7 +1229,7 @@ int ltdc_load(struct drm_device *ddev)
 		goto err;
 	}
 
-	DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_version);
+	DRM_DEBUG_DRIVER("ltdc hw version 0x%08x\n", ldev->caps.hw_version);
 
 	/* Add endpoints panels or bridges if any */
 	for (i = 0; i < MAX_ENDPOINTS; i++) {
-- 
2.7.4

