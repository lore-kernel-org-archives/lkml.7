Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B93C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC516206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563511210;
	bh=A18q6bvzumReKnIF7R7v4bUP7cQ6XlnNJDmpFzffm7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cNMDUR+FQyUUry2lXniCS+ltC7wZHlEV8/NJjw1nuUocS+m49kwWw9kCsGmn+GYtR
	 VlgaiUtC/7CzVr0LbEypaCCApfT9AGQ8cfFJ4lHM5ER7oEVdCzGp3DACkLtuhOTGAg
	 k9dxAO1wM/JZr6a2QH4B9YUSHgkqSDL7uARWswV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfGSD6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfGSD6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:58:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C9421851;
        Fri, 19 Jul 2019 03:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508697;
        bh=A18q6bvzumReKnIF7R7v4bUP7cQ6XlnNJDmpFzffm7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glryT/8UB0ETnx3d/nUZeKOqaHrcvf8fZ9QZcZLl1wKHs78dlY25ucYFHCWXdzjon
         3S03CORL8uEBCDi2FCKQ5sR/Y2/+c16f4cgyTbeMNqCf9AMSPMEkKNqolGlReYhW43
         fDaY0xqw+Nxh50y1OteZdhOi477N81Ww4db23L4A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eryk Brol <eryk.brol@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 037/171] drm/amd/display: Increase Backlight Gain Step Size
Date:   Thu, 18 Jul 2019 23:54:28 -0400
Message-Id: <20190719035643.14300-37-sashal@kernel.org>
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

From: Eryk Brol <eryk.brol@amd.com>

[ Upstream commit e25228b02e4833e5b0fdd262801a2ae6cc72b39d ]

[Why]
Some backlight tests fail due to backlight settling
taking too long. This happens because the step
size used to change backlight levels is too small.

[How]
1. Change the size of the backlight gain step size
2. Change how DMCU firmware gets the step size value
   so that it is passed in by driver during DMCU initn

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 818536eea00a..c6a607cd0e4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -388,6 +388,9 @@ static bool dcn10_dmcu_init(struct dmcu *dmcu)
 		/* Set initialized ramping boundary value */
 		REG_WRITE(MASTER_COMM_DATA_REG1, 0xFFFF);
 
+		/* Set backlight ramping stepsize */
+		REG_WRITE(MASTER_COMM_DATA_REG2, abm_gain_stepsize);
+
 		/* Set command to initialize microcontroller */
 		REG_UPDATE(MASTER_COMM_CMD_REG, MASTER_COMM_CMD_REG_BYTE0,
 			MCP_INIT_DMCU);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
index 60ce56f60ae3..5bd0df55aa5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
@@ -263,4 +263,6 @@ struct dmcu *dcn10_dmcu_create(
 
 void dce_dmcu_destroy(struct dmcu **dmcu);
 
+static const uint32_t abm_gain_stepsize = 0x0060;
+
 #endif /* _DCE_ABM_H_ */
-- 
2.20.1

