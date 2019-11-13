Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ECAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887B721783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfKMMhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:37:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbfKMMhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:37:23 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BF5C8BCE6318978C209D;
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
Subject: [PATCH 6/7] drm/amd/powerplay: remove set but not used variable 'state'
Date:   Wed, 13 Nov 2019 20:44:33 +0800
Message-ID: <1573649074-72589-7-git-send-email-yukuai3@huawei.com>
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

drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c: In
function ‘fiji_populate_memory_timing_parameters’:
drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c:1504:8:
warning: variable ‘state’ set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Fixes: 2e112b4ae3ba ("drm/amd/pp: remove fiji_smc/smumgr split.")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index c3df3a3..32ebb38 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -1499,7 +1499,7 @@ static int fiji_populate_memory_timing_parameters(struct pp_hwmgr *hwmgr,
 	uint32_t dram_timing;
 	uint32_t dram_timing2;
 	uint32_t burstTime;
-	ULONG state, trrds, trrdl;
+	ULONG trrds, trrdl;
 	int result;
 
 	result = atomctrl_set_engine_dram_timings_rv770(hwmgr,
@@ -1511,7 +1511,6 @@ static int fiji_populate_memory_timing_parameters(struct pp_hwmgr *hwmgr,
 	dram_timing2 = cgs_read_register(hwmgr->device, mmMC_ARB_DRAM_TIMING2);
 	burstTime = cgs_read_register(hwmgr->device, mmMC_ARB_BURST_TIME);
 
-	state = PHM_GET_FIELD(burstTime, MC_ARB_BURST_TIME, STATE0);
 	trrds = PHM_GET_FIELD(burstTime, MC_ARB_BURST_TIME, TRRDS0);
 	trrdl = PHM_GET_FIELD(burstTime, MC_ARB_BURST_TIME, TRRDL0);
 
-- 
2.7.4

