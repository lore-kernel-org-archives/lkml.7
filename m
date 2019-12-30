Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B2AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D8A207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfL3Cse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:48:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbfL3Cse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 21:48:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2B288AE7A05B411EE62;
        Mon, 30 Dec 2019 10:48:31 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 10:48:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <sam@ravnborg.org>, <alexander.deucher@amd.com>,
        <jani.nikula@intel.com>, <harry.wentland@amd.com>,
        <yuehaibing@huawei.com>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/nouveau/nv04: Use match_string() helper to simplify the code
Date:   Mon, 30 Dec 2019 10:46:28 +0800
Message-ID: <20191230024628.11820-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the array index of a matching string.
Use it instead of the open-coded implementation.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 03466f0..3a9489e 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -644,16 +644,13 @@ static int nv17_tv_create_resources(struct drm_encoder *encoder,
 	int i;
 
 	if (nouveau_tv_norm) {
-		for (i = 0; i < num_tv_norms; i++) {
-			if (!strcmp(nv17_tv_norm_names[i], nouveau_tv_norm)) {
-				tv_enc->tv_norm = i;
-				break;
-			}
-		}
-
-		if (i == num_tv_norms)
+		i = match_string(nv17_tv_norm_names, num_tv_norms,
+				 nouveau_tv_norm);
+		if (i < 0)
 			NV_WARN(drm, "Invalid TV norm setting \"%s\"\n",
 				nouveau_tv_norm);
+		else
+			tv_enc->tv_norm = i;
 	}
 
 	drm_mode_create_tv_properties(dev, num_tv_norms, nv17_tv_norm_names);
-- 
2.7.4


