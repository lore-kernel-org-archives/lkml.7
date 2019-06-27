Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB6C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588E02064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTEeyH2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfF0Rgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:36:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37235 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0Rgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:36:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id 25so1339436pgy.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o3wPN5sKnMpYXJv1e+SqpjxmPG2dm66g471O72ekDMY=;
        b=pTEeyH2V2kS2aM+XNbEwNHsg0CMGxrz437n791WxO8i8JLoFtlUEcQUpaVmuWenggS
         CTJrZpE5IiGjtsELZcTYV+OaNUdpiA8aVvV3oPsQ6JktDFX8W/+jYTvZHxwisEOm9RGQ
         9gM/CvxdgqNXhBLfqDE5gaBoLjIa64TcQEvZH9zCpBA/hRfB5QfQJz7tVGM2i6htrnZX
         7YDUBqzBCAmeMR4SGu5/15a3b3LcSyeDE3QOgW1oibPemPFaHbKQ42wsQ5lwKUuoHjQv
         3OUnFQqWdMDZPvPt0B1lokccpTg8sHjjZiq4obMbc7bzK3oBR2um13aBp04/RNBWigI5
         iz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o3wPN5sKnMpYXJv1e+SqpjxmPG2dm66g471O72ekDMY=;
        b=gBYHEdVUeLVJWKqNPD4GpNSWDm6TJxFp2GVKA+9tT9Bden6CeKC3Kc03XMBduPGV0s
         cUijjlLVnuXC7C2N7aVA0WzRrlZBnFrNf21rWkR7XHNCqkd0WphdDeCu3wOWv6WqAGn4
         YsDSqOQI5mxTDHUEWLHe/bBm7eWyTd2rr0XnEjvpeHMrh6H+ONY8SCwrRNbh/YSzmUT8
         JtJMYE41osLP50GOtWNn7ocHBf5bclW1LJ3ApPMrBBXMnwLIxca3l0UjGS0YPRvjEv4f
         mbv/iGBRYnJDm2sMGi31+etKnwejcS8Hio90wziE0xG/ysfP6/lA37ZcV8ewBPAdD2yY
         6EnA==
X-Gm-Message-State: APjAAAUaKS8h9mk2et3KkBE2D9PBi0oWvyZhHaGNrBAIPChpaHNxVTbN
        oOICa1sg1SSTPVVEeGZYzyo=
X-Google-Smtp-Source: APXvYqxbawH6+ykIPzr3VcukKDoxoDv/LeONuahmbBGyegEnuwuBTBg3TC01Ex5wn9d68WyWDtn2oQ==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr7521985pjc.31.1561656997066;
        Thu, 27 Jun 2019 10:36:37 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 11sm6726852pfw.33.2019.06.27.10.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:36:36 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/87] gpu: drm: Remove call to memset after kzalloc in iceland_smumgr.c
Date:   Fri, 28 Jun 2019 01:36:28 +0800
Message-Id: <20190627173629.2725-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc has already zeroes the memory.
So memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.11.0

