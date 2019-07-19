Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468E4C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD672173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510372;
	bh=DYiF5DgPJpZupVqJuk1jG1zwZm28TFhMhfDz8SNFOYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ebOBr7AJaSL2RedkK3T5rTcOoO6vNaf4fWhHnZKZnQr+fZOs1QmED84XPKpffVEJs
	 OzNeeDLcc2ddK1zql2BDa5i+oCPVMEjWIF2AkYNDH/js7IcPRR/JnXTxwhLEn3k0Ik
	 suh4n+dcCTP9rgWrD+haTQ93E8eBDJP02egqndpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfGSE0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733104AbfGSEI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:08:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C6021872;
        Fri, 19 Jul 2019 04:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509308;
        bh=DYiF5DgPJpZupVqJuk1jG1zwZm28TFhMhfDz8SNFOYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AL/v9sg0vmmvQB5ByrqK3FiHDwbvqFpICTQWrFWdpi9PyjjNftDbZ3K87alJvkW/l
         3c0o0WeubH3YQ8lgNJpx2l/zoS2/yB6qqrQESmemKDD5XGaLb2hyazIAsRx85TBn7D
         MY4ynxwTvr1FuU7+TEE5NpW8EeGd5GmUqGMoBDWk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 026/101] drm/amd/display: Always allocate initial connector state state
Date:   Fri, 19 Jul 2019 00:06:17 -0400
Message-Id: <20190719040732.17285-26-sashal@kernel.org>
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
index dac7978f5ee1..221de241535a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3644,6 +3644,13 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
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
@@ -3811,9 +3818,6 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
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

