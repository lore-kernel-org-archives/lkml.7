Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89546C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C9E2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKVXEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:04:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43639 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:04:12 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iYHyB-0007vO-EP; Fri, 22 Nov 2019 23:04:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: remove redundant assignment to variables HiSidd and LoSidd
Date:   Fri, 22 Nov 2019 23:04:07 +0000
Message-Id: <20191122230407.109636-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variables HiSidd and LoSidd are being initialized with values that
are never read and are being updated a little later with a new value.
The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 15590fd86ef4..868e2d5f6e62 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -653,8 +653,8 @@ static int ci_min_max_v_gnbl_pm_lid_from_bapm_vddc(struct pp_hwmgr *hwmgr)
 static int ci_populate_bapm_vddc_base_leakage_sidd(struct pp_hwmgr *hwmgr)
 {
 	struct ci_smumgr *smu_data = (struct ci_smumgr *)(hwmgr->smu_backend);
-	uint16_t HiSidd = smu_data->power_tune_table.BapmVddCBaseLeakageHiSidd;
-	uint16_t LoSidd = smu_data->power_tune_table.BapmVddCBaseLeakageLoSidd;
+	uint16_t HiSidd;
+	uint16_t LoSidd;
 	struct phm_cac_tdp_table *cac_table = hwmgr->dyn_state.cac_dtp_table;
 
 	HiSidd = (uint16_t)(cac_table->usHighCACLeakage / 100 * 256);
-- 
2.24.0

