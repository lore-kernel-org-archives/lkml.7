Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB0EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4B3222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLSL6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:58:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfLSL6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:58:19 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58D1A847682FDD26398B;
        Thu, 19 Dec 2019 19:58:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 19:58:10 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH next] drm/amd/display: make non-global functions static
Date:   Thu, 19 Dec 2019 19:55:00 +0800
Message-ID: <20191219115500.2047-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:964:5:
	warning: symbol 'shift_border_left_to_dst' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:975:6:
	warning: symbol 'restore_border_left_from_dst' was not declared. Should it be static?

Fixes: 89d07b662f5e (drm/amd/display: fix 270 degree rotation for mixed-SLS mode)
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 64a0e08f..5843c16 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -961,7 +961,7 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
  * We also need to make sure pipe_ctx->plane_res.scl_data.h_active uses the
  * original h_border_left value in its calculation.
  */
-int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
+static int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
 {
 	int store_h_border_left = pipe_ctx->stream->timing.h_border_left;
 
@@ -972,7 +972,7 @@ int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
 	return store_h_border_left;
 }
 
-void restore_border_left_from_dst(struct pipe_ctx *pipe_ctx,
+static void restore_border_left_from_dst(struct pipe_ctx *pipe_ctx,
                                   int store_h_border_left)
 {
 	pipe_ctx->stream->dst.x -= store_h_border_left;
-- 
2.7.4

