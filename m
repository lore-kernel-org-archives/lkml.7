Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B36C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5016920873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510407;
	bh=vdcF/lCquSrJk97pSXOUvqINEGUodlLcM8fq00HfT6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JepkBCxQtEr/58If2dkmnKOseysu8GIL/fjnp/ttG7UU3LB6T0/xGMfR0T6SSDkra
	 XgozktOCtMJd7HFfAAzfgELPXDAh10yxfuWuZihQBLj7wFD15ZsyUD/O+vlusW1q0/
	 8NAX7Hl46+sXyiqN/4HXhcYg5AQu76CDHTakVIUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbfGSE0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732894AbfGSEII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:08:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1AD21849;
        Fri, 19 Jul 2019 04:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509287;
        bh=vdcF/lCquSrJk97pSXOUvqINEGUodlLcM8fq00HfT6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSOB2dGLKgvUMEQY+llWEcuVAXv4bN0Kk2Galo646OYpjF7mLv3dWdJED882IFcDy
         JF0tsAVvqaizFwg59GTXnzZ+//TVK9GPeuCMMVq5Zkj/JQNLp77c3u2Obabdc5Dja5
         6ae4Z8O32iTbeaAQ8Sj5QqwJGpfSW8P0dS6UAl9Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oak Zeng <Oak.Zeng@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 014/101] drm/amdkfd: Fix sdma queue map issue
Date:   Fri, 19 Jul 2019 00:06:05 -0400
Message-Id: <20190719040732.17285-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040732.17285-1-sashal@kernel.org>
References: <20190719040732.17285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oak Zeng <Oak.Zeng@amd.com>

[ Upstream commit 065e4bdfa1f3ab2884c110394d8b7e7ebe3b988c ]

Previous codes assumes there are two sdma engines.
This is not true e.g., Raven only has 1 SDMA engine.
Fix the issue by using sdma engine number info in
device_info.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f22e745df51..189212cb3547 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1268,12 +1268,17 @@ int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
 	return 0;
 }
 
-static int unmap_sdma_queues(struct device_queue_manager *dqm,
-				unsigned int sdma_engine)
+static int unmap_sdma_queues(struct device_queue_manager *dqm)
 {
-	return pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_SDMA,
-			KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false,
-			sdma_engine);
+	int i, retval = 0;
+
+	for (i = 0; i < dqm->dev->device_info->num_sdma_engines; i++) {
+		retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_SDMA,
+			KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false, i);
+		if (retval)
+			return retval;
+	}
+	return retval;
 }
 
 /* dqm->lock mutex has to be locked before calling this function */
@@ -1312,10 +1317,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	pr_debug("Before destroying queues, sdma queue count is : %u\n",
 		dqm->sdma_queue_count);
 
-	if (dqm->sdma_queue_count > 0) {
-		unmap_sdma_queues(dqm, 0);
-		unmap_sdma_queues(dqm, 1);
-	}
+	if (dqm->sdma_queue_count > 0)
+		unmap_sdma_queues(dqm);
 
 	retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPUTE,
 			filter, filter_param, false, 0);
-- 
2.20.1

