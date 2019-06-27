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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5654BC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC822146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTN0oUfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfF0RgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:36:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41413 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfF0RgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:36:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so1571514pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=12AyxFRnGJTFUoiiKdiSfwhatqGTVYkB7zK+n7S66ho=;
        b=aTN0oUfnkii4ZuE43WoaWkdIADMd01xwCsj58JaW4GjQkbBQR5Z0I2Ckj6XVJoRmLG
         5vTVFPOpbErhLk/ja3TRlpLQ4gGeDpa0IZMkkLy7VkNeiEQjF70GIVA9ms782AxL9FPC
         6ySb+IjaZJFSPcYx6Z1mdUj8v4eudfV/oU4tXzgcE3Kal4FqKI/S8+WJevdLpx0+uozY
         lOKpao/BI1j8LpgwO+VQmDUNn2GQoLlUtNPb6OPMfFzz9UqRV+KrGfEtaTv2d6cqcqew
         J3XPZR4ibG0zE89f6E0WnkLk8EyeNqKd9JjvXunBPPFwDhMCRyikPYrOFT0qbojwQEmC
         S71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=12AyxFRnGJTFUoiiKdiSfwhatqGTVYkB7zK+n7S66ho=;
        b=j355lOI4PpwiSokRMr0/GLZHeND8e2XLk1+A80Z8nuBG+zkSdpK2sdUzojW14i6Opg
         m9cmZubND+doaG+8WnZyDe1Wq2qXko5rDoX8GP8ueSmL95NW5npfSvKVlOwviRVwHSwZ
         ogOdELXZOVoRR0T9oZGxZduZ2JL0pp7ptfYcXNfa/F0UgT7bviqGuo2I3CYbyQkjXXtz
         nPpFuFygA1deiYqiQ3PN84IHSYvjD69UKtFsgetVud/VexLgwReF8rMtk3524pePrvza
         YbtDmab7AQCnhrdc7Td/n8nBBWMrQY5u4DbAMxW2CQTgNAcC7hRGtByd8YnP3qdnL1Lq
         kHqA==
X-Gm-Message-State: APjAAAVLfLovWgN3cgstvQE10P02S4nsI67xHUCZ4Zijd/mN5EpO4I8U
        8GcJy6IqO9q1hwRcPr+/r1fau96M7tN8TQ==
X-Google-Smtp-Source: APXvYqyR5XvNIWESHWAGfLobAFZmd4VmL0Inll2lIYRoBHAuhJI7iLpzCgRUuoRXBi5wjN5alDeXyw==
X-Received: by 2002:a17:90a:8a17:: with SMTP id w23mr7195171pjn.139.1561656961986;
        Thu, 27 Jun 2019 10:36:01 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u20sm3245627pfm.145.2019.06.27.10.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:36:01 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Francis <David.Francis@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/87] gpu: amd: Remove call to memset after kzalloc
Date:   Fri, 28 Jun 2019 01:35:52 +0800
Message-Id: <20190627173553.2561-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc already zerored the memory.
so memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.11.0

