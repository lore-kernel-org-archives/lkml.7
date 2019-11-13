Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3758C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64EA21783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKMMh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:37:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727073AbfKMMhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:37:24 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D8149C0EE21B8436B52B;
        Wed, 13 Nov 2019 20:37:20 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 20:37:12 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <Felix.Kuehling@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <Rex.Zhu@amd.com>,
        <evan.quan@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 7/7] drm/amd/powerplay: remove set but not used variable 'us_mvdd'
Date:   Wed, 13 Nov 2019 20:44:34 +0800
Message-ID: <1573649074-72589-8-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c: In
function ‘vegam_populate_smc_acpi_level’:
drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c:1117:11:
warning: variable 'us_mvdd' set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Fixes: ac7822b0026f ("drm/amd/powerplay: add smumgr support for VEGAM (v2)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index ae18fbc..2068eb0 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1114,7 +1114,6 @@ static int vegam_populate_smc_acpi_level(struct pp_hwmgr *hwmgr,
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	SMIO_Pattern vol_level;
 	uint32_t mvdd;
-	uint16_t us_mvdd;
 
 	table->ACPILevel.Flags &= ~PPSMC_SWSTATE_FLAG_DC;
 
@@ -1168,17 +1167,6 @@ static int vegam_populate_smc_acpi_level(struct pp_hwmgr *hwmgr,
 			"in Clock Dependency Table",
 			);
 
-	us_mvdd = 0;
-	if ((SMU7_VOLTAGE_CONTROL_NONE == data->mvdd_control) ||
-			(data->mclk_dpm_key_disabled))
-		us_mvdd = data->vbios_boot_state.mvdd_bootup_value;
-	else {
-		if (!vegam_populate_mvdd_value(hwmgr,
-				data->dpm_table.mclk_table.dpm_levels[0].value,
-				&vol_level))
-			us_mvdd = vol_level.Voltage;
-	}
-
 	if (!vegam_populate_mvdd_value(hwmgr, 0, &vol_level))
 		table->MemoryACPILevel.MinMvdd = PP_HOST_TO_SMC_UL(vol_level.Voltage);
 	else
-- 
2.7.4

