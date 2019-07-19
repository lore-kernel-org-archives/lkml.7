Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ACCC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618E52186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508726;
	bh=mGJjLnQQ/4+ObCoHaIBDqw4yszwDJRupU01Ku3dNIhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EWKQ8gKvyT+v3qlujeQ+Tszx5q/k+tRDAAe/MMSfEuKOkaMjFVbnvF7aWHOLP2Btg
	 mtDh8ZRsEOMdIyS/ovg3kVUAAVbMz38Un2p1jP2HUbkvhQXur0uLMXpzDTT4UseOZf
	 m/X1HgPWnbnGnefJnp3QQTKFYGXrrgfxJgiuSuPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfGSD6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfGSD6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:58:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E282186A;
        Fri, 19 Jul 2019 03:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508722;
        bh=mGJjLnQQ/4+ObCoHaIBDqw4yszwDJRupU01Ku3dNIhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzxn2vBf2w0AUmLD4P8tZeIzZomSIkRr4afGK97axqzwzoDGWLv+K59Q/z63D84jG
         Y3c2X+0Qf6SM+haWy9A7zb4Co1AemQ3lL14lqLRGRvyLpdrdd0CPEbBFIJZh0q+c6y
         v2ka0A5bQEy71lNe0BRdado6u6dNZ9y6uXdD6WV4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 052/171] drm/amd/display: Always allocate initial connector state state
Date:   Thu, 18 Jul 2019 23:54:43 -0400
Message-Id: <20190719035643.14300-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit f04bee34d6e35df26cbb2d65e801adfd0d8fe20d ]

[Why]
Unlike our regular connectors, MST connectors don't start off with
an initial connector state. This causes a NULL pointer dereference to
occur when attaching the bpc property since it tries to modify the
connector state.

We need an initial connector state on the connector to avoid the crash.

[How]
Use our reset helper to allocate an initial state and reset the values
to their defaults. We were already doing this before, just not for
MST connectors.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0e482349a5cb..dc3ac66a4450 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4627,6 +4627,13 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 {
 	struct amdgpu_device *adev = dm->ddev->dev_private;
 
+	/*
+	 * Some of the properties below require access to state, like bpc.
+	 * Allocate some default initial connector state with our reset helper.
+	 */
+	if (aconnector->base.funcs->reset)
+		aconnector->base.funcs->reset(&aconnector->base);
+
 	aconnector->connector_id = link_index;
 	aconnector->dc_link = link;
 	aconnector->base.interlace_allowed = false;
@@ -4809,9 +4816,6 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 			&aconnector->base,
 			&amdgpu_dm_connector_helper_funcs);
 
-	if (aconnector->base.funcs->reset)
-		aconnector->base.funcs->reset(&aconnector->base);
-
 	amdgpu_dm_connector_init_helper(
 		dm,
 		aconnector,
-- 
2.20.1

