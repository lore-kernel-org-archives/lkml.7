Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC03EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9135021925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfCVU4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:56:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726944AbfCVU4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:56:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MKmdJr135252
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:56:22 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rd60ejr8b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:56:22 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <arbab@linux.ibm.com>;
        Fri, 22 Mar 2019 20:56:19 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 20:56:14 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MKuFfo8257776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 20:56:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CDCD6E054;
        Fri, 22 Mar 2019 20:56:15 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FF346E04E;
        Fri, 22 Mar 2019 20:56:15 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.179.210])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 20:56:14 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
        id 9E0A54608B4; Fri, 22 Mar 2019 15:56:13 -0500 (CDT)
From:   Reza Arbab <arbab@linux.ibm.com>
To:     Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Tarasov <tutankhamen@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     wzabolot@elektron.elka.pw.edu.pl, Pavel Machek <pavel@ucw.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH 2/2] drm/fb-helper: Do not scale depth down to 0
Date:   Fri, 22 Mar 2019 15:56:13 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553288173-10845-1-git-send-email-arbab@linux.ibm.com>
References: <1553288173-10845-1-git-send-email-arbab@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032220-8235-0000-0000-00000E7224F5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010796; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01178185; UDB=6.00616394; IPR=6.00958883;
 MB=3.00026116; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-22 20:56:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032220-8236-0000-0000-000044DEC245
Message-Id: <1553288173-10845-3-git-send-email-arbab@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the scaling loop in drm_fb_helper_single_fb_probe() only finds
supported depths greater than what it's looking for, it will set
sizes.surface_depth = 0. This broke my udl device:

[drm] test CRTC 0 primary plane
udl 3-9.1:1.0: drm_fb_helper_single_fb_probe: test CRTC 0 format 0, depth=24
udl 3-9.1:1.0: drm_fb_helper_single_fb_probe: 24 > 16, skipping
udl 3-9.1:1.0: drm_fb_helper_single_fb_probe: test CRTC 0 format 1, depth=32
udl 3-9.1:1.0: drm_fb_helper_single_fb_probe: 32 > 16, skipping
[drm] requested bpp 16, scaled depth down to 0

Instead of setting zero depth, print that scaling was not possible and
do nothing.

Fixes: f4bd542bcaee ("drm/fb-helper: Scale back depth to supported maximum")
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 0e9349ff2d16..a7028655a065 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1963,7 +1963,11 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
 				best_depth = fmt->depth;
 		}
 	}
-	if (sizes.surface_depth != best_depth) {
+
+	if (!best_depth) {
+		DRM_INFO("Could not scale depth to requested bpp %d",
+			 sizes.surface_bpp);
+	} else if (sizes.surface_depth != best_depth) {
 		DRM_INFO("requested bpp %d, scaled depth down to %d",
 			 sizes.surface_bpp, best_depth);
 		sizes.surface_depth = best_depth;
-- 
1.8.3.1

