Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B43C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC421222DD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="GNRcnyYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfKSK6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:58:11 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33178 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbfKSK6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:58:11 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJAvCZN016187;
        Tue, 19 Nov 2019 11:57:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=YvffzZ2WCYrAd1ijoI8QfGwR+7dHh9PU6TpCOdbzZ+o=;
 b=GNRcnyYKd16YMcP14gpYDJUQaUuLsq6OHINHs5OTyyBYczRg+c75sZKQBK1/Oev6Fj+S
 PTyeKQv/uFxawvWCYgVSEj1aGipjPd+ShsPt9fb6HNtkZKXumnd2yPZiXEFOaspky6GT
 oQrU0c3AIZls6RkuVlp05RKkaZo5332/4iJ7xz/6jWAukKfuP5tJcpWnQsdDwaXXw65w
 BT9q476Nbikc/gW6OBr0q0KS1Hboc1/4ZTMBQpgNR3wvYP7hlKjj40JF8az/K4SqSyeE
 65Rub0pOsnnMrjKl6UKp2VOYkwOK5V/fF74SgAb3HNcTV23fHvdtv8v3VBJZd6jv6n+1 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9uv748a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 11:57:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F2B04100038;
        Tue, 19 Nov 2019 11:57:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C0A1E2B41BE;
        Tue, 19 Nov 2019 11:57:55 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Nov 2019 11:57:55
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm/fb-cma-helpers: Fix include issue
Date:   Tue, 19 Nov 2019 11:57:53 +0100
Message-ID: <20191119105753.32363-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_03:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exported functions prototypes are missing in drm_fb_cma_helper.c
Include drm_fb_cma_helper to fix that issue.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/drm_fb_cma_helper.c | 1 +
 include/drm/drm_fb_cma_helper.h     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index c0b0f603af63..9801c0333eca 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -9,6 +9,7 @@
  *  Copyright (C) 2012 Red Hat
  */
 
+#include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_cma_helper.h>
diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
index 4becb09975a4..795aea1d0a25 100644
--- a/include/drm/drm_fb_cma_helper.h
+++ b/include/drm/drm_fb_cma_helper.h
@@ -2,6 +2,8 @@
 #ifndef __DRM_FB_CMA_HELPER_H__
 #define __DRM_FB_CMA_HELPER_H__
 
+#include <linux/types.h>
+
 struct drm_framebuffer;
 struct drm_plane_state;
 
-- 
2.15.0

