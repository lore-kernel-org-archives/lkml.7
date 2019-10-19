Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1510BCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 03:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C00222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 03:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfJSDRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 23:17:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51536 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbfJSDR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 23:17:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 42DCD11FC222B208D682;
        Sat, 19 Oct 2019 11:17:27 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 19 Oct 2019 11:17:21 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <Bhawanpreet.Lakha@amd.com>,
        <David.Francis@amd.com>, <Tony.Cheng@amd.com>,
        <abdoulaye.berthe@amd.com>, <Thomas.Lim@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] drm/amd/display: remove gcc warning Wunused-but-set-variable
Date:   Sat, 19 Oct 2019 11:23:51 +0800
Message-ID: <1571455431-104881-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenwandun <chenwandun@huawei.com>

drivers/gpu/drm/amd/display/dc/dce/dce_aux.c: In function dce_aux_configure_timeout:
drivers/gpu/drm/amd/display/dc/dce/dce_aux.c: warning: variable timeout set but not used [-Wunused-but-set-variable]

Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 976bd49..739f8e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -432,7 +432,6 @@ static bool dce_aux_configure_timeout(struct ddc_service *ddc,
 {
 	uint32_t multiplier = 0;
 	uint32_t length = 0;
-	uint32_t timeout = 0;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 	struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
 	struct aux_engine_dce110 *aux110 = FROM_AUX_ENGINE(aux_engine);
@@ -446,25 +445,21 @@ static bool dce_aux_configure_timeout(struct ddc_service *ddc,
 		length = timeout_in_us/TIME_OUT_MULTIPLIER_8;
 		if (timeout_in_us % TIME_OUT_MULTIPLIER_8 != 0)
 			length++;
-		timeout = length * TIME_OUT_MULTIPLIER_8;
 	} else if (timeout_in_us <= 2 * TIME_OUT_INCREMENT) {
 		multiplier = 1;
 		length = timeout_in_us/TIME_OUT_MULTIPLIER_16;
 		if (timeout_in_us % TIME_OUT_MULTIPLIER_16 != 0)
 			length++;
-		timeout = length * TIME_OUT_MULTIPLIER_16;
 	} else if (timeout_in_us <= 4 * TIME_OUT_INCREMENT) {
 		multiplier = 2;
 		length = timeout_in_us/TIME_OUT_MULTIPLIER_32;
 		if (timeout_in_us % TIME_OUT_MULTIPLIER_32 != 0)
 			length++;
-		timeout = length * TIME_OUT_MULTIPLIER_32;
 	} else if (timeout_in_us > 4 * TIME_OUT_INCREMENT) {
 		multiplier = 3;
 		length = timeout_in_us/TIME_OUT_MULTIPLIER_64;
 		if (timeout_in_us % TIME_OUT_MULTIPLIER_64 != 0)
 			length++;
-		timeout = length * TIME_OUT_MULTIPLIER_64;
 	}
 
 	length = (length < MAX_TIMEOUT_LENGTH) ? length : MAX_TIMEOUT_LENGTH;
-- 
2.7.4

