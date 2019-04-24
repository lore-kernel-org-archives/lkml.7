Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7868C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F0A218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="llnf21ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfDXOD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:03:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27056 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbfDXOD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:03:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OE30lm030064;
        Wed, 24 Apr 2019 16:03:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=VPpkj27FkT2JUmw5i0uH5uPvA33C/SMpLxZt5wiIQkg=;
 b=llnf21raHPAq3DyDEMy1zurdauq92Ht7y7MTdhLO/yNV4wIfgx8Jcffc2S8oESnwzYi6
 oO6fBaHYyh/H6tFK65Urcy5+zrl3vg4kxXwcIR8jUCmzEExRmw6pzK01Dcuk7cHDiyGd
 TFtw6w4IBcAYm+3i5dxOJVkfWrdk70LwQ3SK9MBuLE2dl2VHKbji/FCos+pllx+7oIqs
 pSnjjxW6SlB6xGQF0GBD/oE6jikMJbtVBnd1zVsSf2I8Znrm6e1fWij8G9O+QirEoq8k
 SbGv46x4iORFV+UVF8vVwepkSf9tyb9tgDILHRGj8z5Sqv1PkhFXgdc0YSBJVBcyC7W6 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ryrj67cbs-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 16:03:41 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B59AA34;
        Wed, 24 Apr 2019 14:03:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9B44C2730;
        Wed, 24 Apr 2019 14:03:31 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 16:03:31 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 16:03:31
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH 2/2] drm/stm: ltdc: return appropriate error code during probe
Date:   Wed, 24 Apr 2019 16:03:21 +0200
Message-ID: <1556114601-30936-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
References: <1556114601-30936-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, return the "clk_get" error value instead of -ENODEV.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 521ba83..97912e2 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1145,8 +1145,9 @@ int ltdc_load(struct drm_device *ddev)
 
 	ldev->pixel_clk = devm_clk_get(dev, "lcd");
 	if (IS_ERR(ldev->pixel_clk)) {
-		DRM_ERROR("Unable to get lcd clock\n");
-		return -ENODEV;
+		if (PTR_ERR(ldev->pixel_clk) != -EPROBE_DEFER)
+			DRM_ERROR("Unable to get lcd clock\n");
+		return PTR_ERR(ldev->pixel_clk);
 	}
 
 	if (clk_prepare_enable(ldev->pixel_clk)) {
-- 
2.7.4

