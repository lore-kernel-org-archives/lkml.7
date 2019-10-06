Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8685DC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A9E2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfJFK55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:57:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbfJFK55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:57:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 926D158369EC033520F0;
        Sun,  6 Oct 2019 18:57:54 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 18:57:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Anthony.Koo@amd.com>,
        <aric.cyr@amd.com>, <Harmanprit.Tatla@amd.com>,
        <bayan.zabihiyan@amd.com>, <ahmad.othman@amd.com>,
        <Reza.Amini@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable 'core_freesync'
Date:   Sun, 6 Oct 2019 18:57:35 +0800
Message-ID: <20191006105735.60708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

rivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:
 In function mod_freesync_get_settings:
drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:984:24:
 warning: variable core_freesync set but not used [-Wunused-but-set-variable]

It is not used since commit 98e6436d3af5 ("drm/amd/display: Refactor FreeSync module")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 9ce56a8..237dda7 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -981,13 +981,9 @@ void mod_freesync_get_settings(struct mod_freesync *mod_freesync,
 		unsigned int *inserted_frames,
 		unsigned int *inserted_duration_in_us)
 {
-	struct core_freesync *core_freesync = NULL;
-
 	if (mod_freesync == NULL)
 		return;
 
-	core_freesync = MOD_FREESYNC_TO_CORE(mod_freesync);
-
 	if (vrr->supported) {
 		*v_total_min = vrr->adjust.v_total_min;
 		*v_total_max = vrr->adjust.v_total_max;
-- 
2.7.4


