Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A6CC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE292070D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Zvh7ZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfHDUhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 16:37:41 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44492 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfHDUhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 16:37:40 -0400
Received: by mail-wr1-f47.google.com with SMTP id p17so82326651wrf.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWNx36oE65qDX237zR+lZS9AWYsuEyWJDxjNBY9blK0=;
        b=D7Zvh7ZPBd4iqC/Q5Wm6OwoJ/awGKA0wkPMXwPfGBh4FNPvqRoXckuqzpmqlK5f4Tm
         AlYyfd2TbJEvfKiQ8FaPU/QQti2R3A1MVghi0W9a05BC6BbvjUN4etE09sF2gvZMPLbW
         GYcN3NQ3nE5niIOPulwOCnSzO/8/BxwEB2G024DbnyfeqzbjzmHdQyPJDMgCTR7ovDpJ
         Uje9XQm7xfhdcIaMMdcJqvnJI7shyLbJoyvB6cWuUuw6SwAgyiOVfXa/iz48Nh/yRmUM
         qTTOZT7oC0CGfBV89kUK8dVAXbLbtFduJTuvgjFH6m63FrET47cIDFPAcJv7S6340f1D
         K6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWNx36oE65qDX237zR+lZS9AWYsuEyWJDxjNBY9blK0=;
        b=eYW3WlEku2C45eyLtujBmMDekxrHgEk5ebCu1kTa/oFUCy0miQSZ4FZ0LgyNSrGA2j
         sUBBzJICGfZrbJnI4y3hABi51fdbRbGY1v27hXc3OfYu73N+Oialy27dNVObIRfHnWip
         FcRWWrt9dk2l7gQXoT/7dZ4kvu2D7OjZyd6yweokyUlzoRu2jcituTC71I6vRfsOCEcy
         gvPyzRWiXoAYibVx/X+6v3Ox+rO2EMIX9gnIOdqZJJ6rUSyGiXFyp8cbimvZ7Uwpqmro
         vj4XMaEZFMewEN4IZUWSqrK6nfz+hRSLlYvxozUx6VVJXlniLPxSTGg13xgcPP0ZRh8f
         KIXg==
X-Gm-Message-State: APjAAAXtEl99aSvAGVSpBNxPMQ2oAtbglrp56qUfEmTDt7s4hl2D4fbf
        4huT9m/EJwaKdOuOG0yUc7U=
X-Google-Smtp-Source: APXvYqyTWB9R4tRJdC9jjgJogZyHbfXuKMw5tdVoyIAdZaN3t6ehoi+AxW2zKM6Cdriqqr4H15qsTA==
X-Received: by 2002:adf:e444:: with SMTP id t4mr55585602wrm.262.1564951056732;
        Sun, 04 Aug 2019 13:37:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c30sm160412887wrb.15.2019.08.04.13.37.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 13:37:35 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/powerplay: Zero initialize some variables
Date:   Sun,  4 Aug 2019 13:37:13 -0700
Message-Id: <20190804203713.13724-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns (only Navi warning shown but Arcturus warns as well):

drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1534:4: warning:
variable 'asic_default_power_limit' is used uninitialized whenever '?:'
condition is false [-Wsometimes-uninitialized]
                        smu_read_smc_arg(smu, &asic_default_power_limit);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:588:3: note:
expanded from macro 'smu_read_smc_arg'
        ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1550:30: note:
uninitialized use occurs here
                smu->default_power_limit = asic_default_power_limit;
                                           ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1534:4: note:
remove the '?:' if its condition is always true
                        smu_read_smc_arg(smu, &asic_default_power_limit);
                        ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:588:3: note:
expanded from macro 'smu_read_smc_arg'
        ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
         ^
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1517:35: note:
initialize the variable 'asic_default_power_limit' to silence this
warning
        uint32_t asic_default_power_limit;
                                         ^
                                          = 0
1 warning generated.

As the code is currently written, if read_smc_arg were ever NULL, arg
would fail to be initialized but the code would continue executing as
normal because the return value would just be zero.

There are a few different possible solutions to resolve this class
of warnings which have appeared in these drivers before:

1. Assume the function pointer will never be NULL and eliminate the
   wrapper macros.

2. Have the wrapper macros initialize arg when the function pointer is
   NULL.

3. Have the wrapper macros return an error code instead of 0 when the
   function pointer is NULL so that the callsites can properly bail out
   before arg can be used.

4. Initialize arg at the top of its function.

Number four is the path of least resistance right now as every other
change will be driver wide so do that here. I only make the comment
now as food for thought.

Fixes: b4af964e75c4 ("drm/amd/powerplay: make power limit retrieval as asic specific")
Link: https://github.com/ClangBuiltLinux/linux/issues/627
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 215f7173fca8..b92eded7374f 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1326,7 +1326,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 				     bool asic_default)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t asic_default_power_limit;
+	uint32_t asic_default_power_limit = 0;
 	int ret = 0;
 	int power_src;
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 106352a4fb82..d844bc8411aa 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1514,7 +1514,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
 				     bool asic_default)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t asic_default_power_limit;
+	uint32_t asic_default_power_limit = 0;
 	int ret = 0;
 	int power_src;
 
-- 
2.23.0.rc1

