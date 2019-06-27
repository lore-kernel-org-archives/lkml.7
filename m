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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5005CC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1439A2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPQAMbat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfF0Rg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:36:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40101 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0Rg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:36:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so1336662pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=djbOmnF6Hniyal++I6RQ9+rf+95159OMOzougsG1kEY=;
        b=rPQAMbat8vxK3ysLgczuh8UG1lDSUqkf6S3guwwKyXw3uyChl7eIacCLSMLJL5lGwa
         Qp0WHTq/UvZ8GqQedDP97adk43ffxvlxnQBpqshqdZ21vECNMip7cFmC8ZcG2NPmDAmg
         hl8ONQyjIMBHctTi0rdlFCoFZgc9edj3XEgZZWel43s1g+bif9wnTfmxJIbbMhCh9mdT
         QciHEiVmABKli/ayIQgemcl3cb8kVPwG/2w/7nW8NNI3+CcH2Rxjr/x8odrmycaNuHRd
         0yGb7vW0AiobZKj8kp8IQJhCnLk5i3AAjnNWXmRvw/3YzqVS1fpB3zApXb5fe4LagfKE
         hmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=djbOmnF6Hniyal++I6RQ9+rf+95159OMOzougsG1kEY=;
        b=X+EigZq7WEykK2R9y/qYSaaHrJeNDhh8iCtuqG48PkJrwvEkaWMptJuOdhkTbc0oQJ
         Zum03aBP+S12o27pYvGbHwjZrUa+Dc/pEQ9DampCjyMFhHjI8+AZHO4H0k8nA824g2Pv
         qFUEVGuCyY9XxkKMGXTdRx8gV+s+Vn8uuPqJX4UpLCTe2N1hPqbRp+wDNdENFF3m9IsA
         LP9lIQtMeBJmd7SOlCFH7Dieae4ttZrxQl/EwVrC+X/rKoHK8XiNP1WxMk8YpE2Pw/82
         PL7udvTlWJ4qbLHtbyLR6/HUDVMkPBZT4KTkJd48bO/ShZ20kBZy3btAamWB6shs72J7
         9uNg==
X-Gm-Message-State: APjAAAUv8Wh3hVnIzoSoc+NCEd44OPI52kbIdNlCUZ66iRGpR64iLF/f
        eyx3iIzK7NUmO4yflvoWAAo=
X-Google-Smtp-Source: APXvYqx/Xwqi/ignbo/Z1tbh8g6pOK+tSYKSCeBLpAPYrBVYKSfFiuE/tqwABNUCP35R88JC+SQ2WQ==
X-Received: by 2002:a63:246:: with SMTP id 67mr4812836pgc.20.1561656986702;
        Thu, 27 Jun 2019 10:36:26 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t11sm3480237pgb.33.2019.06.27.10.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:36:26 -0700 (PDT)
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
Subject: [PATCH 16/87] gpu: drm: Remove call to memset after kzalloc
Date:   Fri, 28 Jun 2019 01:36:16 +0800
Message-Id: <20190627173617.2671-1-huangfq.daxian@gmail.com>
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
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.11.0

