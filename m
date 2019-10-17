Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15EFFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F0220854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407621AbfJQGNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:13:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404664AbfJQGNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:13:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E60147DF292684E267BE;
        Thu, 17 Oct 2019 14:13:18 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 14:13:11 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <harry.wentland@amd.com>, <alexander.deucher@amd.com>,
        <sunpeng.li@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] drm/amdgpu/display: fix compile error
Date:   Thu, 17 Oct 2019 14:19:32 +0800
Message-ID: <1571293172-116998-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenwandun <chenwandun@huawei.com>

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1913:48: error: struct dc_crtc_timing_flags has no member named DSC
   if (res_ctx->pipe_ctx[i].stream->timing.flags.DSC)
						^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1914:73: error: struct dc_crtc_timing has no member named dsc_cfg
   pipes[pipe_cnt].dout.output_bpp = res_ctx->pipe_ctx[i].stream->timing.dsc_cfg.bits_per_pixel / 16.0;
									^
Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 914e378..4f03318 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1910,8 +1910,10 @@ int dcn20_populate_dml_pipes_from_context(
 			pipes[pipe_cnt].dout.output_bpp = output_bpc * 3;
 		}
 
+#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 		if (res_ctx->pipe_ctx[i].stream->timing.flags.DSC)
 			pipes[pipe_cnt].dout.output_bpp = res_ctx->pipe_ctx[i].stream->timing.dsc_cfg.bits_per_pixel / 16.0;
+#endif
 
 		/* todo: default max for now, until there is logic reflecting this in dc*/
 		pipes[pipe_cnt].dout.output_bpc = 12;
-- 
2.7.4

