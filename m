Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1760C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A227420836
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfKYO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:57:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbfKYO5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:57:45 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DFB236CF9FA8163C04FF;
        Mon, 25 Nov 2019 22:57:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 25 Nov 2019
 22:57:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <yuehaibing@huawei.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/amd/display: remove set but not used variable 'msg_out'
Date:   Mon, 25 Nov 2019 22:54:45 +0800
Message-ID: <20191125145445.21648-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c: In function mod_hdcp_hdcp2_enable_encryption:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:633:77: warning: variable msg_out set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c: In function mod_hdcp_hdcp2_enable_dp_stream_encryption:
drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:710:77: warning: variable msg_out set but not used [-Wunused-but-set-variable]

It is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 2dd5fee..468f5e6 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -630,14 +630,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_encryption(struct mod_hdcp *hdcp)
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
-	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
 	struct mod_hdcp_display *display = get_first_added_display(hdcp);
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
-	msg_out = &hdcp_cmd->out_msg.hdcp2_prepare_process_authentication_message_v2;
 
 	hdcp2_message_init(hdcp, msg_in);
 
@@ -707,14 +705,12 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 	struct psp_context *psp = hdcp->config.psp.handle;
 	struct ta_hdcp_shared_memory *hdcp_cmd;
 	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_input_v2 *msg_in;
-	struct ta_hdcp_cmd_hdcp2_process_prepare_authentication_message_output_v2 *msg_out;
 	uint8_t i;
 
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
 
 	msg_in = &hdcp_cmd->in_msg.hdcp2_prepare_process_authentication_message_v2;
-	msg_out = &hdcp_cmd->out_msg.hdcp2_prepare_process_authentication_message_v2;
 
 	hdcp2_message_init(hdcp, msg_in);
 
-- 
2.7.4


