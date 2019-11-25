Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E07207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfKYO7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:59:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728196AbfKYO7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:59:01 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F06DE5FD51FD902D2374;
        Mon, 25 Nov 2019 22:58:56 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 25 Nov 2019
 22:58:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <evan.quan@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <Prike.Liang@amd.com>,
        <yuehaibing@huawei.com>, <chenwandun@huawei.com>,
        <yukuai3@huawei.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/amd/powerplay: remove set but not used variable 'stretch_amount2'
Date:   Mon, 25 Nov 2019 22:58:43 +0800
Message-ID: <20191125145843.15764-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:
 In function vegam_populate_clock_stretcher_data_table:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1489:29:
 warning: variable stretch_amount2 set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 50896e9..b0e0d67 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1486,7 +1486,7 @@ static int vegam_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
 	struct vegam_smumgr *smu_data =
 			(struct vegam_smumgr *)(hwmgr->smu_backend);
 
-	uint8_t i, stretch_amount, stretch_amount2, volt_offset = 0;
+	uint8_t i, stretch_amount, volt_offset = 0;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	struct phm_ppt_v1_clock_voltage_dependency_table *sclk_table =
@@ -1525,11 +1525,9 @@ static int vegam_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
 			(table_info->cac_dtp_table->ucCKS_LDO_REFSEL != 0) ?
 			table_info->cac_dtp_table->ucCKS_LDO_REFSEL : 5;
 	/* Populate CKS Lookup Table */
-	if (stretch_amount == 1 || stretch_amount == 2 || stretch_amount == 5)
-		stretch_amount2 = 0;
-	else if (stretch_amount == 3 || stretch_amount == 4)
-		stretch_amount2 = 1;
-	else {
+	if (!(stretch_amount == 1 || stretch_amount == 2 ||
+	      stretch_amount == 5 || stretch_amount == 3 ||
+	      stretch_amount == 4)) {
 		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
 				PHM_PlatformCaps_ClockStretcher);
 		PP_ASSERT_WITH_CODE(false,
-- 
2.7.4


