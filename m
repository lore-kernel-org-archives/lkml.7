Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2046C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A196B20828
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfCWNcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:32:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbfCWNco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 09:32:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15F67D0E93AD75C01560;
        Sat, 23 Mar 2019 21:32:42 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Sat, 23 Mar 2019
 21:32:32 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <rex.zhu@amd.com>, <evan.quan@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/powerplay: Remove useless set memory to zero use memset()
Date:   Sat, 23 Mar 2019 21:32:16 +0800
Message-ID: <20190323133216.16900-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

The memory return by kzalloc() has already be set to zero, so
remove useless memset(0).

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 8fafcbd..0fb6066 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1295,7 +1295,6 @@ static int vega20_set_default_od8_setttings(struct smu_context *smu)
 	if (!table_context->od8_settings)
 		return -ENOMEM;
 
-	memset(table_context->od8_settings, 0, sizeof(struct vega20_od8_settings));
 	od8_settings = (struct vega20_od8_settings *)table_context->od8_settings;
 
 	if (smu_feature_is_enabled(smu, FEATURE_DPM_SOCCLK_BIT)) {
-- 
2.7.0


