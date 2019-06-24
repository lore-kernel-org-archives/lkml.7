Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC9820449
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfFXLQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:16:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19064 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbfFXLQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:16:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 722C6F7675D79B1559C7;
        Mon, 24 Jun 2019 19:16:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:16:22 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <dan.carpenter@oracle.com>, <julia.lawall@lip6.fr>
CC:     <kernel-janitors@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <jonathan.kim@amd.com>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next v4] drm/amdgpu: return 'ret' immediately if failed in amdgpu_pmu_init
Date:   Mon, 24 Jun 2019 19:23:18 +0800
Message-ID: <20190624112318.149299-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624094850.GQ18776@kadam>
References: <20190624094850.GQ18776@kadam>
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
which will use the return value. So it should return 'ret' immediately if init_pmu_by_type() failed.
amdgpu_device_init()
	r = amdgpu_pmu_init(adev);

Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
 amdgpu_pmu_init().
 v2->v3: change the subject for this patch; return 'ret' immediately if failed to call init_pmu_by_type(). 
 v3->v4: delete the indenting for init_pmu_by_type() arguments. The original indenting is correct.

 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 0e6dba9f60f0..c98cf77a37f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -254,6 +254,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
 				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
 				       DF_V3_6_MAX_COUNTERS);
+		if (ret)
+			return ret;
 
 		/* other pmu types go here*/
 		break;
-- 
2.20.1

