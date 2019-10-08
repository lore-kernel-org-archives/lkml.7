Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E6FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B926C206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jp/vqwuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfJHMnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:43:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9640 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730371AbfJHMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:43:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x98CefEN020734;
        Tue, 8 Oct 2019 14:43:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=CYU1xh4x/15+0eiT1SpidubsI6JpkOmwy2DOuRIf9xs=;
 b=jp/vqwuDHm2N7FaOW7AyrwvRExI9ccdYVx9S5lKIOv957wQT7S14Gb2SHMQNmH7hAWuO
 9IYvQdW2zYVaOtu0KERNG4ViqiPZ3LTEwnFVbdF4/qy1n4OUwmj3u7I9lULufQS6qW1N
 ONbYEJwX8jJ46nJC033d2Ur8pM4JIU8KV7OuNB+zi/gnLs1nz6RvDmjaBMBaLRDiAyMW
 tz4rJMJCEseuGRqfz7rK1zx0S5vXR7v09UFBB6RtiGMS8wESapKLJVe5I0aTbleH6oP7
 WFNNEnz0QWGQN47NQMzwsz/iVhzjDcUjPJrlK7beZg2dCBCM+0MyTrSDvGZkH8QsTBnT tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn0r90j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 14:43:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B1EB4100034;
        Tue,  8 Oct 2019 14:43:06 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A61C2BC16D;
        Tue,  8 Oct 2019 14:43:06 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 14:43:06 +0200
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019 14:43:06
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <ville.syrjala@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2] drm: atomic helper: fix W=1 warnings
Date:   Tue, 8 Oct 2019 14:42:54 +0200
Message-ID: <20191008124254.2144-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_05:2019-10-08,2019-10-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few for_each macro set variables that are never used later which led
to generate unused-but-set-variable warnings.
Add (void)(foo) inside the macros to remove these warnings

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 include/drm/drm_atomic.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 927e1205d7aa..b6c73fd9f55a 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -693,6 +693,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
 			     (old_connector_state) = (__state)->connectors[__i].old_state,	\
 			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
 
@@ -714,6 +715,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
 			     (old_connector_state) = (__state)->connectors[__i].old_state, 1))
 
 /**
@@ -734,7 +736,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)								\
 		for_each_if ((__state)->connectors[__i].ptr &&			\
 			     ((connector) = (__state)->connectors[__i].ptr,	\
-			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
+			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
+			     (new_connector_state) = (__state)->connectors[__i].new_state, \
+			     (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic update
@@ -754,7 +758,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) = (__state)->crtcs[__i].ptr,	\
+			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
 			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
+			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
 			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
 
 /**
@@ -793,7 +799,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->crtcs[__i].ptr &&		\
 			     ((crtc) = (__state)->crtcs[__i].ptr,	\
-			     (new_crtc_state) = (__state)->crtcs[__i].new_state, 1))
+			     (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
+			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
+			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update
@@ -813,6 +821,7 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
 			      (old_plane_state) = (__state)->planes[__i].old_state,\
 			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
 
@@ -873,7 +882,9 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
-			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			      (new_plane_state) = (__state)->planes[__i].new_state, \
+			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_private_obj_in_state - iterate over all private objects in an atomic update
-- 
2.15.0

