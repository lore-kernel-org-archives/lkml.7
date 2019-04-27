Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5C420873
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329187;
	bh=9AZLEdLkfGIReOI+caS4tlJWi91R1zceF+UVuzV08tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wLaqLqMnbwFBaQj6govxakvL7Pdp1epJSf5SKyyfLewFu2w4+KWItKu3EPgZkmQ1m
	 sfpoohRig9CaqsahotVb6thIkAGjosN/s2rZQt4G1Tqawhy55VEFzsS67Q3k7gsl4b
	 jvakYclfWLuxRnbUPmuSqKNaTxxjoABQhkzrPZQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfD0Bjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbfD0Bjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB04D208CB;
        Sat, 27 Apr 2019 01:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329178;
        bh=9AZLEdLkfGIReOI+caS4tlJWi91R1zceF+UVuzV08tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKlPTuuwM9qggAeNRAixRqWrKHE6dLP+1y9wKx6D/NkEFp1gnZ7c+O1XFqwSNDaSO
         KyT7McJZrMf8WRf7SBKZ+bXIhq4Ji2SDn53d06MBSHJ9I21shSovSmZPyR/azpQ8/p
         KGYtBtTT8e6Hh1MRw69Ne34fnI6ITZsQWuXC7B3w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     shaoyunl <shaoyun.liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 39/79] drm/amdgpu: Adjust IB test timeout for XGMI configuration
Date:   Fri, 26 Apr 2019 21:37:58 -0400
Message-Id: <20190427013838.6596-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shaoyunl <shaoyun.liu@amd.com>

[ Upstream commit d4162c61e253177936fcfe6c29f7b224d9a1efb8 ]

On XGMI configuration the ib test may take longer to finish

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index c48207b377bc..b82c5fca217b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -35,6 +35,7 @@
 #include "amdgpu_trace.h"
 
 #define AMDGPU_IB_TEST_TIMEOUT	msecs_to_jiffies(1000)
+#define AMDGPU_IB_TEST_GFX_XGMI_TIMEOUT	msecs_to_jiffies(2000)
 
 /*
  * IB
@@ -344,6 +345,8 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 		 * cost waiting for it coming back under RUNTIME only
 		*/
 		tmo_gfx = 8 * AMDGPU_IB_TEST_TIMEOUT;
+	} else if (adev->gmc.xgmi.hive_id) {
+		tmo_gfx = AMDGPU_IB_TEST_GFX_XGMI_TIMEOUT;
 	}
 
 	for (i = 0; i < adev->num_rings; ++i) {
-- 
2.19.1

