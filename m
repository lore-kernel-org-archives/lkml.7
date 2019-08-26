Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A54C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA1B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfHZI6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:58:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729569AbfHZI6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:58:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 28C44AA3DF56951A2E70;
        Mon, 26 Aug 2019 16:58:22 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 26 Aug 2019
 16:58:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Jun.Lei@amd.com>, <Dmytro.Laktyushkin@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <joshua.aberback@amd.com>,
        <Wenjing.Liu@amd.com>, <charlene.liu@amd.com>,
        <martin.leung@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu/display: fix build error without CONFIG_DRM_AMD_DC_DSC_SUPPORT
Date:   Mon, 26 Aug 2019 16:57:07 +0800
Message-ID: <20190826085707.12504-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_AMD_DC_DSC_SUPPORT is not set, build fails:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: In function dcn20_hw_sequencer_construct:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:2099:28:
 error: dcn20_dsc_pg_control undeclared (first use in this function); did you mean dcn20_dpp_pg_control?
  dc->hwss.dsc_pg_control = dcn20_dsc_pg_control;
                            ^~~~~~~~~~~~~~~~~~~~
                            dcn20_dpp_pg_control

Use CONFIG_DRM_AMD_DC_DSC_SUPPORT to guard this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8a31820b1218 ("drm/amd/display: Make init_hw and init_pipes generic for seamless boot")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e146d1d..54d67f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2092,7 +2092,11 @@ void dcn20_hw_sequencer_construct(struct dc *dc)
 	dc->hwss.enable_power_gating_plane = dcn20_enable_power_gating_plane;
 	dc->hwss.dpp_pg_control = dcn20_dpp_pg_control;
 	dc->hwss.hubp_pg_control = dcn20_hubp_pg_control;
+#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 	dc->hwss.dsc_pg_control = dcn20_dsc_pg_control;
+#else
+	dc->hwss.dsc_pg_control = NULL;
+#endif
 	dc->hwss.disable_vga = dcn20_disable_vga;
 
 	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-- 
2.7.4


