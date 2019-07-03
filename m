Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BE0218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8nLVm/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfGCNO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:14:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41793 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:14:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id m7so1231253pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hoaAwGJfWkow3ZkPB5hXlPhshemR7Qz/fo1wLRaHr10=;
        b=P8nLVm/m7ndoxa5S0p+aTxRxK2GHbLfQW9pavr53ovY0aREIu+194hY4MMguDNux0V
         kjz9JpvVtwozr6S6rB3vL0JTVCpkH29jBJILuHgp1RMWohGbNDaN3MqCXIW3zjX3WN1F
         mGXlLgxlx3jppbLDgE2DwZlfTfjW8dfL9M+y7D53yB6PtgnhRehKBi2Gce7Wv7KxCmTH
         O12p5rsQD1N4GaeucG7y1iJ1oBEF9ND3M7iF4Drkm0RC7I9dDIrc5VRhq7nGanf8QjtY
         WVLb5ohs8OyiWYzGJcC12zx0I8p3fMEwjtPQTX/K5AZlgcwc89JSHO8UiKrqqgBgvErH
         eUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hoaAwGJfWkow3ZkPB5hXlPhshemR7Qz/fo1wLRaHr10=;
        b=ZFnRAOS5XQ03Hs72dMzxeAhPIpApCJZ0eshFW5iLKq4m2cdQA5BH770HBD17cwFMRy
         ODv1JPX04BrB9qsVWykwIJBYfioyuq7dmIVqYQTsF+VgV8U2xhVE8oCCPlkpybvA3iqn
         ctTuk8NMSRDo/6/AG1SPIXKNBwikAzKqtzK/MSKJabd04r8bcfHA02MOwVCUECK2NwFg
         OCHfP9htmRG5/+zxZk3yx3kg00wQWGxZ/xpY03/tSK3vNRcWzU91aQnbKYqhDJubNTLt
         rlxG+QY//Vm3euHERa1do0w2wyieLvx2y+MWj1EJQmIxiLKrEzunFRVzz8VYCzmNerbm
         zyIQ==
X-Gm-Message-State: APjAAAWL4QDR3G88Gk+gkIid2cE3faF8nqJi0KWeLL6xRl8SMmrg6Aa/
        0LNp0SSaUXlDOlp2EGE64Ow=
X-Google-Smtp-Source: APXvYqyKezpe7dibSoNGWubcPSBlVc5pMvdyvKuYiBM1hypUs4YI+WQNx64XvR3lRfYRQmTdcCS53A==
X-Received: by 2002:a17:902:b284:: with SMTP id u4mr43837706plr.36.1562159665199;
        Wed, 03 Jul 2019 06:14:25 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t9sm2233190pji.18.2019.07.03.06.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:14:24 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 06/30] drm/amdgpu: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:14:14 +0800
Message-Id: <20190703131414.24947-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c           | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           | 5 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c        | 6 ++----
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 +---
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 02955e6e9dd9..48e38479d634 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3925,11 +3925,10 @@ static int gfx_v8_0_init_save_restore_list(struct amdgpu_device *adev)
 
 	int list_size;
 	unsigned int *register_list_format =
-		kmalloc(adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
+		kmemdup(adev->gfx.rlc.register_list_format,
+			adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
 	if (!register_list_format)
 		return -ENOMEM;
-	memcpy(register_list_format, adev->gfx.rlc.register_list_format,
-			adev->gfx.rlc.reg_list_format_size_bytes);
 
 	gfx_v8_0_parse_ind_reg_list(register_list_format,
 				RLC_FormatDirectRegListLength,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b610e3b30d95..09d901ef216d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2092,11 +2092,10 @@ static int gfx_v9_1_init_rlc_save_restore_list(struct amdgpu_device *adev)
 	u32 tmp = 0;
 
 	u32 *register_list_format =
-		kmalloc(adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
+		kmemdup(adev->gfx.rlc.register_list_format,
+			adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
 	if (!register_list_format)
 		return -ENOMEM;
-	memcpy(register_list_format, adev->gfx.rlc.register_list_format,
-		adev->gfx.rlc.reg_list_format_size_bytes);
 
 	/* setup unique_indirect_regs array and indirect_start_offsets array */
 	unique_indirect_reg_count = ARRAY_SIZE(unique_indirect_regs);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 18c775a950cc..6ced3b9cdce2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1263,14 +1263,12 @@ struct dc_state *dc_create_state(struct dc *dc)
 struct dc_state *dc_copy_state(struct dc_state *src_ctx)
 {
 	int i, j;
-	struct dc_state *new_ctx = kzalloc(sizeof(struct dc_state),
-					   GFP_KERNEL);
+	struct dc_state *new_ctx = kmemdup(src_ctx,
+			sizeof(struct dc_state), GFP_KERNEL);
 
 	if (!new_ctx)
 		return NULL;
 
-	memcpy(new_ctx, src_ctx, sizeof(struct dc_state));
-
 	for (i = 0; i < MAX_PIPES; i++) {
 			struct pipe_ctx *cur_pipe = &new_ctx->res_ctx.pipe_ctx[i];
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 96e97d25d639..d4b563a2e220 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -167,12 +167,10 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 {
 	struct dc_stream_state *new_stream;
 
-	new_stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
+	new_stream = kzalloc(stream, sizeof(struct dc_stream_state), GFP_KERNEL);
 	if (!new_stream)
 		return NULL;
 
-	memcpy(new_stream, stream, sizeof(struct dc_stream_state));
-
 	if (new_stream->sink)
 		dc_sink_retain(new_stream->sink);
 
-- 
2.11.0

