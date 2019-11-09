Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52992C17443
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 09:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2917021882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 09:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfKIJgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 04:36:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfKIJgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 04:36:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5CC64BCAAA38E2D3A36;
        Sat,  9 Nov 2019 17:36:11 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 17:36:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Jun.Lei@amd.com>,
        <Anthony.Koo@amd.com>, <Zhan.Liu@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable 'bpc'
Date:   Sat, 9 Nov 2019 17:35:38 +0800
Message-ID: <20191109093538.23964-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function get_pbn_from_timing:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2364:11: warning:
 variable bpc set but not used [-Wunused-but-set-variable]

It is not used since commit e49f69363adf ("drm/amd/display: use
proper formula to calculate bandwidth from timing")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bdc8be3..53394e2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2653,13 +2653,11 @@ static int get_color_depth(enum dc_color_depth color_depth)
 
 static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
 {
-	uint32_t bpc;
 	uint64_t kbps;
 	struct fixed31_32 peak_kbps;
 	uint32_t numerator;
 	uint32_t denominator;
 
-	bpc = get_color_depth(pipe_ctx->stream_res.pix_clk_params.color_depth);
 	kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
 
 	/*
-- 
2.7.4


