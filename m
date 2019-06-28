Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E565C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6694C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTW5kN8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfF1CrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:47:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34269 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfF1CrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:47:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so2201919pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7MExjTtrRcsO+tmue4/mTC8PhV6KYZa84/58hfWGsD0=;
        b=RTW5kN8/5LvlT62zo2k0u5kn1+pky/h5UnfZ1envBjsg7J5oNT7MHkJOb4Fxu1sQCZ
         grLeOFuZVTb7ouqzw9ka2s1DC2j3LRQGYpivscBWrEiSG/5fKYqTipRPsUYn0h8JAMc2
         OjyIFq7sIt52w815xuPYD2DtCSas0gGSRll7y+m4KMyAhCLRncZRSb9clSTxO91q6fMs
         58hPcEN9V0CmyU9Qs+gywJL4gKktBrZJYELsHnNNn70bYlKrkXwcfq9Yt+KVpxnKD60U
         R+UAY4D7Kzr7xv+m5rFiFfojFwPElNyZCZfcpzTycCEtycwXEDyIlRMeTm6LPnm1SOTh
         NtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7MExjTtrRcsO+tmue4/mTC8PhV6KYZa84/58hfWGsD0=;
        b=Iz+kY6/aUcgFSfk8O1Y4v6+40OgWd2Md4QMnw6mZ1mrEPD5YfLRLCzM2IKwOk6I8u5
         R6eplVwhhHi92idnDdLK1sf7Y2PkL9fEmTFGwmrbNz74cW2neV7CU0is3AGC1wQc+hVV
         iIUm7ZjoOyGxm9ZqEhCPJMA0ax5IMBACLWjBMbpfr2jSa+Xo3UrHmsUJxq591VGu0kSF
         hyUcxq5Bq/KAMXrVY2uGoe6H6gOtWGabgsHjCoX5cprgl5A5+pUQ/k/Bs9D7+KzqO6lS
         ZDm4YVlD8gTKDeJqFvdkzgPNm/OSq1BIUpHx0foL0fyA3/9fI3AAm2UJkrjB9SyN87ho
         CfhQ==
X-Gm-Message-State: APjAAAV6qfkCQC8CQyxSyovC0+j1Pqoqnk+5gkCzgfYShmhXcI/Dd8nN
        muwo2IL7LQ5p3P/hPvoDsFY=
X-Google-Smtp-Source: APXvYqxV3oVeTVKTqgXe4sCK9eHLDtp8Lgah7TubJIXCNE/5mMs9PA+Qfl8LbtLFbRsudXcdAlyAkQ==
X-Received: by 2002:a63:d410:: with SMTP id a16mr6031309pgh.122.1561690028280;
        Thu, 27 Jun 2019 19:47:08 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q5sm396213pgj.49.2019.06.27.19.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:47:07 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Huang Rui <ray.huang@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/27] gpu: drm: remove memset after zalloc
Date:   Fri, 28 Jun 2019 10:46:54 +0800
Message-Id: <20190628024700.15141-1-huangfq.daxian@gmail.com>
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

