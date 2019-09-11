Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F59DECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3631C21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AdR7PLnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfIKIsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:48:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22350 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726724AbfIKIsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:48:31 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8B8kp03032729;
        Wed, 11 Sep 2019 10:48:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=z6ENkti3uAiwejD5PjtOMXUIXSlg5W0YF9pqxoz3ApI=;
 b=AdR7PLnhq76/wCtudwip3AwQvR6m5lINU6EJdjomYgaYVBQMZ3xrdCBJGzwLkfCBnyrw
 rz3NJh0GHibY8btNQ9xiJ/7CzI7nuHheo28Kg9NHr3awMceHpKcgRT3Ktrg2jQbj3vcG
 igVXtZyrCfHZPO3DWxhh/paMG4m3cCO8DrlzILLedMwdKXR/+oMUJYi1K5HJi5S6yBeI
 oVhfbImIi0hbGnE/56tJ0YUmKAl1qD/PknYe0WhC3FSzRMy+hKwRnqFpsXIj+br0XfCc
 PTyyzPF3h+8bufyOwrcd4wB6WSO2MfAxoJc5ZmQyLv7oGlj535azzuRTYs362fKwsExV vQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uv2aw9qx2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 11 Sep 2019 10:48:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 239E923;
        Wed, 11 Sep 2019 08:48:05 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D7E42B59F2;
        Wed, 11 Sep 2019 10:48:05 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 11 Sep
 2019 10:48:04 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 11 Sep 2019 10:48:03
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <benjamin.gaignard@linaro.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <hwentlan@amd.com>, <manasi.d.navare@intel.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm: fix warnings in DSC
Date:   Wed, 11 Sep 2019 10:47:59 +0200
Message-ID: <20190911084759.6946-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_06:2019-09-10,2019-09-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove always false comparisons due to limited range of nfl_bpg_offset
and scale_increment_interval fields.
Warnings detected when compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/drm_dsc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_dsc.c b/drivers/gpu/drm/drm_dsc.c
index 77f4e5ae4197..27e5c6036658 100644
--- a/drivers/gpu/drm/drm_dsc.c
+++ b/drivers/gpu/drm/drm_dsc.c
@@ -336,12 +336,6 @@ int drm_dsc_compute_rc_parameters(struct drm_dsc_config *vdsc_cfg)
 	else
 		vdsc_cfg->nfl_bpg_offset = 0;
 
-	/* 2^16 - 1 */
-	if (vdsc_cfg->nfl_bpg_offset > 65535) {
-		DRM_DEBUG_KMS("NflBpgOffset is too large for this slice height\n");
-		return -ERANGE;
-	}
-
 	/* Number of groups used to code the entire slice */
 	groups_total = groups_per_line * vdsc_cfg->slice_height;
 
@@ -371,11 +365,6 @@ int drm_dsc_compute_rc_parameters(struct drm_dsc_config *vdsc_cfg)
 		vdsc_cfg->scale_increment_interval = 0;
 	}
 
-	if (vdsc_cfg->scale_increment_interval > 65535) {
-		DRM_DEBUG_KMS("ScaleIncrementInterval is large for slice height\n");
-		return -ERANGE;
-	}
-
 	/*
 	 * DSC spec mentions that bits_per_pixel specifies the target
 	 * bits/pixel (bpp) rate that is used by the encoder,
-- 
2.15.0

