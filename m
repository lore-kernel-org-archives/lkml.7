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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3F5C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337212086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZA3oppJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfF0RkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:40:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38023 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0RkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:40:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so1589142pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L6opFpOThEdquXvnOb5s3Hkh5g3O4IQcltwmgth5DiA=;
        b=CZA3oppJRGpRVbOhcz/P3IO6tE1VhnhxzuflMacV8+o/y/T9vbqL25HKnIukmZc1Y2
         Jl7ngPoG98WaMJmN8ZPliPHljkGZjbjznSIxw+c9bp29CamtqAL4eFbgybvTb6iGVlY4
         aupFWu1YDInGmCyB4iownB507+ppAwz7EnBD1Q3OX7cxhSJmKAQt6fFpF8NBxBt8ukCC
         3tN0dSVf6P0kbTXuA4pYOaBRGJN2D8Sc1a11ZLmM4uG+dZ8tH9RWQnCvtxuSsVNR6crM
         RyEzYCNdblj33qwjsHXfPxCWDGK9k7mByIscSOnmvylDNKq5fiCNMmvP5K9ksBYzTfYg
         6d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L6opFpOThEdquXvnOb5s3Hkh5g3O4IQcltwmgth5DiA=;
        b=DQ6hS23VLxY8dp7uQMa++eqmAi9fya52W+yWRgxR+D66wLmODrAr4vA7/N8tb2KuaQ
         99FfiL5cw6WSBBlsyIDztp4b4VIXzwp/CW0DdaR9b5tKX4NTjCLxmHowS5qYlWSf9Sfp
         E2wlmvMYTkWXVWm82OqGTnjuSptZBjyGeX+DyNzljjBfoCe3NOfOHDnGmv7nrjMYDM5/
         KUOSRrCBSPWXjMX/qlu2gniJcwU1NrusinXddBGaz9PfyRKxdpGeeb3dJ4nh3vWGDyKM
         rAbYndA73QxGgG/HFyouGkzhDw3RdSbXtlKJbELnBTXoSWtvli5QX8i7FtcMUitSOzES
         rLJw==
X-Gm-Message-State: APjAAAUQHUPIoeR06t8Svdl1UZSLdjRaIqJuIUtViEYeTsSF3Pkw53P4
        euP1cEkZpFCPQkQhPHrgMJ4=
X-Google-Smtp-Source: APXvYqxrzUs8DeUHPssnnwWLTuDDk6JJL7Yrqlo13ODapk3BAIjulA+x5zBhBOQ7DfHZad+5QbPjlw==
X-Received: by 2002:a63:5002:: with SMTP id e2mr2522564pgb.216.1561657220675;
        Thu, 27 Jun 2019 10:40:20 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h62sm5865256pgc.54.2019.06.27.10.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:40:20 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/87] gpu: drm: Remove call to memset after kzalloc in process_pptable_v1_0.c
Date:   Fri, 28 Jun 2019 01:40:10 +0800
Message-Id: <20190627174012.4062-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc has already zeroes the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.11.0

