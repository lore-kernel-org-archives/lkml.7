Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD6C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1BC2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013491;
	bh=yS2KDEXb1mtqkGjsdBPg69ZkH+a+Qekok3ngQXZ45Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ljngQaeVDsFzLJhuJe8asfTt6NuI1x5l3x2E6z8EXrS535hwKyYWIPAoEl2LaQ4wF
	 4E5Ezv5oVE2209zQjyfmSKyFG7mnRDynHkhjKQe797OHIRGEipe8sKpBDmnWovxhad
	 yUzY7XQfpjcUNgdPkZmIrummcY3woDmLOAB941hE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfLJVJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfLJVJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D915824699;
        Tue, 10 Dec 2019 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012164;
        bh=yS2KDEXb1mtqkGjsdBPg69ZkH+a+Qekok3ngQXZ45Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBOMGUX+vuZ2Ifb1HTSH9xfKyc6fTsWNsWvTyOrj4GnZ3RIZX+4Hvspq7kgmVsPVR
         CKjV2dudYXM4AXWEJDJ4zp5GgrK450tnk315R3MTXv7yGiBnFKjaXfZ1ZTRdSWaTIo
         Rr/QfXkWxNaaHS3H51cD6WkWPH21B9eVY4dv4CkE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 125/350] drm/amd/display: enable hostvm based on roimmu active for dcn2.1
Date:   Tue, 10 Dec 2019 16:03:50 -0500
Message-Id: <20191210210735.9077-86-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[ Upstream commit 48d92e8eda3d9b61978377e7539bfc5958e850cf ]

Enabling hostvm when ROIMMU is not active seems to break GPUVM.
This fixes the issue by not enabling hostvm if ROIMMU is not
activated.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   | 40 ++++++++++++-------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index d1266741763b9..f5f6b4a0f0aa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -22,6 +22,7 @@
  * Authors: AMD
  *
  */
+#include <linux/delay.h>
 #include "dm_services.h"
 #include "dcn20/dcn20_hubbub.h"
 #include "dcn21_hubbub.h"
@@ -71,30 +72,39 @@ static uint32_t convert_and_clamp(
 void dcn21_dchvm_init(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t riommu_active;
+	int i;
 
 	//Init DCHVM block
 	REG_UPDATE(DCHVM_CTRL0, HOSTVM_INIT_REQ, 1);
 
 	//Poll until RIOMMU_ACTIVE = 1
-	//TODO: Figure out interval us and retry count
-	REG_WAIT(DCHVM_RIOMMU_STAT0, RIOMMU_ACTIVE, 1, 5, 100);
+	for (i = 0; i < 100; i++) {
+		REG_GET(DCHVM_RIOMMU_STAT0, RIOMMU_ACTIVE, &riommu_active);
 
-	//Reflect the power status of DCHUBBUB
-	REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_POWERSTATUS, 1);
+		if (riommu_active)
+			break;
+		else
+			udelay(5);
+	}
+
+	if (riommu_active) {
+		//Reflect the power status of DCHUBBUB
+		REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_POWERSTATUS, 1);
 
-	//Start rIOMMU prefetching
-	REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_PREFETCH_REQ, 1);
+		//Start rIOMMU prefetching
+		REG_UPDATE(DCHVM_RIOMMU_CTRL0, HOSTVM_PREFETCH_REQ, 1);
 
-	// Enable dynamic clock gating
-	REG_UPDATE_4(DCHVM_CLK_CTRL,
-					HVM_DISPCLK_R_GATE_DIS, 0,
-					HVM_DISPCLK_G_GATE_DIS, 0,
-					HVM_DCFCLK_R_GATE_DIS, 0,
-					HVM_DCFCLK_G_GATE_DIS, 0);
+		// Enable dynamic clock gating
+		REG_UPDATE_4(DCHVM_CLK_CTRL,
+						HVM_DISPCLK_R_GATE_DIS, 0,
+						HVM_DISPCLK_G_GATE_DIS, 0,
+						HVM_DCFCLK_R_GATE_DIS, 0,
+						HVM_DCFCLK_G_GATE_DIS, 0);
 
-	//Poll until HOSTVM_PREFETCH_DONE = 1
-	//TODO: Figure out interval us and retry count
-	REG_WAIT(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, 1, 5, 100);
+		//Poll until HOSTVM_PREFETCH_DONE = 1
+		REG_WAIT(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, 1, 5, 100);
+	}
 }
 
 static int hubbub21_init_dchub(struct hubbub *hubbub,
-- 
2.20.1

