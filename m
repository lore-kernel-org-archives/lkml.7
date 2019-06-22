Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83175C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AAE2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 12:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFVM6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 08:58:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfFVM6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 08:58:45 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2EA12DE6D53BC5843FA8;
        Sat, 22 Jun 2019 20:58:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 22 Jun 2019 20:58:32 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <dan.carpenter@oracle.com>, <julia.lawall@lip6.fr>
CC:     <kernel-janitors@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
Date:   Sat, 22 Jun 2019 21:05:27 +0800
Message-ID: <20190622130527.182022-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622104318.GT28859@kadam>
References: <20190622104318.GT28859@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
  int ret = 0;
      ^
amdgpu_pmu_init() is called by amdgpu_device_init() in drivers/gpu/drm/amd/amdgpu/amdgpu_device.c,
which will use the return value. So it returns 'ret' for caller.
amdgpu_device_init()
	r = amdgpu_pmu_init(adev);

Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
 amdgpu_pmu_init().
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 0e6dba9..145e720 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 		/* init df */
 		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
-				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
-				       DF_V3_6_MAX_COUNTERS);
+							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
+							   DF_V3_6_MAX_COUNTERS);
 
 		/* other pmu types go here*/
 		break;
@@ -261,7 +261,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 
-- 
2.7.4

