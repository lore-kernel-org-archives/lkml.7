Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87767C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A1A21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQdrPjrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfGBH5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:57:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32785 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:57:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so7293001pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2P2NThcF6O4K/AZYzle98UIzcxPTK10hu7ywwJY43BE=;
        b=FQdrPjrBr7QIb6EHDJUqfKKWDcnMR+wItobvZJyAmVFzkkib4tqftuCdMYWVhSyDWf
         1HFE2CTpcQw3W6F5ZMi2eZQUQcSjcfKM/4KexkHmkR8ahFpz77K0pjtHQPCm+cwxAnJK
         syL8CsmFM7st0Lz6uoRv5NVMLdrrEOAzzFNrk76KAUhz+DyJprrn6YmyaC1LXo/0h2lP
         YjL9kzDIZeL4MsVgSImari+Cdjn7yvqfbQwe0csX43d4k9irQegZEKiY53EfKOm9g9tC
         Lwy/UL9nNA7WjsDrEv8iKzPqh8v/LCG5vjZN71E3wdsjVhIZzZ99PriztaR7C9m/YvuZ
         nQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2P2NThcF6O4K/AZYzle98UIzcxPTK10hu7ywwJY43BE=;
        b=cAPZVHAT4CEMKOT9wCLy1xTys4RxRj1QTalXJ419nkx5nVIBlta1hJK8NBWsXZCOys
         o3d3LhKGhBsYZLIlHl9lM4tzeGKt0xRvLmKL4jUjMPUXWD+IZEsT43BE2ytVCq3+P0zk
         Sh3CXFBa4rjT48P0KCibLTpYJ1dHxSEeW3rR1+ORSbk4/eEAnWlk6XOTTOdP/+vmJSA1
         wge5MpU9kwb21SyvgwvRwxzxM0+D9J1/p8+hTE24qzY4llf9BUvz+ErGHNua7u3b6Qxq
         lSdmaQa6dTv9qfHwbqVkc4lG62Dov6Sk+mYdyIjhAoSqeHqFJyoiKoFC5resHzG2GBqi
         HpdQ==
X-Gm-Message-State: APjAAAULa5O6VcQYBBTl1j0o3d5gwnJxoQv/OAhJHWKHx+XDyBXCLGFT
        L2+zBwn8lr15m+i4NYA/fCUtYOZaXuE=
X-Google-Smtp-Source: APXvYqw4vdXD2XJH+AFJLVlY68qirIVkxZFq/WI+FiRosj4r1P9IGE/QyhENAwVwHorFHNVa2PSxxA==
X-Received: by 2002:a63:60c8:: with SMTP id u191mr27435796pgb.401.1562054261636;
        Tue, 02 Jul 2019 00:57:41 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id n19sm13488880pfa.11.2019.07.02.00.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:57:41 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 07/27] drm/amdgpu: remove memset after zalloc
Date:   Tue,  2 Jul 2019 15:57:36 +0800
Message-Id: <20190702075736.23835-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zalloc has already zeroed the memory.
so memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Changes in title: gpu: drm -> drm/amdgpu

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c       | 2 --
 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c            | 2 --
 drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c       | 2 --
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c         | 2 --
 5 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index fd22b4474dbf..4e6da61d1a93 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -279,8 +279,6 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 		return DAL_INVALID_IRQ_HANDLER_IDX;
 	}
 
-	memset(handler_data, 0, sizeof(*handler_data));
-
 	init_handler_common_data(handler_data, ih, handler_args, &adev->dm);
 
 	irq_source = int_params->irq_source;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
index ae64ff7153d6..eb7757443bdd 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
@@ -1065,8 +1065,6 @@ static int pp_tables_v1_0_initialize(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE((NULL != hwmgr->pptable),
 			    "Failed to allocate hwmgr->pptable!", return -ENOMEM);
 
-	memset(hwmgr->pptable, 0x00, sizeof(struct phm_ppt_v1_information));
-
 	powerplay_table = get_powerplay_table(hwmgr);
 
 	PP_ASSERT_WITH_CODE((NULL != powerplay_table),
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 669bd0c2a16c..d55e264c5df5 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2702,8 +2702,6 @@ static int ci_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS2));
 	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
 
-	memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
-
 	result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
 
 	if (0 == result)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 375ccf6ff5f2..c123b4d9c621 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -2631,8 +2631,6 @@ static int iceland_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS2));
 	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
 
-	memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
-
 	result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
 
 	if (0 == result)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index 3ed6c5f1e5cf..60462c7211e3 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -3114,8 +3114,6 @@ static int tonga_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP,
 			cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
 
-	memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
-
 	result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
 
 	if (!result)
-- 
2.11.0

