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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47648C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131012187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj4HgwcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfGCQ12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:27:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35310 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:27:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so345391pfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UaCfWwscnCZ9X19G2iox4r2DvMJhQMjdmw+itwepCYk=;
        b=Kj4HgwcHyaagPTCY8GhUqTvrvQSy4Yd+XUxgRU9gQUNdmbYhG4XDtk8WUcRjmpRseD
         cHr9wS1oPEnjO/48xT1JxFaCEEsq0rz0E+rlHYKwklKLfz0kRbRKX3Fs8WJ5v5BoDvkK
         QOTQYF0wBSTLgBB2rIiCwmSpe4mdR5Jx83Ceb9cfnbxVjUMO1k6YIr587NYmWFnfnkvm
         7Bnzi4Q69NLxvijF3X2ZFEtuLDkVPpHd4QbKF3/aZre9Q+vjFlPloeoo2TlcwX1eQHWp
         5+maYUdfZuYjWCV7jkr+s4o+XsFf7BY0s9fP3RjOd78o6LuLHPiS5omMtK+jjVuvgr2M
         w0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UaCfWwscnCZ9X19G2iox4r2DvMJhQMjdmw+itwepCYk=;
        b=AX30/B/OO/VfY6uzC0qLst9T5Uib5FJ45kluuwxtCraotvouDsu7IW/AXOnBaDxIDi
         Vemuhn/DyQxESlMujytSHfIO1tZscz437S0nNAdKU/A2RcbZvkABDBCBLL/QbKxX5VX6
         cdD4PBhe6DVTsi5DskFGPlbcUDwzCmRS1JmNoWBLfZBthVbX8PfF3dIOVByd0W+4Bpkl
         uwK3+GO2kjB1yUlff+Ir1x1ALIo74Z2rDS7glqjUkZaFrTsthH+uHMabudVEWjqYZxwp
         PJuhnPpCzU29QHK50SLUWVrNILv9OnV2Vl8qPhdgRP8A7Dh4mYWE491MYXQT93AYYIHu
         U7xQ==
X-Gm-Message-State: APjAAAWrNRmxI5KjWI5gRnNlhnnXSYILik01WFicfMJ0DamM4H9ZPsha
        nAtQs4xolyxV/DUiYIJ3nWg=
X-Google-Smtp-Source: APXvYqzkQ6bcPEfIil3HUDVMahzt6JJS97amraTDfjGTSEJJKqnMP0+6Q5Q+ENguuAWIV/uuzywivQ==
X-Received: by 2002:a65:6656:: with SMTP id z22mr36489848pgv.197.1562171247573;
        Wed, 03 Jul 2019 09:27:27 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id m31sm2914550pjb.6.2019.07.03.09.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:27:27 -0700 (PDT)
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
Subject: [PATCH v2 07/35] drm/amdgpu: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:27:18 +0800
Message-Id: <20190703162718.32184-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

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

