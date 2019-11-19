Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CC0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C36622304
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="eM/jA03T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfKSNfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:35:54 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62308 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfKSNfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:35:53 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJDSoBs024969;
        Tue, 19 Nov 2019 14:34:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=iRVctjJDP4VsySTwcBDAz4gTqwDw4MWcibi48UpEjC8=;
 b=eM/jA03T0mUh0nUcKYMA7qjZdWuCbnQtsSm0RJ08xgdmGPjThBTi6jqfITX0vednD69s
 wcRW5Fx9fQGaOmJ+DuOBa9RBS1+xIU5hSk3jeT9bCSBP335SLzae/FcbCvgkQjFkGpWy
 sr02JbnfMJdQK801CqUaKzy4DjdV33ZAAR/IldJWRLhLon7E0MkDV2N8vZcjm3M+fv50
 tVuf/fQSeAMbc5CQy37AlFRvfA2xhe6E36SEQYqOeTaozgYbGmw2+Niz55VDYf1KDlmQ
 tDCcjUPIp19Ifc/ygTCmrq/sDmN7VMgwhRFb5I5EakJ0Z9VEmK7cQZ8KiSH/+pgUkV4b rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9uhyj70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 14:34:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09FB410002A;
        Tue, 19 Nov 2019 14:34:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ECEE92BC103;
        Tue, 19 Nov 2019 14:34:37 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Nov 2019 14:34:37
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm/rect: remove useless call to clamp_t
Date:   Tue, 19 Nov 2019 14:34:35 +0100
Message-ID: <20191119133435.22525-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_04:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clamping a value between INT_MIN and INT_MAX always return the value itself
and generate warnings when compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/drm_rect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_rect.c b/drivers/gpu/drm/drm_rect.c
index b8363aaa9032..681f1fd09357 100644
--- a/drivers/gpu/drm/drm_rect.c
+++ b/drivers/gpu/drm/drm_rect.c
@@ -89,7 +89,7 @@ bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
 		u32 new_src_w = clip_scaled(drm_rect_width(src),
 					    drm_rect_width(dst), diff);
 
-		src->x1 = clamp_t(int64_t, src->x2 - new_src_w, INT_MIN, INT_MAX);
+		src->x1 = src->x2 - new_src_w;
 		dst->x1 = clip->x1;
 	}
 	diff = clip->y1 - dst->y1;
@@ -97,7 +97,7 @@ bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
 		u32 new_src_h = clip_scaled(drm_rect_height(src),
 					    drm_rect_height(dst), diff);
 
-		src->y1 = clamp_t(int64_t, src->y2 - new_src_h, INT_MIN, INT_MAX);
+		src->y1 = src->y2 - new_src_h;
 		dst->y1 = clip->y1;
 	}
 	diff = dst->x2 - clip->x2;
@@ -105,7 +105,7 @@ bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
 		u32 new_src_w = clip_scaled(drm_rect_width(src),
 					    drm_rect_width(dst), diff);
 
-		src->x2 = clamp_t(int64_t, src->x1 + new_src_w, INT_MIN, INT_MAX);
+		src->x2 = src->x1 + new_src_w;
 		dst->x2 = clip->x2;
 	}
 	diff = dst->y2 - clip->y2;
@@ -113,7 +113,7 @@ bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
 		u32 new_src_h = clip_scaled(drm_rect_height(src),
 					    drm_rect_height(dst), diff);
 
-		src->y2 = clamp_t(int64_t, src->y1 + new_src_h, INT_MIN, INT_MAX);
+		src->y2 = src->y1 + new_src_h;
 		dst->y2 = clip->y2;
 	}
 
-- 
2.15.0

