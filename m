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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19121C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C4D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujl1mwOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfF0Rgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:36:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42211 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF0Rgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:36:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so1573654pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T7nDlxgAbHwIPfNOE7F83rtRIAmZKxOzk4AlOTCiOZQ=;
        b=Ujl1mwOMHwV1d6/BYCi5LNmxPksXeTW4Q6NpgeQx2HkTbe+Y4jMd3sKbj44KdAb6GF
         zpNnI/WveW/NRlDkjb6xgUApufF8v13jMNZMzq4X6FBV+hZ/l9sqByFNIexL/ran+ljR
         sev0uchO6Nb2OLtSEIhYDE6deil6NvRlicSBGfGaW/+RkrrHTVLmGUZ9sgBm6avFE2Tm
         fFocFI+qUuIo9o1ynqwV4K3ihId2QgM1zCnosV82v3xgEz6KWlOsE0JF1pzjNGtVo4NK
         EVOOtlYAcm2syoPxBoIwHfK8eihGWP65/X0P8wvNGayftOfZG7OZyuBGnBi8F/vgzcTS
         PeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T7nDlxgAbHwIPfNOE7F83rtRIAmZKxOzk4AlOTCiOZQ=;
        b=nRCbK4cJk2BLvqMWTGBrDmAL9yI1gO29sbWtifGMH5wyQCJOAi65uos/0jGc13ewbj
         8nEJBs7gWCbLbKaOcL4GPTwDbz/FSsXqiKZ2E4P6ENJIoxVPbzgPgZac7FzPf3uSzo7Y
         a5mJgC6viGGrbx9ixL5fus28Zka9pzPk9KvNHVqdVOF+RI+7fYc6M0dpVrMRP7uGQ1+j
         udVUBf71fzLyG0ViSOXrHVRsN4aUdi+GdwZXx1BLTAB6448rrRlmVQFCt2UccY/8XyEd
         N1Kr5vRNe/1ls2VCVZ0r7e5Mn5AZ6VF4xXpS7cl7KRg+DCzVTXaAUbjvnPtDmoApwbjd
         cZXw==
X-Gm-Message-State: APjAAAWd9l+0jJ+WnCoaRM8D08K3TDnIfDrr1k5cGx/ukEvp/XyKuU2d
        XDbDY0pC/S0C/3f0IehXFJupo3sdtTh2Yg==
X-Google-Smtp-Source: APXvYqwOGe41/aVWH3nFXJGYtJo7kL6W6anx9Wkp3js7xNTLCEJIB3I5BMcvsSY4tEAO+dNr5LvEww==
X-Received: by 2002:a65:4348:: with SMTP id k8mr4934574pgq.219.1561657007423;
        Thu, 27 Jun 2019 10:36:47 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 201sm7441791pfz.24.2019.06.27.10.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:36:47 -0700 (PDT)
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
Subject: [PATCH 18/87] gpu: drm: Remove call to memset after kzalloc in tonga_smumgr.c
Date:   Fri, 28 Jun 2019 01:36:38 +0800
Message-Id: <20190627173639.2779-1-huangfq.daxian@gmail.com>
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
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c | 2 --
 1 file changed, 2 deletions(-)

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

