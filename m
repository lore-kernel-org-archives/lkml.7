Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0490EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFAA20811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCRS2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:28:08 -0400
Received: from gateway36.websitewelcome.com ([192.185.195.25]:43577 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbfCRS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:28:08 -0400
X-Greylist: delayed 1359 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2019 14:28:08 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 01918401049CB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:21:39 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 5wdahbxQSYTGM5wdahpA6u; Mon, 18 Mar 2019 13:05:26 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.39] (port=43380 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h5wda-001Ykc-1M; Mon, 18 Mar 2019 13:05:26 -0500
Date:   Mon, 18 Mar 2019 13:05:25 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdkfd: Fix unchecked return value
Message-ID: <20190318180525.GA13768@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.39
X-Source-L: No
X-Exim-ID: 1h5wda-001Ykc-1M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.39]:43380
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign return value of function amdgpu_bo_sync_wait() to variable ret
for its further check.

Addresses-Coverity-ID: 1443914 ("Logically dead code")
Fixes: c60cd590cb7d ("drm/amdgpu: Replace ttm_bo_wait with amdgpu_bo_sync_wait")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1921dec3df7a..fb621abcb006 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -906,7 +906,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		pr_err("validate_pt_pd_bos() failed\n");
 		goto validate_pd_fail;
 	}
-	amdgpu_bo_sync_wait(vm->root.base.bo, AMDGPU_FENCE_OWNER_KFD, false);
+	ret = amdgpu_bo_sync_wait(vm->root.base.bo, AMDGPU_FENCE_OWNER_KFD,
+				  false);
 	if (ret)
 		goto wait_pd_fail;
 	amdgpu_bo_fence(vm->root.base.bo,
-- 
2.21.0

